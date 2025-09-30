Return-Path: <linux-kernel+bounces-838258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D59BAED18
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907251684D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734B2D3759;
	Tue, 30 Sep 2025 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8/k4f0K"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060B2D2381
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276630; cv=none; b=OyLKYbphrmAL4XzbkDkAlMZFTgNpGB+QOqufjEU+6TsSo8F3AsGTApiMwB69usBbo8mAykwHo9g8i4b78NUOq8R5UGavmsSqH3mtxFR6b99wy58EAiw3YukkyRfpyNnfkH/ccloP2XNHeywWPDgP/H9KjxfPHJ4xNigud/XrcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276630; c=relaxed/simple;
	bh=atva32dpAGurDqbsN1X/1jyjnqhlQoecIg344mg7ygw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eY2LQNoCUpQxB2n6X36sDyQLU/TLRSEyNqsBFBrYbxdyooa29JiBQMJf/MIXDbktxLYM0WMxkh36uoBKlD72ShJz2a50SG9yyaD1e/HrkVQoMTTVgbcU9v17w802QQMpp02VG8TbcBFcDtgUIS/Dm6VEl3LZam7wDwtZMw01tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8/k4f0K; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780f914b5a4so6151293b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759276626; x=1759881426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTud8SdXKBeCuSaGWDhSF1xN2wT+DbeyoTk33RQk500=;
        b=H8/k4f0Ke6wvcMkxRcbREMh1xhBFyKI0YZidixGUChEQHQd5eLbM4OINPzf0gnc6nQ
         jdg72pZYtYZp1f6ZHdEjzKyYQ5yim0HjUXYR17Wpb/dN/UxyrL/bJKxLuAhmQ/nidf9D
         ecKxtnypdJbmYwTmek/VMokZSMQqoYQpN5jWBWfiJhuRJOak7Hqa1NRH2QtTgFiGgS73
         Z8tlrT80tg2rL/Xu7UNdnwYOtZbed7WZsPCZzjCGod2xhvTBrypT/fgSoib6iFylvGu3
         ZjpqJUfVifE/jjIqNsqDcVjme6A+vAsl7p23srMvrYWNx14YFIZdxk1AQWIw1QFz7pjP
         uEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759276626; x=1759881426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTud8SdXKBeCuSaGWDhSF1xN2wT+DbeyoTk33RQk500=;
        b=Bsy2pwUEosOIMmqhEl8FWc+cr94kBGXa3zgXHUUuOXDd6LoGQcD87i5oMsPs6LfVQI
         +4pPaCT5cT4AvTRKTi/uVau+vQJ1WT/GUJwoR6w7DWLmIJ0dMgEaCDGxNrPQS7MPHvTE
         1K8xX1ttBXGROWlERpqYsJfM59Nl2YwsWPQR/e43ug7zgjC0hWmv+pfgCFdbtFCy6cYG
         fcvgt8i2vDWGbxchZzucd3zYH0CsuhlJUzADertiMN0ufcGYfYPEzax/TES8i8pKsaV5
         4P1BW+hvZpkV9+S2BBokFx81rc0ClW2FLIcrNIosWGFJOFksEFreHH/B0uoeduV2iF4F
         kBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVG8VLrU7MvmogI+5re/UxgSIZ+eI4PYqSRaEOQa7UqHlbJ2oFotE2RWqSs81D5hBAGKMcXflQPfxwoZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcR1Y2M0zSjC97FER45+xCHZqb8iEaxDylX2HQM1KuIcaRoDv
	xSIcx0Eps/cVrl81o0w0d3U8QolU/xszqlOHdfpb6j9L2kaXhsnOwOQ+lhamJOamIbt9fsPC0+D
	Z0O1mmg==
X-Google-Smtp-Source: AGHT+IHGur04GASc/Obl7kcIHR+n+On2SMP5CTuuAmfjMJE41ohUNTMozHS4yRLDexY+owtgfBJrf5yhVUY=
X-Received: from pghi5.prod.google.com ([2002:a63:e905:0:b0:b55:15b6:28fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7305:b0:2e5:655c:7f92
 with SMTP id adf61e73a8af0-321e98360f1mr1975657637.50.1759276626337; Tue, 30
 Sep 2025 16:57:06 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:57:04 -0700
In-Reply-To: <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
Message-ID: <aNxuUMbNhcURAxR_@google.com>
Subject: Re: [RFC PATCH v2 05/51] KVM: guest_memfd: Skip LRU for guest_memfd folios
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Fuad Tabba <tabba@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Michael Roth <michael.roth@amd.com>, 
	Ira Weiny <ira.weiny@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, David Hildenbrand <david@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

Trimmed Cc again.

On Wed, May 14, 2025, Ackerley Tng wrote:
> filemap_add_folio(), called from filemap_grab_folio(), adds the folio
> onto some LRU list, which is not necessary for guest_memfd since
> guest_memfd folios don't participate in any swapping.
> 
> This patch reimplements part of filemap_add_folio() to avoid adding
> allocated guest_memfd folios to the filemap.
> 
> With shared to private conversions dependent on refcounts, avoiding
> usage of LRU ensures that LRU lists no longer take any refcounts on
> guest_memfd folios and significantly reduces the chance of elevated
> refcounts during conversion.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: Ia2540d9fc132d46219e6e714fd42bc82a62a27fa

Please make sure to purge Change-Id before posting upstream.

> ---
>  mm/filemap.c           |  1 +
>  mm/memcontrol.c        |  2 +
>  virt/kvm/guest_memfd.c | 91 ++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b90cbeb4a1a..bed7160db214 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -954,6 +954,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  	return xas_error(&xas);
>  }
>  ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
> +EXPORT_SYMBOL_GPL(__filemap_add_folio);
>  
>  int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  				pgoff_t index, gfp_t gfp)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c96c1f2b9cf5..1def80570738 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4611,6 +4611,7 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(__mem_cgroup_charge);
>  
>  /**
>   * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
> @@ -4785,6 +4786,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>  	uncharge_folio(folio, &ug);
>  	uncharge_batch(&ug);
>  }
> +EXPORT_SYMBOL_GPL(__mem_cgroup_uncharge);

These exports need to be added in a separate patch.  As a general rule, isolate
changes that need approval from non-KVM (or whatever subsystem you're targeting)
Maintainers.  That provides maximum flexibility, e.g. the patch can be Acked and
carried in the targeted tree, it can be applied separately and exposed via a
topic branch, etc.

>  void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
>  {
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f802116290ce..6f6c4d298f8f 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -466,6 +466,38 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	return r;
>  }
>  
> +static int __kvm_gmem_filemap_add_folio(struct address_space *mapping,
> +					struct folio *folio, pgoff_t index)
> +{
> +	void *shadow = NULL;
> +	gfp_t gfp;
> +	int ret;
> +
> +	gfp = mapping_gfp_mask(mapping);
> +
> +	__folio_set_locked(folio);
> +	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);

The @shadow param can be NULL, at least in current upstream code.

> +	__folio_clear_locked(folio);
> +
> +	return ret;
> +}
> +
> +/*
> + * Adds a folio to the filemap for guest_memfd. Skips adding the folio to any
> + * LRU list.

Eh, the function name covers the first sentence, and stating something without
explaining _why_ isn't all that helpful for non-library code.  E.g. there's no
kvm_gmem_file_add_folio() that DOES add to LRUs, so on its own the distinction
is uninteresting.

> + */
> +static int kvm_gmem_filemap_add_folio(struct address_space *mapping,
> +					     struct folio *folio, pgoff_t index)
> +{
> +	int ret;
> +
> +	ret = __kvm_gmem_filemap_add_folio(mapping, folio, index);
> +	if (!ret)
> +		folio_set_unevictable(folio);
> +
> +	return ret;
> +}
> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -477,8 +509,46 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   */
>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  {
> +	struct folio *folio;
> +	gfp_t gfp;
> +	int ret;
> +
> +repeat:
> +	folio = filemap_lock_folio(inode->i_mapping, index);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	gfp = mapping_gfp_mask(inode->i_mapping);
> +
>  	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	folio = filemap_alloc_folio(gfp, 0);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = mem_cgroup_charge(folio, NULL, gfp);
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
> +	if (ret) {
> +		folio_put(folio);
> +
> +		/*
> +		 * There was a race, two threads tried to get a folio indexing
> +		 * to the same location in the filemap. The losing thread should
> +		 * free the allocated folio, then lock the folio added to the
> +		 * filemap by the winning thread.
> +		 */
> +		if (ret == -EEXIST)
> +			goto repeat;
> +
> +		return ERR_PTR(ret);
> +	}

I don't see any value in copy+pasting the complex "goto repeat" pattern from the
filemap code.  Copying names and exact patterns seems to be a theme with pulling
code from the kernel into guest_memfd code.  Please don't do that.  Write code
that makes the most sense for guest_memfd/KVM.  There's value in consistency
throughout the kernel, but copying code verbatim from a subsystem that's going
to evolve independently and thus diverage at some point isn't a net positive.

This code in particular can be reworked to something like this.  The do-while
loop makes it _much_ more obvious when KVM retries, and also makes it much easier
to see that the allocated folio is freed on any error, i.e. even on EEXIST.

static struct folio *__kvm_gmem_get_folio(struct address_space *mapping,
					  pgoff_t index,
					  struct mempolicy *policy)
{
	const gfp_t gfp = mapping_gfp_mask(mapping);
	struct folio *folio;
	int err;

	folio = filemap_lock_folio(mapping, index);
	if (!IS_ERR(folio))
		return folio;

	folio = filemap_alloc_folio(gfp, 0, policy);
	if (!folio)
		return ERR_PTR(-ENOMEM);

	err = mem_cgroup_charge(folio, NULL, gfp);
	if (err)
		goto err_put;

	__folio_set_locked(folio);

	err = __filemap_add_folio(mapping, folio, index, gfp, NULL);
	if (err) {
		__folio_clear_locked(folio);
		goto err_put;
	}

	return folio;

err_put:
	folio_put(folio);
	return ERR_PTR(err);
}

/*
 * Returns a locked folio on success.  The caller is responsible for
 * setting the up-to-date flag before the memory is mapped into the guest.
 * There is no backing storage for the memory, so the folio will remain
 * up-to-date until it's removed.
 *
 * Ignore accessed, referenced, and dirty flags.  The memory is
 * unevictable and there is no storage to write back to.
 */
static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
{
	/* TODO: Support huge pages. */
	struct address_space *mapping = inode->i_mapping;
	struct mempolicy *policy;
	struct folio *folio;

	/*
	 * Fast-path: See if folio is already present in mapping to avoid
	 * policy_lookup.
	 */
	folio = filemap_lock_folio(mapping, index);
	if (!IS_ERR(folio))
		return folio;

	policy = kvm_gmem_get_folio_policy(GMEM_I(inode), index);

	do {
		folio = __kvm_gmem_get_folio(mapping, index, policy);
	} while (IS_ERR(folio) && PTR_ERR(folio) == -EEXIST);

	mpol_cond_put(policy);
	return folio;
}

> +
> +	__folio_set_locked(folio);
> +	return folio;
>  }
>  
>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -956,23 +1026,28 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  }
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +static void kvm_gmem_invalidate(struct folio *folio)
> +{
> +	kvm_pfn_t pfn = folio_pfn(folio);
> +
> +	kvm_arch_gmem_invalidate(pfn, pfn + folio_nr_pages(folio));
> +}
> +#else
> +static inline void kvm_gmem_invalidate(struct folio *folio) {}
> +#endif

Similar to my comment about not adding one-off helpers without good reason, don't
add one-off #ifdef-guarded helpers.  Just bury the #ifdef in the function (or if
possible, avoid #ifdefs entirely).  This way a reader doesn't have to bounce
through ifdeffery just to see that kvm_gmem_invalidate() is a nop when
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=n

static void kvm_gmem_free_folio(struct folio *folio)
{
	folio_clear_unevictable(folio);

#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
	kvm_arch_gmem_invalidate(folio_pfn(folio),
				 folio_pfn(folio) + folio_nr_pages(folio));
#endif
}

> +
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -	struct page *page = folio_page(folio, 0);
> -	kvm_pfn_t pfn = page_to_pfn(page);
> -	int order = folio_order(folio);
> +	folio_clear_unevictable(folio);
>  
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +	kvm_gmem_invalidate(folio);
>  }
> -#endif
>  
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  	.error_remove_folio = kvm_gmem_error_folio,
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  	.free_folio = kvm_gmem_free_folio,
> -#endif
>  };
>  
>  static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,
> -- 
> 2.49.0.1045.g170613ef41-goog
> 

