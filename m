Return-Path: <linux-kernel+bounces-820443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2603FB7DFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A321E1BC7B59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB55350D4E;
	Wed, 17 Sep 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rCCxbLkp"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51C34AAE3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104006; cv=none; b=dfesQky0kETR40lZ5H6BTcwgbIMSAszN0HsjtmdwnJI4CkpUZasTH5K8WZ7kO3/htvHCk41qANSQd5UbxzXitoIetTBRvouns2JhG5dzSHjqeT2HffRD5c9H9dyb6IlrOBs2jePqR6YGZeoXWslbPtz8pMimDS2Hqx8ahcso9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104006; c=relaxed/simple;
	bh=vMPTMMaX4DuBqbFZgf9VREQRe7yCtSuApn5Ks/nN3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffyXRdNJxswrtsAVCqjmuM9oTifzqyP1Mn3RNlKsuwKx2hYy4+9Hn85dvovdEaBFpIf2nLItGZa1Brd3f9alemZQhXbF5qm/qfjVYTVX1BPN0zXm2V6jeMy1Y2mZAwc+mAfIZpCowIq6Buqg5BqHPC9P1fRd4lIetS1oQCrR3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rCCxbLkp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758103992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sY4yRTDzSjP2nKXOkMSrPlGsLlDMNjfquCWH7tlNoCE=;
	b=rCCxbLkpA/Cnzyvzd37H8DFM+iCrFO45c6ilgbwCkHhpB3jY2ratUDb5GYcfVnGsxiLlSI
	IMAPzinzuZTgxD1O5sVHpSgIjP5yVDgWEzwbMhb57LqxKmJd5wu52YzaL7VC3ssnxzOYQK
	BbKnbeZEXgjt2EUv6IKFExVYcdQzdnw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Pawel Laszczak <pawell@cadence.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ma Ke <make_ruc2021@163.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: hub: Use max() to improve usb_set_lpm_pel()
Date: Wed, 17 Sep 2025 12:12:31 +0200
Message-ID: <20250917101235.58381-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use max() to simplify and improve the readability of usb_set_lpm_pel().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/core/hub.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828..c8a543af3ad9 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -28,6 +28,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
 #include <linux/workqueue.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
@@ -277,10 +278,7 @@ static void usb_set_lpm_pel(struct usb_device *udev,
 	 * device and the parent hub into U0.  The exit latency is the bigger of
 	 * the device exit latency or the hub exit latency.
 	 */
-	if (udev_exit_latency > hub_exit_latency)
-		first_link_pel = udev_exit_latency * 1000;
-	else
-		first_link_pel = hub_exit_latency * 1000;
+	first_link_pel = max(udev_exit_latency, hub_exit_latency) * 1000;
 
 	/*
 	 * When the hub starts to receive the LFPS, there is a slight delay for
@@ -294,10 +292,7 @@ static void usb_set_lpm_pel(struct usb_device *udev,
 	 * According to figure C-7 in the USB 3.0 spec, the PEL for this device
 	 * is the greater of the two exit latencies.
 	 */
-	if (first_link_pel > hub_pel)
-		udev_lpm_params->pel = first_link_pel;
-	else
-		udev_lpm_params->pel = hub_pel;
+	udev_lpm_params->pel = max(first_link_pel, hub_pel);
 }
 
 /*
-- 
2.50.1


