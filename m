Return-Path: <linux-kernel+bounces-865566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFFBFD7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8BD4067D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C9272E6E;
	Wed, 22 Oct 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nqsays2h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H8V01t+v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922A35B121;
	Wed, 22 Oct 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151878; cv=none; b=o38pBaiUkMyiEFtP9cg2d/lcicnMylQ/mRSys9tpfYnHoY/DE73bnhB9axSRuTWBLw8x5KzILiJ3wty8v/wFAJw18Do1nNux856/aClHUhWe/Dmbv+jGygLZKF+Gju3lG5kzBrY0vJ2EgmMet8+ETe7qmzEdO1Pivo6SGu3pg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151878; c=relaxed/simple;
	bh=Jp8oF/W5EI9xSJTtHFx58WplnAZPtpDdl6YepC6k3Fk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShERLxr7VSO96pjKDhWDkDVZYyLJG6liDKiAwcng1Pd3FWoz4WUyRFVLUzH2TJaElENhx0uRf7v2TkPXDtkBis9o2oMs3wwTI9tUMY4Ym805R1+pgBWKzOv+Wm0TsAJYAvaJBS935d0R2dLdnfgQYLPB80WWKIWN3snhFIXSv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nqsays2h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H8V01t+v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761151875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUA1o5WQQPVYysu6WcIr2xDXJWQfyRSq8an7IHzsYEE=;
	b=Nqsays2hvm/reEWnIZrs8JhsUsg2zUkM/2uo8+YG41VXqxyQQ1CT3VgfvcY+b6AdwvQYhs
	HWKh2W/lUm9zJS8k5BRyooIyqgtDW+PU7nWRhla+3IT9N6jmAta78739L09hWPW3njYMtU
	538GG4UGTC7n19+Nii0VUo2omyMs2fHgQZ+DXhhdUIIAtlPrzlQiKSxhub64Zf0illoXrM
	w5TKi3Ju5ZVOhjkterp14xfUnq7j8Wlk8sn33R6zRf/9rqnjr+e6HBUo65qCRL08d8kreg
	ymYIQaHM55yYx3Zg3jY6HmOFUBRiPqbXmF0Y72w/ihlPxgr+hjodhdQF+lg4nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761151875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUA1o5WQQPVYysu6WcIr2xDXJWQfyRSq8an7IHzsYEE=;
	b=H8V01t+vilrR5cMR7J0tB7Xfvt2kU0XLpQcjAXHtBbLM2cMov/9lAM8oE4vvpZNROE9KpJ
	A1JLrIbDatJvefDQ==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
In-Reply-To: <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
Date: Wed, 22 Oct 2025 18:51:14 +0200
Message-ID: <87ecquyj5p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:

The subject prefix is: irqchip/aspeed-intc:

It's documented how to make them:

   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> The AST2700 SoC defines two parent interrupt controller blocks
> (INTC0 and INTC1), each containing multiple interrupt-controller
> child instances ("*-intc-ic"). The existing irqchip driver
> (irq-aspeed-intc.c) currently only registers a single compatible
> string: "aspeed,ast2700-intc-ic"
>
> To support device trees that describe the INTC0 and INTC1
> hierarchy more precisely, this patch adds two additional

s/this patch adds/add/

git grep 'This patch' Documentation/process/

> compatible strings:
>  - "aspeed,ast2700-intc0-ic"
>  - "aspeed,ast2700-intc1-ic"
>
> Both map to the same initialization function
> `aspeed_intc_ic_of_init()`.

The backticks are pointless. Just write aspeed...init()

Thanks,

        tglx

