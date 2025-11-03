Return-Path: <linux-kernel+bounces-883438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BBC2D770
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB26F3ADDA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF86931B10E;
	Mon,  3 Nov 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="i4R86Lv4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445763126B6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190650; cv=none; b=Zez7k3LIkihq/6LZvspmW88bHNI6XrVoqb+kahSCcLLsyNXn5zncFU0lkD9i2nMeB8RVDxeJwMW/NdgYVIbbC9H+82MzExqRaL0GksCmnypNm/BV/Tq6x0gD1HMN2vceH90DVS+er+KbwVpbZat/KpmW98iox6F714E8+cmFEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190650; c=relaxed/simple;
	bh=mN9G/Z1vY3bEMQPr/JrTS8Wja+pJsTsTVz8Tjsq8Uas=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=sk+IOdwvTVRv/2LMsBrESqFbS58R8Gj1mM9AK87lBgMLaKrZkULcVAPZcliIgehSpsAutiq+rClZ13cSDhU2WKTa4LvPrTow0vG6Rc3Yn5sMjeClNu99cgFDeZapW/Q36Ol8FEqIF+HJLdc4gBzQ+yuJGb+pzxeyCz/LIyxlJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=i4R86Lv4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4769bb77eb9so4793575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762190644; x=1762795444; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqqBVuJmR63IDNhhp80d35gpuVaRjLT+Q9SYsgYK1NQ=;
        b=i4R86Lv4BaDjshkA2RJftBUiQn0aVuEg6lMiTbcRts2J8SYfgn1SAkVD5B4hAAgHKk
         CZ82zKXxUWteR7WHsRy1263OrxPWZAMk6OCeX8UDBc5wAHZGURunie+xgYkmPTl5d+eC
         x5c2P8pYMeLeRobaDCklRXE1qbG+mbFGE4u0JnZ7/+8uH0QcQ9imCAPUi8g9gE9Fnd3M
         vEpIBvHk8YAk9eNFJ9UvSNkqg8iwmOCoX7SxBpzFirUNNc9nEuDJNObudZ3eKuasPVoa
         AmoRMQGUx82enD6R8kAipbSc2vFpT3S0eVxpG9NbfF5lD4pslM+Uyw9omK/nGHmziw/t
         c5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190644; x=1762795444;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqqBVuJmR63IDNhhp80d35gpuVaRjLT+Q9SYsgYK1NQ=;
        b=EJqFLgjXDzT4/x1hefGJaq+juLyCdMOj/HSc2ZX4OrjEXMaa9Wzqg/uiU2ZP968sfD
         CRfomSQtX70D7DuJNyDlDXTqhbZXRUYyPyFdPBauUHd0eDw5nSAmPRg126YglyXrLay9
         MKPHvVqseGIY8sli+jN+7lNJTnZQQ5Xohq/diTo2pqUsmAmFAwB8GuqtaPqRunRvSPBQ
         FGApuWUs4upujHTDs1BKGPs3PR8qZxfbzCFL2GwdccS+DNlfHQ1xV0U+MaCU4pImWdh0
         5pCnSrOCn5GCiyOyaPnz5DxD3NR1CIXEsXTJ4NEJp1IbBJjD4yDPMx8ljkODos5/Xp1O
         jJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVRKmsB1n7VICZDCJeEOL1RUFnD+nQLhEYX5bko1lS9Kq39iBDyWr3xbZevhOEFmP3ER/YdFYmfI2Nt00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBiwiagdgt8cEgM0BX6bDGsjKLNSxShZBhUzhK6RDL73F5DR6
	jNoytNjRIH1ZFvVr9kp/Q6mTxOI5bw+vyo7l8hIU741+ITOyrxV9YqDgaXNPsj2RF/Q=
X-Gm-Gg: ASbGncvj95DchN7WaKFWtJvnW9BLqdQ/A2720+H6zJyQNMRCXjAiW3tDJVBuVRSx5S4
	89mA7scQtJSwJTVEwC2zXhsebYh9C0lDr9jUUPKeI36kcNK85iH+X6a7uCpcfEU9Ln8z2/CKb5Y
	m2IuRkWUZDjlQsDbp7giyvRaDpClhii+2V1AtW2yCgkjIrDUEILs5e54SQeQFqM8lNbBbYmyX2i
	T3+L+yct7732beDWP3r4mwqlCgg9dcH97PBjv7CRF71sHU9vKJFBzOmnNtuLvCsbD8hlYch55FQ
	NWRfhDCEfAA/HHTPIFBIhxSTJIZU77FSyGQW6vxUPig2zsQtNZEPP6hGw7O/ZPhy1qsuKRxvbZ2
	/BoaLc9Z/PKefp4IqtE4utiXWoIg+Zcld+8ntddDnyNk3YpCKozPs8Oxc61oIR1GBYpbZTi+bvI
	w=
X-Google-Smtp-Source: AGHT+IH8SUlODHNS7u6OTUXw57n29tXocbjwTvu8e3spDVsip8NoE9wR82cZ2MJR9n3VuQdaP6nEKw==
X-Received: by 2002:a05:600c:4eca:b0:471:1387:377e with SMTP id 5b1f17b1804b1-477308ef9f2mr74631625e9.6.1762190644383;
        Mon, 03 Nov 2025 09:24:04 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c383b75sm206919615e9.11.2025.11.03.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 18:23:52 +0100
Message-Id: <DDZ8G0K2921V.8B66OPQY2GXG@ventanamicro.com>
Cc: "Conor Dooley" <conor@kernel.org>, <paul.walmsley@sifive.com>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <luxu.kernel@bytedance.com>, <atishp@rivosinc.com>, <cleger@rivosinc.com>,
 <ajones@ventanamicro.com>, <apatel@ventanamicro.com>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <songshuaishuai@tinylab.org>, <bjorn@rivosinc.com>, <charlie@rivosinc.com>,
 <masahiroy@kernel.org>, <valentina.fernandezalanis@microchip.com>,
 <jassisinghbrar@gmail.com>, <conor.dooley@microchip.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "yunhui cui" <cuiyunhui@bytedance.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [External] Re: [PATCH 3/3] riscv: crash: use NMI to stop the
 CPU
References: <20251027133431.15321-1-cuiyunhui@bytedance.com>
 <20251027133431.15321-4-cuiyunhui@bytedance.com>
 <20251028-scallion-list-c8aa5f350286@spud>
 <DDTYKLFUE3M0.17GD0S4OSQG16@ventanamicro.com>
 <CAEEQ3wk8w1q8Ujpq+6fyRPP+zqTy6_q22K-g681VZyVXstPaDg@mail.gmail.com>
In-Reply-To: <CAEEQ3wk8w1q8Ujpq+6fyRPP+zqTy6_q22K-g681VZyVXstPaDg@mail.gmail.com>

2025-11-03T22:10:25+08:00, yunhui cui <cuiyunhui@bytedance.com>:
> Hi Radim,
>
> On Tue, Oct 28, 2025 at 8:36=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>>
>> 2025-10-28T10:42:12+00:00, Conor Dooley <conor@kernel.org>:
>> > On Mon, Oct 27, 2025 at 09:34:31PM +0800, Yunhui Cui wrote:
>> >> NMI is more robust than IPI for stopping CPUs during crashes,
>> >> especially with interrupts disabled. Add SBI_SSE_EVENT_LOCAL_CRASH_NM=
I
>> >> eventid to implement NMI for stopping CPUs.
>> >>
>> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> >> ---
>> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sb=
i.h
>> >> @@ -487,6 +487,7 @@ enum sbi_sse_attr_id {
>> >>  #define SBI_SSE_EVENT_GLOBAL_LOW_PRIO_RAS   0x00108000
>> >>  #define SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED       0xffff0000
>> >>  #define SBI_SSE_EVENT_LOCAL_UNKNOWN_NMI             0xffff0001
>> >> +#define SBI_SSE_EVENT_LOCAL_CRASH_NMI               0xffff0002
>>
>> This event isn't defined in the SBI pull request.
>>
>> I assume it's a pure software event that the platform shouldn't inject.
>> If we want to reserve more events for software use, why not make them
>> generic, like SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED?
>
> In fact, it's not just crash NMI, but also stop NMI, kgdb NMI, etc. An
> event can only register one SSE handler. If all use
> SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED, we'll have to execute each
> different NMI handler in sequence within the SSE handler, with each
> NMI handler checking for itself if there are NMIs of its type to
> process.
> Is that what you mean too?

My main point is that a platform doesn't seem to care what 0xffff0002 is
used for, so SBI could just assign a range of SSE event vectors for
software use, without trying to be overly specific about the purpose.
(I don't see a meaningful difference between 0xffff0000 and 0xffff0002.)

Demultiplexing a single SSE event vector is possible if event handlers
don't have to (or shouldn't) preempt each other.
I assume that we do need at least two software SSE event vectors, since
we should be able to interrupt other SSE handlers to execute the SSE
crash handler.
Do you think that two software SSE events are sufficient, or should we
aim to reserve more in SBI?

Thanks.

