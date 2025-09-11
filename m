Return-Path: <linux-kernel+bounces-811154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBEB52504
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1255744836A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198A19309E;
	Thu, 11 Sep 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHySYb85"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E118C031
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551331; cv=none; b=Y0UC0h3anMW03F0loAGqcL2zM82Btrksy/qgypSxiiKssKIo2D8EeE1Wggh0dPp7+bKPtgDiwgJVGooXHne8yhDWJrZNCU5bvQhXPC0t2Okeugc7TC5wkWHXXNnRYHUgP9m7MAE0NiU4UF5zVYcT38w3EZ2gbAzV7taOUmeZSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551331; c=relaxed/simple;
	bh=YFTY1MlXgMtpCzJ3ppwQHdzTqRu6eh+Wa/wiYizEOSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXWSu6E8FM7ox3cjkE6Ozbk7R5jYJcpDl43LEpPfwL59OLiYqtWv867UB+vXhsFTL9z1StKdpnbd8aePxkJxz5Vp4Bjd+wVus/6Ri9TDdN/G/D9pAYGrjRNakxyfhM6va5uWxVGNEkchsLd/swAmehALIYiPkUMwqaUeY5XoTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHySYb85; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so182251a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757551329; x=1758156129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmrRfCstUoTNbXxhDuwFdSNJzCztRtDazCJ7pzGhkEw=;
        b=WHySYb85ZZtxMil1WpuZAFT+9/zPPCkykVEb16UKmYh6J+Wsh0FF1xu1I1+0pNG/SH
         5Mjbnn5VnQIIW6S+0NAV0gZq18lwu0D8ZPrujCZq10jjify+8GlfQKCzX2bXpnu42DQq
         O9bywdUkexlslhrRQY+zw94kHvAoxzRRTrI3RXL/P1Uyk2jK1dFpH/PTQaGoN3YaXtbU
         syiJFJTNHQjWqd+4ErfKsmySLJB9nGqCJ4rAly6I7FIXppJZXbeo5/QucADCXgsKB0CN
         gvnnsyIBxEIjGh7w2bzPnh1tZA1u5UEnNn5pZm+NoAh6k6Tx/tBy6o287KAOssgwZXwP
         JxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757551329; x=1758156129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmrRfCstUoTNbXxhDuwFdSNJzCztRtDazCJ7pzGhkEw=;
        b=QJT+mWC/eVrcarzDIcaCMGW+1GQee8xgbmKCJf8CkrnIag4kEC3Cq8oR1UpWVZiKlY
         wdNoaGibqyv3gH911UqYE4RefM918dAssuS8+FuRuJnQ+HYS5in6u5a57TZqQ9zvMkqK
         4T7Wso2tAI7xfvK5S2ZSMX1j2IJIrnPy8IIC5WTD0J7LOuRkJOGnhyKAOlahE02xI1Bp
         GIcdmB5zYyx9q/g1YXDnLNF641V4ZIuY2cpmXsW9l1nYu651opPXc4SNUjKoiR2kV/OL
         iBBlX2pRpFkB5TUi6QNPJdfCpuiP7BSAkaeExkn7+Wu8ObfGpgN+nM9LwtKSIgL/SlKD
         Gp6A==
X-Gm-Message-State: AOJu0YzOyoL3z7s8SlcgYhrldMidQElpD4vZ7pKKgzOy2ncnX6uW58QJ
	8iSVPaTECPy8YRu9W8KWNvSaQvGQ6J+aBZpx0jYp2ssy8mogp1g0g9Y/
X-Gm-Gg: ASbGncuql9+YbQs7fhZEbPWVEYCteeu8lyIbbZwpXwTYbr0hhqsbpy1OAfNL2aHw+7H
	ExXRFZ0XrgUN/VaWr+cPK0eDiKtcoxDdWxTJcjtH08kKUa/AlFRM/v1b1T2KZssUttJHOy58gxM
	F/CzRbzjqubegW1zy8oDfMu0w8o5gVQBqB6cCTI0/jp7vAfvCtDqlEqOvKAnqPW5JLIvh8Nr2fl
	JCzma1xTRFiYIasOy8mP5bVPtQ+7C0SZgPUFmUUHS0NU2COGjqTTyw7YKrUV//QTar2eX1r3/yL
	oKEoDS/kWppubs09665+mlH/zepUQB0JhAmVnx6TXSA361WV8+aR0nIrrHWcpgdty2yUGkwmg2D
	FCGBXQRV4Sh/EYY8crilK3jXrI07YEY+vONQ=
X-Google-Smtp-Source: AGHT+IHa62UeWvctrBUHblphA2gshKtLoXfu3nHGh4jNUws9ENqIeed+eb2v9i1WsK+fuVPtv2Omfw==
X-Received: by 2002:a17:903:1585:b0:251:8220:c53a with SMTP id d9443c01a7336-2518220ccbemr221721355ad.27.1757551328755;
        Wed, 10 Sep 2025 17:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6cc5sm193065ad.27.2025.09.10.17.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 17:42:08 -0700 (PDT)
Message-ID: <81669788-9661-40fb-9cbc-c9fb44970c3c@gmail.com>
Date: Thu, 11 Sep 2025 08:42:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Unify breakpoint install/uninstall
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250910093951.1330637-1-wangjinchao600@gmail.com>
 <cae9c81e-84ac-4da4-abb5-9ff9e20c6d3d@intel.com>
 <332DA932-2A5A-48B1-AEF6-84D4CCDB7BA1@zytor.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <332DA932-2A5A-48B1-AEF6-84D4CCDB7BA1@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/25 22:56, H. Peter Anvin wrote:
> On September 10, 2025 7:47:06 AM PDT, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 9/10/25 02:39, Jinchao Wang wrote:
>>> Consolidate breakpoint management into a single helper function to
>>> reduce code duplication. This introduces new static helpers for
>>> slot management and debug register manipulation.
>>>
>>> Also, add `<linux/types.h>` to the header file to fix a build
>>> dependency.
>>>
>>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>>> ---
>>>   arch/x86/include/asm/hw_breakpoint.h |   7 +-
>>>   arch/x86/kernel/hw_breakpoint.c      | 151 ++++++++++++++++-----------
>>>   2 files changed, 96 insertions(+), 62 deletions(-)
>> That diffstat doesn't look like it's reducing code duplication.
> He does add a *lot* of comments.
The diffstat was misleading. My refactoring consolidated duplicated
logic into reusable functions, which reduces the final code size.
The original refactoring can be found at:
https://lore.kernel.org/lkml/20250904002126.1514566-6-wangjinchao600@gmail.com
Measurements of the `hw_breakpoint.o`file were taken with 
`CONFIG_DEBUG_INFO`
enabled, using these commands:
```
objcopy --strip-debug arch/x86/kernel/hw_breakpoint.o tmp.o
du -b arch/x86/kernel/hw_breakpoint.o
du -b tmp.o
```
This table compares the code size in bytes. The `refactor`column indicates
if the refactoring was applied (`1`) or not (`0`). The `function`column
indicates if `arch_reinstall_hw_breakpoint`was included (`1`) or not (`0`).
```
+----------+------------+------------+----------+----------+
| refactor | function | unstripped | stripped | percent |
+----------+------------+------------+----------+----------+
| 0 | 0 | 275320 | 11976 | 100% |
| 1 | 0 | 275736 | 11448 | 96% |
| 0 | 1 | 278720 | 13520 | 100% |
| 1 | 1 | 276392 | 11760 | 87% |
+----------+------------+------------+----------+----------+
```
1.**Overall Refactoring Benefit**: The refactored version (`refactor 1`) 
with
`arch_reinstall_hw_breakpoint`is 11760 bytes, a **13%**reduction from the
original's 13520 bytes.
2.**Unification Target**: Adding `arch_reinstall_hw_breakpoint`to the
un-refactored code increased the size by **1544 bytes**. Adding it to the
refactored code only increased the size by **312 bytes**. This demonstrates
that the refactoring makes future code additions more efficient.

-- 
Thanks,
Jinchao


