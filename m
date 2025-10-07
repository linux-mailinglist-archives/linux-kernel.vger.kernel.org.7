Return-Path: <linux-kernel+bounces-843946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B6BC0A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD1C189EFB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F852D77EF;
	Tue,  7 Oct 2025 08:32:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79B2D5A0C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825976; cv=none; b=Y0TiaXW5Fmzb8G4wM0HwqJLmw+KBny8YAOWSKhro3DYdO1yvGCZ18uUEZEOhlznkj1QvlYWF2ztmFiLNvZBXnvaW0jOMKTBXeLd+ZUj+1aDHqxxloRbL0aGtFrbdhsT48OGSUKlkbHAm/nfmtb491ZKShN68dMOjkkThEnUofKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825976; c=relaxed/simple;
	bh=FE/v7WPfFFkRfOu5bkbgFlAf0Iqzl95j48vKzQ3Ftvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JpGfsvafY+GkZvUyhfYbJwsJ7QyZ/vOeuWfxKYra6kcS+DD3T6WZ5DiSsMEc5uGVhoTlJG/XLvfqgbVTD0/4StUvfgq6zFsM5hgoq52CMaqu/iCGBEKq/h12yV6NBV56gHUOxF1NJ4gU9DKebatCrLOPIR00LPs8D1p3dW+wTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1v637r-0002Hb-Ur; Tue, 07 Oct 2025 10:32:52 +0200
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Tue, 07 Oct 2025 10:31:58 +0200
Subject: [PATCH 05/16] media: rockchip: rga: use card type to specify rga
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-spu-rga3-v1-5-36ad85570402@pengutronix.de>
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
In-Reply-To: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
To: Jacob Chen <jacob-chen@iotwrt.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In preparation of the RGA3 support add a filed to the rga_hw struct
to specify the desired card type value. This allows the user to
differentiate the RGA2 and RGA3 video device nodes.

Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/media/platform/rockchip/rga/rga-hw.c | 1 +
 drivers/media/platform/rockchip/rga/rga.c    | 4 +++-
 drivers/media/platform/rockchip/rga/rga.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index 871fe8c787c8d8dbd55c111c3fba3953d4debf02..a44befe4054d19e3b921c0827af4d36cf077e61f 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -619,6 +619,7 @@ static struct rga_fmt formats[] = {
 };
 
 const struct rga_hw rga2_hw = {
+	.card_type = "rga2",
 	.formats = formats,
 	.num_formats = ARRAY_SIZE(formats),
 	.cmdbuf_size = RGA_CMDBUF_SIZE,
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 32d24cdf17e9db38541d2b1615c6337def9362c6..ce55b48ef9fa8fbb2b265455cc559a4216609d4f 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -286,8 +286,10 @@ static const struct v4l2_file_operations rga_fops = {
 static int
 vidioc_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
 {
+	struct rockchip_rga *rga = video_drvdata(file);
+
 	strscpy(cap->driver, RGA_NAME, sizeof(cap->driver));
-	strscpy(cap->card, "rockchip-rga", sizeof(cap->card));
+	strscpy(cap->card, rga->hw->card_type, sizeof(cap->card));
 	strscpy(cap->bus_info, "platform:rga", sizeof(cap->bus_info));
 
 	return 0;
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index 61a00f56ce9b31968881e22bef873612b62e21d9..257267738d5d179d9ec4fcb5c8729783c9b713de 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -151,6 +151,7 @@ static inline void rga_mod(struct rockchip_rga *rga, u32 reg, u32 val, u32 mask)
 };
 
 struct rga_hw {
+	const char *card_type;
 	struct rga_fmt *formats;
 	u32 num_formats;
 	size_t cmdbuf_size;

-- 
2.51.0


