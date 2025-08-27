Return-Path: <linux-kernel+bounces-787882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF000B37CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F75362D33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D1322774;
	Wed, 27 Aug 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mnb84gfl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8547322771
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282087; cv=none; b=RI72fNZP1EVHapr6/Gl8Rsh+B93KvTh2og0QDXGZqq2OfiscRQHV8IAwH6STNplkzRzNLgIBi0JW1HTeVtxSewUwZtUqNMDqax+NFa8nSAUerFpcDsSQV57125FxN4yQuUFT0naxkQbeQXV7+z4LdUL5OSL0x9fyTedHBmsc+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282087; c=relaxed/simple;
	bh=iUMnI1Gr4aSIqM3m6NcNydTZjndSBas7VbolVEVepzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPKAyvraqj+h64zT/tlCV8Bn7sVGF1d7yMZQYud8mOzfN8GokCZ7Z0KI0LGrkPSt8ZEFxi2ZvG8KnmvYQAhXocTsht5IChq6ZcmZjCPe6UIBel/hQqC2cxr2whb3XoMvMtMVj2BUBWsX4SWndnh8OwUPypigCLAYNb7YK1vFzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mnb84gfl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756282076;
	bh=iUMnI1Gr4aSIqM3m6NcNydTZjndSBas7VbolVEVepzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mnb84gflk5q2wshjIppNvzipnpgkgqqqkczdn533RahwnTwvlfvMoPzKAl1VUJPJc
	 hTN5RyiO9im78ixrxURAKhqtHk+IaHrV5FIgbsMWkdu7eRzgtE5JgDIMA5cPdUzWAw
	 5lsbxiIbOBFHOwM0mWRRB56Xy6BLDcwjTqoFakuJSHqNdeCWQsn5WpLXV1SEqiWybh
	 Q6ZBT9fl49OU4kTiZTiCXh3ZivyZKcappvkcGmcJR7KI/xP86+8YT1ys0VB46RSo3+
	 d14WLCELgzukLxxEHccJ/kTN9X2MhOAcPjWT7ctVijmQmPgrEBA/aoi0C6gM7hekeB
	 BScLOoxqZwIUw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D9E117E00A3;
	Wed, 27 Aug 2025 10:07:56 +0200 (CEST)
Date: Wed, 27 Aug 2025 10:07:48 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dmitry.baryshkov@oss.qualcomm.com, airlied@gmail.com,
 simona@ffwll.ch, dmitry.osipenko@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use drm_gem_shmem_unpin() to unpin the backing pages
 for a shmem GEM
Message-ID: <20250827100748.0d7fb9d1@fedora>
In-Reply-To: <20250827022516.2890226-1-xiaolei.wang@windriver.com>
References: <20250827022516.2890226-1-xiaolei.wang@windriver.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 10:25:16 +0800
Xiaolei Wang <xiaolei.wang@windriver.com> wrote:

> Although drm_gem_shmem_free() will decrease the use count
> on the backing pages and free backing pages for a GEM object,
> the pages_pin_count count is not decremented, which results
> in a warning. Therefore, use drm_gem_shmem_unpin() to unpin
> the backing pages for a shmem GEM.

With the subject prefixed with "drm/gem-shmem: " this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> WARNING: CPU: 2 PID: 1106 at drivers/gpu/drm/drm_gem_shmem_helper.c:180 drm_gem_shmem_free+0x4d0/0x6f0
>  Call trace:
>   drm_gem_shmem_free+0x4d0/0x6f0 (P)
>   drm_gem_shmem_free_wrapper+0x10/0x1c
>   __kunit_action_free+0x50/0x70
>   kunit_remove_resource+0x144/0x1e4
>   kunit_cleanup+0x64/0xfc
>   kunit_try_run_case_cleanup+0xa0/0xd4
>   kunit_generic_run_threadfn_adapter+0x80/0xec
>   kthread+0x3b8/0x6c0
>   ret_from_fork+0x10/0x20
> 
> Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 68f2c3162354..e0a9f3a917ed 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -227,6 +227,7 @@ static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
>  		len += sg->length;
>  	}
>  
> +	drm_gem_shmem_unpin(shmem);
>  	KUNIT_EXPECT_GE(test, len, TEST_SIZE);
>  }
>  


