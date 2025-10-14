Return-Path: <linux-kernel+bounces-852822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95DBD9FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5639354B55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3B274B3C;
	Tue, 14 Oct 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+uYGCQR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFF347C7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452200; cv=none; b=rVCghV4ajkX2qA1vX4S8Hfhn9rxs17eL+nMA75l0+fxJy3Nd6UUoLWnaMqp0oqZrpQ5KUFVI76ijuhdllna3MAgoA6VjEY0wRfdxqN22pN8IOnclhvLgnyZD/Cy33PwpYeLvIdVH0frZD8NijLyxHeWRSJLrxe5w0UbsApMsxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452200; c=relaxed/simple;
	bh=76dicc6szxh1p+s3M12Nx9zbHWYCpU1ZVPlTcEImA5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN3PmgI27R+O/Gn9b/A3CqSXUiCo7wXYZm/CydI1jft6wVyQPwRXZRGWVK1p2O++u2B8Oeu78a4OF4Dg4sbH6QoR6DGY6bRr10IodfL5I/uJ1nVY/WYIOy+4rHZTtPyZMwmI/gzG+WUcrkYkmUlUhgm4ZYhZrigvDOUSqhivrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+uYGCQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760452197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UFKPyi7QTrUFRgjRxc+KcY0otJ1gluh+WRQjU9bwR/w=;
	b=Y+uYGCQR4pg+qlI4EfWPuUctVsCAtln44HDpRMtY1LyUSNfgDekZeXebUGjo7VwMzKQLFL
	mg26UdKXy8PZrOuCtjiw8/zOqlmhjOKQOOGJf6IA9zoasvbY+lOCrhc53XA8u0qqUxl3Kn
	jo4qM0O1Yk5T3WQArF2GN83dRA6vnqc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6y1I_OBPPwOgkbfv2Pd9Gg-1; Tue, 14 Oct 2025 10:29:56 -0400
X-MC-Unique: 6y1I_OBPPwOgkbfv2Pd9Gg-1
X-Mimecast-MFC-AGG-ID: 6y1I_OBPPwOgkbfv2Pd9Gg_1760452195
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso3179050f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452195; x=1761056995;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFKPyi7QTrUFRgjRxc+KcY0otJ1gluh+WRQjU9bwR/w=;
        b=NK9k4a2CC5aHEm10vNEw/r1Bcj4J9tDKK4IlKq4yeUtlXDCTkvOa1CyVbloxTcbz3n
         Y8/lk7a7qX/uy6sS70zFlNSRhhpgUMYaZP5f77QN09psyhayX+B32ZzYiv3KGQYvjTkQ
         e2dI3nIfEo3rIz6yeryt/W+aOg5z3HJ8hu8ww+MqkQOaYKANBvyw6w1SAVsb8KktHFv2
         aD3kF7WL/SnSArQdg80HdM+p7kWHw8u1svtFnnEqLTOaeh/f7wg0ERb4xCiLCCpJ2BMY
         7ymuOIzEn9BtrgfKb4J+gemaSiFvRTYlz26K8gYWArtHdOvbg4bKGq6/VmdXNtTa4QX2
         oN7w==
X-Forwarded-Encrypted: i=1; AJvYcCXm0hpKv/YA2dkbc527gj6qNvp/YdzaXPakMyk+tttdXDYGP+9pblM2GU8VAOHofY347TEkSJsihXsv0UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GqBcEsfL50M+Yo88QlTQKdIIDZb/yklmPnnfVcDhtm4gSW82
	O/FzsGB26MY9EeIAceFI6gb1xzK4ifriCF/v7Ixl+UzLuAacsGp5qEIQgKH+BRkD4hWf1jxHNaU
	s5q7t3nUAE1tbHwkzAnO6l4Pwf/yCW5F3DVaT6yljPiwkTWWoA1elIEpw7S+Jo6mmTg==
X-Gm-Gg: ASbGncv/zPH4FfzFePYS4fFEMTTssFkVfliwrziwH9P4i5rj8IFQpsQSbMjqiwXtEUQ
	tTAhCm2TOKSKETmh9m+pBhqZieae/gtrd0MQN2xrqQP1vMaH+Hna3Z2zbpywnvPKu5TnWNVvsvc
	aLuWdERGT2OqxLXkAyFwFxdOKWJ1uKjnaJYZRT/zwr31pKbe1GLEcG6mlQrRYMHSxddosgmF2E0
	iluIzAQ657vjmuEd+2ipYCqRtNJ9PuWpiL+dtxKyyuPVIw0QNG8Cn8WvqGwvas5CfnjwG+AOOW/
	kjawDodYjY8AWdF+AHbl3tNT3JumRqcU6BG2NlE6BJCNi82KI+nRbKhslYG9KLgOeDP3iQb78g=
	=
X-Received: by 2002:a5d:5c8a:0:b0:425:8125:ac79 with SMTP id ffacd0b85a97d-42666ab97f0mr16064623f8f.25.1760452194819;
        Tue, 14 Oct 2025 07:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFCs5Uq2bjb6FBvbszcIDA1BGaWI1fo3lzZMSqgsmNNAwQgGoq2mX9mDWZ9CeSdVoO8ANTMQ==
X-Received: by 2002:a5d:5c8a:0:b0:425:8125:ac79 with SMTP id ffacd0b85a97d-42666ab97f0mr16064596f8f.25.1760452194295;
        Tue, 14 Oct 2025 07:29:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cd658sm159792605e9.1.2025.10.14.07.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:29:53 -0700 (PDT)
Message-ID: <83d15ab9-55bf-4cd8-8b3c-007253dfc175@redhat.com>
Date: Tue, 14 Oct 2025 16:29:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mm: prevent poison consumption when splitting THP
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, linmiaohe@huawei.com, tony.luck@intel.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, nao.horiguchi@gmail.com, farrah.chen@intel.com,
 jiaqiyan@google.com, lance.yang@linux.dev, richard.weiyang@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <20251014141935.1878315-1-qiuxu.zhuo@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014141935.1878315-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 16:19, Qiuxu Zhuo wrote:
> When performing memory error injection on a THP (Transparent Huge Page)
> mapped to userspace on an x86 server, the kernel panics with the following
> trace. The expected behavior is to terminate the affected process instead
> of panicking the kernel, as the x86 Machine Check code can recover from an
> in-userspace #MC.
> 
>    mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
>    mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>    mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
>    mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
>    mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>    mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
>    Kernel panic - not syncing: Fatal local machine check
> 
> The root cause of this panic is that handling a memory failure triggered by
> an in-userspace #MC necessitates splitting the THP. The splitting process
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC, occurring before
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
> 
>    First Machine Check occurs // [1]
>      memory_failure()         // [2]
>        try_to_split_thp_page()
>          split_huge_page()
>            split_huge_page_to_list_to_order()
>              __folio_split()  // [3]
>                remap_page()
>                  remove_migration_ptes()
>                    remove_migration_pte()
>                      try_to_map_unused_to_zeropage()  // [4]
>                        memchr_inv()                   // [5]
>                          Second Machine Check occurs  // [6]
>                            Kernel panic
> 
> [1] Triggered by accessing a hardware-poisoned THP in userspace, which is
>      typically recoverable by terminating the affected process.
> 
> [2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().
> 
> [3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().
> 
> [4] Try to map the unused THP to zeropage.
> 
> [5] Re-access sub-pages of the hw-poisoned THP in the kernel.
> 
> [6] Triggered in-kernel, leading to a panic kernel.
> 
> In Step[2], memory_failure() sets the poisoned flag on the sub-page of the
> THP by TestSetPageHWPoison() before calling try_to_split_thp_page().
> 
> As suggested by David Hildenbrand, fix this panic by not accessing to the
> poisoned sub-page of the THP during zeropage identification, while
> continuing to scan unaffected sub-pages of the THP for possible zeropage
> mapping. This prevents a second in-kernel #MC that would cause kernel
> panic in Step[4].
> 
> [ Credits to Andrew Zaborowski <andrew.zaborowski@intel.com> for his
>    original fix that prevents passing the RMP_USE_SHARED_ZEROPAGE flag
>    to remap_page() in Step[3] if the THP has the has_hwpoisoned flag set,
>    avoiding access to the entire THP for zero-page identification. ]

Two smaller things:

(a) Sub-page is the wrong terminology. We simply call it "page in a 
THP". So consider changing multiple occurrence above.

(b) You should probably trim the credits to something simple like

	"Thanks to Andrew Zaborowski for his initial work on fixing
          this issue."

removing the brackets. If you want, you could then link to one of the 
submissions from him. The details how he would have fixed it are not 
really relevant to be had in this patch.

LGTM, thanks

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


