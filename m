Return-Path: <linux-kernel+bounces-844745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C7BC2A76
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CED374E384C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBE8227E82;
	Tue,  7 Oct 2025 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLvQ+COn"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3244218AB4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869373; cv=none; b=KIC3lLN3P9Jq21TV9NBv69qdZsjUb2BZSSDIiRczd+DP16iVw72R07b8oJ1EiAiV5llB7aSMzD3c1/FfGzErGRpA+SyQoZ7zcDq01zd3UltXVobHeviBkUgnzXZXgx/benlTHAjGeQE2GXA5xwsw/yKPKGlhvGuToXOZ23hjzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869373; c=relaxed/simple;
	bh=X30O3tuyaGnUdYn4ZevXlMz7qK4brBb8HMxNaffjlTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMVLt7+f0FLmQUH6H1hoEH9A5pqrf07JOq4pA6fVb9XvG+PA4eneDqO99mB69aE0iQTkcltMObsinf7X9gH7ZatDKn1tx287EhQuNfvsYSS1d9w14MYhwbDIVcH3582PUMOTYmEH5xaRqFPqiRof4AdvJHoA8Pr4FEcxwWoUlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLvQ+COn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-421851bcb25so3582399f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759869370; x=1760474170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwcpw0zy4R46b7XzPVyh5saCrP79aFOpHXUMlFp84UE=;
        b=GLvQ+COnWwysbYu9qXh2CDzHK2PLnluNwyQUiURSDjMv9aiMdFVCktxx+Pu6g6Sgc2
         JaaLdj32OI091+GkjdnFzXjeaOei6OHZzSkFilzBC1lr90gOpWsiu4btmV58G22P8Djc
         mb89+4LcAcC9NxKVGGT/C0SfNxGD0BiZYq8LgFpAzsfFgkq9QEb5aXnWO5sqvzcWIpUv
         jZlDBvQz/s00izscGRthts2eUv8ZfSfVAjFG+peEcaHTadrzNImKx2ZZ5bV77ZHxyOX1
         LDZC8OuyelwohZ3Gp5wXEZRjs1grYx73uTAQ6q56YScgXmMwUHtktVWVp1YYf9mg4gGz
         30Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869370; x=1760474170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mwcpw0zy4R46b7XzPVyh5saCrP79aFOpHXUMlFp84UE=;
        b=aPh2BfDiEK70WL62xUqhofcriOhp/9muZ/VslJlmmuxTXSDmmK36ekFCTIvh+IVjLm
         ozk1l6/efPEzvdye3rxdGjyw3V6Ap9Vv4IZwlawDNdZJxaLvZdBiMj/mQ6sbywxRVC9v
         fB4FFR+6QZjSoC21mXz1VuSG3wUwYTv/wG7kABe3YerTHhb1LQckfwN/BY4mMs/q6OjW
         T1ppcA3DMiWjlTglpMwsT62H0j8xFnp5J7eU/8s0+xP465IZqdZrUQ/E/zt+Sp9jndLz
         3QMc7axCX0+ZKnGl8wRfQ2Ew++M1Rv27K/dPP3E/ReDhiH5CQb6dJ5eDs/EqnVMB/TUR
         /nWA==
X-Gm-Message-State: AOJu0YwLAIGDDviBbvXnJGS6tKld4sEbNHMMlt7hqM+SBkHjaUcfaO7c
	8tsnql8S6YjuhIFlYKu16LOn1x6QdpVaWNrMCSjshvW4U1X19hWtuBx0VP43Tvw=
X-Gm-Gg: ASbGncttgpgKU12Q11cLovyDj3K+SEwuXgL3mxRmlcWvvtpf7wUJCKLA0j2N/5QD/Up
	zhHzVqJ7xOsKbdgGe5lGBVCwoU9Gs0gRIZl3L+q7I1NMVBpFCpMt6ioolhfePMWeW+KDqhjuGCt
	OApdeMwLyr+41OW7zANB4K84s5LAcu1q1qtAQ+piY+CnexMgPmo+kqIM27xGkzesxRTVPt3DfBE
	/L221+qfpx0dhrXJiLQna3ehmEygX6+eLaFdNnpTVgOl5NZ8ncjhiG5VqwUmJbVnJACheiSsFuF
	GHGRFB7EEG9UtG+uzIh0FR7fJXDyQ2OZguOF96Lptf+i8O5nWwTnzjzy5l6DdgOg0Y4KsEqU2We
	bzNE9pmTJOWLWpmuYzHWbIlA6yNFKxhh7q1agIXW4UKkzjwb7fABAbUPimady+rEy9hgRe4cJ7V
	1dyxWIHU2dWgwQuIyw
X-Google-Smtp-Source: AGHT+IGPLtE8dj0u0tUPLyujq1JtdE0ZsW+bW3gJIuAcpvuOgESONWNsIxWyKFgjZ67CUoGoms/o1w==
X-Received: by 2002:a05:6000:240d:b0:421:a112:4010 with SMTP id ffacd0b85a97d-4266e8e8f53mr421505f8f.55.1759869369892;
        Tue, 07 Oct 2025 13:36:09 -0700 (PDT)
Received: from DESKTOP.home (188-23-144-33.adsl.highway.telekom.at. [188.23.144.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf94ddsm8016005e9.2.2025.10.07.13.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 13:36:09 -0700 (PDT)
From: Benedek Kupper <kupper.benedek@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bentiss@kernel.org,
	jikos@kernel.org,
	Benedek Kupper <kupper.benedek@gmail.com>
Subject: [PATCH] drivers: hid: renegotiate resolution multipliers with device after reset
Date: Tue,  7 Oct 2025 22:35:44 +0200
Message-ID: <20251007203544.9963-1-kupper.benedek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scroll resolution multipliers are set in the context of
hidinput_connect(), which is only called at probe time: when the host
changes the value on the device with a SET_REPORT(FEATURE), and the device
accepts it, these multipliers are stored on the host side, and used to
calculate the final scroll event values sent to userspace.

After a USB suspend, the resume operation on many hubs and chipsets
involve a USB reset signal as well. A reset on the device side clears all
previous state information, including the value of the multiplier report.
This reset is not handled by the multiplier handling logic, so what ends up
happening is the host is still expecting high-resolution scroll events,
but the device is reset to default resolution, making the effective,
user-perceived scroll speed incredibly slow.

The solution is to renegotiate the multiplier selection after each reset.

This is not the only bug related to the high-resolution scrolling
implementation in the kernel (the other one is
https://bugzilla.kernel.org/show_bug.cgi?id=220144), but for this one,
there is no device side workaround for,
leading to poor user experience with our product:
https://github.com/UltimateHackingKeyboard/firmware/issues/1155
https://github.com/UltimateHackingKeyboard/firmware/issues/1261
https://github.com/UltimateHackingKeyboard/firmware/pull/1355
This patch was tested by an affected user and has been reported to
fix the issue (see discussion in 1355).

Signed-off-by: Benedek Kupper <kupper.benedek@gmail.com>
---
 drivers/hid/hid-generic.c | 9 +++++++++
 drivers/hid/hid-input.c   | 7 +++++++
 include/linux/hid.h       | 1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index 9e04c6d0fcc8..c2de916747de 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -70,6 +70,14 @@ static int hid_generic_probe(struct hid_device *hdev,
 	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 }
 
+static int hid_generic_reset_resume(struct hid_device *hdev)
+{
+	if (hdev->claimed & HID_CLAIMED_INPUT)
+		hidinput_reset_resume(hdev);
+
+	return 0;
+}
+
 static const struct hid_device_id hid_table[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
 	{ }
@@ -81,6 +89,7 @@ static struct hid_driver hid_generic = {
 	.id_table = hid_table,
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
+	.reset_resume = hid_generic_reset_resume,
 };
 module_hid_driver(hid_generic);
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f45f856a127f..3dd3822cc549 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -2382,6 +2382,13 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
+void hidinput_reset_resume(struct hid_device *hid)
+{
+	/* renegotiate host-device shared state after reset */
+	hidinput_change_resolution_multipliers(hid);
+}
+EXPORT_SYMBOL_GPL(hidinput_reset_resume);
+
 #ifdef CONFIG_HID_KUNIT_TEST
 #include "hid-input-test.c"
 #endif
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2cc4f1e4ea96..b78fb55ea85e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -953,6 +953,7 @@ extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct h
 extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
 extern int hidinput_connect(struct hid_device *hid, unsigned int force);
 extern void hidinput_disconnect(struct hid_device *);
+void hidinput_reset_resume(struct hid_device *hid);
 
 struct hid_field *hid_find_field(struct hid_device *hdev, unsigned int report_type,
 				 unsigned int application, unsigned int usage);
-- 
2.43.0


