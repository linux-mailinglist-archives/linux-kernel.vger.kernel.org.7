Return-Path: <linux-kernel+bounces-866316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4400BFF739
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24854F13E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353EF2BE7BB;
	Thu, 23 Oct 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nlr6XBmJ"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED903296BA8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203070; cv=none; b=P++yikaN1G6pqgAxL4VoCoFEUNxDlBKFWxCAmHrckCJr8qF2BCje4l6CD4yj4rTcCzbC8iEsIp06k1OY6wGgjCx7p9NA+Z9JkYtF1kxWSb2SEUYyQ7lS6IyMFhkvYFVjwtJ/SKxX3Ejs+iGwlC1rVQHEV1emioG+u+GyRmqMXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203070; c=relaxed/simple;
	bh=44kSWjXhylp0VcoDGtJsPwzuZs4JwGw1Dq5stSGOOJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c856vRlgf9Uxi/Xl8ywP78dv44fJ+pqxkin4btC4ethAmnkXucz+wHM8XwYS90fPn2ykdg0KWy0j18Ir5WPaz/La7tSf2cYKnmftxSg7ozibxxx/307YA7pXRDS3KzXxzA1DyzajDVNg0JZnyV9D8JuCOmbv4K7cwo4UPlJObQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nlr6XBmJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 248471A15EA;
	Thu, 23 Oct 2025 07:04:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6D596062C;
	Thu, 23 Oct 2025 07:04:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C558102F2408;
	Thu, 23 Oct 2025 09:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761203064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A6EIv7MbbGBRMKtax/govJMi5UBAxZZaOhBy6c7KAOM=;
	b=nlr6XBmJgAKd4tnoGws3RG7ArQpPQ538EUt70eafCV+kpVf43I+E/6P21S2CibNHQ7YGoU
	a5wpzmVfYbGna1syZEzT3TYL2nS0vvlePMFg2xb3QKYws3bIb8B5RrYt4kQcTgoxuhEhf4
	jBh+ZxDvfD3i3i36Ty58EsHgA9tCQj3kleq1tUkfik54orKniD3NnR87Bp5NPnezs8dcdZ
	6XxWEwSb6NSfe+5uGZ8YiN9d8vsj/mFpr3wGyE2vgjRenB1SB9X5QceQhByTdxMweUJEDC
	W8SWJ3tVo1tMrawUQanAHrn+H9xDxlLjQKzO1CSzlayqMixXg864BZyYvHPN/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, niravkumarlaxmidas.rabara@altera.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251023033201.2182-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251023033201.2182-1-niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH] mtd: rawnand: cadence: fix DMA device NULL pointer
 dereference
Message-Id: <176120306155.174442.12328338821059704795.b4-ty@bootlin.com>
Date: Thu, 23 Oct 2025 09:04:21 +0200
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

On Thu, 23 Oct 2025 11:32:01 +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> The DMA device pointer `dma_dev` was being dereferenced before ensuring
> that `cdns_ctrl->dmac` is properly initialized.
> 
> Move the assignment of `dma_dev` after successfully acquiring the DMA
> channel to ensure the pointer is valid before use.
> 
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: cadence: fix DMA device NULL pointer dereference
      commit: 5c56bf214af85ca042bf97f8584aab2151035840

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


