Return-Path: <linux-kernel+bounces-858194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D1BE9410
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADB06E3D34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278632E141;
	Fri, 17 Oct 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC0vTxKu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FD32C931
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712192; cv=none; b=bT8e8xYU3fFAqqp3dzZevAusX/4LhrcHtRLTnoU7dK9QPNQFsmppGGu55ys7KpuB0Rv6mBDzfTcw2rxoB4PPdjT+FhjHY4L3DbF2tRPjgr36Qhysf0kCIoJU0/AFb6+sF9ctSsX42bQP+hfzkCMv0iwP/5SWemPTBCEHyd1fPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712192; c=relaxed/simple;
	bh=LQft2ZGwphAbVdZQ8KaevaEx/UexW+O08veqrqIfS2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJnVJ/KBp2c6JQbZpyLW45Z+PphGH3LqcamBw9C7Ki0w8D42107+0IR4pMBOXmJ3tZk4/Repl+ESYr0uaKcKCJcq2XI101mu0yY1WCBuR3t1/xCGfakcogFy/kGiNWaE+l0OVxNfhyrQXqnQAlNym6zi4V7+d/ilWf2lMrE/aiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC0vTxKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxj7lS1C95jhv85kif7t4WsLymDjCUu9zyZAz/6p1Bc=;
	b=PC0vTxKunMDL+0VdvFs7c3+VB4Cn08cixsTGglwfAwOKDBVn1eCZdD22Bn4MDGWcFsX39h
	8hZLjBS0yBDWWkvamJJ5caYWBTj01dKJ/307zp+OxwovLu5goicxey3ts6K/YG5lT3hVLN
	qPshNHAyAe4D8EDyZ5hwDhHJXlwVEWw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-YPflQvvnP5OMELUEWGo7mg-1; Fri, 17 Oct 2025 10:43:08 -0400
X-MC-Unique: YPflQvvnP5OMELUEWGo7mg-1
X-Mimecast-MFC-AGG-ID: YPflQvvnP5OMELUEWGo7mg_1760712188
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78417f6306dso2220337b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712188; x=1761316988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxj7lS1C95jhv85kif7t4WsLymDjCUu9zyZAz/6p1Bc=;
        b=TzVj8KXdC4jzObj/gBv6Bxa6e0h3/pKAcyXE/wMnPVB0mCUwZ88qCn6mVEGat9VWVJ
         un4+2Qm+ax/psv8U75cBZ2+I1x9MHEgZlqTl+EnECifkJJlsRn++45qON8BhDZCUqLk9
         cHdHzPBHFBOB6zgChoWjyHNtm/ti+p9FuQaaPnyLhq4fP4jWYecVCaLMMuPrJOe3u4Jl
         d6i86a/e7PwfeS7cFoghXXfiLLo1/XqwZ9lno2l/5niCxsnWi055Si5jKUeqLmqcWhJL
         vZt8Y/E7vdsVHcxRKevMnWNce1KyearHbo15U45gBdJt5YRVsYc1cxE49ql7EbKHJvOJ
         8W+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk/t1p3xIAWxvnQ/Y3rAX63QnxuJxT8eX2S/k48dZ+z5SIarAQm+hSegCNH3exTs52aJWWdPPWdCdhnrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8Omgh483x3GNxtZuxjDuKYLmxtZQTEGxr5eLwSlbPnDgur2P
	MkWaotJ5Hrm7hT8UTvDKzeDJPF2xtJcHyMPQCExyKCbTvILNAX5fQ07Va6pEjcxpKm6PbbR+74F
	O9ABXDUglXbCWWYDxhNOEguAByfkifStaQ4j9vLreGEMTc5VnRon6kgmrzpgpaCm121Kp7VRgvL
	8ZbqfPmU9jTvUCPoKc4pL87TZAgmt4/ki1I4VG7x/C
X-Gm-Gg: ASbGncuff9Ob9VREVzsCh9rSFgsGjbKwwYL8b9dhKENbZ7g/tk3Ilb2W9uOZGKchLbC
	xLrQNFUigYi3TwuVaW7RCdRPtKlsT4B2HpCN7rHGWBN0mwOpB6jJXPWqpnDAqzQT5bitoEwlEI+
	0ic2fJJB1wWd9rj/5z6qouUQ2AnEJxLT3IKF80xm5BtXKkCDi8mg1/avzvZVP7Ineytf6TzA==
X-Received: by 2002:a05:690e:1443:b0:63e:1c4c:302b with SMTP id 956f58d0204a3-63e1c4c307fmr1674698d50.47.1760712187520;
        Fri, 17 Oct 2025 07:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs48qDAMhz4D4LbgvFTtDvQVRQBswskN83/kSgWqI6wIc76qg7MoUwbuH0PX+UqeptgQovfUG/kTE2lMO7H2w=
X-Received: by 2002:a05:690e:1443:b0:63e:1c4c:302b with SMTP id
 956f58d0204a3-63e1c4c307fmr1674677d50.47.1760712186942; Fri, 17 Oct 2025
 07:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017093847.36436-1-lance.yang@linux.dev>
In-Reply-To: <20251017093847.36436-1-lance.yang@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Fri, 17 Oct 2025 08:42:41 -0600
X-Gm-Features: AS18NWCBKfGK51DZT3g62G_clfCY9edECXjl7uUSq0bR_PlTrl1LHPcNQSK0gDo
Message-ID: <CAA1CXcBSCezWLFNJFf+7yw8aVSAvbAMWe4OUa9EJ14yX=MjfPw@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls
 with pte_present()
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 3:39=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
>
> From: Lance Yang <lance.yang@linux.dev>
>
> A non-present entry, like a swap PTE, contains completely different data
> (swap type and offset). pte_pfn() doesn't know this, so if we feed it a
> non-present entry, it will spit out a junk PFN.
>
> What if that junk PFN happens to match the zeropage's PFN by sheer
> chance? While really unlikely, this would be really bad if it did.
>
> So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
> in khugepaged.c are properly guarded by a pte_present() check.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
LGTM!

Reviewed-by: Nico Pache <npache@redhat.com>
> ---
> Applies against commit 0f22abd9096e in mm-new.
>
> v1 -> v2:
>  - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
>  - Reduce a level of indentation (per Dev)
>  - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@lin=
ux.dev/
>
>  mm/khugepaged.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d635d821f611..648d9335de00 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte=
,
>                 pte_t pteval =3D ptep_get(_pte);
>                 unsigned long pfn;
>
> -               if (pte_none(pteval))
> +               if (!pte_present(pteval))
>                         continue;
>                 pfn =3D pte_pfn(pteval);
>                 if (is_zero_pfn(pfn))
> @@ -690,17 +690,18 @@ static void __collapse_huge_page_copy_succeeded(pte=
_t *pte,
>              address +=3D nr_ptes * PAGE_SIZE) {
>                 nr_ptes =3D 1;
>                 pteval =3D ptep_get(_pte);
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +               if (pte_none(pteval) ||
> +                   (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))=
) {
>                         add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
> -                       if (is_zero_pfn(pte_pfn(pteval))) {
> -                               /*
> -                                * ptl mostly unnecessary.
> -                                */
> -                               spin_lock(ptl);
> -                               ptep_clear(vma->vm_mm, address, _pte);
> -                               spin_unlock(ptl);
> -                               ksm_might_unmap_zero_page(vma->vm_mm, pte=
val);
> -                       }
> +                       if (pte_none(pteval))
> +                               continue;
> +                       /*
> +                        * ptl mostly unnecessary.
> +                        */
> +                       spin_lock(ptl);
> +                       ptep_clear(vma->vm_mm, address, _pte);
> +                       spin_unlock(ptl);
> +                       ksm_might_unmap_zero_page(vma->vm_mm, pteval);
>                 } else {
>                         struct page *src_page =3D pte_page(pteval);
>
> @@ -794,7 +795,8 @@ static int __collapse_huge_page_copy(pte_t *pte, stru=
ct folio *folio,
>                 unsigned long src_addr =3D address + i * PAGE_SIZE;
>                 struct page *src_page;
>
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +               if (pte_none(pteval) ||
> +                   (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))=
) {
>                         clear_user_highpage(page, src_addr);
>                         continue;
>                 }
> @@ -1294,7 +1296,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                                 goto out_unmap;
>                         }
>                 }
> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> +               if (pte_none(pteval) ||
> +                   (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))=
) {
>                         ++none_or_zero;
>                         if (!userfaultfd_armed(vma) &&
>                             (!cc->is_khugepaged ||
> --
> 2.49.0
>


