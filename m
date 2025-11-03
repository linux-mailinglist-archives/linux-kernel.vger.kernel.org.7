Return-Path: <linux-kernel+bounces-882900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D594FC2BD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE9B4EF421
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9F221264;
	Mon,  3 Nov 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W0vtjdpc"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0D30CDB1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173769; cv=none; b=sFJAuWW8az6jKeelzVzsBdQALPNQ4R7Vk3OCu1I6qCE83uOhCDJxgmUluJamEOqzi/Dy9Z40e1vmUGXod9N76osljl9neP0PYaYdqTI5hk6brmIcwJZsDlMEX4CN2x3cEfeM8aL4TyJPFHNb9qSfKAlK6k345Lx57/cziJ6r8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173769; c=relaxed/simple;
	bh=9WWZRj95x1PsEyZywEyr4mp9AG5VR4rGO6uiOLlvg2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/J9wnZ0XN3mmihkky1430ifwV/pn31x6tn+3gXLwZCuvOjJo5logPCURfL4GA5LdM3YCevTl8Z8i/K6yg7zAdvq8e4c2zJcGMgpWIkiUuX+67rFP2ZBslt6iVHUUx6ffWS90cRodNIFoOU2+T5HtxNIXc9isl97M6q4Z3KL3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W0vtjdpc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso7438246a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173765; x=1762778565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPrnykW9RcTv8SXmC4oIff7zEg9zUe3KhDF23k6GnlE=;
        b=W0vtjdpcAFoqNDwPO/neNXFiGxgBqSgDMHoH7+WMYDE9PuL1R+LzQNdTz/L/gfMaNv
         us8cojP/zowHd/QbzLQIxV0tAu0ol5LhLmDzLwPRnhZ4Yoe9Qf94yy80Om1E5GKWVabz
         6G2YxswccxGUdC1kC5fIaQgNPYK0fCPQXUApjhuIMi2VuQ3ZVhRWSFh6+p3yv+Tb+xdi
         s+MbEOb8J/sCdrwsn4rkUOQAuY8CBwvQF85Wa4l4E0z06+sQ29a8F85OwkClPKHUTUAU
         iQRAI6E3tbj47TabMlVHLWu+w1mJYqH8lKQaCwmfnJIwHAOHuJCrQHbuTdFuDO3MnUn2
         YynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173765; x=1762778565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPrnykW9RcTv8SXmC4oIff7zEg9zUe3KhDF23k6GnlE=;
        b=K3ZTEKFxt07DFV4vdNz3Zx/ykq5tk6vJxYuG/KFJGx+jMYFkhKBOd45vFTaOe95bkP
         WM30234LzuxBgolvjZDVpd3eI+70KS5VmfKduq/IJQHrqtRRFK3Q3QlAiv5xisktydaj
         tJ6cbEmDgdZznIikIBcvlQMIk+ztIqadMfBoZZDENPykAHq+YbXxUxcjFaeOYpIpKz7d
         eBSsygrPLsPcSNd+rg/cRIkfgnGB9H3zncV21sm5mq9x0OenipRwVMYObxF3MDKIfjSM
         dXTAAEsysRlB5z0euC2FPKA3J9VW8H8Cj1O8SWrYr0ZLb4NnI4LP9QLy4e6MhD+921pp
         TGzw==
X-Forwarded-Encrypted: i=1; AJvYcCVQLMAWWW71QTr6b67/NNkFUxYa44UMbeQMrEnfvRGO8JgF8EAPU71pfwTXVRtemvNswHuy/U2Tc/D8Qpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhNfnt2BIRjIwP7xUQZlwQ1RC5psRl4UlKL7BBrS9kINAt7nx
	lkP4t65+lJP1oKfobIwKYq65GRXcLUJdElJQjB4pCEvIWgbdH79+yWnpKp9zCydvwus=
X-Gm-Gg: ASbGncvbaNyV6CAqYESGZXkAKsLqdSzcK6RSYN8Nycla363WD4lPECBd4PnqzoCR0J9
	+jdnGXeoILxJXqS5t9Aax8RyrcQmkBCBUHoa+VkQVyLZgHRi7JKIPQD2pTB2jlGJ0ha9179u+6d
	J5DOzMNgX7tYU5LCfzpFm0mxOXRvFZJs9HrJX3djbvWYcyx1sczoSiliDCboDtt1brvVa8AE2EI
	uQQiu5qi/OCeg+ewjC5J5XHYiZMdzR5zSoWd8nN9dJgOooeI91Y9z2XF0WJv+c/84CGhvjRehVB
	m3DbOGL2dGoWTQgaHF+c/nHzkuSf09x+dKaVt/iLRXc9knyquXsS8RiKh+4F2egDB1dBKnwa7Kf
	OkjL6NRY2XP9c3LwCecEp2/flxdciefCN/NbPppVWFeXLXy4a4a+2k2ckIDZOcK4RG5Oc8QQ=
X-Google-Smtp-Source: AGHT+IEt2sGyB8OGmSAirfMXRL4rXymXxxnigXWQMbloi64CMl+rBW5jNMGAdVjLMSOzt2Z2+JBIlg==
X-Received: by 2002:a17:907:60cd:b0:b3b:110c:d343 with SMTP id a640c23a62f3a-b70701061c7mr1219796166b.8.1762173765217;
        Mon, 03 Nov 2025 04:42:45 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b70bd65ca39sm348853066b.26.2025.11.03.04.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:42:44 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:42:21 +0100
Subject: [PATCH v10 3/3] firmware: ti_sci: Remove constant 0 function
 arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-partialio-v6-12-b4-v10-3-0557e858d747@baylibre.com>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=msp@baylibre.com;
 h=from:subject:message-id; bh=9WWZRj95x1PsEyZywEyr4mp9AG5VR4rGO6uiOLlvg2k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyOxdZ7NE5/fPheUGmV3Z/0nr0a4lOcNDdtrst6dE+iI
 5rzgu6ljlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIMz2G/+lzd76tzC2pOXVi
 14eD3gfTM6epTn4ZKz5hxcdT513ypIIZ/tfuLI4p25z+VE9ng/P5tUrJc1ZvqXbXUq8I0eOXn1B
 mxAAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
debug_flags which are always 0 for the caller. Remove these arguments as
they are basically unused.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 811507ded63ac784ad6c6ad77b2f827768f3f3c7..023c603ae58cb5df176c66eec429bd0b4037b798 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1664,14 +1664,10 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
  * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
  * @handle:		pointer to TI SCI handle
  * @mode:		Device identifier
- * @ctx_lo:		Low part of address for context save
- * @ctx_hi:		High part of address for context save
- * @debug_flags:	Debug flags to pass to firmware
  *
  * Return: 0 if all went well, else returns appropriate error value.
  */
-static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
-				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
+static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode)
 {
 	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
 			TI_SCI_FLAG_REQ_GENERIC_NORESPONSE :
@@ -1702,9 +1698,9 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 
 	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
 	req->mode = mode;
-	req->ctx_lo = ctx_lo;
-	req->ctx_hi = ctx_hi;
-	req->debug_flags = debug_flags;
+	req->ctx_lo = 0;
+	req->ctx_hi = 0;
+	req->debug_flags = 0;
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
@@ -3729,7 +3725,7 @@ static int ti_sci_sys_off_handler(struct sys_off_data *data)
 
 	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
 
-	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO, 0, 0, 0);
+	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO);
 	if (ret) {
 		dev_err(info->dev,
 			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
@@ -3768,8 +3764,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 			 * internal use and can be 0
 			 */
 			return ti_sci_cmd_prepare_sleep(&info->handle,
-							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
-							0, 0, 0);
+							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);
 		} else {
 			/* DM Managed is not supported by the firmware. */
 			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");

-- 
2.51.0


