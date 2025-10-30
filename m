Return-Path: <linux-kernel+bounces-877467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6D3C1E2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D796734B467
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4ED32C95D;
	Thu, 30 Oct 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frSd84Sr"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A732C95C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761793230; cv=none; b=darife3J9De4r311kIm+d3mQLRh+y0Ril/z6SSQl6KJXsW7vU0fNYSaM0PG0s6FonZIYsh2HPtuneG6YT53lfBRQBO8Nfkx/LDyVHEunz4BGF74PM6lUuHHrcDaRU19WCUn2kZHtmF+byNNrGJYPjTiesxykSCUbe1y+HQJLAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761793230; c=relaxed/simple;
	bh=p9VUFDUmElzhq3Y1NJOKencICnU7fgRdtPaIJ9+b4YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtQS9Im79J7YhsJUXSq+015/56xA3a3NX+27tWCDHv3QgC3NIKyJWmTTCVRRo/eI9zbhr44Ia0dIzT5oR6QKI4drSVc0Yr6pkkZNo4ooDD8Mj7g68xs87RmxaqLd9ncjbMuJ7p+aFYmvgeC46Q3sWdFZ2W/Dhiom8I4jFq2zONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frSd84Sr; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso641480b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761793228; x=1762398028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOqMlrs96orUrV/G+q7YtbzEmic4V+UvSE86rYjh92Q=;
        b=frSd84SrVJH2O1fr6t14PLOZLs+hKdRks5Rx1JoNdgcdP+8kStcDC6OEqb/cPuZ0qW
         mQxyKSz4mrTceEvu8Cl2wX/q4nCDpForUXbdUfSv4wvLuRFTwRIPCIP1BEG5NghO7tUe
         zNRgt/0Xi9URJisY9Wr2+38PlKDlDbQo63I0Q895QphMk1It+aThUi5wEYFEPG2dsp+H
         0WJp8246mtNGbf8zGQErJPMF9T5hhoGOLOQx2crBoeX8/QN9V8QdD5BqNZA/HjCSsTwX
         3+n46QXmO6K6jkP9eRIxN9VEZy9UzedGnpOgGxF/GH/fLcoR9gfuT6g6rFk5D6IGB+63
         WLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761793228; x=1762398028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOqMlrs96orUrV/G+q7YtbzEmic4V+UvSE86rYjh92Q=;
        b=co91bKLYmYtg4mEGW+la+98UM0Kk/2Cey8a8TTprhVWY+rWlRWBBKAS/+jVhK9xe7/
         NuldWsrZCreWdAQxfsO/8zvsxrwsfLW4/N5wgxuQQdxU+yVXZ36oFz8V+b/YnxnECM8W
         HVyt6jw01HSxTUbzOq1FZBII0wGiTMYVBV7YdqOOIgRWajmuDG+9KB2OCv0IkSNqgDt+
         DycAYSnJZe4XGi6jyXUaC7Ywumk8f+OJD5tNMuWvMwphHBVSMKu8s8q7KhUbPZ6jy/H4
         OWoDxRwo7r/vjAeU7+VsefE8kd7n+i0VJypwnTuYjKiSl/qMOGD5hvJ593ZTxyYPn5U4
         CdRA==
X-Forwarded-Encrypted: i=1; AJvYcCUo9JUq4e8VAUZ4t4JPrY0Cfq+iXBpmdv85WYnwn5wQ6LfHBnl2GW2g+Q1xiSnOiDDp6nMucGsoAcUyu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5z/0W9BtC02vFScrHdLbBvpPyVnU+A/rtpwAV3f+UzjLxa+s
	SZzyKx6v+bZnvze+WLVa8wljCH3LfHdM10i2cuFG4JY3R1l8C5D0cdya
X-Gm-Gg: ASbGncsbQ23m77Xn+2HW4//yBERETfyZO8Y7xnbwbWIBkxeIHdrYHi4EeIeXaVAVcR/
	w/ZdwsYA0CHVMgK5dGOi6L0UdjFoG3wBvpxNhHMNKeqcT3fI5MAQOsWW26U6WTNrt01A2u6XKNh
	6ciXPnQq2WgDMqADupoA7xGLYLoeUPJnZWvUonj33Xsq4NtqOc7L0xNhnFXhi2MwvZc1hbB4lR5
	BS54rsE+slSkDswejDiaGrA1licH8MUWP8dVs9xXRly8LRCyApBSPDGC1PGB6rfE6YsiQmOz/4Y
	mXCXJjg1RdBT3/+rAI5CK6sp1jIEgKN4lm4shkr8VtonDcREWctYhKJ8mejP/SbifLgKFdvpDHQ
	IEtJfrEh6Rfr2I+ApenfCu0zAa4PHR0IdGy0qsNYn5DzoELCIvPTAR3jEguxjPfE6VyQdZkEAMM
	Ra
X-Google-Smtp-Source: AGHT+IE+EkIZH7nXlS0M66HyWl57U57NNIvburFNgkiF/aZKFtLI6PX9C71beMO3KKsYSq3AkXoUuA==
X-Received: by 2002:a05:6a00:806:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a624c63426mr1985029b3a.13.1761793228514;
        Wed, 29 Oct 2025 20:00:28 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm16663311b3a.12.2025.10.29.20.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:00:28 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: martin.lau@linux.dev,
	leon.hwang@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test map deadlock caused by NMI
Date: Thu, 30 Oct 2025 11:00:10 +0800
Message-ID: <20251030030010.95352-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251030030010.95352-1-dongml2@chinatelecom.cn>
References: <20251030030010.95352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this testing, map updating and deleting both happen in NMI context and
user context, which is used to detect the possible deadlock.

For now, LRU is added in the testing, and more map type can be added in
the feature.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/map_deadlock.c   | 136 ++++++++++++++++++
 .../selftests/bpf/progs/map_deadlock.c        |  52 +++++++
 2 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_deadlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_deadlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_deadlock.c b/tools/testing/selftests/bpf/prog_tests/map_deadlock.c
new file mode 100644
index 000000000000..17fcf1f5efa6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_deadlock.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
+#include <pthread.h>
+#include "map_deadlock.skel.h"
+
+
+static int perf_open_all_cpus(struct perf_event_attr *attr, int fds[], int max_cpus)
+{
+	int n = 0;
+
+	for (int cpu = 0; cpu < max_cpus; cpu++) {
+		int fd = syscall(__NR_perf_event_open, attr, -1 /* pid: all */, cpu,
+				 -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+		if (fd < 0)
+			continue;
+		fds[cpu] = fd;
+		n++;
+	}
+	return n;
+}
+
+struct thread_arg {
+	int map_fd;
+	bool *stop;
+};
+
+static void *user_update_thread(void *argp)
+{
+	struct thread_arg *arg = argp;
+	u32 key = 0;
+	u64 val = 1;
+
+	while (!*arg->stop) {
+		key++;
+		val++;
+		bpf_map_update_elem(arg->map_fd, &key, &val, BPF_ANY);
+		if ((key & 0x7) == 0)
+			bpf_map_delete_elem(arg->map_fd, &key);
+	}
+	return NULL;
+}
+
+static void test_map(const char *map_name, int map_index)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_HARDWARE,
+		.size = sizeof(struct perf_event_attr),
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+		.sample_period = 1000000,
+		.freq = 0,
+		.disabled = 0,
+		.wakeup_events = 1,
+	};
+	int map_fd, nfd = 0, max_cpus, err;
+	struct bpf_link **links = NULL;
+	struct map_deadlock *skel;
+	struct bpf_program *prog;
+	struct thread_arg targ;
+	bool stop = false;
+	int *fds = NULL;
+	pthread_t thr;
+
+	skel = map_deadlock__open();
+	if (!ASSERT_OK_PTR(skel, "map_deadlock__open"))
+		return;
+	skel->rodata->map_index = map_index;
+	err = map_deadlock__load(skel);
+	if (!ASSERT_OK(err, "map_deadlock__load"))
+		goto out;
+
+	prog = skel->progs.on_perf;
+	map_fd = bpf_object__find_map_fd_by_name(skel->obj, map_name);
+	if (!ASSERT_GE(map_fd, 0, map_name))
+		goto out;
+
+	max_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(max_cpus, 0, "num cpus"))
+		goto out;
+
+	links = calloc(max_cpus, sizeof(*links));
+	ASSERT_OK_PTR(links, "alloc links");
+	fds = calloc(max_cpus, sizeof(*fds));
+	ASSERT_OK_PTR(fds, "alloc fds");
+	for (int i = 0; i < max_cpus; i++)
+		fds[i] = -1;
+
+	nfd = perf_open_all_cpus(&attr, fds, max_cpus);
+	if (!ASSERT_GT(nfd, 0, "perf fds"))
+		goto out;
+
+	for (int cpu = 0; cpu < max_cpus; cpu++) {
+		if (fds[cpu] < 0)
+			continue;
+		links[cpu] = bpf_program__attach_perf_event(prog, fds[cpu]);
+		if (!ASSERT_OK_PTR(links[cpu], "attach perf"))
+			goto out;
+	}
+
+	targ.map_fd = map_fd;
+	targ.stop = &stop;
+	err = pthread_create(&thr, NULL, user_update_thread, &targ);
+	if (!ASSERT_OK(err, "create thr"))
+		goto out;
+
+	/* 1 second should be enough to trigger the deadlock */
+	sleep(1);
+	stop = true;
+	(void)pthread_join(thr, NULL);
+	/* TODO: read dmesg to check the deadlock? */
+out:
+	if (links) {
+		for (int cpu = 0; cpu < max_cpus; cpu++) {
+			if (links[cpu])
+				bpf_link__destroy(links[cpu]);
+		}
+	}
+	if (fds) {
+		for (int cpu = 0; cpu < max_cpus; cpu++) {
+			if (fds[cpu] >= 0)
+				close(fds[cpu]);
+		}
+	}
+	free(links);
+	free(fds);
+	map_deadlock__destroy(skel);
+}
+
+void test_map_deadlock(void)
+{
+	if (test__start_subtest("lru"))
+		test_map("lru_map", 0);
+}
diff --git a/tools/testing/selftests/bpf/progs/map_deadlock.c b/tools/testing/selftests/bpf/progs/map_deadlock.c
new file mode 100644
index 000000000000..6966224955fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_deadlock.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct lru_map {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1024);
+	__type(key, u32);
+	__type(value, u64);
+} lru_map SEC(".maps");
+
+struct map_list {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+	__array(values, struct lru_map);
+} map_list SEC(".maps") = {
+	.values = { [0] = &lru_map },
+};
+
+const volatile int map_index;
+
+static __always_inline void do_update_delete(void *map)
+{
+	u64 ts = bpf_ktime_get_ns();
+	u32 key = (u32)(ts >> 12);
+	u64 val = ts;
+
+	if ((ts & 1) == 0)
+		bpf_map_update_elem(map, &key, &val, BPF_ANY);
+	else
+		bpf_map_delete_elem(map, &key);
+}
+
+SEC("perf_event")
+int on_perf(struct bpf_perf_event_data *ctx)
+{
+	int key = map_index;
+	void *target_map;
+
+	target_map = bpf_map_lookup_elem(&map_list, &key);
+	if (!target_map)
+		return 0;
+
+	for (int i = 0; i < 4; i++)
+		do_update_delete(target_map);
+	return 0;
+}
-- 
2.51.2


