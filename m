Return-Path: <linux-kernel+bounces-856171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CBBE34B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE95504343
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3632A3C0;
	Thu, 16 Oct 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f8GWi8tG"
Received: from mx-relay04-hz2.antispameurope.com (mx-relay04-hz2.antispameurope.com [83.246.65.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA40326D50
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616909; cv=pass; b=EAbM1DeTkufbXH7PDBLIbe+1Tud9gV2m8Kq8ZiRHR1VduPtxoegzdpUZ367ELYC9wdP7SOb3ljSrAEdI3Iqr/kT6gVdIPLAKsNMGLXZbSK7mIXvR/xtaozfPGdRFdz9Uxh8s6g2FJxS/zuq4zvf3EM1w6t/EzszZnrt91BRLJDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616909; c=relaxed/simple;
	bh=+nT7wrU09OzSu4z9yJcXShxj9D77xku1c19SZi+Zfys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlAG4EZPim+zfMnlRvUEqt5a7WjHWlj7V1OLwWtVWtASACBCXkzVrfci/3F33SqF3LfIy4VieVNbFDRSSTAOq9KoVvG3xJwexoiGzKB18XaBYxjLaJ26NBSttbKh4ScMiCaMMKNN9fz/dVQtYdiDPvJruVfi5NWUDbE1fKd/S5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f8GWi8tG; arc=pass smtp.client-ip=83.246.65.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate04-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=snl/FA4F2odsZP4JCWfwkL/jLHpTuzRQFb/i2zMw6TA=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760616841;
 b=VZHIyj5PrFSbFKKlNGHSPSXWlQAAGKPO8Daqm4wtTcF8M8TT+UyJ1ll9Za34aycNfMggDR8Q
 oc7PZy3ZZN4s/1zisNqjGoy6iwBt5kCM53Owzzr6g0sud3Z7ZQa9QV8Dv+WVAm+40I8cdkhaEwS
 Veplmx6SZIMgEUyzLb1aqR2gDpchrmGuQe2+e53vF4Ovct0qCtc+WDjY67kxDbQrEyH/zNhV9xX
 ywn89fScHy42AnUS1T1SowbcGyoYZbMilDGv0ktzoEBaSRk/W6lJKXW60vi6wcQ8b81xFYEONWw
 l6233YVEUey2LiznHC4R8K0rvBxTip6PbD0Anhw2VQNTA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760616841;
 b=IhIug31a4CdS4ahkmFreETee1FJlETs+uJYQjvUECsDudcVk6b8rq0sDpR/cf77RtWbS5kUC
 KWVDaUR05G8/8oxLOp+srZZUUvx1dPhaloTN43UsM+/+guy3qCO28nfChxhob2yEY620ncCa0ZR
 p+iQylMBuaznXjx3J2R1M4BpITtjsxDk9jgczoFONLIb3cab5T3qs00/O6T70fG23sfOB8F4irH
 hq+B41S/qSxWpIPfNB08UnN4m5L4pQ+jCldBPtnj2Z6OP3re6gXQGEOSBVnt9MLAoZl9x7/L4CK
 XOexmNDJbBMqn7MZqPEG2gdxDEdlBy3wo3xatHYqCgoZQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay04-hz2.antispameurope.com;
 Thu, 16 Oct 2025 14:14:00 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 6D0A1A40A31;
	Thu, 16 Oct 2025 14:13:49 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/4] i2c: machxo2: new driver
Date: Thu, 16 Oct 2025 14:13:26 +0200
Message-ID: <5855f15ad83617d3a71b40d89d61273722c6e15f.1760601899.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay04-hz2.antispameurope.com with 4cnRgx6qBMz1kCKK
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:ff297c315025247f28474da0fb6e8b13
X-cloud-security:scantime:2.636
DKIM-Signature: a=rsa-sha256;
 bh=snl/FA4F2odsZP4JCWfwkL/jLHpTuzRQFb/i2zMw6TA=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760616840; v=1;
 b=f8GWi8tGnsB6gFFlE7v8VciIMD3c55iMm4w+Wns3IFqlmwm7GwlnL0C7buLvKH5x3D/cXkAb
 2qH0J+T81vWCD41EdukcgSpj/6V/i1r6YJnEdQcZ3xn9+U+xTFWwC31GkWH3bMqCkzk/2A2JMbb
 W1A8t31TWwf7X6pdd8lnD7CfXZN5RO3oTvwTPxd81dP720oqQNZzCZMbMIRgr9gBJXkGvefDcWQ
 iauVMwNjfLiSP96p2kpq46tkxIX0342tpaWMfUeV+2VisIOlfciCl0eJEDaz2QaRwNpp3afIcaF
 vNSt1zBoFF7dQsfq22d+qW0/b1Az+7HP/tJpXA/Ld+3kA==

Implement a driver for the "Hardened I2C" controller found on Lattice
MachXO2 family PLDs. The driver can run IRQ-driven or use a timer for
polling.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: use MODULE_DEVICE_TABLE()

 drivers/i2c/busses/Kconfig                |  10 +
 drivers/i2c/busses/Makefile               |   1 +
 drivers/i2c/busses/i2c-machxo2.c          | 703 ++++++++++++++++++++++
 include/linux/platform_data/i2c-machxo2.h |  17 +
 4 files changed, 731 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-machxo2.c
 create mode 100644 include/linux/platform_data/i2c-machxo2.h

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index fd81e49638aaa..9c170485a8924 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -855,6 +855,16 @@ config I2C_LS2X
 	  This driver can also be built as a module. If so, the module
 	  will be called i2c-ls2x.
 
+config I2C_MACHXO2
+	tristate "Lattice MachXO2 I2C Controller"
+	select REGMAP_MMIO
+	help
+	  If you say yes to this option, support will be included for the
+	  "Hardened I2C" controller found on the Lattice MachXO2 PLD family.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-machxo2.
+
 config I2C_MLXBF
         tristate "Mellanox BlueField I2C controller"
         depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index fb985769f5ff7..f9c44406be2e1 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_I2C_BRCMSTB)	+= i2c-brcmstb.o
 obj-$(CONFIG_I2C_CROS_EC_TUNNEL)	+= i2c-cros-ec-tunnel.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_ICY)		+= i2c-icy.o
+obj-$(CONFIG_I2C_MACHXO2)	+= i2c-machxo2.o
 obj-$(CONFIG_I2C_MLXBF)		+= i2c-mlxbf.o
 obj-$(CONFIG_I2C_MLXCPLD)	+= i2c-mlxcpld.o
 obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
diff --git a/drivers/i2c/busses/i2c-machxo2.c b/drivers/i2c/busses/i2c-machxo2.c
new file mode 100644
index 0000000000000..dba2c7a605381
--- /dev/null
+++ b/drivers/i2c/busses/i2c-machxo2.c
@@ -0,0 +1,703 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * i2c-machxo2.c: I2C bus driver for Lattice MachXO2 I2C controller
+ *
+ * Copyright (c) 2024-2025 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Author: Matthias Schiffer
+ *
+ * Based on driver by:
+ *   Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>
+ *
+ * Implementation follows "MachXO2 Family Handbook", HB1010 Version 01.8, with
+ * a few additional undocumented quirks described by comments.
+ *
+ * Basic design:
+ *
+ * All functions returning an enum machxo2_i2c_state are part of a state machine,
+ * each returning the next state to transition to. The state machine reflects
+ * the diagrams found in the aforementioned document.
+ *
+ * All processing is driven by the hrtimer handler machxo2_handle(). The hrtimer
+ * is used to poll the hardware for state transitions. In IRQ mode, the hrtimer
+ * is disabled in states where we are waiting for an IRQ; the IRQ handler does
+ * nothing but restart the timer to keep code paths in polling and IRQ mode as
+ * similar as possible.
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/hrtimer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/i2c-machxo2.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/wait.h>
+
+enum machxo2_i2c_state {
+	STATE_DONE,
+	STATE_START,
+	STATE_WRITE,
+	STATE_READ_WAIT_SRW,
+	STATE_READ,
+};
+
+struct machxo2_i2c {
+	struct i2c_adapter adap;
+	struct regmap *regmap;
+	u32 clock_khz;
+	u32 bus_khz;
+	int irq;
+
+	/* Current transfer state */
+	enum machxo2_i2c_state state;
+	struct i2c_msg *msg;
+	int nmsgs;
+	u16 pos;
+
+	wait_queue_head_t wait;
+	ktime_t timer_wait;
+
+	/* lock syncs arming the timer and setting the error field */
+	spinlock_t lock;
+	struct hrtimer timer;
+	int error;
+};
+
+#define MACHXO2_I2C_POST_TIMEOUT_US	1000
+
+/* Registers */
+#define I2C_CR			0 /* Control, RW */
+#define  I2C_CR_I2CEN		0x80 /* Enable I2C */
+
+#define I2C_CMDR		1 /* Command, RW */
+#define  I2C_CMDR_STA		0x80 /* Start */
+#define  I2C_CMDR_STO		0x40 /* Stop */
+#define  I2C_CMDR_RD		0x20 /* Read */
+#define  I2C_CMDR_WR		0x10 /* Write */
+#define  I2C_CMDR_ACK		0x08 /* Send NACK if the bit is set */
+#define  I2C_CMDR_CKSDIS	0x04 /* Clock stretch disable */
+
+#define I2C_BR0			2 /* Clock Pre-scale, RW */
+#define I2C_BR1			3 /* Clock Pre-scale, RW */
+#define I2C_TXDR		4 /* Transmit Data, WO */
+#define I2C_SR			5 /* Status, RO */
+#define  I2C_SR_TIP		0x80 /* Transmit In Progress */
+#define  I2C_SR_BUSY		0x40 /* Bus Busy */
+#define  I2C_SR_RARC		0x20 /* Received ACK (if unset) */
+#define  I2C_SR_SRW		0x10 /* Slave Read/Write */
+#define  I2C_SR_ARBL		0x08 /* Arbitration Lost */
+#define  I2C_SR_TRRDY		0x04 /* Transmitter/Receiver Ready */
+#define  I2C_SR_TROE		0x02 /* Transmitter/Receiver Overrun Error */
+#define  I2C_SR_HGC		0x01 /* Hardware General Call Received */
+#define I2C_RXDR		7 /* Receive Data, RO */
+#define I2C_IRQ			8 /* IRQ, RW */
+#define I2C_IRQEN		9 /* IRQ Enable, RW */
+#define  I2C_IRQ_ARBL		0x08 /* Arbitration Lost */
+#define  I2C_IRQ_TRRDY		0x04 /* Transmitter/Receiver Ready */
+#define  I2C_IRQ_TROE		0x02 /* Transmitter/Receiver Overrun Error */
+#define  I2C_IRQ_HGC		0x01 /* Hardware General Call Received */
+#define  I2C_IRQ_MASK		(I2C_IRQ_ARBL | I2C_IRQ_TRRDY | I2C_IRQ_TROE)
+
+static inline void machxo2_set(struct machxo2_i2c *i2c, unsigned int reg,
+			       u8 value)
+{
+	regmap_write(i2c->regmap, reg, value);
+}
+
+static inline u8 machxo2_get(struct machxo2_i2c *i2c, unsigned int reg)
+{
+	unsigned int val;
+
+	regmap_read(i2c->regmap, reg, &val);
+
+	return val;
+}
+
+static inline unsigned long
+machxo2_cycles_to_usecs(const struct machxo2_i2c *i2c, unsigned int cycles)
+{
+	return DIV_ROUND_UP(cycles * 1000, i2c->bus_khz);
+}
+
+/* Delay by a number of SCL cycles */
+static inline void machxo2_delay(const struct machxo2_i2c *i2c,
+				 unsigned int cycles)
+{
+	udelay(machxo2_cycles_to_usecs(i2c, cycles));
+}
+
+static enum machxo2_i2c_state
+machxo2_error(struct machxo2_i2c *i2c, int error)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	if (!i2c->error)
+		i2c->error = error;
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STO);
+
+	return STATE_DONE;
+}
+
+static void machxo2_reset_timer_wait(struct machxo2_i2c *i2c)
+{
+	/* 10 SCL cycles is a good starting point to wait for 1 byte to get transferred */
+	i2c->timer_wait = ns_to_ktime(machxo2_cycles_to_usecs(i2c, 10) * NSEC_PER_USEC);
+}
+
+static enum machxo2_i2c_state
+machxo2_end_of_message(struct machxo2_i2c *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	/* More messages to process? */
+	if (--i2c->nmsgs) {
+		i2c->msg++;
+		i2c->pos = 0;
+		return STATE_START;
+	}
+
+	/* End of transaction */
+
+	if (!(msg->flags & I2C_M_RD))
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STO);
+
+	return STATE_DONE;
+}
+
+static enum machxo2_i2c_state
+machxo2_write(struct machxo2_i2c *i2c, u8 stat)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	if (stat & I2C_SR_TRRDY) {
+		bool eom = (i2c->pos == msg->len);
+
+		if (eom) {
+			machxo2_delay(i2c, 1);
+			stat = machxo2_get(i2c, I2C_SR);
+		}
+
+		if ((i2c->pos > 0 || eom) && (stat & I2C_SR_RARC)) {
+			dev_dbg(&i2c->adap.dev, "No ACK at %d\n", i2c->pos);
+			return machxo2_error(i2c, -ENXIO);
+		}
+
+		if (eom)
+			return machxo2_end_of_message(i2c);
+
+		machxo2_set(i2c, I2C_TXDR, msg->buf[i2c->pos++]);
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_WR);
+
+		machxo2_reset_timer_wait(i2c);
+	}
+
+	return STATE_WRITE;
+}
+
+static enum machxo2_i2c_state
+machxo2_prepare_read(struct machxo2_i2c *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	/* Prepare to stop if we are waiting for the last byte */
+	if (i2c->pos == (msg->len - 1) && i2c->nmsgs == 1) {
+		if (msg->len == 1)
+			machxo2_delay(i2c, 2);
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_RD | I2C_CMDR_ACK | I2C_CMDR_STO);
+	} else if (i2c->pos == msg->len) {
+		return machxo2_end_of_message(i2c);
+	}
+
+	machxo2_reset_timer_wait(i2c);
+
+	return STATE_READ;
+}
+
+static enum machxo2_i2c_state
+machxo2_read(struct machxo2_i2c *i2c, u8 stat)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	if (stat & I2C_SR_TRRDY) {
+		msg->buf[i2c->pos++] = machxo2_get(i2c, I2C_RXDR);
+		return machxo2_prepare_read(i2c);
+	}
+
+	return STATE_READ;
+}
+
+static enum machxo2_i2c_state
+machxo2_read_wait_srw(struct machxo2_i2c *i2c, u8 stat)
+{
+	if (!(stat & I2C_SR_SRW))
+		return STATE_READ_WAIT_SRW;
+
+	machxo2_delay(i2c, 1);
+	stat = machxo2_get(i2c, I2C_SR);
+	if (stat & I2C_SR_RARC)
+		return machxo2_error(i2c, -ENXIO);
+
+	machxo2_set(i2c, I2C_CMDR, I2C_CMDR_RD);
+	return machxo2_prepare_read(i2c);
+}
+
+static enum machxo2_i2c_state
+machxo2_start(struct machxo2_i2c *i2c)
+{
+	struct i2c_msg *msg = i2c->msg;
+
+	if (!(msg->flags & I2C_M_NOSTART)) {
+		u8 addr = i2c_8bit_addr_from_msg(msg);
+
+		/*
+		 * If too much time passes between the previous write and
+		 * setting the new address, the address may become written
+		 * as a data byte instead of sending a restart first. Removing
+		 * the WR flag first avoids this issue.
+		 */
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STA);
+		machxo2_set(i2c, I2C_TXDR, addr);
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STA | I2C_CMDR_WR);
+	}
+
+	machxo2_reset_timer_wait(i2c);
+
+	return (msg->flags & I2C_M_RD) ? STATE_READ_WAIT_SRW : STATE_WRITE;
+}
+
+/* I2C state machine - returns the next state to transition to */
+static enum machxo2_i2c_state machxo2_process(struct machxo2_i2c *i2c)
+{
+	unsigned long flags;
+	int error;
+	u8 stat;
+
+	if (i2c->state == STATE_DONE)
+		return STATE_DONE;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	error = i2c->error;
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	if (error) {
+		/* Error was set from outside of machxo2_process (timeout) */
+		machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STO);
+		return STATE_DONE;
+	}
+
+	stat = machxo2_get(i2c, I2C_SR);
+
+	/* Check for errors (arbitration lost / overrun) */
+	if (stat & (I2C_SR_ARBL | I2C_SR_TROE))
+		return machxo2_error(i2c, -EIO);
+
+	switch (i2c->state) {
+	case STATE_DONE:
+		/* Handled above - should be unreachable */
+		break;
+
+	case STATE_START:
+		return machxo2_start(i2c);
+
+	case STATE_WRITE:
+		return machxo2_write(i2c, stat);
+
+	case STATE_READ_WAIT_SRW:
+		return machxo2_read_wait_srw(i2c, stat);
+
+	case STATE_READ:
+		return machxo2_read(i2c, stat);
+	}
+
+	/* Should be unreachable */
+	WARN_ON(1);
+	return machxo2_error(i2c, -EINVAL);
+}
+
+static enum hrtimer_restart machxo2_restart_timer(struct machxo2_i2c *i2c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	if (!hrtimer_is_queued(&i2c->timer))
+		hrtimer_forward_now(&i2c->timer, i2c->timer_wait);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	/* Exponential backoff for timer */
+	i2c->timer_wait *= 2;
+
+	return HRTIMER_RESTART;
+}
+
+static enum hrtimer_restart machxo2_handle(struct hrtimer *timer)
+{
+	struct machxo2_i2c *i2c = container_of(timer, struct machxo2_i2c, timer);
+
+	/*
+	 * If the new state is STATE_START, we're at a restart and want to
+	 * run process again right away.
+	 */
+	do {
+		i2c->state = machxo2_process(i2c);
+	} while (i2c->state == STATE_START);
+
+	switch (i2c->state) {
+	case STATE_DONE:
+		wake_up(&i2c->wait);
+		return HRTIMER_NORESTART;
+
+	case STATE_READ_WAIT_SRW:
+		/* There is no IRQ for the SRW flag, so we always use the timer here */
+		return machxo2_restart_timer(i2c);
+
+	case STATE_WRITE:
+	case STATE_READ:
+		/* If we have an IRQ, it is used to drive the state machine */
+		if (i2c->irq > 0)
+			return HRTIMER_NORESTART;
+
+		return machxo2_restart_timer(i2c);
+
+	default:
+		/* Unreachable */
+		WARN_ON(1);
+		return HRTIMER_NORESTART;
+	}
+}
+
+static irqreturn_t machxo2_isr(int irq, void *dev_id)
+{
+	struct machxo2_i2c *i2c = dev_id;
+	u8 irq_stat = machxo2_get(i2c, I2C_IRQ);
+
+	if (!(irq_stat & I2C_IRQ_MASK))
+		return IRQ_NONE;
+
+	/*
+	 * Due to a race condition in the I2C controller, no edge on the IRQ
+	 * line may be generated if an event comes in right at the moment when
+	 * the IRQs are cleared. Loop to ensure that IRQs are actually cleared.
+	 */
+	do {
+		machxo2_set(i2c, I2C_IRQ, I2C_IRQ_MASK);
+		irq_stat = machxo2_get(i2c, I2C_IRQ);
+	} while (irq_stat & I2C_IRQ_MASK);
+
+	spin_lock(&i2c->lock);
+	hrtimer_start(&i2c->timer, 0, HRTIMER_MODE_REL);
+	spin_unlock(&i2c->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void machxo2_recover(struct machxo2_i2c *i2c)
+{
+	/*
+	 * This is happening somewhat often after reads, in particular at
+	 * 100kHz. Further investigation is necessary, but for now the recovery
+	 * sequence keeps the bus usable.
+	 */
+	dev_dbg(&i2c->adap.dev, "stuck transaction, recovering\n");
+
+	machxo2_set(i2c, I2C_CR, 0);
+	machxo2_set(i2c, I2C_CR, I2C_CR_I2CEN);
+	machxo2_delay(i2c, 1);
+
+	machxo2_set(i2c, I2C_CMDR, 0);
+	machxo2_set(i2c, I2C_TXDR, 0);
+	machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STA | I2C_CMDR_WR);
+	machxo2_delay(i2c, 2);
+	machxo2_set(i2c, I2C_CMDR, I2C_CMDR_STO);
+	machxo2_delay(i2c, 10);
+
+	machxo2_set(i2c, I2C_CR, 0);
+	machxo2_set(i2c, I2C_CR, I2C_CR_I2CEN);
+	machxo2_delay(i2c, 1);
+}
+
+static void machxo2_wait_not_busy(struct machxo2_i2c *i2c, unsigned long sleep,
+				  u64 timeout)
+{
+	u8 status;
+
+	read_poll_timeout(machxo2_get, status, (status & I2C_SR_BUSY) == 0,
+			  sleep, timeout, false, i2c, I2C_SR);
+
+	if (status & (I2C_SR_BUSY | I2C_SR_TROE))
+		machxo2_recover(i2c);
+}
+
+static int machxo2_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct machxo2_i2c *i2c = i2c_get_adapdata(adap);
+
+	machxo2_wait_not_busy(i2c, 1000, jiffies_to_usecs(adap->timeout) + 1);
+
+	dev_dbg(&adap->dev, "new msg: addr %02x, flags %x, nmsgs %d, len %d\n",
+		msgs->addr, msgs->flags, num, msgs[0].len);
+
+	i2c->msg = msgs;
+	i2c->pos = 0;
+	i2c->nmsgs = num;
+	i2c->error = 0;
+	i2c->state = STATE_START;
+	/* Ensure that the hrtimer sees the state change */
+	smp_wmb();
+
+	spin_lock_irq(&i2c->lock);
+	hrtimer_start(&i2c->timer, 0, HRTIMER_MODE_REL);
+	spin_unlock_irq(&i2c->lock);
+
+	if (!wait_event_timeout(i2c->wait, i2c->state == STATE_DONE,
+				adap->timeout)) {
+		spin_lock_irq(&i2c->lock);
+		i2c->error = -ETIMEDOUT;
+		/* Run handler once more to send STOP */
+		hrtimer_start(&i2c->timer, 0, HRTIMER_MODE_REL);
+		spin_unlock_irq(&i2c->lock);
+
+		if (!wait_event_timeout(i2c->wait, i2c->state == STATE_DONE,
+					usecs_to_jiffies(MACHXO2_I2C_POST_TIMEOUT_US))) {
+
+			if (i2c->irq > 0)
+				disable_irq(i2c->irq);
+			hrtimer_cancel(&i2c->timer);
+			i2c->state = STATE_DONE;
+			/*
+			 * Ensure that the hrtimer sees the state change (if
+			 * started again by pending IRQ)
+			 */
+			smp_wmb();
+			if (i2c->irq > 0)
+				enable_irq(i2c->irq);
+		}
+	}
+
+	machxo2_wait_not_busy(i2c, 100, MACHXO2_I2C_POST_TIMEOUT_US);
+
+	if (i2c->error) {
+		dev_dbg(&adap->dev, "end msg: error %d, nmsgs %d, pos %d\n",
+			i2c->error, i2c->nmsgs, i2c->pos);
+		return i2c->error;
+	}
+
+	return num;
+}
+
+static int machxo2_init(struct machxo2_i2c *i2c)
+{
+	unsigned int prescale;
+
+	/* Make sure the device is disabled */
+	machxo2_set(i2c, I2C_CR, 0);
+
+	/* I2C bus frequencies officially supported by MachXO2 are 400, 100 and 50 kHz */
+	if (i2c->bus_khz >= 400)
+		i2c->bus_khz = 400;
+	else if (i2c->bus_khz >= 100)
+		i2c->bus_khz = 100;
+	else
+		i2c->bus_khz = 50;
+
+	prescale = DIV_ROUND_UP(i2c->clock_khz, 4 * i2c->bus_khz);
+	if (prescale > 0x3ff) {
+		dev_err(&i2c->adap.dev, "unsupported prescale: %d\n",
+			prescale);
+		return -EINVAL;
+	}
+
+	machxo2_set(i2c, I2C_BR0, prescale & 0xff);
+	machxo2_set(i2c, I2C_BR1, prescale >> 8);
+
+	machxo2_set(i2c, I2C_IRQEN, 0);
+	machxo2_set(i2c, I2C_CR, I2C_CR_I2CEN);
+
+	return 0;
+}
+
+static u32 machxo2_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_NOSTART;
+}
+
+static const struct i2c_algorithm machxo2_algorithm = {
+	.master_xfer = machxo2_xfer,
+	.functionality = machxo2_func,
+};
+
+static const struct regmap_config machxo2_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	/*
+	 * No locking is necessary for ioport access, and we don't have a
+	 * regcache (caching doesn't make sense for this driver, as all
+	 * registers ever read are volatile)
+	 */
+	.disable_locking = true,
+	.io_port = true,
+	.max_register = 9,
+};
+
+static int machxo2_i2c_probe(struct platform_device *pdev)
+{
+	struct machxo2_i2c_platform_data *pdata;
+	struct machxo2_i2c *i2c;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata || !pdata->clock_khz)
+		return -EINVAL;
+
+	i2c->clock_khz = pdata->clock_khz;
+	i2c->bus_khz = pdata->bus_khz;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	if (!devm_request_region(&pdev->dev, res->start, resource_size(res),
+				 pdev->name)) {
+		dev_err(&pdev->dev, "Can't get I/O resource.\n");
+		return -EBUSY;
+	}
+
+	regs = devm_ioport_map(&pdev->dev, res->start, resource_size(res));
+	if (!regs) {
+		dev_err(&pdev->dev, "Can't map I/O resource.\n");
+		return -EBUSY;
+	}
+
+	i2c->regmap = devm_regmap_init_mmio(&pdev->dev, regs, &machxo2_regmap_config);
+	if (IS_ERR(i2c->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->regmap),
+				     "Unable to initialize register map\n");
+
+	i2c->irq = platform_get_irq_optional(pdev, 0);
+	if (i2c->irq < 0 && i2c->irq != -ENXIO)
+		return i2c->irq;
+
+	ret = machxo2_init(i2c);
+	if (ret)
+		return ret;
+
+	init_waitqueue_head(&i2c->wait);
+	spin_lock_init(&i2c->lock);
+	hrtimer_setup(&i2c->timer, machxo2_handle, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	if (i2c->irq > 0) {
+		ret = devm_request_irq(&pdev->dev, i2c->irq, machxo2_isr, 0,
+				       pdev->name, i2c);
+		if (ret) {
+			dev_err(&pdev->dev, "Cannot claim IRQ\n");
+			machxo2_set(i2c, I2C_CR, 0);
+			return ret;
+		}
+
+		machxo2_set(i2c, I2C_IRQEN, I2C_IRQ_MASK);
+
+		dev_info(&pdev->dev,
+			 "Using IRQ %d, bus speed %dKHz, clock %dKHz.\n",
+			 i2c->irq, i2c->bus_khz, i2c->clock_khz);
+	} else {
+		dev_info(&pdev->dev,
+			 "Running in polling mode, bus speed %dKHz, clock %dKHz.\n",
+			 i2c->bus_khz, i2c->clock_khz);
+	}
+
+	platform_set_drvdata(pdev, i2c);
+
+	strscpy(i2c->adap.name, "i2c-machxo2", sizeof(i2c->adap.name));
+	i2c->adap.algo = &machxo2_algorithm;
+	i2c->adap.dev.parent = &pdev->dev;
+	i2c->adap.nr = pdev->id;
+	i2c->adap.owner = THIS_MODULE;
+	i2c_set_adapdata(&i2c->adap, i2c);
+
+	ret = i2c_add_adapter(&i2c->adap);
+	if (ret) {
+		machxo2_set(i2c, I2C_CR, 0);
+		machxo2_set(i2c, I2C_IRQEN, 0);
+
+		if (i2c->irq > 0)
+			disable_irq(i2c->irq);
+		hrtimer_cancel(&i2c->timer);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static void machxo2_i2c_remove(struct platform_device *pdev)
+{
+	struct machxo2_i2c *i2c = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(&i2c->adap);
+
+	/* Disable I2C logic */
+	machxo2_set(i2c, I2C_CR, 0);
+	machxo2_set(i2c, I2C_IRQEN, 0);
+
+	if (i2c->irq > 0)
+		disable_irq(i2c->irq);
+	hrtimer_cancel(&i2c->timer);
+}
+
+static int machxo2_i2c_suspend(struct device *dev)
+{
+	struct machxo2_i2c *i2c = dev_get_drvdata(dev);
+
+	machxo2_set(i2c, I2C_CR, 0);
+
+	return 0;
+}
+
+static int machxo2_i2c_resume(struct device *dev)
+{
+	struct machxo2_i2c *i2c = dev_get_drvdata(dev);
+
+	machxo2_set(i2c, I2C_CR, I2C_CR_I2CEN);
+
+	return 0;
+}
+
+static DEFINE_NOIRQ_DEV_PM_OPS(machxo2_i2c_pm,
+			       machxo2_i2c_suspend, machxo2_i2c_resume);
+
+static const struct platform_device_id machxo2_i2c_driver_ids[] = {
+	{ .name = "i2c-machxo2", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, machxo2_i2c_driver_ids);
+
+static struct platform_driver machxo2_i2c_driver = {
+	.probe = machxo2_i2c_probe,
+	.remove = machxo2_i2c_remove,
+	.id_table = machxo2_i2c_driver_ids,
+	.driver  = {
+		.name = "i2c-machxo2",
+		.pm = pm_sleep_ptr(&machxo2_i2c_pm),
+	},
+};
+
+module_platform_driver(machxo2_i2c_driver);
+
+MODULE_AUTHOR("TQ-Systems GmbH <linux@ew.tq-group.com>");
+MODULE_DESCRIPTION("Lattice MachXO2 I2C bus driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/i2c-machxo2.h b/include/linux/platform_data/i2c-machxo2.h
new file mode 100644
index 0000000000000..5cbfbe9d81b46
--- /dev/null
+++ b/include/linux/platform_data/i2c-machxo2.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * i2c-machxo2.h: Platform data for Lattice MachXO2 I2C controller
+ *
+ * Copyright (c) 2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Author: Matthias Schiffer
+ */
+
+#ifndef _LINUX_I2C_MACHXO2_H
+#define _LINUX_I2C_MACHXO2_H
+
+struct machxo2_i2c_platform_data {
+	u32 clock_khz; /* input clock in kHz */
+	u32 bus_khz; /* I2C bus clock in kHz */
+};
+
+#endif /* _LINUX_I2C_MACHXO2_H */
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


