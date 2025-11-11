Return-Path: <linux-kernel+bounces-896313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECCC50168
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F4A3AD715
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC522EDD50;
	Tue, 11 Nov 2025 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4XccFDvA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB31E50E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904730; cv=none; b=QklV8QNvbhhf5yUKTEuSytXmz+QEWa25he4BPR+CZn++QTYK1YvuN0+iCggdgdTJCAWSanWWQ8tyqKsF7FQvyRUs1g7hr6J0fxyLDADaZ0NFUjTYJrtjzbBqCme7V5kw6YEGu4Sb1c+cPmW+QnOqiACkc9OrxAs6isZO9vRkuz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904730; c=relaxed/simple;
	bh=qxooVqZ8G74g4ULaPe+b1bpS5QJxwVoELBCS6dYu+SY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HKEN/DVNjgz1c9NBah53KaK/3JxHdzplWJrhwLJLqQeicsgiTNjSq+M5TlNTgCsTLhZgTkJyUJsLHPbpnhoSW0mYv87BEFcmsg/gty4nNkWcvpHxmbORu2ru51FnyXUhWqaSm5OjxB9bocenQEALeb4RYsJCDcykBDy1hBygGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--svv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4XccFDvA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29848363458so5500015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762904727; x=1763509527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SkAgq4uxa7nmEDHPV7OO8AWFIpaAVvZ4Bew+s0IZT0g=;
        b=4XccFDvANQnOeF+G2HQUbZf0Eksrkmr9F/XCsKAFk1K7CNXPKGiLx3H/d9VJVVKlhZ
         IZ/4mBl+MJEZ0GwkG1NVBUop3pMJg7GIibeeJgx6aN7RN0oGpdJiayupgnhn5O5rWKWF
         e8fFGygkIma6BEU3opWkM0wUpawIVYhuo5zl57QbhrmoRzvfH6lU14iqfyn/ntu8DCp9
         ockJLroYXJKFJbEAJDSiC4sfoEsI7pxltEi5g7VHY8oPruoT9ziOqjwQjlFPr36TqfPG
         /WiS5gk0RaYhIgtxVDj3Ow/Q+kxbW0pF5wonaLsnjSqKBXA0FXz6M9VJEYSdni4E9EBU
         hL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904727; x=1763509527;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkAgq4uxa7nmEDHPV7OO8AWFIpaAVvZ4Bew+s0IZT0g=;
        b=YfnR3bMfx7zUj2vk//o4W8ldVSpqP6yFOYBlpgrB9uHe0K4PMQRrmSRdlATngLQsFY
         k9BqhaqbR8Sdy6MITekjj6QvJ6W5FXW8W3nz7PmFFiOdMvWZQJXVcwW/85jygCqLdsS7
         FEvj8eDjwH6cFACE2JbXabpgS816YL0SQGDNTX08VV4iZLrXj1DchXiJrL4oTfeGOJAg
         GbgYHtb5ADpsO0tBpEKOsB8ed+Ai7+IkT+ZuLOdQw4rEjDplgs0TtOdIaeb5G2GuD9n8
         QyQwU8mUi3qrqgKImHUCcZWfEu5OAzXWWkBeChEVBdmnBrvmoPT8jfguJYqKSavJNoHc
         KPDw==
X-Forwarded-Encrypted: i=1; AJvYcCWXBjqp1/RLzGVUV1Ku/QdRvytf7+yhY2MsswbQMVaTKG6MaCyHHw0nM+Kn2XaGCCG+dFvT1vxFtNafEyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2/VmX5V3p4QpCBAiIWG4oki3rDwHtUSkbg2IqH+LoWqgzRMl
	bpwVp/2vvrYzr1Q+xgDUGEHmhdMdIBt1CL8NrY+/ViEgWEHKEOpTMb7vr/HIdi3xyelRJw==
X-Google-Smtp-Source: AGHT+IHi8saf2F8wVaPEUpOukbg9CK0jA+tPs9m1AXQ0+2z7mS0WR+FRBSqOKKylZcLB1P8ogvHJtsc=
X-Received: from dlqq25.prod.google.com ([2002:a05:7022:6399:b0:11a:4dfb:95fc])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1967:b0:277:3488:787e
 with SMTP id d9443c01a7336-2984ed79f0dmr12519685ad.12.1762904727382; Tue, 11
 Nov 2025 15:45:27 -0800 (PST)
Date: Tue, 11 Nov 2025 15:45:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111234519.369652-1-svv@google.com>
Subject: [PATCH v2] HID: playstation: Center initial joystick axes to prevent
 spurious events
From: Siarhei Vishniakou <svv@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

When a new PlayStation gamepad (DualShock 4 or DualSense) is initialized,
the input subsystem sets the default value for its absolute axes (e.g.,
ABS_X, ABS_Y) to 0.

However, the hardware's actual neutral/resting state for these joysticks
is 128 (0x80). This creates a mismatch.

When the first HID report arrives from the device, the driver sees the
resting value of 128. The kernel compares this to its initial state of 0
and incorrectly interprets this as a delta (0 -> 128). Consequently, it
generates EV_ABS events for this initial, non-existent movement.

This behavior can fail userspace 'sanity check' tests (e.g., in
Android CTS) that correctly assert no motion events should be generated
from a device that is already at rest.

This patch fixes the issue by explicitly setting the initial value of the
main joystick axes (e.g., ABS_X, ABS_Y, ABS_RX, ABS_RY) to 128 (0x80)
in the common ps_gamepad_create() function.

This aligns the kernel's initial state with the hardware's expected
neutral state, ensuring that the first report (at 128) produces no
delta and thus, no spurious event.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
 drivers/hid/hid-playstation.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 1468fb11e39d..a145b5ea4405 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -718,11 +718,16 @@ static struct input_dev *ps_gamepad_create(struct hid_device *hdev,
 	if (IS_ERR(gamepad))
 		return ERR_CAST(gamepad);
 
+	/* Set initial resting state for joysticks to 128 (center) */
 	input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
+	gamepad->absinfo[ABS_X].value = 128;
 	input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
+	gamepad->absinfo[ABS_Y].value = 128;
 	input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
 	input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
+	gamepad->absinfo[ABS_RX].value = 128;
 	input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
+	gamepad->absinfo[ABS_RY].value = 128;
 	input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
 
 	input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
-- 
2.51.2.1041.gc1ab5b90ca-goog


