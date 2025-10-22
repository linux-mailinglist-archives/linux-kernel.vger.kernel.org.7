Return-Path: <linux-kernel+bounces-864593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2CBFB220
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD491A0719D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BC3128D4;
	Wed, 22 Oct 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="erNkwFCA"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B192FA0E9;
	Wed, 22 Oct 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124860; cv=none; b=Womb11Era05XiGA8agC+KoRuFytt73ii87gBw9zxMwg4GDt2WWPgW4WiJiPqozfgeEFq4lbxMTUJFq8dNprEijbADZnr9G4iZh4lETAljKxURh70XC0rXM+ZEna1GiEoQKS++Z3Vcb58sMxfWMwQrX3ZVJbxR3OnkAj07huXCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124860; c=relaxed/simple;
	bh=lhFpU/Ya2FpFsQ5qefHEf4YDuzs6g5hk1JCUojxtVao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAqnwNQFVhGW4WQMbnlmqg14ZhBCiXNr6HatQyfXchzuPyiIAgG1qDrwOVJvcJQgjAPFvI3hXCE3fGSNffCOISrHyah1IoLl9Gcs83dGf04Q63rcTE31HSQeOhsYoyVmf6mbLFdzpLCf9MwMPBWP486C6nZlIJ/j9eoBxiQHYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=erNkwFCA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC5DD1A15CD;
	Wed, 22 Oct 2025 09:20:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0D45606DC;
	Wed, 22 Oct 2025 09:20:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1794D102F2431;
	Wed, 22 Oct 2025 11:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761124854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eHlP+N8MaWcT1YqqHBfX7bz2ZZfGvtWUZIn+21jD6Gs=;
	b=erNkwFCAkRFjaCf2oyUivOub+gdPX16PZmEEWEZLvuhwpXm6I/Z3WCmtWxue3XYiY8380i
	rAzFBUTDYvUDqzgowQ/DS841hHO6nYltJgJufahq0+5u1e5TskGHD/Y8zUfFFoNcgzfdSi
	9gsG+qjYOzLgcP53U5M1YbGBvZJOs/Fd28fTd/8uPlLQ1j6zaLF6i3nRO6xMRP/ufiIfxQ
	YRdniBbR92fgQ0dnLBLOaaJeWJyocvvfIUefMp/OYFov2NQzQ3QYy1RpopqLq5OPATFKbn
	FPJluRTC+HambRECsW4lb8MOpQnitaTKBF8z9IDTH1WGp17XnXVQFuPJkCONnw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Wentao Liang <vulab@iscas.ac.cn>,  Johan
 Hovold <johan@kernel.org>,  Maxime Ripard <mripard@kernel.org>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/15] dt-bindings: mtd: sunxi: Add H616 compatible
In-Reply-To: <20251020101311.256819-15-richard.genoud@bootlin.com> (Richard
	Genoud's message of "Mon, 20 Oct 2025 12:13:10 +0200")
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
	<20251020101311.256819-15-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 11:20:47 +0200
Message-ID: <878qh3thqo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Richard,

On 20/10/2025 at 12:13:10 +02, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> The H616 NAND controller is quite different from the A10 and A23 ones,
> some registers offset changed, and some new one are introduced.
> Also, the DMA handling is different (it uses chained descriptors)
>
> So, introduce a new compatible to represent this version of the IP.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../mtd/allwinner,sun4i-a10-nand.yaml         | 41 +++++++++++++++++--
>  1 file changed, 38 insertions(+), 3 deletions(-)

Please move the binding patch first in your series (binding then driver
changes aligned with the introduced binding and then DT changes using
it).

Thanks,
Miqu=C3=A8l

