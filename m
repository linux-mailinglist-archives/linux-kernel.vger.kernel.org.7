Return-Path: <linux-kernel+bounces-780912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA84B30AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D401C862FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BBB19004A;
	Fri, 22 Aug 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahTJ3SmI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89A1BBBE5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826739; cv=none; b=E2RaVtKpAC67yq6R99F7CBtqwzDNpIhPpLqc4YusWH3p9QeBw8k1Ris/0Ab6xKb63ijtoQ+S4j2JnzwfF4B61AgSjo+rZYrqBx8XQ3EUt066VJhilddMM6ynOxaXwUOxFEmPjVUHD7p6PNovSNG5znsqBMUCOrcTiM3xEDfv6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826739; c=relaxed/simple;
	bh=cMyDPM6lVeJMVaG2qjywrXR4bPYrAG96UhN1uXVEBsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bSRTYnm1YTdG2s32nwOQQorrumLdzegdwVDkrP79OGYQcubaUcPThs7x8GtdfTeHLMN+alkelWiTHG6D8LQLgTdS5XIIioCYEtYvlY7ZPTWwspgEtyJJpbN+GqbTWUms462PkGSKxs7WvoLkTBFR7zp07UeTbwlOHtJTPPlYyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahTJ3SmI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f42254so36066025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755826737; x=1756431537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMDg/uAc5+RsTMY4md2v1ID7410l0nb81E+3UmfaUqY=;
        b=ahTJ3SmI8eELS6VwSVRdfBpoug9T8+EST9AvGn0m5IZvOiZTHorp30o6FgPyJm74UX
         GDvMBS+/xTB6SQQNMCt0wpya1n5U7swGjr6UI9N0X863nepyM2TlurC6Gj+Gh3F4OdGN
         1v8TaoRol/2dFSGA+IzIqr+EWPAYHYk+GOdPja5rN60P4VF5Zj//TZtvgc28Ivj7cZd6
         Q6NytikVF+W/JTlsMLWEuLpIVvHMaGB95lhT4eiqhzoS1Po+xuQjexL2Akr/jRUG0+xu
         uKpxPIunrTRljILNpxq+vFRq3s8W12/OBY1WLFzi6GW2tV3Sb9it/n3Hl4EZe9YamH6o
         f+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826737; x=1756431537;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zMDg/uAc5+RsTMY4md2v1ID7410l0nb81E+3UmfaUqY=;
        b=YflRXDsXHCy9hqiVsbw25gJYm29s4a4ufsFPAAH99vv/KZptGmnv27f9KDcD7geYBa
         e0RGUc3gvL9Qe5Lt7GKi2rwk8qoAcMsIRLGzEgx4jd1Uzag6c22UO5UHKqdk+TGpgsdx
         Olc5uxX/KvIi0i+Mo2OzB4QH0aq0Y0VLkGc6UypqZLCcOiXy+dLOHbEiA3GfvI+JpvVM
         KZTMYprHw2KMdPtHWA0VTYVftE02dgMz+JFi6biPaS8816pJYtu4Kgs8/5UF3mmRUIOM
         wgm+fbfgca8VpsjGGSeb08C4gfCoVuZDxzK/4KXK1QvAlzyj6GfjGRIs+XM1u4bJ3uk+
         6yUA==
X-Gm-Message-State: AOJu0YwBVA2Zz9KprT8QPgVCBmWU1U8X/qlzJ0UWYoCeHlBrOABeSckK
	8/Jl40Dg9ntBy7CUKFe40DfAumoWWSlKStOIBa8piMa9HA3i6S/gXnsefcYtXxxSO83A0/RNV0F
	xZBzBsyi/wHHnouk9lTnSrUVbKfQo7N6McNJYY0pmjB5ieYVm78TUFmsIZpDtNyzjTT/bJtLnmS
	V2QSRKU2SLbwY0IFXyPugKsKAkVCMbG6lfKltH6C1kauRV6gPPyA==
X-Google-Smtp-Source: AGHT+IFb1w489F3f4jLCNYnaL1YiWRdZ4hvvhOBlLgEi34xYiBkeRh4NlmcN4ipV7dXI4J8WtLETF6fELCn/
X-Received: from plev24.prod.google.com ([2002:a17:903:31d8:b0:246:222a:4ddf])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d507:b0:240:7308:aecb
 with SMTP id d9443c01a7336-2462ef1d587mr14551615ad.32.1755826736773; Thu, 21
 Aug 2025 18:38:56 -0700 (PDT)
Date: Thu, 21 Aug 2025 18:37:53 -0700
In-Reply-To: <20250822013749.3268080-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822013749.3268080-6-ynaffit@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822013749.3268080-8-ynaffit@google.com>
Subject: [PATCH v4 2/2] cgroup: selftests: Add tests for freezer time
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Test cgroup v2 freezer time stat. Freezer time accounting should
be independent of other cgroups in the hierarchy and should increase
iff a cgroup is CGRP_FREEZE (regardless of whether it reaches
CGRP_FROZEN).

Skip these tests on systems without freeze time accounting.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
---
v3 -> v4:
* Clean up logic around skipping selftests and decrease granularity of
  sleep times, as suggested by Michal.
---
 tools/testing/selftests/cgroup/test_freezer.c | 663 ++++++++++++++++++
 1 file changed, 663 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/=
selftests/cgroup/test_freezer.c
index 8730645d363a..dfb763819581 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -804,6 +804,662 @@ static int test_cgfreezer_vfork(const char *root)
 	return ret;
 }
=20
+/*
+ * Get the current frozen_usec for the cgroup.
+ */
+static long cg_check_freezetime(const char *cgroup)
+{
+	return cg_read_key_long(cgroup, "cgroup.stat.local",
+				"frozen_usec ");
+}
+
+/*
+ * Test that the freeze time will behave as expected for an empty cgroup.
+ */
+static int test_cgfreezer_time_empty(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *cgroup =3D NULL;
+	long prev, curr;
+
+	cgroup =3D cg_name(root, "cg_time_test_empty");
+	if (!cgroup)
+		goto cleanup;
+
+	/*
+	 * 1) Create an empty cgroup and check that its freeze time
+	 *    is 0.
+	 */
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+	if (curr > 0) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+
+	/*
+	 * 2) Sleep for 1000 us. Check that the freeze time is at
+	 *    least 1000 us.
+	 */
+	usleep(1000);
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr < 1000) {
+		debug("Expect time (%ld) to be at least 1000 us\n",
+		      curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 3) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 2).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Check the freeze time again to ensure that it has not
+	 *    changed.
+	 */
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr !=3D prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * A simple test for cgroup freezer time accounting. This test follows
+ * the same flow as test_cgfreezer_time_empty, but with a single process
+ * in the cgroup.
+ */
+static int test_cgfreezer_time_simple(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *cgroup =3D NULL;
+	long prev, curr;
+
+	cgroup =3D cg_name(root, "cg_time_test_simple");
+	if (!cgroup)
+		goto cleanup;
+
+	/*
+	 * 1) Create a cgroup and check that its freeze time is 0.
+	 */
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+	if (curr > 0) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 2) Populate the cgroup with one child and check that the
+	 *    freeze time is still 0.
+	 */
+	cg_run_nowait(cgroup, child_fn, NULL);
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr > prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+
+	/*
+	 * 3) Sleep for 1000 us. Check that the freeze time is at
+	 *    least 1000 us.
+	 */
+	usleep(1000);
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr < 1000) {
+		debug("Expect time (%ld) to be at least 1000 us\n",
+		      curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 3).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 5) Sleep for 1000 us. Check that the freeze time is the
+	 *    same as at 4).
+	 */
+	usleep(1000);
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr !=3D prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * Test that freezer time accounting works as expected, even while we're
+ * populating a cgroup with processes.
+ */
+static int test_cgfreezer_time_populate(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *cgroup =3D NULL;
+	long prev, curr;
+	int i;
+
+	cgroup =3D cg_name(root, "cg_time_test_populate");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+	if (curr > 0) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 1) Populate the cgroup with 100 processes. Check that
+	 *    the freeze time is 0.
+	 */
+	for (i =3D 0; i < 100; i++)
+		cg_run_nowait(cgroup, child_fn, NULL);
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr !=3D prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 2) Wait for the group to become fully populated. Check
+	 *    that the freeze time is 0.
+	 */
+	if (cg_wait_for_proc_count(cgroup, 100))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr !=3D prev) {
+		debug("Expect time (%ld) to be 0\n", curr);
+		goto cleanup;
+	}
+
+	/*
+	 * 3) Freeze the cgroup and then populate it with 100 more
+	 *    processes. Check that the freeze time continues to grow.
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	for (i =3D 0; i < 100; i++)
+		cg_run_nowait(cgroup, child_fn, NULL);
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 4) Wait for the group to become fully populated. Check
+	 *    that the freeze time is larger than at 3).
+	 */
+	if (cg_wait_for_proc_count(cgroup, 200))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 5) Unfreeze the cgroup. Check that the freeze time is
+	 *    larger than at 4).
+	 */
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 6) Kill the processes. Check that the freeze time is the
+	 *    same as it was at 5).
+	 */
+	if (cg_killall(cgroup))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr !=3D prev) {
+		debug("Expect time (%ld) to be unchanged from previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	/*
+	 * 7) Freeze and unfreeze the cgroup. Check that the freeze
+	 *    time is larger than it was at 6).
+	 */
+	if (cg_freeze_nowait(cgroup, true))
+		goto cleanup;
+	if (cg_freeze_nowait(cgroup, false))
+		goto cleanup;
+	prev =3D curr;
+	curr =3D cg_check_freezetime(cgroup);
+	if (curr <=3D prev) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr, prev);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * Test that frozen time for a cgroup continues to work as expected,
+ * even as processes are migrated. Frozen cgroup A's freeze time should
+ * continue to increase and running cgroup B's should stay 0.
+ */
+static int test_cgfreezer_time_migrate(const char *root)
+{
+	long prev_A, curr_A, curr_B;
+	char *cgroup[2] =3D {0};
+	int ret =3D KSFT_FAIL;
+	int pid;
+
+	cgroup[0] =3D cg_name(root, "cg_time_test_migrate_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] =3D cg_name(root, "cg_time_test_migrate_B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	if (cg_create(cgroup[0]))
+		goto cleanup;
+
+	if (cg_check_freezetime(cgroup[0]) < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(cgroup[1]))
+		goto cleanup;
+
+	pid =3D cg_run_nowait(cgroup[0], child_fn, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_wait_for_proc_count(cgroup[0], 1))
+		goto cleanup;
+
+	curr_A =3D cg_check_freezetime(cgroup[0]);
+	if (curr_A) {
+		debug("Expect time (%ld) to be 0\n", curr_A);
+		goto cleanup;
+	}
+	curr_B =3D cg_check_freezetime(cgroup[1]);
+	if (curr_B) {
+		debug("Expect time (%ld) to be 0\n", curr_B);
+		goto cleanup;
+	}
+
+	/*
+	 * Freeze cgroup A.
+	 */
+	if (cg_freeze_wait(cgroup[0], true))
+		goto cleanup;
+	prev_A =3D curr_A;
+	curr_A =3D cg_check_freezetime(cgroup[0]);
+	if (curr_A <=3D prev_A) {
+		debug("Expect time (%ld) to be > 0\n", curr_A);
+		goto cleanup;
+	}
+
+	/*
+	 * Migrate from A (frozen) to B (running).
+	 */
+	if (cg_enter(cgroup[1], pid))
+		goto cleanup;
+
+	usleep(1000);
+	curr_B =3D cg_check_freezetime(cgroup[1]);
+	if (curr_B) {
+		debug("Expect time (%ld) to be 0\n", curr_B);
+		goto cleanup;
+	}
+
+	prev_A =3D curr_A;
+	curr_A =3D cg_check_freezetime(cgroup[0]);
+	if (curr_A <=3D prev_A) {
+		debug("Expect time (%ld) to be more than previous check (%ld)\n",
+		      curr_A, prev_A);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (cgroup[0])
+		cg_destroy(cgroup[0]);
+	free(cgroup[0]);
+	if (cgroup[1])
+		cg_destroy(cgroup[1]);
+	free(cgroup[1]);
+	return ret;
+}
+
+/*
+ * The test creates a cgroup and freezes it. Then it creates a child cgrou=
p.
+ * After that it checks that the child cgroup has a non-zero freeze time
+ * that is less than the parent's. Next, it freezes the child, unfreezes
+ * the parent, and sleeps. Finally, it checks that the child's freeze
+ * time has grown larger than the parent's.
+ */
+static int test_cgfreezer_time_parent(const char *root)
+{
+	char *parent, *child =3D NULL;
+	int ret =3D KSFT_FAIL;
+	long ptime, ctime;
+
+	parent =3D cg_name(root, "cg_test_parent_A");
+	if (!parent)
+		goto cleanup;
+
+	child =3D cg_name(parent, "cg_test_parent_B");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_check_freezetime(parent) < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_freeze_wait(parent, true))
+		goto cleanup;
+
+	usleep(1000);
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_check_frozen(child, true))
+		goto cleanup;
+
+	/*
+	 * Since the parent was frozen the entire time the child cgroup
+	 * was being created, we expect the parent's freeze time to be
+	 * larger than the child's.
+	 *
+	 * Ideally, we would be able to check both times simultaneously,
+	 * but here we get the child's after we get the parent's.
+	 */
+	ptime =3D cg_check_freezetime(parent);
+	ctime =3D cg_check_freezetime(child);
+	if (ptime <=3D ctime) {
+		debug("Expect ptime (%ld) > ctime (%ld)\n", ptime, ctime);
+		goto cleanup;
+	}
+
+	if (cg_freeze_nowait(child, true))
+		goto cleanup;
+
+	if (cg_freeze_wait(parent, false))
+		goto cleanup;
+
+	if (cg_check_frozen(child, true))
+		goto cleanup;
+
+	usleep(100000);
+
+	ctime =3D cg_check_freezetime(child);
+	ptime =3D cg_check_freezetime(parent);
+
+	if (ctime <=3D ptime) {
+		debug("Expect ctime (%ld) > ptime (%ld)\n", ctime, ptime);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	free(child);
+	if (parent)
+		cg_destroy(parent);
+	free(parent);
+	return ret;
+}
+
+/*
+ * The test creates a parent cgroup and a child cgroup. Then, it freezes
+ * the child and checks that the child's freeze time is greater than the
+ * parent's, which should be zero.
+ */
+static int test_cgfreezer_time_child(const char *root)
+{
+	char *parent, *child =3D NULL;
+	int ret =3D KSFT_FAIL;
+	long ptime, ctime;
+
+	parent =3D cg_name(root, "cg_test_child_A");
+	if (!parent)
+		goto cleanup;
+
+	child =3D cg_name(parent, "cg_test_child_B");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_check_freezetime(parent) < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_freeze_wait(child, true))
+		goto cleanup;
+
+	ctime =3D cg_check_freezetime(child);
+	ptime =3D cg_check_freezetime(parent);
+	if (ptime !=3D 0) {
+		debug("Expect ptime (%ld) to be 0\n", ptime);
+		goto cleanup;
+	}
+
+	if (ctime <=3D ptime) {
+		debug("Expect ctime (%ld) <=3D ptime (%ld)\n", ctime, ptime);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	free(child);
+	if (parent)
+		cg_destroy(parent);
+	free(parent);
+	return ret;
+}
+
+/*
+ * The test creates the following hierarchy:
+ *    A
+ *    |
+ *    B
+ *    |
+ *    C
+ *
+ * Then it freezes the cgroups in the order C, B, A.
+ * Then it unfreezes the cgroups in the order A, B, C.
+ * Then it checks that C's freeze time is larger than B's and
+ * that B's is larger than A's.
+ */
+static int test_cgfreezer_time_nested(const char *root)
+{
+	char *cgroup[3] =3D {0};
+	int ret =3D KSFT_FAIL;
+	long time[3] =3D {0};
+	int i;
+
+	cgroup[0] =3D cg_name(root, "cg_test_time_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] =3D cg_name(cgroup[0], "B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	cgroup[2] =3D cg_name(cgroup[1], "C");
+	if (!cgroup[2])
+		goto cleanup;
+
+	if (cg_create(cgroup[0]))
+		goto cleanup;
+
+	if (cg_check_freezetime(cgroup[0]) < 0) {
+		ret =3D KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (cg_create(cgroup[1]))
+		goto cleanup;
+
+	if (cg_create(cgroup[2]))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[2], true))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[1], true))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[0], true))
+		goto cleanup;
+
+	usleep(1000);
+
+	if (cg_freeze_nowait(cgroup[0], false))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[1], false))
+		goto cleanup;
+
+	if (cg_freeze_nowait(cgroup[2], false))
+		goto cleanup;
+
+	time[2] =3D cg_check_freezetime(cgroup[2]);
+	time[1] =3D cg_check_freezetime(cgroup[1]);
+	time[0] =3D cg_check_freezetime(cgroup[0]);
+
+	if (time[2] <=3D time[1]) {
+		debug("Expect C's time (%ld) > B's time (%ld)", time[2], time[1]);
+		goto cleanup;
+	}
+
+	if (time[1] <=3D time[0]) {
+		debug("Expect B's time (%ld) > A's time (%ld)", time[1], time[0]);
+		goto cleanup;
+	}
+
+	ret =3D KSFT_PASS;
+
+cleanup:
+	for (i =3D 2; i >=3D 0 && cgroup[i]; i--) {
+		cg_destroy(cgroup[i]);
+		free(cgroup[i]);
+	}
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cgfreezer_test {
 	int (*fn)(const char *root);
@@ -819,6 +1475,13 @@ struct cgfreezer_test {
 	T(test_cgfreezer_stopped),
 	T(test_cgfreezer_ptraced),
 	T(test_cgfreezer_vfork),
+	T(test_cgfreezer_time_empty),
+	T(test_cgfreezer_time_simple),
+	T(test_cgfreezer_time_populate),
+	T(test_cgfreezer_time_migrate),
+	T(test_cgfreezer_time_parent),
+	T(test_cgfreezer_time_child),
+	T(test_cgfreezer_time_nested),
 };
 #undef T
=20
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


