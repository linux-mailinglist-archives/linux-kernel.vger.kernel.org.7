Return-Path: <linux-kernel+bounces-871674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B1C0E1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82FB4FB94C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4EE2E7F05;
	Mon, 27 Oct 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Gb+zulSB"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9B2E2DF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571784; cv=none; b=UpT0hz6EAq9uP0NdZwa741rhZQweZlcWr8Z/iDntpssaEDJuSnX4l84MzrCtNz9rA1V9XNAih/G9ALv+zqEL7ngy6mvwfusgeD0+vgNBl49LlqBTHYUiVyvrI/fMtI6tKACLYbE0LCvM9ZTlHtx4SPeG8fTSodE5TutBvUaXU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571784; c=relaxed/simple;
	bh=q2srYrWDDzGeN8zZLSRRC143sp6OpAMUt8IpPashUGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP/W6up8nOErgSzMQnQxW74ur0Dq0ClOqdJKqUYZAdDU1pw7fgMOYanXwA1peM6OrtHZllWAwze/J4jRei45S5Fu1NQxwe01eaGhmsTAyWaT8tiZjcXRNVJu6pdgQmhWaE7u1kT6XTfoSY+0LW45CWeDGEYzRLjjpCmqRcK0HWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Gb+zulSB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso4265255a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761571781; x=1762176581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Wt2P3rgJn+5UKGAbxiwQscDH8snP1L4I/rTGNdNX60=;
        b=Gb+zulSBCe7xWQI1ue3Jhkf7qopFPnrvLZwsMSSdYxci4qyH4/ABuYiaFGL6BAu3EY
         WmXDVtv3YJx45r9gegtAKk3Bco8lcLzJoHs2US9asExsmxlJOopx09UTLp3nDZOZV/ya
         TAaD68vpctm/HUrHDbxRyuIHTuqL5B6ry9oPfCMN/PfK51BDXNtz91gkmeySE79liBia
         pg8OR85tHqskMZNhYOE/Jw8YnM+K5m0HVZXK1DCaBrJ3b77L5Ob6Yhbt8VvobfDvFou4
         m0O8L+m9J4sXqwk94MLi3yRB7WiTw+mls3RERLUPLJVlyThZebncMH7LuKs+0DsdL3YF
         piew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571781; x=1762176581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wt2P3rgJn+5UKGAbxiwQscDH8snP1L4I/rTGNdNX60=;
        b=W7AXuag1lNumqtyan2lHhZD0JNtO/TuzDElxC8cCOUJ1ZqiAPlKdDy86jDF2XzSSvi
         81mx3NY56GXz1Y6hv+CtZQhBz7HkxQUcSR0DeGjTEs1Au+14utibSFPeyouGR3Pq0ORs
         TCxDR1GyG5kWxlSPuCCKnu9Nhb3MLI1HaDsHDuRDvjlP2y13PUOWZoH/OR/GFtPH4Bsv
         WJDpHDxBmqvPIujBNG/9djJrr9J5iS0qYoaYTeUS9nPAGOW00kwp7XKu7ZBqFhLlsnaA
         4lByH3x9XCtV+2aXldWV93s1/fug3YJU83MTUFCcJ8HictYhKFvqPU5sUVAKx1IOYr39
         NKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwnd3VNSfKz8X8DHL0bjdKYwJGQU7Z3XrM1qgLDi5Cuz3kT/rMio/jtHUNkSMJGkDP3cltfM/q5IB1Z4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsN7goQWKOwTOmsNfLBVEGWRBMvRTf5KE+QYhv4ftDPUXxMIP
	mkF/odJqA5pVeYW9jzcKEWB5N4GvpfzuAk8ldXn7GMuvZ7iyrYQ4X9/omnX/g0U5xM1D4fXfVid
	CX57fUDs=
X-Gm-Gg: ASbGnctWuQayOQXdiJa9XhH88/ufymY3NJIvDB0p2Yjy799LJRamO64VRDMwJbjtn2j
	Xb3heW8y6iT5gJVv09y9v4ZRs3AcrcxplIcmBsiNhshFXR979AYE0jmrTN60miYYITUh6syD7Iz
	Rmn7IrVH4YsOM6jl4gZhluWJMctOUJuZioFiVnlb4rOQJtWNd3UiaUTpYUm5AWsBR7Uevl4+0JC
	yPJia20n+8jt7CAwDURf0hYZepKbdo0aJwWqHWPs8JvEqk9qYTnKSdzNSXHK6cHV+NmRnk+85wI
	edhIDgN//r6T94w9+UcvrZJ2X/Zky2iehc3njwSUB/tnYSOFhSc5bey1ZdY8t8sKpS5gE2VZwaR
	+hqqXJwuTbIhAqbwTs3Gf+VRBz9l2PBYjDshTAEjDWtuSEWgQC+cWgbTS7F0nBgiT20VrgC3ZrE
	kHupqdZQ/rFK53rTfnnlW6zHEnpocLE9rwZnuqOL49KlyTeg==
X-Google-Smtp-Source: AGHT+IGhfwb4u5norrCouP8BPxoTLYfO2XYGgio+ddfcnsYJ7Y7fRmFkfkRRSKjz9BOxITMsUStHfA==
X-Received: by 2002:a17:903:9ce:b0:267:bd8d:19e with SMTP id d9443c01a7336-2948b9a823fmr133319325ad.22.1761571781056;
        Mon, 27 Oct 2025 06:29:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed5b056dsm4181028a91.1.2025.10.27.06.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:29:40 -0700 (PDT)
Message-ID: <2b4cd5a6-98f8-4ec6-bdac-c6c7dae84049@rivosinc.com>
Date: Mon, 27 Oct 2025 14:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v7 2/5] riscv: add support for SBI Supervisor
 Software Events extension
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Atish Patra <atishp@atishpatra.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <20250908181717.1997461-3-cleger@rivosinc.com>
 <CAPYmKFuVC3CwHbytPzQCHOYPoQp2LhucbLRRRRsqHk9upkrW8A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAPYmKFuVC3CwHbytPzQCHOYPoQp2LhucbLRRRRsqHk9upkrW8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/27/25 13:00, Xu Lu wrote:
>> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
>> +{
>> +       nmi_enter();
>> +
>> +       /* Retrieve missing GPRs from SBI */
>> +       sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
>> +                 SBI_SSE_ATTR_INTERRUPTED_A6,
>> +                 (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
>> +                 arch_evt->interrupted_phys, 0, 0);
>> +
>> +       memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt->interrupted));
>> +
>> +       sse_handle_event(arch_evt, regs);
>> +
>> +       /*
>> +        * The SSE delivery path does not uses the "standard" exception path
>> +        * (see sse_entry.S) and does not process any pending signal/softirqs
>> +        * due to being similar to a NMI.
>> +        * Some drivers (PMU, RAS) enqueue pending work that needs to be handled
>> +        * as soon as possible by bottom halves. For that purpose, set the SIP
>> +        * software interrupt pending bit which will force a software interrupt
>> +        * to be serviced once interrupts are reenabled in the interrupted
>> +        * context if they were masked or directly if unmasked.
>> +        */
>> +       csr_set(CSR_IP, IE_SIE);
> IE_SIE may not always be enabled in CSR_IE(for example when we disable
> CONFIG_ACLINT_SSWI and use imsic for ipi). Maybe we should send ipi to
> the current cpu here.

Hi Xu,

Indeed, that's a good catch. Sending an IPI will be more generic.

Thanks,

Clément

> 
> Best regards,
> Xu Lu


