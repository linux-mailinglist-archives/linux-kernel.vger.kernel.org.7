Return-Path: <linux-kernel+bounces-803342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF2B45DDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C91CC335A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61F30B500;
	Fri,  5 Sep 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="K0MhL6cN"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B0309F06
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089219; cv=none; b=Vm/bS8n3psbySg3rcYr4jljmOb8abBNRCOLZUDvpPB1OWnr6wsUKhLwoKOnhrAZP0eYuUwgHNz2PsHlPMmQ3oOvSAGUj9ZSl+CAerratKsrBpMXrzONNKgcNZCbo6S9sTcdb4IjBLfFbTJfKb9py5qcNfj1PfQqUIKieX3vVA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089219; c=relaxed/simple;
	bh=Ca0oteHvtODJ8QEGbCD9HKZOWT+cAQB/6nZ2cmWsX1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDcnEhFXV3AS5KRpH5zc68z+xhW+4Scq/QAIVqj4V9BTTWXoou6sneF5XA79WdHhwZAeDLchqJs8f6ra2ffm/hFy8TplpmHhVrhdzTsVs1Kjcdxkw27hbX3gWlRFVtT8VulhuOVe5RMzga5o3dbJO/Txq3I1xAqAZIAAxmrfzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=K0MhL6cN; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1757089217; bh=a24JwIPc+tBBg820eesT0m8iwbS1J/efZ6fiBKYnR3s=;
 b=K0MhL6cNe4oEp53+dmlrGteaTRQaVbQpbYOKGXKzL2DUxCCmWgviQR+G4IcpxzZBU3mwPi66+
 5pCfUI0iXx19kFDrxulsxQyEWR8okhttcRRhkSORnLYFDomDSjjxGuvBWQHtxNgwD4mvLvR4ohr
 p7rlF19ty6srE1ArTlAf6JOJkqUUNxR5e+bwOXltmZ/mHj6qwD1LLpqnYCf2MGva9NEBWqoF5nk
 UhzZMeGOyxIQ4gilmr9Epa1/ytBiooOlkI4lKEDYIq9t6T0s99yfldcQtSCFV0KmcCPrY8A3RuV
 N+K9vqmIMTgrae9pRQhfjQ+IPN1RIrAGKJldjzmvq9aQ==
X-Forward-Email-ID: 68bb0dbc90d039a4fd84d62f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.13
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Alex Bee <knaerzche@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 4/7] media: rkvdec: Add RK3288 variant
Date: Fri,  5 Sep 2025 16:19:22 +0000
Message-ID: <20250905161942.3759717-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905161942.3759717-1-jonas@kwiboo.se>
References: <20250905161942.3759717-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add a RK3288 variant, a version of the Rockchip VDEC IP that only
support HEVC decoding.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- Add num_regs field
- Collect r-b tag

Changes in v2:
- No change
---
 drivers/media/platform/rockchip/rkvdec/rkvdec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
index 088ddfadf995..f8cbc7bcfa15 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
@@ -1221,6 +1221,11 @@ static void rkvdec_watchdog_func(struct work_struct *work)
 	}
 }
 
+static const struct rkvdec_variant rk3288_rkvdec_variant = {
+	.num_regs = 68,
+	.capabilities = RKVDEC_CAPABILITY_HEVC,
+};
+
 static const struct rkvdec_variant rk3399_rkvdec_variant = {
 	.num_regs = 78,
 	.capabilities = RKVDEC_CAPABILITY_HEVC |
@@ -1229,6 +1234,10 @@ static const struct rkvdec_variant rk3399_rkvdec_variant = {
 };
 
 static const struct of_device_id of_rkvdec_match[] = {
+	{
+		.compatible = "rockchip,rk3288-vdec",
+		.data = &rk3288_rkvdec_variant,
+	},
 	{
 		.compatible = "rockchip,rk3399-vdec",
 		.data = &rk3399_rkvdec_variant,
-- 
2.51.0


