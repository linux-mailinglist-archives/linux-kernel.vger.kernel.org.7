Return-Path: <linux-kernel+bounces-855282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D726BE0BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3423F4F6A02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC32FE57F;
	Wed, 15 Oct 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="lTg3shNO"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483A2D9EF2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561982; cv=none; b=RPAjX930fS2HNP99brzwK6jwr+LMkVVOfADKPx5J3gyN/15QSQiHYsHahx9HxRjF1nSdYR8neqeUNFfHOeYe4nAGAP/wrXjPgzhm+QQYjid1Ww9LVh+DY3R6P1nJayPYA5ID74G+TAWpcvaxaS6tDlCv/U2ybmG5d3dRHVH24v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561982; c=relaxed/simple;
	bh=FGc6lCmQPgIariDqqATWhZu/+cnd36zIPScbB2qlhXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU470SW6JM3LbukwTbtCoeLMbFD1Ad+nmWyGjdoDEzmpfg8ZsLwL6RIP5TGs4NHMpRFo9/f3QWi01ibXzl8Lq2KIP+JoR1Zwr8hcKcG0lc7wAlFlx6zfHy+z9GcJDajhZF+Dv15yBIywBlhZDEbVLLsK6FBmXWq9Vxi79JKhEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=lTg3shNO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TmMo7UfKp9jPjoJxaD8G1+/QMcyWYOk4wYhcprXR6As=; b=lTg3sh
	NOAg3DSPo30M6o803binPnO1vZrTiQDZfqbylmMJ3mn+zFth7ki3+O68xISuVIn9
	GBhdQN75LTnGMOIu0q0YhWRF6UdxK1fU0SZRpUM7OxB0NWgOAAOQZ0IzNRnd+ejW
	v1h+3A/CA++mBwWvyJQUy5OjAL0bVmxzo5p55l777exG/7GAv4MRNLV81asITjni
	JUIXwD+jnZfD/U6qP2fShcm/yZs/E3/ObgExeVpDsJ2TepMjzm0btBOCeHiahd5j
	0IQR7RBYEYTjVSeUUJhotJ3N/kZqxad93NWRWs/td2YuAkROy24rF+2hvg9FHJyP
	JarJILQo95UFI5iA==
Received: (qmail 3544968 invoked from network); 15 Oct 2025 22:59:33 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Oct 2025 22:59:33 +0200
X-UD-Smtp-Session: l3s3148p1@zckBxzhBbLMujnsG
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 1/2] reset: always bail out on missing RESET_GPIO driver
Date: Wed, 15 Oct 2025 22:59:21 +0200
Message-ID: <20251015205919.12678-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optional GPIOs mean they can be omitted. If they are described, a
failure in acquiring them still needs to be reported. When the
RESET_GPIO is not enabled (so the reset core cannot provide its assumed
fallback), the user should be informed about it. So, not only bail out
but also give a hint how to fix the situation. This means the check has
to be moved after ensuring the GPIO is really described.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since RFC v1:
* moved the code after second phandle check
* switched to pr_err
* updated commit message
* moved Reported-by to patch 2

 drivers/reset/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae5..c1909074f715 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1028,9 +1028,6 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
 	if (ret) {
-		if (!IS_ENABLED(CONFIG_RESET_GPIO))
-			return optional ? NULL : ERR_PTR(ret);
-
 		/*
 		 * There can be only one reset-gpio for regular devices, so
 		 * don't bother with the "reset-gpios" phandle index.
@@ -1040,6 +1037,11 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 		if (ret)
 			return optional ? NULL : ERR_PTR(ret);
 
+		if (!IS_ENABLED(CONFIG_RESET_GPIO)) {
+			pr_err("%s(): RESET_GPIO driver not enabled, cannot fall back\n", __func__);
+			return ERR_PTR(-ENOEXEC);
+		}
+
 		gpio_fallback = true;
 
 		ret = __reset_add_reset_gpio_device(&args);
-- 
2.47.2


