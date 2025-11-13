Return-Path: <linux-kernel+bounces-898751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED4C55EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6034C54B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5C320A08;
	Thu, 13 Nov 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fYy3y0nd"
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66509DDD2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015332; cv=none; b=NuKbjqDC2qlvGkigTQkwpzDqr9pVjdL05P5HTHrYgtf0bG9enhRMfFPxC4cjXXEJsYux5hdf72fP2mEgg+ywT+N+81wx+nF1R8Ru0capc9c2RHo9ExLobAJ7ubO9FYzyDCba91iTf+NgIlhp5yXtSolKo5d3nfrC24NoDyRJv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015332; c=relaxed/simple;
	bh=sm1UvO9HJ27dul6o8PteCs2LjpXoY8dl2X0N6XOfwXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNOm/7thMX8CdA+j/v2XpUyYAQ7k/WrNRwL6UyilbPYyA7IYP9mPYbvib0GvvSR/WSeaQCE714LCCdPYLoiZG5rISNFKwyO5nLAwZ4cCFUcrDgdi8F9P+MI0PKhsrVBYVFizda7+W7ZFmVX6d/KEzyViz9ERsRIeplQvjGEHRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fYy3y0nd; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 296eb38b8;
	Thu, 13 Nov 2025 14:28:37 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: krzysztof.karas@intel.com
Cc: airlied@gmail.com,
	andi.shyti@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	jianhao.xu@seu.edu.cn,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mikolaj.wasiak@intel.com,
	nitin.r.gote@intel.com,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	zilin@seu.edu.cn
Subject: Re: [PATCH] drm/i915: Fix improper freeing of GTT resources
Date: Thu, 13 Nov 2025 06:28:36 +0000
Message-Id: <20251113062836.109379-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <w65f2rp75bxa3j5twgqkaq52t3hu6r6s72eo2rpaycoudq4jor@3e5uhyrgiqp2>
References: <w65f2rp75bxa3j5twgqkaq52t3hu6r6s72eo2rpaycoudq4jor@3e5uhyrgiqp2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7be6d6be03a1kunm8168544c111744
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHRkdVkoYS0hMTE1LHh1DGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=fYy3y0ndBjNOOE8TUIJDdARp9Tl7+Rg7IP9AlbKA8VGO0G/w+WUhNbmGyKtBZmVr/9Fe1Jy9uOObBJH9jH/Xcf1lOxsDM7gXbmtRTsyAVe8GXQJmPVh7Z1ovyewi6vAmFJMHJPVNvJb3yAdA2+ZqG2aFGnZXB5XApoJv9X8b3kw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=i40pANTPTAlLXf/Xv35Wt1YdGvZo+1REVipDwy3lPbc=;
	h=date:mime-version:subject:message-id:from;

On Wed, Nov 12, 2025 at 12:45:13PM +0000, Krzysztof Karas wrote:
> Hi Zilin,
> 
> > In the error paths of reserve_gtt_with_resource() and
> > insert_gtt_with_resource(), a vma_res object allocated via
> > i915_vma_resource_alloc() was incorrectly released using kfree().
> > 
> > Since i915_vma_resource_alloc() allocates objects from a dedicated
> > kmem_cache, using kfree() instead of the corresponding
> > i915_vma_resource_free() causes a mismatch between allocation and
> > deallocation routines, potentially leading to memory corruption.
> I would not call this "improper", because the definition of
> kfree allows this usage (found in mm/slub.c):
> 
> /**
>  * kfree - free previously allocated memory
>  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>  *
>  * If @object is NULL, no operation is performed.
>  */
> void kfree(const void *object)
> {
> 	struct folio *folio;
> 	struct slab *slab;
> 	struct kmem_cache *s;
> 	void *x = (void *)object;
> 
> 	trace_kfree(_RET_IP_, object);
> 
> 	if (unlikely(ZERO_OR_NULL_PTR(object)))
> 		return;
> 
> 	folio = virt_to_folio(object);
> 	if (unlikely(!folio_test_slab(folio))) {
> 		free_large_kmalloc(folio, (void *)object);
> 		return;
> 	}
> 
> 	slab = folio_slab(folio);
> 	s = slab->slab_cache;
> 	slab_free(s, slab, x, _RET_IP_);
> }
> EXPORT_SYMBOL(kfree);
> 
> i915_vma_resource_alloc() calls kmem_cache_zalloc, which is
> defined in include/linux/slab.h:
> 
> #define kmem_cache_zalloc(_k, _flags)		kmem_cache_alloc(_k, (_flags)|__GFP_ZERO)
> 
> I understand what you are trying to do here, but I'd call this
> improvement to the readability and matching alloc/free routines
> rather than "fixing" it.

Thanks for your review and for pointing out that kfree() can handle
memory from a kmem_cache. I agree that this change is better described
as an improvement for readability and to ensure matching
allocation/deallocation functions are used. I will update the commit
message accordingly in v2.

> > Fix this by calling i915_vma_resource_free() to properly release the
> > vma_res object in both functions.
> > 
> > Fixes: e1a4bbb6e837d ("drm/i915: Initial introduction of vma resources")
> I think you could drop the last sentence and Fixes tag.

I will drop the last sentence and Fixes tag in the v2 patch.

> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> > index 7ab4c4e60264..16e72ef57bed 100644
> > --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> > +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> > @@ -1524,7 +1524,7 @@ static int reserve_gtt_with_resource(struct i915_vma *vma, u64 offset)
> >  		i915_vma_resource_init_from_vma(vma_res, vma);
> >  		vma->resource = vma_res;
> >  	} else {
> > -		kfree(vma_res);
> > +		i915_vma_resource_free(vma_res);
> >  	}
> >  	mutex_unlock(&vm->mutex);
> >  
> > @@ -1704,7 +1704,7 @@ static int insert_gtt_with_resource(struct i915_vma *vma)
> >  		i915_vma_resource_init_from_vma(vma_res, vma);
> >  		vma->resource = vma_res;
> >  	} else {
> > -		kfree(vma_res);
> > +		i915_vma_resource_free(vma_res);
> >  	}
> >  	mutex_unlock(&vm->mutex);
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Best Regards,
> Krzysztof

Best Regards,
Zilin Guan

