Return-Path: <linux-kernel+bounces-809502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AEB50E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F06517B912
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124530748A;
	Wed, 10 Sep 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnt4JP0m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0E2D24AC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486752; cv=none; b=ONPr1nkBB27/SdkzxkpsIVQV/0wwpL+dlWv9hg3qQ8L1YAzu4hYZEw3abMx0Mp63wYNYSEDP0knkJCBdGa81D62otgf5aqZHIiMUnjHIyMx+lVwe/F+27rE4aRSqon4Dwm7vjncuJ7BXXp8poajIzdpy+whbzpmojE59YoWFqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486752; c=relaxed/simple;
	bh=H0aZbqVhd5GoPxkwQUZK3QWxN2ceWNRsWEz7AGCiSN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OkHgO9KpkGo8PMiMVm0cUSBCpEdhKu1p8DyptkZpaGp0VKRf9TGfhZ3yOhkaxeu4FVUi3hRT+f6TV6vx9QfHax/sAbqaJGOeObY+ABvLvNfnEJg/JUL8hlw/chO+tRxCSmgJLafIpH2ZFWZyukxkuo/3sMSYA5p+KnN65j6jCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnt4JP0m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757486748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V0LaaZHJC2+QM5StiTxDhV+SbRojzxK9teAGcqG/Wng=;
	b=gnt4JP0mKOikI4V3FYz4rx1uC18pW7L8S/sM2Dl72rEv4WWRBkgGuw2c/XRkk4GDkz5Lfm
	TGEaPDTAoXeCt40AIrBljrMmMJPoYXS3e2rFujUXdknbMWqPE2O8Bg5fDd+NsWdu4fTcQa
	xWA8Q5Bl7jRzpQ3WhX4haM0JTXUJdy0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-rM5DeSLGN56ARl5c8voxOg-1; Wed, 10 Sep 2025 02:45:46 -0400
X-MC-Unique: rM5DeSLGN56ARl5c8voxOg-1
X-Mimecast-MFC-AGG-ID: rM5DeSLGN56ARl5c8voxOg_1757486745
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de27bf706so16232545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757486745; x=1758091545;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0LaaZHJC2+QM5StiTxDhV+SbRojzxK9teAGcqG/Wng=;
        b=iDchgctW7LBTspgLXxVthqS8m34SZfxmeQzMAse4E3Ml/cx1KTLoV3SEvf8Qgy5OIV
         /vmpQwk0sMPPKjnw+aD7wRWOFE8UetMqmTrSBzklICzTWT/KeVkF5QwjITG9QQ91cVMI
         D404RBV1xsuQryCcxNG5z5BdgnhZSe7uG7V1VANC8k1cTpXZddPKlxl01YlVRf54HOJG
         3PT386XyjR1dfD2d+Ewfw9BCF9mMeaj1r593YtT59En/RqXqdq97gEri2xYTePJeoLHn
         sRUxAsrGmfTLxDZdaktl/tqGd7MovlTW/n3rYTCTAQ1PiVpEJ4+6t0wYq9l37suUX6bb
         C05A==
X-Forwarded-Encrypted: i=1; AJvYcCU+IZfJHq5mjYbgjPGMnRhjf+voeUSE/8Fm6V5K+6GV8dJ0ejdGXDAV9wTQnU+poRVut0xAKob4pI/y7zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHem4c7ro5efvmRUwDAUAzg8N93gC1vxsPGH9TuO6CwuBfWfxV
	+MKtx956+SAyzESUhx32vktmIPAQ7VMUGs79FsDjGswYCaAAtBIYClJBWJsLvSNkQdNmE9onsdw
	+Ug8LysBcJu45vVi2Sxl2XV33lwgzAN1lKYSCgeMg7J+SFpco5lJlDK2qB4M1ImSB4raf+HKcyg
	==
X-Gm-Gg: ASbGncuQl0ELi/b08ZDmmnOtzuDYiomd7rV20DSPvoUMiK0cBbKtUWlcIxo/4raJDgG
	Js/RVsM/Mv9lzASUtF0d7R6mY193iJskFY4diNy29hE6BbUd3sKYkhtFnXGfxmuJvGLIcyv8Okn
	xkOIXqNz36iQtM9ajAxSQgX8nxKjVZVCa7FIz8JoUT/zRmbZ6FdKS07EdD+mD7F6ilyUJWwcD9Y
	nwpDHmCaVwc72cUMhjV7RrlZ4PpGXenZQLj94uSq2/PEn5JT7vS2tOu2QD3IsR0EWIn4UReiTNV
	yjjBc8CLd4PInfoBJH2kpibFn5NQsbMgCQnOGOGIhJ83rRDnDyq/L6LnTSESBJ/lssG9mnCVWu1
	+0iKPFk/oC592SnycZq8cXnE5hh7zFIm2dQSmQ0ApRikD3NiOFGowx/pACJkTUMi70II=
X-Received: by 2002:a05:600c:8b42:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45dddefa74emr108518505e9.34.1757486745353;
        Tue, 09 Sep 2025 23:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiaDvgvPi+ow108IrBBgH6uR4YMCBOBWtjYkmddUoAmFVlm0pw98QwAazjmMcru3JY0FxgMQ==
X-Received: by 2002:a05:600c:8b42:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45dddefa74emr108518355e9.34.1757486744966;
        Tue, 09 Sep 2025 23:45:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df17d9774sm23146765e9.9.2025.09.09.23.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 23:45:44 -0700 (PDT)
Message-ID: <e9b34151-0879-4900-af9f-2ce0dbb678a6@redhat.com>
Date: Wed, 10 Sep 2025 08:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: Jane Chu <jane.chu@oracle.com>, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250909184357.569259-1-jane.chu@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909184357.569259-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 20:43, Jane Chu wrote:
> commit 59d9094df3d79 introduced ->pt_share_count dedicated to
> hugetlb PMD share count tracking, but omitted fixing
> copy_hugetlb_page_range(), leaving the function relying on
> page_count() for tracking that no longer works.
> 
> When lazy page table copy for hugetlb is disabled (commit bcd51a3c679d),
> fork()'ing with hugetlb PMD sharing quickly lockup -
> 
> [  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
> [  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
> [  239.446631] Call Trace:
> [  239.446633]  <TASK>
> [  239.446636]  _raw_spin_lock+0x3f/0x60
> [  239.446639]  copy_hugetlb_page_range+0x258/0xb50
> [  239.446645]  copy_page_range+0x22b/0x2c0
> [  239.446651]  dup_mmap+0x3e2/0x770
> [  239.446654]  dup_mm.constprop.0+0x5e/0x230
> [  239.446657]  copy_process+0xd17/0x1760
> [  239.446660]  kernel_clone+0xc0/0x3e0
> [  239.446661]  __do_sys_clone+0x65/0xa0
> [  239.446664]  do_syscall_64+0x82/0x930
> [  239.446668]  ? count_memcg_events+0xd2/0x190
> [  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
> [  239.446676]  ? syscall_exit_work+0x118/0x150
> [  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
> [  239.446681]  ? clear_bhb_loop+0x30/0x80
> [  239.446684]  ? clear_bhb_loop+0x30/0x80
> [  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> There are two options to resolve the potential latent issue:
>    1. remove the PMD sharing awareness from copy_hugetlb_page_range(),
>    2. fix it.
> This patch opts for the second option.
> 
> Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared
> count")
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   mm/hugetlb.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b4c718..8ca5b4f7805f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5594,18 +5594,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   			break;
>   		}
>   
> -		/*
> -		 * If the pagetables are shared don't copy or take references.
> -		 *
> -		 * dst_pte == src_pte is the common case of src/dest sharing.
> -		 * However, src could have 'unshared' and dst shares with
> -		 * another vma. So page_count of ptep page is checked instead
> -		 * to reliably determine whether pte is shared.
> -		 */
> -		if (page_count(virt_to_page(dst_pte)) > 1) {
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +		/* If the pagetables are shared don't copy or take references. */

Why remove so much of the original comment?

> +		if (ptdesc_pmd_pts_count(virt_to_ptdesc(dst_pte)) > 0) {
>   			addr |= last_addr_mask;
>   			continue;
>   		}

LGTM, thanks!

-- 
Cheers

David / dhildenb


