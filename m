Return-Path: <linux-kernel+bounces-835602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8316BA78DC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B8A1891005
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554A230D0F;
	Sun, 28 Sep 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGPLOWWG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68F155C97
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759096520; cv=none; b=fx1MCZjLp1kA2m38jk8Zh2RRDzj5K3iTDFYf3Kxj/T6ZVay/qUWBKE7XkK/M/Awl71sZ2QsPtVElzevNoVIRmqKK4qYj/70s9DLkLaRNNQSYCxocYpsSWlhiAnaCO1bmCu8FcO1waeOJtHfGgQ2pJiVasECCvwnSIThLkVXEOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759096520; c=relaxed/simple;
	bh=+EAjlEO8uQDwc8jzUv6BlII0XyFQAH1/Gq1lWKA3OWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFuAVvwRn6DZm1W0CBgu9pWi+fVwzJcrgN3ia4lvUlJ1bVqNFyTPknxMfFEy5FkM971cpCIsH3o8qoCNiuytGUi7w8k375EEgZKbwtKD69LQ84eGbGbAXK3M0XJSfKx7UCPUubbwYHs1m57s2VHdN1Ya7EHrUTN7Lk6ae70von4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGPLOWWG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso91385e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759096516; x=1759701316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMA3FY1cLbcNhfw1XHhs0JDOqj11mx6kBKtX7cr5kdQ=;
        b=nGPLOWWGv4PHsgVvHLQWSVjI0Ll6jnULVDlEShJsziLarM4J6ZxyUguVJ65CunyAXN
         c6cbDDsISfrwch/0hNNLvnEWqjkX84AMMFgYxA2vBAY7ifVxxVEaFbIgtkaFRzkzBGNC
         0F1veNFd/97hZBkxOeT4bkzWly9qNr3w+o5yjUvsOJmGSqWAf7TdjuyA1QuDCyRA85hY
         5ZEPF7cpky4rKI0r57UrcFF94tYh7oUCgFlfPHsUV74gBsaEVeWD/uHEBTR6wMRYdvnt
         jzD5Le1tGuAttUFTa8eJHK2U9KqVdFZhu5h1bWoDsQnVPqA7KaseH9CrL8Fl9eDjLsW1
         9QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759096516; x=1759701316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMA3FY1cLbcNhfw1XHhs0JDOqj11mx6kBKtX7cr5kdQ=;
        b=Y/TbdtvRZEcRm8K187MQhVqVh1r09pM1hz5VvnGymOLNQTylb43KtXxhlBNZldBGu7
         EvvurmP00JGPGC0+wuHjeRB2ngL0sBxr6qcXsYgj/Vfx5TTw9AgMcQCTcS6gUiJpev87
         QxHi9geToyCK57xDpPrT2l8blkLs2mzUV67gWQlivyM21D0tr8m7D3o6KFUP5C+af+xV
         +D5EeyhQS0IjKWCDMvSTywqZ7xbvrW2eSEPs7pwx+QDrewJ5Qp64rZU6Yz0RJlYKZYAn
         zRE9KJP8ff59Ry+/8MgMIjkDb/Xc+wRIrG5B3H3IbZGkxmKpPkdgjMKCBE0GcdKXk+CJ
         gz2g==
X-Forwarded-Encrypted: i=1; AJvYcCXTE0YAoEgjmdrFGugKpw8OsCj60AWEnPIfcinv3SQaDSLLWf2Sj0aeHx1ahZfBrT8omJ09faJjR7gLh4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdjNZUoo71ZmUAMVetAonSC0p0IzDjAAGGXkrDCACR5zmnXbI
	Vf6SyRw8CP4XXij9IQV02eLWMTJFG4AI7GK8wB0Dp/T+6N4F7vq9XHOoN9mTp3miJUjAL+5JGNI
	hjbQvJRsJScoApa8otoeu4myE6bl/46YaBSmfq8Cf
X-Gm-Gg: ASbGncuYeQjX/E3EpjO4aBfSJku+Yg4+mrWkG4yvnDdjACoASIKSc6Z7YaxHZJS9kmd
	aMSYm0W7hbDdSFpWTAlCBh3kbNYTlV5Dayyv3qbpaoe1vHgvL2l0x6IXe29GUUHtIqNF25ylAYg
	fPS6h/PcR0HQlX4WFTTLQjJK7A71mUKsxiqIEZwx2N9Ye+okhfYLImaJ0Cdf0rrmADVNZTAFXvx
	gfa2wfCYzm4aPe3EL1ZUhmFHn15V7DJbGDRqPun
X-Google-Smtp-Source: AGHT+IGuuHuV6NhRdtb2XbDDFb64hZXsw9U4K9RD49mZlUNSm0AUIK8jLtLvPojHIhekgdfDaYZhLDQcukon9pUOy4U=
X-Received: by 2002:a05:600c:1687:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-46e3af88c70mr4043975e9.2.1759096516280; Sun, 28 Sep 2025
 14:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sun, 28 Sep 2025 14:55:04 -0700
X-Gm-Features: AS18NWCZXYADEm26_yLS0Zgi7PqfD8kDWiEzPUFTAPAgj2X_CDKkUG2kA8H6SOk
Message-ID: <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	linmiaohe@huawei.com, tony.luck@intel.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	nao.horiguchi@gmail.com, farrah.chen@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Zaborowski <andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:30=E2=80=AFPM Qiuxu Zhuo <qiuxu.zhuo@intel.com> w=
rote:
>
> From: Andrew Zaborowski <andrew.zaborowski@intel.com>
>
> When performing memory error injection on a THP (Transparent Huge Page)
> mapped to userspace on an x86 server, the kernel panics with the followin=
g
> trace. The expected behavior is to terminate the affected process instead
> of panicking the kernel, as the x86 Machine Check code can recover from a=
n
> in-userspace #MC.
>
>   mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd8000=
0000070134
>   mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>   mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e7=
41e77539027db
>   mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC =
0 microcode 80000320
>   mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>   mce: [Hardware Error]: Machine check: Data load in unrecoverable area o=
f kernel
>   Kernel panic - not syncing: Fatal local machine check
>
> The root cause of this panic is that handling a memory failure triggered =
by
> an in-userspace #MC necessitates splitting the THP. The splitting process
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), whic=
h
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC, occurring before
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
>
>   First Machine Check occurs // [1]
>     memory_failure()         // [2]
>       try_to_split_thp_page()
>         split_huge_page()
>           split_huge_page_to_list_to_order()
>             __folio_split()  // [3]
>               remap_page()
>                 remove_migration_ptes()
>                   remove_migration_pte()
>                     try_to_map_unused_to_zeropage()

Just an observation: Unfortunately THP only has PageHasHWPoisoned and
don't know the exact HWPoisoned page. Otherwise, we may still use
zeropage for these not HWPoisoned.

>                       memchr_inv()                   // [4]
>                         Second Machine Check occurs  // [5]
>                           Kernel panic
>
> [1] Triggered by accessing a hardware-poisoned THP in userspace, which is
>     typically recoverable by terminating the affected process.
>
> [2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().
>
> [3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().
>
> [4] Re-access sub-pages of the hw-poisoned THP in the kernel.
>
> [5] Triggered in-kernel, leading to a panic kernel.
>
> In Step[2], memory_failure() sets the has_hwpoisoned flag on the THP,
> right before calling try_to_split_thp_page(). Fix this panic by not
> passing the RMP_USE_SHARED_ZEROPAGE flag to remap_page() in Step[3]
> if the THP has the has_hwpoisoned flag set. This prevents access to
> sub-pages of the poisoned THP for zero-page identification, avoiding
> a second in-kernel #MC that would cause kernel panic.
>
> [ Qiuxu: Re-worte the commit message. ]
>
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  mm/huge_memory.c    | 3 ++-
>  mm/memory-failure.c | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9c38a95e9f09..1568f0308b90 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3588,6 +3588,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>                 struct list_head *list, bool uniform_split)
>  {
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
> +       bool has_hwpoisoned =3D folio_test_has_hwpoisoned(folio);
>         XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>         struct folio *end_folio =3D folio_next(folio);
>         bool is_anon =3D folio_test_anon(folio);
> @@ -3858,7 +3859,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>         if (nr_shmem_dropped)
>                 shmem_uncharge(mapping->host, nr_shmem_dropped);
>
> -       if (!ret && is_anon)
> +       if (!ret && is_anon && !has_hwpoisoned)
>                 remap_flags =3D RMP_USE_SHARED_ZEROPAGE;
>         remap_page(folio, 1 << order, remap_flags);
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index df6ee59527dd..3ba6fd4079ab 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2351,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
>                  * otherwise it may race with THP split.
>                  * And the flag can't be set in get_hwpoison_page() since
>                  * it is called by soft offline too and it is just called
> -                * for !MF_COUNT_INCREASED.  So here seems to be the best
> -                * place.
> +                * for !MF_COUNT_INCREASED.
> +                * It also tells split_huge_page() to not bother using

nit: it may confuse readers of split_huge_page when they didn't see
any check on the hwpoison flag. So from readability PoV, it may be
better to refer to this in a more generic term like the "following THP
splitting process" (I would prefer this), or to point precisely to
__folio_split.

Everything else looks good to me.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

> +                * the shared zeropage -- the all-zeros check would
> +                * consume the poison.  So here seems to be the best plac=
e.
>                  *
>                  * Don't need care about the above error handling paths f=
or
>                  * get_hwpoison_page() since they handle either free page
> --
> 2.43.0
>
>

