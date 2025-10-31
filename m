Return-Path: <linux-kernel+bounces-880367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B09C259CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88D31A21974
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59B34D91F;
	Fri, 31 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N/fL39rY"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94E34D4D7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921365; cv=none; b=mU1l6L7oIknCQzQAPdn+5RLTNKkmq+365EzL4ISUTvj9G4pTahEUvkomOljoyTE10qyCmaN6vGV0aV7e4UN0a0d/kAttDIJsRvSRtcDUEi/QtGx17wnsMNfw6U+EoqH1s4ubK7/QfS22mq5Gu7nMRgkEE4Bt3xrdikKkaAmdh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921365; c=relaxed/simple;
	bh=jSYgowSPnsKU4uTaoBMtC1kCUf9iWrbUFklkf+xnNYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfXoIQXE2U0c+Sur6DBG94OsrUwfGofmXMpKcoKKNH10ZttKu8NSNspsPtXanLKScsO45+KIO1umR7CF1VBgsEqy2/Bx9hJAexpsH8CL76yOc/ywx6ZcADHGhXdwO5Su9rdjJrV9odtwwuFXxHAGxYDPUr3hrWgmQjJBG89CS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N/fL39rY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BA2D64E4143F;
	Fri, 31 Oct 2025 14:36:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8ECBC60704;
	Fri, 31 Oct 2025 14:36:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20BE811818038;
	Fri, 31 Oct 2025 15:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761921360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8wBld+iTHvg/W6Ysw3IhzKMYKstkStW0Df/bDSMM+9Y=;
	b=N/fL39rYnp1pKdGPyPZu2a9JAHu8hWWlbIXFc7LkFLlrTSdIS2BiiFX6aqkOMf33NcrVB+
	kL1z/knY+J1Tpdc9w3JdinRk+vi7+9M1TNlV6MVLAWeY9y64xW6U6XNkGCFy0XFpncoWJW
	UfeJYNKLg86KLfTwvJckogvcPH2vWs9e+WtWQ6UXAgEi5MLpsUxwS3eFDutttcrPtKLqtC
	ktDbE2RgbvT30HILGWDaOOxpioyTKjhYqPfTDrSH5hx8nmOhSZMRh+upMlNbU/gYTYbISl
	4XWGQqSWXD4NiPGiKt76vWZwcveuAlyaHnL8trhWgYHL836i/bd4hSPMZJzmYA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 31 Oct 2025 15:35:42 +0100
Subject: [PATCH v2 4/5] i2c: designware: Implement I2C_M_STOP support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-i2c-dw-v2-4-90416874fcc0@bootlin.com>
References: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
In-Reply-To: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add the support of the I2C_M_STOP flag in i2c_msg by splitting
i2c_dw_xfer() in two: __i2c_dw_xfer_unlocked() for the core transfer logic
and i2c_dw_xfer() for handling the high-level transaction management.

In detail __i2c_dw_xfer_unlocked() starts a transaction and wait for its
completion, either with a STOP on the bus or an error. i2c_dw_xfer()
loops over the messages to search for the I2C_M_STOP flag and calls
__i2c_dw_xfer_unlocked() for each part of the messages up to a STOP or
the end of the messages array.

i2c_dw_xfer() holds the device lock while calling __i2c_dw_xfer_unlocked(),
this allows to group multiple accesses to device that support a STOP in
a transaction when done via i2c_dev I2C_RDWR ioctl, in a single-master
configuration.

Also, now that we have a lookup of the messages in i2c_dw_xfer() prior
to each transaction, we use it to make sure the messages are valid for
the transaction. We check that the target address does not change before
starting the transaction instead of aborting the transfer while it is
happening, as it was done in i2c_dw_xfer_msg(). The target address can
only be changed after an I2C_M_STOP flag, thus a STOP on the i2c bus.

The I2C_FUNC_PROTOCOL_MANGLING flag is added to the list of
functionalities supported by the adapter, except for the AMD NAVI i2c
controller which uses its own xfer() function and is left untouched.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 103 ++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index ec4fc2708d03..da1963d25def 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -431,7 +431,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	struct i2c_msg *msgs = dev->msgs;
 	u32 intr_mask;
 	int tx_limit, rx_limit;
-	u32 addr = msgs[dev->msg_write_idx].addr;
 	u32 buf_len = dev->tx_buf_len;
 	u8 *buf = dev->tx_buf;
 	bool need_restart = false;
@@ -442,18 +441,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
 		u32 flags = msgs[dev->msg_write_idx].flags;
 
-		/*
-		 * If target address has changed, we need to
-		 * reprogram the target address in the I2C
-		 * adapter when we are done with this transfer.
-		 */
-		if (msgs[dev->msg_write_idx].addr != addr) {
-			dev_err(dev->dev,
-				"%s: invalid target address\n", __func__);
-			dev->msg_err = -EINVAL;
-			break;
-		}
-
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
 			buf = msgs[dev->msg_write_idx].buf;
@@ -801,26 +788,15 @@ static int i2c_dw_wait_transfer(struct dw_i2c_dev *dev)
 }
 
 /*
- * Prepare controller for a transaction and call i2c_dw_xfer_msg.
+ * Prepare controller for a transaction, start the transfer of the msgs
+ * and wait for completion.
+ * Caller must hold the device lock.
  */
 static int
-i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+__i2c_dw_xfer_unlocked(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 {
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	int ret;
 
-	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
-
-	pm_runtime_get_sync(dev->dev);
-
-	switch (dev->flags & MODEL_MASK) {
-	case MODEL_AMD_NAVI_GPU:
-		ret = amd_i2c_dw_xfer_quirk(adap, msgs, num);
-		goto done_nolock;
-	default:
-		break;
-	}
-
 	reinit_completion(&dev->cmd_complete);
 	dev->msgs = msgs;
 	dev->msgs_num = num;
@@ -832,10 +808,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	dev->abort_source = 0;
 	dev->rx_outstanding = 0;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		goto done_nolock;
-
 	ret = i2c_dw_wait_bus_not_busy(dev);
 	if (ret < 0)
 		goto done;
@@ -896,13 +868,75 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	ret = -EIO;
 
+done:
+	return ret;
+}
+
+static int
+i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
+	struct i2c_msg *msg;
+	int ret, cnt;
+
+	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
+
+	pm_runtime_get_sync(dev->dev);
+
+	switch (dev->flags & MODEL_MASK) {
+	case MODEL_AMD_NAVI_GPU:
+		ret = amd_i2c_dw_xfer_quirk(adap, msgs, num);
+		goto done_nolock;
+	default:
+		break;
+	}
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		goto done_nolock;
+
+	/*
+	 * If the I2C_M_STOP is present in some the messages,
+	 * we do one transaction for each part up to the STOP.
+	 */
+	for (msg = msgs; msg < msgs + num; msg += cnt) {
+		u16 addr = msg->addr;
+
+		/*
+		 * Count the messages in a transaction, up to a STOP
+		 * or the end of the msgs.
+		 */
+		for (cnt = 1; ; cnt++) {
+			/*
+			 * We cannot change the target address during
+			 * a transaction, so make sure the address stays
+			 * the same.
+			 */
+			if (msg[cnt - 1].addr != addr) {
+				dev_err(dev->dev, "invalid target address\n");
+				ret = -EINVAL;
+				goto done;
+			}
+
+			if ((msg[cnt - 1].flags & I2C_M_STOP) ||
+			    (msg + cnt == msgs + num))
+				break;
+		}
+
+		ret = __i2c_dw_xfer_unlocked(dev, msg, cnt);
+		if (ret < 0)
+			goto done;
+	}
+
 done:
 	i2c_dw_release_lock(dev);
 
 done_nolock:
 	pm_runtime_put_autosuspend(dev->dev);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+	return num;
 }
 
 static const struct i2c_algorithm i2c_dw_algo = {
@@ -920,6 +954,9 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 
 	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
+	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
+		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 

-- 
2.51.1


