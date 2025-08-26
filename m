Return-Path: <linux-kernel+bounces-786731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435DB36674
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5808E80B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CE21ABDC;
	Tue, 26 Aug 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzdTxeI2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEC343218
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216073; cv=none; b=ZsFNr7zpzzWzeZ1K1WcUge1E+vmPpp9B/r5LKqj5rYLBghP3vySj6nMrYZ+aLrzQ4ZiKnX3I25MtrkZllTnzruAq45C0m0u589EC1NMTAR2g5jKDN1zh7XfhebszXc/MCm0dJcrKlzmAY0ME7pUgugrc1TGBCOzAiNYVSkRY2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216073; c=relaxed/simple;
	bh=ca5ZoltKL4u7suH6w/84wUwVz2luhJxy8t+NFtDa68Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ps5SGGUfT35O593FmBSfinT062+TKIl+OdoIwS7AQ7Kh/G80BZoVhaB7UEj+8arwZhnjBLAKQJurCf4HMnMZxf/ZNERXgUWtLbaXHpaGgU8vmZeT3UfRSVt9rx8ptpAqTBM5QpOCNF2zx+9ajBKSH57uXEizuFEgKpUEUSchVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzdTxeI2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c69724519fso487786f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756216070; x=1756820870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24J6yGBtDmQ7nphXpNVoNww4k8YjsT123AiAm7QWPeI=;
        b=gzdTxeI2hW3KJH3hXcr96TtGQ7yd4q21r/PhFbMXACggGve5t+JRvGpK4JEZmMOVit
         G+1Tx8+JIu0WoNMt6VS+4aUMoK7DOrL1bUiG5OH6L0tB+DWH4jo2T1q7i+GtbslehVAm
         928dk5Vxo1aj7YBR6axEk+yZLnglqrrlrRH71W5OuJ7GfAka8cBSHKZXEskz9KhNHKwy
         VYh/p4eXcln1G0bqEZi9q/6R6Za9x/HBTjzQ2YlCZj/PIzPEZhXp9oTLIPGFZNWHHBuK
         cwaUedF2Kc1GNhGZa8yrZIeD8M6yekhZBmzVWQvWcszLl7SNV0Y1k6Xuoc0UmhEQu8FH
         d3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216070; x=1756820870;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24J6yGBtDmQ7nphXpNVoNww4k8YjsT123AiAm7QWPeI=;
        b=nebYN/iMv/2fM2fl7ca9RPWZZ6LCsc75IFveAEXM6fkGEbiGWSrP+VaB50CkKQNS1g
         rj0YsFRixMvz0wvNsk0PUiGI381Wrx4HRVI0kZ3GC+X7cH+IwITta2a1L4XvBOlEbgQl
         OZSRPfvzVZNUUdY+8USaajWXs32bM+VTZiiSy6Mpm26S9XvXJ0bhFkKi+QlaF8lTcXuT
         q59extOuLqsbaLk3+Yfm2UEy2MhHvTSWhbTH0edorpV5ioCnU5Bg7uKBfiPUscIO2PKe
         oIQCM43gDczl3e6354L3Yo4rgicY6Q7afapjy7Dvjsi6ce/I9uD3kc6l10fpXsA4xa/u
         j6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXURluqcereCzD5tVrMzdF/NtmtsZ8vkTrV9nzaDJyljMWwTMbX8IXfd4W5VyF6OqoZ3KK262aY4lo1In4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzCYf8ReIh8ysiEqXbzBz8FIEGYxDp3Nmx8IQYA3ilUGT/BOS
	/u7jYknqitNIXaOJ60gJg4303Y43Cdt0yBc6lRW0hfnirP2wBtdsWXBSvifaixtRZiI=
X-Gm-Gg: ASbGncuu1p2oA+2MK8U1MXR8RleAQXlBNL7G355nGJw/+CTA/UlSPwnIl9Ts0MtigGu
	cZzMRr3OrHRcxZQ2sfqJyq+mcLcjsw3WND9OH0CHYyKUMXQO11vZWclYTHJimd7kAtLBrpjyb1c
	Ob940MRd5/Q5jeosIpdnXrH+YMlTGUT6zlE55FK1bIQjrHk2CW5zEXvPgV3izynojZevTEKjaPd
	Omqrh1P/E2uX+SBnyzqgHPzZUfZ4UqIGUfePEGGUNXe3+T5a4+tbMIlAClqn66VBMFHyTABMsvs
	pKajBxGmRjn6w7Oz/ZxAtVpMjdnA1eDA1ZxiNTJpYiw9F9Pp/inyOVM92aCbtwyEu8o90Cs0STl
	QfLOQk4xVsDFIl6dYonXGJrFNv/3WlsUIaXeVROaXeE8fu0yr6tpz
X-Google-Smtp-Source: AGHT+IGrapQhlq/k0mOQIOwdRTN+F/YHP/gq4qPni4dyohc6q+HMjbgpdtYQibl5r+Hbnhmd8Voxgg==
X-Received: by 2002:a05:600c:3487:b0:45a:2493:fcb8 with SMTP id 5b1f17b1804b1-45b517d4d15mr71555845e9.6.1756216070093;
        Tue, 26 Aug 2025 06:47:50 -0700 (PDT)
Received: from [192.168.100.5] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ea81d38sm16875933f8f.17.2025.08.26.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:47:49 -0700 (PDT)
Message-ID: <512764a4-611c-42d4-8b4a-2aaca4e519a4@gmail.com>
Date: Tue, 26 Aug 2025 17:47:47 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: donettom@linux.ibm.com
Cc: aboorvad@linux.ibm.com, akpm@linux-foundation.org,
 chengming.zhou@linux.dev, david@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, richard.weiyang@gmail.com, ritesh.list@gmail.com,
 xu.xin16@zte.com.cn
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm/ksm: Reset KSM counters in mm_struct during fork
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What if we only allocate KSM stats when a process actually uses KSM?

struct ksm_mm_stats {
	atomic_long_t merging_pages;
	atomic_long_t rmap_items;
	atomic_long_t zero_pages;
};
struct ksm_mm_stats *mm->ksm_stats; // NULL until first enter

static inline struct ksm_mm_stats *mm_get_ksm_stats(struct mm_struct *mm)
{
	if (likely(mm->ksm_stats))
		return mm->ksm_stats;
	return ksm_alloc_stats_if_needed(mm); // Slow path
}



On 8/26/2025 4:49 PM, Donet Tom wrote:
> Currently, the KSM-related counters in `mm_struct` such as
> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages` are
> inherited by the child process during fork. This results in
> incorrect accounting, since the child has not performed any
> KSM page merging.
> 
> To fix this, reset these counters to 0 in the newly created
> `mm_struct` during fork. This ensures that KSM statistics
> remain accurate and only reflect the activity of each process.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   include/linux/ksm.h | 6 +++++-
>   1 filechanged <https://lore.kernel.org/linux-mm/2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com/#related>, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h index 
> 22e67ca7cba3..61b8892c632b 100644 --- a/include/linux/ksm.h +++ b/ 
> include/linux/ksm.h @@ -56,8 +56,12 @@ static inline long 
> mm_ksm_zero_pages(struct mm_struct *mm)  static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
>   	/* Adding mm to ksm is best effort on fork. */
> - if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) + if 
> (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) { + mm->ksm_merging_pages = 0; 
> + mm->ksm_rmap_items = 0; + atomic_long_set(&mm->ksm_zero_pages, 0);  		__ksm_enter(mm);
> + }  }
>   
>   static inline int ksm_execve(struct mm_struct *mm)
> -- 
> 2.51.0
> 
> 



