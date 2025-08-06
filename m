Return-Path: <linux-kernel+bounces-758304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBFB1CD64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E79F174854
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DB21B9F1;
	Wed,  6 Aug 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afd9eIxc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E61EFFB7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511697; cv=none; b=EiMQDfsNWMdgrPaMCgA3lBFjMyo5H2rEox7j4YzQCYQQ3cAzi3gd2ofP8uDOBOpar1lII/W/bQWY4mnwyOvatDummchxoeO1rnHOEOjcj0tTEwWRsMF8BoUvxNIzYyB9hCqAKiwsBCXKfp4onsJu1fNl+HfFVdhCx3Q0W7SLJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511697; c=relaxed/simple;
	bh=tUxVY2un84plNGc0k5hdFTI5nut0oV3TwVMgtbTNrwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYNQ7qH/WW8Z3hkxzk7HBe9ZHQLLganx0DAl1jBqfCKYZZUxYZuYXbOfM/sbIx2jR1T2yXhicR7cL/kehGnzvCZAEgpvnkoCECaUUiUNBFJD2PWE+1e+pmMzDTsR1aSiXlHp3KfrG9HyjMG2h3x2FeQA67IUBjrRnchVc7QIwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Afd9eIxc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754511694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lq3p/AP2ehM2TE8laSRpSoByadMgmXpnPOPj4urYp8A=;
	b=Afd9eIxcvlYSCoYiNGR5rEuFmGRcYrb6QHFu410jtDbrFAoGGQ4gLpOuqj4ZVX94+Mp4An
	USUilEKScsWhDTxO53EPAAyiK1R2P3hZA9f1MzyD+SIeBWr72UK5T0DNPs2MaySKqG+dUt
	tYuiZ7Z8AvJSdNNjLecgccd389cCpBI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-DteoeOlDOyW-_uE8ltn_zA-1; Wed, 06 Aug 2025 16:21:32 -0400
X-MC-Unique: DteoeOlDOyW-_uE8ltn_zA-1
X-Mimecast-MFC-AGG-ID: DteoeOlDOyW-_uE8ltn_zA_1754511691
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e4b85895so1295245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511691; x=1755116491;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq3p/AP2ehM2TE8laSRpSoByadMgmXpnPOPj4urYp8A=;
        b=M6xMiwAxOAvvYRVTwjlC1+A06nikFOZuh2X8Ug4/YUnTDwRVObuExI9dOnfAmVUBkE
         J3w5QrwxCiQj2rDf/zWNvzAoAzdpXusT5N2BPmicmc9kiwVCgtMfHDqNs1Vbx4oz9ua4
         6d1YQCTQhWESjmzEi8JEdh5Wafz0UXzZdX9DvdkJeN33SDtmxM5VuyVbCQcQFDbx3oX8
         3+4P5ucyhN2PulL6N8lslTscRw1XEZYV+qkEnZ3p2WQTMZeT52kr/TsOJB9weI110y/F
         8OVOtoYYslXzS0K9f6S5dIiUnVL58jhkJfpb2cjteG5IuOwMsKLVc4I/uGdkeUjOL4LM
         hmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEcRmkuvHZxsm0b2kzShYjPBn55W2iooRHPVXc8gXE2BiAjA84p5OWf4Onw/90uoI63hAgc8OzKdUzy6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+jafR+G6efVazO2xviDHv/GjKDHko6fRIdfHbvNBf4C6bVvP
	g0pHkYbPXw6nUgfg8ORWUialh5yp8TYIrZI1lWawrHLca8oWXNQeBqSrEG6csjSz2n+E06bw/ba
	xgmzVNWC4DnXDA9MGArSP2mnXNiXvxoC/OMilSulf2Qli7sVasL0HbZac8p7bPvvJyw==
X-Gm-Gg: ASbGnctsNwTvhzcswC1Dlt42YPja62lHCX/vJf9PgxwD1sL2XiZfpRe+0cKIlyDB/4t
	MvYr45XXj0R29vNhehjUu/6rkPRnSnl5doe6mtyBcYlotNf5E4IaUjeuUmp0awbKIGN80qmO79G
	Hltb5uWOYe2nJb+tGsIPZKg2/vmj44VfdClSGdw6EDuRWUQfx7uOAtzrx9n7pQLfrec6KeO+X9l
	Gfwpem269Y47lec7Bc4fCswz4SJvqymfFRNwP/264EpA7QFPh4z4ZCzqDY1aUJRNx8fp0ErqMvQ
	g+D8ttEiYFNdH79fJODD1d3pg5Y7tHE3Ycc+/mO0IOgBjONLV5qspUlsOiuAP/uQB0Od8RaNNCV
	jbUBPKQQJzS6WaKu/F6oUaCAIlvE+Ej/ajaBx9j3GCcFV/aFVu3xCq+CryVOVlGFsaHo=
X-Received: by 2002:a05:600c:46c8:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-459e748fbafmr42832645e9.17.1754511690833;
        Wed, 06 Aug 2025 13:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz9L54Y8dv3ZQQQ5zpImfkqY1bGBCy7DJowT7QpPPwDnagA1P2KPKg47yvDFrtnPzdqTms+A==
X-Received: by 2002:a05:600c:46c8:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-459e748fbafmr42832425e9.17.1754511690266;
        Wed, 06 Aug 2025 13:21:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:da00:badf:cc55:23d5:1679? (p200300d82f42da00badfcc5523d51679.dip0.t-ipconnect.de. [2003:d8:2f42:da00:badf:cc55:23d5:1679])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bbf91b69sm106335825e9.3.2025.08.06.13.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:21:29 -0700 (PDT)
Message-ID: <0de8d37e-5977-43f4-8e21-0ad47130d62f@redhat.com>
Date: Wed, 6 Aug 2025 22:21:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes-unstable] mm: Pass page directly instead of
 using folio_page
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com,
 syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
References: <20250806145611.3962-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806145611.3962-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 16:56, Dev Jain wrote:
> In commit_anon_folio_batch(), we iterate over all pages pointed to by the
> PTE batch. Therefore we need to know the first page of the batch;
> currently we derive that via folio_page(folio, 0), but, that takes us
> to the first (head) page of the folio instead - our PTE batch may lie
> in the middle of the folio, leading to incorrectness.
> 
> Bite the bullet and throw away the micro-optimization of reusing the
> folio in favour of code simplicity.

Huh? We are still reusing the folio. There is a single 
vm_normal_page()+page_folio() lookup in that code.

Maybe what you meant is "Simplify the code by moving the folio lookup 
out of prot_numa_skip() such that we only have a single page+folio lookup."

> Derive the page and the folio in
> change_pte_range, and pass the page too to commit_anon_folio_batch to
> fix the aforementioned issue.
> 
> Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
> Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")

Fell free to add a

Debugged-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


