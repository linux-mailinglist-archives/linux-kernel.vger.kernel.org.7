Return-Path: <linux-kernel+bounces-855126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C428BBE04F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A55234E5671
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AF30BB86;
	Wed, 15 Oct 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe2hnpX1"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556463043D7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555320; cv=none; b=boBsmiCW2XcsowkGrytbUniabE87biRbwc36I1yZJmWpUihxe3icMZXyD/2e7/U/UILyMC2vwU75EjMS9GgV4P2lmqcG6bKZBNvTxpx3axYkETF/zboMKGk+cvrZPNQaJxPYlx2Nlwq3VkL58WbhfOyXfIzllNnYXgLMTbwHEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555320; c=relaxed/simple;
	bh=dy/nxHNfK9JLsq/wUJoJjg9iuGlOj2VZFEhQ/YFK11s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM9okez4ejOH/LyVMFGRKTUGVIlRuEIotoO8acgKjk10nXrpOFrsHBSBJxyK0S3UON8sXazvjZ+FSahNqWCtpuycCrA8183mJJpo0ld+UnECIEs3l25teAixZDFoB6HLh2RAupmY9hBANUdN8a6cK9JeL3WkVGIINl0QON1XVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe2hnpX1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7930132f59aso9295134b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555318; x=1761160118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jtTseR4AzpCPkYXmfSeMBcpg1TsK/YhbPk71+4USG4=;
        b=Fe2hnpX1twzorIGhR5kZ9ppyDDFQXWoLEitED8PkXw96zvGQ5dzq96hcIbE5Ozwejk
         e1JpNrIfvCa+BU3IhPn2HdhltkRuCqdZhR3UQ1fNMZgruGRelMGChRtwmzpgNlcMv5TC
         V498tWpxaBg4rN6o3g+fx2slIhdE5sAyTOmPLiuQp8froTnJHlvhBxt6jDBgHWW49sIU
         igugNQzKNVu+Ax6NEo29Tc5RGMzYBiDiu4potmKxrZXDNkPAzSRcym8XxRazYLWvuiWM
         Juaz1uBnyaREGSPkH9buyYqkhAUaxHbVR18N/QIc8k2tiWgdmuNJLC21zCo0wEkjujdV
         DUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555318; x=1761160118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jtTseR4AzpCPkYXmfSeMBcpg1TsK/YhbPk71+4USG4=;
        b=M655ra8CLxRGa4b3t24qZ8qejo1wyZlXorcV1on0femS8mD4FY+sY2DkAOlfnaYcPA
         5ghbeRPJ0Ygf63r4NsJ0cl0r5Bk+/9f+5vUIx5K7IkZbPDQGUSxgSZRfhdReGz6CsvPB
         lRODAPcsogA/dmeKWn+TRjJDFoS41kXP79lnlzRIeyJXmw5XcE0ZkFf2L/fcmI+QxexK
         +E/rSnBYBSWmhn1GfzUsF6DeNa6C4yS7uom6oieZvES9P4QehknLvj7QtmrEotoB6aXG
         4UK3vrr9m7Xvv18iFSyroxbTsaelWXnt7Z41DfFxTyvpaVhrmM3waPqaFC5j/ijSt4jj
         5i2Q==
X-Gm-Message-State: AOJu0YxejM6Jm5Wmz8e6svkTbLubE0xmqhZjO2cMPXhfafVL2xymORUN
	C6TgLopi2qWNsuN2wo+SnCIxumnN6b0AEqH9YTwDwJifHS48Hjlr5Ebm
X-Gm-Gg: ASbGncu9TdF+FOJXjCZnY43F61uXoDAl5MD8q1SugjfHqrg8zd6lxQU+kEAWQ00XF/l
	n572nKKDS/riph2CAmq1M916yyyoGyePj3y4zy81ElxFz4NWhHLAZLTOol7UsfW9EBMpskAf3Lv
	DJ35pC+1xHmx3ZbVGghOVR5VKhuSUz/JHCdeuswXNjkNHHsfxLMr938Hpbu2mfTJ8c/6OTsME1A
	aA0pZR5+UQypO8yxDWqTnXkV20F4G3quA5UU7aSfUtTKq1/uXBtK56SlYZQfBIjjF2cR0FvuK/v
	Iee/AXwlxi5UolzYlKqRr8oCAaVZcFyhWAkvdtQiNvBaYwQbLzZm49hhx9WHtEykVq/sPIoXg5a
	IAiCtmVHi4/5p1WciaaZO0Q4uEcTzHxbtk8l6lOGXKXPHkXrCfvFsJxJqtreGaMx6WWkewRw7nM
	eBFlSk
X-Google-Smtp-Source: AGHT+IFk0KEOhu/r0D+eCv5Ze6uXH3k3mw8nLse3HDIgRrBhuzKLo4na23l7qUwdjNYl5QryCDzGtg==
X-Received: by 2002:a05:6a00:14c1:b0:78c:994a:fc87 with SMTP id d2e1a72fcca58-793853254c5mr39312586b3a.6.1760555317735;
        Wed, 15 Oct 2025 12:08:37 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:1069])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm19483106b3a.69.2025.10.15.12.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:08:37 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 2/2] memcg: selftests for memcg stat kfuncs
Date: Wed, 15 Oct 2025 12:08:13 -0700
Message-ID: <20251015190813.80163-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015190813.80163-1-inwardvessel@gmail.com>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test coverage for the kfuncs that fetch memcg stats. Using some common
stats, test before and after scenarios ensuring that the given stat
increases by some arbitrary amount. The stats selected cover the three
categories represented by the enums: node_stat_item, memcg_stat_item,
vm_event_item.

Since only a subset of all stats are queried, use a static struct made up
of fields for each stat. Write to the struct with the fetched values when
the bpf program is invoked and read the fields in the user mode program for
verification.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 295 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
 3 files changed, 374 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

diff --git a/tools/testing/selftests/bpf/cgroup_iter_memcg.h b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
new file mode 100644
index 000000000000..5f4c6502d9f1
--- /dev/null
+++ b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef __CGROUP_ITER_MEMCG_H
+#define __CGROUP_ITER_MEMCG_H
+
+struct memcg_query {
+	/* some node_stat_item's */
+	long nr_anon_mapped;
+	long nr_shmem;
+	long nr_file_pages;
+	long nr_file_mapped;
+	/* some memcg_stat_item */
+	long memcg_kmem;
+	/* some vm_event_item */
+	long pgfault;
+};
+
+#endif /* __CGROUP_ITER_MEMCG_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
new file mode 100644
index 000000000000..264dc3c9ec30
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include "cgroup_helpers.h"
+#include "cgroup_iter_memcg.h"
+#include "cgroup_iter_memcg.skel.h"
+
+int read_stats(struct bpf_link *link)
+{
+	int fd, ret = 0;
+	ssize_t bytes;
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(fd, "bpf_iter_create"))
+		return 1;
+
+	/*
+	 * Invoke iter program by reading from its fd. We're not expecting any
+	 * data to be written by the bpf program so the result should be zero.
+	 * Results will be read directly through the custom data section
+	 * accessible through skel->data_query.memcg_query.
+	 */
+	bytes = read(fd, NULL, 0);
+	if (!ASSERT_EQ(bytes, 0, "read fd"))
+		ret = 1;
+
+	close(fd);
+	return ret;
+}
+
+static void test_anon(struct bpf_link *link,
+		struct memcg_query *memcg_query)
+{
+	void *map;
+	size_t len;
+	long val;
+
+	len = sysconf(_SC_PAGESIZE) * 1024;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		return;
+
+	val = memcg_query->nr_anon_mapped;
+	if (!ASSERT_GE(val, 0, "initial anon mapped val"))
+		return;
+
+	/*
+	 * Increase memcg anon usage by mapping and writing
+	 * to a new anon region.
+	 */
+	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
+		return;
+
+	memset(map, 1, len);
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		goto cleanup;
+
+	ASSERT_GT(memcg_query->nr_anon_mapped, val, "final anon mapped val");
+
+cleanup:
+	munmap(map, len);
+}
+
+static void test_file(struct bpf_link *link,
+		struct memcg_query *memcg_query)
+{
+	void *map;
+	size_t len;
+	long val_pages, val_mapped;
+	FILE *f;
+	int fd;
+
+	len = sysconf(_SC_PAGESIZE) * 1024;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		return;
+
+	val_pages = memcg_query->nr_file_pages;
+	if (!ASSERT_GE(val_pages, 0, "initial file val"))
+		return;
+	val_mapped = memcg_query->nr_file_mapped;
+	if (!ASSERT_GE(val_mapped, 0, "initial file mapped val"))
+		return;
+
+	/*
+	 * Increase memcg file usage by creating and writing
+	 * to a temoprary mapped file.
+	 */
+	f = tmpfile();
+	if (!ASSERT_OK_PTR(f, "tmpfile"))
+		return;
+	fd = fileno(f);
+	if (!ASSERT_OK_FD(fd, "open fd"))
+		return;
+	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
+		goto cleanup_fd;
+
+	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap file"))
+		goto cleanup_fd;
+
+	memset(map, 1, len);
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		goto cleanup_map;
+
+	ASSERT_GT(memcg_query->nr_file_pages, val_pages, "final file value");
+	ASSERT_GT(memcg_query->nr_file_mapped, val_mapped,
+			"final file mapped value");
+
+cleanup_map:
+	munmap(map, len);
+cleanup_fd:
+	close(fd);
+}
+
+static void test_shmem(struct bpf_link *link,
+		struct memcg_query *memcg_query)
+{
+	size_t len;
+	int fd;
+	void *map;
+	long val;
+
+	len = sysconf(_SC_PAGESIZE) * 1024;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		return;
+
+	val = memcg_query->nr_shmem;
+	if (!ASSERT_GE(val, 0, "init shmem val"))
+		return;
+
+	/*
+	 * Increase memcg shmem usage by creating and writing
+	 * to a shmem object.
+	 */
+	fd = shm_open("/tmp_shmem", O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_OK_FD(fd, "shm_open"))
+		return;
+
+	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
+		goto cleanup_fd;
+
+	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap shmem"))
+		goto cleanup_fd;
+
+	memset(map, 1, len);
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		goto cleanup_map;
+
+	ASSERT_GT(memcg_query->nr_shmem, val, "final shmem value");
+
+cleanup_map:
+	munmap(map, len);
+cleanup_fd:
+	close(fd);
+	shm_unlink("/tmp_shmem");
+}
+
+static void test_kmem(struct bpf_link *link,
+		struct memcg_query *memcg_query)
+{
+	int fds[2];
+	int err;
+	ssize_t bytes;
+	size_t len;
+	char *buf;
+	long val;
+
+	len = sysconf(_SC_PAGESIZE) * 1024;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		return;
+
+	val = memcg_query->memcg_kmem;
+	if (!ASSERT_GE(val, 0, "initial kmem val"))
+		return;
+
+	err = pipe2(fds, O_NONBLOCK);
+	if (!ASSERT_OK(err, "pipe"))
+		return;
+
+	buf = malloc(len);
+	memset(buf, 1, len);
+	bytes = write(fds[1], buf, len);
+	if (!ASSERT_GT(bytes, 0, "write"))
+		goto cleanup;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		goto cleanup;
+
+	ASSERT_GT(memcg_query->memcg_kmem, val, "kmem value");
+
+cleanup:
+	free(buf);
+	close(fds[0]);
+	close(fds[1]);
+}
+
+static void test_pgfault(struct bpf_link *link,
+		struct memcg_query *memcg_query)
+{
+	void *map;
+	size_t len;
+	long val;
+
+	len = sysconf(_SC_PAGESIZE) * 1024;
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		return;
+
+	val = memcg_query->pgfault;
+	if (!ASSERT_GE(val, 0, "initial pgfault val"))
+		return;
+
+	/* Create region to use for triggering a page fault. */
+	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
+		return;
+
+	/* Trigger page fault. */
+	memset(map, 1, len);
+
+	if (!ASSERT_OK(read_stats(link), "read stats"))
+		goto cleanup;
+
+	ASSERT_GT(memcg_query->pgfault, val, "final pgfault val");
+
+cleanup:
+	munmap(map, len);
+}
+
+void test_cgroup_iter_memcg(void)
+{
+	char *cgroup_rel_path = "/cgroup_iter_memcg_test";
+	struct cgroup_iter_memcg *skel;
+	struct bpf_link *link;
+	int cgroup_fd, err;
+
+	cgroup_fd = cgroup_setup_and_join(cgroup_rel_path);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup_setup_and_join"))
+		return;
+
+	skel = cgroup_iter_memcg__open();
+	if (!ASSERT_OK_PTR(skel, "cgroup_iter_memcg__open"))
+		goto cleanup_cgroup_fd;
+
+	err = cgroup_iter_memcg__load(skel);
+	if (!ASSERT_OK(err, "cgroup_iter_memcg__load"))
+		goto cleanup_skel;
+
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {
+		.cgroup.cgroup_fd = cgroup_fd,
+		.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY,
+	};
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cgroup_memcg_query, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto cleanup_cgroup_fd;
+
+	if (test__start_subtest("cgroup_iter_memcg__anon"))
+		test_anon(link, &skel->data_query->memcg_query);
+	if (test__start_subtest("cgroup_iter_memcg__shmem"))
+		test_shmem(link, &skel->data_query->memcg_query);
+	if (test__start_subtest("cgroup_iter_memcg__file"))
+		test_file(link, &skel->data_query->memcg_query);
+	if (test__start_subtest("cgroup_iter_memcg__kmem"))
+		test_kmem(link, &skel->data_query->memcg_query);
+	if (test__start_subtest("cgroup_iter_memcg__pgfault"))
+		test_pgfault(link, &skel->data_query->memcg_query);
+
+	bpf_link__destroy(link);
+cleanup_skel:
+	cgroup_iter_memcg__destroy(skel);
+cleanup_cgroup_fd:
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
new file mode 100644
index 000000000000..0d913d72b68d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include "cgroup_iter_memcg.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern void memcg_flush_stats(struct cgroup *cgrp) __ksym;
+extern unsigned long memcg_stat_fetch(struct cgroup *cgrp,
+		enum memcg_stat_item item) __ksym;
+extern unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
+		enum node_stat_item item) __ksym;
+extern unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
+		enum vm_event_item item) __ksym;
+
+/* The latest values read are stored here. */
+struct memcg_query memcg_query SEC(".data.query");
+
+/*
+ * Helpers for fetching any of the three different types of memcg stats.
+ * BPF core macros are used to ensure an enumerator is present in the given
+ * kernel. Falling back on -1 indicates its absence.
+ */
+#define node_stat_fetch_if_exists(cgrp, item) \
+	bpf_core_enum_value_exists(enum node_stat_item, item) ? \
+		memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
+					 enum node_stat_item, item)) : -1
+
+#define memcg_stat_fetch_if_exists(cgrp, item) \
+	bpf_core_enum_value_exists(enum memcg_stat_item, item) ? \
+		memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
+					 enum memcg_stat_item, item)) : -1
+
+#define vm_event_fetch_if_exists(cgrp, item) \
+	bpf_core_enum_value_exists(enum vm_event_item, item) ? \
+		memcg_vm_event_fetch((cgrp), bpf_core_enum_value( \
+					 enum vm_event_item, item)) : -1
+
+SEC("iter.s/cgroup")
+int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
+{
+	struct cgroup *cgrp = ctx->cgroup;
+
+	if (!cgrp)
+		return 1;
+
+	memcg_flush_stats(cgrp);
+
+	memcg_query.nr_anon_mapped = node_stat_fetch_if_exists(cgrp,
+			NR_ANON_MAPPED);
+	memcg_query.nr_shmem = node_stat_fetch_if_exists(cgrp, NR_SHMEM);
+	memcg_query.nr_file_pages = node_stat_fetch_if_exists(cgrp,
+			NR_FILE_PAGES);
+	memcg_query.nr_file_mapped = node_stat_fetch_if_exists(cgrp,
+			NR_FILE_MAPPED);
+	memcg_query.memcg_kmem = memcg_stat_fetch_if_exists(cgrp, MEMCG_KMEM);
+	memcg_query.pgfault = vm_event_fetch_if_exists(cgrp, PGFAULT);
+
+	return 0;
+}
-- 
2.47.3


