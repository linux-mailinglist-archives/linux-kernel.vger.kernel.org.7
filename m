Return-Path: <linux-kernel+bounces-814545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C913B5555F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437DAAC54C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A02322747;
	Fri, 12 Sep 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um7vTKv0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869F38DD3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697236; cv=none; b=GkAEuz/NI39awljFA/HJLbBCPCycZevme20EUJe6UITA1GKPx34aAIRMC+zlS/YnzXgawxFyr3M1fGZFm8Wvk4rfElbnd9G2l+LKM0W/Ki9l8kv4BWUUx3FAozev+lyX/eWAVDVugEj9s4zCxnEYV47ue7eEVAULvTgJLQwFzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697236; c=relaxed/simple;
	bh=QCs0PPcYIyjywUsc3kOUXm/XboCxG3sNmvjmOli93PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyDumWG9WBcjEYIDdQz80TaeBFDBMnCMvHehMohoLfHGZb2atCNlDpzAQ/6WdrHo9wJMUtLwCXQBo7dKeD7C5gwxmD8WxgHaePejU+agCeZb1q/S3B4SwupIJnKqBeBSo1gEZpHO5R8F0oufu0NfsBbxB80QoSScLal/a6RzgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um7vTKv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757697233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2YALunsK4g8WkzqephiUqE2mfLk4sdPgr1rQwcgrz6Y=;
	b=Um7vTKv0uU4UYUlO49TJ5YPAqy74EmoK8fYI1znjRoZT2/zJ3OP0V7ZVDFKqstKujO4Q4V
	IYjEX1Mf7Ga1cI6/9u72zff07ANVIVIQ9mfWagXbOMvbKSDiEcDnK/QHs8ZoCGFeZNGvZ1
	rWPCxRVmspfhp5THnbmuQO42XRztT34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-Q8KqO75ZPhSJ5AE8JM6iLw-1; Fri, 12 Sep 2025 13:13:52 -0400
X-MC-Unique: Q8KqO75ZPhSJ5AE8JM6iLw-1
X-Mimecast-MFC-AGG-ID: Q8KqO75ZPhSJ5AE8JM6iLw_1757697231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e3f8616125so1986634f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757697231; x=1758302031;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YALunsK4g8WkzqephiUqE2mfLk4sdPgr1rQwcgrz6Y=;
        b=sW0KvVG9eUZn0X4id/mHla7flr9fqRUOk1dB9PC17ecqtrKt9S23cTqVFjUkhV7oiG
         JoDAXy26Dhro0L/XcuuT062Kyei+lZPB0Oay/IkIPj0Ig8CIFwWxqti/7Zh+tlit8sgm
         JRst9o36xD5fLTFb3m4J1XMR+Zia2jhahVEcD0nYcJqHhluD3xSWJB51MFjlKbd/wDYN
         LaJzXYL95Tzstg2M6JoT92ecCpCOVHLuTejypMUVa7pRuua5iWid6CnS7li5lzMkC9ir
         KGgylp71Ut6291KLWy5stvQQl9Mwn7nbE6g3SHBLIPmsezvln3DD/JVQ2wKMOGIN11fN
         Z+pw==
X-Forwarded-Encrypted: i=1; AJvYcCVeeMKdj9RNvLudYvtey3S+jB367COlqOG2j5z61P3o43sNJoP8556kPJH7enHkRplojGBfmrOZ2gU6lHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmBR8RTefmIsPtJcA5N3KssaGQcyYMQARCoIW4vLtjN46OxGk
	oF5l7iek8QIhr9QRNZfc5+SMNrPpN0XveNLCIeSS2/PtUx6H2uWviKXneiO1oH98NySJWHemesg
	SV2PqI0VGCjZsNSKKGel9Yl8J3mrMgBBONqYSLeUP909ic0X/RrY9Zuc+XrKVfWM7yA==
X-Gm-Gg: ASbGncvg6g00CYqZHn0n7YIp0RjYV8F/Xd8NvSGrjQ12pBJbBD+n/G6aF2cUqGPRFrv
	rxl//NyL+xB94a6bOpSzcitONEBFERt1vGSylDu5jkSiGC8gYSNAu9+JHJUuOruw90gq43uteS0
	q1LDyH9Dr+j6FZgrY6RkBPfDLmVMf6q0YD/88EjzF2WYyDKSI7f7JUS9ZrgAmACM+d20twhKOfb
	kqOCY3sZ8E9l8pwkYvHE4TXTJWLa3H+8GZxpV/vwCzpW1vD9D9Jqq/PyXFCywoWre5oevTu4iqF
	t0ZdPya+uoJf7qg0wFyhYNUpYw+FaccBezmzF6SNZ8tI9uVhbEIRtD2si7AHeR8fCyrhgRTbUzt
	zef8UUIfqAEmGtPj3rZxVWgjP42JJNzzTdRUTdIxWEchPfhZrEQkSW+fkNzvLnOdPQvw=
X-Received: by 2002:a05:6000:1ac9:b0:3d9:a7b3:1b05 with SMTP id ffacd0b85a97d-3e75e15c1admr6736601f8f.25.1757697231116;
        Fri, 12 Sep 2025 10:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdRuP5+++u4mPF1dSEU3FtB9l/UJjeEm9l6i0OeSGdideE7lj1C8hRYAaMPCus2MbDdEb7xQ==
X-Received: by 2002:a05:6000:1ac9:b0:3d9:a7b3:1b05 with SMTP id ffacd0b85a97d-3e75e15c1admr6736578f8f.25.1757697230633;
        Fri, 12 Sep 2025 10:13:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e766659ea0sm3822008f8f.43.2025.09.12.10.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 10:13:50 -0700 (PDT)
Message-ID: <36bf71ea-f6aa-42fa-9fa2-53d00f351777@redhat.com>
Date: Fri, 12 Sep 2025 19:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 18:58, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
> PMD page table is installed or not.
> 
> Consider following example:
> 
> 	p = mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
> 		 MAP_SHARED, fd, 0);
> 	err = madvise(p, 2UL << 20, MADV_COLLAPSE);
> 
> fd is a populated tmpfs file.
> 
> The result depends on the address that the kernel returns on mmap().
> If it is located in an existing PMD table, the madvise() will succeed.
> However, if the table does not exist, it will fail with -EINVAL.
> 
> This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL when
> a page table is missing, which causes collapse_pte_mapped_thp() to fail.
> 
> SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
> collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
> tables as needed.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

Makes sense to me.

Is this something we want a Fixes: or even Cc: stable for?

I assume it doesn't really happen frequently, but could also happen 
after MADV_DONTNEED'ing the full range with pt reclaim I think after 
having faulted in some PTEs, for example.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


