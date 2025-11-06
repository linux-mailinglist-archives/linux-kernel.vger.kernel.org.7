Return-Path: <linux-kernel+bounces-889087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5DC3CB51
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FF2421B04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101F34BA5B;
	Thu,  6 Nov 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/pF21hX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501B34A3A2;
	Thu,  6 Nov 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448354; cv=none; b=MwWj+igy3wOG+qqKNU8K8sYDQ7aV4TLkMb+WSPnekYZMCUMd8SdgXxLCsOyzksIKhI350ekxbFb0Usq2ZPALkoAE3QvSOIL+x5Pe3ong9knpuKUkmjlVXwFlNIX8MPumLOv2MwbR4jgpiAnilgfAEuLdhBuPKR+uRTkWI2PbGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448354; c=relaxed/simple;
	bh=5zVxDLJDS4HgZvm0mUPMa4NXwy0uzOr1eXabb1arNpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mk35u6otX9xV47YOEKSDuWQvyIHDv/fDQ2g6CYOIvMqs70p1SCiix/uV/fXpjUpGzS1KD40MqedEj50Ny1PeDK6/mJwlkJjOJCNXlmKdRVPSft22WORJsYACfY7DfU/hJmAXlVzWwUxGAl2paV7QbBm0FBCg6CZbLjvOtIvkjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/pF21hX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7582C4CEF7;
	Thu,  6 Nov 2025 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448353;
	bh=5zVxDLJDS4HgZvm0mUPMa4NXwy0uzOr1eXabb1arNpI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m/pF21hXXdxtUQjEpD7ImAPfMVCmNCJ2tehEPz5uAKfbfWxrAQnoXZPNFBbgOe+A6
	 VyU4Gr6tnm/VOVLcTJIsz8H2+IFUox0CEJF3M25ALvUjI6qwJ+M23+yi68cfIhFcg9
	 Iokb74FJ1ZmUNMPv5qBKvvCpMQbccALrAlRtUB8dCFNz+k4yk+hyUm8ZIAk9m6qREs
	 ZaA0G8RRFZCikQck59el+G/yILo0vRrVxw/9zzEnfmLM+1PGZ/ozslAgVoenTS1X64
	 uobNY6wQ7vIDer2ViUmnr7nFcyCNtQzy4CjD60pQd3QwRygy+NKpxX7XZg6rDF+VCG
	 Bh0ISPmF1I24g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D679ACCFA13;
	Thu,  6 Nov 2025 16:59:12 +0000 (UTC)
From: Kimi Chen via B4 Relay <devnull+kimi.zy.chen.fii-foxconn.com@kernel.org>
Date: Fri, 07 Nov 2025 00:58:39 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: add gpio line name to io
 expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-dts-add-gpio-to-io-expander-v2-1-585d48845546@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAL7TDGkC/42NQQ6CMBBFr2Jm7RhaAaMr72FYlOkUZmGHtIRgC
 He3cgI3P3l/8d4GmZNwhsdpg8SLZNFYwJ5PQKOLA6P4wmAr2xhTtejnjM57HCZRnBXL8jq56Dm
 hq+lqiULTOgfFMCUOsh72V1d4lDxr+hyxxfze/7yLQYN9fWsbqu6We34GEQy6ksZ4IX1Dt+/7F
 3ryuuvMAAAA
X-Change-ID: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Kimi Chen <kimi.zy.chen@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762448350; l=1406;
 i=kimi.zy.chen@fii-foxconn.com; s=20251105; h=from:subject:message-id;
 bh=q3Hjka33GAqrC98JfV2gHVz/SyvVpQc9OOGcXtH2A3s=;
 b=NrYZXH/6ZM0K5uh1E4Dpz9BEY/90j+EqlD+xpSNYCWBMgYSWb8gU3AUlhgA9eKPNOTBjBQ8xF
 hI/8nERMKFgDSBf2fbZg1SHASISyBZ14VLdDlX6u4mgFSYLGXe1XLtL
X-Developer-Key: i=kimi.zy.chen@fii-foxconn.com; a=ed25519;
 pk=3zHetsW/3CYYIgQlYV9dqSS7aW7aZXLUaIvc+OKr3NM=
X-Endpoint-Received: by B4 Relay for kimi.zy.chen@fii-foxconn.com/20251105
 with auth_id=559
X-Original-From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
Reply-To: kimi.zy.chen@fii-foxconn.com

From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>

The chassis power cycle process requires a forced shutdown before
cutting off the standby power. Therefore, SCM CPLD adds a hard shutdown
host function and triggers it via the IO expander in Clemente platform.

Thus, a new GPIO line named "hard_shutdown_host" is added to the
PCA9555 IO expander at line 10 to notify the CPLD to execute the hard
shutdown host function.

Signed-off-by: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
---
Changes in v2:
- Add "hard_shutdown_host" GPIO line name to PCA9555 IO expander for Clemente platform.
- Link to v1: https://lore.kernel.org/r/20251106-dts-add-gpio-to-io-expander-v1-1-b4765c092ebe@fii-foxconn.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36..0eafd8ea04ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -983,7 +983,7 @@ io_expander4: gpio@4f {
 			"",
 			"",
 			"",
-			"",
+			"hard_shutdown_host",
 			"",
 			"",
 			"",

---
base-commit: 6953afcd81a2cc73784e3dd23faa0a1aaf97441a
change-id: 20251106-dts-add-gpio-to-io-expander-a4c32ccf56aa

Best regards,
-- 
Kimi Chen <kimi.zy.chen@fii-foxconn.com>



