Return-Path: <linux-kernel+bounces-794542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5CDB3E2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B141A82A97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D63431E3;
	Mon,  1 Sep 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xTXs0bMy"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695533EB0C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729790; cv=none; b=MOinC9gglxAU//BgcGG5tJHiQOCqcXuudgLR7hCAxrO5W7tHUmVQhcutOopufKBfrfo49vVILm4Y83o2isloRA0/tIIV0pF7mWjK1ThcsqGdsFgyMZAeQKbXp3pTuTNf0BgYqLNH4i5Nrh7ud0DIssjsUjXBnoexe5E2pS0QaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729790; c=relaxed/simple;
	bh=JRDTtaSY6x6JvPMrq0epFT7Rly+ZIG5WhsnJhRBsHbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g+mHCWQVSvxl/RE9A0IhV5gSLY07mq5qrarACC4yEw6gUh/3yMc88LB1KzW4/hgLG9lmtroQ9rwZBtjTAXcedZ/Le4IbBN3FgW8cMu2QT1venUJ59/uKZgvhUKwEEx6IiOHA/W6WzXJQk3yu/ugjuIkxLvQUK3qYVOU76o3sHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xTXs0bMy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 777AF1A0D79;
	Mon,  1 Sep 2025 12:29:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A75560699;
	Mon,  1 Sep 2025 12:29:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3130D1C22D87C;
	Mon,  1 Sep 2025 14:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zHNXLKMq7EGcvkjeYCErHCNRC2gDYHZswCYoJ/fq0oA=;
	b=xTXs0bMyQ/U2Ww57PnaJAbHsO3qVlWkZJLxSEdPUUAiHkAIcVDqiMqBuSk6iuVuc7IxTVx
	hRfJzzMsuNZCklpfYFrsnXPRqpP8Y/WSPVcPXR4VJgzCdumiwgE8e9n+HFnKKprXyCjMFD
	otx4Q2sM9B2TVeZJqvh3u+iQ2CPFrNxMSJMfuPNfmoEdR0zWUDe9uZ24xklRlXtTDYbiPa
	95nhYknnH63iBFK6CDo0+EM7OZ9kiS/V1taL7wsSIl5JgcRixUJbMC1HhPkI77m78edpRb
	Yv9uw3lPy0Me8J757CwH+QnhrDMQCBflL9ccFlZA/5gO4h/uLzucFKqVSQwCYg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20250808-mtd-ooblayout-sysfs-v2-1-fa620506d1ce@gmail.com>
References: <20250808-mtd-ooblayout-sysfs-v2-1-fa620506d1ce@gmail.com>
Subject: Re: [PATCH v2] mtd: core: expose ooblayout information via debugfs
Message-Id: <175672978510.48892.10136763977144565438.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:29:45 +0200
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

On Fri, 08 Aug 2025 12:13:44 +0200, Gabor Juhos wrote:
> Add two new debugfs files which allows to determine the OOB layout
> used by a given MTD device. This can be useful to verify the current
> layout during driver development without adding extra debug code.
> The exposed information also makes it easier to analyze NAND dumps
> without the need of crawling out the layout from the driver code.
> 
> The content of the new debugfs files is similar to this:
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: core: expose ooblayout information via debugfs
      commit: 54f922de70bbcd08a044b18c8635f4574ee7a29b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


