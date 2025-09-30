Return-Path: <linux-kernel+bounces-837622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F06BACC72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5823AF83B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA02FABF6;
	Tue, 30 Sep 2025 12:09:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E02561B6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234152; cv=none; b=LW04LZ+C2lBF4m4hpj4sGlhxN1WDRQo3BTHb90RGRJ+Zcx1xMuWiUOMTgfb7eYBRuTwu/mxZvoNUaKoVUIMucvCXvlKgTUGCMurwSaqkGSRmkJtB7NzsYZOmP2PGjtw0qVOz3s6gbC94VXGFv8j2rxvqzrQOA/B9ayNpPDLY1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234152; c=relaxed/simple;
	bh=aXheT6SuJ8j5FXGmOrUPMo5wJsarsxNsdl3Gz76bvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL6Rxsb3GcE7s8ZszRNNbSXvtK8VEMWpvP8DyXCgHBBCT65eticyOLibkcVZ3pZUh/2UtrEdF784WOHFEYqPAPAlwrDkeikxdF5oZOhzsZRw0sUuAdwadMcsWSlJcSYrb7tFQkSwhWkhFNw5PZ+IguINH4qZjLTuh0C1GmwS1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAD-0008KE-2P; Tue, 30 Sep 2025 14:09:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAC-001F1X-2r;
	Tue, 30 Sep 2025 14:09:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAC-00000009LkC-3TXF;
	Tue, 30 Sep 2025 14:09:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: core: add infrastructure for downstream event forwarding
Date: Tue, 30 Sep 2025 14:08:56 +0200
Message-ID: <20250930120857.2228296-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930120857.2228296-1-o.rempel@pengutronix.de>
References: <20250930120857.2228296-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Forward critical regulator events downstream through the supply chain.
Without forwarding, an under-voltage at an upstream supply is not
visible to end devices (e.g. eMMC), preventing timely emergency action.

Introduce an opt-in helper to forward events from a regulator's supply
to the consumer's notifier chain. For now only
REGULATOR_EVENT_UNDER_VOLTAGE is forwarded to avoid surprising behavior.
Drivers that do not opt in see no behavior change.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/core.c         | 113 +++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |   5 ++
 2 files changed, 118 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 554d83c4af0c..69cdc6db64e8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -83,6 +83,19 @@ struct regulator_supply_alias {
 	const char *alias_supply;
 };
 
+/*
+ * Work item used to forward regulator events.
+ *
+ * @work: workqueue entry
+ * @rdev: regulator device to notify (consumer receiving the forwarded event)
+ * @event: event code to be forwarded
+ */
+struct regulator_event_work {
+	struct work_struct work;
+	struct regulator_dev *rdev;
+	unsigned long event;
+};
+
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
@@ -5054,6 +5067,106 @@ int regulator_unregister_notifier(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(regulator_unregister_notifier);
 
+/**
+ * regulator_event_work_fn - process a deferred regulator event
+ * @work: work_struct queued by the notifier
+ *
+ * Calls the regulator's notifier chain in process context while holding
+ * the rdev lock, then releases the device reference.
+ */
+static void regulator_event_work_fn(struct work_struct *work)
+{
+	struct regulator_event_work *rew =
+		container_of(work, struct regulator_event_work, work);
+	struct regulator_dev *rdev = rew->rdev;
+	int ret;
+
+	regulator_lock(rdev);
+	ret = regulator_notifier_call_chain(rdev, rew->event, NULL);
+	regulator_unlock(rdev);
+	if (ret == NOTIFY_BAD)
+		dev_err(rdev_get_dev(rdev), "failed to forward regulator event\n");
+
+	put_device(rdev_get_dev(rdev));
+	kfree(rew);
+}
+
+/**
+ * regulator_event_forward_notifier - notifier callback for supply events
+ * @nb:    notifier block embedded in the regulator
+ * @event: regulator event code
+ * @data:  unused
+ *
+ * Packages the event into a work item and schedules it in process context.
+ * Takes a reference on @rdev->dev to pin the regulator until the work
+ * completes (see put_device() in the worker).
+ *
+ * Return: NOTIFY_OK on success, NOTIFY_DONE for events that are not forwarded.
+ */
+static int regulator_event_forward_notifier(struct notifier_block *nb,
+					    unsigned long event,
+					    void __always_unused *data)
+{
+	struct regulator_dev *rdev = container_of(nb, struct regulator_dev,
+						  supply_fwd_nb);
+	struct regulator_event_work *rew;
+
+	switch (event) {
+	case REGULATOR_EVENT_UNDER_VOLTAGE:
+		break;
+	default:
+		/* Only forward allowed events downstream. */
+		return NOTIFY_DONE;
+	}
+
+	rew = kmalloc(sizeof(*rew), GFP_ATOMIC);
+	if (!rew)
+		return NOTIFY_DONE;
+
+	get_device(rdev_get_dev(rdev));
+	rew->rdev = rdev;
+	rew->event = event;
+	INIT_WORK(&rew->work, regulator_event_work_fn);
+
+	queue_work(system_highpri_wq, &rew->work);
+
+	return NOTIFY_OK;
+}
+
+/**
+ * register_regulator_event_forwarding - enable supply event forwarding
+ * @rdev: regulator device
+ *
+ * Registers a notifier on the regulator's supply so that supply events
+ * are forwarded to the consumer regulator via the deferred work handler.
+ *
+ * Return: 0 on success, -EALREADY if already enabled, or a negative error code.
+ */
+int register_regulator_event_forwarding(struct regulator_dev *rdev)
+{
+	int ret;
+
+	if (!rdev->supply)
+		return 0; /* top-level regulator: nothing to forward */
+
+	if (rdev->supply_fwd_nb.notifier_call)
+		return -EALREADY;
+
+	rdev->supply_fwd_nb.notifier_call = regulator_event_forward_notifier;
+
+	ret = devm_regulator_register_notifier(rdev->supply,
+					       &rdev->supply_fwd_nb);
+	if (ret) {
+		dev_err(&rdev->dev, "failed to register supply notifier: %pe\n",
+			ERR_PTR(ret));
+		rdev->supply_fwd_nb.notifier_call = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_regulator_event_forwarding);
+
 /* notify regulator consumers and downstream regulator consumers.
  * Note mutex must be held by caller.
  */
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4a216fdba354..60d16d37196a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -658,6 +658,9 @@ struct regulator_dev {
 	spinlock_t err_lock;
 
 	int pw_requested_mW;
+
+	/* regulator notification forwarding */
+	struct notifier_block supply_fwd_nb;
 };
 
 /*
@@ -781,6 +784,8 @@ int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
 				       unsigned int selector);
 
+int register_regulator_event_forwarding(struct regulator_dev *rdev);
+
 #ifdef CONFIG_REGULATOR
 const char *rdev_get_name(struct regulator_dev *rdev);
 #else
-- 
2.47.3


