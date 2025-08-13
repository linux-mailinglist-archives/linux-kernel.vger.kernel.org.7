Return-Path: <linux-kernel+bounces-767124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB52B24FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6361C80B72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00A298CAB;
	Wed, 13 Aug 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MYaZunoB"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5C28DF01
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101794; cv=none; b=dpaPr9Gfia7w8xHnRIXqGaeWqgPcdahK5u85AOSk4bg5ANdk10akXsa7WKAQav/gkEzxDzqpciOmshCyddEvktnjglG8V6/LA+Y6c29LJ5uHNUefzKA7zH6WGzg7sTw0zopZ9FNKaCUQTEWTYJwhcEp9kEU1OXawnc92Q1zSV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101794; c=relaxed/simple;
	bh=bAwuCStthKps7T2itHm+n0AuswFf928YP3Khh4V5u7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/CHz0Zy4Zlu3bWLyvK8fISB/98blmpOvHxFBdIPPCBNCEjgbsVg0gnSOOF62FwsGJTIIvfr024ZihpFNaViODA5/mTTneF2YJJAVBmWjbsGdtwB05VSravrkGrE2mpKq70WMDawHVf0UgPbAVkrtVSxWgrgB+JDNIJkhN4ILc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MYaZunoB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=+xDwDmsRX+gP2fiU/WhvnawyPXMFLcOwOSTBzoWba6I=; b=MYaZun
	oBF/dWAgwv37nH0Q82ZUv9A4ZZ1PF4SUKcsZssw1JzmeYMyktcdL0ijV881BtWyH
	OjCNkmhGrlVy8dH5S91pBsN5nFi7e46a6EZ+5HXv4IOrln2VypxZJieRzajw71bf
	Mwd32a7EtjIFPTHnva+WmV1d2sNsqLEdriXL9Z7qUpFUcusgWcsuh8uBdt+ckQ2I
	iyiWbbkL0CFq0hRHZvq3k4vNNrcbD1teJYZ5+H4uc18GmWlM79dRLa3hBFEVM7/1
	FaPaynqFiFTyKGS34iukvaZR2X4lmjA1CtGz6EMJv8WIxUhe8IEr164PUgXJ4nHV
	7mGyunONxQmMIOKQ==
Received: (qmail 695309 invoked from network); 13 Aug 2025 18:16:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:20 +0200
X-UD-Smtp-Session: l3s3148p1@2DIjekE8rJFtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH 13/21] pinctrl: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:59 +0200
Message-ID: <20250813161517.4746-14-wsa+renesas@sang-engineering.com>
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

 drivers/pinctrl/pinctrl-rp1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
index dadafc935dbb..6699b36349d0 100644
--- a/drivers/pinctrl/pinctrl-rp1.c
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -1627,7 +1627,6 @@ static const struct regmap_config rp1_pinctrl_regmap_cfg = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 	.name = "rp1-pinctrl",
 };
 
-- 
2.47.2


