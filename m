Return-Path: <linux-kernel+bounces-843954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E5BC0A67
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EC6189FA9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F402D9EE7;
	Tue,  7 Oct 2025 08:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5A2D8DCA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825982; cv=none; b=hmqzeWkZA7WX/WwQPrQS8oWQ4pGdsuYz/F5oL5+d5OWLWh9sy+vL1ZwkvM2J60MUUuGQGbjLCmC3ZZMj9XHfTUZE6K0XgtET0iLMUGc7R23BwDlR2C2gtANMBeFwnSYydwreVvC5p0Y2nLlIZhOuC0TnD5VRcHv2TaVQBg4C1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825982; c=relaxed/simple;
	bh=pRDW7lgbAUaacoOPhIHLsMUsCwmihqrcWqugGPVfDW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJty7VosIOzH+usNLcaRfNRsSgf7L+Iw89pcReyuNm7U6iHqESHhWB+t3qAsHafAoWYYsz+zOwEQCxm59H7f0YZzw35gEVMkk5fSl0zg7hhmtzCkVUIhmo/GeU3gt3A0cKvQcv4mk6S+7JlUI8C7h1fLainQT++4MU6VVZRnRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=peter.mobile.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1v637x-0002Hb-Mm; Tue, 07 Oct 2025 10:32:57 +0200
From: =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Date: Tue, 07 Oct 2025 10:32:05 +0200
Subject: [PATCH 12/16] media: rockchip: rga: handle error interrupt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-spu-rga3-v1-12-36ad85570402@pengutronix.de>
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

Handle the error interrupt status in preparation of the RGA3 addition.
This allows the buffer to be marked as done, as it would otherwise
be stuck in the queue.

The RGA3 needs a soft reset to properly work after an error occurred,
as it would otherwise cease to deliver new interrupts. Also the soft
reset avoids additional error interrupts to be triggered, which are
currently not supported by the rga_isr function.
As it is unknown how the RGA2 behaves in the error case, no
error interrupt was enabled and handled.

Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
---
 drivers/media/platform/rockchip/rga/rga-hw.c |  6 ++++--
 drivers/media/platform/rockchip/rga/rga.c    | 32 +++++++++++++++++-----------
 drivers/media/platform/rockchip/rga/rga.h    |  8 ++++++-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index d54183d224b3e9c42d5503acf172257f2e736f7b..93822b5b8b15e76862bd022759eaa5cb9552dd76 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -459,7 +459,7 @@ static void rga_hw_start(struct rockchip_rga *rga,
 	rga_write(rga, RGA_CMD_CTRL, 0x1);
 }
 
-static bool rga_handle_irq(struct rockchip_rga *rga)
+static enum rga_irq_result rga_handle_irq(struct rockchip_rga *rga)
 {
 	int intr;
 
@@ -467,7 +467,9 @@ static bool rga_handle_irq(struct rockchip_rga *rga)
 
 	rga_mod(rga, RGA_INT, intr << 4, 0xf << 4);
 
-	return intr & 0x04;
+	if (intr & 0x04)
+		return RGA_IRQ_DONE;
+	return RGA_IRQ_IGNORE;
 }
 
 static void rga_get_version(struct rockchip_rga *rga)
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 0a725841b0cfa41bbc5b861b8f5ceac2452fc2b5..3b5d2eb8e109f44af76dd2240a239b1fa8a78cee 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -56,30 +56,38 @@ static void device_run(void *prv)
 static irqreturn_t rga_isr(int irq, void *prv)
 {
 	struct rockchip_rga *rga = prv;
+	struct vb2_v4l2_buffer *src, *dst;
+	struct rga_ctx *ctx = rga->curr;
+	enum rga_irq_result result;
 
-	if (rga->hw->handle_irq(rga)) {
-		struct vb2_v4l2_buffer *src, *dst;
-		struct rga_ctx *ctx = rga->curr;
+	result = rga->hw->handle_irq(rga);
+	if (result == RGA_IRQ_IGNORE)
+		return IRQ_HANDLED;
 
-		WARN_ON(!ctx);
+	WARN_ON(!ctx);
 
-		rga->curr = NULL;
+	rga->curr = NULL;
 
-		src = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-		dst = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	src = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	dst = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
 
-		WARN_ON(!src);
-		WARN_ON(!dst);
+	WARN_ON(!src);
+	WARN_ON(!dst);
 
-		v4l2_m2m_buf_copy_metadata(src, dst, true);
+	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-		dst->sequence = ctx->csequence++;
+	dst->sequence = ctx->csequence++;
 
+	if (result == RGA_IRQ_DONE) {
 		v4l2_m2m_buf_done(src, VB2_BUF_STATE_DONE);
 		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
-		v4l2_m2m_job_finish(rga->m2m_dev, ctx->fh.m2m_ctx);
+	} else {
+		v4l2_m2m_buf_done(src, VB2_BUF_STATE_ERROR);
+		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_ERROR);
 	}
 
+	v4l2_m2m_job_finish(rga->m2m_dev, ctx->fh.m2m_ctx);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
index e19c4c82aca5ae2056f52d525138093fbbb81af8..dc4bb85707d12f5378c4891098cd7ea4a4d75e2d 100644
--- a/drivers/media/platform/rockchip/rga/rga.h
+++ b/drivers/media/platform/rockchip/rga/rga.h
@@ -143,6 +143,12 @@ static inline void rga_mod(struct rockchip_rga *rga, u32 reg, u32 val, u32 mask)
 	rga_write(rga, reg, temp);
 };
 
+enum rga_irq_result {
+	RGA_IRQ_IGNORE,
+	RGA_IRQ_DONE,
+	RGA_IRQ_ERROR,
+};
+
 struct rga_hw {
 	const char *card_type;
 	bool has_internal_iommu;
@@ -152,7 +158,7 @@ struct rga_hw {
 
 	void (*start)(struct rockchip_rga *rga,
 		      struct rga_vb_buffer *src, struct rga_vb_buffer *dst);
-	bool (*handle_irq)(struct rockchip_rga *rga);
+	enum rga_irq_result (*handle_irq)(struct rockchip_rga *rga);
 	void (*get_version)(struct rockchip_rga *rga);
 	void *(*try_format)(u32 *fourcc, bool is_output);
 	int (*enum_format)(struct v4l2_fmtdesc *f);

-- 
2.51.0


