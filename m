Return-Path: <linux-kernel+bounces-747817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85CB138C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239EE188DF58
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0447A25A323;
	Mon, 28 Jul 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zkjm2shC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A5225795
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697834; cv=none; b=tWvJHkNVTKiLaH4UE36+JPRWid4J7K6lQaPrwda8eJzANxTTYTjhewECf9Bzvs7pg61BsHoP2Cy2tRGfbuKKLqPFwsYJb6warwvmOf9/pwu0lOQO05HMJSsMZIXrkVSTpwZJD3Oe0+VpndzNPbLliDhmLE67/9vUGI2dzVuiKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697834; c=relaxed/simple;
	bh=+QSOk1skXADSLgUzo2daFYEATbUux1ldbokGQqMGm08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oKSvniVozBxVaX8WOxGcuHXyiMXYlvvJyyrCDq4QFMkSWv3LWlCePna04P4V1pJScK8GhzHTFYoQego4j9tQTrtVRCaP2jj/2LgCMmHL/M6nQwxDHwoV5gEkQg0kalVwx1JzbyocV97vtqLVut2qB5MWXBwYVswFfJ6hl3HIPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zkjm2shC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 533254329B;
	Mon, 28 Jul 2025 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2pizfwQKoKGdOMNPF3BacZFLWH5qaDvaOE2TTeK/ok=;
	b=Zkjm2shC8dNPGEV/0FDraPI/Gg1TM6vzU4y67mQAQKjGs7GIW7cMATKaDnPj+LMlVvAL5v
	AnhlTFDspYEHISwt70asIz8Bb6M+QkY5nqza3mta+yabDsmRBIpV4GUUeUu5wty2XFvzKg
	V+lNpJfKQwIPfp+QwGVBLhGf1EJ99eXxPTitG73IkgBtfPEnOAQgqYBViXdQDnagnJzkw9
	lJ9BFClJWot2fPgP2LTnwTSf1c3JD9gLDrPuNDT7cGzVCUqlQ6/30uZtZPmFhSolXVugiB
	exNfyxDXBiOPsSQW1YY7ulGIE0acjFwrsheLnC7oLFBSnndJrUhmfxFwYmXQvg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 dan.carpenter@linaro.org, bbrezillon@kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Cc: Zixun LI <admin@hifiphile.com>, 
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
In-Reply-To: <20250721104340.113581-1-balamanikandan.gunasundar@microchip.com>
References: <20250721104340.113581-1-balamanikandan.gunasundar@microchip.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: set pmecc data setup time
Message-Id: <175369782927.102528.5580599335079355284.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghlrghmrghnihhkrghnuggrnhdrghhunhgrshhunhgurghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtu
 higohhnrdguvghvpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprggumhhinheshhhifhhiphhhihhlvgdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhhitgholhgrshdrfhgvrhhrvgesmhhitghrohgthhhiphdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 21 Jul 2025 16:13:40 +0530, Balamanikandan Gunasundar wrote:
> Setup the pmecc data setup time as 3 clock cycles for 133MHz as recommended
> by the datasheet.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: rawnand: atmel: set pmecc data setup time
      commit: c115e7ed66f0dc6cf96f9bf3e3c46f6c44aa531b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


