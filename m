Return-Path: <linux-kernel+bounces-794512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC1B3E2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E74C1731DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769EA335BDE;
	Mon,  1 Sep 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ICva/DOh"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86331AF08;
	Mon,  1 Sep 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729570; cv=none; b=kS91Nc7QkeGKXvOftipKys+KcbSFFZG1l+ws874EL3IH2Eb6ucIG8F65wCNvPZ1boV49TPUMtc8KUC7/4e6PgbzWee8DJKW0tbVo5RmiSjWF4lCWPPGShgZVRhu0p4aPERVPMc6MOQsxa2sJH91b6opBBKUV6HSALlrOhjTeW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729570; c=relaxed/simple;
	bh=AEAWGm09PNUzOWP6M1l1HBuE2oEYgtQu4SJPrOfx8J8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dh/DpYDcBp80p254OQ3Oxqii/GUzYayPMzYwM6g1r4cDTLrXS3XXWadAH4uSFFVq4oy+yViuM8Z5ApJdAojyM0EHqrNY9sk3rYZq7qA+Akvwzu5bhBSUI1XHHKF31UHilchvZjjAF49FRBVPfubzb4TKNy0bKrzWu+gC5YL4Uug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ICva/DOh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6ABF9C8F1CA;
	Mon,  1 Sep 2025 12:25:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41FBD60699;
	Mon,  1 Sep 2025 12:26:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2DF91C22D736;
	Mon,  1 Sep 2025 14:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8hGKL4FKs6i1GHIz+xvbOKSl/l4umvQsOiUCwcWZt3c=;
	b=ICva/DOhoEqp0sA/6pEKzHDp66jcy4SdmY8zOiDNLM/OAzy2LXngum3o1tpj3CFzbRhWav
	dSu8CrivVDRGAnuO7HUwM7hJ0u1+5nvI74OY9iDBX2wA4uZ1eoFrjKKo6HX5h5LkQ0SQ2o
	kfy5behNlzpFHvhiXPnndYs1DvuU+5jLkPpTu98qEhsMv7E7z2ds8pYwloloJUVcpVcHOr
	V7bbVLfvGGoj108tZnogq9g+yN0rPZxPvUL1sjHC/knOiOujD+aPXCbA5Kf8TPC1MIjN+I
	GS4y0PiZ8HhRTmqzlW8Qya6sZ/6vnxC5IvXiYhpfmFsVHAhNUbYp2FHOcRdqxA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Hui-Ping Chen <hpchen0nvt@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <a2a4ca2010ac4aa2aee0bec151d2e57e812510a0.1753904852.git.christophe.jaillet@wanadoo.fr>
References: <a2a4ca2010ac4aa2aee0bec151d2e57e812510a0.1753904852.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] mtd: rawnand: nuvoton: Fix an error handling path in
 ma35_nand_chips_init()
Message-Id: <175672955080.48300.7085440480114483519.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:25:50 +0200
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

On Wed, 30 Jul 2025 21:47:46 +0200, Christophe JAILLET wrote:
> If a ma35_nand_chip_init() call fails, then a reference to 'nand_np' still
> needs to be released.
> 
> Use for_each_child_of_node_scoped() to fix the issue.
> 
> 

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: nuvoton: Fix an error handling path in ma35_nand_chips_init()
      commit: 1eae113dd5ff5192cfd3e11b6ab7b96193b42c01

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


