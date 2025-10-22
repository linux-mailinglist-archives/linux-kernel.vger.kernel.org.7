Return-Path: <linux-kernel+bounces-864553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD6BFB0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808C2588335
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC933101B8;
	Wed, 22 Oct 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n2Z4tkf6"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D230E0E2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123915; cv=none; b=UyfOsYh2ZgO+uo9Id4DqqEhFvQVQ2xHjj4kfSlKSy+tdXwp8/fRv0QY6jhXSXDqo4YyHlE8kSwkEptB0RhbfpC3EXPUWOdjDcTBlx3dMHFxZbpe0sWkiIz4AogCBr2R3tgwC0gpY7EaGUZj+c9nxWWR4w7IPLhL4sKFjNocQlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123915; c=relaxed/simple;
	bh=Wdyf7HnCAayl1DdEyrGs4CIPuT2p3NlnmLcxp4BvcEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ndz3fB/fB/HtEKNn/eQsyurqBq5bE5sqhimMyiOmJRIV8iMLd+yHB0N3wRHXWVfxbZeEAYXqs0MIxChxPMCr30RHikF+hOSAJUqt7wB7FiiqSSr3SIsyNzkDaXRbULg1nAgQoy/XyQmNKwm4niD4KAo9IQ2pi638gbvEeiCuZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n2Z4tkf6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF30D1A15D0;
	Wed, 22 Oct 2025 09:05:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86033606DC;
	Wed, 22 Oct 2025 09:05:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D3DE102F2424;
	Wed, 22 Oct 2025 11:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761123910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6yeLxlHF1ExWB5DZwZRxEYNkaxzkbdpoSKjymzjUJmE=;
	b=n2Z4tkf6o5U9c0lipN+o3XifhRcaEsIcWUSNkB4T/+bkjiLI0YovdjgK0wcw/J7+w+RMbP
	XXXJAB5sk0AgXJ84LV6w1+bAF7TfewA7Ru9eQQUYtqRfc5Mz8hPSjomJ0vzJimC6f6WSwx
	/RxHncJUqmBumvBArZb2tIXudRxorWrI/LUSkof3LpNucgeWNsVEkRp5WEsVVZK+YJCiDt
	2WpyPYSkFUyw42NtZYWtYA8vW4rVY8qo9IfQUOl2gFlEZkXCUFjf+zwFrTIIUZqhmy41P1
	zPVa0GTV+6s2TmWVoPZN/nw4n5xoyv9dLP8khMJ85WIi/0FKybbmO1lGqDabAQ==
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
Subject: Re: [PATCH v3 07/15] mtd: rawnand: sunxi: introduce ecc_mode_mask
 in sunxi_nfc_caps
In-Reply-To: <20251020101311.256819-8-richard.genoud@bootlin.com> (Richard
	Genoud's message of "Mon, 20 Oct 2025 12:13:03 +0200")
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
	<20251020101311.256819-8-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 11:05:02 +0200
Message-ID: <87jz0ntigx.fsf@bootlin.com>
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

On 20/10/2025 at 12:13:03 +02, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> The H6/H616 ECC_MODE field is not at the same offset, and has not the
> same size.
> So move the mask into sunxi_nfc_caps.
>
> No functional change.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 70c940840dda..4118307cac15 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -29,8 +29,9 @@
>  #include <linux/iopoll.h>
>  #include <linux/reset.h>
>=20=20
> -/* non compile-time field get */
> +/* non compile-time field get/prep */
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) &
> (_mask))

This could probably require a mention in the commit message, as for the
introduction of the field_get() helper.

No need to resend just for this either.

Thanks,
Miqu=C3=A8l

