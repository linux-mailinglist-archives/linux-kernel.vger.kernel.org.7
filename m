Return-Path: <linux-kernel+bounces-847650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4319BCB5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F7354E63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE022727F2;
	Fri, 10 Oct 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23tNBei7"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05A26CE2F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059217; cv=none; b=Z8ZbI/Ro04Q4Rv/p7h+qouYg1DJzvARoINEN8eHEbTT/iDY4aOAPY5O9upqgaUrYZ0Dw3YrwxR6Da8Q9H60ynUabGzQS/RKaP/5LHOpbpwV9nslAoHSPpUSHk8l2M8Q+VBmWuBlX8f14zADvDqvWHYG/UPZXbLj2jH9i9q2BwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059217; c=relaxed/simple;
	bh=zpsFxkYp7i/qFinpxTf4uQvjMjKAkyzUtADOVa7F/Rg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t2Y+r/GhH1MeSgMKx/5JuFeN2m8zSGLlr/kzCsMS2Thn/bonIVbpLZdOjS2a3VjKP3aacjWajCmFnI9lsc/2tTw8rgqiWdtBwmR9Jeuz1JnG4ZwFPoRW0NpOBT3D5L6I8LWg15Akx+FmUkorUGhTXCoTzolmHu05qmcXV3YVLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--svv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23tNBei7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-781253de15aso4802971b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059215; x=1760664015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bkwp0xgfZSEd0BSxSFi0SgJuGdtO+jQeRTWHAgDhs58=;
        b=23tNBei7HNsVrsg5ueaNxPGKbOSl+1Y/5n59Opt0xXH41RZF0U7ZCqMpoilr2gZofN
         8cgsKL5IxUi+WhQrzZQQpOu52r/g9QNb/iYEd7m9lXE7GLtILXq+OX8wZxYChn0ua6co
         1DVShrwKEXhUhYDs9rOiW3tw0u4WrjVCS12VFRLXW4DP8AF0sA4adeX8bBKTlLbamuk5
         LBxXTnPmDuK6romnuz2Q15OkHeIUP0L92XFcxTCMof8/dPJbp/l2Le5KsRUzxUDMzEZ9
         SW43Yg7fw2PEidYHIZMjlLfaOB4+FWrEveW4TG4xRTHoHyOI5+xGRZehNcCnFsmHjKcM
         2xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059215; x=1760664015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkwp0xgfZSEd0BSxSFi0SgJuGdtO+jQeRTWHAgDhs58=;
        b=GHgBQnYehULEbe6IUpFUT/EoCBsYzZjUiX3EAMY2m874U+AsOxMEo+Ru8nagaK8beR
         JS7BXaI3K86KsU50d+F2lgRr2MbR8OMV1vUyn2aKqVIZDucZZxakmxSlsCZTHw4sH9++
         SUDg4XXML8tcLcwCrm0G2CfEU4JzUYD6/CF3US381eUxLP0R0mC4t6V2MM8RjXGv5jRg
         LCBq92qo8boPpOqQVL1/irBhvrH3Uip3GWyXVtvK48h0B4cekBdFPYFe+FkILZ9Q826i
         7iE838WWTzUzsTLXyP0I5EhWbA7jbQTlOn7CYWc8z4bXQmoVdSm41PbHpFNmNhw0R4Y4
         PVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVYUc9xLpofJYeE62NN8qtbj6aqDwQm19aJBygrwYqDcoVuAppw/nwQSi6AFZKwlfeYq0LLQWpwckXsgak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSW/dqvNi7T3TckjINJtnSSyPcIuc2XnVbXK7DY0D1DDjA6JMu
	IXbtAG7yHkxoLIlSUNzxFnYJ7I28qtHEBYx0rLOqHCLaIhvhi6G4SLfSPAbe1+RkX+rlOg==
X-Google-Smtp-Source: AGHT+IE/oYoGQXxn68i5qfazwIxY7OpJR/DN4zu7YepqEPWGgaKmJJzz1DQpi8EDScfHDcUOIuvIsCs=
X-Received: from pfx5.prod.google.com ([2002:a05:6a00:a445:b0:77e:468d:c50d])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9a4:b0:77f:2de7:eef3
 with SMTP id d2e1a72fcca58-79385324dcamr11417351b3a.5.1760059214953; Thu, 09
 Oct 2025 18:20:14 -0700 (PDT)
Date: Fri, 10 Oct 2025 01:20:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010012006.2282321-1-svv@google.com>
Subject: [PATCH] HID: playstation: Remap joystick axes to be centered at 0
From: Siarhei Vishniakou <svv@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

The joystick axes (ABS_X, ABS_Y, ABS_RX, ABS_RY) for PlayStation
gamepads report a neutral state of 128 over HID, with a full range of
[0, 255]. The driver previously mapped this directly, resulting in an
evdev range of [0, 255] with a resting point of 128.

This approach is unconventional for Linux gamepad drivers and has several
drawbacks: it requires userspace applications to be aware of the
non-zero resting state, and it is incompatible with the input
subsystem's 'flat' (deadzone) logic, which assumes a resting point of 0.

This patch remaps the four joystick axes to the conventional signed
8-bit range of [-128, 127], with 0 as the neutral state. This is
accomplished by changing their evdev range in ps_gamepad_create() and
translating the incoming hardware value in the report parsing functions
by subtracting 128.

The analog trigger axes (ABS_Z, ABS_RZ) are handled separately. Their
resting state is 0 (un-pressed), and their hardware range of [0, 255]
is already the conventional representation. They are left unmodified by
this patch.

This makes the joystick behavior consistent with other gamepad drivers
while preserving the standard behavior for the triggers.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
 drivers/hid/hid-playstation.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 1468fb11e39d..ca5bca9c2654 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -718,11 +718,11 @@ static struct input_dev *ps_gamepad_create(struct hid_device *hdev,
 	if (IS_ERR(gamepad))
 		return ERR_CAST(gamepad);
 
-	input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
-	input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
+	input_set_abs_params(gamepad, ABS_X, -128, 127, 0, 0);
+	input_set_abs_params(gamepad, ABS_Y, -128, 127, 0, 0);
 	input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
-	input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
-	input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
+	input_set_abs_params(gamepad, ABS_RX, -128, 127, 0, 0);
+	input_set_abs_params(gamepad, ABS_RY, -128, 127, 0, 0);
 	input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
 
 	input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
@@ -1349,10 +1349,10 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 		return -1;
 	}
 
-	input_report_abs(ds->gamepad, ABS_X,  ds_report->x);
-	input_report_abs(ds->gamepad, ABS_Y,  ds_report->y);
-	input_report_abs(ds->gamepad, ABS_RX, ds_report->rx);
-	input_report_abs(ds->gamepad, ABS_RY, ds_report->ry);
+	input_report_abs(ds->gamepad, ABS_X,  ds_report->x - 128);
+	input_report_abs(ds->gamepad, ABS_Y,  ds_report->y - 128);
+	input_report_abs(ds->gamepad, ABS_RX, ds_report->rx - 128);
+	input_report_abs(ds->gamepad, ABS_RY, ds_report->ry - 128);
 	input_report_abs(ds->gamepad, ABS_Z,  ds_report->z);
 	input_report_abs(ds->gamepad, ABS_RZ, ds_report->rz);
 
@@ -2272,10 +2272,10 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 		return -1;
 	}
 
-	input_report_abs(ds4->gamepad, ABS_X,  ds4_report->x);
-	input_report_abs(ds4->gamepad, ABS_Y,  ds4_report->y);
-	input_report_abs(ds4->gamepad, ABS_RX, ds4_report->rx);
-	input_report_abs(ds4->gamepad, ABS_RY, ds4_report->ry);
+	input_report_abs(ds4->gamepad, ABS_X,  ds4_report->x - 128);
+	input_report_abs(ds4->gamepad, ABS_Y,  ds4_report->y - 128);
+	input_report_abs(ds4->gamepad, ABS_RX, ds4_report->rx - 128);
+	input_report_abs(ds4->gamepad, ABS_RY, ds4_report->ry - 128);
 	input_report_abs(ds4->gamepad, ABS_Z,  ds4_report->z);
 	input_report_abs(ds4->gamepad, ABS_RZ, ds4_report->rz);
 
-- 
2.51.0.740.g6adb054d12-goog


