Return-Path: <linux-kernel+bounces-864643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCEBFB3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D52B3BABED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6131A54A;
	Wed, 22 Oct 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lOwRt36u"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9963164B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127022; cv=none; b=UaA9RjtqGZ+efTqW8r/ZrWEKv2ZlVcpDQDJNL6TWsJBvutKEFm+vXhT0D0kRM3paA4LkboPu068aFMd0iPMSbEnXDgW2iZluUnxODnR59b/2YTjSKGmNiAWT0bHiuCaBP5d71gDJAHQqmgiH25VCRuppI3Ngzcl9nBPJwrymj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127022; c=relaxed/simple;
	bh=Fup2cSAdRDKg7z+e+91hn9H3ZevwS4kdA+FlkNyKtYw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LZcOCkapBkGqQMC6aWN3Vsp4e2K+JspEhmrz66zeKlPAfhM0ugTlf8QEh42O+vXN0VZ1cmqW0+uSc2473iYlcejYhurRKV3WQfVqzo7uiPhASG3HRMZ694HRnLDrEiQHL8tfTxVX1WFSdzU8ENzfXqFSvIP2tIK7xacp5RLj+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lOwRt36u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1C2921A15D0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:56:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4AF7606DC;
	Wed, 22 Oct 2025 09:56:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D35D102F242A;
	Wed, 22 Oct 2025 11:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761127018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dyDM/lHlh9+h2cDK+opXbELVb8qGok73uNfmtfylgmA=;
	b=lOwRt36u0feYh+E2/gQGjNed5H2r2LrOJN6oUo7PyJilelbyInUX7vC3wmr5iwcIB/ZUhp
	0y7Lo9Iv8QJkzO93J8EU7cN3FzEq9HNNbB1okb+VZT9EnZm6zb/RtVYaecTXCRppC+jJTp
	03lTENOGx8qAdQpgpvhNMmeEyx7XavgUdLQdYI8guNK37rdK96kBhLy+dwjGBR1Tz5fa9p
	r7xn6MXwhCt9C4diJ8y7lZXQZUJBkMZp1CAGwPshwmhoMPb5oV0AycEAs0fmjwa6CvTWYQ
	XJbhw0EsdMzDjNrF34v40+SLW0BaYVgFX+seqbUE9U5liczZEvM0veld1cyTDw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <5109cd228940c246d2e1ef4ff01799315601c285.1759916792.git.geert@linux-m68k.org>
References: <5109cd228940c246d2e1ef4ff01799315601c285.1759916792.git.geert@linux-m68k.org>
Subject: Re: [PATCH] mtd: nand: MTD_NAND_ECC_REALTEK should depend on
 HAS_DMA
Message-Id: <176112701735.140484.10535546133170470087.b4-ty@bootlin.com>
Date: Wed, 22 Oct 2025 11:56:57 +0200
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

On Wed, 08 Oct 2025 11:47:15 +0200, Geert Uytterhoeven wrote:
> If CONFIG_NO_DMA=y:
> 
>     ERROR: modpost: "dma_free_pages" [drivers/mtd/nand/ecc-realtek.ko] undefined!
>     ERROR: modpost: "dma_alloc_pages" [drivers/mtd/nand/ecc-realtek.ko] undefined!
> 
> The driver cannot function without DMA, hence fix this by adding a
> dependency on HAS_DMA.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: nand: MTD_NAND_ECC_REALTEK should depend on HAS_DMA
      commit: 0d9c80aa572182d4b1464826cd77aa8973213216

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


