Return-Path: <linux-kernel+bounces-846320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB1BC78F4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E753E6177
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565532C3277;
	Thu,  9 Oct 2025 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IpcilbrT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E782848A0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992451; cv=none; b=XlAoGrHtBiRrXriYEBH4WKh3rPhczV5BLVEDfiZ50x7cyjMmB6+ya58vVJVJC7bCOuWBSEFBorqLzqaJlzgQxkCAf2mrjRC/alErQo8StRiOVYuyOWBHvxZzKPkE9bp2DmDYpnoCWBo89dx/tOqYD+J4qSMNwnCwL8I+ObfGH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992451; c=relaxed/simple;
	bh=mfZ9IwMPosLthjEdYwEjtzA3SfovaP/AyucpLKx9p3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=c6L37KmnrNBks1hgC7OCZMoPiwZP1O1/egh8eRZmaT5Qi+TWpYk4ubXkZX/tDoyg3rydzluSu4gwR8svHWUPLIKI3exBBgEN3RjnLic85fH0U+5fhCUgF4slxFDmQlpCDDHhlJnV2hIQZAsbe5zvmCNxkzfyLPrCs4WPizPMulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IpcilbrT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e33cec8edso375245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759992448; x=1760597248; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kX/2DcwJULxUzQnKC5hadF3mFu3a5RnnRgumV8iiFk=;
        b=IpcilbrTGVgAzt2x9SaoibJai8ig5MzpI9+rZgGlpDWBP92DINa42KRmtn93BhiitN
         RSqq1ER2PEYZdt0Le5snXHcoMKbJQA5VZ9WhZU0L+67r0zWOJGBEQJ+zaAPvboK7KCGU
         OgQqxoL46qxGRNHpn+41hXnCTQ8//2Z42rWEymJeKld3KjTMnuM6/uBH4AwzCm/3WP7l
         BfpFwBAs1jUgiJvotf99PfYD8gGUc/TJJI2V7GwYravvQ45ZHKOy4ai5KrOBXUwRqsNJ
         hLXIUBryPe/aWmy8DcmUDPuVa5+87YIStQKQmS5c+4r6HyMVslC+llvBQRv6t5OV4aQS
         gLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759992448; x=1760597248;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4kX/2DcwJULxUzQnKC5hadF3mFu3a5RnnRgumV8iiFk=;
        b=np8ndZtNRLV9v17Btc7MUM0iWstNXwDshcd3+H5KMyXc5HGG1uMw1MsGkZuEJTRbdd
         WJEikOIT4+r9+tWO2lxKM6A0OSwRYUKrs9uWgDEDk6pE6r5fjTxvY5S/eU7n5P255wUb
         HS1lGMDLcWlbhu93YvIGkVIAbeU+tn59nK6JpcQ5N5oFMP5A3Sk7RHmaYBtixyLrt0eJ
         SfMmK+z4v0si+tx4J+litia1IDh/V76IrHze+CyilTH1Ocgv/MLDvSZMHYhsm0ENhASq
         WQOtu3kl1aX7jWOrf3CJqnJsP8jtp9EkFiCGvTRgl6LPFInD1P2mPE9toWgbwDZ6Fynp
         EfHw==
X-Forwarded-Encrypted: i=1; AJvYcCX9QzZB2ND8XB+g0SRDlnbtd9O2YM0TM4RRvtMPO0PWpemxVFFLxLiygD0JYCVHPvbM2VMkhDdKIjn/CsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeZa6SP17i/glFSrWYGkF0mYekmuEfBYenrxfqLwroUMsuETf
	CcLIn0ckhZn3Kx0yZKb4zaARjVpMotgvmE3W8V353mgbK6CWy6hrFkA35A4ZKYr9Ayc=
X-Gm-Gg: ASbGncssS6KLoiW+njHixcwzsFnGc3AjT89tD6trkhl3/2DWHD1VofD0OJsXP52lcTw
	/0XLb0WI2qGwNH7hSrFkz2xywz0zsDGHslGXQh9Ud8KDkygnfTzj7qlSFSnbYf7rOD0L/pIKGeo
	TRcWZXV8o7GvWHATgffFhOMf2s2JrEe6POFRYHC2Jx2F2KbNxdMLf+dXxM0IcTKErtcXf8O1/ct
	GZKeiE6Am70x2w/LWAUdHynagNtb/RiHBN+8n55X5K+Xcqml/6CaxgbE9Ut3NVkW3crxl8+pTo3
	lP7m6TmM0/1YZJlc5mS+UqJV+X3B6eRKMb//BW72itoLDDScsURyYqRDzOVu/L5KqSv/0TEwlji
	5HIgjTWl9KmBJ799eC6vvKDbRStyyqBEK9lJ7PyCHYZj0nLvE
X-Google-Smtp-Source: AGHT+IERhG2czUcI/1bkhsjABOhRhpIpLRnFW9gDFTFnSV/gvPy8JtCf/9GIOjxDAvwaj+T5F6mmJw==
X-Received: by 2002:a05:600c:4707:b0:46e:4292:769b with SMTP id 5b1f17b1804b1-46fa9af990bmr23672735e9.4.1759992448349;
        Wed, 08 Oct 2025 23:47:28 -0700 (PDT)
Received: from localhost ([193.86.240.59])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e97f0sm32843535f8f.27.2025.10.08.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 08:47:27 +0200
Message-Id: <DDDL94HT7HYF.3VU2WQYU4WZY5@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v4 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid
 ext
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Conor Dooley" <conor@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, "Adrien Ricciardi" <aricciardi@baylibre.com>, "James
 Morse" <james.morse@arm.com>, "Atish Kumar Patra" <atishp@rivosinc.com>,
 "Atish Patra" <atish.patra@linux.dev>, "Vasudevan Srinivasan"
 <vasu@rivosinc.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 <guo.wenjia23@zte.com.cn>, <liu.qingtao2@zte.com.cn>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Drew Fustini" <fustini@kernel.org>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
 <20251007-ssqosid-v4-3-e8b57e59d812@kernel.org>
In-Reply-To: <20251007-ssqosid-v4-3-e8b57e59d812@kernel.org>

2025-10-07T23:21:12-07:00, Drew Fustini <fustini@kernel.org>:
> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> +static inline void __switch_to_srmcfg(struct task_struct *next)
> +{
> +	u32 *cpu_srmcfg_ptr =3D this_cpu_ptr(&cpu_srmcfg);
> +	u32 thread_srmcfg;
> +
> +	thread_srmcfg =3D READ_ONCE(next->thread.srmcfg);
> +
> +	if (thread_srmcfg !=3D *cpu_srmcfg_ptr) {

Wouldn't prev->thread.srmcfg have the value of CSR_SRMCFG when executing
switch_to?

Thanks.

> +		*cpu_srmcfg_ptr =3D thread_srmcfg;
> +		csr_write(CSR_SRMCFG, thread_srmcfg);
> +	}
> +}

