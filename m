Return-Path: <linux-kernel+bounces-874175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D2C15AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6CE1889AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172B347BA3;
	Tue, 28 Oct 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HrmDt3SE"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEEF342C8F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667175; cv=none; b=Mjmi3bjzKvQkNDg/yonF5m/jPW5Qsiwh9xgkiYKilAIufiHfIdx6zyLDcGmvaeRT9wMYx2InrOlqC3YIL4L29fIgEslfTgjLcw7DwqyZ7k00Y8t2ilRlwao9B+9pHxc7Vx+p2eGDu4dkp/fdYZ0sx+CRvqJgtOxcU82V/bLCIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667175; c=relaxed/simple;
	bh=YMUe+kV24w+pXXn8m/nZIzRksMzqFQ0QQHDH9KbUyks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aWUx1u88nmgTAcErCPiLC+M9sXE12UzRT40DyNz3N8qdEVGr5uvb2nSiIRc5F/4Qu8jtRcCEI6wYVlMfpwNKDT4Hke5BoJR8bVI8G+raZB4NUm9myxVD47bMr6cIka21CeB7zq1Gq68YGLt20XGkf+dUHxrzjcPaBkH6zrFt7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HrmDt3SE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E7F94E413A0;
	Tue, 28 Oct 2025 15:59:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7BC0606AB;
	Tue, 28 Oct 2025 15:59:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F035117A9A2D;
	Tue, 28 Oct 2025 16:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761667169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sRwSaMd6UTVG+EXoPh3Z8r1dIb+gecAn5V193KEwsVs=;
	b=HrmDt3SE5MmeHDTAqfZrtU1OFQxz5le9h51hbFOyA77E8pT2lM5ABQcXcmBrXzBGWWsZjr
	qz294AoULNlkROm1CBXEygfYPbfQKZhcuVml+XA3ir6CR4/iY26/JF8ZiF+7gB3t5PpLLV
	/moxL2+JjjVGIacBpJd3Tk5WdT/MA6Mtvz8PD3V7oO6IRdieXPL8wwpzCA2ZDpFSfm5dCI
	8obFEJlTjENM0EpoeG1hzGJkOLBV3pZe6TBTw3rTKRGgk3UaLDliRpb8RiMefaidoSFOL2
	IvMBv5ba7tuP5+o5bf7laBrxbrBp4udCeU7gpwZ1fDxbmjw2yE71F3O2NNfwxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: richard@nod.at, vigneshr@ti.com, vz@mleia.com, 
 piotr.wojtaszczyk@timesys.com, Haotian Zhang <vulab@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251028094747.1089-1-vulab@iscas.ac.cn>
References: <20251028094747.1089-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on
 probe error and remove
Message-Id: <176166716607.365556.10097701376798389137.b4-ty@bootlin.com>
Date: Tue, 28 Oct 2025 16:59:26 +0100
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

On Tue, 28 Oct 2025 17:47:47 +0800, Haotian Zhang wrote:
> The driver calls gpiod_get_optional() in the probe function but
> never calls gpiod_put() in the remove function or in the probe
> error path. This leads to a GPIO descriptor resource leak.
> The lpc32xx_mlc.c driver in the same directory handles this
> correctly by calling gpiod_put() on both paths.
> 
> Add gpiod_put() in the remove function and in the probe error path
> to fix the resource leak.
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on probe error and remove
      commit: 3ae23f77b6a0cd53b557ac69c98312f7be22f081

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


