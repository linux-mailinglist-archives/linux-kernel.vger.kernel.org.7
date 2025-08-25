Return-Path: <linux-kernel+bounces-785033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A3DB344EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5732A1885360
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF772FDC22;
	Mon, 25 Aug 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gdTzak8L"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45660302CC3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133906; cv=none; b=LbXV4VNCIOR11OCzNskF1uw+0PVZY66MnpShBHoP4svfSM3D/zrBn9hNieFSwq36kMmASoAw+DlmTn/vBd9JjKK6/YD4yXT005Q+7LN0kJ8uwNLTSIaW2p4Zyh8r8FBQ6K9HFROYjKvqzsATkwwUXqGH1LFXO6VC3uOw0Rja6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133906; c=relaxed/simple;
	bh=dMbxmq897CRXL+9wK5op3TWg0dnVjEE/JIek66Xyqvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcSulDiWm+AtlEu1XdJQhcUf1cSaf9DLLSk5x9OJhcttqeXSdi0WQ0rm/JcQT7O1LbVnr6G7o41sdlcQjYbRfWYf+5tiCb49DyOA7sTmAGFVSXYGnqeebsr7FTXYdbRf+Omz+pqm8UcPOGB7ImBRjxMEGL3ynpEnFpuqOfGusc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gdTzak8L; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e4378263so812348b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133904; x=1756738704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=gdTzak8L5/5zYLHB7l3xmmQnZLq5/R3UrnP8rtHV74KHAi4DdiYYwQT6Tfa67rBBsn
         wyFZGnbQgXNoCsiMaYEUYPZkOl79bLv2W0ED8euDrZi3Fhppr062iHn02an5oRVDmglX
         nPZPnGOkkXrJAfWcHSPnOI9skhkyzE8bYZOLB/E7ih0CpbqRftb7xs3AxcqmQUR00PbI
         2tZ5Fgkt8izBo3T5XYpKmNUTSsxOik1rVbuimclCvkLWFLyJRQDcMW2kBEWpaOgG9bPq
         t5zVxVxbjdOrosGMXRymoBB1rjAAQd6SnUE/8G8gnpJwlgE7rVLjcNoHgyXN5DRZTIj7
         7F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133904; x=1756738704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=ljmJbQM0L5/4B+RCbmI2dKIPy0mtv4zNZ7QZn59mSf+JfF5lyzmfwjdUaHSghn7faT
         cH71bpb1rUSuCFRp8tfD093xPH82/v3ZcYpIouTlbn6hX7pfg2zqOKtJ/Aqwj+8Oqpig
         dOYOwmT+rUHJIH8ti9QclUYJAJW5VOSO2Rsq25IXb4gcE53dfpgGNI1busiw7KNPOKPv
         qBrcnUEFE7qqMUKZ6JtvcTjd0ipGifG9NlESycKHMv7f/TCJ8ZPCe7fPGpGbiRHzmbfO
         WHc622aLFoPr4chuRtfBrEDZnCWxYNTTPEwcTtqV6KSiTI/bJmHqj53rGUF1h97fE12r
         zX1Q==
X-Gm-Message-State: AOJu0Yz3RFTL43DMLH4C3dGkpi+wWANsIvu7CpwY1FVxd0F0ERQtnu4K
	M0ekIRwrxCV4+642g9dDK5HZF57MtQYzj2C01lTeOPJWUxlad7HAAKvzBy8gNF4i7Bc=
X-Gm-Gg: ASbGncu8DXEOcYSt4BqvuA6BdRpC9zWxVmId/wJzOGrCJaGs3e7uBeGmnD3ZCJsbnS2
	EYfGChjss+bktSL02LEh96oa4NtuPBu/vIsOs7P2ebp76xZQNhNIvASCPKffNuNuuMcHCni1nmf
	xd2afxMYm9SR5t76A4NU8Gy/9wMIGh9SC62Cc8xXCRWIJZ8aBg2IHVf9/5VwxxGcyqpBurdRCsm
	RjEAyFhSFHvpkFkzGTzwmTiiVk89Q2LEHBCx2lVg/zT3TI7nTtjkT1tbjPvJzdb19p7DIWLN/og
	Jxbkkew0eayaHS6HAlzhvq2tsos7hm+1xRaqk5up5p6Mj9kUKAJCFaGBqF4TbTBh9ObFUYwig+D
	5ZDviIhKl+vc9MvwOafUGB2bKC+79ccUiyyESAgjWVvZDklepK9o8TsiULlsr
X-Google-Smtp-Source: AGHT+IG7Oofc5Cp5x58qIccTW/mt1D9LGI3RCFnvY/URUYZhtnINl3UlS8zIeItcw+B6/b2CMeUqrg==
X-Received: by 2002:a05:6a20:3942:b0:240:d14:c7e3 with SMTP id adf61e73a8af0-24340c1475emr19568752637.24.1756133903397;
        Mon, 25 Aug 2025 07:58:23 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:23 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mshare: selftests: Add some helper functions for reading and controlling cgroup
Date: Mon, 25 Aug 2025 22:57:17 +0800
Message-Id: <20250825145719.29455-15-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before verify some complicated memory functionalities such as swap memory
and THP, we need add some helper functions to controlling the cgroup
(specifically, memcg).

These helper functions consist:
  Create and destroy individual cgroup for test cases
  attach and dettach the test process to specified cgroup
  Read swap size and thp size from testing cgroup

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/util.c | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/testing/selftests/mshare/util.c b/tools/testing/selftests/mshare/util.c
index 75f6ff25aa2c..94fddaea2c56 100644
--- a/tools/testing/selftests/mshare/util.c
+++ b/tools/testing/selftests/mshare/util.c
@@ -121,3 +121,131 @@ int mshare_ioctl_munmap(int fd, size_t size)
 
 	return ioctl(fd, MSHAREFS_UNMAP, &munmap);
 }
+
+/*
+ * Helper functions for cgroup
+ */
+
+#define CGROUP_BASE "/sys/fs/cgroup/"
+#define CGROUP_TEST "mshare-test-XXXXXX"
+
+bool is_cgroup_v2;
+
+__attribute__((constructor))
+void get_cgroup_version(void)
+{
+	if (access(CGROUP_BASE "cgroup.controllers", F_OK) == 0)
+		is_cgroup_v2 = true;
+}
+
+int create_mshare_test_cgroup(char *cgroup, size_t len)
+{
+	if (is_cgroup_v2)
+		snprintf(cgroup, len, "%s/%s", CGROUP_BASE, CGROUP_TEST);
+	else
+		snprintf(cgroup, len, "%s/memory/%s", CGROUP_BASE, CGROUP_TEST);
+
+	char *path = mkdtemp(cgroup);
+
+	if (!path) {
+		perror("mkdtemp");
+		return -1;
+	}
+
+	return 0;
+}
+
+int remove_cgroup(char *cgroup)
+{
+	return rmdir(cgroup);
+}
+
+int write_data_to_cgroup(char *cgroup, char *file, char *data)
+{
+	char filename[128];
+	int fd;
+	int ret;
+
+	snprintf(filename, sizeof(filename), "%s/%s", cgroup, file);
+	fd = open(filename, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	ret = write(fd, data, strlen(data));
+	close(fd);
+
+	return ret;
+}
+
+int attach_to_cgroup(char *cgroup)
+{
+	char pid_str[32];
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	return write_data_to_cgroup(cgroup, "cgroup.procs", pid_str);
+}
+
+/*
+ * Simplely, just move the pid to root memcg as avoid
+ * complicated consideration.
+ */
+int dettach_from_cgroup(char *cgroup)
+{
+	char pid_str[32];
+	char *root_memcg;
+
+	if (is_cgroup_v2)
+		root_memcg = CGROUP_BASE;
+	else
+		root_memcg = CGROUP_BASE "memory";
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	return write_data_to_cgroup(root_memcg, "cgroup.procs", pid_str);
+}
+
+size_t read_data_from_cgroup(char *cgroup, char *file, char *field)
+{
+	char filename[128];
+	FILE *fp;
+	char line[80];
+	size_t size = -1;
+
+	snprintf(filename, sizeof(filename), "%s/%s", cgroup, file);
+	fp = fopen(filename, "r");
+	if (!fp) {
+		perror("fopen");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (!strncmp(line, field, strlen(field))) {
+			char *value = line + strlen(field) + 1;
+
+			size = atol(value);
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	return size;
+}
+
+size_t read_swap_from_cgroup(char *cgroup)
+{
+	if (is_cgroup_v2)
+		return read_data_from_cgroup(cgroup, "memory.stat", "pswpout");
+	else
+		return read_data_from_cgroup(cgroup, "memory.stat", "swap");
+}
+
+size_t read_huge_from_cgroup(char *cgroup)
+{
+	if (is_cgroup_v2)
+		return read_data_from_cgroup(cgroup, "memory.stat", "file_thp")
+		     + read_data_from_cgroup(cgroup, "memory.stat", "anon_thp")
+		     + read_data_from_cgroup(cgroup, "memory.stat", "shmem_thp");
+	else
+		return read_data_from_cgroup(cgroup, "memory.stat", "rss_huge");
+}
-- 
2.20.1


