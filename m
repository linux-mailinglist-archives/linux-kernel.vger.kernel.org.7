Return-Path: <linux-kernel+bounces-831070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64289B9B6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF892188E971
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E18238C23;
	Wed, 24 Sep 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4NG1V3j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31C28F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737758; cv=none; b=mq2x8pILhkgNEA6o+fMWz9ue3AG7tZ9XCjM8TImBsHa+uPgPiq8pYGLwu85uZD5s/Lc8i0cyXdnIN+DbgN2w/Z2QJqy8VQ1i2U9d8/pEWhyIKqoZe31qcN0OKMAyrgBEYbnZDvYB4+K7FLrTvHMpcOxw7A07vOYXorfCpkquV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737758; c=relaxed/simple;
	bh=pgqs5Ay6DVcSrnEvPattj0BDmX7YbOgW6e4yaI+T7/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm6h90ZeQtulg4vr/ayRyhA7T+NeRUpm2FN9NK1FOmNXQK3zjBSEC2EpWvymbygL+vPKu7yg00r7wXOhTfKffgLB2JqPqkZVbzc+L3EiwS1umPc8n62mpCxmuS3k079418BijG8Yx37iWd+cnvDzDwuRukbu/Dm2YnPjstEJIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4NG1V3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758737755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D5GCmu/y4XizTk8YGFlDNXswrxzNbODJ9T4sLwRMNCY=;
	b=d4NG1V3jFD6LorDJGfK0jOblZsBq3aD8RBswyjbsIyZXxaV8UMp1SVd2juhQtvLpNlG613
	HE+YqmBdAgYtkUX6EBzTb1dSWPorr9gE065Lpb94Dw2BwcLU9ISs5ea+jMF5VeTOdHgDEq
	XifkBY7bIdwLfvJ3XI2AiuB6A70ZXv0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-01m_fzT1MuSBJnglIwLMLA-1; Wed, 24 Sep 2025 14:15:54 -0400
X-MC-Unique: 01m_fzT1MuSBJnglIwLMLA-1
X-Mimecast-MFC-AGG-ID: 01m_fzT1MuSBJnglIwLMLA_1758737753
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso95227f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737753; x=1759342553;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5GCmu/y4XizTk8YGFlDNXswrxzNbODJ9T4sLwRMNCY=;
        b=LhBOWTdmUZ+d4+UfCHsCYI5+vwzctBCxeHA26JZ+Eari6QrRwYtSQ71J1XKCsdmiCg
         TD4LHQnQtznsckZB6C5PZNpPfJuLoeL/5bu4PSuYhKb02y9bN1j+EuPofrpnoahbkN3h
         xtIlKmynxPyjV91F1PdR/4g3LT2d4BppYYiZii8xszB8JHJSJ8L0p3Xh1CJhGqCCZZfV
         icBjyTOGZ5ZYJ/uMx10kKxmQrIG9sF/ZIJEYaRYrvVvo3wbJvNbfAlZ/sgTZ1TktxPFf
         C8LPJwykl8MwV+4uWMtow1ba2L5OI0mMrjq5zg1eY6ErCvuMyLgtzo6ApxdzetBpYYzq
         RfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIcvttca3rbF9juAMv8OBbhueuXMFIbjryiqRtTnzdLF5a1BGXnZRwMs1yQIvFYJ1WO3x9w/G8SyR2vuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6qto/hFRWC6wNvEgFh5eWyKkWtqbAIqfpiDyN3MjhEClxhMa
	jw7Vxcv9xjkvQPOPSZRZ4Za4Iubf7HMD0FceXz8DzkqxoOh1V/wRkLpMzTzbVbicAiAhJoE1dOb
	SwZdELdqHoGbmvMMPFibBZdoY7hUqIpd5EbXevXyqaZ4s/5ADtWCVp2u2VvMgIWsJ7A==
X-Gm-Gg: ASbGncsc3h2uHoaUmsK5KJS0F2ILx+2tOk4+hme9ChSDcAkO9yI6GRIFU4ff8Udvaf8
	d8esZm/S2DS0FR8Ti/MW+AyI9Q3iKXMrHfHDBoUvry99GHh+AA91pEb3FonRqS/RfUPAnXd7ACj
	Kiar1tDM/rrhi+FcC0Gq9w7KjzVW0WM9RZkeynJV0StJ/Gl7lbX2iDDYJfdDLTcTtgi3mrfahrw
	SnIGfQhSRk9TMvNfKc31NEtd3JvF6FnpcDj7lZmP6DK459NqpQTjAAnZZ+O9MmWpEh8l4QtExAK
	FMqQPupp9Dbup9fowMCkjB6gUDNiR0jWLlwrAnDaSqDfkaTU7hTouyHmlUcBH7SSqn0UEQI2
X-Received: by 2002:a05:6000:2284:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-40e4ff19bebmr824909f8f.46.1758737752845;
        Wed, 24 Sep 2025 11:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZdDp+BFhDVtrTjfLVZ6x4IdbV8pP5igjFYnLDvyjxlGAktmd1iZfdHRlX9DtqxmZchD6BQ==
X-Received: by 2002:a05:6000:2284:b0:3ec:b384:322b with SMTP id ffacd0b85a97d-40e4ff19bebmr824888f8f.46.1758737752403;
        Wed, 24 Sep 2025 11:15:52 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a5c4.dip0.t-ipconnect.de. [87.161.165.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm29256281f8f.31.2025.09.24.11.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 11:15:51 -0700 (PDT)
Message-ID: <ec4070bf-f1de-450f-8b8a-2f130226b9da@redhat.com>
Date: Wed, 24 Sep 2025 20:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm: swap: check for stable address space before
 operating on the VMA
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, shikemeng@huaweicloud.com, kasong@tencent.com,
 nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
 zhangpeng.00@bytedance.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 20:11, Charan Teja Kalla wrote:
> It is possible to hit a zero entry while traversing the vmas in
> unuse_mm() called from swapoff path and accessing it causes the
> OOPS:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000446--> Loading the memory from offset 0x40 on the
> XA_ZERO_ENTRY as address.
> Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
> 
> The issue is manifested from the below race between the fork() on a
> process and swapoff:
> fork(dup_mmap())			swapoff(unuse_mm)
> ---------------                         -----------------
> 1) Identical mtree is built using
>     __mt_dup().
> 
> 2) copy_pte_range()-->
> 	copy_nonpresent_pte():
>         The dst mm is added into the
>      mmlist to be visible to the
>      swapoff operation.
> 
> 3) Fatal signal is sent to the parent
> process(which is the current during the
> fork) thus skip the duplication of the
> vmas and mark the vma range with
> XA_ZERO_ENTRY as a marker for this process
> that helps during exit_mmap().
> 
> 				     4) swapoff is tried on the
> 					'mm' added to the 'mmlist' as
> 					part of the 2.
> 
> 				     5) unuse_mm(), that iterates
> 					through the vma's of this 'mm'
> 					will hit the non-NULL zero entry
> 					and operating on this zero entry
> 					as a vma is resulting into the
> 					oops.
> 
> The proper fix would be around not exposing this partially-valid tree to
> others when droping the mmap lock, which is being solved with [1]. A
> simpler solution would be checking for MMF_UNSTABLE, as it is set if
> mm_struct is not fully initialized in dup_mmap().
> 
> Thanks to Liam/Lorenzo/David for all the suggestions in fixing this
> issue.
> 
> [1] https://lore.kernel.org/all/20250815191031.3769540-1-Liam.Howlett@oracle.com/
> 
> Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

I assume we want to CC stable?

> ---
> 
> V1:
>     -- Checking for xa_zero_entry() instead of most cleaner way of
> checking for MMF_UNSTABLE
>     -- https://lore.kernel.org/linux-mm/20250808092156.1918973-1-quic_charante@quicinc.com/
> 
>   mm/swapfile.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 890b410d77b6..10760240a3a2 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2389,6 +2389,8 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
>   	VMA_ITERATOR(vmi, mm, 0);
>   
>   	mmap_read_lock(mm);
> +	if (check_stable_address_space(mm))
> +		goto unlock;
>   	for_each_vma(vmi, vma) {
>   		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
>   			ret = unuse_vma(vma, type);
> @@ -2398,6 +2400,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
>   
>   		cond_resched();
>   	}
> +unlock:
>   	mmap_read_unlock(mm);
>   	return ret;
>   }

Yeah, this should do until Liam's rework is in.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


