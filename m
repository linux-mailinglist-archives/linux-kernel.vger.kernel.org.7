Return-Path: <linux-kernel+bounces-726707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11354B01043
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A571C8119A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD7182B7;
	Fri, 11 Jul 2025 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEoKZTMI"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C3C13D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194110; cv=none; b=CK+2jg4KaxUf3CZLdgLLGKdPYRmctMHf68G6Cn2iAeeAqxfYvzRV7TKjH1SwMOpty+eEAVNc1v5oNICuxCkr9GjLLY1K5bFVQcH73Wcz3xXJWCkG9mHk783WCB8UHyFeXKlc+gqYshKzDBjFSojjDq9m8a0LAZhmVPaB/wESYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194110; c=relaxed/simple;
	bh=e6+DZi1JgBpr17kx0CjWTVQ9OCnXGT8vSxIPwoHZdf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rd4s70flybK/WzUndYuHQvjbOYtqHWpPxMxmlLQN75lkTL+jg4czx6e+ND0cXnt0MUo9dwW+quMg5icU7GpBixNHm4Rp4+A1XZHUiyTvUod9JIYI7GXvBSFEg8CeZcZVO0iV+hriTuJpnqWESA6VeCOL1mB2V28/ZvKcyT8Qjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEoKZTMI; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-606b62ce2d4so1661482a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752194107; x=1752798907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSHKjcKKvYgRHJeFbbOrV5zha/qrZ8dMntIj30OJ+ao=;
        b=dEoKZTMILZ+muZs5fjv0TlSCneB86M4X8VVE8y2kVp/YoPRYXmToId/X4ZcEBwORDy
         m94RP6OnAukHs7PWkudE2jtWM+Lpfk76RZTvnQCkreO7YkH6Uk4d08aZLYlK5mOx1KhB
         36vDASdA4mRTIxFWgf+9PIS+HXJ5k0zWZ1spOIMVzP1/Y4kVMATQ0vtBH2xclQI0buXl
         wUYRvIQjrezSa8K/gj5fFc300XfdHKbms3y4/PMPOToUd5ffrqWxazxppPYjjUOrD35x
         G+fm8iyDIzP0bDHDli68cucho/TROMvFqmk2IFqFhLQLNBtlJYclz5O4SEuSE+44QGow
         QKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752194107; x=1752798907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSHKjcKKvYgRHJeFbbOrV5zha/qrZ8dMntIj30OJ+ao=;
        b=ZUnqqcbppXr63c7U8YW5X4wZ+cotaR8Cc29SavrmXBg/0s7FHDGeJ9iU0zWiXdLjEW
         kvEws0Z5TltOSpr3Mx/H0NVRopMBKPyOVdgZ8DjMCMI6rs3j4sOxAckTWtkN7CI58ZxK
         1hRCKgUdxfwhDxUOUM/KB/A0V/6LB94eeY0B4oSoMMcdONVY/cOw6kDXEXK0SFrXf34t
         5saDr6xATdGBt2oByKim09T1QI6LlU2GEbVhFt0mu80cD9MqBYaBCbH2Oyn95jJ6hRhO
         WXDewQEGUa6iN9x0sRIETciwsHQPP2KjDW8CzNhPBcHrAu1BtWeLiyY/Cw+bFilJOC77
         VzDA==
X-Forwarded-Encrypted: i=1; AJvYcCWyXtBOL4fy3CrnjSq9VB1/v9z/306ZVsudv7ErlTQDtVZpfCRvJ5BlcLNIVFQyq27O3KgUMwJETDjrt7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHol3ix7F6hXg+OvBI6gLpm8EdxGxXuPRoNL2EEFiRrVqcpWCT
	Ffhf/tzMs72j5tynY8pkT/HGmOUgGjJgC6qLrLRP7CGzBRVe8hR+6XG3ii3fLXShXjalLDIa0O7
	JF046O62s8JI6BQ==
X-Google-Smtp-Source: AGHT+IF5x6/2oYvOsXOIupQ8KAQZV10RrodN3KzeY1zC+GHgSI/M0WxEiGUgw7kvT3FI7WC1cHMA9KmoqxlMXA==
X-Received: from edsk12.prod.google.com ([2002:aa7:d8cc:0:b0:608:f54a:3f91])
 (user=raduvele job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13cb:b0:607:20b1:7485 with SMTP id 4fb4d7f45d1cf-611ecaa2e30mr386190a12.2.1752194107049;
 Thu, 10 Jul 2025 17:35:07 -0700 (PDT)
Date: Fri, 11 Jul 2025 00:35:02 +0000
In-Reply-To: <20250711003502.857536-1-raduvele@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711003502.857536-1-raduvele@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711003502.857536-2-raduvele@google.com>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add lock per-port
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
  Changes in v2:
    - Followed Tzung-Bi's suggestion to use the guard mechanism for
      managing mutexes. This also removes the declaration of `ret`
      in the middle of the function that Benson pointed out.
---
 drivers/platform/chrome/cros_ec_typec.c | 10 ++++++++++
 drivers/platform/chrome/cros_ec_typec.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e689bfaf95dc..f6a3d73a967f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -7,7 +7,9 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
@@ -54,6 +56,7 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
 		.mode_to_enter = CROS_EC_ALTMODE_USB4
 	};
 
+	guard(mutex)(&port->lock);
 	return cros_ec_cmd(port->typec_data->ec, 0, EC_CMD_TYPEC_CONTROL,
 			  &req, sizeof(req), NULL, 0);
 }
@@ -70,6 +73,8 @@ static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_r
 	if (!data->pd_ctrl_ver)
 		return -EOPNOTSUPP;
 
+	guard(mutex)(&port->lock);
+
 	/* First query the state */
 	req.port = port->port_num;
 	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
@@ -378,6 +383,7 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		if (!typec->ports[i])
 			continue;
 
+		mutex_lock(&typec->ports[i]->lock);
 		cros_typec_remove_partner(typec, i);
 		cros_typec_remove_cable(typec, i);
 
@@ -386,6 +392,8 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		typec_mux_put(typec->ports[i]->mux);
 		cros_typec_unregister_port_altmodes(typec->ports[i]);
 		typec_unregister_port(typec->ports[i]->port);
+		mutex_unlock(&typec->ports[i]->lock);
+		mutex_destroy(&typec->ports[i]->lock);
 	}
 }
 
@@ -480,6 +488,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			goto unregister_ports;
 		}
 
+		mutex_init(&cros_port->lock);
 		cros_port->port_num = port_num;
 		cros_port->typec_data = typec;
 		typec->ports[port_num] = cros_port;
@@ -1240,6 +1249,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		return -EINVAL;
 	}
 
+	guard(mutex)(&typec->ports[port_num]->lock);
 	req.port = port_num;
 	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
 	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
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


