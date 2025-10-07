Return-Path: <linux-kernel+bounces-843944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074ABC0A48
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAAD189EF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B02D47F5;
	Tue,  7 Oct 2025 08:32:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76922D5944
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825975; cv=none; b=N2J6Na8VzbE8rujILVz7IhY9uuIn/FxCvsiF/BHYIHIF1AMepmxOgbTCERyXvi41V2hiEgJnAIAfVpd9t7/pT7RPsMdBhN7Mm/xXzvkj65PtMojPBKUmJKz1NN5qJxr0HoJtUWoy8zCFiiSBUIIj8/qQHwVA7Mp3zMhBSbWWLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825975; c=relaxed/simple;
	bh=KVsgiZyiRmT5EtwxVArjMCYkxEe7fYqEDI4m3XHEGAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo64W+s6z8BtJe+adGiEWr6WCp6ObinRYNW6YkmmJRr/4HbnI1E4weH0X0G8v5o6YKfDL7KT/mCMS1e0Gs0vBYyKU2SypGfzMq64pcC2Sv2FugMStErhr4iDGHi8exsZxDrOAbLmNbYoOMlzJgYZb9c7Kgv0yBCPxnEHtQITn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1v637q-0002Hb-C9; Tue, 07 Oct 2025 10:32:50 +0200
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Tue, 07 Oct 2025 10:31:56 +0200
Subject: [PATCH 03/16] media: rockchip: rga: align stride to 16 bytes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-spu-rga3-v1-3-36ad85570402@pengutronix.de>
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

Align the stride to a multiple of 16 according to the RGA3 requirements
mentioned in the datasheet. This also ensures that the stride of the RGA2
is aligned to 4 bytes, as it needs to divide the value by 4 (one word)
before storing it in the register.

Increasing the stride for the alignment also requires to increase the
sizeimage value. This is usually handled by v4l2_fill_pixfmt_mp, but
it doesn't allow to set a stride alignment. Therefore use the generated
values to calculate the total number of lines to properly update the
sizeimage value after the bytesperline has been aligned.

Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/media/platform/rockchip/rga/rga.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 6438119a6c7aeff1e89e7aa95dcd5d2921fefa08..3cb7ce470c47e39d694e8176875a75fad2717f96 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -459,6 +459,25 @@ static int vidioc_enum_fmt(struct file *file, void *priv, struct v4l2_fmtdesc *f
 	return 0;
 }
 
+static void align_pixfmt(struct v4l2_pix_format_mplane *pix_fmt)
+{
+	int lines;
+	struct v4l2_plane_pix_format *fmt;
+
+	/*
+	 * Align stride to 16 for the RGA3 (based on the datasheet)
+	 * To not dismiss the v4l2_fill_pixfmt_mp helper
+	 * (and manually write it again), we're approximating the new sizeimage
+	 */
+	for (fmt = pix_fmt->plane_fmt;
+	     fmt < pix_fmt->plane_fmt + pix_fmt->num_planes;
+	     fmt++) {
+		lines = DIV_ROUND_UP(fmt->sizeimage, fmt->bytesperline);
+		fmt->bytesperline = (fmt->bytesperline + 0xf) & ~0xf;
+		fmt->sizeimage = fmt->bytesperline * lines;
+	}
+}
+
 static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 {
 	struct v4l2_pix_format_mplane *pix_fmt = &f->fmt.pix_mp;
@@ -474,6 +493,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		return PTR_ERR(frm);
 
 	v4l2_fill_pixfmt_mp(pix_fmt, frm->fmt->fourcc, frm->width, frm->height);
+	align_pixfmt(pix_fmt);
 
 	pix_fmt->field = V4L2_FIELD_NONE;
 	pix_fmt->colorspace = frm->colorspace;
@@ -496,6 +516,7 @@ static int vidioc_try_fmt(struct file *file, void *priv, struct v4l2_format *f)
 				(u32)MIN_HEIGHT, (u32)MAX_HEIGHT);
 
 	v4l2_fill_pixfmt_mp(pix_fmt, fmt->fourcc, pix_fmt->width, pix_fmt->height);
+	align_pixfmt(pix_fmt);
 	pix_fmt->field = V4L2_FIELD_NONE;
 
 	return 0;

-- 
2.51.0


