Return-Path: <linux-kernel+bounces-774093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3CB2AE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885F8620ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D3342CB8;
	Mon, 18 Aug 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l1h1TwQv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79401342C80;
	Mon, 18 Aug 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535827; cv=none; b=nrHqYp8LHSc71MZRMsh0vBDo1ptX7rM5rIu+9MYmG6zcbW/xAOX5rBI19l7Jr9Qp0kp3lb/jRPtd7iGgo27VO1cdIlp83OkWXXshTKKHx6s5d3Y4zB9ly8FBL77/ZT16J7br9vdxZ7Ze+hEgNq4QeR9IylEGOU3QYvY7vgM0mVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535827; c=relaxed/simple;
	bh=MGuv2ukYBUC0Ye0ioL6jboGYWp7kjlUyc8sH41xsuaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F1H5GN+flwPVg15cZCOc8TKTHHoi/cpuyPzvS/n4Bwzy1I18cVYbEiMycP38UzWJNI1cvZlzQR9CJTmTQcl4bOUPgokvW55EzD3PU1ZrQBh51IlOtziG05oWMn1vQxMRivA/b6Yuws4kV1F/m4JaJCtIm+rNqcvIC154UqGDClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l1h1TwQv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755535823;
	bh=MGuv2ukYBUC0Ye0ioL6jboGYWp7kjlUyc8sH41xsuaA=;
	h=From:Date:Subject:To:Cc:From;
	b=l1h1TwQvT1ZF3LODElGp/aAjFIHetP1JXEhVPLkjgxg16gdG/MbvCAdAAFB7lpqmn
	 EMDoYchZw8yBbQTVL5Vs1nL1R48gqmPKZTMecu6AkW7hyxG7b3R4N9wGMMWwkro8uO
	 2jAG8NWoZwBj+NqQ/epd1P+4cVrWmbtUcJNL5RzaF6Z0WZpB+5qgWv5ct7ViNVA2RL
	 lI3m9831t76SJ4PINwhC7CbAX+mxlBRV2Jsu490HRBjuVF3w2QBvDxmODXEyARtQkI
	 4f53FcEpCqU7olOF4TaiD4cm7ZyWV5GqvxufVyVkGHz8icqLwmMNFO/ML+TTJ27+KI
	 59Varhzdx19pw==
Received: from jupiter.universe (dyndsl-091-248-210-167.ewe-ip-backbone.de [91.248.210.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9023A17E0DE3;
	Mon, 18 Aug 2025 18:50:23 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 28497480044; Mon, 18 Aug 2025 18:50:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 18:50:19 +0200
Subject: [PATCH] usb: typec: fusb302: Revert incorrect threaded irq fix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-fusb302-unthreaded-irq-v1-1-3a9a11a9f56f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMpZo2gC/x3MywqDMBBG4VeRWXcgiRdCX6V0YcyvzibaSRVBf
 HeDy29xzkkZKsj0rk5S7JJlSQX2VdEw92kCSywmZ1xrvPU8bjnUxvGW/rOij4gs+uO6QxvM0Pg
 ASyVeFaMcz/jzva4bN5JnaGgAAAA=
X-Change-ID: 20250818-fusb302-unthreaded-irq-36e5b0c48be1
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yongbo Zhang <giraffesnn123@gmail.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=sre@kernel.org;
 h=from:subject:message-id; bh=MGuv2ukYBUC0Ye0ioL6jboGYWp7kjlUyc8sH41xsuaA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGijWc8irCnIETR7VZPXyCnu/ltLu7cg0CdZ7
 wzYAWPzdw+iYIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoo1nPAAoJENju1/PI
 O/qa3iEQAJ7CwQ9eNbPKa3g3l41hK8gHYOHoyM3TlAatPWY44Pby4CrGiKc9qpB0BLCzj3rPk/V
 3a1eKA4EOCUFjpGhkg2L8MYCO9KCClrItPzeZKX6qGfrh9KH/xkFZZOg9wI7IF9BxyPLQCG3xYq
 wzr49P9cOcsk93mL7p4eHEfislY7cM9Q2xMF1Oo7F5lKGmkOg5QCWrWYW7YUiwLeuTxyyL/bt9N
 UD0pxO+RYClXUOGrt8pzUslS8vqhHI+IBzS71H20GW8uUnJnnQP24rgbMjHW8UOESkL5pxRwXBb
 ns/fMHsFyE3OnRvsNRMOVZdg8UQLCnddMehfAjxwYRCTJSYVl1geLubotTHXcBzIF7p+p3yQYgA
 lrGKZiB6Y9hzUwFzyEoh+YlGj/z3b+K0pQcr2HA60/Z/6bWn04obwjw75oaHF0Vz+Ohh0D5VRJy
 0L6WY9hWNDw0C/IHADxCDHlxZgfIi7FwmtGrqYg/d2Lsc4lhFOz8tgGdns8pW6H6LQBjUu4ITWe
 +bSIDRmuzKvZ8FJ93meuTqo+6oJnTutNEt2FAUGq5jASEXxUfZn/EF10N3WWl8xJ5iCClgpA1U9
 sFggx3TdWBWtfYmOi9dQJ5SXr2J10SWMfuyGktW9PyBEcmgd+aKUDYhK9ej3wi7vHtqA8V/qtIj
 836dvFSkvGpNYHTH/GxQwWA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The fusb302 irq handler has been carefully optimized by Hans de Goede in
commit 207338ec5a27 ("usb: typec: fusb302: Improve suspend/resume
handling"). A recent 'fix' undid most of that work to avoid a virtio-gpio
driver bug.

This reverts the incorrect fix, since it is of very low quality. It
reverts the quirks from Hans change (and thus reintroduces the problems
fixed by Hans) while keeping the overhead from the original change.

The proper fix to support using fusb302 with an interrupt line provided
by virtio-gpio must be implemented in the virtio driver instead, which
should support disabling the IRQ from the fusb302 interrupt routine.

Cc: Hans de Goede <hansg@kernel.org>
Cc: Yongbo Zhang <giraffesnn123@gmail.com>
Fixes: 1c2d81bded19 ("usb: typec: fusb302: fix scheduling while atomic when using virtio-gpio")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Note, that the referenced patch is in 6.17-rc, but not yet in any
released kernel. It breaks boot for Radxa ROCK 5B when fusb302 is
enabled in its device tree (strictly speaking that's not a regression,
since upstream DT does not yet describe fusb302).
---
 drivers/usb/typec/tcpm/fusb302.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index a4ff2403ddd66fb7aaa27fd890533c7aff1dc163..870a71f953f6cd8dfc618caea56f72782e40ee1c 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1485,6 +1485,9 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 	struct fusb302_chip *chip = dev_id;
 	unsigned long flags;
 
+	/* Disable our level triggered IRQ until our irq_work has cleared it */
+	disable_irq_nosync(chip->gpio_int_n_irq);
+
 	spin_lock_irqsave(&chip->irq_lock, flags);
 	if (chip->irq_suspended)
 		chip->irq_while_suspended = true;
@@ -1627,6 +1630,7 @@ static void fusb302_irq_work(struct work_struct *work)
 	}
 done:
 	mutex_unlock(&chip->lock);
+	enable_irq(chip->gpio_int_n_irq);
 }
 
 static int init_gpio(struct fusb302_chip *chip)
@@ -1751,10 +1755,9 @@ static int fusb302_probe(struct i2c_client *client)
 		goto destroy_workqueue;
 	}
 
-	ret = devm_request_threaded_irq(dev, chip->gpio_int_n_irq,
-					NULL, fusb302_irq_intn,
-					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-					"fsc_interrupt_int_n", chip);
+	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
+			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+			  "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
 		goto tcpm_unregister_port;
@@ -1779,6 +1782,7 @@ static void fusb302_remove(struct i2c_client *client)
 	struct fusb302_chip *chip = i2c_get_clientdata(client);
 
 	disable_irq_wake(chip->gpio_int_n_irq);
+	free_irq(chip->gpio_int_n_irq, chip);
 	cancel_work_sync(&chip->irq_work);
 	cancel_delayed_work_sync(&chip->bc_lvl_handler);
 	tcpm_unregister_port(chip->tcpm_port);

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-fusb302-unthreaded-irq-36e5b0c48be1

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


