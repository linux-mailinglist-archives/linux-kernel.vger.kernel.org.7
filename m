Return-Path: <linux-kernel+bounces-741135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A403B0E07A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496BF17E5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D3267F57;
	Tue, 22 Jul 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVcXdh0a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2aMI2TLL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B325228B;
	Tue, 22 Jul 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198107; cv=none; b=mqctI6grIPktuJ+votfQ8m6bJ3athRtVpNvbR90c9uU85phkjtJBKHa/gSI4oa02HvMScHAxUMsMJ43GfAu35aKMVoflAc284MhQYe//z0f5npFoA+51l3+hlKp+sv6g09QHxnbLyWS+yfmMVcGTsvoiLxPE1X1GTAOa6Dmgfrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198107; c=relaxed/simple;
	bh=3fd74I5Pb6rmLjOUK5XEQaXmUHbrPFDHe6ZUapTBwuQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emPRp8Nl6eN9KUq0tzArJ/PPX4WeoKY4wHhfaMMD3VifgBbm1oYUhBmLC8v+DVXkLFnupgfbSuuNiaTDoVGJBKMnEF7pJGZgSWp/gV0HkOqOW9m1uk/mLxLHnxPiLvJq7jlP7dLAUIFqz66DU/0MAY3uw8BF+ZsSpReXsxbaz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVcXdh0a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2aMI2TLL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753198104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85XrHWG9Jv3VTDn16FMltpEf586hn4QJABtiSR/Wwvs=;
	b=PVcXdh0a6fdgzThlV2t988DT7q7CAo1ZE4pfVnd2r9kJnW0ZZzKeSQR/7lZYqzfG9szsKY
	e5ri3xfR+DlYoP9g3JymbTygs+bX/evN+HtDtQaaFUyOUvtUlT2sggNJE7l17DW2+QLt8h
	FKCnMJKvY5nQeUVwhvrBhP+jpERaMqtvJZM3kY4fn07vLLVBVSfkKVzlbeflEVDutThOiZ
	Iv6/lU7GlnbZW9xi1iRbeowXeEpdGscP28u8aiB3VaP4v/carXHeZMTBMls64E4/Ba/yc5
	OOPRDAgpqPKgz/f6+2o40R9HUN2hD6N5A3Ty9OiSWR/nJO+xPTJKMRZLLc2fYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753198104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85XrHWG9Jv3VTDn16FMltpEf586hn4QJABtiSR/Wwvs=;
	b=2aMI2TLLvKRpRzdAWE6LR5GQ+UaMV1YrI5ZndoTpBlbt7m2b4vzw6/NttvrmH/VtNLuDzL
	j2RFiW2PS4UfWyAg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
In-Reply-To: <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
Date: Tue, 22 Jul 2025 17:28:23 +0200
Message-ID: <87zfcws0rs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22 2025 at 17:51, Ryan Chen wrote:
> -        interrupt-controller@12101b00 {
> -            compatible = "aspeed,ast2700-intc-ic";
> -            reg = <0 0x12101b00 0 0x10>;
> -            #interrupt-cells = <2>;
> -            interrupt-controller;
> -            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> +        intc1_0: interrupt-controller@100 {
> +          compatible = "aspeed,ast2700-intc-ic";
> +          reg = <0x0 0x100 0x0 0x10>;

I doubt that the controller base address is at 0x100 ...

