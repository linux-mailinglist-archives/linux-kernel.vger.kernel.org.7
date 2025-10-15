Return-Path: <linux-kernel+bounces-854396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D5BDE446
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E74A4FB4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF331AF18;
	Wed, 15 Oct 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AuYOSJPq"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C73168FE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527787; cv=none; b=VLncYtyPN0nbIq0Jw/isZt/6B8rm6hyH+SIk6bLiZS3FRusuoUPBVkw2CzXO+TL6UHRYy2oCoocYULkRifDDT3x9lFrjUturd9bBv7gs2B1o/rBEuWFrvftaPHtS2lIBOu09NjLhluGR2ShyE7mfaJIDgHFFwhColC5L8RTkxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527787; c=relaxed/simple;
	bh=cvbc4bQsfp6XJXPd4RR86XSedJxcuv8j3+iJpY/Z290=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEyaPjhTqhso9gw4bg4q2trw3MAJgKgq94c6hJPXAfvH66pRcAMPvZkgYYV5KGJxkthhk4kGDOVlrQZPNEuxNWfXIolh1bNo+P/l5LVtGN3hSaOqMwkVnFuyxAd0CFU4xxOQFqs/T05CUMoyGqLQvANPMey+OTVSoCXbopQrv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AuYOSJPq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=M2uLmgje3ebm4+
	kl1NOOb5d0r1B8OIFraXJQh54wt3Q=; b=AuYOSJPqfGiIXF7sJjp2f8TXTRX6jf
	kgNKHGGwDxt9EmF6diCEjxTCcM87I9z9g4JLZi3lRcPKZO+T/O9B3dtN25iBartJ
	s0PU3Pt7Nj+Gb9qgjttju99FljNgtA04xOxZKmLy4+NkAnsWreSIWkW3E0RcXoua
	1TyTo6Y9OBXjifVAOjN2r5Sx/VAEWmxQP4nfBes1tzb8sz5pHTkza4vwgkzNkftI
	QJxnZGzrwLu+CLKc1vG5iIo8WGEEd4Xe/SxAUMjPYuWfNjij3t78tFUV8DvZfjWK
	OSnGJHs9B/Ld8Zk1yq2eEny653T5YyD7+6SCHV5QL+3kDUtVu4R5N1hw==
Received: (qmail 3376364 invoked from network); 15 Oct 2025 13:29:41 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Oct 2025 13:29:41 +0200
X-UD-Smtp-Session: l3s3148p1@L5Tt0DBBxLkujnsG
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC PATCH] reset: always bail out on missing RESET_GPIO driver
Date: Wed, 15 Oct 2025 13:28:59 +0200
Message-ID: <20251015112921.19535-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optional GPIOs mean they can be omitted. If they are described, a
failure in acquiring them still needs to be reported. When the
RESET_GPIO is not enabled so the reset core cannot provide its assumed
fallback, the user should be informed about it. So, not only bail out
but also give a hint how to fix the situation.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Closes: https://lore.kernel.org/r/87a51um1y1.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This happened because of this (in general) nice cleanup patch for the
pca954x driver (690de2902dca ("i2c: muxes: pca954x: Use reset controller
only")). Our .config didn't have the RESET_GPIO enabled before, so sound
regressed on some boards.

Actually, my preferred solution would be to make the reset-gpio driver
'obj-y' but I guess its dependency on GPIOLIB makes this a no-go?

On the other hand, the fallback is a really nice feature which could
remove duplicated code. But if the fallback is not present by default,
it makes it cumbersome to use IMO.

Has this been discussed before? I couldn't find any pointers...

Happy hacking, everyone!


 drivers/reset/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae5..8a0f41963f6b 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1028,8 +1028,10 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
 	if (ret) {
-		if (!IS_ENABLED(CONFIG_RESET_GPIO))
-			return optional ? NULL : ERR_PTR(ret);
+		if (!IS_ENABLED(CONFIG_RESET_GPIO)) {
+			pr_warn("%s(): RESET_GPIO driver not enabled, cannot fall back\n", __func__);
+			return ERR_PTR(ret);
+		}
 
 		/*
 		 * There can be only one reset-gpio for regular devices, so
-- 
2.47.2


