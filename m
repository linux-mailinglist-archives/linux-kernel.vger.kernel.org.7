Return-Path: <linux-kernel+bounces-773386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BECB29F28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C4817FA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACDE258EEA;
	Mon, 18 Aug 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="H8UUTFuj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D7258EDA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512954; cv=none; b=QNlfQ8jYh6OIjUrl5M/xIRZY0Cz/oab7HWVG1TvhmrKcMyOORBlxKJ8aGXAxYvqdxfm2lEMip4hY5jcjbs0VYyFHyiXKgTQnXXwWlwHr5O+DYjlPez1klew9+gsPvtdYg5BXEp62mwfrUMbkjzGFv7o5jmzFWn7unOa4rwtG9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512954; c=relaxed/simple;
	bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=haEAuIVLcjs0+EqX19Ps+zNRc7Hjm0oJ4eI78UXUF3dHz+igkG/13jM6BxT2Z2MXAin+N7bcIPNYRuZbFImcvKzPgeLCMcldngNmOQ4CI1zPflmF8CGRk4FCcOXtGd2v4NEYf36hjbZnNJez4XFwevrTEoB87IxiuALlGAh+Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=H8UUTFuj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1fc6996aso2677735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755512951; x=1756117751; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
        b=H8UUTFujZ5bOLN6tfCzFgID6wonxXrPF9cK8Z+ZS9fyfn7aGURLVqHXgqUfi0r1/vT
         Sn5ORcibCb9aNtRsE/3btDwWwqXJZGMUURJjuWMjBC4l7T9zXMjCDo1M57XWLJlakU+l
         i2xjswyTWWLeLqPI7PT19ZhfG/PayiG1TGLWAI9BpBnIVjtqe8FmsjaE4txXpr5y6qRM
         kBWo98qzE6NncAWo39DOGtkOl77CnZymx9LV6pX2e0hE0mXXBX6HaP2BTNIo18pCZ6r3
         bWRWDQzCLZj6P8Nz4Dyj/0QiMOQ0SPrY+hnQXZVGLZR3tXU6mpsrcrBxprzPFe2GmO2b
         aSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755512951; x=1756117751;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhbysUcbAKjEA8/11kFRzX2E12IzlBavWPgZPsKEmYQ=;
        b=m/DQ9X09MRrTikXvU0mlqM3zP5gqggbKufT6dhlhc7GxzVoAit6D0wjdAFu7/wHIjV
         MlIzTdiK+IKCE/mTMdmzT2bx59SnbYvoTagUWo3ZXQA1R+7ebkTYR8oKb+EVzvCwIJex
         /tv7IMSqhVZn9j491OCf8l7/oQoYQKZcIObZr2UyIUZe4obRcE4wz35FuWYfBpqNSxCQ
         VoW1MCdUgVvH7z7CiB/ft4hYZXoUQM3W9cu9CZUJAR65om8I67ME/fSg7i2skVToL2YA
         EW08LBlDSAaKb77A1KzMgJQmeS4LFZjzVD9s6Y2TcgmajNz81u85tpYdErOHaOt/DfyL
         ZyHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXVsK/69bimCwGPhkzoXFYn8QM7wGkmduZ8N3zPIDjF9l+hG0AsgfQeayvDOYt11Mu2mhvrrJXnjgLrcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIyZXwzN7g7ebfS2LYpklXbyoS/T8ImR+HtC2dCVXubOpx1sS
	Ogbhly881HCjWVkH67L83zKgJn2Y62U0WCTuZveWUqcWQA2Zn1KZHaaxwt0DoaMZcFI=
X-Gm-Gg: ASbGncvj/KYSGYU3ExYTv3FF0TgFNLSNqF6yK9fTQ4l04q4820ZEbeQf7Z2HlBItnRj
	N9vc+sWTxvixcWKX7YzOqM/bDyL3eVwNmBgjfEKx+kmpw3zDd6gn+FjUi9FBGGndkCp5qPoxoE7
	NZbO/NOSm14hbgu7nwliZG6zj3hwnVbBMfMGgpAj+zJP76d/9vUQ3nfg4CtTVXhi6mrv1L39hUG
	rzEvJOVYA3VMRRLt4NvtTOvUEoohp5XC2m6PYihyNpXbK2Dp49wqjXvEKCLRyTUPCSDzqvqtZBv
	P9G9OIteVPqQs9WiwE1XDX6wK5yweWIl7wfNhOHEBX9fLJf5I9Kq5LuKR72aum4mutNDszM97oA
	MBcoBERX3Mv3ZFjABPoT8lJnAyS/eMA==
X-Google-Smtp-Source: AGHT+IFey14ol9S6TtNaCL77HGtEmBhLvnjzcHSJ5a+JMC7yNb3b8k4bUmeKUn0yZJ7mbxDU1Gpejg==
X-Received: by 2002:a05:600c:46cf:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45a21781fb3mr36116495e9.0.1755512950889;
        Mon, 18 Aug 2025 03:29:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:faeb:f88c:9e29:5aa1])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a2232de40sm125126805e9.26.2025.08.18.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 12:29:10 +0200
Message-Id: <DC5HEJRMZ84K.34OPU922A7XBE@ventanamicro.com>
Subject: Re: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Alexandre Ghiti" <alex@ghiti.fr>, "Andrew
 Jones" <ajones@ventanamicro.com>, "Anup Patel" <anup@brainfault.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Shuah Khan" <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Anup Patel" <apatel@ventanamicro.com>, "Atish Patra"
 <atish.patra@linux.dev>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
In-Reply-To: <20250814155548.457172-1-apatel@ventanamicro.com>

2025-08-14T21:25:42+05:30, Anup Patel <apatel@ventanamicro.com>:
> This series adds ONE_REG interface for SBI FWFT extension implemented
> by KVM RISC-V.

I think it would be better to ONE_REG the CSRs (medeleg/menvcfg), or at
least expose their CSR fields (each sensible medeleg bit, PMM, ...)
through kvm_riscv_config, than to couple this with SBI/FWFT.

The controlled behavior is defined by the ISA, and userspace might want
to configure the S-mode execution environment even when SBI/FWFT is not
present, which is not possible with the current design.

Is there a benefit in expressing the ISA model through SBI/FWFT?

Thanks.

