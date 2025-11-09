Return-Path: <linux-kernel+bounces-892121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C4C44629
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92F8188B8D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42E22A7E9;
	Sun,  9 Nov 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="q+/NYAGA"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061BDF59
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716507; cv=none; b=ClKdAcACRpvT/3xaLabo/Xr5+NDc2idv23DJpDI8VHbK+0N9m4r2VADFb5jMBEEBvjXYJzTgEwpQbIGCtDYNzFJNCYh9RH2hmy6ZDx3JAC0sUxlUK49gTzjaPEeznCEIYSbXzWo6T/KQRgA6jnG8+XJsFgPptCBT1sWOL3dAkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716507; c=relaxed/simple;
	bh=pC0VLFZsf8G2B62bdNWPT+MgWwzx5QtGXcbHVTZwVlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GfyndaDEIXN/5MAVZ1VKB55a4j51CF/YSVyKb1Wfy89EnmJpoUu6CRQqWzeEPxmNUhdQAuA6K58IePYvd/Iu0OnVsn18muqAuMD7DPBKpcz7ALlTUmzoN/o9xXyUY8hcMmxTurlkHtX4G4b9pHcS86kwJq5Fgu1UAUuH5QDxxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=q+/NYAGA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762716496;
	bh=pC0VLFZsf8G2B62bdNWPT+MgWwzx5QtGXcbHVTZwVlU=;
	h=From:Date:Subject:To:Cc:From;
	b=q+/NYAGAFqPSyydyjiU/Mkn2O9ty9reoWuZ6/sXjRIwII7CEJvJSW1KCZpa7zCN4m
	 Js59WKql96LVTAd02QCu4vbPM0Cun73oLWp+7J4uvEdRUzUV+ehTisSZCPhf5V1bCB
	 WG2YjNyoxILZvxt5eZuzaFWjd0tc1Sz7wlEMcbrQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Nov 2025 20:27:29 +0100
Subject: [PATCH] tools/nolibc: avoid using plain integer as NULL pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251109-nolibc-sparse-v1-1-02256638a99c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACDrEGkC/x3MTQqAIBBA4avIrBNU+qGuEi1MxxoIFQcikO6et
 PwW71VgLIQMi6hQ8CamFBt0J8CdNh4oyTeDUWbQykwypot2Jznbwiid7gOqUc/oHbQmFwz0/L9
 1e98P+/HX2V8AAAA=
X-Change-ID: 20251027-nolibc-sparse-c14fe0619edc
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762716494; l=3273;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pC0VLFZsf8G2B62bdNWPT+MgWwzx5QtGXcbHVTZwVlU=;
 b=LCKs0CrqxLl2sHQMoBEjOLB3Jt1rXLrwHgBI3BPv7i8WJN87f6vv2YEYubB8XlZUbmla52Nki
 +9qcdPJ6XomBo+rVFWnmLr34BW+uXPID9+so/pwPKfiE8W2y5x2tpyv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The integer zero should not be used as NULL pointer.
It is invalid and sparse will complain about it.

Use proper NULL pointers instead.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/getopt.h     | 2 +-
 tools/include/nolibc/sys.h        | 2 +-
 tools/include/nolibc/sys/reboot.h | 2 +-
 tools/include/nolibc/unistd.h     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
index 217abb95264b..87565e3b6a33 100644
--- a/tools/include/nolibc/getopt.h
+++ b/tools/include/nolibc/getopt.h
@@ -78,7 +78,7 @@ int getopt(int argc, char * const argv[], const char *optstring)
 		return '?';
 	}
 	if (optstring[i] == ':') {
-		optarg = 0;
+		optarg = NULL;
 		if (optstring[i + 1] != ':' || __optpos) {
 			optarg = argv[optind++];
 			if (__optpos)
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 28481feedb37..fcc36cffad4d 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -106,7 +106,7 @@ static __attribute__((unused))
 void *sbrk(intptr_t inc)
 {
 	/* first call to find current end */
-	void *ret = sys_brk(0);
+	void *ret = sys_brk(NULL);
 
 	if (ret && sys_brk(ret + inc) == ret + inc)
 		return ret + inc;
diff --git a/tools/include/nolibc/sys/reboot.h b/tools/include/nolibc/sys/reboot.h
index 4a1e435be669..38274c64a722 100644
--- a/tools/include/nolibc/sys/reboot.h
+++ b/tools/include/nolibc/sys/reboot.h
@@ -28,7 +28,7 @@ ssize_t sys_reboot(int magic1, int magic2, int cmd, void *arg)
 static __attribute__((unused))
 int reboot(int cmd)
 {
-	return __sysret(sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0));
+	return __sysret(sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, NULL));
 }
 
 #endif /* _NOLIBC_SYS_REBOOT_H */
diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 7405fa2b89ba..bb5e80f3f05d 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -54,7 +54,7 @@ int msleep(unsigned int msecs)
 {
 	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
 
-	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+	if (sys_select(0, NULL, NULL, NULL, &my_timeval) < 0)
 		return (my_timeval.tv_sec * 1000) +
 			(my_timeval.tv_usec / 1000) +
 			!!(my_timeval.tv_usec % 1000);
@@ -67,7 +67,7 @@ unsigned int sleep(unsigned int seconds)
 {
 	struct timeval my_timeval = { seconds, 0 };
 
-	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+	if (sys_select(0, NULL, NULL, NULL, &my_timeval) < 0)
 		return my_timeval.tv_sec + !!my_timeval.tv_usec;
 	else
 		return 0;
@@ -78,7 +78,7 @@ int usleep(unsigned int usecs)
 {
 	struct timeval my_timeval = { usecs / 1000000, usecs % 1000000 };
 
-	return sys_select(0, 0, 0, 0, &my_timeval);
+	return sys_select(0, NULL, NULL, NULL, &my_timeval);
 }
 
 static __attribute__((unused))

---
base-commit: 107eb8336e8782ae8e98b60962852a1e29aca715
change-id: 20251027-nolibc-sparse-c14fe0619edc

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


