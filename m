Return-Path: <linux-kernel+bounces-603832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D1A88CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 22:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EC018990D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EBF1E1DEF;
	Mon, 14 Apr 2025 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbbKVVDX"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169741DB951
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661379; cv=none; b=H9sl8Qf93Glj63gcIZ9FANHAosT6frYMrAexE52RFpP1KvCBdEjmgk2SCgZsVDk8St5j9DNxc6830rZeqoP+tEzR2+WFmt0A98FqUu5wEbBSpavnTb2fRttWMPy1D0VkZay9pdrqoqtV8wufqrY3tg1DD6iPFhHmo9FKMfRW068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661379; c=relaxed/simple;
	bh=A9agp1wVVTN9gLJ7vLgLfDxvVbChZWKeOB6jEwY00oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T8AtWkSEooP1Lc0PdqUwPaoPl0eTO+I7vUlCq1tJOL1amsfphpm5p+/bKYOI0jXnAqfCNGaHJoRNSMYRId86uTtuk+71RUA+yD5CroY20pA9Y2abXmQspzQzPzor9Hr83YTgCq8HFzldxg8NUpHcCf8pQlRUis6rHF32CK7WFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbbKVVDX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5f876bfe0so776101285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744661376; x=1745266176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEPCPsuu4mOv4RpZG9bxPkCm1mldRsLNLtiJyqFAhfo=;
        b=BbbKVVDXil6GwtHDXj46KTFzIJFOSyyQbkggiwUDt4LGIeMgVyBm1ytwgawhRMxlv2
         k8enYGNxUbBrr0XA8wN7IK21pCsW16tfWHECHH9k3KXR5FzPv3ndXane9kXsAv2Jp+qe
         sYMRYBRFluYQAbKiYWdePQc5+4wLSwgUkph5cUuorgShkKU4IncJKwEWvbMBVuu5B2WM
         5BF54mqqI6wMpVxv/3+DMB2xIlq42aRfoHZrGemIH6UN8N67yfh4rUjGIOWv9DWljUUX
         WjQihe8I8gUu06f2fg0ZCh/ITMRAAq4nlPmqWqIVfsMChVQF3ASnsT0XcdUIwZ9fjtzz
         d2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661376; x=1745266176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEPCPsuu4mOv4RpZG9bxPkCm1mldRsLNLtiJyqFAhfo=;
        b=PJZrTbnn9j53kX+T3O4fCRcjb6m8ndRetvsYQu4lWTImfZhdAN82wfcJsiVQgMM181
         iEgNFwkykjvSiM8Ygn0ePJ4eNdvHZj5MOSspkayFDsiQHkadiR4L4sBsn+Ldo1M3I/wz
         +/FWXgbXDO1PedJwg5YPnK8e/ckByUPkCWxWMgOiix5IB2HAhNc2dWEQMCTbfTrLO/YO
         e2vOUCEGa12tnQUejvfaTSh95TI4S3cHse9nk8zZ4WU69wU9KTERDeyepjejEd0F7kan
         HqhUB6NN2iUGDOS/xkkWag+XkMhkD89E8WMsqXTgPmtYnCJZp1aHN3IfsVX+ft4kqgeg
         RqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXS/UxESbxqcAKhA62TpoLdXPqp8A3WPv4KP1FqBUVUEZeikj6SGuCXQSOSxbEqpOggPXgrgKs/DkQ1vE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkzcrE7ibVJ+0mBAwg4txGQGACGQe52ljUW6lJGpLnh20PB5T
	h4k+c+2BiE7fiQZXP3Kk8zUNvfpWVUoTvmEbKsEpysPa8LRV4p54C5lwrLPNxAlUB4NYgKlxuH9
	qGCurDRG3aaTc8szXXw==
X-Google-Smtp-Source: AGHT+IFo27YAEXtdB9NO9z8x8Qu4EDaExdktQ60IBBNvdKMRDz2sKxo9rLMgeMU1RMTXNBzeHGQ39ioAKjECzVSv
X-Received: from qkae13.prod.google.com ([2002:a05:620a:208d:b0:7c5:b5ba:4136])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:460b:b0:7c0:bb3f:e285 with SMTP id af79cd13be357-7c7af13370dmr1874025885a.24.1744661376057;
 Mon, 14 Apr 2025 13:09:36 -0700 (PDT)
Date: Mon, 14 Apr 2025 20:09:26 +0000
In-Reply-To: <20250414200929.3098202-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414200929.3098202-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414200929.3098202-3-jthoughton@google.com>
Subject: [PATCH v3 2/5] KVM: selftests: access_tracking_perf_test: Add option
 to skip the sanity check
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

Add an option to skip sanity check of number of still idle pages,
and set it by default to skip, in case hypervisor or NUMA balancing
is detected.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Co-developed-by: James Houghton <jthoughton@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/access_tracking_perf_test.c | 62 ++++++++++++++++---
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   |  7 +++
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 447e619cf856e..a2ac6fa2ba141 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -65,6 +65,16 @@ static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 /* Whether to overlap the regions of memory vCPUs access. */
 static bool overlap_memory_access;
 
+/*
+ * If the test should only warn if there are too many idle pages (i.e., it is
+ * expected).
+ * -1: Not yet set.
+ *  0: We do not expect too many idle pages, so FAIL if too many idle pages.
+ *  1: Having too many idle pages is expected, so merely print a warning if
+ *     too many idle pages are found.
+ */
+static int idle_pages_warn_only = -1;
+
 struct test_params {
 	/* The backing source for the region of memory. */
 	enum vm_mem_backing_src_type backing_src;
@@ -177,18 +187,12 @@ static void mark_vcpu_memory_idle(struct kvm_vm *vm,
 	 * arbitrary; high enough that we ensure most memory access went through
 	 * access tracking but low enough as to not make the test too brittle
 	 * over time and across architectures.
-	 *
-	 * When running the guest as a nested VM, "warn" instead of asserting
-	 * as the TLB size is effectively unlimited and the KVM doesn't
-	 * explicitly flush the TLB when aging SPTEs.  As a result, more pages
-	 * are cached and the guest won't see the "idle" bit cleared.
 	 */
 	if (still_idle >= pages / 10) {
-#ifdef __x86_64__
-		TEST_ASSERT(this_cpu_has(X86_FEATURE_HYPERVISOR),
+		TEST_ASSERT(idle_pages_warn_only,
 			    "vCPU%d: Too many pages still idle (%lu out of %lu)",
 			    vcpu_idx, still_idle, pages);
-#endif
+
 		printf("WARNING: vCPU%d: Too many pages still idle (%lu out of %lu), "
 		       "this will affect performance results.\n",
 		       vcpu_idx, still_idle, pages);
@@ -328,6 +332,32 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	memstress_destroy_vm(vm);
 }
 
+static int access_tracking_unreliable(void)
+{
+#ifdef __x86_64__
+	/*
+	 * When running nested, the TLB size may be effectively unlimited (for
+	 * example, this is the case when running on KVM L0), and KVM doesn't
+	 * explicitly flush the TLB when aging SPTEs.  As a result, more pages
+	 * are cached and the guest won't see the "idle" bit cleared.
+	 */
+	if (this_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		puts("Skipping idle page count sanity check, because the test is run nested");
+		return 1;
+	}
+#endif
+	/*
+	 * When NUMA balancing is enabled, guest memory will be unmapped to get
+	 * NUMA faults, dropping the Accessed bits.
+	 */
+	if (is_numa_balancing_enabled()) {
+		puts("Skipping idle page count sanity check, because NUMA balancing is enabled");
+		return 1;
+	}
+
+	return 0;
+}
+
 static void help(char *name)
 {
 	puts("");
@@ -342,6 +372,12 @@ static void help(char *name)
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -w: Control whether the test warns or fails if more than 10%\n"
+	       "     of pages are still seen as idle/old after accessing guest\n"
+	       "     memory.  >0 == warn only, 0 == fail, <0 == auto.  For auto\n"
+	       "     mode, the test fails by default, but switches to warn only\n"
+	       "     if NUMA balancing is enabled or the test detects it's running\n"
+	       "     in a VM.\n");
 	backing_src_help("-s");
 	puts("");
 	exit(0);
@@ -359,7 +395,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:b:v:os:w:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -376,6 +412,11 @@ int main(int argc, char *argv[])
 		case 's':
 			params.backing_src = parse_backing_src_type(optarg);
 			break;
+		case 'w':
+			idle_pages_warn_only =
+				atoi_non_negative("Idle pages warning",
+						  optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -388,6 +429,9 @@ int main(int argc, char *argv[])
 		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
 	close(page_idle_fd);
 
+	if (idle_pages_warn_only == -1)
+		idle_pages_warn_only = access_tracking_unreliable();
+
 	for_each_guest_mode(run_test, &params);
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 77d13d7920cb8..c6ef895fbd9ab 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -153,6 +153,7 @@ bool is_backing_src_hugetlb(uint32_t i);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 long get_run_delay(void);
+bool is_numa_balancing_enabled(void);
 
 /*
  * Whether or not the given source type is shared memory (as opposed to
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 3dc8538f5d696..03eb99af9b8de 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -176,6 +176,13 @@ size_t get_trans_hugepagesz(void)
 	return get_sysfs_val("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size");
 }
 
+bool is_numa_balancing_enabled(void)
+{
+	if (!test_sysfs_path("/proc/sys/kernel/numa_balancing"))
+		return false;
+	return get_sysfs_val("/proc/sys/kernel/numa_balancing") == 1;
+}
+
 size_t get_def_hugetlb_pagesz(void)
 {
 	char buf[64];
-- 
2.49.0.604.gff1f9ca942-goog


