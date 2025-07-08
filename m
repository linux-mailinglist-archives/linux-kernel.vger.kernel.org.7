Return-Path: <linux-kernel+bounces-722184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66408AFD653
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537995669D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38E2E7BC2;
	Tue,  8 Jul 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IkLv1n/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLfpmM0b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B42E7178
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998828; cv=none; b=qly5Dy5/JB9oo3HgyX0gUOzPPCwYLkI960ciHIdqDrTvZR0/7/pnfLXHP2qSD9h0hXZLK32dJQKXsy4vKNw8YHRk+vcho22AqbFLxRP+fKw7ms5/vi5pjml65Rd5QFkr9xDccPcQ/97uaqgB9tfNqnX8xFdi18WFIM9eWpWQ4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998828; c=relaxed/simple;
	bh=v4LxCvv8WoskLG6QIetQCGXqVFUw0qQGnp7cVAGaT0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GmNZ/8KvMzWOzveMmhSh3Jef/sLW5a9sE8/+X7Ah15yv8IzrnPXHsGcUmnc+Ua2ktfFyvk/ayuWU0Jnnp3gv5mlvhusKQmT4M+lPFdesU6Hrzm0UwAyN5nVjwHHWlpR7zUOkx7EJ/c2P3/vhk2+u/QM5U+1YMItxXbC2FUUsVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IkLv1n/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLfpmM0b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 18:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751998825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FxpAD7zVLZ4qd8gwTxM8GBK3+ZCm/OxOBD1xLVw8CY=;
	b=IkLv1n/MP1hyXhNHUdeghJ9sCJl8eGVT2hrkMI/lqCq4nVdqQoov/XOY9cIGsX+ghiYwiZ
	sucUdbHJSSkfN8RYfYOoh7iAV1jilhne3c+SDH+nNaJJljUst2croG3maXhvbpSX5Atb2G
	wOydaJvHjmfvYSl1iYa1lLi90lvaPKUO5wYoKTaclwaPk+yFlqx0a7qpMy2IvYbJPb6PoV
	74ec7oBMps9liT5V2Hw8My2/ZwBNZ5CQwk0jKBmZk5zWfA6rnKh+sr6spIJUF1t0jAjYtJ
	YtwUWVZBVata1ZM9rzBMmCxApX3+lP8GU8G2pZIcktZ6S6wCWh15jtwwQwCUZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751998825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FxpAD7zVLZ4qd8gwTxM8GBK3+ZCm/OxOBD1xLVw8CY=;
	b=WLfpmM0bzoQxDgz0pubP65y7FQaot0JVJoZgYH02QXeLV9fypxH4XJbe5mCu/uOrZRZE2F
	kx1+v+wSy3ZQWkBQ==
From: "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject:
 [irqchip: irq/irqchip-next] of/irq: Add of_msi_xlate() helper function
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>, tglx@linutronix.de
In-Reply-To: <20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175199882466.406.11089795363838580771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     31fd3becb920e0b31b99cf202ace637f75dd7e78
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/31fd3becb920e0b31b99cf202ace637f75dd7e78
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 03 Jul 2025 12:25:14 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 08 Jul 2025 18:35:52 +01:00

of/irq: Add of_msi_xlate() helper function

Add an of_msi_xlate() helper that maps a device ID and returns
the device node of the MSI controller the device ID is mapped to.

Required by core functions that need an MSI controller device node
pointer at the same time as a mapped device ID, of_msi_map_id() is not
sufficient for that purpose.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250703-gicv5-host-v7-24-12e71f1b3528@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 22 +++++++++++++++++-----
 include/linux/of_irq.h |  5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b..74aaea6 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -670,8 +670,20 @@ err:
 	}
 }
 
-static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
-			    u32 id_in)
+/**
+ * of_msi_xlate - map a MSI ID and find relevant MSI controller node
+ * @dev: device for which the mapping is to be done.
+ * @msi_np: Pointer to store the MSI controller node
+ * @id_in: Device ID.
+ *
+ * Walk up the device hierarchy looking for devices with a "msi-map"
+ * property. If found, apply the mapping to @id_in. @msi_np pointed
+ * value must be NULL on entry, if an MSI controller is found @msi_np is
+ * initialized to the MSI controller node with a reference held.
+ *
+ * Returns: The mapped MSI id.
+ */
+u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 {
 	struct device *parent_dev;
 	u32 id_out = id_in;
@@ -682,7 +694,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
 		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
-				"msi-map-mask", np, &id_out))
+				"msi-map-mask", msi_np, &id_out))
 			break;
 	return id_out;
 }
@@ -700,7 +712,7 @@ static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
  */
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
-	return __of_msi_map_id(dev, &msi_np, id_in);
+	return of_msi_xlate(dev, &msi_np, id_in);
 }
 
 /**
@@ -719,7 +731,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
 {
 	struct device_node *np = NULL;
 
-	__of_msi_map_id(dev, &np, id);
+	of_msi_xlate(dev, &np, id);
 	return irq_find_matching_host(np, bus_token);
 }
 
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 6337ad4..a480063 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -54,6 +54,7 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 id,
 							u32 bus_token);
 extern void of_msi_configure(struct device *dev, const struct device_node *np);
+extern u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)
@@ -100,6 +101,10 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
 static inline void of_msi_configure(struct device *dev, struct device_node *np)
 {
 }
+static inline u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
+{
+	return id_in;
+}
 static inline u32 of_msi_map_id(struct device *dev,
 				 struct device_node *msi_np, u32 id_in)
 {

