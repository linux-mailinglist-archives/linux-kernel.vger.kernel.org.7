Return-Path: <linux-kernel+bounces-726706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A0B01042
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27B67B2B89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2980C8F0;
	Fri, 11 Jul 2025 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJ112fn2"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FCBA33
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194108; cv=none; b=Ub4T8Q34PhjwIPa2J4H/RUHvTBZZV4EqB5+ioj4RyfkNSVAO5L8dniJ84IhoWQDqbWiv2Cmli7BX9X8qEdZt9vZR58CQYpYMu8aPTkYSuSdL9VbH3BmTsdew6FqiQducdl2x1INbvsBAAVZjwan8XHQFJJIVG26lE6l44x6bMbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194108; c=relaxed/simple;
	bh=9ffrvIK5jaQ6HiA0P7odbBJIoQ9cftfXdnMC0msSa6Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lpQ+4plllt9SeVdRC9lvuzCJJ5AhvyGm2H8WxhlxUKTLwsEUpxB6+Mj4k9+TlGAnVRcwSuBulErArpwnmV3oBkC4hNyBGUTxC+VWZVeCPHq9vwf32Kg9DeyQSi5TE/qOuv2oMOX4MV41ZeBk60mStTBYmHpnM3XJov8q5mAmvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJ112fn2; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60785c45274so1116784a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752194105; x=1752798905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfAdX2MqONc3umr8BiQV/VWYcu9IN89E1XmpZSpBvuM=;
        b=wJ112fn2LYZXJXE4iG2Z6BTHOhxf/MeXsFeZaOdruviA4kmxVGlS2LtkigNmIHK/kH
         ncliidFEPZmxKtt0kvd1FVzMJsqfTHM7fZMX/Jv3DDYbwn65zTb4x4O9EofHXQ8qXKHk
         ppvnIqb4DQ9XONISTxNx6Lyp3qm0vBW9S2Ob6bJdCS9rAY22msK67uoufzibKQXOub9b
         wbw6oHA6eJnoQqAXps6SUB+ysab8AH3MXE5mtLqagwr91YaJWyALPvt1JPwYreU3ys1p
         K5/lk6ORpkG3pw9j8Tj9A0Go3mg7Jt8UyB3R5I7JFMq4eVLiUrbICf+FrvbPnq5f4+k5
         Ci8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752194105; x=1752798905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfAdX2MqONc3umr8BiQV/VWYcu9IN89E1XmpZSpBvuM=;
        b=DyFajXQ0Vf224HAikb35FKyYDto07EEmWnTP/hi8NQBZhqm8elPGFyH9xbDF+QcGgN
         /xDyFbxuPIdlOPpUWWv99Tn4N8CNm20aevgF2xkDuORgQK94Lhg4cTvXh7CD1puK42En
         h+MKOhcp6TSQBKiKnDgVQ3PichvXom4Mo0vszrK3uiZF0A1qb/gDdnyo9eXnaPiP7IFn
         J7k5jHGJoYRYDNpK+lm5oXkk9kEuB//CnIUZdKuwvRC4UzF8iCt1gfAXD+DFPxgHVuhz
         46/Y10/c6Ds9VcK3kW+is2/5k7s8soSvck52xgH9HvoTkd4dVBIbXV5UqyV4VRvzJpwI
         IwWg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYTLeKQ1NBvXihoYzk9QsU62oChUm/mN35C9qZ7GEA5q1ScQ7icxQfqGm6lG4cx1Q1UVFRbLDlNXsxvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEwxpvl0dI4y/O2nAe+a4hwzoV8/oDoq/f9VFjHOY35OKArhO
	0wLMUj9TAodg/eIkZ6S4BkZKilNtdlK+JFo0IfziwHOZ6Vi67BUhZbQoP+lYzbnVDWfIBQgOnPE
	6STITcdKWwZn/yw==
X-Google-Smtp-Source: AGHT+IEY5l2MjG3wbFjOsXTF7b0MS6bi8janbGCzV2kVEfsPPF284wBY7MoFRHUcb8hDxM7iInYsgpL8vQyVEQ==
X-Received: from edbet3.prod.google.com ([2002:a05:6402:3783:b0:608:806a:7dbf])
 (user=raduvele job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:210e:b0:601:fcc7:4520 with SMTP id 4fb4d7f45d1cf-611e7608d27mr752920a12.4.1752194104914;
 Thu, 10 Jul 2025 17:35:04 -0700 (PDT)
Date: Fri, 11 Jul 2025 00:35:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711003502.857536-1-raduvele@google.com>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Add role swap ops
From: Radu Vele <raduvele@google.com>
To: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Add the pr_set and dr_set typec_operations to registered typec ports.
This enables sysfs to control power and data role when the port is
capable of doing so.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Co-developed-by: Radu Vele <raduvele@google.com>
Signed-off-by: Radu Vele <raduvele@google.com>

---
  Changes in v2:
    - addressed comments from Tzung-Bi
    - after EC command to swap role is issued we check if the returned
      role in the response matches the target role. While testing this
      I observed that for power role swap the ec returns >0 but the
      returned role doesn't ever match the target role (but the role
      swap happens as expected). This may be an EC bug, I am
      investigating.
---
 drivers/platform/chrome/cros_ec_typec.c | 85 ++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7678e3d05fd3..e689bfaf95dc 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,8 +58,91 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
 			  &req, sizeof(req), NULL, 0);
 }
 
+static int cros_typec_perform_role_swap(struct typec_port *tc_port, int target_role, u8 swap_type)
+{
+	struct cros_typec_port *port = typec_get_drvdata(tc_port);
+	struct cros_typec_data *data = port->typec_data;
+	struct ec_response_usb_pd_control_v2 resp;
+	struct ec_params_usb_pd_control req;
+	int role, ret;
+
+	/* Must be at least v1 to support role swap. */
+	if (!data->pd_ctrl_ver)
+		return -EOPNOTSUPP;
+
+	/* First query the state */
+	req.port = port->port_num;
+	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
+	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
+	req.swap = USB_PD_CTRL_SWAP_NONE;
+
+	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
+				&req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	switch (swap_type) {
+	case USB_PD_CTRL_SWAP_DATA:
+		role = (resp.role & PD_CTRL_RESP_ROLE_DATA) ? TYPEC_HOST :
+						TYPEC_DEVICE;
+		break;
+	case USB_PD_CTRL_SWAP_POWER:
+		role = (resp.role & PD_CTRL_RESP_ROLE_POWER) ? TYPEC_SOURCE :
+						TYPEC_SINK;
+		break;
+	default:
+		dev_warn(data->dev, "Unsupported role swap type %d\n", swap_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (role == target_role)
+		return 0;
+
+	req.swap = swap_type;
+	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
+				&req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	switch (swap_type) {
+	case USB_PD_CTRL_SWAP_DATA:
+		role = resp.role & PD_CTRL_RESP_ROLE_DATA ? TYPEC_HOST : TYPEC_DEVICE;
+		if (role != target_role) {
+			dev_err(data->dev, "Data role swap failed despite EC returning success\n");
+			return -EIO;
+		}
+		typec_set_data_role(tc_port, target_role);
+		break;
+	case USB_PD_CTRL_SWAP_POWER:
+		role = resp.role & PD_CTRL_RESP_ROLE_POWER ? TYPEC_SOURCE : TYPEC_SINK;
+		if (role != target_role) {
+			dev_err(data->dev, "Power role swap failed despite EC returning success\n");
+			return -EIO;
+		}
+		typec_set_pwr_role(tc_port, target_role);
+		break;
+	default:
+		/* Should never execute */
+		break;
+	}
+
+	return 0;
+}
+
+static int cros_typec_dr_swap(struct typec_port *port, enum typec_data_role role)
+{
+	return cros_typec_perform_role_swap(port, role, USB_PD_CTRL_SWAP_DATA);
+}
+
+static int cros_typec_pr_swap(struct typec_port *port, enum typec_role role)
+{
+	return cros_typec_perform_role_swap(port, role, USB_PD_CTRL_SWAP_POWER);
+}
+
 static const struct typec_operations cros_typec_usb_mode_ops = {
-	.enter_usb_mode = cros_typec_enter_usb_mode
+	.enter_usb_mode = cros_typec_enter_usb_mode,
+	.dr_set = cros_typec_dr_swap,
+	.pr_set = cros_typec_pr_swap,
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
-- 
2.50.0.727.gbf7dc18ff4-goog


