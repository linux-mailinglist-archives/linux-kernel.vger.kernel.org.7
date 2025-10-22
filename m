Return-Path: <linux-kernel+bounces-864641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEEDBFB3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D2356958
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8D2FFF9C;
	Wed, 22 Oct 2025 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EClQ6rS2"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46176307AEA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127018; cv=none; b=oTMryxz3WXBzgFqUSV4bsiwZzvkN+WyaGYS87ZO5VjuyOD1Fue9SdT4zIsUO6kUJ8shs4FSYr9NBBN9seEaCuvhCREsqTRmCquPqxLo5GiVaHpHModsUhXCl1ptRFjj0+A1wFW8YiR64XpzC8daGipex3EB4tPIPJxmj+MNHZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127018; c=relaxed/simple;
	bh=YlVeq68YvgrRSwKBIIf0HCrGHeLXi8dyIqJ/PjZP9Mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B7E4IR5J4OZrdEpp0W9wx41h+rFBNwYwcEYom744UyTVyjk1fEZef1mR513DAoH+7/70OAInBIjoGaqZnw1tRim4YW1/ghTxQg1F9g1xw6y/PUWBgGg4vc2GqT5kr4Db4gMruYGaVGfGb63ms2vDhiPGdm0OjCVyKT4SoJEkEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EClQ6rS2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AD1AD1A15CE;
	Wed, 22 Oct 2025 09:56:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81543606DC;
	Wed, 22 Oct 2025 09:56:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD497102F242A;
	Wed, 22 Oct 2025 11:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761127011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PtUVlEJ95DFrLMp1kRswERQY+ixJI6wZGrq1K1yw3ck=;
	b=EClQ6rS26/rnP/zhUZKi0h9SDoA5ZzfeiYjG2Umwvn3r2OlW98nK5bomlonaRmsXwAJOEE
	fV8TjWbPOuc2wvZlJjqZ5ZlK7a8Y8LCI+SHCRjB/Tu+6hdPD1ozA2C1t4ZS5U6bb9dQDJF
	6RUG0vSc6rp2JaZQC2pqrXLIjaBG0t9SSDaI89F3YxNZ1DPl0vKmZPGu7jaK+L15O/Epeh
	2FXFzStLOhs43muKwx3rg1u5A2clefITADHkb3XmdFlsaXqn4Puif2LjiXQCobAm8Ey8gE
	dP+LRRR7aBGunuiUKETHmqDvjtwC2Zu71daYnppwJ+vPwTe52p3Cm+o/l9Tzpg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aNvN4kfJ2ROB353Q@stanley.mountain>
References: <aNvN4kfJ2ROB353Q@stanley.mountain>
Subject: Re: [PATCH v2 resend] mtdchar: fix integer overflow in read/write
 ioctls
Message-Id: <176112699838.140484.7478020068192325576.b4-ty@bootlin.com>
Date: Wed, 22 Oct 2025 11:56:38 +0200
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

On Tue, 30 Sep 2025 15:32:34 +0300, Dan Carpenter wrote:
> The "req.start" and "req.len" variables are u64 values that come from the
> user at the start of the function.  We mask away the high 32 bits of
> "req.len" so that's capped at U32_MAX but the "req.start" variable can go
> up to U64_MAX which means that the addition can still integer overflow.
> 
> Use check_add_overflow() to fix this bug.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtdchar: fix integer overflow in read/write ioctls
      commit: e4185bed738da755b191aa3f2e16e8b48450e1b8

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


