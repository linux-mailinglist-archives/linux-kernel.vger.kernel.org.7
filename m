Return-Path: <linux-kernel+bounces-764834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0776B227C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAC01BC3F18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB827932D;
	Tue, 12 Aug 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="KBC7fYIt"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50825A331
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003436; cv=none; b=Pcwt82r1qnZ5VSGV/dNHhtZtKKSHe9u/W49PUSx76SjnclfdUD9T6I3UssZLlkyNHCrW71ZsetRfirdty8hxQ9rjDFXKMy44+WzXmTpKpeXrDGpY28ZPwYmowhwktZKU5xsliDE6PKEiPFcLEcppLrlEwnNXq9TOmLPP5TvZtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003436; c=relaxed/simple;
	bh=mzD8sr4w2A+BSz1Y6ofS4iGUheeGjGjvJekxF47ge+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5sGyzc702t4iCVYNPavFLwaADAjBrnqM7FNgCtSmkcvTcym6iE70PS5733C0Qgf1SAuDvCkxgaB1kdAIPFxLd4Ny/QW/K4attN30r99bpq8aC5pb0wTP/ZikAoh4q/pq5+GmqwMNajPxqzizreQTIm72VaYoVxDyAWv/uY3zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=KBC7fYIt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bd7676e60so4613101b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755003433; x=1755608233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CQwup3JJa1ayhdQThgOgG4MUx5X/EUx4Tii1T+qif0=;
        b=KBC7fYItnoD5Rw90aUlppQIX6xTtoajxiWHQXbT2y11VjzZWzJKu2LbrewK8JLFM1N
         974Hwk52+HTA8zZdKUkGUH3kUebNTp0oSJfY1xYZaeNSKkPHcIiP79jwZRhDGa6ZsmNl
         pE8dvVc/Vz18pvt/VZ5n/B5vAh14qNtIJo8yBWBxMbONkb4QbIx42MxxxbtTa1rnAMbs
         QwgHhl+kJNtUVzvzZ61LeaWLoX5qPwJ27lzLD47UtTvO+M6JCJU1XlszGQZSrOnoX9WQ
         2BWUklrwu8Xc3wGwTYZWQ6FV9dtrvMrUF2doHLfVx0Wc1zbZgwBbsb+Bln2kLC8PH0eq
         opNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003433; x=1755608233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CQwup3JJa1ayhdQThgOgG4MUx5X/EUx4Tii1T+qif0=;
        b=vCW2GTJxHNSfyEHTeO6E4QC/pFjuz7+8qYkjNGHWldYFg/DQW0Vz9HV5pHcst1L4Fn
         yFvbeT4+Q0/Dl4lE4BSzXTj/tAq5yDzEmQj7oG8vK6qY+IPExpfQo/eurPwUqodvyWVi
         Ukx/CiPJyaJi1JgR7v+WXAIqaIBCiUSAwvtfpgZxrRQrsZ2onDO19gcMCA4ICxhiC3r1
         MR6BO4BIlkjkmjUD8B9mig71RWeLZBEp4D0Hm2W3XOmB1TmvpzKgbL1JDX2a9t+NTUJD
         1BwJBKwz2krvU9zugv6dYhNiIiE37t0+KzgTyP0/2ZetIHBuPuxT7aFZU0l0oGYKZIPG
         H5cw==
X-Forwarded-Encrypted: i=1; AJvYcCXICx0FMba1I8xMmfrF7xlh1K/gx2pucUf86qly3HDdsTpI5OxIRdBKX+hOJG6+soetSEg/BxeK6FrAcV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFlqi1PezpZSgWxXXdzfXak6H70Z1g5xFwdnKmVBUM1rY4bI+
	M7Ma0O+quxPqTjx9VhmSgtKDWumpI5STHH4F5MqVk35fpDXSSQHCrDzEYUe0d84ouqk=
X-Gm-Gg: ASbGnctE+rCfZtuwgeJGMxjgTY7QfrdAf2t4CCOgukzdVp/YKefVhZNt7vCG1mxfF+z
	/zcaROwxmL/byZtv/11v/JHP8JAv/vjDI38JWPMrm3jgkChQpqsmt4NM1Loe6LKr3ogz1M4iwKp
	3y4Fl3OxsDI70BzPN3TFlMQ4oxU6p45ns18Dt3Ys/8RVZtjfRnYDRcyvlJ6ejkIQxu+3zRPwoSl
	J0zwX9G6ndbATVF31pg4wl9gKkLOIVfVNO+4mXU8Xs8CqQTCfB/HBsZijL4b9MF3ftsxXwN+OrV
	UVQQK/gbE68a3lSUVTKguANOhcQjr+9F9u8Lf+6wU+p9GVQMymPd/XhrQLiUCmCyBCxUCcR2aPV
	RlrBZbQrChaxQBykpeu+efMmxXNjzGWF8IMro3m8A/GGXQ8918eo7lONI5puE3O1QPqRBNknbne
	CJ6Q==
X-Google-Smtp-Source: AGHT+IHLx2NmNN4eIHAGhJaj/DxTDLbTh85qThe6wdpXJOc29/KjHDsxypcCoyrdkW0QCjfRPpKYfQ==
X-Received: by 2002:a05:6a00:2d7:b0:76b:cf2b:18bf with SMTP id d2e1a72fcca58-76c4603e0c4mr17297275b3a.2.1755003433445;
        Tue, 12 Aug 2025 05:57:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd98csm29222812b3a.67.2025.08.12.05.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:57:12 -0700 (PDT)
Message-ID: <56c18c70-ebb9-4018-b8b6-9041337bb3c3@rivosinc.com>
Date: Tue, 12 Aug 2025 14:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v6 3/5] drivers: firmware: add riscv SSE
 support
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-4-cleger@rivosinc.com>
 <CAEEQ3wmUvQRx3HLG=i7fk60-wf1AtYmjV20Xbe2c5_RHi1c1gw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAEEQ3wmUvQRx3HLG=i7fk60-wf1AtYmjV20Xbe2c5_RHi1c1gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/08/2025 14:54, yunhui cui wrote:
>>                                                       &preferred_hart);
>> +                       if (ret)
>> +                               goto err_event_free;
>> +
>> +                       cpu = riscv_hartid_to_cpuid(preferred_hart);
>> +                       sse_global_event_update_cpu(event, cpu);
>> +
>> +                       ret = sse_sbi_register_event(event, event->global);
>> +                       if (ret)
>> +                               goto err_event_free;
>> +
>> +               } else {
>> +                       sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
>> +                                       SBI_SSE_EVENT_DISABLE);
>> +               }
> It is necessary to check the return value; otherwise, the event might
> be passed as a valid value to subsequent logic, such as
> sse_event_enable().
> 
> 

Hi Yunhui,

Indeed, nice catch. I'll fix that.

Thanks,

Clément

