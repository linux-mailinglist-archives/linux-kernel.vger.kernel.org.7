Return-Path: <linux-kernel+bounces-809716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E35B51114
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880E81C22272
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE0330CDA1;
	Wed, 10 Sep 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AE4Dwmbh"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB02877E9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492596; cv=none; b=nHBSGZn5HIsHFkAq217mqVDePLwwIEFuiQnKohRR2BzON3ZDWmXQkKi2bcmlZILK4GjxiR9Dy9626hQZWhTG9E3ouLVWTqLQpiLETMRuIX2fsQ7jXLPTYjBOWvmgGuCciYz3LUh/geu3W9URGUipT7xrPBh06Fdom2m5TUapyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492596; c=relaxed/simple;
	bh=xOvcxo9360IhOLUCcpkzBUwIO1z9bUa6ciCVyKZqwBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NGsB0aDE2Ly+qE47nJ1i05I0VQ+mF56EUrdP6BdYWgpBAVBw9iV+dAWnvY/5A/egHESoTRGtkphkLKfqenv23T3Rj4hUoZsFGqd0aEtTDFZRS5Y5GozlrPyfuQcRKcCqhYcfw+g5d8d/adYuC4TxBO6ihPi9lgnquRzDRumWHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AE4Dwmbh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9C284C8EC7D;
	Wed, 10 Sep 2025 08:22:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61037606D4;
	Wed, 10 Sep 2025 08:23:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD834102F2927;
	Wed, 10 Sep 2025 10:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757492591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cKnFYHvPIy6MTzO2MIhkn1M2uICE2klZ9uK2bnBrUU8=;
	b=AE4DwmbhjS04E41pbmWk0ixKoT83FA1TLAobsy2E27OdKuwv1DM2Igfa4Uea5LfOmIEJpc
	a8XqZei0tDi5rNhdIF07TI1NLYRHNVnNnU6ScOgdDsUW4SKxw5HmtAzoplDuskuj09V1U+
	9xElE1HiJ7sY6itHkbZqeLmt+zwU8EPaUlI73mdGkGjRRFbsL4pPEv3HYjz8qJ6q0rWeQR
	IbpBGffcrzKXj6zQ12ACJ5kIttYNhaX4v97aLI3F8WY29K1TfMWs6Ogon+whjcaFsIVXol
	ZRlGcJghi1FWzhUTwQdS2m7Mf7UJDoefYcyCEYcnRfwPZlKBgQv7pszz/fQhOw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-mtd@lists.infradead.org, Alexander Dahl <ada@thorsis.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Li Bin <bin.li@microchip.com>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Thomas Fourier <fourier.thomas@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250904091441.351805-1-ada@thorsis.com>
References: <20250904091441.351805-1-ada@thorsis.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Fix pulse read timing for
 certain flash chips
Message-Id: <175749258044.456366.13668613524637231004.b4-ty@bootlin.com>
Date: Wed, 10 Sep 2025 10:23:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 04 Sep 2025 11:14:41 +0200, Alexander Dahl wrote:
> Prevent PMECC errors when reading from AMD/Spansion S34ML02G1 flash on
> SAM9X60 SoC, after switching to ONFI timing mode 3.
> 
> >From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
> like we have to wait tREA after rising RE# before sampling the data.
> Thus pulse must be at least tREA.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: raw: atmel: Fix pulse read timing for certain flash chips
      (no commit info)

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


