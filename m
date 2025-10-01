Return-Path: <linux-kernel+bounces-838751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F6BB0120
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671D72A1B94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150072C0F81;
	Wed,  1 Oct 2025 10:56:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF424502C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316215; cv=none; b=EqQKRnhvKJVbKLLwXHsZuAd+cFC6wnPDQc8MZnfHnqd2+EwBCSSyP7CxdKNNRwq/0cf2ERr13VXCSWN9G9DbmQQqGhuu+2CQfvUeqy5i6S4wlit0n2lGGXCdDbs7wtCmmJMbjTpxFTaHPKzjNOQk/k2z0YVG8SPOksF7RWGoeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316215; c=relaxed/simple;
	bh=Tm9YT35x+rhzIJsNx1RT++/G/P5A8DDEkwwm40aRU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNP/rb5zqxL0oZBhQigsYEQRVzf7+ElyAJvwIR64xsERlgTC8jGpqmJfYz7PXdMUbtlr+Gw66K7zQlqeou1g9hCF/zqJkDjPUDAU8scKtqQFOr2v4nQxKg33ymlb2xykH9DFexXBI2Yd9CosSx9aMNHU3tZb0V3SMdpFBUkiXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3uVv-0007XO-Eh; Wed, 01 Oct 2025 12:56:51 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3uVv-001On1-0C;
	Wed, 01 Oct 2025 12:56:51 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v3uVu-0000000A28c-4BYB;
	Wed, 01 Oct 2025 12:56:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] regulator: core: forward undervoltage events downstream by default
Date: Wed,  1 Oct 2025 12:56:49 +0200
Message-ID: <20251001105650.2391477-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
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

Forward critical supply events downstream so consumers can react in
time.  An under-voltage event on an upstream rail may otherwise never
reach end devices (e.g. eMMC).

Register a notifier on a regulator's supply when the supply is resolved,
and forward only REGULATOR_EVENT_UNDER_VOLTAGE to the consumer's notifier
chain. Event handling is deferred to process context via a workqueue; the
consumer rdev is lifetime-pinned and the rdev lock is held while calling
the notifier chain. The notifier is unregistered on regulator teardown.

No DT/UAPI changes. Behavior applies to all regulators with a supply.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- Switch to default on
- Register forwarding in regulator_resolve_supply()
- Make register_regulator_event_forwarding() static
- Use regulator_register_notifier() and unregister in regulator_unregister()
- Remove separate fixed-regulator patch (no longer needed).
---
 drivers/regulator/core.c         | 124 +++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |   3 +
 2 files changed, 127 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 554d83c4af0c..7629e6a28338 100644
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
@@ -1658,6 +1671,104 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	return 0;
 }

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
+static int register_regulator_event_forwarding(struct regulator_dev *rdev)
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
+	ret = regulator_register_notifier(rdev->supply, &rdev->supply_fwd_nb);
+	if (ret) {
+		dev_err(&rdev->dev, "failed to register supply notifier: %pe\n",
+			ERR_PTR(ret));
+		rdev->supply_fwd_nb.notifier_call = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * set_supply - set regulator supply regulator
  * @rdev: regulator (locked)
@@ -2144,6 +2255,16 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		goto out;
 	}

+	/*
+	 * Automatically register for event forwarding from the new supply.
+	 * This creates the downstream propagation link for events like
+	 * under-voltage.
+	 */
+	ret = register_regulator_event_forwarding(rdev);
+	if (ret < 0)
+		rdev_warn(rdev, "Failed to register event forwarding: %pe\n",
+			  ERR_PTR(ret));
+
 	regulator_unlock_two(rdev, r, &ww_ctx);

 	/* rdev->supply was created in set_supply() */
@@ -6031,6 +6152,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 		return;

 	if (rdev->supply) {
+		regulator_unregister_notifier(rdev->supply,
+					      &rdev->supply_fwd_nb);
+
 		while (rdev->use_count--)
 			regulator_disable(rdev->supply);
 		regulator_put(rdev->supply);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4a216fdba354..978cf593b662 100644
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
--
2.47.3


