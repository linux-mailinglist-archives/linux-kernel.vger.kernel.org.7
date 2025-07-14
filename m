Return-Path: <linux-kernel+bounces-730091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BAB04023
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606583B55DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0AE256C6D;
	Mon, 14 Jul 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="UJsfbsV0"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73724EA9D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499921; cv=none; b=SprgrHuh8M07TkoLrs2QA5EHs0VjZ41wKDGwsehTHrIjzDalWgey/PNwAfpW5CjHCdNfAXB/H+UuWoeRaWlGagpBSDc2rRkv0XmkK8/6apsrvZ1PvKA6PWAPD8ucojCW1q2WPAurZXjok+wc+0/4NttxZPXM+WU6Ni7yoKx189g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499921; c=relaxed/simple;
	bh=+NdcW4brtmmXfHJrbIWAdZQSmcJK1gkNBsuYeS6Cqvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTGXheYORxkWizZFgg6rkGcT8ICp9uV5FdN4FLiyD3x6QGhvKolZPY4t94qWGkcWAM+b2NiQGuO7XvzzLLvkaGKXE9ja3BQWIE4g1Xb1esf3IGBlPylmBUqWh4bq9kCAiFW4//RnxLJ6tSvx0v1X4LelVKDd5txm8EJu1/yQLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=UJsfbsV0; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1752499917;
 bh=EUP3YEzDD6Id6ZhB1Y6hZ/zaBctkExpb8qNgPN1Ya60=;
 b=UJsfbsV0uZ/rPDAIfj+oRUB38S6gFZ+UybNfe8otILmgpQX7PrxjlBzHyAjIfP5beZoYz+twL
 vkTM6jJD3YyUXK2LstEHHQJStuWBzcmSHiVgxD6p8qO6gt9iHh9X1/zrhiVke6FjF0zLyri6KlZ
 oNpwWnyD7OKRFOOCb54d7h/qmLEwYWBycgS17A1z9r5Qi82BIxm8FIAN+BcDjuNt5YhqOFNSiN4
 sBxVzAhk0O6AljLDJxnD0oV61agebGFo8PLX9GE8TW4bLZRjBxCFWlK4QoOK8HqxAEF9pwFy7ls
 SXfd32wAeIU80TaQ4xjXjo+kUy1tyeAByASK7Fv33c2w==
X-Forward-Email-ID: 687506cb85526031a5bfa407
X-Forward-Email-Sender: rfc822; schopin@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Simon Chopin <schopin@ubuntu.com>
To: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Simon Chopin <schopin@ubuntu.com>
Subject: [PATCH v2] staging: greybus: Documentation: firmware.c: fix whitespace alignments
Date: Mon, 14 Jul 2025 15:31:33 +0200
Message-ID: <20250714133148.442401-1-schopin@ubuntu.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This addresses all instances of the checkpatch.pl warning
"CHECK: Alignment should match open parenthesis"
in this file.

Signed-off-by: Simon Chopin <schopin@ubuntu.com>

---

This patch was created as part of the "Submit your first
contribution to the Linux kernel" workshop at Debconf 25.

changed in v2:
* commit title amended to mention Documentation
---
 .../greybus/Documentation/firmware/firmware.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/greybus/Documentation/firmware/firmware.c b/drivers/staging/greybus/Documentation/firmware/firmware.c
index 765d69faa9cc..b27d425c5c06 100644
--- a/drivers/staging/greybus/Documentation/firmware/firmware.c
+++ b/drivers/staging/greybus/Documentation/firmware/firmware.c
@@ -47,12 +47,12 @@ static int update_intf_firmware(int fd)
 	ret = ioctl(fd, FW_MGMT_IOC_GET_INTF_FW, &intf_fw_info);
 	if (ret < 0) {
 		printf("Failed to get interface firmware version: %s (%d)\n",
-			fwdev, ret);
+		       fwdev, ret);
 		return -1;
 	}
 
 	printf("Interface Firmware tag (%s), major (%d), minor (%d)\n",
-		intf_fw_info.firmware_tag, intf_fw_info.major,
+	       intf_fw_info.firmware_tag, intf_fw_info.major,
 		intf_fw_info.minor);
 
 	/* Try Interface Firmware load over Unipro */
@@ -69,20 +69,20 @@ static int update_intf_firmware(int fd)
 	ret = ioctl(fd, FW_MGMT_IOC_INTF_LOAD_AND_VALIDATE, &intf_load);
 	if (ret < 0) {
 		printf("Failed to load interface firmware: %s (%d)\n", fwdev,
-			ret);
+		       ret);
 		return -1;
 	}
 
 	if (intf_load.status != GB_FW_U_LOAD_STATUS_VALIDATED &&
 	    intf_load.status != GB_FW_U_LOAD_STATUS_UNVALIDATED) {
 		printf("Load status says loading failed: %d\n",
-			intf_load.status);
+		       intf_load.status);
 		return -1;
 	}
 
 	printf("Interface Firmware (%s) Load done: major: %d, minor: %d, status: %d\n",
-		firmware_tag, intf_load.major, intf_load.minor,
-		intf_load.status);
+	       firmware_tag, intf_load.major, intf_load.minor,
+	       intf_load.status);
 
 	/* Initiate Mode-switch to the newly loaded firmware */
 	printf("Initiate Mode switch\n");
@@ -108,12 +108,12 @@ static int update_backend_firmware(int fd)
 	ret = ioctl(fd, FW_MGMT_IOC_GET_BACKEND_FW, &backend_fw_info);
 	if (ret < 0) {
 		printf("Failed to get backend firmware version: %s (%d)\n",
-			fwdev, ret);
+		       fwdev, ret);
 		return -1;
 	}
 
 	printf("Backend Firmware tag (%s), major (%d), minor (%d), status (%d)\n",
-		backend_fw_info.firmware_tag, backend_fw_info.major,
+	       backend_fw_info.firmware_tag, backend_fw_info.major,
 		backend_fw_info.minor, backend_fw_info.status);
 
 	if (backend_fw_info.status == GB_FW_U_BACKEND_VERSION_STATUS_RETRY)
@@ -122,7 +122,7 @@ static int update_backend_firmware(int fd)
 	if ((backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_SUCCESS)
 	    && (backend_fw_info.status != GB_FW_U_BACKEND_VERSION_STATUS_NOT_AVAILABLE)) {
 		printf("Failed to get backend firmware version: %s (%d)\n",
-			fwdev, backend_fw_info.status);
+		       fwdev, backend_fw_info.status);
 		return -1;
 	}
 
@@ -148,10 +148,10 @@ static int update_backend_firmware(int fd)
 
 	if (backend_update.status != GB_FW_U_BACKEND_FW_STATUS_SUCCESS) {
 		printf("Load status says loading failed: %d\n",
-			backend_update.status);
+		       backend_update.status);
 	} else {
 		printf("Backend Firmware (%s) Load done: status: %d\n",
-				firmware_tag, backend_update.status);
+		       firmware_tag, backend_update.status);
 	}
 
 	return 0;
@@ -185,7 +185,7 @@ int main(int argc, char *argv[])
 		fw_timeout = strtoul(argv[4], &endptr, 10);
 
 	printf("Trying Firmware update: fwdev: %s, type: %s, tag: %s, timeout: %u\n",
-		fwdev, fw_update_type == 0 ? "interface" : "backend",
+	       fwdev, fw_update_type == 0 ? "interface" : "backend",
 		firmware_tag, fw_timeout);
 
 	printf("Opening %s firmware management device\n", fwdev);

base-commit: 1b0ee85ee7967a4d7a68080c3f6a66af69e4e0b4
-- 
2.48.1


