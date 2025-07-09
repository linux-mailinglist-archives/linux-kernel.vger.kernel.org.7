Return-Path: <linux-kernel+bounces-723690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A1AFE9FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6823A4D02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4232D3EFF;
	Wed,  9 Jul 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3TkQcnjo"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C8276025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067358; cv=none; b=gS1zIOfdfavpFUYTillEw3eoKAx160Ib9pLndD4sXKswLduGAwOuvB2AEhqU81DUw0+om6jW1Y66IMgRQDreLg0Ss6+rXycIRmh75gs4ZISC4Fuz5nhVQaTVkAtVm2iEghW+HgZbM9QaSMt45GJ89WHnDKt4PRfOZIGC2rdSxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067358; c=relaxed/simple;
	bh=A2DoetifgDt48zV1gVs51Ud+jL1vtv986xcqbQ9S0Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AyFxWF3wxVcknFlWml+rQ68gS0GfiQE4Mep69OBzrJb1sPExQK9YvDtmX/JfX0GNu/smzz/Dmv1Ds0SIVfh5KXLEc6M06fETspkvt78vpFYXqbQ6g2vzsaVEtg257W8xEKYdfqq1cJt2wLyBW1yEXrk7EDDI4BL0Z3ejkLA+LoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3TkQcnjo; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--raduvele.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-60c6d568550so4814141a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067354; x=1752672154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0POwGeVY/oBf03TkHrGLCHAo/NCqv2tLic3Xhhp3IR4=;
        b=3TkQcnjoHL2oWFhwzv6H6ugSWZy8jnlfi5zuluIsbr4DkpC0Pvii4IE3jmYPyAo/ON
         0iVoOGbbXiB4ouZ+MYRQAKilCYHTO1Bl3rFv916QTLZnj8/Upe0m6uqMSibqLZ45vbm4
         XZly4Tjoq+gs05Bkv06HCWJXnfhg1BHaMCIr7BrQhJHryJtA/3JR2astp+YvxUq3cjvF
         JUkoBLLEpZm4tmPQhNo7YGErlzqSMFGLKx+712xIBwpJ3T8B2pOWrM7btGkNZvpXvN8x
         aK1kONnGtndHzHMlwQVLWr1VTDXn8G1wyZUg9jEVy8moNH4IJ/RGHQGepP8H7S0T++je
         kx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067354; x=1752672154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0POwGeVY/oBf03TkHrGLCHAo/NCqv2tLic3Xhhp3IR4=;
        b=N2oXoi7JMbPHYoClL3bh073ZiZjt2oRTpMDzTYN5TzXAXMGRYu5vKcozmi5I0vK6L4
         BokJ0AU5wvzz0Mj5tLBlMojpp19iQN9RjTOTPs9RdhCZvYfl0eRFnCLQTomhDaoVVTEX
         WfwlvF4recmBZTvX01fWAPF9taRW4cAVrjgJOggom9ZpDGmKmF1mb28wj7d4ICWeiSz2
         fvQfIaKl47RcJNwIJtjWxyFS/fzajav4JrmMlI+/JUR9xeHhPpuisSVb+j1sVOkm66e0
         tiEmBOo+ZALsVeDTGXO9K5DQuAnhNAh9decViAo3yY3mn2S8dRsOqlC9VilwAJHvZzY6
         EonA==
X-Forwarded-Encrypted: i=1; AJvYcCWCEtxTOULzTyutJ4sg1zImdPWz+Ztrq9aECQ0DfVFvQ/t1Q11/P0SMrqhmlXajPfDY0IcaF/qKKqfTXgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHweX2qZZbDpZsYSbodqzBJROOj0X5RzSyN6mUtcnATLpYc+m
	KhahpgX5gtmZ9wcWhHmAJU8jP+JXRhvJsaOxVVDICuEyduIwcVXkzfNnSsoxxFZBnt/NZq/GFfv
	N3kr+88vOsPbUpg==
X-Google-Smtp-Source: AGHT+IGZlrYoPqnzfB61mLqVQH6I9T9xqiZxhmKbJTnu8SwepKkIF9hCJoXZOBCPN7dspanLKivlSMfeN8QSIw==
X-Received: from edbdn22.prod.google.com ([2002:a05:6402:22f6:b0:60c:a42b:25c3])
 (user=raduvele job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:35d6:b0:608:f54b:5c81 with SMTP id 4fb4d7f45d1cf-611a65ab957mr2204701a12.1.1752067354375;
 Wed, 09 Jul 2025 06:22:34 -0700 (PDT)
Date: Wed,  9 Jul 2025 13:22:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709132232.2475172-1-raduvele@google.com>
Subject: [PATCH v1 1/2] platform/chrome: cros_ec_typec: Add role swap ops
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
 drivers/platform/chrome/cros_ec_typec.c | 77 ++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7678e3d05fd3..289429ef959f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,8 +58,83 @@ static int cros_typec_enter_usb_mode(struct typec_port *tc_port, enum usb_mode m
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
+		dev_warn(data->dev, "Unsupported role swap type %d", swap_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (role == target_role)
+		return 0;
+
+	req.swap = swap_type;
+	ret = cros_ec_cmd(data->ec, data->pd_ctrl_ver, EC_CMD_USB_PD_CONTROL,
+				&req, sizeof(req), &resp, sizeof(resp));
+
+	if (ret < 0)
+		return ret;
+
+	switch (swap_type) {
+	case USB_PD_CTRL_SWAP_DATA:
+		typec_set_data_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_DATA ?
+									TYPEC_HOST :
+									TYPEC_DEVICE);
+		break;
+	case USB_PD_CTRL_SWAP_POWER:
+		typec_set_pwr_role(tc_port, resp.role & PD_CTRL_RESP_ROLE_POWER ?
+									TYPEC_SOURCE :
+									TYPEC_SINK);
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
+	.pr_set = cros_typec_pr_swap
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
-- 
2.50.0.727.gbf7dc18ff4-goog


