Return-Path: <linux-kernel+bounces-724244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB44AFF05E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771F01C83DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801262376F2;
	Wed,  9 Jul 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ors1ftUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB142264B0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084217; cv=none; b=n5nDBmA+4GdE5D+qlP1oLrZAkeUtctO4lP/par5KqMNqpoMTy0AvFE6tEmfAfC8iziStoqEypaVz+AESHbUqkETuhxrl1X5PWaXksHQzU8uzx/H7itk2VPPX3vvq6e3sjzQE4ugjQ/ClqzuQ0jV6BYpv0SRGvXxcyLjICyJxtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084217; c=relaxed/simple;
	bh=/F7mjkjuohfh46YDlcOQVurzihzSdvozO8b9E8yCnhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbxmk+E8IUMaemvVBJjytKJ8MNjoWAAKNaju6f19ACA9l8HxyLuJQwTUIeLFUUcFO8daRJOsLo4KH9hQOMo0eIFgDy09TrbrTno82nWESTMUBbnMcHVkBfCVDHylbchkM6heQrtIIoPiwEpILZqgY6H50QcGDBW3R057pHd7sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ors1ftUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA1BC4CEF7;
	Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084217;
	bh=/F7mjkjuohfh46YDlcOQVurzihzSdvozO8b9E8yCnhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ors1ftUbxRPqDxY+5MMsyLIA9I0E23bfabFtOQkMEESM1CDPosTC5/SVcFovHGcBa
	 rrNN1nsfSVqzAOyxoUrB1qwi6QeO4CCc0Pia9+D+CN7tRsAPMjlm0MLgp1GqAkpkzL
	 Hi+JYSdosn70vnRFn/zimufkUSS8BIWU0Y5E+WXnq9yyvQRfZExL126XCmlIKg/yct
	 wrPKKiPJD+IjWrVTXMHH54ePRieUSrI9otCH+o4JepLTMf8IvQUMjDkbCkL7H7c987
	 IlTBiweYjNvjpNp1TRVxJxlZSj5HPMXRIFCUs6lB+iEwrvKiSw7HJu+9AFMIA9m3km
	 87/kWWA0Q957w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1F9B2CE0C26; Wed,  9 Jul 2025 11:03:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v6 3/3] lib: Add stress test for ratelimit
Date: Wed,  9 Jul 2025 11:03:35 -0700
Message-Id: <20250709180335.1716384-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple stress test for lib/ratelimit.c

To run on x86:

	./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_RATELIMIT_KUNIT_TEST=y --kconfig_add CONFIG_SMP=y --qemu_args "-smp 4" lib_ratelimit

On a 16-CPU system, the "4" in "-smp 4" can be varied between 1 and 8.
Larger numbers have higher probabilities of introducing delays that
break the smoke test.  In the extreme case, increasing the number to
larger than the number of CPUs in the underlying system is an excellent
way to get a test failure.

Link: https://lore.kernel.org/all/fbe93a52-365e-47fe-93a4-44a44547d601@paulmck-laptop/
Link: https://lore.kernel.org/all/20250423115409.3425-1-spasswolf@web.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 lib/tests/test_ratelimit.c | 69 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/lib/tests/test_ratelimit.c b/lib/tests/test_ratelimit.c
index 5d6ec88546005..bfaeca49304a5 100644
--- a/lib/tests/test_ratelimit.c
+++ b/lib/tests/test_ratelimit.c
@@ -4,6 +4,8 @@
 
 #include <linux/ratelimit.h>
 #include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/cpumask.h>
 
 /* a simple boot-time regression test */
 
@@ -63,14 +65,77 @@ static void test_ratelimit_smoke(struct kunit *test)
 	test_ratelimited(test, false);
 }
 
-static struct kunit_case sort_test_cases[] = {
+static struct ratelimit_state stressrl = RATELIMIT_STATE_INIT_FLAGS("stressrl", HZ / 10, 3,
+								    RATELIMIT_MSG_ON_RELEASE);
+
+static int doneflag;
+static const int stress_duration = 2 * HZ;
+
+struct stress_kthread {
+	unsigned long nattempts;
+	unsigned long nunlimited;
+	unsigned long nlimited;
+	unsigned long nmissed;
+	struct task_struct *tp;
+};
+
+static int test_ratelimit_stress_child(void *arg)
+{
+	struct stress_kthread *sktp = arg;
+
+	set_user_nice(current, MAX_NICE);
+	WARN_ON_ONCE(!sktp->tp);
+
+	while (!READ_ONCE(doneflag)) {
+		sktp->nattempts++;
+		if (___ratelimit(&stressrl, __func__))
+			sktp->nunlimited++;
+		else
+			sktp->nlimited++;
+		cond_resched();
+	}
+
+	sktp->nmissed = ratelimit_state_reset_miss(&stressrl);
+	return 0;
+}
+
+static void test_ratelimit_stress(struct kunit *test)
+{
+	int i;
+	const int n_stress_kthread = cpumask_weight(cpu_online_mask);
+	struct stress_kthread skt = { 0 };
+	struct stress_kthread *sktp = kcalloc(n_stress_kthread, sizeof(*sktp), GFP_KERNEL);
+
+	KUNIT_EXPECT_NOT_NULL_MSG(test, sktp, "Memory allocation failure");
+	for (i = 0; i < n_stress_kthread; i++) {
+		sktp[i].tp = kthread_run(test_ratelimit_stress_child, &sktp[i], "%s/%i",
+					 "test_ratelimit_stress_child", i);
+		KUNIT_EXPECT_NOT_NULL_MSG(test, sktp, "kthread creation failure");
+		pr_alert("Spawned test_ratelimit_stress_child %d\n", i);
+	}
+	schedule_timeout_idle(stress_duration);
+	WRITE_ONCE(doneflag, 1);
+	for (i = 0; i < n_stress_kthread; i++) {
+		kthread_stop(sktp[i].tp);
+		skt.nattempts += sktp[i].nattempts;
+		skt.nunlimited += sktp[i].nunlimited;
+		skt.nlimited += sktp[i].nlimited;
+		skt.nmissed += sktp[i].nmissed;
+	}
+	KUNIT_ASSERT_EQ_MSG(test, skt.nunlimited + skt.nlimited, skt.nattempts,
+			    "Outcomes not equal to attempts");
+	KUNIT_ASSERT_EQ_MSG(test, skt.nlimited, skt.nmissed, "Misses not equal to limits");
+}
+
+static struct kunit_case ratelimit_test_cases[] = {
 	KUNIT_CASE_SLOW(test_ratelimit_smoke),
+	KUNIT_CASE_SLOW(test_ratelimit_stress),
 	{}
 };
 
 static struct kunit_suite ratelimit_test_suite = {
 	.name = "lib_ratelimit",
-	.test_cases = sort_test_cases,
+	.test_cases = ratelimit_test_cases,
 };
 
 kunit_test_suites(&ratelimit_test_suite);
-- 
2.40.1


