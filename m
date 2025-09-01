Return-Path: <linux-kernel+bounces-794529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9624B3E2EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECA97B086F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A83314B7;
	Mon,  1 Sep 2025 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cV+Bta78"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF625EFBF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729693; cv=none; b=PL5FXrxMf9z7RQdrETTZ5TZIxVvrucPdSqNsUK1k/NOGt9qWXsA7Ue/2GB2HtJMZfnpsGbkr5R9/NQ97dRhMOTf0GFbgeql5aOOMDz/nA9SYNym15TLKcbEamxheJkKbdWoNIrH22+jaVz51TyH9rkTlw4O2OSXSUrmQioaweM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729693; c=relaxed/simple;
	bh=EKtgCFb76QNLdDWqxy/vKKqZuH/cQa+O98dS4JA6FNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H2vWkPWfHFWR8VvuOC/Yf4rU6jEice6qKHWAdBI/A7k6kU7GH2VNpbbpzW+URHwQfcX6ULMLDA664TcYmfWt89t4e6555XmnlIe+NjLCYn4aYUgqshWBkPWMq0eCHXIeP3YB8tDGzzjJxPR7XOHUC+39893+kMt2eZRXAluwaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cV+Bta78; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5F3521A0A08;
	Mon,  1 Sep 2025 12:28:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3158060699;
	Mon,  1 Sep 2025 12:28:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14D461C22D920;
	Mon,  1 Sep 2025 14:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756729689; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UXOsm8qhuucdsAyM1zdKnCT0l85k6/jaf73qtFHA0x8=;
	b=cV+Bta78fV6WZzUVXYqcLaEhUSlEA6ARnyEsZJdG2Gpqk8G8donsFfZ/NsyOnuXK5Oi6u+
	Qk5U2aWmsvTvl8KlWDKMGf+ZoEUZunpi2DNAzxeO6Enw/jQBtrpBaHGf7JxeHXYpCSS+YQ
	C32M/Ag5CkDod5V0e2QUTbeK80veRuSby12/pv/Q50RZmSoRU5PpYTav8pE0PKs7maL47y
	QqTXOMIoKTM6tRbRMAYEI9pT+2384Rs6AFRzK0OLjEK6d0hghPSI0uNcd9x5lQzLKAdO8l
	lRUnTclMVNFWsUhibsqOatapG20Wj4geKfXDMkEDjOV9O9Un83T8bOps+FLEfg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811-qpic_common-unused-defines-v2-1-cfc5aea03a93@gmail.com>
References: <20250811-qpic_common-unused-defines-v2-1-cfc5aea03a93@gmail.com>
Subject: Re: [PATCH v2] mtd: nand: qpic-common: remove a bunch of unused
 defines
Message-Id: <175672968576.48694.1163405170152581048.b4-ty@bootlin.com>
Date: Mon, 01 Sep 2025 14:28:05 +0200
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

On Mon, 11 Aug 2025 09:40:40 +0200, Gabor Juhos wrote:
> A bunch of definitions in the 'nand-qpic-common.h' header became
> unused after the conversion of the 'qcom_nandc' and 'spi-qpic-snand'
> drivers to use the FIELD_PREP() macro, so remove those.
> 
> No functional changes.
> 
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: nand: qpic-common: remove a bunch of unused defines
      commit: 3ea299d3dccdb8554057d0a87552e7673baea95d

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


