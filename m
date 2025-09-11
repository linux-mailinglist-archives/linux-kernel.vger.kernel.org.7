Return-Path: <linux-kernel+bounces-811609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60EBB52B71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501971C84E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C18C2D9792;
	Thu, 11 Sep 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JonPNbwr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664F2D0612
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578652; cv=none; b=mde8XxyaASsKWWcF2zr9f3pAJUC7mO+bghCqnjdPqQpSEuwNatRBrcQV0Eqwd1mjHUir19bAo/0P2/NTnGrjvtUEYWTAoUIFgYNMAMxOC1r17WZAiHuebvMcdhZ3q1wKryabt17DjjNF2Dc8Xme//0Evz3LuSV5+HOJEx9KBsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578652; c=relaxed/simple;
	bh=aCj5k/zBQRH0yYqlJrLuu8A9CLwVwUNx3B9SIc8p5Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A53H+gDDAshkEGLNuHyjUTvvDg0jKqdn/hYqApyTOhvVRPx1c73XPMOerfZGTmOdHyp6+bobc12uJtZGGADRbaUs3GgP/xHCgjCCxyqzrTG6uCrAuIoupHvoyb/QysfSbTLudlm39BwjQ6abYprbFc4jci13Wx/6DRd4GUg6p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JonPNbwr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757578649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Ad4RitIlPCzWAHNWtUENRWOS98f9IauUAknhVfFDSI=;
	b=JonPNbwrWZehl3ZXd2Fu0hwsdXfXqTyM+QmILqO+6guKbeKbuqKhi9sX3BdVBU7m5sFiUR
	FkQZMjLFt9DBjIvgxM90ymfRYw+B0tI3MU9/0UazrEW+K7aA4wYXBMrEpgXoBy0Vjd4qgA
	eP4z8ZQaoDN/esCKn5NtMfY2s77QfiU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-PJ8rPkZ3PeyX9u89GMcSzw-1; Thu, 11 Sep 2025 04:17:28 -0400
X-MC-Unique: PJ8rPkZ3PeyX9u89GMcSzw-1
X-Mimecast-MFC-AGG-ID: PJ8rPkZ3PeyX9u89GMcSzw_1757578647
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so3890615e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578647; x=1758183447;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ad4RitIlPCzWAHNWtUENRWOS98f9IauUAknhVfFDSI=;
        b=v0Idkf6aOb9i3Lf61wdUe6Ez1k2L+vLhu/Eu2km5vNSw6oNzcz1LiVxdzkfH8aDovf
         3qSdWa0o+vgLOI6RZkeNxkqJLdIQ6YZGYykZTXquRWLLjsZB+Scw3wRp9+nQTTFXkth5
         RlJ8ZEG53Ns8ujMIR7+VN+5aO+3FG8HjSnwQ7CGbpSWz3g1qL39QJkQdpZYpJiualsQ+
         UAsGq2l9VSXNG6NomRWhGXih8L333ACXJtySqGgC6c/7XJfkyqGZqvZa76kyELfIPCdl
         Z43cLdfmOWjFet3dCAplDYb0rGg2LBHNrySCbTHXsHjwQ0PzX+7xNMRjHMd7C6sAPxR8
         3Evw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KOr/7xvfGp3jqKTWOuldXbZupOGjpIknv+PHG09FgDZKWeb5+2GE2woqwt+F5T6ErOFlrT3cjnFwU60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZJtlI2t9NnFR5q7KRHmJ0dVlhVdnjCcvgCcrNfJvInfY62m+
	BGZw0L7vyYigbLmw6+ibOdPoxnWIPSKX4OM2MeGc7T+SBcmddSTV0MfwChDujJeTqW9DmeWJPZR
	HgdOkeOhIAh3Wnzt6i9gELgCsNIlE9ZFxh/grL/4xa2XwvZaYOgjGonY/BNIE8lJPng==
X-Gm-Gg: ASbGncvTAi1LhF04eRlyrMG940q9kUJUdwF/EB+WozNGeNLJkQDwCQFwJewsxQ23FCi
	OOQYs+SYquVq8XqtNE6HdbHQuAMkdZil0nTpxvv68ZZuhsYi6OvfOSuDeg4OqZQIia1MmNewZJW
	jALcPOlRql9mT/ckdrGtxLF9bvdR3uZJoFnoaazP2GPvN/GBIR48Jk6zWB3ssUJ8lwLwkZ7aZzG
	ZoPif6mzHh4nEFj77imeGdLKw82MUmLmaLNc3O87tD1psqYc16DguUfr5IyJOGHumUw/f7Xnxyl
	8a/701WMAPInJVj2vmr4S5c6brxbJYldkXJ1oPhoFhhL1ay9aYZK7zGo4jrTqP4j7L515bC3xQk
	SbH5JHiR2BhQt12I2iUPpdjidVHlnRVoBtTFEzWzR0ZxqrRDcCvZTc+IYMfR8cZR9KDM=
X-Received: by 2002:a05:600c:4e14:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45ddde8a741mr192478565e9.6.1757578646708;
        Thu, 11 Sep 2025 01:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSRVxSfASwnKAAMpCKLh03FTQFpe6kLNAVJ0k/oKJQ1NfZbCDMlSF+qLrVbq3VUgGgugW5bw==
X-Received: by 2002:a05:600c:4e14:b0:45b:86ee:415f with SMTP id 5b1f17b1804b1-45ddde8a741mr192478245e9.6.1757578646277;
        Thu, 11 Sep 2025 01:17:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870cfsm1513658f8f.19.2025.09.11.01.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:17:25 -0700 (PDT)
Message-ID: <bfeb8af7-62d3-4dc6-903c-b6697c5ef795@redhat.com>
Date: Thu, 11 Sep 2025 10:17:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
To: Jane Chu <jane.chu@oracle.com>, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250910192730.635688-1-jane.chu@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250910192730.635688-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 21:27, Jane Chu wrote:
> commit 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> introduced ->pt_share_count dedicated to hugetlb PMD share count tracking,
> but omitted fixing copy_hugetlb_page_range(), leaving the function relying on
> page_count() for tracking that no longer works.
> 
> When lazy page table copy for hugetlb is disabled, that is, revert
> commit bcd51a3c679d ("hugetlb: lazy page table copies in fork()")
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
>    1. warn against PMD sharing in copy_hugetlb_page_range(),
>    2. fix it.
> This patch opts for the second option.
> 
> Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
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

I think you ignored my question to v1 regarding the change of comment.

-- 
Cheers

David / dhildenb


