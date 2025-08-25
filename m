Return-Path: <linux-kernel+bounces-785019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169EB344CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF453B9EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E152E2FE05B;
	Mon, 25 Aug 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JFh7CXIU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D882FE060
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133875; cv=none; b=mUww3HoeL/mwmQHkAU2jWjbrU2rk0rVP1DixTGyZmEo5VJEuX78PxzRYbinqZRduxxGwJrJU4gfL57wLleTAgMjaXVT3P2QkqTkCXDPQ8VuG7samiwfTBwD2weT30QUvnZQLAndSwOuxKI/qRYoUME3suTuF4UEhrC63oXPPZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133875; c=relaxed/simple;
	bh=dMbxmq897CRXL+9wK5op3TWg0dnVjEE/JIek66Xyqvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e93r+K5jlDUyrLhUw3LavFmy6pSg016PVj2cR1VO8jGY5l1Gld2sGUBeQsAuYh4bgW3Xq6IBtznFZiYh9TdIo0LtUglp+BJ3VqoS5EIfg96yOJTMi8P0EVmx6rvEDyzs7Wf7RU9vVBZPST37q0Ac6sZ3KFQcwZjE933W4jAqxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JFh7CXIU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso3869990b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133873; x=1756738673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=JFh7CXIUbY8pui0NTsgTwytFbIbm4tAWV3790iBfEzgX/TU1fwgocgwl3QOg+xF3ZR
         CAEIhXq81MPbJC24oLO0XA+pmvx727dOpluFx1fFjyf6PrGJV5/DCcjtzK0FPmT38aqh
         NA83lX07wY4F+M//i3nBqOsk/xVyb2eYlDtXiAgcCjJQT9hXMWq1CbA41d62GoyBqqCY
         0dJw5OrBVauUWQR01VYiTvIrnzj28ctCzDN5xCA79yr+kG+bF8Zn4t08r9L0F6LDqKgM
         7IYNXrfb3b6ZbLrhWLSZcQP/mEiBQwunlVb+qDkdf5IxfcokW90A7UIa9jqLx1X8tpUB
         Ravw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133873; x=1756738673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=pl+1nbrAl1J8Bnz1PLT38hOyp+cRa6fWT1w0ncvHTtvrmUWsat4E/SwzytLQc0+e5H
         a+i6pQJwzF1R6On0E3Y5lE8uQBWa4fI6PXwCs1uF52ocHhc0FdDo1iHg+PQKba66zQuw
         jL5wfnUn0t58n801TCDUva+Xq9iHzQjx4/BY6hYZKtcAQarghBziridfxoPQhEFE/gZ4
         u4IbZZ+Hd5EiO2KLJavl8xbPw/f67s82gkiJ09jCVp5lan+bM+N8pBgfgWey4STobtft
         bfl3ZDBZZqVWkrm1nTenlfCuodkPFz70BWfIvCNop06x9P3cv0yqlp0kZ5djl3Vq0drF
         2BAw==
X-Gm-Message-State: AOJu0Yxgyodgk+YndDh/LMgBNAm8RSHC5QDe5lvDnS79Ex75SMoPEwcm
	jCIcmzoiixwVcL23SvDCDEw2kP9bH+8BdU7lj+2cngW0Z//tkjoxeNNmxYuYvbmpNBE=
X-Gm-Gg: ASbGncsof3l3Vuh3AUNFWxN1tfvUNMBAi79TzQlzYFwEDKPturEKUIVD/5JX+NIfyuN
	pAOA1S6uxMBwMjz1zASvxyCjil33vwrzHKw1YQfmMiSr8l6KumRxLc+6gAEPI39fTeL0gddfXLo
	XLjHqjbrc/dY/oST4m4yCBRiwI91Gwitll9yqAosVHqOHulYM+bBxZKH9PAbjz9ZvW8N6u0L8ff
	/RBX7JHvdSybbEE4Js/zmtUE/ksRQTZMNTQ37VEu7+BvKUgq1opTuizWBkZwhkTrM6+oMQ9sBt8
	8GH8za1hjjYubYhNuzQMhSeq+4+hQ8yGRKTqSmoYFVPXSHbCJrwNdalhU4tq0ovnnSqN6E1Eu6+
	mB/WFkzF92ZBa/XCnjA/THaRw2VhVyFgUlxmuBAktUuhNbivgyRFICnyEBfS65ChV4EfD0Zs=
X-Google-Smtp-Source: AGHT+IFN3XgZGUydfFw4/mbd3YmT+QXstnE6CrDDlxBYxDb55CdCB22fpDRPMIk2g4/sSsJBoMDeZg==
X-Received: by 2002:a05:6a20:734c:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-24340b5e298mr17551742637.19.1756133872732;
        Mon, 25 Aug 2025 07:57:52 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:52 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:09 +0800
Message-Id: <20250825145719.29455-7-linyongting@bytedance.com>
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


