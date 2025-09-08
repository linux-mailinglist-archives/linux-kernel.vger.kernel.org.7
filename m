Return-Path: <linux-kernel+bounces-806567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C6B49891
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D581B26089
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB531CA59;
	Mon,  8 Sep 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGzUMi/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB014315D25
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357137; cv=none; b=LXBlLyv+iwgThIkSto5iT/JAqMSHkQPcbZ98gduO0iAvcPgNPmwOJm6LBoBvV0kUQ8koUtAvqzQ4vo2Eg79n9ns/w7QhHVk7Rm5EJ4W/P4JzUazsm32ud5KfdHbeXz/TJeDZoWwZ6StW84PGOD1AVx1PDSEfgb7wlwt8ayn+5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357137; c=relaxed/simple;
	bh=u4634A0GpgrHa65LJw+AaevVl1eVSTRE0zlvp0/N79A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLp6DOowkU1El6yGNqkv1M6OG85JIrABJgOfgs6cUJWEkkR5rTA2uaAxiWq5Ii7AwcURGFuqjkOObG6LMwV6vP0sN062FKjhUGnZWONmV4dFPZsGzPg0jSN5c/4bLTTDh+ku6kthyLZfSuL1cSYxTXcYQDuAP+Zym/VK3b2QjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGzUMi/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757357134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CZ1U0+nto9ykqfQPo7HpxxJzqiGtL77TvIiUKaOMOeM=;
	b=eGzUMi/IQuJBO8SqQHIOzY2X8bKPZwsJSWotFnHOwu6hfReNDpqdHd/lgglp0OSFXzwdVb
	pIRYRUKbLKx9pTJrx9apsDAWvwcljqqZbFRjSuZ7g2kRIY32u37wPtLMepegQIDMvnKEOp
	0Nu4f2XMUa4M3svFVSuxPVdMs4gxkJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-5f6XAxEqN1eI0g2bmsDAQg-1; Mon, 08 Sep 2025 14:45:33 -0400
X-MC-Unique: 5f6XAxEqN1eI0g2bmsDAQg-1
X-Mimecast-MFC-AGG-ID: 5f6XAxEqN1eI0g2bmsDAQg_1757357132
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so38050955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357132; x=1757961932;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ1U0+nto9ykqfQPo7HpxxJzqiGtL77TvIiUKaOMOeM=;
        b=XaNCekI9ep/Sc006LEr8DiS+KZpbGAwF5FBh/7NQhH47pnmj3m7BxFzXaGlSpD/ZIu
         FXe9bRzR8p49CuUvivhV4cxD80PM7Wch/29evUKYy2P6Z/KDS7KQe4ui3A/yysqDKcbh
         /3KK66QZTg0zA7SOcRTlpEZu2lv66LPMUlb+RiZRe8LntqHeXZyg8NJVsvdktBilitKF
         ibLYgk3aY6GBQPe1ecbLrcJ4+DBEurtcbJ8hLIkJwtRhoGgWwq7leKJrCQSbBn+MqK4s
         W5dtvqCVJvl3qONybr4ZHDjfR4d/vDDX/l403lQ1SzNl/3nloMzUuDDKHo/wQho4204C
         UhLA==
X-Forwarded-Encrypted: i=1; AJvYcCWvFZGVnPtOgMoYlz57K5q24/ahcteUTE3Ta7VIoFDWArQidgJcVmuaLknc3w5uvR5GT27XN3jgiCFqJs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0Qx5Us+3anEKfl8Ng5e0TC4K//QXkRxAm6IenDnea/C57eXL
	s2Mqshg/8uHozgsBZBbdDEivKa4YAoM5VUpgfrsBmz+wC3zb2joDd4ZXzFN3f/UBxuscfTkD3gZ
	KHfkPg1JvI+hlblCV8TiXRMHYqjfXaWgm+S60pxGSwY5TZsfg6CHzesPeTlIFYGZX+Q==
X-Gm-Gg: ASbGnctQTEcqOn8cwJdkdv8be4nJQmSfMXHsc5lFC+dcNfoHDElUha/5AJoITrxByk+
	y+2aO0WraRyOMDGMatd0tUnAdMl7I/yk/fRVskey0vTYOCHu/Muj5n0gkGf7Ehz0gwOlV5yWtz/
	0+Cx+N4/3FobNBTrwkpJbZ/4fbVeiiNiDsr35S03Fo3nm96M/yJB8f1Jcsm9Rws+rhEElDG8Aga
	Dp0+09irngzI3uoCh5eLWOlAF+YdAPLEzi0M3gsMCHrEQ0mQgImEpwbTkRjTSmoHakQUf5glnrF
	LEi1ujhzVBziCFF0YqdwJB/tMnlPE+3omhF5oRfLyly2A12t8kxKwF8WKAkS9J5GqoV3FPL9Um5
	/dO38OrWMDm28dp8rcP1At55DOse57CjGBAzekcRBDLhiXlXiemkzkZjTZhBaYRFn
X-Received: by 2002:a05:600c:46ca:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45de072e878mr66056675e9.13.1757357132072;
        Mon, 08 Sep 2025 11:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl6W6PZgDJSOeT0hvE61lJkei0qub4EjvxomlpdB428UuZFOkk6zMkWPcWT58RiDXm1V4n4A==
X-Received: by 2002:a05:600c:46ca:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45de072e878mr66056435e9.13.1757357131588;
        Mon, 08 Sep 2025 11:45:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de5180623sm34433125e9.0.2025.09.08.11.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 11:45:30 -0700 (PDT)
Message-ID: <5c43116f-fef9-426d-8c90-1a3a129f3d20@redhat.com>
Date: Mon, 8 Sep 2025 20:45:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/22] mm/mshare: Add a vma flag to indicate an mshare
 region
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
 bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz,
 vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com,
 willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-7-anthony.yznaga@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820010415.699353-7-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 03:03, Anthony Yznaga wrote:
> From: Khalid Aziz <khalid@kernel.org>
> 
> An mshare region contains zero or more actual vmas that map objects
> in the mshare range with shared page tables.
> 
> Signed-off-by: Khalid Aziz <khalid@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---

Why can't we query the mapping instead?

-- 
Cheers

David / dhildenb


