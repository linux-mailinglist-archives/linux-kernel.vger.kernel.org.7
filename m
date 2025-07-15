Return-Path: <linux-kernel+bounces-731686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B4B0583F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E6B1A60DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A92459E1;
	Tue, 15 Jul 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNxx62zh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB51D5ABA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577183; cv=none; b=DS2htOZO4A7TGvgR642eXWhgvUDAt2PKFrrTnRvbQ19M24Ok4WZ0tSekjLoB1doBo1OGiOgzyNYnfWAoUXw9h/wYm4tfZSCdNizo5ck1mowidG74jZI5EmVRTdCaHeVDlsU0jX3P4qdnCYRfmMvwKGGHxArFa++UZ8rgogUvWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577183; c=relaxed/simple;
	bh=rMYalLLeEd3S1xA1irQwZxfnCL4Yquiy1wHAHkzdyws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlzO0R0b/WvXMk7yO1NisEBhjCxkOTA4t7WmbP5e187+k/KpbBxmbTvN98DwQsuiN+vls1ONf8BFr0VBj7EPNkKlZobTF8awuLyuF75EX2odGytBvSq0YHZpv7+vDDcHeRJUoJ8VHmaezTX1LCwI6O4HbKRBi74tPIPrchAAjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNxx62zh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so37597075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752577180; x=1753181980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toCJyDKQNk5HbhRNwLuMhsfzyo6mnXy56DMD8XUxftA=;
        b=fNxx62zhsKlNbRh/RzFGAN1Jy2hizz7moBWw+t/ltGXKuPRWK8MgizS1QeafPf7x97
         /U+U5Q0f5yYXCXTxjjkN7lgNIJlenOupjtYrf5X03R0nxovskwA77clBHl+wi1xYL4l2
         7kr2FGe3od156/56r9JhP5LCzZW4y9pcnGR+3IapHm+rXHQrjCvqfVofPfUNHoCeTNNb
         4pq50gKn4i3+GrYigJts2i2cQzzzhY/UeofiXMPA6c8fqASAncCBUfCJkLFPrf5b0zOi
         +bzzzKlyLBhMUAn/Ze6MtTmGk4SvJfcBitHvzeAo0UN30rTzlHD29Jfcyt3EjJzsCIRl
         rvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577180; x=1753181980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toCJyDKQNk5HbhRNwLuMhsfzyo6mnXy56DMD8XUxftA=;
        b=VRVPeJo6+Bict+wNA0OlCVO1nQq1o6BonRQx/CgveEf+suepqFLN5bxLgc7ZSeopXT
         LQhG7wTd2qW1PsbV6puYYStaBRrQhHabTAGOUA14jPAP8lxFJ4Y1MHji9oiA4cjvwqE/
         mRupwv5upBfk966V7ROA5GETWJzsBwr3gl9apbKV0IzY6K1wRu4GMKWfi1oT+HId429T
         LN5PtNZkbl6KmGFPI2QIzQwk60u4d923EOao5FWTSC8U9MvSwB8VWEM/MAt+dClHqoML
         R3gl0ZhQjZkVEg1EAMPDvtd3yM2bjf3YrAtQ9vAVcfVoukvpBa5MClGNzLOX+pH6UpKm
         98YA==
X-Forwarded-Encrypted: i=1; AJvYcCV2JIZbDpFTVmDk4MYjTPhIfvebDWaKZ5o/B1A4n00zu9rBtjIlDqKp3qw0rPe83KJ3Vri/LNdRbS+5fzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfijlqxErluKkVyUiOwcMd+9BWYKzOQYzJIWlvqosQ59fBBry
	95eV2sc3VThaCte8z+MITdo053ETOp2p40/w9ZlvO5vXNl2NgvN4Nv903iOJrhec6zg=
X-Gm-Gg: ASbGncvIutpPSIfbxcgcMHMpz3qlumKIl+1OAUBbDqEYgUI+1QfP7S7I7dD1gzowFWq
	373UdHuKzZ6hAa8QRddUNG4GXqhEUPtDoRpcs9uPQFhTXRB1xx93b8Khz26ACXz7DEveaLTZiJN
	4DVclGUWGVuEE1ECmbPIYe7u3MCN7tptiGCxwZRUMQwxmUlZFiMml7P4XoBz8gSrnHnMQvP5tbv
	xVUiySSPPoTktCxrh7a5gjITOjC4jryb1ypM0rB7CZXhjHbF4FtivlX2OCejBMjqTLf27XZD2So
	0OkErPmoTZu3QdTxRfWhH0qATyvtzIjg6IwzG44o9Divq4pfUdRWLoyC0IKykrmgXb+U6U1m0Bb
	kVErdTVv6CVpaaQKeYXe+jjcsTSkuDMCz6ZJPr1G4l53O17zBiUpVR4QXL1hD
X-Google-Smtp-Source: AGHT+IH9yNop1DNzjKnyhvWDzas7yapCZPG85Uz0SgzV9JDeFte7MdK67izXkmMUDo23mW7w8RaLRA==
X-Received: by 2002:a05:600c:a308:b0:455:fab4:4b80 with SMTP id 5b1f17b1804b1-455fab44c03mr92497205e9.19.1752577179889;
        Tue, 15 Jul 2025 03:59:39 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562797b8d2sm15984945e9.8.2025.07.15.03.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:59:39 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:59:37 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] clocksource/drivers/timer-clint: Add T-Head C9xx clint
Message-ID: <aHY0mWEx8_z_nJoU@mai.linaro.org>
References: <20250623231536.1120282-1-Mr.Bossman075@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623231536.1120282-1-Mr.Bossman075@gmail.com>

On Mon, Jun 23, 2025 at 07:15:36PM -0400, Jesse Taube wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> care two points:
> 
> 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> add a quirk for lacking mtime register") of opensbi:
> 
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
> 
> So, we need to fall back to read time CSR instead of mtime register.
> Add riscv_csr_time_available static key for this purpose.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> Treat this as a completely new patch, as it is mostly rewritten.

[ ... ]

> V5 -> V6:
>  - Add csr_clock_next_event
>  - Add csr_get_cycles64 to sched_clock_register
>  - Break get_cycles64 into csr_get_cycles64 and clint_get_cycles64
>  - Change default behavior to use CSR time register

[ ... ]

Any comments for these changes from the arch maintainer ?

Thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

