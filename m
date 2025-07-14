Return-Path: <linux-kernel+bounces-730030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E8B03F63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEF517A01F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3CA24DCE8;
	Mon, 14 Jul 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="EhRtxneI"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A324C692
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498751; cv=none; b=Abi4YQK69D+APuLeqgzzffUE8wUn8v9hUqgQ50G6sprC4rA6J+8ZcC1s8y7wroCwhLFfJMckAgiPgcw/fCHJjwFRCVVZaa6AT5TabY5TQJRfwFsubP7wh72uAw1XDbdHdeXfzcXG4Ivuh8UFxCA7geJQZBY14mtopHsu2j0iOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498751; c=relaxed/simple;
	bh=uxtVMW5ptGidGGwUzvq6Y9xl6J+S5oSN6o93pQ6Z7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwgOrXfw6N4tbeuqpND2OdLaOcTAGF2E95PE6lE1ryqa50E+WBbEi1VNpIcxxTOIg7deLgfN0e4dDSvnmCqISGtvf5apb+jzSgZO+qLE2OiYOzTu9Yb71eGTLrBv6bKIPEFCRPREnKt493DBfCjUpsCZadr+GSwpALcJkznRVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=EhRtxneI; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1752498748;
 bh=urrC69RSn/xpKnJTpVLILpFXwIJPBmtW775RpQeEWDE=;
 b=EhRtxneITAYOZ/Yren0XdwE2zWeKKP4lRhjl+4AzI35qWdqxuCsWzM8uyrK+OKl8z9eNW9dH+
 ERzojF/6SxamZueH2+yinqi9OoVNlD7JeGtAc/+HXqHmq+W/qxj8TzPzjqoWLVea/NyYjDvyG3L
 YI2f/KXuUA1abg6LpglZ3nyxTLdMwecFfLpeXXgX7TroKEwrZZaOEawN1E6AcEbz4XCLOo2gTIX
 TEtdYP2EvJYLJ4QWf9zYzyS5M9mQ/nOx5MiKPnNp7hIq54M8i5gCfaiP3+f2TcMTKR+j1YHhOrK
 9ox0cYksUbrA4d7mNV1Dy2bI0YIGpkWaRuqgHsqR99lw==
X-Forward-Email-ID: 6875023685526031a5bf8a98
X-Forward-Email-Sender: rfc822; schopin@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH] staging: greybus: fix whitespace alignments in firmware.c
Date: Mon, 14 Jul 2025 15:10:47 +0200
Message-ID: <20250714131101.434301-1-schopin@ubuntu.com>
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


