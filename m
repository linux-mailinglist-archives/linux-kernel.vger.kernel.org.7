Return-Path: <linux-kernel+bounces-767113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88AB24F92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B05C2B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC572874E9;
	Wed, 13 Aug 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="M5T6O+x/"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B4246BD1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101779; cv=none; b=LZQv9Y3POHPSLqmxaUCLNHh5ta5y6tTmtUazW/zF6FXABaJBD2xweqVs59QnDYdM/csioox8E8CoutGpCYTGLyNBNPTXyU2oTM3nLhzDIo62ZRyyQGD0n9CuNhjoUvJisJQ4e8QyXIwIhQOHmd4/PPzoeuJNwDu0oatwECtS6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101779; c=relaxed/simple;
	bh=MCUCYzK9BWpZOosZvr9lPl5z+08ZfNbYEeFrw8Mb9+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYTWqzhVLw8ISapLjjXzBg7roOlKZ09Br6Gm/5jLqyTntcf+wlBuPk4OdFotcXBL/sOA4/POl+Yk2TkzIZiM/Gl1mRIHxZTf7mMuoHE1Hb+xpwLZTeFPb8dDIe93+gtE5Jsrt+omszN2mDsqhRiiSdJbhhrfBKHhiSKGXMi3LOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=M5T6O+x/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=mjdM+kq0pe9Kr1Y7YIS/rThb8NG624lAdP7joruNZjg=; b=M5T6O+
	x/FapnyvTl+KClZqj5CQeYs21l6I6PfLcTva2QO0FbGzCGjyhArh6cGQ/QqChDcz
	bY3xi/GF9Ly0fwZjiAAEqe96YE7KKQU4B+DdlC0Ap9X2K2apovP0ffHb1WDdZTZj
	DajY3u98B0j+RHFLMr9Cc0Tk6F/su7nVaoR5Uko5Esb60pdRgTCP9d+HAgcxGsqf
	S5PcS26qJNwe0VRdx24pW69UWLRA43Cuxd+ywnNYWdvEqHW8cwXxoKoboRd8WLB8
	rv6vgjNSMTH9Z3gJ4aIUwcrJqhc62b6B4IGOAJDZv7n6f8kqESHrv9udgC3b/0Qh
	Lt+ML3iZGBPXPdGg==
Received: (qmail 694554 invoked from network); 13 Aug 2025 18:15:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:15:56 +0200
X-UD-Smtp-Session: l3s3148p1@yMS0eEE8OodtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 01/21] bus: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:47 +0200
Message-ID: <20250813161517.4746-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 7463124b6dd9..0ac7d09c9b95 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -64,7 +64,6 @@ static const struct regmap_config bt1_apb_regmap_cfg = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = APB_EHB_TIMEOUT,
-	.fast_io = true
 };
 
 static inline unsigned long bt1_apb_n_to_timeout_us(struct bt1_apb *apb, u32 n)
-- 
2.47.2


