Return-Path: <linux-kernel+bounces-887655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E38C38D08
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131231A25E77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88822ACEF;
	Thu,  6 Nov 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="mgXdmeso"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204EB258EE9;
	Thu,  6 Nov 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394890; cv=none; b=coITuUXHa7LBpp2gJf3QcJiF3ZFv4azZXOJTk33HyZo6XqY3ec0nkAtFFctS3K2KxypfcfMi05OVzelzAGG/jSqLQHtw6gLWqUH1dokVIwPees+LUH98Ki0FkvsjfRRd+7EwQDPuBAsHCEEJyLBpzy88VhR48zwgWHfhh/hmRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394890; c=relaxed/simple;
	bh=SkugNnl5xO5VKbwb4R4GzfSYXCPRBx4T3UXJ7+ap1yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J01JX1CbbZKa4taapPuIrRo1pkN/bMK+25HoWkR/3UGW7ERiKWH4TlbwhPi1nrwjy1979wwgl1+3Id9fTYYBb+SH6rKozk1oZbV5G6BEV50A9A7tJC8Dybl6+75a8I4nWzJ4ol4P5kFCzqalGJBXpvCnEPb6OX/HHi2Hj5KUNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=mgXdmeso; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394824;
	bh=dlreJtu1yTZc+3gYynIBMms0O05/ZWzTxS4Cx5D33aA=;
	h=From:To:Subject:Date:Message-Id;
	b=mgXdmeso8Y5CzbeGvBmSoXVkikF7UGQcM84Tgan7qgPzmmW5dZ2AayaqkzPABuvcj
	 Sw0YQ/4oFGPupfSoH/7+R1fjjirkVkkatHIC/+rHqisQ6xy5FHm0xaSs+iH7V4kzZM
	 BLLZwqnUyRgbauDhXfoS789uQ1kwyR33o+qAFZ+Q=
X-QQ-mid: esmtpgz15t1762394822t3dff838e
X-QQ-Originating-IP: otWT7nKKGfQI+mkYDiDkRHYGEnaihLiw+FDQpRrNMKw=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:07:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8019224694940531236
From: Chaoyi Chen <kernel@airkyi.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 5/9] drm/panel: ilitek-ili9881d: Add support for Wanchanglong W552946AAA panel
Date: Thu,  6 Nov 2025 10:06:28 +0800
Message-Id: <20251106020632.92-6-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106020632.92-1-kernel@airkyi.com>
References: <20251106020632.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MoEtoil6yR/CNkuu9v3dTG2uI1VNp0vJRpos/NRJ08iueGeCH8On6t1v
	1B6f4wE9hQWLOZsoyLM61e6wF/KEFCyMnVckGv/kjzkh4ol4IyqGspWLHzyXcxZ8xJpMA4q
	rRF2UrpD/fHm9dj2oC7lopTbEm4vFChxKzxHI3kPPkY0D3d9hH6xnB6BmPVoeDNAJl5IFYe
	PkRp/FI1ZJzZ0himjZxKYNSN0JZ3rPiT2BKhHLRAHGPecS5d8bUMWyJwMUTOFxlJQTqMXS/
	obbP6ogRYE6drvCPSVSttz2G+yXT5mhKDgDBQPyFuT6S8RUhU+JzXWFBrwc44/Pf9fJzauv
	vgHzvA0v/R9FBdjRP8MdljRMCxb+H77f6w4/OxcV7iz4C7SUeCaTitetshWoix7NHvjBIzR
	7fhdpd0Q7FxSWQdQdExt8kHncAjqO12F0G3JvF9JXijhN/OZxjFxicFdXgZL23Ts6AjElHU
	XfCf9y/xbGAzw9/LhZ6MxpXW0dJEO53fCyPpUdgfGpipLpAyb507LmYNItgWQqEA32o5317
	/weBCgoCwRX8wQTr5DFA4dS6p8xoR4d1UfUaOowSamfNKjuaaBlqnWJVx1POm/Yfo8S8Vjv
	499fow0OfgsM8kFPNuGx1u2Enxw13rhBVpxe1EWfRImi377kjzEWxS6Eg9bXOS93BwPDxXs
	3VGa8bF9JvlgT6hZcyZSDlGShl97sRzJ3q/Cteh35XVlbyNZKPQK3daONV6c/foL5jyU0mf
	CFpqkKwrRhEkLwKC/UqSwvuwwpZR08soBB8Fz6iwMW1I2j/mhhULUYUSupWOrwwMaoB0kxU
	40Wohe/Np03jvYODzIkXRhVfbPH7JpGeK5Wn5eYzkJwuE+OetPagRqFPCQdIsMDAr0dv6n4
	LPDq2w2Cg/jw74zuD1pRlt5CubY5mebluS1SIoDpb28jabShF8MnUD+9BTp2WTYtH/Zw8Se
	9703iPKaIHCmmo4/poeteSeG0O3Fbwas/LU9aIB9oZn9bhvtXEf6tQNCvOv8kL6kXxkocgp
	K+XBXCAw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

W552946AAA is a panel by Wanchanglong. This panel utilizes the
Ilitek ILI9881D controller.

W552946AAA is similar to W552946ABA, but the W552946AAA only
uses 2 lanes.

Tested on rk3506g-evb1-v10.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 225 ++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index ad4993b2f92a..9b3e9450808d 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -820,6 +820,204 @@ static const struct ili9881c_instr tl050hdv35_init[] = {
 	ILI9881C_COMMAND_INSTR(0xd3, 0x39),
 };
 
+static const struct ili9881c_instr w552946aaa_init[] = {
+	ILI9881C_SWITCH_PAGE_INSTR(3),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x53),
+	ILI9881C_COMMAND_INSTR(0x04, 0x53),
+	ILI9881C_COMMAND_INSTR(0x05, 0x13),
+	ILI9881C_COMMAND_INSTR(0x06, 0x04),
+	ILI9881C_COMMAND_INSTR(0x07, 0x02),
+	ILI9881C_COMMAND_INSTR(0x08, 0x02),
+	ILI9881C_COMMAND_INSTR(0x09, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x10, 0x00),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x08),
+	ILI9881C_COMMAND_INSTR(0x16, 0x10),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x08),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0xc0),
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x02),
+	ILI9881C_COMMAND_INSTR(0x21, 0x09),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x55),
+	ILI9881C_COMMAND_INSTR(0x29, 0x03),
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x00),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x04),
+	ILI9881C_COMMAND_INSTR(0x35, 0x05),
+	ILI9881C_COMMAND_INSTR(0x36, 0x05),
+	ILI9881C_COMMAND_INSTR(0x37, 0x00),
+	ILI9881C_COMMAND_INSTR(0x38, 0x3c),
+	ILI9881C_COMMAND_INSTR(0x39, 0x35),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x40),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x88),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x00),
+	ILI9881C_COMMAND_INSTR(0x44, 0x1f),
+	ILI9881C_COMMAND_INSTR(0x50, 0x01),
+	ILI9881C_COMMAND_INSTR(0x51, 0x23),
+	ILI9881C_COMMAND_INSTR(0x52, 0x45),
+	ILI9881C_COMMAND_INSTR(0x53, 0x67),
+	ILI9881C_COMMAND_INSTR(0x54, 0x89),
+	ILI9881C_COMMAND_INSTR(0x55, 0xab),
+	ILI9881C_COMMAND_INSTR(0x56, 0x01),
+	ILI9881C_COMMAND_INSTR(0x57, 0x23),
+	ILI9881C_COMMAND_INSTR(0x58, 0x45),
+	ILI9881C_COMMAND_INSTR(0x59, 0x67),
+	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
+	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
+	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
+	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
+	ILI9881C_COMMAND_INSTR(0x5e, 0x03),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x14),
+	ILI9881C_COMMAND_INSTR(0x60, 0x15),
+	ILI9881C_COMMAND_INSTR(0x61, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x63, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x64, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x65, 0x10),
+	ILI9881C_COMMAND_INSTR(0x66, 0x11),
+	ILI9881C_COMMAND_INSTR(0x67, 0x08),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x6a, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x70, 0x02),
+	ILI9881C_COMMAND_INSTR(0x71, 0x02),
+	ILI9881C_COMMAND_INSTR(0x72, 0x06),
+	ILI9881C_COMMAND_INSTR(0x73, 0x02),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x14),
+	ILI9881C_COMMAND_INSTR(0x76, 0x15),
+	ILI9881C_COMMAND_INSTR(0x77, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x78, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x79, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x7a, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x7b, 0x11),
+	ILI9881C_COMMAND_INSTR(0x7c, 0x10),
+	ILI9881C_COMMAND_INSTR(0x7d, 0x06),
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7f, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x80, 0x02),
+	ILI9881C_COMMAND_INSTR(0x81, 0x02),
+	ILI9881C_COMMAND_INSTR(0x82, 0x02),
+	ILI9881C_COMMAND_INSTR(0x83, 0x02),
+	ILI9881C_COMMAND_INSTR(0x84, 0x02),
+	ILI9881C_COMMAND_INSTR(0x85, 0x02),
+	ILI9881C_COMMAND_INSTR(0x86, 0x02),
+	ILI9881C_COMMAND_INSTR(0x87, 0x02),
+	ILI9881C_COMMAND_INSTR(0x88, 0x08),
+	ILI9881C_COMMAND_INSTR(0x89, 0x02),
+	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
+	ILI9881C_SWITCH_PAGE_INSTR(4),
+	ILI9881C_COMMAND_INSTR(0x00, 0x80),
+	ILI9881C_COMMAND_INSTR(0x70, 0x00),
+	ILI9881C_COMMAND_INSTR(0x71, 0x00),
+	ILI9881C_COMMAND_INSTR(0x66, 0xfe),
+	ILI9881C_COMMAND_INSTR(0x82, 0x15),
+	ILI9881C_COMMAND_INSTR(0x84, 0x15),
+	ILI9881C_COMMAND_INSTR(0x85, 0x15),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x24),
+	ILI9881C_COMMAND_INSTR(0x32, 0xac),
+	ILI9881C_COMMAND_INSTR(0x8c, 0x80),
+	ILI9881C_COMMAND_INSTR(0x3c, 0xf5),
+	ILI9881C_COMMAND_INSTR(0x88, 0x33),
+	ILI9881C_SWITCH_PAGE_INSTR(1),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x53, 0x78),
+	ILI9881C_COMMAND_INSTR(0x55, 0x7b),
+	ILI9881C_COMMAND_INSTR(0x60, 0x20),
+	ILI9881C_COMMAND_INSTR(0x61, 0x00),
+	ILI9881C_COMMAND_INSTR(0x62, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x63, 0x00),
+	ILI9881C_COMMAND_INSTR(0xa0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xa1, 0x10),
+	ILI9881C_COMMAND_INSTR(0xa2, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xa3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xa4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xa5, 0x26),
+	ILI9881C_COMMAND_INSTR(0xa6, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xa7, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xa8, 0x67),
+	ILI9881C_COMMAND_INSTR(0xa9, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xaa, 0x29),
+	ILI9881C_COMMAND_INSTR(0xab, 0x5b),
+	ILI9881C_COMMAND_INSTR(0xac, 0x26),
+	ILI9881C_COMMAND_INSTR(0xad, 0x28),
+	ILI9881C_COMMAND_INSTR(0xae, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xaf, 0x30),
+	ILI9881C_COMMAND_INSTR(0xb0, 0x31),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x32),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x00),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x2e),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x32),
+	ILI9881C_COMMAND_INSTR(0xb3, 0x00),
+	ILI9881C_COMMAND_INSTR(0xb6, 0x02),
+	ILI9881C_COMMAND_INSTR(0xb7, 0x03),
+	ILI9881C_COMMAND_INSTR(0xc0, 0x00),
+	ILI9881C_COMMAND_INSTR(0xc1, 0x10),
+	ILI9881C_COMMAND_INSTR(0xc2, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xc4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xc5, 0x26),
+	ILI9881C_COMMAND_INSTR(0xc6, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xc7, 0x1d),
+	ILI9881C_COMMAND_INSTR(0xc8, 0x67),
+	ILI9881C_COMMAND_INSTR(0xc9, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xca, 0x29),
+	ILI9881C_COMMAND_INSTR(0xcb, 0x5b),
+	ILI9881C_COMMAND_INSTR(0xcc, 0x26),
+	ILI9881C_COMMAND_INSTR(0xcd, 0x28),
+	ILI9881C_COMMAND_INSTR(0xce, 0x5c),
+	ILI9881C_COMMAND_INSTR(0xcf, 0x30),
+	ILI9881C_COMMAND_INSTR(0xd0, 0x31),
+	ILI9881C_COMMAND_INSTR(0xd1, 0x2e),
+	ILI9881C_COMMAND_INSTR(0xd2, 0x32),
+	ILI9881C_COMMAND_INSTR(0xd3, 0x00),
+	ILI9881C_SWITCH_PAGE_INSTR(0),
+};
+
 static const struct ili9881c_instr w552946ab_init[] = {
 	ILI9881C_SWITCH_PAGE_INSTR(3),
 	ILI9881C_COMMAND_INSTR(0x01, 0x00),
@@ -1772,6 +1970,23 @@ static const struct drm_display_mode tl050hdv35_default_mode = {
 	.height_mm	= 110,
 };
 
+static const struct drm_display_mode w552946aaa_default_mode = {
+	.clock		= 65000,
+
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 52,
+	.hsync_end	= 720 + 52 + 8,
+	.htotal		= 720 + 52 + 8 + 48,
+
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 16,
+	.vsync_end	= 1280 + 16 + 6,
+	.vtotal		= 1280 + 16 + 6 + 15,
+
+	.width_mm	= 68,
+	.height_mm	= 121,
+};
+
 static const struct drm_display_mode w552946aba_default_mode = {
 	.clock		= 64000,
 
@@ -1983,6 +2198,15 @@ static const struct ili9881c_desc tl050hdv35_desc = {
 	.default_address_mode = 0x03,
 };
 
+static const struct ili9881c_desc w552946aaa_desc = {
+	.init = w552946aaa_init,
+	.init_length = ARRAY_SIZE(w552946aaa_init),
+	.mode = &w552946aaa_default_mode,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
+	.lanes = 2,
+};
+
 static const struct ili9881c_desc w552946aba_desc = {
 	.init = w552946ab_init,
 	.init_length = ARRAY_SIZE(w552946ab_init),
@@ -2023,6 +2247,7 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "feixin,k101-im2byl02", .data = &k101_im2byl02_desc },
 	{ .compatible = "startek,kd050hdfia020", .data = &kd050hdfia020_desc },
 	{ .compatible = "tdo,tl050hdv35", .data = &tl050hdv35_desc },
+	{ .compatible = "wanchanglong,w552946aaa", .data = &w552946aaa_desc },
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
 	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
-- 
2.51.1


