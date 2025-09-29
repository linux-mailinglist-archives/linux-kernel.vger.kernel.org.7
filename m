Return-Path: <linux-kernel+bounces-836510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A70BA9E37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A1D19214F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C530C0EA;
	Mon, 29 Sep 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Aoiv0H7a"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D4430BF58
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161359; cv=none; b=novg4QbjO0iQjol/iGQXbod7xNOkALAeo6XJcOa0MdAfQlMGsQlSD6c5I/w6S067BiWWAtIJxkd7nZUTOEoF8gvJX9xT2PkzCRIhqvmiG7dHnVVQrZy9Zee25Px4iT4rPldrU5RREBOzGXn4LZlyl9IT2dquE8k/2yTWbaThZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161359; c=relaxed/simple;
	bh=PmnnP3tlJb7sfMJLtSPFp1ePI8TpZG2gGLM4TeLP9EI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+2oln2GxSHLvf+hTCkfwcKwvpLfH57nGF/LKloIMmf2jc7fiRO3UQmBQqogVITEqMIgkbWCQgI9jcV4fRxE51W804cLb7llv0OGJ7I553StApdaVQgLR/t75eXvfnlX2OhtCO+i6nhtGisKmgjMhYcLFaWq4h2IK6AftFE/0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Aoiv0H7a; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B025F1A101F;
	Mon, 29 Sep 2025 15:55:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87324606AE;
	Mon, 29 Sep 2025 15:55:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A909102F198F;
	Mon, 29 Sep 2025 17:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vo4QfhD98L8b58KoDVJk9jRcoE5N2oLtCd0bb1BghPw=;
	b=Aoiv0H7a+tE1fllLiatpWiOhyfR6Nih+buSSLBvfymK3Xc3I4nHglWrZtS31S1P9IJp7B3
	vp3h4a4hLoWk2L48j43Uveev5k9baoVPXKe8dAEF8v4XzvBo+MxZapnEjmSZ6qprAs6+iC
	tdKeKCAK4K4c6Yn0RWUHb9xSQg/EIbYugqFhcyijKHy8ZlU4AfCboOokVuOUvi9go/i0kX
	H1NCzfTd/fBJYwQmpU6L7GxdTBWk5aN6iTSJ4xkqRUkYU4SlLBZVhReVEepQ+317t1b5Ak
	GYOwEuDeV7YuEAuisCSqrmsKzwfLUWWNP+qo0rB46rFXeKGbzFI2uKOlxgSe4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
In-Reply-To: <20250922110727.1423318-1-karanja99erick@gmail.com>
References: <20250922110727.1423318-1-karanja99erick@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: atmel: Fix error handling path in
 atmel_nand_controller_add_nands
Message-Id: <175916134713.50416.13477111980143091827.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 17:55:47 +0200
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

On Mon, 22 Sep 2025 14:07:27 +0300, Erick Karanja wrote:
> In case of a jump to the  err label due to atmel_nand_create() or
> atmel_nand_controller_add_nand() failure, the reference to nand_np
> need to be released
> 
> Use for_each_child_of_node_scoped() to fix the issue.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: atmel: Fix error handling path in atmel_nand_controller_add_nands
      commit: 8ed4728eb9f10b57c3eb02e0f6933a89ffcb8a91

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


