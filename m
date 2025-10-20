Return-Path: <linux-kernel+bounces-860976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A297FBF17EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC8918925DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5B31197C;
	Mon, 20 Oct 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UQ4RY7a+"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80678315D52;
	Mon, 20 Oct 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966187; cv=none; b=BbA9zZO1ZWFEiPoJ8iu6rTA35WZfSarZRQNvX8HQCt29StZj3q1gyBOkP002KrU3fUepsans3n/prFdE8fINc+juRmws2tzN4MCZXtKY8+RHyAS+iJHjlXAG19WwxxIf+/Oe4lFT7mfr3Xy+t1uEV4hi5iL4JMm/+lkcw2MFB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966187; c=relaxed/simple;
	bh=kO7eI2olk7z3ICnnsFN+OaMWZMMqzzuZ7KUw97lV52M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1+/KJlEFLs5Ty5vZeGR84W1xk7UDlOTXk64vszMQhw4MsTdu5ZQmRdzpczUtb83t2Tf8gU7q/0OOF3sYJcIRVARYMNEl6xU88xuu6+bh4ocP2Fvuf68hDcvLbgAGhw+rYbmx6imnIViR9L3AYcVk0QMkNAIoDhSjyIEbyslM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UQ4RY7a+; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GTq/+CR+1YPS7UoGRwrDDUPcf4nRdaeC2o8uP0i5q8s=; b=UQ4RY7a+iw2ZNe6jCaBXAspIq0
	ZGZiSu+snnG1VxqR0lS6tv+dPf1jX3LpaKq0oVTtAwnhzkq8c1UUTJztqLmQbOpw2CwAuohUQ37TC
	jdfPyfM2qd5JvEEJnJLqkM/ToRFaZxlGmqpN9sTrga9IIEcdvZcy7owoCGcVpn4muoTZ2OwXAigB/
	NdbSch5+8iyAuWFOsHGaF8oQFj48nrdQIHjzKcBwtQemugFgQhGigdTRL7RJjl4+C79+cnPq5LaBp
	tbZA0qE0uy66tBV7gHf9V4uvB30R/0y2CM2VpUvIpAJrm2WuCOvM5FfqUlkQTVKt/uNkV9fbV22IZ
	d0p02pYA==;
Date: Mon, 20 Oct 2025 15:15:11 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alistair Francis
 <alistair@alistair23.me>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>, Andreas
 Kemnade <akemnade@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: mfd: sy7636a: Add missing
 gpio pins and supply
Message-ID: <20251020151511.1fd8611b@kemnade.info>
In-Reply-To: <175993751776.2584245.7441294249150226238.b4-ty@kernel.org>
References: <20250917-sy7636-rsrc-v3-1-331237d507a2@kernel.org>
	<175993751776.2584245.7441294249150226238.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Oct 2025 16:31:57 +0100
Lee Jones <lee@kernel.org> wrote:

> On Wed, 17 Sep 2025 09:14:29 +0200, Andreas Kemnade wrote:
> > To be able to fully describe how the SY7636A is connected to the system,
> > add properties for the EN and VCOM_EN pins. To squeeze out every bit
> > of unused current, in many devices it is possible to power off the
> > complete chip. Add an input regulator to allow that.
> > 
> >   
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: mfd: sy7636a: Add missing gpio pins and supply
>       commit: 7d983e997cb53d4c48b61b105163c31c92a35823
> 
hmm, what is the fate of this? I remember having seen this in your
for-mfd-next-next branch. But now I cannot find it neither in
your mfd-next nor your mfd-next-next nor general linux-next.

Regards,
Andreas

