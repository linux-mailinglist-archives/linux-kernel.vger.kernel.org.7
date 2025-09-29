Return-Path: <linux-kernel+bounces-836505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070EBA9E04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A0216E7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3530C11E;
	Mon, 29 Sep 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a1Pcb2Yb"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721EB30BBAC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161242; cv=none; b=H55Q5n/fF+9DF1/0p8C0DlIafyF4f15uroMmJSgC9PkdMTOHpyvmdqXDrpolZQ3gQqyF88+XM8bKOuAEVYm2NHTm8oub7Mw0KwnbeFEUPsr0b+yuWznNJuat/a/05IPtjiLkFbvkxEcmwLJ/vSscGtcwdVB3XZHzi6f56+eZWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161242; c=relaxed/simple;
	bh=BjEgUKPh0GPqCbpOU6fvEKlFxdfcwcdlQOFsEz5Ao8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F3QieRaNr2zP89uGa9lWg3wAAiefb4vozqWYpYfUDZq9T/lBpvqAZ8T/iR7qMpv1sdO0yBzQeUB+eINAqiQvFMaU9mA7uda8HJyjpH2uX8ehLbqniww9LV+zFAEwSc58HVnnZNYnSYvNob2pT4WHTF71JtVdiPM0J9tMJO1oVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a1Pcb2Yb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7D7244E40D3E;
	Mon, 29 Sep 2025 15:53:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CC2A606AE;
	Mon, 29 Sep 2025 15:53:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15091102F198F;
	Mon, 29 Sep 2025 17:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759161236; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i/6Hyq8dUOSWl9oLKZN2M9OHkzWrotGY1p3Ytmb8Mo0=;
	b=a1Pcb2YbJ4azTRrfqDiwaf+1qWjyyT0OzRME8dE2Xp0sBB0euxaCPvc3aMSIlgOiykQkAE
	iquDV6X6YMaKoSToNUIhLo8KlT3+2G2I/1vmSOhbHmr3q9DuHDRP9FfgZvN+Ng2I/JfL9C
	oAnKrspJhK3c7xuHUWynbeLe86SD6iC9J3YuGG9uKJMWN5daFuVq0rZcGlwc/6fRwZwoVx
	laKJFn/c4jHmoUqypZgHdJdEWh5ABeRIqRTTeup/1TSdm+QxjV8WSBcw10OxwN0Vvl6I56
	F+2+JNiVZYS1ARpFGuM2ZJujaYtW+V4ylH/+cYSH4B9HzCHxBb/0CzgmgX9wnQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
In-Reply-To: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH RESEND v5 0/3] mtd: spinand: fix continuous reading
 mode support
Message-Id: <175916122241.49940.15564492037102571849.b4-ty@bootlin.com>
Date: Mon, 29 Sep 2025 17:53:42 +0200
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

On Thu, 18 Sep 2025 00:53:58 +0300, Mikhail Kshevetskiy wrote:
> Continuous reading mode is broken for some spi controllers. There are two
> possible bug scenarios:
> 
> 1) "continuous mode" flash and spi controller without dirmap support,
>    but with restriction on transfer length in adjust_op_size()
> 
> 2) "continuous mode" flash and spi controller with dirmap support for a
>    single flash page
> 
> [...]

Applied to nand/next, thanks!

[1/3] mtd: spinand: fix direct mapping creation sizes
      commit: e4a0cf9f1d90e6888e5373da3314f761024f6c97
[2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
      commit: 004f8ea0d9917398aabff7388b3bf62a84a4088b
[3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
      commit: 010dc7f2dd6a0078ade3f88f627ed5fbf45ceb94

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


