Return-Path: <linux-kernel+bounces-723691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9DAFEA00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BF43A66C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797602DEA88;
	Wed,  9 Jul 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfQtM+hX"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055E291C31
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067360; cv=none; b=XoTRgnUnBTL2kdAnsJXh/BNehBG8cmzJoTedzUUY9+Uvf9+ZVZvvt+Q6aW0wm9/eKL4J3iT7zACWh+JQb72hlLjPyT3sPemlLbWHKcQ/5jy2fNQzLfmv+clj1ZvvN016w9qTkfhiCPnXtAyHJwLUIedDuc+QCvnNVTms/iZpqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067360; c=relaxed/simple;
	bh=P4NNh24Uubem3+5FD8u976ML2Q+JAb1DIESveJSn2Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fo/ey3NUTpIuQCdH7s5lcF1d1bHyIdbO7yYhyZZ7Hfl1/rfgOh3MDN6XyDlg5I4cGtNO4vytUmEd9BzBT4ia48IxbLg3wiKb2p+GAmDHwpJ5Thby+y+xGI6F72P8Pb86tbe9We4jBm3AjuFTIaJsWYhBTgry5Ez9O1J29+bu5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfQtM+hX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6105223641bso1348279a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067356; x=1752672156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVdeqDRdF6ZLtzy+wRZhrpbW4oRIUx8OwK+HIqHAMuc=;
        b=sfQtM+hXpuO7tWgwHlotnCvsVxhX69jLpi+T3R4zl6/T7aeB0bPDjIcPlN263p8lk2
         VgXUAhT7ybar+oaTSJb5mlSgCX+5IyL/CTxx/OzyiyudjvbKDcLaD0nQq3fb5eTtf3wK
         V7LT8FFv/VOs9y0ggm8lLrfcbraTTsLzmQjSdIdULRCCgFRpnsYtBheVjE1QPaebY9XC
         kU3PeJUFY4u3tAopcFnmKhsb6JNEidiCYkkzd/Q6Xk40jlzEGTk7MpdoDsZ28iCJitPx
         KxHcRJkY4Tplbf5InGYfuMIlf5gVisYcljwC9EBgVdCbxdeOFRONpchRzxTehagSbvwz
         9LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067356; x=1752672156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVdeqDRdF6ZLtzy+wRZhrpbW4oRIUx8OwK+HIqHAMuc=;
        b=dV8KC+/RZw+6XAIs+6MKPCGinmxhtMwndU6u2cGAESuhS9/LWbzedp2+gEs3T0oKJ/
         HhoqoiukyF81tu8jdkLXgxS5dCblUyGdnSMt9nrlQC8hq0R6Or67kLzT1nc5T7K/Rjh6
         BADBOHlIMRjx/KCnPJoo+4bAan69Hs8/56PNFf9Uf5h7juc22hM9C7oS66t6aybzIkgX
         /3A6lTfirkR1AiL5zu42gO5qQcpEYpiDW6InwRK73kJcIoaCpiXJvJH+jJ/zYhKw3g6P
         O7AKmiQIm4YCOgNKGME61kKCSNQveZVjj3N9tEgpRpvvFphm7Xmv22OF+BmbgDZn5YYk
         N+tw==
X-Forwarded-Encrypted: i=1; AJvYcCVgWjHSYMjT7NyFrE0nIasJDoS2Kk5XsxfYML5ov3QRL9AsHjSvvc2A1c1igROUZlWRRhYF9dndsxAsZ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRaXI5e77861ds7PXjkbUn6rhT0EO7lp1WcAldH6FeJ7XdRuC
	bf1JrrZv1sccvquOk6OtSu1IQQDPhG+Pnz9MTQTWAYzFJ0Tbzd8F7DOFrpu4jRMR910qyeP0SoK
	jqe+GJce5Tr05UA==
X-Google-Smtp-Source: AGHT+IES0Q1sgjW+61NY3L9U4CpfzOSPoPQsy+CX2JuVDMyWKfQl2YC02Tx3GzAP3ymg1Lfc5BIF/XUz2ysVGw==
X-Received: from edc20.prod.google.com ([2002:a05:6402:4614:b0:608:f54a:3f91])
 (user=raduvele job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26c6:b0:606:a77b:cca3 with SMTP id 4fb4d7f45d1cf-611a6599762mr2394898a12.7.1752067356562;
 Wed, 09 Jul 2025 06:22:36 -0700 (PDT)
Date: Wed,  9 Jul 2025 13:22:32 +0000
In-Reply-To: <20250709132232.2475172-1-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709132232.2475172-1-raduvele@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709132232.2475172-2-raduvele@google.com>
Subject: [PATCH v1 2/2] platform/chrome: cros_ec_typec: Add lock per-port
From: Radu Vele <raduvele@google.com>
To: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a lock associated to each port to protect port data against
concurrent access. Concurrency may result from sysfs commands
and ec events.

Signed-off-by: Radu Vele <raduvele@google.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 38 +++++++++++++++++++------
 drivers/platform/chrome/cros_ec_typec.h |  3 ++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 289429ef959f..bbb9e02624b8 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
@@ -54,8 +55,11 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
 		.mode_to_enter = CROS_EC_ALTMODE_USB4
 	};
 
-	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
+	mutex_lock(&port->lock);
+	int ret = cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
 			  &req, sizeof(req), NULL, 0);
+	mutex_unlock(&port->lock);
+	return ret;
 }
 
 static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_role, u8 swap_type)
@@ -70,6 +74,8 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
 	if (!data->pd_ctrl_ver)
 		return -EOPNOTSUPP;
 
+	mutex_lock(&port->lock);
+
 	/* First query the state */
 	req.port = port->port_num;
 	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
@@ -79,7 +85,7 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
 	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
 				&req, sizeof(req), &resp, sizeof(resp));
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	switch (swap_type) {
 	case USB_PD_CTRL_SWAP_DATA:
@@ -92,18 +98,21 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
 		break;
 	default:
 		dev_warn(data->dev, "Unsupported role swap type %d", swap_type);
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto unlock;
 	}
 
-	if (role == target_role)
-		return 0;
+	if (role == target_role) {
+		ret = 0;
+		goto unlock;
+	}
 
 	req.swap = swap_type;
 	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
 				&req, sizeof(req), &resp, sizeof(resp));
 
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	switch (swap_type) {
 	case USB_PD_CTRL_SWAP_DATA:
@@ -117,8 +126,11 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
 									TYPEC_SINK);
 		break;
 	}
+	ret = 0;
 
-	return 0;
+unlock:
+	mutex_unlock(&port->lock);
+	return ret;
 }
 
 static int cros_typec_dr_swap(struct typec_port *port, enum typec_data_role role)
@@ -370,6 +382,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		if (!typec->ports[i])
 			continue;
 
+		mutex_lock(&typec->ports[i]->lock);
 		cros_typec_remove_partner(typec, i);
 		cros_typec_remove_cable(typec, i);
 
@@ -378,6 +391,8 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		typec_mux_put(typec->ports[i]->mux);
 		cros_typec_unregister_port_altmodes(typec->ports[i]);
 		typec_unregister_port(typec->ports[i]->port);
+		mutex_unlock(&typec->ports[i]->lock);
+		mutex_destroy(&typec->ports[i]->lock);
 	}
 }
 
@@ -472,6 +487,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			goto unregister_ports;
 		}
 
+		mutex_init(&cros_port->lock);
 		cros_port->port_num = port_num;
 		cros_port->typec_data = typec;
 		typec->ports[port_num] = cros_port;
@@ -1232,6 +1248,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		return -EINVAL;
 	}
 
+	mutex_lock(&typec->ports[port_num]->lock);
 	req.port = port_num;
 	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
 	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
@@ -1241,7 +1258,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 			  EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
 			  &resp, sizeof(resp));
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	/* Update the switches if they exist, according to requested state */
 	ret = cros_typec_configure_mux(typec, port_num, &resp);
@@ -1263,7 +1280,10 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (typec->typec_cmd_supported)
 		cros_typec_handle_status(typec, port_num);
 
-	return 0;
+	ret = 0;
+unlock:
+	mutex_unlock(&typec->ports[port_num]->lock);
+	return ret;
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
index f9c31f04c102..d0a8a12ec91a 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -82,6 +82,9 @@ struct cros_typec_port {
 	struct usb_power_delivery_capabilities *partner_sink_caps;
 
 	struct cros_typec_data *typec_data;
+
+	/* Mutex to protect port data against concurrent access */
+	struct mutex lock;
 };
 
 #endif /*  __CROS_EC_TYPEC__ */
-- 
2.50.0.727.gbf7dc18ff4-goog


