Return-Path: <linux-kernel+bounces-813404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65958B544EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA1B3AD6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C82D4B7A;
	Fri, 12 Sep 2025 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALMiutHz"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE32652B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664945; cv=none; b=XS7CU/oZbOAxk6+yEZxauIfPDWnwPiqqRqYzJyo/b3r9DlGNOaLveQNvs512tIrXtLmxuX/DHYoaBSbyrSl2xCB43V1NhEN3nBZd3mzmG79urqioGpAIkAqU4A+26HP9m0gCPDsgokq3/wsLA+YKVf2LCHGh9iyMud5gbQpExPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664945; c=relaxed/simple;
	bh=x6auaUtLkJOEoqmzTVyoxHafeP+WDnwCjdDW23ooG7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDVPV/Z9FkSB0wUrt+qPnPEbwLrxnFbX7MCKjV9Kzcqdc15aGinHOKaul3zPz1FqWRCuZKgdzwIGHdAymjIc23UrWUHG9R8gEGAbNJNAm8ArDTzYhXx4Anveiylzav8pIL1vUjqWuSZ5Hi32cj/pcb0ldFEKHW9UnFgfzeN0vko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALMiutHz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b21006804so18525685ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757664944; x=1758269744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2EuFHC5+5B8ohKz2yz145rUlrp5xKfqVTKvvn+wKTM=;
        b=ALMiutHz7JsBiTGqgQyeZscQpxU4dusSXLlyzt5UxlsWFzxLAuOkHAMGKkBL81BnBk
         N21n6BjkxYLh0fKkCc9cpv16e++jnADpb7GmBnNORfNFU2XrP/3pZBSZvYrcYZswY5ZL
         7VR1SguAzdvNYbH8C8nSFSpb2gnhJ8x2XeiaVD7ftDS5a2VkijMmkMm4DCnNnADleBPg
         KjXkSBDzP3ZdMRQHng8o+yhM3E9kW6YS1xcHjGrBnXs0gSEoSjnPbw8sOh8Wm2tHQDVH
         JH2BYYWPwXvZvoSOuoibsV3V9POo3jQkrr0n+N7FXDRF2fFEbDVJOVSI0t4WQgDXTsOt
         Cytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664944; x=1758269744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2EuFHC5+5B8ohKz2yz145rUlrp5xKfqVTKvvn+wKTM=;
        b=YpgwLWyhVB3fEkqaLuUxuIkL7crNG79PP+/O/RjJS3FrScXMjBSVBCc8M7sut9bcod
         XzUYzZbz6PJ5JDXtZHuNwcodfLdbdd3JVBZ3v/ufm1C0gcc3eZ2/5YipOYZ+zJq8ZqqL
         K12ym2yw4byCyze/ucDp573str264hUIJMS+qUcHaLA1gHYJ05jtbVPfyz3tOcs4aBL4
         585WHTgwmk+QWCgYwVo9ac/btXwGHGYaqHDWlx5ZG/GSMGgW+qj7FXVEnC/eubEfFCdC
         BFERYrC8lDMn8edA9evSajEWlVH5XL4YHVfhE+Oi7O6Q0D4gkzxNhNnHsWIsQ08OxfBq
         Bxxw==
X-Forwarded-Encrypted: i=1; AJvYcCUqAACGruCF8RRfVgC5PKfJv6Cl+txqup0X1dk28ps4wrTU3SsQhelE0PGCJVKmAM/RdF7NrVwt5H0hFAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/1xgALmhvxodGL51ikL3Z1tFt9p+AEB1W8Fg7ImmMNCeFZ/y
	tLjtU1CnQmfBxTe7Gm9/KTPpHBoqdXD2ygxZuornNGsvaBwq/bbOAcAW
X-Gm-Gg: ASbGncu4vfcAmNzTLrYOlYIFwCo107F49+IGm/RLVBlTeB7SmrYc1XXc5yKBjPvK0sx
	Zh/CRjrS8OQaI/A+OYjZTWYjWkkPZcsDWPrhvSFiOv2yTlt08M6kysS2lssK6Jz3oyKrJmJfewm
	ZjupV4C0hwDHtC0d1GuwxnrpwxBzvVW61j4u3ILr2228i7WdIhJR6FmMS4gGhgSTlzkhitrKgvb
	0HAyibDWbvNc/U9qaL+iHpMsJu6F+/V77c8rCJk0xeA4K64u6Sdks0vSv0fCeoQTtFlOKSo37cB
	xuDt4rtSC3Bmr/xiOe078/TMWw/cncQ+ki+U0Sy2Zs8zWkHYG89ZxeNLMRq6sK8fFEtGDxxGyOF
	moYwJ4HMR/4QZl6SPoQ==
X-Google-Smtp-Source: AGHT+IEbBMlmn4X7zEmlKlP8C6ibHYXtACBPItjKVzlA2dNacKH531krqQgn4mB7LrrpYHonZsrfZg==
X-Received: by 2002:a17:902:f707:b0:25e:78db:4a0d with SMTP id d9443c01a7336-25e78db4d35mr3480525ad.36.1757664943639;
        Fri, 12 Sep 2025 01:15:43 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3079])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc580csm41503445ad.10.2025.09.12.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:15:43 -0700 (PDT)
Message-ID: <8c047b5f-f4c2-4795-8ceb-a556ac6647b2@gmail.com>
Date: Fri, 12 Sep 2025 16:15:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
Content-Language: en-CA
To: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 "Naveen N . Rao" <naveen@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <aMO07xMDpDdDc1zm@mdev>
 <CAG_fn=V5LUhQQeCo9cNBKX1ys3OivB49TuSeWoPN-MPT=YTG6g@mail.gmail.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CAG_fn=V5LUhQQeCo9cNBKX1ys3OivB49TuSeWoPN-MPT=YTG6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/25 14:41, Alexander Potapenko wrote:
> On Fri, Sep 12, 2025 at 7:51 AM Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>
>> FYI: The current patchset contains lockdep issues due to the kprobe handler
>> running in NMI context. Please do not spend time reviewing this version.
>> Thanks.
>> --
>> Jinchao
> 
> Hi Jinchao,
> 
> In the next version, could you please elaborate more on the user
> workflow of this tool?
> It occurs to me that in order to detect the corruption the user has to
> know precisely in which function the corruption is happening, which is
> usually the hardest part.
> 

Hi Alexander,

Thank you for the question. I agree with your observation about the
challenge of detecting stack corruption.

Stack corruption debugging typically involves three steps:
  1. Detect the corruption
  2. Find the root cause
  3. Fix the issue

Your question addresses step 1, which is indeed a challenging
part. Currently, we have several approaches for detection:

- Compile with CONFIG_STACKPROTECTOR_STRONG to add stack canaries
   and trigger __stack_chk_fail() on corruption
- Manual detection when local variables are unexpectedly modified
   (though this is quite difficult in practice)

However, KStackWatch is specifically designed for step 2 rather than
step 1. Let me illustrate with a complex scenario:

In one actual case, the corruption path was:
- A calls B (the buggy function) through N1 call levels
- B stores its stack variable L1's address in P (through a global
   variable or queue or list...)
- C (the victim) called by A through N2 levels, unexpectedly has a
   canary or local variable L2 with the overlapping address with L1
- D uses P in a separate task (N3 call levels deep), which modifies
   the value of L1, and L2 is corrupted
- C finds the corruption

The only clue might be identifying function D first, which then leads
us to B through P.

Key advantages of KStackWatch:
  - Lightweight overhead that doesn't reduce reproduction probability
  - Real-time capability to identify corruption exactly when it happens
  - Precise location tracking of where corruptions occur

KStackWatch helps identify function D directly, bypassing the complex
call chains (N1, N2, N3) and intermediate functions. Once we locate D,
we can trace back through the corruption path and resolve the issue.

Does this clarify the tool's intended workflow?

-- 
Jinchao

