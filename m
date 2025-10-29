Return-Path: <linux-kernel+bounces-875592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F8C1962F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A40402C26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BBC328611;
	Wed, 29 Oct 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYT2eAHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAB3126C7;
	Wed, 29 Oct 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730546; cv=none; b=T/YZdQ9YehhWZDaMKP7gqvMK5cO5an0UULkMO/b9OCnMSB3jgXxVULyn4RAKU9+qCgT2c97zA35dmP6Ke6YaXJwzsn4tJNvXtOpBxkTzANXHx7UYEcSz1QUXzdlmaWP+28RMrr5VTv3wuGxRcw69dcqMAJ2Q1Mh6zTSXdR1vd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730546; c=relaxed/simple;
	bh=+sv/ym/3oMt2t6wvCh16Q69GZeefPvHRR5JklW56Y3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/6zciTE72kBHqU7+wIcs8FjnIoAdK0vRoi4IgOAW/4YXWQkN2qVY4L02DViLR3ovzEz7sADgSmcmLalN6HJRBwV4Mks29i49bJxJbgK/mXQO+YBBp1zHHqV+yKqq4GBE6Pj1sUkDoVB21DOYT0G9QXQsliaAYMBBsQ43IANnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYT2eAHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FEEC4CEF7;
	Wed, 29 Oct 2025 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761730545;
	bh=+sv/ym/3oMt2t6wvCh16Q69GZeefPvHRR5JklW56Y3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=VYT2eAHz5OdTrUXOC8mofrl7yrgw9knGDcGpU+FGL0ckXGu5P6nih7bKyjP01ANPa
	 DObb8eBiBJnKSmCUudf0apXoErsbdFszYgMt6clFTuIRkF+M2LQ863SbZ9ILd2oBb4
	 MQqvEisQ3f9MaMwll6+TKyGRIeT69TJCgyqVPPTDK8Xd0EjU2WSNb/XwbD+8Y9zr+N
	 u26DifRsKxitSV6HBrx+cWk3fSWILjnWiDc8B2JhoxJIXAjyfSRWPp5F26TF3tcxed
	 h0NlBg67HgTecPZ5XLhzb57JKIOf9kLIfuQv9LEO+5Sgs5dI3iVbk7butKH259r5fJ
	 RsXpK8xUEa1xA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE2at-000000007d6-36tu;
	Wed, 29 Oct 2025 10:35:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] staging: most: remove broken i2c driver
Date: Wed, 29 Oct 2025 10:34:42 +0100
Message-ID: <20251029093442.29256-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MOST I2C driver has been completely broken for five years without
anyone noticing so remove the driver from staging.

Specifically, commit 723de0f9171e ("staging: most: remove device from
interface structure") started requiring drivers to set the interface
device pointer before registration, but the I2C driver was never updated
which results in a NULL pointer dereference if anyone ever tries to
probe it.

Fixes: 723de0f9171e ("staging: most: remove device from interface structure")
Cc: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/most/Kconfig      |   2 -
 drivers/staging/most/Makefile     |   1 -
 drivers/staging/most/i2c/Kconfig  |  13 --
 drivers/staging/most/i2c/Makefile |   4 -
 drivers/staging/most/i2c/i2c.c    | 374 ------------------------------
 5 files changed, 394 deletions(-)
 delete mode 100644 drivers/staging/most/i2c/Kconfig
 delete mode 100644 drivers/staging/most/i2c/Makefile
 delete mode 100644 drivers/staging/most/i2c/i2c.c

diff --git a/drivers/staging/most/Kconfig b/drivers/staging/most/Kconfig
index 6f420cbcdcff..e89658df6f12 100644
--- a/drivers/staging/most/Kconfig
+++ b/drivers/staging/most/Kconfig
@@ -24,6 +24,4 @@ source "drivers/staging/most/video/Kconfig"
 
 source "drivers/staging/most/dim2/Kconfig"
 
-source "drivers/staging/most/i2c/Kconfig"
-
 endif
diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
index 8b3fc5a7af51..e45084df7803 100644
--- a/drivers/staging/most/Makefile
+++ b/drivers/staging/most/Makefile
@@ -3,4 +3,3 @@
 obj-$(CONFIG_MOST_NET)	+= net/
 obj-$(CONFIG_MOST_VIDEO)	+= video/
 obj-$(CONFIG_MOST_DIM2)	+= dim2/
-obj-$(CONFIG_MOST_I2C)	+= i2c/
diff --git a/drivers/staging/most/i2c/Kconfig b/drivers/staging/most/i2c/Kconfig
deleted file mode 100644
index ff64283cbad1..000000000000
--- a/drivers/staging/most/i2c/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# MOST I2C configuration
-#
-
-config MOST_I2C
-	tristate "I2C"
-	depends on I2C
-	help
-	  Say Y here if you want to connect via I2C to network transceiver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called most_i2c.
diff --git a/drivers/staging/most/i2c/Makefile b/drivers/staging/most/i2c/Makefile
deleted file mode 100644
index 71099dd0f85b..000000000000
--- a/drivers/staging/most/i2c/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_MOST_I2C) += most_i2c.o
-
-most_i2c-objs := i2c.o
diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
deleted file mode 100644
index 184b2dd11fc3..000000000000
--- a/drivers/staging/most/i2c/i2c.c
+++ /dev/null
@@ -1,374 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * i2c.c - Hardware Dependent Module for I2C Interface
- *
- * Copyright (C) 2013-2015, Microchip Technology Germany II GmbH & Co. KG
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/most.h>
-
-enum { CH_RX, CH_TX, NUM_CHANNELS };
-
-#define MAX_BUFFERS_CONTROL 32
-#define MAX_BUF_SIZE_CONTROL 256
-
-/**
- * list_first_mbo - get the first mbo from a list
- * @ptr:	the list head to take the mbo from.
- */
-#define list_first_mbo(ptr) \
-	list_first_entry(ptr, struct mbo, list)
-
-static unsigned int polling_rate;
-module_param(polling_rate, uint, 0644);
-MODULE_PARM_DESC(polling_rate, "Polling rate [Hz]. Default = 0 (use IRQ)");
-
-struct hdm_i2c {
-	struct most_interface most_iface;
-	struct most_channel_capability capabilities[NUM_CHANNELS];
-	struct i2c_client *client;
-	struct rx {
-		struct delayed_work dwork;
-		struct list_head list;
-		bool int_disabled;
-		unsigned int delay;
-	} rx;
-	char name[64];
-};
-
-static inline struct hdm_i2c *to_hdm(struct most_interface *iface)
-{
-	return container_of(iface, struct hdm_i2c, most_iface);
-}
-
-static irqreturn_t most_irq_handler(int, void *);
-static void pending_rx_work(struct work_struct *);
-
-/**
- * configure_channel - called from MOST core to configure a channel
- * @most_iface: interface the channel belongs to
- * @ch_idx: channel to be configured
- * @channel_config: structure that holds the configuration information
- *
- * Return 0 on success, negative on failure.
- *
- * Receives configuration information from MOST core and initialize the
- * corresponding channel.
- */
-static int configure_channel(struct most_interface *most_iface,
-			     int ch_idx,
-			     struct most_channel_config *channel_config)
-{
-	int ret;
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	unsigned int delay, pr;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (channel_config->data_type != MOST_CH_CONTROL) {
-		pr_err("bad data type for channel %d\n", ch_idx);
-		return -EPERM;
-	}
-
-	if (channel_config->direction != dev->capabilities[ch_idx].direction) {
-		pr_err("bad direction for channel %d\n", ch_idx);
-		return -EPERM;
-	}
-
-	if (channel_config->direction == MOST_CH_RX) {
-		if (!polling_rate) {
-			if (dev->client->irq <= 0) {
-				pr_err("bad irq: %d\n", dev->client->irq);
-				return -ENOENT;
-			}
-			dev->rx.int_disabled = false;
-			ret = request_irq(dev->client->irq, most_irq_handler, 0,
-					  dev->client->name, dev);
-			if (ret) {
-				pr_err("request_irq(%d) failed: %d\n",
-				       dev->client->irq, ret);
-				return ret;
-			}
-		} else {
-			delay = msecs_to_jiffies(MSEC_PER_SEC / polling_rate);
-			dev->rx.delay = delay ? delay : 1;
-			pr = MSEC_PER_SEC / jiffies_to_msecs(dev->rx.delay);
-			pr_info("polling rate is %u Hz\n", pr);
-		}
-	}
-
-	return 0;
-}
-
-/**
- * enqueue - called from MOST core to enqueue a buffer for data transfer
- * @most_iface: intended interface
- * @ch_idx: ID of the channel the buffer is intended for
- * @mbo: pointer to the buffer object
- *
- * Return 0 on success, negative on failure.
- *
- * Transmit the data over I2C if it is a "write" request or push the buffer into
- * list if it is an "read" request
- */
-static int enqueue(struct most_interface *most_iface,
-		   int ch_idx, struct mbo *mbo)
-{
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	int ret;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (ch_idx == CH_RX) {
-		/* RX */
-		if (!polling_rate)
-			disable_irq(dev->client->irq);
-		cancel_delayed_work_sync(&dev->rx.dwork);
-		list_add_tail(&mbo->list, &dev->rx.list);
-		if (dev->rx.int_disabled || polling_rate)
-			pending_rx_work(&dev->rx.dwork.work);
-		if (!polling_rate)
-			enable_irq(dev->client->irq);
-	} else {
-		/* TX */
-		ret = i2c_master_send(dev->client, mbo->virt_address,
-				      mbo->buffer_length);
-		if (ret <= 0) {
-			mbo->processed_length = 0;
-			mbo->status = MBO_E_INVAL;
-		} else {
-			mbo->processed_length = mbo->buffer_length;
-			mbo->status = MBO_SUCCESS;
-		}
-		mbo->complete(mbo);
-	}
-
-	return 0;
-}
-
-/**
- * poison_channel - called from MOST core to poison buffers of a channel
- * @most_iface: pointer to the interface the channel to be poisoned belongs to
- * @ch_idx: corresponding channel ID
- *
- * Return 0 on success, negative on failure.
- *
- * If channel direction is RX, complete the buffers in list with
- * status MBO_E_CLOSE
- */
-static int poison_channel(struct most_interface *most_iface,
-			  int ch_idx)
-{
-	struct hdm_i2c *dev = to_hdm(most_iface);
-	struct mbo *mbo;
-
-	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
-
-	if (ch_idx == CH_RX) {
-		if (!polling_rate)
-			free_irq(dev->client->irq, dev);
-		cancel_delayed_work_sync(&dev->rx.dwork);
-
-		while (!list_empty(&dev->rx.list)) {
-			mbo = list_first_mbo(&dev->rx.list);
-			list_del(&mbo->list);
-
-			mbo->processed_length = 0;
-			mbo->status = MBO_E_CLOSE;
-			mbo->complete(mbo);
-		}
-	}
-
-	return 0;
-}
-
-static void do_rx_work(struct hdm_i2c *dev)
-{
-	struct mbo *mbo;
-	unsigned char msg[MAX_BUF_SIZE_CONTROL];
-	int ret;
-	u16 pml, data_size;
-
-	/* Read PML (2 bytes) */
-	ret = i2c_master_recv(dev->client, msg, 2);
-	if (ret <= 0) {
-		pr_err("Failed to receive PML\n");
-		return;
-	}
-
-	pml = (msg[0] << 8) | msg[1];
-	if (!pml)
-		return;
-
-	data_size = pml + 2;
-
-	/* Read the whole message, including PML */
-	ret = i2c_master_recv(dev->client, msg, data_size);
-	if (ret <= 0) {
-		pr_err("Failed to receive a Port Message\n");
-		return;
-	}
-
-	mbo = list_first_mbo(&dev->rx.list);
-	list_del(&mbo->list);
-
-	mbo->processed_length = min(data_size, mbo->buffer_length);
-	memcpy(mbo->virt_address, msg, mbo->processed_length);
-	mbo->status = MBO_SUCCESS;
-	mbo->complete(mbo);
-}
-
-/**
- * pending_rx_work - Read pending messages through I2C
- * @work: definition of this work item
- *
- * Invoked by the Interrupt Service Routine, most_irq_handler()
- */
-static void pending_rx_work(struct work_struct *work)
-{
-	struct hdm_i2c *dev = container_of(work, struct hdm_i2c, rx.dwork.work);
-
-	if (list_empty(&dev->rx.list))
-		return;
-
-	do_rx_work(dev);
-
-	if (polling_rate) {
-		schedule_delayed_work(&dev->rx.dwork, dev->rx.delay);
-	} else {
-		dev->rx.int_disabled = false;
-		enable_irq(dev->client->irq);
-	}
-}
-
-/*
- * most_irq_handler - Interrupt Service Routine
- * @irq: irq number
- * @_dev: private data
- *
- * Schedules a delayed work
- *
- * By default the interrupt line behavior is Active Low. Once an interrupt is
- * generated by the device, until driver clears the interrupt (by reading
- * the PMP message), device keeps the interrupt line in low state. Since i2c
- * read is done in work queue, the interrupt line must be disabled temporarily
- * to avoid ISR being called repeatedly. Re-enable the interrupt in workqueue,
- * after reading the message.
- *
- * Note: If we use the interrupt line in Falling edge mode, there is a
- * possibility to miss interrupts when ISR is getting executed.
- *
- */
-static irqreturn_t most_irq_handler(int irq, void *_dev)
-{
-	struct hdm_i2c *dev = _dev;
-
-	disable_irq_nosync(irq);
-	dev->rx.int_disabled = true;
-	schedule_delayed_work(&dev->rx.dwork, 0);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * i2c_probe - i2c probe handler
- * @client: i2c client device structure
- * @id: i2c client device id
- *
- * Return 0 on success, negative on failure.
- *
- * Register the i2c client device as a MOST interface
- */
-static int i2c_probe(struct i2c_client *client)
-{
-	struct hdm_i2c *dev;
-	int ret, i;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	/* ID format: i2c-<bus>-<address> */
-	snprintf(dev->name, sizeof(dev->name), "i2c-%d-%04x",
-		 client->adapter->nr, client->addr);
-
-	for (i = 0; i < NUM_CHANNELS; i++) {
-		dev->capabilities[i].data_type = MOST_CH_CONTROL;
-		dev->capabilities[i].num_buffers_packet = MAX_BUFFERS_CONTROL;
-		dev->capabilities[i].buffer_size_packet = MAX_BUF_SIZE_CONTROL;
-	}
-	dev->capabilities[CH_RX].direction = MOST_CH_RX;
-	dev->capabilities[CH_RX].name_suffix = "rx";
-	dev->capabilities[CH_TX].direction = MOST_CH_TX;
-	dev->capabilities[CH_TX].name_suffix = "tx";
-
-	dev->most_iface.interface = ITYPE_I2C;
-	dev->most_iface.description = dev->name;
-	dev->most_iface.num_channels = NUM_CHANNELS;
-	dev->most_iface.channel_vector = dev->capabilities;
-	dev->most_iface.configure = configure_channel;
-	dev->most_iface.enqueue = enqueue;
-	dev->most_iface.poison_channel = poison_channel;
-
-	INIT_LIST_HEAD(&dev->rx.list);
-
-	INIT_DELAYED_WORK(&dev->rx.dwork, pending_rx_work);
-
-	dev->client = client;
-	i2c_set_clientdata(client, dev);
-
-	ret = most_register_interface(&dev->most_iface);
-	if (ret) {
-		pr_err("Failed to register i2c as a MOST interface\n");
-		kfree(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-/*
- * i2c_remove - i2c remove handler
- * @client: i2c client device structure
- *
- * Return 0 on success.
- *
- * Unregister the i2c client device as a MOST interface
- */
-static void i2c_remove(struct i2c_client *client)
-{
-	struct hdm_i2c *dev = i2c_get_clientdata(client);
-
-	most_deregister_interface(&dev->most_iface);
-	kfree(dev);
-}
-
-static const struct i2c_device_id i2c_id[] = {
-	{ "most_i2c" },
-	{ } /* Terminating entry */
-};
-
-MODULE_DEVICE_TABLE(i2c, i2c_id);
-
-static struct i2c_driver i2c_driver = {
-	.driver = {
-		.name = "hdm_i2c",
-	},
-	.probe = i2c_probe,
-	.remove = i2c_remove,
-	.id_table = i2c_id,
-};
-
-module_i2c_driver(i2c_driver);
-
-MODULE_AUTHOR("Andrey Shvetsov <andrey.shvetsov@k2l.de>");
-MODULE_DESCRIPTION("I2C Hardware Dependent Module");
-MODULE_LICENSE("GPL");
-- 
2.51.0


