Return-Path: <linux-kernel+bounces-794538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A0B3E2F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044CA3A70AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55233A02D;
	Mon,  1 Sep 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jNBVc2Jj"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD34322DD5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729787; cv=none; b=MdH53VzpdF6+p1FRFr5wQzz5UmQGCqbDcwdsGkfNgNbLZ/n3oeFB8S6TFtrCAtkNuq22yhpmhYngHPzsQcMHoogoZFuQseb1E8yCS7sWU6rB2pgOO0CAvU/b4AqIayN8F3DE7Gi+AQ8pTb0E16yZru+WZbnzvsWl/MXxA9nL6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729787; c=relaxed/simple;
	bh=mqW/3j/qm/a4/xvzFgOJO1ThExGROqxggDbWXjya4Uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DoHqS5ukS+eumTQTOcGkfGp0vugUETfgXoy9ltaqtLY+3VYvYPruEPlGPgGdQj42qq1VtVzgJp/Mvtg5D8pfbE0h1cSqkTzTias359IJ5dOkOpCQi8Pazu6GODC7BUs2em9kB2pNe0gE3TcEb1/8Ru0XGKQRYlQO0ARjFxc1Gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jNBVc2Jj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C1BAD4E40C66;
	Mon,  1 Sep 2025 12:29:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9524660699;
	Mon,  1 Sep 2025 12:29:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EDE6B1C22D5F0;
	Mon,  1 Sep 2025 14:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b5dX9UoBbxev9aaHEY9TfqgQYiczy1eLN+APvPcn4go=;
	b=jNBVc2JjX2nONGCForZYed73fEntZDDaaveghRpy68HctZphQwN2+ejwn9TaUDJwF2cHku
	BodA4L5vPGA0QjNY5YxIKNnIcszDAV17SgIIpL1DMrbEuWMpQdGTnDTF/VpZbmdVuA9Ago
	omS/3BaNjxBDo4gCNp7SjlsmXuGVEQRBMnKImiUYwKngf2XhmXGpnox3NQgNXp0ar6p/VW
	ggSw4ivEVoqQAHRD1HzZEviqCtMtpiLsUASnRjk3uYh7/JVt7cTO3p+8zc9TxmV3BcAWtv
	UWRbwh6gdYlZHNq7t6hRpJen9zTeU3/cNSfk90MOkZrniMoE7Yb5hHlqAps5yA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250730135934.1712198-1-arnd@kernel.org>
References: <20250730135934.1712198-1-arnd@kernel.org>
Subject: Re: [PATCH] mtd: map: add back asm/barrier.h inclusion
Message-Id: <175672978089.48892.5892042326459406309.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:29:40 +0200
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

On Wed, 30 Jul 2025 15:59:24 +0200, Arnd Bergmann wrote:
> The mb() macro is used in this header:
> 
> In file included from include/linux/mtd/qinfo.h:5,
>                  from include/linux/mtd/pfow.h:8,
>                  from drivers/mtd/lpddr/lpddr_cmds.c:14:
> include/linux/mtd/map.h: In function 'inline_map_write':
> include/linux/mtd/map.h:428:9: error: implicit declaration of function 'mb' [-Wimplicit-function-declaration]
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: map: add back asm/barrier.h inclusion
      commit: 6538d039c524304a00b8fac651982fdf1fe24cc3

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


