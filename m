Return-Path: <linux-kernel+bounces-878460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91950C20B21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C3018972AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD9274FC2;
	Thu, 30 Oct 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjB4UwUv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D626CE07
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835380; cv=none; b=Teerj4jtPcS+FQm76y0h8R6fjr3nLJ40VygdpU0FMaM1p5KiZXF/0B0P65a9o5G2TP15PuwMqFns7SdvN7Vh02cFchouZ/nHnypf6KP/H/wfwsb0g3Ff7o0Ue6cMab5o4RMx/pbQvJykc4cjWOcoTRG/ZEB/XRp/8bNsDnTdTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835380; c=relaxed/simple;
	bh=W7F6ofQm9i5OMHMEQLNobUycQ6FyyZZLSn2Kgq7fZWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kaNiMBPVhwwwTniSu2v+NfQ5R2qYKGqK4BIHpyZlrVbQcE+j0sY0hq+uZ6iGbhUG2kk3eboHrEfuG9xm2OtLFvX8ZGY0eDc2DRyu4RPpvaW8IXqj8ZbSVK11/d4KsbiGu2f4G4WtRpn6mK3q2n6lm4uPdSWwxw1u+RaRlFT+njI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjB4UwUv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761835377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7RBY6cRsphyM7Egk+QxIKUUG4SJbeGL2Q7A3V4twLHM=;
	b=KjB4UwUvfHStTDe1pkYVv1OfjEIMgH5yHnIEQOoLGuaSJq4Gw9YCKXBuNgFxFtr/A1PMDE
	V1Fis0cyXLlSLGS44U5pMPlY2V95XiF8ua+OeNSvbOx8KlZhc2tre1p8sGkUHKKUUPkYKi
	1yrnRJJJ1kopVCtPlaNYY5Gt3Lv6BcU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-UzohFTzxMvarRZzSb0O-rw-1; Thu, 30 Oct 2025 10:42:56 -0400
X-MC-Unique: UzohFTzxMvarRZzSb0O-rw-1
X-Mimecast-MFC-AGG-ID: UzohFTzxMvarRZzSb0O-rw_1761835375
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429a7f1ed1bso497769f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835375; x=1762440175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RBY6cRsphyM7Egk+QxIKUUG4SJbeGL2Q7A3V4twLHM=;
        b=lHOhuh048h/AV4uyihMZBPo2Px6J4EH4mpJAuK+Cg6vbaannT3CqJ1qSoPGgo1q/C2
         IWjsyi2+/z9+8hdnJbbkWo60HarxhY1NZR4j/BcpZVXzpLZjzwmQy5Eft6nv1jLkK950
         nwOsq6oyfH6PWvnVR2DHekTY7dla1d9tLkrRCyDHW5qHJe8zcHgjT2uB40xB2GKkQAPL
         pETHIvotG6AwatjvkjU7vuD5B90HwhSd8aIEd3AY2F9/S1/qRq2ozRx5wBUiNR9FrOFe
         12m0ebNRnQGuyqk3miViRzd6XINI+KBc109Hvc/nbz5ZTeQw4FV4LzbmMGVP7qw5EXCY
         6esA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Rx9QQ46eBhQzS5ha5TqCJrWVFIz37Xj9RbWbIG9ivhz/a7Hqa0vuosGI3SrCuLTq+KzDhfL6uufiCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DKSkh5KLlQKc6ANHbOoH4ex+zwK452GB8sF1Zk/Jn1yHVcRk
	7Ngqwbgc1Fevnq9oCu/8SnToDEDcXdvJ4hLeT7oys0ozHZ+TdjfFM3WIyKhpI4mKyWh6kW2J4Br
	2YUy9aSgyFMx3Sb0BwzO+/0cd0TwbkYFMB41Dv3SwW60bky40etZ0wiq3gI4oz8mSFQ==
X-Gm-Gg: ASbGncs+4upQlKOvXZliaCs+xyaP8sA+hOIotqU/IOmkrK1YtzwD8mVlclV/Kk9/JhG
	Bf13yT02WWooy8IO/ZeXeSqqgJWOmzTRThWEeiYzM9NcJ3aidJiMFTGaYg+dYFLcxEkTyk6mGf8
	5kFaUrGaT6NDw5y4I64TDGaW+lyr1YE+b0N1MbXfXQ2l5amwy3OHJALxJ3JdVv7jMOfNhkzEsPk
	U1keV7iDOKuk3RmYjk4Bq3VSOl20bYmTRSvkrXKGIFDih9MZHVfAXA9Jxl+8CsxmktEJZh3Kavn
	E+td22O590M6EwbLuIOCCg692iWv3Z2cFn0GPBO04n2qqiUUkVcvODcPRqyOi38egidAfIURmXp
	PEgMk8cDPkANpVCRt
X-Received: by 2002:a05:600c:6215:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4771e3cb787mr59234005e9.41.1761835374700;
        Thu, 30 Oct 2025 07:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHCgM4Ds9xAAPOUDu/AHE+PrtojCrX8DIjSrcBE/xzmmspk1K0VbazsEIkFHo7lgNZdGqN0A==
X-Received: by 2002:a05:600c:6215:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4771e3cb787mr59233795e9.41.1761835374271;
        Thu, 30 Oct 2025 07:42:54 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289b396dsm42970075e9.11.2025.10.30.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:42:53 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Extract cgroup common code from set_pid_cgroup and set_comm_cgroup
Date: Thu, 30 Oct 2025 16:42:28 +0200
Message-ID: <20251030144231.40058-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set_pid_cgroup and set_comm_cgroup functions have code duplication
for opening cgroup.procs file.

Extract duplicated code into a new helper function open_cgroup_procs().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 68 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb490..fcd8ad98551a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -769,27 +769,24 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 }
 
 /*
- * set_comm_cgroup - Set cgroup to pid_t pid
+ * open_cgroup_procs - Open cgroup.procs file for writing
  *
- * If cgroup argument is not NULL, the threads will move to the given cgroup.
- * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
- *
- * Supports cgroup v2.
+ * If cgroup argument is not NULL, use the given cgroup.
+ * Otherwise, use the cgroup of the calling (rtla) thread.
  *
- * Returns 1 on success, 0 otherwise.
+ * Returns the file descriptor on success, -1 on error.
  */
-int set_pid_cgroup(pid_t pid, const char *cgroup)
+static int open_cgroup_procs(const char *cgroup)
 {
 	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
 	char cgroup_procs[MAX_PATH];
-	char pid_str[24];
 	int retval;
 	int cg_fd;
 
 	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
 	if (!retval) {
 		err_msg("Did not find cgroupv2 mount point\n");
-		return 0;
+		return -1;
 	}
 
 	if (!cgroup) {
@@ -797,7 +794,7 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 				sizeof(cgroup_path) - strlen(cgroup_path));
 		if (!retval) {
 			err_msg("Did not find self cgroup\n");
-			return 0;
+			return -1;
 		}
 	} else {
 		snprintf(&cgroup_path[strlen(cgroup_path)],
@@ -809,6 +806,31 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
 
 	cg_fd = open(cgroup_procs, O_RDWR);
+	if (cg_fd < 0) {
+		err_msg("Failed to open cgroup.procs: %s\n", strerror(errno));
+		return -1;
+	}
+
+	return cg_fd;
+}
+
+/*
+ * set_pid_cgroup - Set cgroup to pid_t pid
+ *
+ * If cgroup argument is not NULL, the threads will move to the given cgroup.
+ * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
+ *
+ * Supports cgroup v2.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int set_pid_cgroup(pid_t pid, const char *cgroup)
+{
+	char pid_str[24];
+	int retval;
+	int cg_fd;
+
+	cg_fd = open_cgroup_procs(cgroup);
 	if (cg_fd < 0)
 		return 0;
 
@@ -838,8 +860,6 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
  */
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 {
-	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
-	char cgroup_procs[MAX_PATH];
 	struct dirent *proc_entry;
 	DIR *procfs;
 	int retval;
@@ -851,29 +871,7 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 		return 0;
 	}
 
-	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
-	if (!retval) {
-		err_msg("Did not find cgroupv2 mount point\n");
-		return 0;
-	}
-
-	if (!cgroup) {
-		retval = get_self_cgroup(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path));
-		if (!retval) {
-			err_msg("Did not find self cgroup\n");
-			return 0;
-		}
-	} else {
-		snprintf(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path), "%s/", cgroup);
-	}
-
-	snprintf(cgroup_procs, MAX_PATH, "%s/cgroup.procs", cgroup_path);
-
-	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
-
-	cg_fd = open(cgroup_procs, O_RDWR);
+	cg_fd = open_cgroup_procs(cgroup);
 	if (cg_fd < 0)
 		return 0;
 
-- 
2.51.0


