Return-Path: <linux-kernel+bounces-768392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB6B260A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E555A57BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B527144D;
	Thu, 14 Aug 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN23y8pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A512EF644;
	Thu, 14 Aug 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162787; cv=none; b=ZfJcmlsr3/31hnQmtk4wyUiAVEtYUOz/EflTnOztDtLMtTPMIGQXTyDYllZJzraddwF9Z4M7qY+NlkLct4MjfsUaRFiT0NULToTATDRO/Pg4BcqdGb6Y67UHiQBwennv9cHf9iuCCrkOvZwcARMHgxmyl5KmMPrizQkPKDWSeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162787; c=relaxed/simple;
	bh=TBXf9TlITbl7kntH3GIMV20rolg0uvfkE9lfCdNPb+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqLIUbsmW+987Gsy6BYAKbpJa9q4QTDNS4OEiDigTxZG6uDfYtSkrBv6LZAfv303J9lwBugSX3G22MwKATexp/ztHgufRqQD0mcW3Z5Wgk9oyZn0/r+/brYpvGv+xazUg/CYS7w5IKPsvmiR/dYdD2V4863OJZhmqAvfHYLwwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN23y8pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B21CC4CEFA;
	Thu, 14 Aug 2025 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162786;
	bh=TBXf9TlITbl7kntH3GIMV20rolg0uvfkE9lfCdNPb+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN23y8pbqqlmt6tFYwlOJ1z1eGvrjZE/jLEjPRXQau6t4UzWNeTwseKrPdi72GaTX
	 9fBABkCYry94P3y5AQzqeFT+qDeooYGretDmUClN8UxQWfUvl0Ro805EM8EVMmQDwO
	 2jP9MH/QGK2bSdItJjtJbZjKvWIDnv4spp41+fUGFILXSYpagZMUt5yAvjbPrY1h3Z
	 GlJa+IEzPPy5ekgvUYtzbBkCF8DkHvCPymkP0QUSKk091+4EplYAlQFati/EAIr9Ag
	 1Are5J8+c22UXAZO/rR5WJb42ps4Z6o/tyKW6EIxQQxFtxYulxAdYtBdd7zMbQ1rPA
	 L1MKgI6WSDJ+w==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	dawidn@google.com,
	chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/chrome: cros_ec_chardev: Consume cros_ec_device via ref_proxy
Date: Thu, 14 Aug 2025 09:10:20 +0000
Message-ID: <20250814091020.1302888-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814091020.1302888-1-tzungbi@kernel.org>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec_chardev driver provides a character device interface to the
ChromeOS EC.  A file handle to this device can remain open in userspace
even if the underlying EC device is removed.

This creates a classic use-after-free vulnerability.  Any file operation
(ioctl, release, etc.) on the open handle after the EC device has gone
would access a stale pointer, leading to a system crash.

To prevent this, leverage the ref_proxy library and convert
cros_ec_chardev to a resource consumer of cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_chardev.c | 125 +++++++++++++++-------
 1 file changed, 85 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..f4aa70c8b6d4 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -22,6 +22,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
+#include <linux/ref_proxy.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -32,7 +33,7 @@
 #define CROS_MAX_EVENT_LEN	PAGE_SIZE
 
 struct chardev_priv {
-	struct cros_ec_device *ec_dev;
+	struct ref_proxy *ec_dev_proxy;
 	struct notifier_block notifier;
 	wait_queue_head_t wait_event;
 	unsigned long event_mask;
@@ -55,6 +56,7 @@ static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
 	};
 	struct ec_response_get_version *resp;
 	struct cros_ec_command *msg;
+	struct cros_ec_device __rcu *ec_dev;
 	int ret;
 
 	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
@@ -64,12 +66,19 @@ static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
 	msg->command = EC_CMD_GET_VERSION + priv->cmd_offset;
 	msg->insize = sizeof(*resp);
 
-	ret = cros_ec_cmd_xfer_status(priv->ec_dev, msg);
-	if (ret < 0) {
-		snprintf(str, maxlen,
-			 "Unknown EC version, returned error: %d\n",
-			 msg->result);
-		goto exit;
+	REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
+		if (!ec_dev) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+		if (ret < 0) {
+			snprintf(str, maxlen,
+				 "Unknown EC version, returned error: %d\n",
+				 msg->result);
+			goto exit;
+		}
 	}
 
 	resp = (struct ec_response_get_version *)msg->data;
@@ -92,22 +101,30 @@ static int cros_ec_chardev_mkbp_event(struct notifier_block *nb,
 {
 	struct chardev_priv *priv = container_of(nb, struct chardev_priv,
 						 notifier);
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device __rcu *ec_dev;
 	struct ec_event *event;
-	unsigned long event_bit = 1 << ec_dev->event_data.event_type;
-	int total_size = sizeof(*event) + ec_dev->event_size;
+	unsigned long event_bit;
+	int total_size;
+
+	REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
+		if (!ec_dev)
+			return NOTIFY_DONE;
 
-	if (!(event_bit & priv->event_mask) ||
-	    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
-		return NOTIFY_DONE;
+		event_bit = 1 << ec_dev->event_data.event_type;
+		total_size = sizeof(*event) + ec_dev->event_size;
 
-	event = kzalloc(total_size, GFP_KERNEL);
-	if (!event)
-		return NOTIFY_DONE;
+		if (!(event_bit & priv->event_mask) ||
+		    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
+			return NOTIFY_DONE;
 
-	event->size = ec_dev->event_size;
-	event->event_type = ec_dev->event_data.event_type;
-	memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
+		event = kzalloc(total_size, GFP_KERNEL);
+		if (!event)
+			return NOTIFY_DONE;
+
+		event->size = ec_dev->event_size;
+		event->event_type = ec_dev->event_data.event_type;
+		memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
+	}
 
 	spin_lock(&priv->wait_event.lock);
 	list_add_tail(&event->node, &priv->events);
@@ -166,7 +183,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->ec_dev = ec_dev;
+	priv->ec_dev_proxy = ref_proxy_alloc(ec_dev->ref_proxy_provider);
+	if (!priv->ec_dev_proxy) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	priv->cmd_offset = ec->cmd_offset;
 	filp->private_data = priv;
 	INIT_LIST_HEAD(&priv->events);
@@ -178,9 +200,14 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 					       &priv->notifier);
 	if (ret) {
 		dev_err(ec_dev->dev, "failed to register event notifier\n");
-		kfree(priv);
+		goto err;
 	}
 
+	return 0;
+err:
+	if (priv->ec_dev_proxy)
+		ref_proxy_free(priv->ec_dev_proxy);
+	kfree(priv);
 	return ret;
 }
 
@@ -251,11 +278,16 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 static int cros_ec_chardev_release(struct inode *inode, struct file *filp)
 {
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device __rcu *ec_dev;
 	struct ec_event *event, *e;
 
-	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
-					   &priv->notifier);
+	REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
+		if (ec_dev)
+			blocking_notifier_chain_unregister(
+					&ec_dev->event_notifier,
+					&priv->notifier);
+	}
+	ref_proxy_free(priv->ec_dev_proxy);
 
 	list_for_each_entry_safe(event, e, &priv->events, node) {
 		list_del(&event->node);
@@ -273,6 +305,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 {
 	struct cros_ec_command *s_cmd;
 	struct cros_ec_command u_cmd;
+	struct cros_ec_device __rcu *ec_dev;
 	long ret;
 
 	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
@@ -299,10 +332,17 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 	}
 
 	s_cmd->command += priv->cmd_offset;
-	ret = cros_ec_cmd_xfer(priv->ec_dev, s_cmd);
-	/* Only copy data to userland if data was received. */
-	if (ret < 0)
-		goto exit;
+	REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
+		if (!ec_dev) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		ret = cros_ec_cmd_xfer(ec_dev, s_cmd);
+		/* Only copy data to userland if data was received. */
+		if (ret < 0)
+			goto exit;
+	}
 
 	if (copy_to_user(arg, s_cmd, sizeof(*s_cmd) + s_cmd->insize))
 		ret = -EFAULT;
@@ -313,24 +353,29 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 
 static long cros_ec_chardev_ioctl_readmem(struct chardev_priv *priv, void __user *arg)
 {
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device __rcu *ec_dev;
 	struct cros_ec_readmem s_mem = { };
 	long num;
 
-	/* Not every platform supports direct reads */
-	if (!ec_dev->cmd_readmem)
-		return -ENOTTY;
+	REF_PROXY_GET(priv->ec_dev_proxy, ec_dev) {
+		if (!ec_dev)
+			return -ENODEV;
 
-	if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
-		return -EFAULT;
+		/* Not every platform supports direct reads */
+		if (!ec_dev->cmd_readmem)
+			return -ENOTTY;
 
-	if (s_mem.bytes > sizeof(s_mem.buffer))
-		return -EINVAL;
+		if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
+			return -EFAULT;
 
-	num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
-				  s_mem.buffer);
-	if (num <= 0)
-		return num;
+		if (s_mem.bytes > sizeof(s_mem.buffer))
+			return -EINVAL;
+
+		num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
+					  s_mem.buffer);
+		if (num <= 0)
+			return num;
+	}
 
 	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
 		return -EFAULT;
-- 
2.51.0.rc1.163.g2494970778-goog


