Return-Path: <linux-kernel+bounces-855983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C03BE2CED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919C25E47D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53034328621;
	Thu, 16 Oct 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dyf4keG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m97xrjB9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B82111A8;
	Thu, 16 Oct 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609796; cv=none; b=QaIY18Y0n2q+KyvmQ8psERxe3E7jM+jFB2Bc/GEFHvC/3BJoJ+Wbu2bhVfQuBw6zb6hHtpw9X0oqaSvfk5YbmJyP9pzovXgHbAUkoAMxMDpEtMSgPyQEkBLZ6/DspEps8mzz3OwlKBDhMHYw5WMoz6SYQ5S+7z2SwHOEZ2rm9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609796; c=relaxed/simple;
	bh=8P2htBhrJO17CrkOlrLH3d0XBHXx2pEysnhLVdEWLvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BR7N60Km+0ZPF+GGrKw3psf4oZs/kie0Y0Daktlq+AtTjE3hEUYgs/EETQ83jB7ddjKvOiDNuwKlK7jXxSyzBaLTl7e5CNSoeZphMMvvXYGRKIhFMtaJvW9gQ+ej2FlxFau0PliCU9g2MEyrERbZAC/h/sS8u30Si9CU4wMflKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dyf4keG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m97xrjB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760609788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLL69dJksF4/iqPmPUgAV5VYqtWXMBbCiNFdjNIo33A=;
	b=4dyf4keGlON8LSBC1aKpcUUuL7XHEVITligizH+whmze2T1S9YiS2D6lI5s+/gLeIWR+Ah
	2ZvutviDhrj2QYaki5VnTWq9WyAVwapLiVFaqxATBh3L/m2E1ihklhIKGi144T0EXKix2C
	oQbaxy9NojKDXswd7xxV+KFCr6e4+WtJc/oXCYHxht1AmCjh7NXJP6B6C85s5AXv6vKidQ
	sxL9j4vlNzXONRtdmWcoynupVyIKDsrh3VK2xxETQMpmgK7096cCoIIyrviDRMVa9jDArH
	D1H/x+S15p6l6MhcgrXNkB0oq/YW2StHHvaUm/wdDaSnsUNWHPGtTMdbVfqx6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760609788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLL69dJksF4/iqPmPUgAV5VYqtWXMBbCiNFdjNIo33A=;
	b=m97xrjB9cTEobIoToBzhJ5TnfbY2K7rA/p04sZvWEmK5R41wJb0EJV+mN6bY2YtAI0RRug
	rUMF1tse33kTVWDA==
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vivian
 Wang <dramforever@live.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Zhang Xincheng
 <zhangxincheng@ultrarisc.com>, Lucas Zampieri <lzampier@redhat.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <20251016084301.27670-4-lzampier@redhat.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com>
Date: Thu, 16 Oct 2025 12:16:26 +0200
Message-ID: <87sefj179h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 16 2025 at 09:42, Lucas Zampieri wrote:
> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
      ^^^^^^^^^^^^
How on earth did you manage to screw up the hunk header?

Applying: irqchip/plic: Add support for UltraRISC DP1000 PLIC
error: corrupt patch at line 116

>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
>  	{ .compatible = "thead,c900-plic",
>  	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> +	{ .compatible = "ultrarisc,cp100-plic",
> +	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
>  	{}
>  };
>  
> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
     ^^^^^^^^^^^^^^^
Ditto here.

I fixed it up manually. Please be more careful next time.


