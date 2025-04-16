Return-Path: <linux-kernel+bounces-607286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308EA9044D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C46A179AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D1183CB0;
	Wed, 16 Apr 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4nezjGD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278013A88A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810018; cv=none; b=MvvRVNEkhMB6kybfSLSbJUlanTc3lY/j7P0nQm0APoRcehln2+19RnWNY4umYMLvYPyvof4ZDmGR698fUp3CEWCgxEEgXz+Zr3xPC944jEZMZbjnvvv3XznqMj53Rvwo+CIlwA0s9K3R7S1j1+SPlcz//luCiGj1dhflbITgjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810018; c=relaxed/simple;
	bh=u7tgQKyBQxDpDlv/eeh5XGW8bH99prkZaYli+k8oNIg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wm8k/8YaG2tZJ40mb6VWB+NlQaAmfWflh60qv5Ffz+lEqB3o5JX6rHPt5UYoe3F84BKd+LmXAG7jQWZc0qejn4moJA+J4IdfugiHJAZXUb30cjgW/bduw1+XipwWCeAUCh3Fy3Jrf60+41WpRxQu2R0WTcFyUecGIhnFAs09o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4nezjGD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso73166955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744810015; x=1745414815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LXUe0iANce6xhwP4QYlP8FMxu/z1y++/7cwAdg0G+Lw=;
        b=e4nezjGDmWYu/ShAEf+fYUZguqWtnwaNw0FIlPpkvjgSOU/ZC/Qhfw3zKi/vge0HSC
         5RqJVgGdVNRfvQiSVLuiAT40wwK2NY8TUL69rj+Q0mCCQ7XbTsloL1dwuEJWDJA37rvL
         nBS+cq90KLbeJKIUliXlf2BEHCGG1uELLoaQnywvKq9epGTInY4OpUy1v3GUmL+oY8p5
         uMt6t1aXg5sc6zAHZ9QNN5CNhl4/tDr1zwxtkdiRAEpumeK68K5AkmPsr5nbOEdHpkNx
         DqLV9Bsi5GmSiy0XOGpUC0yKLto6oId3fCUF79Fl+3QUYfbt1pYucr8uLAps9RPlNCCH
         eJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810015; x=1745414815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXUe0iANce6xhwP4QYlP8FMxu/z1y++/7cwAdg0G+Lw=;
        b=aBv19cHCsNGyWeuQhHjERCnQBfn5mWWpKpFh1c80SBdQGTz7CEWrRxpTWMf3wl0cJV
         xMjmwXJFlu3GrFuEhFMPjaFcrMyeDe9emU9Uz3xGpztcu11ULfTCysk/VGWhOcKADmqk
         CKUY3yTdK8nn0Y7K98087kclko+U+Ie1jqLiIvhbE9PNkNTYbw9lE0FAJ6bFrrpQnQgR
         YVwZ1+u/IXu3/9q7ucvxEqzq5XXQcV8dq3//Mq2VRckC1IEiCUnsSmmOOrn9k6pvRdp7
         6aPknLhzCGm1OFhxbndnpOT8A4hjq+EPns95lzV/eID8eJJ3LIk+gxvJR07jK1SXkLjY
         UCzA==
X-Forwarded-Encrypted: i=1; AJvYcCXTCPdgQ+bTjEw7qSAhIZ3MEsvIwGuU9g3eIDvBH0XEEgz2XSqHkVbqSbGhc0RI/xCC+/jHmzWCuXJBHQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnHu0fVZe0sWJNc11W0LpbnhmmSlFAQNa9pJja8O86yC0ajgR
	h3dGIlj307+OPz9e6bPXsK9hC1VHw2cDgLuJzWp+Qan0eye6QC23pOSOpuHGY0k=
X-Gm-Gg: ASbGncu1RgBOV2m1eo3ODhXp7cms0Jb3saz2X6rX943azNiLJKfGc/kpvh24BE/wDjl
	hNaEqhIYdFI/n2KL2aZgmll6rM3CFjCEKDFHHByD6dDbvKzGsMROv3SPmZOojMrQkXaTzFPKf+t
	mdO4cEQUyiwHLZCZoiBIGGB3FI12+kyeK8mNI+qE4ZaDGn2OAlDen+F4G/GYVwMl5NEGsn5jH/u
	xtOdrJiUA6F+Xryt83LNlPnNaKPyBBkR9wOkPsHLqneWgDDBFb+jbKlwp3J/X8AF9i8dbWCURwn
	VMFRYm0F9hG62KI4vIMR5g+QRn7hQB7W+W3knB+RFVU=
X-Google-Smtp-Source: AGHT+IGw46NqRQ8rr3G65OgHPazkLo5CSU52gngWFd673YvxDsgGuzhMGHsuig9f8x6t5NauOdl0Mg==
X-Received: by 2002:a05:600c:3b9c:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-4405d6cce52mr14393385e9.28.1744810015079;
        Wed, 16 Apr 2025 06:26:55 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c8216sm21577475e9.7.2025.04.16.06.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:26:54 -0700 (PDT)
Message-ID: <95c9bd53-ccef-4a34-b6d2-7203df84db01@linaro.org>
Date: Wed, 16 Apr 2025 14:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] tools headers: Update the syscall table with the
 kernel sources
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnd Bergmann <arnd@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 linux-arch@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20250410001125.391820-1-namhyung@kernel.org>
 <20250410001125.391820-6-namhyung@kernel.org>
 <f950fe96-34d3-4631-b04d-4a1584f4c2f1@linaro.org>
Content-Language: en-US
In-Reply-To: <f950fe96-34d3-4631-b04d-4a1584f4c2f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/04/2025 5:28 pm, James Clark wrote:
> 
> 
> On 10/04/2025 1:11 am, Namhyung Kim wrote:
>> To pick up the changes in:
>>
>>    c4a16820d9019940 fs: add open_tree_attr()
>>    2df1ad0d25803399 x86/arch_prctl: Simplify sys_arch_prctl()
>>    e632bca07c8eef1d arm64: generate 64-bit syscall.tbl
>>
>> This is basically to support the new open_tree_attr syscall.  But it
>> also needs to update asm-generic unistd.h header to get the new syscall
>> number.  And arm64 unistd.h header was converted to use the generic
>> 64-bit header.
>>
>> Addressing this perf tools build warning:
>>
>>    Warning: Kernel ABI header differences:
>>      diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
>>      diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/ 
>> x86/entry/syscalls/syscall_32.tbl
>>      diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/ 
>> x86/entry/syscalls/syscall_64.tbl
>>      diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/ 
>> powerpc/kernel/syscalls/syscall.tbl
>>      diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/ 
>> s390/kernel/syscalls/syscall.tbl
>>      diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/ 
>> mips/kernel/syscalls/syscall_n64.tbl
>>      diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/ 
>> tools/syscall.tbl
>>      diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/ 
>> kernel/syscalls/syscall.tbl
>>      diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/ 
>> sparc/kernel/syscalls/syscall.tbl
>>      diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/ 
>> xtensa/kernel/syscalls/syscall.tbl
>>      diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/ 
>> include/uapi/asm/unistd.h
>>      diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm- 
>> generic/unistd.h
>>
>> Please see tools/include/uapi/README for further details.
>>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
>>   tools/include/uapi/asm-generic/unistd.h       |  4 +++-
>>   .../perf/arch/arm/entry/syscalls/syscall.tbl  |  1 +
>>   .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
>>   .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
>>   .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
>>   tools/perf/arch/sh/entry/syscalls/syscall.tbl |  1 +
>>   .../arch/sparc/entry/syscalls/syscall.tbl     |  1 +
>>   .../arch/x86/entry/syscalls/syscall_32.tbl    |  3 ++-
>>   .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
>>   .../arch/xtensa/entry/syscalls/syscall.tbl    |  1 +
>>   tools/scripts/syscall.tbl                     |  1 +
>>   12 files changed, 15 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/ 
>> arm64/include/uapi/asm/unistd.h
>> index 9306726337fe005e..df36f23876e863ff 100644
>> --- a/tools/arch/arm64/include/uapi/asm/unistd.h
>> +++ b/tools/arch/arm64/include/uapi/asm/unistd.h
>> @@ -1,24 +1,2 @@
>>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> -/*
>> - * Copyright (C) 2012 ARM Ltd.
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> - */
>> -
>> -#define __ARCH_WANT_RENAMEAT
>> -#define __ARCH_WANT_NEW_STAT
>> -#define __ARCH_WANT_SET_GET_RLIMIT
>> -#define __ARCH_WANT_TIME32_SYSCALLS
>> -#define __ARCH_WANT_MEMFD_SECRET
>> -
>> -#include <asm-generic/unistd.h>
>> +#include <asm/unistd_64.h>
> 
> Hi Namhyung,
> 
> Since we're not including the generic syscalls here anymore we now need 
> to generate the syscall header file for the Perf build to work (build 
> error pasted at the end for reference).
> 
> I had a go at adding the rule for it, but I saw that we'd need to pull 
> in quite a bit from the kernel so it was blurring the lines about the 
> separation of the tools/ folder. For example this file has the arm64 defs:
> 
>   arch/arm64/kernel/Makefile.syscalls
> 
> To make this common part of the makefile work:
> 
>   scripts/Makefile.asm-headers
> 
> Maybe we can just copy or reimplement Makefile.syscalls, but I'm not 
> even sure if Makefile.asm-headers will work with the tools/ build 
> structure so maybe that has to be re-implemented too. Adding Arnd to see 
> what he thinks.
> 
> As far as I can tell this is a separate issue to the work that Charlie 
> and Ian did recently to build all arch's syscall numbers into Perf to 
> use for reporting, as this is requires a single header for the build.
> 
> Thanks
> James
> 
> ---
> 
> In file included from /usr/include/aarch64-linux-gnu/sys/syscall.h:24,
>                   from evsel.c:4:
> /home/jamcla02/workspace/linux/linux/tools/arch/arm64/include/uapi/asm/ 
> unistd.h:2:10: fatal error: asm/unistd_64.h: No such file or directory
>      2 | #include <asm/unistd_64.h>
>        |          ^~~~~~~~~~~~~~~~~
> 
> 
> 

Hmmm I see this was also mentioned a while ago here [1]. Maybe I can 
have another go at adding the makerule to generate the file. I'll 
probably start by including as much as possible from the existing make 
rules from the kernel side. I think something similar was already done 
for generating the sysreg defs in commit 02e85f74668e ("tools: arm64: 
Add a Makefile for generating sysreg-defs.h")


[1]: 
https://lore.kernel.org/lkml/ZrO5HR9x2xyPKttx@google.com/T/#m269c1d3c64e3e0c96f45102d358d9583c69b722f




