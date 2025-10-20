Return-Path: <linux-kernel+bounces-860793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E6BF0F61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73D9406C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2FE3126A9;
	Mon, 20 Oct 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="554YekhL"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E09305057
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961416; cv=none; b=oe7v5P2cv244XcPFlNEC3/0CF7i10S37Ntnssl6W8YXgmQGMBw/knEg+iCFlLXtoWazs941rcbzEp8CXnYdtM09iGMyF8yDlgCvHpR12vrx458nHPiS5k70BAD4v+2mIe7YMpZNeRTD4BKgMLc5YlZNVyN1/IFZbKuiwr20Wtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961416; c=relaxed/simple;
	bh=VjDQiG+M6K6QnT2gGqxEZan0J6keDFKijaH95ZMH354=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkR0ao770J59ETec2B2HcuMUCxvDU6J9/sbzj+B2CBgIv7OVvQ8BFJOguEPwgYwEkMz40muW44p5Gq4LSzlD1kAyFd5hNiMlu+No4Z07hTIIb67ANeszV4WpOFzwdthctU6tQ/Rs+RyhSOpjSlMbvQpXRG6xLSykCrYRqkZhBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=554YekhL; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id C3EE36892E9;
	Mon, 20 Oct 2025 13:56:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1760961405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VzgKu5v6USgX+sWCyGZJi7MH0wzM3lpI03vAJt5XXlY=;
	b=554YekhLAPr28fBEKd59LRu2SI6PHw4S4Jc4YR2QX1wGFuN1EtZeYSkefgs8/dxJuC8Qyt
	/MIgBt11b6fLG1zE+GMWOhs7nvt3z7QxkYzO3apKbT0l0XDcLYI1zIL/NYzo3KzlO0JOxi
	wPMKjDV+RqbwyKGqAPrDYsa6qlTO719P6Dn9RYn4sxpGVv63Z1YulqDc0JHSdXxRYvYGM+
	ckgrejNh9T0Mtq5HW4jiCPDnOubEEAPYEOkbaJntEwr2MBSaH0y3KHYlFfTYpysQut+GJz
	xwACZHY55R6p4dm9lw9ZKJpOnzrRgNZuuyXz9YXPMtQz3aZUeGZ9MNXFvtJ4uA==
From: Sander Vanheule <sander@svanheule.net>
To: Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH 0/2] gpio: regmap: Ensure writes for aliased data values
Date: Mon, 20 Oct 2025 13:56:34 +0200
Message-ID: <20251020115636.55417-1-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches aim to fix an issue with aliased data registers, where the
input values are read from an offset and the output values are written
to the same offset. The current use of regmap_update_bits() may cause an
input value to be used to decide not to write a new output value.

The first patch in this RFC aims to fix the above issue. The second
patch is optional, but allows to recover some performance by leveraging
the regmap cache.

I am currently revisiting an older patch series of mine [1]. I am
submitting these as an RFC to see if they are acceptable, but would
include the patch(es) in the respin of the series.

[1] https://lore.kernel.org/linux-gpio/cover.1623532208.git.sander@svanheule.net/

Sander Vanheule (2):
  gpio: regmap: Force writes for aliased data regs
  gpio: regmap: Bypass cache for aliased outputs

 drivers/gpio/gpio-regmap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.51.0


