Return-Path: <linux-kernel+bounces-767122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25061B24F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D43A9A0E09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78628F937;
	Wed, 13 Aug 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TpwPmPUA"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2B28CF7C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101792; cv=none; b=t6Y68N+ew1+s21XLLNWEtT170lwTe85CQhRkHqSKLCLuH1fjZg/RAimr3IObsho/nw6iTxOYSSnljX+H24PsUTRhi1oKNWlw/YuNXs7zBiBC5onq/D95MfvhCcjhsDjqedQWZ0VXyVwMoiNqy2jCSytMcsMuILyp8S715IXqyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101792; c=relaxed/simple;
	bh=tIHHA1AqxAhFFJnxzRpdQsTYCTEHw74LFmqOh2tlBG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMcF442LgJ2tVAiv3fxUAkwnMQq+gJsEI4TU/0Vh2/RfY2eMhfl0Z1bFuctXTtdEvZiOkAbL+E+2Xy8xaECy7tBtvG+L9WtTQoLznceDDp8tseKkCzztcz4X04SRdaZ8bWdZv8xzc5YpsvgfUFxvqpg6EYiDuru4Qq/oF9Z2i9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TpwPmPUA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=2Z8b0tA6giS8n4O6KDji8VyXizH69Pnanef04kHHLwQ=; b=TpwPmP
	UAkWsHGWTOJ96wf0Xm8ASUQbM8WFN3k0wv7z3bceGB2TBJc49lhn11GuDdp0Ec3s
	zyZ+0z0r7m+u00ZxkVz1P8GoTtQ9g0eiAofYmOGCKTsigex8taUB/9iYsQCpCdXy
	GebgMFq6w2V69FSMBqB3BhiebgXPLJJIOs8NRMf9k9SHb7QoyvDvI9dVLftQBj4v
	dMPZu79GLrHMWouEHF9gBIsbCu5gMjiZCbGcCdOMGP3eDZmUSR2YWJqfEhHNsHj+
	jSD44mdaiOo8Jf9Ah8GCFypKeKDp9jugJJ6jLd4NcFxHW9NKCoWenW/wBz3Pljih
	iHz6iAhPqmWZQ8ZQ==
Received: (qmail 695149 invoked from network); 13 Aug 2025 18:16:17 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:17 +0200
X-UD-Smtp-Session: l3s3148p1@vWXreUE8JtttKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	openbmc@lists.ozlabs.org
Subject: [PATCH 11/21] peci: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:57 +0200
Message-ID: <20250813161517.4746-12-wsa+renesas@sang-engineering.com>
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

 drivers/peci/controller/peci-npcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/peci/controller/peci-npcm.c b/drivers/peci/controller/peci-npcm.c
index c77591ca583d..931868991241 100644
--- a/drivers/peci/controller/peci-npcm.c
+++ b/drivers/peci/controller/peci-npcm.c
@@ -221,7 +221,6 @@ static const struct regmap_config npcm_peci_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = NPCM_PECI_MAX_REG,
-	.fast_io = true,
 };
 
 static const struct peci_controller_ops npcm_ops = {
-- 
2.47.2


