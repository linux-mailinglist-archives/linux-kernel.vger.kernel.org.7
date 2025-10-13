Return-Path: <linux-kernel+bounces-850049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29DBD1B69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAF7C4E9BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA32E6CCE;
	Mon, 13 Oct 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="S7fGJDOQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B87EADC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338387; cv=none; b=HigJ/AE/EpeMCoxyCv10fewNACcOmegSqI6FEcd645xqx6x4sBMxn+INt6JqIT5wi4/IuvSanBP+y+Rud81qIy9G4wqKehJ9dr5MV3t6SjY6XPspxSEQfNJwcrPM9TOj9O2AIue89nGA7gqoegvpKm/7+LBl36Wqn2DMLKn6M2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338387; c=relaxed/simple;
	bh=XWfWVvT50sWqI3yEYYBBeqvjR5ZD2au7/yuFk5dkruo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CW7QUP+hGGXJEVxHAecLTZkBAT/CosNGgRT1Ge2cdlKJzB75E9ARq03WalD3ALW2RuIECmg1Q4zSV0X8l0vOxb2OuacuOp4soKJngNjUWQHB9U9hfyXypS7sWNt+bZdVgGU7Wyj1OVHZBc55PMg7djKGEBzSTRQxYdKf1IrgkGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=S7fGJDOQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so34527175e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760338383; x=1760943183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbH3h4P4XxNpCmGDtdwz6GDKeAh4p4S3SJJjZvahGmI=;
        b=S7fGJDOQMPOQq5hVE5lEPajO2/rCG27hBFcUOGRrhtZiBOX/z70AV3proMyjzPCjtf
         L4w+jswVR6W/QUslnCeT+8fVZ5pvNdrFmyYIkK9/dUVEoDMmOtkWT5Kr3r01GFMcbjPh
         BkJoO0J8t2Hehvu5WYnIGQZv/MaeW8WHet0L/hWicAMhPmEVuBxH17DyYkPcp4RbJ91d
         LmVlkdqGyjHn0KlsgmO7/amgwB0VuwewWRaFHjWXxbYkvB0OBMT5h8W4JIBRMKu0eGxn
         BQIG6FxjEYjVxGfCFtsFY+lR5Wqy2TfCadQvL8uCQRMWrFgnqm2AEUdSrqNHKoDF5ADL
         RN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760338383; x=1760943183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbH3h4P4XxNpCmGDtdwz6GDKeAh4p4S3SJJjZvahGmI=;
        b=LiIB4g+VeshB1L555fUMuwgddrVB65DmkAbm/rU0zltesawr7oUFrtu/tAwKOhGEC2
         zPnMAT8iqRTlBDjlRxPulSnzq3P5coeVGWgvzCg8Q4u7irMT6SyW6l5B39QGuAVdZMe9
         vA3MH6yLi4ulHSLyVxI/7wtwo9BTMl220OUC/atnt9/VSiGfQ34OLvIFKwvkyU2ykIJE
         wESNYWXTLCDCWGaxEE3wKErZS3Wdq5k1kBo+hfyDuPCPkMgEFaUlqfiDijsrh1Rn+7tJ
         ZngFJGvvz8wuQENNq8uKfP3Onx2cdjahDyIhBjT4QClNf5rWosFC8bVNDRAigTXEI18g
         rk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtPijcX7/Tav0ffuqVyYSlcQsz11cLacVrwiCIYvnyuwIMBzrnK50vOqjVicL7PI9Ct0xnfzsPOBWoOwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXqqAWJ+8kolmXbBDUQkpzn210N2B8dqdxF1sn7pbU7h+Z+dz
	tudxixh4pjO+IY0Bn/2814DHgzd5SzwppZVT4aEjMnY+a0J6jLiWM3FdraoEplPu5To=
X-Gm-Gg: ASbGnctglB7X3hFX6OtfOLtT4hKFmCq4HsXctxoPV2kvPPwE1FWn4SL67Bl7OImiKtm
	hq0FBzsO4jwq99gTSRsDEf4ID3NfL6jVXr0cZ5ZkgOdiM+Vqtt2f//litVD/iQ09l5sAMQ9mcST
	8PNo94z/UtQll1A6G4XsQV1s/b8YtsJ0xKD0b0QBuw6SwwpZAIxVBFl9q6nteOJEgw1nqpJ38qG
	7xju5nKvCK7Cbd05MVdjGuVtKAoJH4FBINsc+fgr0SiKLWVmNdrQl9Qq8c4YmaEhWzYD7QJsIdS
	6eN/qTVsLJrBF2cFuw8WoBCh9GsFRDtIJlWKin0mcdgTKOb+xC+mi2/JA8SiE2EvcjX+8vUAPpq
	FVo1GlLPLsFAUM4/tK/rCeSkGO801jbj+QJSi6Tb5NyVtD/XTEHq69/qIUeirroSdlRn2Mskvtb
	yiVQ5uka8Myw==
X-Google-Smtp-Source: AGHT+IHS+mxS8XXsx5JY+2orAFN0Rw3+Bxz5ihy+z4tH7rBV7ImQGUUGN7GgYYiyXdTqtgFgFgyyAw==
X-Received: by 2002:a05:600c:1d1b:b0:46f:b32e:4f3e with SMTP id 5b1f17b1804b1-46fb32e4fa5mr108548385e9.37.1760338383336;
        Sun, 12 Oct 2025 23:53:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589a21sm17022180f8f.23.2025.10.12.23.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 23:53:02 -0700 (PDT)
Message-ID: <628d357c-f462-4dc8-92f2-99006b73e0c7@rivosinc.com>
Date: Mon, 13 Oct 2025 08:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software
 Events
To: Paul Walmsley <pjw@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <86817f9a-c601-81e8-b95b-0f2396275f95@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

Thanks for caring about this series ;)

On 10/10/2025 03:32, Paul Walmsley wrote:
> Hi Clément, 
> 
> On Mon, 8 Sep 2025, Clément Léger wrote:
> 
>> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
>> to inject software events from an SBI implementation to supervisor
>> software such that it preempts all other supervisor level traps and
>> interrupts. This extension is introduced by the SBI v3.0 specification[1].
>>
>> Various events are defined and can be send asynchronously to supervisor
>> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
>> as platform specific events. Events can be either local (per-hart) or
>> global. Events can be nested on top of each other based on priority and
>> can interrupt the kernel at any time.
>>
>> First patch adds the SSE definitions. Second one adds support for SSE
>> at arch level (entry code and stack allocations) and third one at driver
>> level. Finally, the last patch add support for SSE events in the SBI PMU
>> driver. Additional testing for that part is highly welcomed since there
>> are a lot of possible path that needs to be exercised.
>>
>> Amongst the specific points that needs to be handle is the interruption
>> at any point of the kernel execution and more specifically at the
>> beginning of exception handling. Due to the fact that the exception entry
>> implementation uses the SCRATCH CSR as both the current task struct and
>> as the temporary register to switch the stack and save register, it is
>> difficult to reliably get the current task struct if we get interrupted
>> at this specific moment (ie, it might contain 0, the task pointer or tp).
>> A fixup-like mechanism is not possible due to the nested nature of SSE
>> which makes it really hard to obtain the original interruption site. In
>> order to retrieve the task in a reliable manner, add an additional
>> __sse_entry_task per_cpu array which stores the current task. Ideally,
>> we would need to modify the way we retrieve/store the current task in
>> exception handling so that it does not depend on the place where it's
>> interrupted.
>>
>> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
>> handled and does not adds any overhead to existing code. Moreover, it
>> provides "true" NMI-like interrupts which can interrupt the kernel at
>> any time (even in exception handling). This is particularly crucial for
>> RAS errors which needs to be handled as fast as possible to avoid any
>> fault propagation.
>>
>> A test suite is available as a separate kselftest module. In order to
>> build it, you can use the following command:
>>
>> $ KDIR=<build_dir> make O=build TARGETS="riscv/sse"-j $(($(nproc)-1)) -C tools/testing/selftests
>>
>> Then load the module using:
>>
>> $ sh run_sse_test.sh
>>
>> A KVM SBI SSE extension implementation is available at [2].
>>
>> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
>> Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]
> 
> I updated these to apply on Linus' current master, commit 5472d60c129f, 
> cleaned up the checkpatch.pl --strict issues, applied Anup's pr_info() 
> suggestion, and pushed them up here to make it convenient for folks to 
> integrate and test:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pjw/riscv.git/?h=riscv-experimental-for-v6.18
> 
> Am assuming you didn't have other changes that you wanted to make; let me 
> know if that's not the case.

Indeed, I do not have pending modification for this series. The KVM SBI
SSE support will be submitted later that year.

> 
> I noticed that you asked for folks to do additional testing, particularly 
> of the SBI PMU driver integration, but didn't notice any additional 
> Tested-by:s.  It would be great if other folks on the list could do some 
> focused testing now, particularly since we're on v7 of this series, and 
> I'm sure others care about this.

 I would have prefer a bit more reviews and testing before going through
since SSE can be quite intrusive at execution time (even though the
classic IRQ path should not be impacted, I expect mostly feedback/bugs
from the SSE handling path itself). We'll see in a few days if people
find such problems.

Thanks,

Clément


> 
> 
> thanks,
> 
> - Paul
> 


