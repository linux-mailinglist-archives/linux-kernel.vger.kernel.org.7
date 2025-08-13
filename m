Return-Path: <linux-kernel+bounces-766526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D10B247B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AB16CF13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533C2F0C44;
	Wed, 13 Aug 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FeILUOqG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3802EFDA9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082170; cv=none; b=GZaEHtFObgDbDrvV7Vd2774k5xrYztkD1Ghz1Dy2EhfVZ6Gd2Cbr4/HBQMaKWevIUdDOj4LITcgkAxt0DLeH3gBwu28/faBcvlmbIBj4J5qd9yUikuFQe6YR8OYsFzryzfCV/KaDrLNy0bBSjdd4ZhWGWCus5FkEfMBTCAJ40pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082170; c=relaxed/simple;
	bh=o12tWkv1rqEQ/2Gn1MjNVFiGD0fRX6TwDI8PFfPP8C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REGQ2D0BCJ7xuWJznkquH7hNfqLaNtitYuNWF5lZBQCjjzPg44+CpKSTkCIv6rovQzu8CVn61zkSxej/tj9fT+A14mzhz2DjvJgbv/hi0/L7KzcqUcLBdjAWA/jQ5k/pku/8wRHmOGSPz9rzcmj7+YakVbiYXVc6Y1/Fvd8B+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FeILUOqG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so5926996b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755082167; x=1755686967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsJrMOipXi6ygDGi8uaWJElErqj//d6RNhZ0Csh1gV4=;
        b=FeILUOqGD4E7X+N7+T1QACMJBnr+xjwHzNTr7XAwOuLSRRLlHVtMjSy097js1hfybv
         voeMaS8s8z9lYzIVtGWKUHflYVOMFpOoSDfUZClJtP9NZ233RE5ComFkyCQMrCQsRrji
         Fvyee7ZQHxV/37C1UND4ry6ECK/u4b7VQpf8QLNmsvm5kvVzv1IGBH6JTRXn3gwj/4TQ
         DG1e0So39/Xuypr0g5DDnGRQCtfrcYjDtVy99A5cBxZuUnOKpASQ+NiLA2lgMQOAAgix
         gdNeJo3voM0GKe+SrIOjJg2rY5QfgJ4upe8w9zMWWfwN3cP+NcHBPtqVK0RhOsuMcC3e
         O7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082167; x=1755686967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsJrMOipXi6ygDGi8uaWJElErqj//d6RNhZ0Csh1gV4=;
        b=u5i6gYYFc6MilJp/MYQXcpdh8xoAyzQw6y0RKZ1Kq2OCpLnOSwNYGcreWVM6yJUkPp
         zNsKBejyo3FmL/esf4uYp8wvRYy6lSoLW4l7MmHkCmuM2wLYfgYlJi+rFHy9bVskp7Wr
         8J983NIImuMZdrDvDlaNlDvkDtn9+oh3PmYNcP27OqKVK1v8rfYzwEybmfxtbXRIIDcv
         FtwhQbnvC1gr10GkBfFEE9em0N3RzsfuEPgGketjGa3XMx46h7qNsdywqbxZ7fGjEhan
         uZhsfO9GLYc7cZs8qd/a0FNty08SZBqCOefhv35OR+qHSLoHp0Iwmnr0xoFJRNp7hdL6
         7bzw==
X-Forwarded-Encrypted: i=1; AJvYcCVdDTkXX+wUYrYwZTIppCBfVKPG4l2fujTFvxj9EX4QKqbUEJciTQnRcGjqB9FTwKNAmKwf+6FyyPn1A38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBGvOax8lcZvLmyTwtnX4FKbsdASUNc8Zg/C4kq0I0lzjqxg3
	73xRIPEnaiyoUAuRIIRBnQ2ddOe0rGooJk8b+5bQvCytzHtkGx+2dgL8kI8bKoXeQG4=
X-Gm-Gg: ASbGncv8WccjGyLMlPL0qxYu0g1K6xNdJSViglOJbbH4vx1WEeICppoDcdYPIw29csr
	Ox15GnrYm/opvu/n79IeX3PklrRaULe6KVm+TJfhRR31T5zR32fZB15RotGpRCgGnaC0xAVPJRN
	O3lA+nGZLatmigd8lIxe6xXgEvLSljLjk00+Hq1Nutelr+V0TrlmaGYI7a9/ORsxFFThIL1kwLB
	i5i/DYbDz++aVq5apiiOCg5wkwEc4QwuCqJb3lBOWgS4xaXqkzrpANY4d41BkLFBh15h/8pFJI5
	anKxHMmCPgTb3Pg/WCE20gXhYlSTCaLP61k4VtRCCmbo+1yuoCws3qB+N0NsJ1nhWd9KS8kbnq7
	vWjm2S8BX/0/3fZcVU/pBxi3/+UopGWNTjSHHCqBm41Iv4qIjG5GXu2TegHLHk53P1L8=
X-Google-Smtp-Source: AGHT+IE/YM3UenWxDGDj1rUFrnUNo+PQmT4iczHqOZXZc8fbF1ObrznKIkApKXpNIvM2AlxhxVfRXg==
X-Received: by 2002:a05:6a21:3381:b0:23e:19fd:e18f with SMTP id adf61e73a8af0-240a8b5e5camr4481586637.35.1755082166961;
        Wed, 13 Aug 2025 03:49:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae2fe7sm27486647a12.44.2025.08.13.03.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:49:26 -0700 (PDT)
Message-ID: <2a9906d7-c914-4e69-8c72-ac848659650c@rivosinc.com>
Date: Wed, 13 Aug 2025 12:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] riscv: add SBI SSE extension definitions
To: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-2-cleger@rivosinc.com>
 <d0f8d0d8-fb46-4009-a50f-3faacf8516fc@ghiti.fr>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <d0f8d0d8-fb46-4009-a50f-3faacf8516fc@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/08/2025 11:01, Alexandre Ghiti wrote:
> Hi Clément,
> 
> On 8/8/25 17:38, Clément Léger wrote:
>> Add needed definitions for SBI Supervisor Software Events extension [1].
>> This extension enables the SBI to inject events into supervisor software
>> much like ARM SDEI.
>>
>> [1] https://lists.riscv.org/g/tech-prs/message/515
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/sbi.h | 61 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 341e74238aa0..e4993fb664d2 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -36,6 +36,7 @@ enum sbi_ext_id {
>>       SBI_EXT_STA = 0x535441,
>>       SBI_EXT_NACL = 0x4E41434C,
>>       SBI_EXT_FWFT = 0x46574654,
>> +    SBI_EXT_SSE = 0x535345,
>>         /* Experimentals extensions must lie within this range */
>>       SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>> @@ -430,6 +431,66 @@ enum sbi_fwft_feature_t {
>>     #define SBI_FWFT_SET_FLAG_LOCK            BIT(0)
>>   +enum sbi_ext_sse_fid {
>> +    SBI_SSE_EVENT_ATTR_READ = 0,
>> +    SBI_SSE_EVENT_ATTR_WRITE,
>> +    SBI_SSE_EVENT_REGISTER,
>> +    SBI_SSE_EVENT_UNREGISTER,
>> +    SBI_SSE_EVENT_ENABLE,
>> +    SBI_SSE_EVENT_DISABLE,
>> +    SBI_SSE_EVENT_COMPLETE,
>> +    SBI_SSE_EVENT_SIGNAL,
> 
> 
> Nit but in the specification this event is referred as "inject" instead
> of "signal", any reason to change that naming?

Hi Alex,

That's mostly for historic reason, spec changed that after a few
revision. I'll update that.

Thanks,

Clément
> 
> 
>> +    SBI_SSE_EVENT_HART_UNMASK,
>> +    SBI_SSE_EVENT_HART_MASK,
>> +};
>> +
>> +enum sbi_sse_state {
>> +    SBI_SSE_STATE_UNUSED     = 0,
>> +    SBI_SSE_STATE_REGISTERED = 1,
>> +    SBI_SSE_STATE_ENABLED    = 2,
>> +    SBI_SSE_STATE_RUNNING    = 3,
>> +};
>> +
>> +/* SBI SSE Event Attributes. */
>> +enum sbi_sse_attr_id {
>> +    SBI_SSE_ATTR_STATUS        = 0x00000000,
>> +    SBI_SSE_ATTR_PRIO        = 0x00000001,
>> +    SBI_SSE_ATTR_CONFIG        = 0x00000002,
>> +    SBI_SSE_ATTR_PREFERRED_HART    = 0x00000003,
>> +    SBI_SSE_ATTR_ENTRY_PC        = 0x00000004,
>> +    SBI_SSE_ATTR_ENTRY_ARG        = 0x00000005,
>> +    SBI_SSE_ATTR_INTERRUPTED_SEPC    = 0x00000006,
>> +    SBI_SSE_ATTR_INTERRUPTED_FLAGS    = 0x00000007,
>> +    SBI_SSE_ATTR_INTERRUPTED_A6    = 0x00000008,
>> +    SBI_SSE_ATTR_INTERRUPTED_A7    = 0x00000009,
>> +
>> +    SBI_SSE_ATTR_MAX        = 0x0000000A
>> +};
>> +
>> +#define SBI_SSE_ATTR_STATUS_STATE_OFFSET    0
>> +#define SBI_SSE_ATTR_STATUS_STATE_MASK        0x3
>> +#define SBI_SSE_ATTR_STATUS_PENDING_OFFSET    2
>> +#define SBI_SSE_ATTR_STATUS_INJECT_OFFSET    3
>> +
>> +#define SBI_SSE_ATTR_CONFIG_ONESHOT    BIT(0)
>> +
>> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPP    BIT(0)
>> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_SSTATUS_SPIE    BIT(1)
>> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPV    BIT(2)
>> +#define SBI_SSE_ATTR_INTERRUPTED_FLAGS_HSTATUS_SPVP    BIT(3)
>> +
>> +#define SBI_SSE_EVENT_LOCAL_HIGH_PRIO_RAS    0x00000000
>> +#define SBI_SSE_EVENT_LOCAL_DOUBLE_TRAP        0x00000001
>> +#define SBI_SSE_EVENT_GLOBAL_HIGH_PRIO_RAS    0x00008000
>> +#define SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW    0x00010000
>> +#define SBI_SSE_EVENT_LOCAL_LOW_PRIO_RAS    0x00100000
>> +#define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS    0x00108000
>> +#define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED    0xffff0000
>> +#define SBI_SSE_EVENT_GLOBAL_SOFTWARE_INJECTED    0xffff8000
> 
> 
> And here you use "injected".
> 
> 
>> +
>> +#define SBI_SSE_EVENT_PLATFORM        BIT(14)
>> +#define SBI_SSE_EVENT_GLOBAL        BIT(15)
>> +
>>   /* SBI spec version fields */
>>   #define SBI_SPEC_VERSION_DEFAULT    0x1
>>   #define SBI_SPEC_VERSION_MAJOR_SHIFT    24


