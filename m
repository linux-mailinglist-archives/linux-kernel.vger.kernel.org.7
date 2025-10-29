Return-Path: <linux-kernel+bounces-876538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE41C1BDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6A45095BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24465330D51;
	Wed, 29 Oct 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="TQCu+f9b"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477F272816
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752120; cv=none; b=uofDQH/36qn9SPpdNfVqCZyhwKiRrEdno+7ctzEN2JRCKSvqX7VEpRcVmqhYfltDRyMNQ01dK1p/qLtaqmsZFIJFV9EgXiX/G4nFpuyxDp9JIJ9VZUBYgsRcVI7+mj5sYEa1YvEnlgpy8mzIlcjt0+2yMxyG2d4Hd2XzGcu0/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752120; c=relaxed/simple;
	bh=VS9zFfCKQfDabjtC/aOkbTUdrLT8y14H6pa7PkJCmXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRG7Fx0/fF6QamDe2g7bdi+EZT2JuPeAVOyYXRe/FLVw5iqa2+QdZUAzRxv5QYgJ+geOit+fhclCHXuZD/0XTDyBIHlz+7sdFGgdu+r0BaI+aIySz8/sgpvvCeYRYxYbngY2VvQY9PiyqiNbf6BReLtXM+It5H5sajoWbXK270M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=TQCu+f9b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so58034555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761752115; x=1762356915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLI3NZdHzrZYLWdy8/zoWvHAgFT9er17PaTQd3QXPMs=;
        b=TQCu+f9bnIn32TmH3H7vC4RJb7YE4t3MW/FQGWTOqxhf2ETwTuc7BVwo/JS7ZhtASF
         rZ/dChuCuKpCjmy9XvZdV31swkHC0dniWmuUNvDdFNt7e3khrVmSnF6go8tL2qq+B5mU
         Ki6ilBlOz+odo2szX0b8wj2sQu7lctCdUAeIG//d+c1tNWil9/uAAxeCAdCEiy07fTGC
         JwSuvSu7wFi9PkYB1KUsa9V4GuP8t5iysuDaSkMuZNBYoquXRoFy20BZN+4ZEmvMTltG
         rQWSdzKRpdCLfCHKB9GCjdKCQtJuptwNc/93ZtM6F4YFxUQqP37m3+q8o1ClCWhv7cTA
         jh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752115; x=1762356915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLI3NZdHzrZYLWdy8/zoWvHAgFT9er17PaTQd3QXPMs=;
        b=QGBFrYUAVRzzOkRy/HS5t2gCDBRK8/8j98EL3324KS5LC5Vtz+mCTcGedFaPcqIoxq
         GaHYXAWNAW63SAWKrRmckUDKo4WLHE7pMjFnLoXAA0db89Zm5/sMDkvT1rc8EcpRcly7
         mIwDloGpOV+XLoxJJ8Ib4RkYFcHScI+8Bk1ZonM/wW5dUuNZ1wKJWhxMc6McM9OOsyX6
         Zmn1DbvLSLHpP3KQdT3tQWlw/b+ggcWR24R4wlxbEvdMYpDFNJmFc+GS6fC+ucCsTWXl
         MxlfJr/nyUcsPQPSDFLS2kMgn4ibkRExni6np+H/JYLPWCR0AwViG8lwCDmYiMIxnjf4
         jMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNEp+OmGtY+LRBY3byd/KyjQJyME/CwZ6MiCxokQSsIqyPzx9J0NU6lm4FZ/JPWMNhszss14zcyR+3aEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZCbEqNJhEWL13nxZv/2uP44vVVHYtgCbffsBmzhzpy3kAv/N
	8hUvVfsf+PTBmkH7RuhhmzFcd2weVDsYKERqL5lirCnM9zo5PHJoUopX6YVm7IdIiBw=
X-Gm-Gg: ASbGncv02A+HrEoCMO84C/0omEDvV6x0OKRsKSIug0lp+IR7SHKJmIi+O9WKuaEGt5t
	BRj96Z8LeRfhjDF/xYVhnx21gSaf7dTWJIKBsxwe+4lpbPjHwQBi/v0RJacmRPmzx22w4ilu/Cq
	OjEjphH7HptnACZK7XL3dbfdrIBzgSK2ENCTfnvcO4Nf8esPrZ60BmQcACNCV+TUPTh4xO6W4PL
	Mw7qCDrbCbIZkzH1R0DEgwqApEjSuE+dS/nhpksUlp/bgEKsDHoYUi7mXmbvd9/pFsduCOv2ezK
	p66PJ/Isf7NapBl40bCil+ZEJKRvKR53yhDE2Mdm+2VmcKsnbQADez/VjTVLmCqXoLqiQRqdrDu
	YE3gvbb5z5gLsNOYDPtbmstRAzL3TvlG5iPdxFLux6rbi5E6VUKbF+HDDozibBPka7mbiEUKVKx
	WeP5uQeuBu7efGBBGr/BXi8h506rPpgoMCs7vaRELKQHx3DQ1L9FnrZKiZ+pE=
X-Google-Smtp-Source: AGHT+IE1War9zWW2DadyeaQTgCuzaEYVadTvhpK/iM6ucbryWIKimZJyW4F7rU2olGBmaok/ywFf6w==
X-Received: by 2002:a05:600d:839a:b0:475:dbb5:2397 with SMTP id 5b1f17b1804b1-4771e93fe4dmr17226345e9.0.1761752115477;
        Wed, 29 Oct 2025 08:35:15 -0700 (PDT)
Received: from ?IPV6:2001:861:3380:2e20:6214:6f9b:8e4c:f723? ([2001:861:3380:2e20:6214:6f9b:8e4c:f723])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196b27sm56962425e9.8.2025.10.29.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:35:14 -0700 (PDT)
Message-ID: <72ab3ef1-fcd7-4003-8393-e64159625125@rivosinc.com>
Date: Wed, 29 Oct 2025 16:35:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] drivers: firmware: add riscv SSE support
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <20250908181717.1997461-4-cleger@rivosinc.com>
 <CAPd4WezLU2TdpyUQ_UOT0SO=N+jbwEs4iVUKZ2_ngcGEJpSbNw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAPd4WezLU2TdpyUQ_UOT0SO=N+jbwEs4iVUKZ2_ngcGEJpSbNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/27/25 13:35, Himanshu Chauhan wrote:
>> +static int sse_pm_notifier(struct notifier_block *nb, unsigned long action,
>> +                          void *data)
>> +{
>> +       WARN_ON_ONCE(preemptible());
>> +
>> +       switch (action) {
>> +       case CPU_PM_ENTER:
>> +               sse_events_mask();
>> +               break;
>> +       case CPU_PM_EXIT:
>> +       case CPU_PM_ENTER_FAILED:
>> +               sse_events_unmask();
>> +               break;
>> +       default:
>> +               return NOTIFY_DONE;
>> +       }
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block sse_pm_nb = {
>> +       .notifier_call = sse_pm_notifier,
>> +};
>> +
>> +/*
>> + * Mask all CPUs and unregister all events on panic, reboot or kexec.
>> + */
>> +static int sse_reboot_notifier(struct notifier_block *nb, unsigned long action,
>> +                              void *data)
>> +{
>> +       cpuhp_remove_state(sse_hp_state);
>> +       sse_reset();
> Is this sse_reset required?
> I was running the poweroff command. The CPU teardown function is
> called and events are disabled & unregistered as part of it.
> when sse_reset is called, it again tries to call disable & unregister
> events for all cpus (nolock version). So I see errors from SBI that
> event is in invalid state. Commenting out sse_reset() wo

Hi Himanshu,

Yeah that is useless. I think it was there before you add PM support and
wasn't removed then. I'll remove it.

Thanks,

Clément


