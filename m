Return-Path: <linux-kernel+bounces-813818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB627B54B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6773B3BC6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2089301015;
	Fri, 12 Sep 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz3BmvmO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E22FF642
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676885; cv=none; b=uCSjzXSPdsIEUQyWRtUBmmOxF88k3tlp+ZlkwY3IsNBnONxVLciJmQ/KA3VECfysCbHPJ22tsLANJD7MBO89IN3u9pzTQrtzA1zkS/goi0lvYjXBSuypvYlexuZf3YR+WtS78jpMIFRU765SEokFm+w2OENgrD6fB5hWpbphm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676885; c=relaxed/simple;
	bh=2xByMI5F86FXQ/YNzPul1DNfvLb05F0F4wRGQQrq5Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhexrwrOJTQ3XGNcL8Uyr0Y8M9Wbk8yUMANr4Mv0QIJeGArZfIYSh8TwWoLKusG7MOFq/WthEPlzTXNr5ATtgq/2oCzOikv0v9yFgPzh7j1F4neBJhjBjMyOTV826AYiUQxQr9Yq/MkFGMUM2B+WBNiXPblheAoiErUIlSBeiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz3BmvmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757676882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZWd+C+6xlO7ZNnElus07Td372OLIDupg0E/fPHS2G6s=;
	b=Lz3BmvmOLHBg/6PtImScADLSvnkSvbLTJCj/a/WTlvF5gSQUuwTULUQcgYQPULlq0SSYXV
	KqkohEldUl7R36u4fvakdAiYm6vFbloC8I7Y+/SmMv6DaYufEgi7pvlCT3YYcYrvn2ogBE
	cDvzx9W0B/XKTWarrkWnKaKMXn0EjnM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-_TaX-sdnOkqjo1C1U2n2WA-1; Fri, 12 Sep 2025 07:34:41 -0400
X-MC-Unique: _TaX-sdnOkqjo1C1U2n2WA-1
X-Mimecast-MFC-AGG-ID: _TaX-sdnOkqjo1C1U2n2WA_1757676880
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so13748005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676880; x=1758281680;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWd+C+6xlO7ZNnElus07Td372OLIDupg0E/fPHS2G6s=;
        b=XCAavvIvv3QJQTlB67U1wQ2bq0X5018qWHtgB0QmmC4NzTS/mdCiRQWW2CYIB8WdIL
         R1Qk7+jd4XvdkBVtNLO9DTITcA/gHmYhumQckwC2RK+7FwlGFsCmnIq4IuvHf9B4HKHT
         WnaxCJAZKt8ELOdT2q8j45oOUAYINYCeTDyAG+igg2VuOqhUWRI42RpHjgFtffeUUm82
         xAy+yQxIMdOfwtMjES2r2sULANgeU44osmYk8be2r9hpKAAcQ1NlArothuMzWyBPrzkz
         XxawMU4dKrzbph1xqTnfZ4mEMvXtNnW7Id6bwx3tnPBrKLGzG1lzvwTTMGletgFu9hOO
         dmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFtB+O+SyC8ArpwtNua5xFYlsAU0luwebxGUgJzFjjcenivPTPdm+VRu3IF26+cQzIvtLjZM5+xDs9r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaMai4/GWifZr4mOqMUbVlyqPNsUskYQ+ar5KBrwL4XzrP3EX
	9n7tkEpK45WyZUADcBLJ9f7ZSSLW8GCv9KvXAbfbTn72KKwqM4Poy4j6BAENVhgsvN23mklYK9V
	Y8wHAs/9kG1/cXm/funzjnNyTk73PsJQRFOTaCUf3F+3hr+JdHLMOwOJzZNCWpX5dqg==
X-Gm-Gg: ASbGncuUCiuXXwmFboFsmk1mXDSUVS+7h3rYMghye0QfRNCCkByuaGiR5V3GUwLNHMt
	1AwpYZSEih3irYdGMJoY63lPzGK86jReXvMMifdJ5fEvtsJ88FR7V7qNJfiaVF0QdLMNDrblF+F
	4oyBsPFablm2GnG27Saz4iNSbTAfCCXuzEXxpY1B2T3QBtWdh3c+7B/g6lx4Hf4wgGm6R6QuXVK
	EwU5on9c5PsYVVMh3TLtnHVuOUOVi1CHYgp59ylzMjdcWFGc1vRCtdMquV1WUVm6Y2leNxYrr93
	HDtKtFJoO2ObOshn93NOrkS3w2myH2Xk6vI/3jUilxtie0oAolV1cVflrx/EY8N3Le3qQXfW+Gi
	IwJJ/SEMp+Y1L7oO1jqCCSToFoultidfi2HcK6yRTw4BauS7tOvN/FIL2F7++oqe8uYQ=
X-Received: by 2002:a05:600c:3b85:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f216696c8mr21980625e9.4.1757676880124;
        Fri, 12 Sep 2025 04:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBCLdYjQPkVnjO0W8XKaGSgjZLsccprLNd6W9/Xe0KR1we4p5qR7REUfvO0pBQsst9YNwS0w==
X-Received: by 2002:a05:600c:3b85:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f216696c8mr21980295e9.4.1757676879669;
        Fri, 12 Sep 2025 04:34:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf9esm6158472f8f.40.2025.09.12.04.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:34:39 -0700 (PDT)
Message-ID: <d7a03a2b-d950-4645-80f2-63830bd84f76@redhat.com>
Date: Fri, 12 Sep 2025 13:34:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250912: riscv: s390: mm/kasan/shadow.c
 'kasan_populate_vmalloc_pte' pgtable.h:247:41: error: statement with no
 effect [-Werror=unused-value]
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, linux-s390@vger.kernel.org,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, Andrew Morton <akpm@linuxfoundation.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>
References: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 13:32, Naresh Kamboju wrote:
> The following build warnings / errors noticed on the riscv and s390
> with allyesconfig build on the Linux next-20250912 tag.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20250912 mm/kasan/shadow.c
> 'kasan_populate_vmalloc_pte' pgtable.h error statement with no effect
> [-Werror=unused-value]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> $ git log --oneline next-20250911..next-20250912 --  mm/kasan/shadow.c
>    aed53ec0b797a mm: introduce local state for lazy_mmu sections
>    307f2dc9b308e kasan: introduce ARCH_DEFER_KASAN and unify static key
> across modes
> 
> ## Test log
> In file included from include/linux/kasan.h:37,
>                   from mm/kasan/shadow.c:14:
> mm/kasan/shadow.c: In function 'kasan_populate_vmalloc_pte':
> include/linux/pgtable.h:247:41: error: statement with no effect
> [-Werror=unused-value]
>    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
>        |                                         ^
> mm/kasan/shadow.c:322:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
>    322 |         arch_enter_lazy_mmu_mode();
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/shadow.c: In function 'kasan_depopulate_vmalloc_pte':
> include/linux/pgtable.h:247:41: error: statement with no effect
> [-Werror=unused-value]
>    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
>        |                                         ^
> mm/kasan/shadow.c:497:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
>    497 |         arch_enter_lazy_mmu_mode();
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 


I'm afraid these changes landed in -mm-unstable a bit too early.


-- 
Cheers

David / dhildenb


