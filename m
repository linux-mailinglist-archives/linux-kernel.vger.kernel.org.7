Return-Path: <linux-kernel+bounces-794524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A160BB3E2E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2DD7AFC6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE62341AD7;
	Mon,  1 Sep 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QNTbYNtZ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB333CEB9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729590; cv=none; b=fPgWQleyzFvKAhtNYPkdCM+gQBAYlkK95V1IMQvVm4bW+SM/da7+KLsD88xRdxfUXn4A+u+k5Ah/oYjo6K/oYwyAz/z3CmvHUqv9jsr974nOpHIgWBMmNb4aXoyyEfsc7J2abdEsLio6kPTcG6ya/r51M6aES7ejq8Py57kbhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729590; c=relaxed/simple;
	bh=1BZ6biF1Hq34l5j3qpniKSw2bnZLqivxP5C7A0Go0Hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j8S3/dhWZwbfgPuxbi/3hNmKV4tBUPi1yFPXBEt+yXWimJhQpncFSZPikbDEOE4ma2VEqsJI8LLw4nuuTJ6GJBZMUuHKZVMJolxfyhtGF126l/2ugzF2brnmL+eYCFqNgqZ5NzelcdKqU0/jMiclOHW1bFQ1apturEFhiGSqUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QNTbYNtZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9B4011A0A08;
	Mon,  1 Sep 2025 12:26:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72A3C60699;
	Mon,  1 Sep 2025 12:26:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF8801C22C8BB;
	Mon,  1 Sep 2025 14:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UbSWQH4bFjDPLvG/kct3uB1vklz5zdXrHO0a0fdTay4=;
	b=QNTbYNtZGe/Rez2qkXQ8x/CtwL54EdeCkYpZimpV6z9LZpAAQhzSoQSGHRowQPL65c6YOn
	h5DHmNwb9cdUNlhZ6IsGEWP3Fn+t3tVXZ2b2JGqxwCBuK0n0jFx4Di4OE6OdPZ6iLuFlfh
	5xvvn77xkblzZgAd8R6ssFvDwqvgwRmaYKdd7CuMaKslNGRp6Ynwb3SbPU9gWugcf9U76D
	BQ6R3EIv92iIaUohi40gFILMLcUyX9TvySgtQKv78bfhivWMpHQu1VgXJ/M4CHfqpECzWk
	m5g57zuMiTqNX4CMIhGNvN4y4REkGgcBQ33UsKmcKmniKvUH2ykhoKd20VL+4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Balamanikandan.Gunasundar@microchip.com, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
References: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read
 setup timing
Message-Id: <175672957665.48300.9426658311064681547.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:26:16 +0200
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

On Thu, 21 Aug 2025 14:00:57 +0200, A. Sverdlin wrote:
> Having setup time 0 violates tAR, tCLR of some chips, for instance
> TOSHIBA TC58NVG2S3ETAI0 cannot be detected successfully (first ID byte
> being read duplicated, i.e. 98 98 dc 90 15 76 14 03 instead of
> 98 dc 90 15 76 ...).
> 
> Atmel Application Notes postulated 1 cycle NRD_SETUP without explanation
> [1], but it looks more appropriate to just calculate setup time properly.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing
      commit: fd779eac2d659668be4d3dbdac0710afd5d6db12

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


