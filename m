Return-Path: <linux-kernel+bounces-824582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44230B899B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7B7E0C76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF02F83D4;
	Fri, 19 Sep 2025 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AUS08XtA"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7053112D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287212; cv=none; b=ZQEeAi63loYf1nx6NXrs41xFnN9jr791sKwi4jyrJsC1QLCxUwww0KZ82k/JTp+5DlYc9UyDPJth91YcKkOGjgVoc6TB4fS7crBTNF+QC8DCm41fDMFbecbhJ9BwWJIBH8srXsR3cipgsuJZSxmsD1XS519wr8LO+HSfs0xWdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287212; c=relaxed/simple;
	bh=G4hWA+cTSaVeYPpghA4z9vtC6hi4kszdoPGfJgSFtRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgLA456qE1DXIldekZ7kQWi042e/KR2s8JV3yaqPlBgkDiF4hiMG+zu/T/MlnB2sP6eQ2YkHLChkGYBokWxOJNIpn183rYJrXRNncpRoFak+73Gg/I08ZYrjUk2kRTFpkSSlhsBUBbHXoHvX+AXQ4BLsakAHwJj7K79kdUjjUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AUS08XtA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1802965a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287210; x=1758892010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqd2OsumqXvM1qmIAqFhFCxL6bjWOH+kistJRYcEtxM=;
        b=AUS08XtApgZe93P/1lGF3p+rDcH3FkJRWKvFcooM2N5DuppUwjJl5blryXNys/dYRK
         0TqYtMS0gRWe6h4FgWuyCQqESN91ZdpdMixtlcDyZaK8O0AzmxcpVFEBEbvPGYrqKtre
         u9vYwmvQO9w2XNCdZmSATK+sWGA3WCxPhYxNa9k1saVJmNbxLjZxZsmaowtBTBJZGIqy
         Ks29tZ0ilF2GozhhGnVvYefJ6vVyb2PLZsqaZAJPCUj7yggjXLNrui/BIH9pHwt5GDaS
         9lZaCSGOZryvzM+yRBl6OlKOnob34lqE8iUR1t2tNG14f2VEiYVbknWAD6LOuW2LVTTR
         4iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287210; x=1758892010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqd2OsumqXvM1qmIAqFhFCxL6bjWOH+kistJRYcEtxM=;
        b=IceW3NqVapVPbV5ATyzgvv4iP8h0IljW2kpTEegwBATAttLOarc7UwECCgxcZGwLyB
         J5RHemPjtqapM0uDZ/SiVazHpCX48RzhcskcRMnC564v6Wb1J++0jcr4pxXULOzMGZdY
         MFJNwklWIafSGMSQJ9gpp7No/g7/jwRW7Fn3DLJhUS48XPuTeZvWi0mW31Nm+Zs7f+0y
         VtEoUm0XuRW3p5LhW89AmZJKWo5PNvQZABry9iKy7ykvQaVrQ3GpCIu1ya/pXCFODXac
         rGA7sY1lqhQg3oVvwpfh+EbmHD3Yy5hhxENbOgHnec72dJ++Lz5iisFUNcUPfECM6r01
         9S/w==
X-Gm-Message-State: AOJu0YwOyUBMJNsyYxCzqnXPBp9Hg7QNNeteOgn9xkncNkllIP1P2wMh
	U7gbgxfs0/9dRFzR+pOtwEJhbpeJsVHvj661nyhe8jXebE/nUlbtLM6Dyai4wbo9zyCVBi9reKx
	a8YmF
X-Gm-Gg: ASbGnctkXb0oCBO03ZnHVywRJ0O/TZqN+3UjCrKrtfW0ukBfwOcGVR15Bqj6P+00hnL
	gs3Gr4T9C7wOiomCEV0lRpgcnO7jweUbnLypALrlehHF7qACEKr8e9Fi4YjTz+JYLvAA+aDn2AV
	1Ge+OuujOEX5PV6Zac0+Z/cV9/FT9/0agUwKF2qVj2b1xecuI9ToW8tbrEDRm6DjvzpCY4XRYZC
	q1ePinhpfBn7dKE7uZY+/7w7MVjfI2+4LjJzVYpgG64i8QnRlZ/3I9JLB6tdpsAkvOVQa1ntM/5
	7fwqJB5rLkYegEY3iyjVztPnFjgH9fmdpCYIEGPXpVKhJSUza8z4USvxMLGx8jusJI/F7rlC/vG
	2W3eHDn+r9z/IHY2qDCeuYGXdeG4CyvbH/uK6R9X3iIztLhgOaJgOd8nVmw==
X-Google-Smtp-Source: AGHT+IGsQX4qqfvNoPwWJFUjplN/lur0/YcnCiwcw0BLRN5WPXUAW75RvKgSRYlc7901m8WomTeIKw==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr46562425ad.17.1758287210016;
        Fri, 19 Sep 2025 06:06:50 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:49 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 6/8] mshare: selftests: Add some helper functions for configuring and retrieving cgroup
Date: Fri, 19 Sep 2025 21:06:18 +0800
Message-Id: <20250919130620.56518-6-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before verify some complicated memory functionalities such as swap memory
and THP, we need add some helper functions to configure and retrieve cgroups
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
index a3c3896bd507..f1db4eb3cd8f 100644
--- a/tools/testing/selftests/mshare/util.c
+++ b/tools/testing/selftests/mshare/util.c
@@ -124,3 +124,131 @@ int mshare_ioctl_munmap(int fd, size_t size)
 
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


