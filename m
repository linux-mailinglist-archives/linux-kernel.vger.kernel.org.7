Return-Path: <linux-kernel+bounces-815323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E688B562B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1477C17F697
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4A248F65;
	Sat, 13 Sep 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A72VPpGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FBA20E6F3;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791191; cv=none; b=dTaT+/I3UXe5FiNTfDrHIoppwKk+FpU7n3tTCk9/IDaRlmZB+JnbJ8mOKeEOXdcrQOqyDBgXJ3oixnwsoRTYbABSWIQOjav80SAZxdKOVvbQ9ocIDGl2NAjlD5DqTHt7KzhCjt0jYKkB9ZiWjHzwqAJcmb9L2BHYQ6iG80x4NEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791191; c=relaxed/simple;
	bh=D2z+oF6F047TpnEznp6oagMdF2PSz/sUfdT88afYQ90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFPFiAnxg+gqAm/00QyiTNQKxObuwnqe7RP4XYqvxmoSVfSDMXOrygk1PHuLDqrmAEtX8SuQ4b6jnS516AoH5kcxYLIrzomwLQeMYkqpswiS4Nsat9yXDyFOhpvx9JLMJRs80uDvJIwdHFWOzgDxINbGBu4ypUdrL1SJNxoXWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A72VPpGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70800C4CEF8;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757791191;
	bh=D2z+oF6F047TpnEznp6oagMdF2PSz/sUfdT88afYQ90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A72VPpGFVghpgMn2T0yPgyZ0n1JTlXbIFH/A2hfK9K2eYi/6+Bv397UIKmvY8LDPb
	 nN27ItFGO4oKidqKlGp3E/zouaIYdnM41Z3oDK6Ks1mtqpIWFhRwBGNKpBBgb7VVhg
	 MspRzi9SoI3edPMR96Ti6m3yTeWaUbajFKUsWr9EWTqAHjlq8oDc33lJpwyJg5Wo+G
	 KweZYHOZMQSIlEPw6W1Ddj43pD+OXIHjWlV9B4OQ3TMPVbhvhbpWp9qforKtWSRmbF
	 g9lWVlnyxc6OQhmjS7PJF3hpCGdlojRSh2xbGc6q2sACsSKGFswJ2qL3nYYS5LwtIE
	 MjpM3BGyma7rA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F954CAC58E;
	Sat, 13 Sep 2025 19:19:51 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 13 Sep 2025 21:19:47 +0200
Subject: [PATCH v6 1/3] drm: panel: nt36672a: Make some command sequences
 optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-nt35596s-v6-1-b5deb05e04af@ixit.cz>
References: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
In-Reply-To: <20250913-nt35596s-v6-0-b5deb05e04af@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Molly Sophia <mollysophia379@gmail.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QTYZEo7wDH4JK80WKEmXRMnm9sUlw16EBzi/obT5zQ0=;
 b=kA0DAAgBYAI/xNNJIHIByyZiAGjFw9Wiz6mWj07JiHm6qevg86j9McXDcPlt/chYi0NaAMDNR
 YkCMwQAAQgAHRYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJoxcPVAAoJEGACP8TTSSByOs0P/21U
 TZd6OHLvr3BU1Xdty/CGUydc1FZm6ai45xC1u3qU/2A8e62YzTdw2IzimQ7sOdBpMRy1Zzyco2d
 Njsnf9kVicuAKt96lmxmxqrbXAUiOpZy/nczu+HpsBwp/5ElvQtBfMdCodH0gXqXK3OTlkR84Ou
 xBGh2BmubM5Habr1Oz/hG4scz99+tbsK2wmYM3V+PactnIqK9F32E+2vOhYjPOUkTs3SQRaap4H
 GJi8g8IJiB9CmdCHde9lG5sZ6EaCkBvXb6RYyt3l+PEsqhlT7IsWPLddLX4rkDqsuV9nrTiCnRv
 J5gTt4NNa2DF6Wts6lmn45LYa1GS+pcJWkq54n8/wcO1AuBZeblHjo3KgPi518LsRp/2Ka0/88M
 26tY5RLn/JJc0RQCUOhLMB1+YLILkYDx/Iz9H+JulJq2Mv53NFpOxAxylg7lXby7mMTTwy29mUz
 pL8vB04bbgzUTHssVbT/TkoG3aZia6Zh0ZZc/J9p9LjGJaFOmZ1N1GYeCqrnNZZu5oLxGpMzTMQ
 RIPqETejk8aPGN4oT3k5dDwZMWsPnuKU86Nf3aEVo5QDAXUzC+S86KLD4Z5MBPD4F3Td9DQrCIB
 BbEECYECD7i2xpjlgiIoDpgj/g6vldfR7q0uVWOikwpJismepvj3lr0MDa3swORiLT3zGsRlKHt
 6Dvhx
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Molly Sophia <mollysophia379@gmail.com>

Preparation for the follow-up nt35596s support, where not all sequences
are provided.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 29e1f6aea48060384f4639999174b67097a6c8a7..f7518ec469176a4e2d4f2b03f8e77f03511a12a7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -117,12 +117,13 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
 	int ret;
 
-	/* send off cmds */
-	ret = nt36672a_send_cmds(panel, pinfo->desc->off_cmds,
-				 pinfo->desc->num_off_cmds);
-
-	if (ret < 0)
-		dev_err(panel->dev, "failed to send DCS off cmds: %d\n", ret);
+	if (pinfo->desc->num_off_cmds != 0) {
+		/* send off cmds if present */
+		ret = nt36672a_send_cmds(panel, pinfo->desc->off_cmds,
+					 pinfo->desc->num_off_cmds);
+		if (ret < 0)
+			dev_err(panel->dev, "failed to send DCS off cmds: %d\n", ret);
+	}
 
 	ret = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (ret < 0)
@@ -200,13 +201,15 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	/* Send rest of the init cmds */
-	err = nt36672a_send_cmds(panel, pinfo->desc->on_cmds_2,
-				 pinfo->desc->num_on_cmds_2);
+	if (pinfo->desc->num_on_cmds_2 != 0) {
+		/* Send rest of the init cmds if present */
+		err = nt36672a_send_cmds(panel, pinfo->desc->on_cmds_2,
+					 pinfo->desc->num_on_cmds_2);
 
-	if (err < 0) {
-		dev_err(panel->dev, "failed to send DCS Init 2nd Code: %d\n", err);
-		goto poweroff;
+		if (err < 0) {
+			dev_err(panel->dev, "failed to send DCS Init 2nd Code: %d\n", err);
+			goto poweroff;
+		}
 	}
 
 	msleep(120);

-- 
2.51.0



