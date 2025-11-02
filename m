Return-Path: <linux-kernel+bounces-881936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D0C29448
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05043A6D04
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F021773F;
	Sun,  2 Nov 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz4wwQeJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD942BCF5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762105945; cv=none; b=qf94AwiilXkEkllCm+8DUCQQa3t2EsitUQ26nX5v4txSYxgrNuw+x6bWMpm+vab1RJOI4FdMRF5lDd0UXPK7x1Z49fbZSePWqtUy9L3UMUGQmQV48KPVgekoJ3YHsYoVWmgH9ObRRC+/SKAkfZOpN0wW0ZmueFZ+/sa1dVGFYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762105945; c=relaxed/simple;
	bh=bCytgWaN5kcCIkmFDBRKSON2gh2/3LaK9lXPnxwH6ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0ltos0L6a792LHxPD87tOxiO2lfauAQ1nnmnCzqp883sZR9J2gjd/VxWMZ1PqTc3zkj0Z2E+8QsawciDzzvL8Gcioma/Q26XPuNJ+5pszMt7RBsPApAEWQDqq8PjZ7t5Gz5HmB2gmrld6FW99SeuM9QOUQ9yOay4Q4hZCdc32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz4wwQeJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294fd2ca6acso27487095ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762105943; x=1762710743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Ec2zQurK8STOuaWu3d/5bNQMcmfortr8Sd7cdcPYw=;
        b=Iz4wwQeJ7zZIFV/INW1B5sjV6FbzVpW9oW31xyBnBzEoLFj6gPkHdIXHmZIRTcpeQt
         DdQ+h9sLAs8K2xOMIfgtLuzqYvkaEaLoHqgXyyITFeLBIiLl+5GZaDuPgSWAugX/J/2u
         TupniOD3o/s7GPlLum7S14MrOTKiK8FvGSsNF4B/QQ7VnZLoDWdqbtlzg0po5MI1ynUT
         rdtX4GUx6CQXj6Ze87aMGEsIzIDCYx92v0nn0x/RH7ZlYA+XyB25C0R7TFU7CGoXsFum
         28XUxN1EJBNHRCAN60Oe0iFcaP1GpA231UXyvOVYEWnw+ICGIXuRfx2t3COViD40V4Oo
         afqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762105943; x=1762710743;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Ec2zQurK8STOuaWu3d/5bNQMcmfortr8Sd7cdcPYw=;
        b=upRCWznBae53FFJouJNSFR+nFyfif4A/Rm/m/uyS7N/vhDXjHR9DZaKRbosZlusyIT
         +s7qSjuHkH2mfhxTvWj4Nw/540en+L2uT6/Pue44r9RbCQ/U3+1VeAAayUnjR9HIvwxn
         6TYt6t/6QV5ibSTpdFTnL5xKaFeJa0oZ0Wm4UaAcx4Dk5lrcJy0UxqK8XeRZzRUWsv6o
         96KDhE8pg8aCamaCYSvAoUN2cLHJktc2TZ0LxmRRdfiPIxvjvxYJDhKB+5G5kMoDO0Fm
         v+76VehM2CdpSuYyuJ3GKlLEGt4alT3MbnWCmBzdKXeilvXVJKgKAR1I9SwPVukYHZqF
         FsCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvfC+9+A+PtlcgVSGaMn9iAClwDMZlLtjkWaVeBvYN34c+R8UDf+hO6WAUMChoOVxzx51nFzZkxsxYN5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIaiE73fyjnlHhqKbZxN3HIVld/0olHeRIYn/b2x/TxDHO2vQ
	zUovEtgacnWJV4VQ1+WHZVHFD1lqygajYWWTZT3rpKKcH5JcfwfvryCb
X-Gm-Gg: ASbGncsM8IHXECXFv90IdyHXAAObDNPNkCI8fk0cW/fX/toHik7gVQNnOkv5TaIKFAD
	qo8vnafJ4iBvKn3Z1lvlplgj38HIMJ5lRHETRJJZql/uFgY5mAJRJ/h84+BcosnbqcUh+7vFR/H
	80O3juP3lyoYHpHKbSvyE3YKu1nxT1jatLrwqJ6a2cVf8npJA7c+mCSRhL6KZjVseQobOWYij6F
	lunzSa1gVHBDMbMZy6JkGMLEFxlorgQrsrj9Uuz60eG5Fa5j/3uOyodN3t681WqcCWT00V779eT
	TBCMHH0ZWWKb8YTrG5ck4VY7Qzp2eh1BKfm1Wn6dFYuDsa1MZWTveAYoqXx+rQwB1VdV6ilC6CW
	+sOMA4bZV9JlmlzQLVA9QWqs2a/wEa+boBo/ZVuITAKcCU04egEK1GkGiFB5PiS+nPhMDtQaVGc
	TCDwhXegJ8qbgAUy5/pLqGuRGgNmF+ZWymoUZH4t5KvpaAuBDA
X-Google-Smtp-Source: AGHT+IGtoTdzpUb2T1EbfjQRkDOZfadeV+MUvBKwgGICeRZwRx4ujvdTe6AhPX5UfUKG81LSmwLfZQ==
X-Received: by 2002:a17:903:228c:b0:273:ef4c:60f3 with SMTP id d9443c01a7336-294ed070898mr190085585ad.4.1762105943418;
        Sun, 02 Nov 2025 09:52:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm90821675ad.57.2025.11.02.09.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 09:52:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <71da525e-fea1-44a1-9d47-9280654690ef@roeck-us.net>
Date: Sun, 2 Nov 2025 09:52:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nd@arm.com
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-4-yang@os.amperecomputing.com>
 <f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net>
 <933a2eff-1e06-451e-9994-757d66f4b985@arm.com>
 <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
 <CABXOdTeOU0qeSicdDU6DjNHWpzCEhK-66kTdwWjb3M+=Xr3aMQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CABXOdTeOU0qeSicdDU6DjNHWpzCEhK-66kTdwWjb3M+=Xr3aMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/25 09:49, Guenter Roeck wrote:
> On Sun, Nov 2, 2025 at 7:09 AM Ryan Roberts <linux@roeck-us.net> wrote:

Oops. That was sent from my Google address and got messed up.
Copying Ryan this time. Sorry for the noise.

Guenter

> ...
>> commit 602ec2db74e5abfb058bd03934475ead8558eb72
>> Author: Ryan Roberts <ryan.roberts@arm.com>
>> Date:   Sun Nov 2 11:45:18 2025 +0000
>>
>>      arm64: mm: Don't attempt to split known pte-mapped regions
>>
>>      It has been reported that split_kernel_leaf_mapping() is trying to sleep
>>      in non-sleepable context. It does this when acquiring the
>>      pgtable_split_lock mutex, when either CONFIG_DEBUG_ALLOC or
>>      CONFIG_KFENCE are enabled, which change linear map permissions within
>>      softirq context during memory allocation and/or freeing.
>>
>>      But it turns out that the memory for which these features may attempt to
>>      modify the permissions is always mapped by pte, so there is no need to
>>      attempt to split the mapping. So let's exit early in these cases and
>>      avoid attempting to take the mutex.
>>
>>      Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
>>      Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
>>      Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Tested-by: Guenter Roeck <groeck@google.com>
> 
> Thanks a lot for the quick turnaround!
> 
> Guenter


