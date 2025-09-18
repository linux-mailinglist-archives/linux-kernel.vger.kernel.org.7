Return-Path: <linux-kernel+bounces-752165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5BEB17206
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB5D1AA8520
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E12D12F4;
	Thu, 31 Jul 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg4T17Fu"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6F2D0C73
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968422; cv=none; b=Pm8s+s3R9H7flK6/h+ucyAQOth+Krbvf5x5otvjOAuumwP9PxKJ8KTRqDMqUIRmJtP6wKoMhwi9J9Bt7XDHO/utBiBRfqwXYrDOCaIlKtN3uZIO+f62DcqJiugSvnTbgDNG8shwy6Oy8wUAYMJFPEMOuzcrHPcz2g1gpLE4ifnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968422; c=relaxed/simple;
	bh=U2Q/nA8/fs3IaxhsmxtBPWhflIIPydiW0Xcing3X6TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jLTqKOt/hrbNpE7Q4WMsH0GtGeV/6yC68t5WlIcfzIROVhDHoDAgejR6aDWXuYi5+tu6RKF237Gn4BAPk1uz1F/BUFsqlrPeDtugIBQS7ndaoHjV3ISq3bAnfQN/nADPW6Eci14MV38N7870WJIc+S/qXSyp6EYRvKS9CW63EkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg4T17Fu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2400cbd4241so12638835ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753968420; x=1754573220; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cS0kX7TvRYgQTsqu0GMqG/8vvD7pFz5fsy9ObfHAWm4=;
        b=Jg4T17FugmVHZwRiwS3QLHVhMZkjjr/LQTLtSfLnY8fYp6RWCCP1q1G9cAWNeV9PoO
         19/Ez/k0IFszuunhz30CmIKDUmIWeVX4IZAkxtxUHe4Ic685tzJCD0Zfb22HggSuhvCL
         3XsKBZ1CxoldgPPe3YrDWDairLV94zT5dPcLMSqxo2xiRUtPoYshTI0hdovKfw/s58gf
         YbYx3ivr9YD0gu+Rp9eDB+q4JDv1UmgsnxC7BgtZRhX0vMcBjCUiwYIJORK+108xXmpl
         anpDjuGEfxWc49HoVZv/4KoM+pTk79di7/msXig6WlK/5lDpDUW4UradQd4mHjPho+md
         7Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968420; x=1754573220;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cS0kX7TvRYgQTsqu0GMqG/8vvD7pFz5fsy9ObfHAWm4=;
        b=Tn1vRK+IBa3mI+HwxHRo9GzdnL2u/sLVvqsSytDybmaIx7P/8TsPmfMFqhXHfP9qnk
         XIuUftW4UEPWmHYop1QZNMQGOvIgEubPSZyBR08pb/kC7NfpHALKLqE9pxf5mgtYorer
         EFmNaANRvBnPsWpy0PnixYvbPn+LATu5iTRi+3RQt5ieWI9It+w4RbkRC+9q4sGsrV0g
         wcplp1QSU4vLx/an4iVsqv3+RN0oqNyA5ytbMwI10Db4ky09LJQoWHXXTqZbOac7VEmD
         H7sImkHlsobocNxziRgpLwq9774MxASzXb91nfM4+jxKyudCrcfhbfzLjCbM/WOzb3X0
         H61w==
X-Forwarded-Encrypted: i=1; AJvYcCVij2MQNwNI8PYq1psihSgewrMVr1PQDDL75HgELE4V3DtHrdH0+48x5W4wHZpzqRVfqsa3PGI48RgQMNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXkRFfobj8Pw74we9beTHObRsvZ2YcDBWwnUKoIMuDhHDZ2fr
	xZa1/gEexP4qjnBULpz2sF1NlaNT9LyV6PF4Ej7lcI0lUM9tBNcAGZN7BJlrs3cMJPidCtvtpSo
	DqhQ+XA==
X-Google-Smtp-Source: AGHT+IEwFWYPRxHNlmybj0gexk68rMr7gVOb927INT9mYj/fa8gmdq1czl+fytYCMaogstSXj8WleWU/75s=
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:23f:cd94:8c5e])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b43:b0:240:8ec:fe2
 with SMTP id d9443c01a7336-24096a4fa57mr127525435ad.4.1753968420421; Thu, 31
 Jul 2025 06:27:00 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:26:14 -0700
In-Reply-To: <20250731132615.938435-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731132615.938435-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731132615.938435-5-yuzhuo@google.com>
Subject: [PATCH v1 4/5] perf bench: Add 'ratio' mode to 'sync rcu'
From: Yuzhuo Jing <yuzhuo@google.com>
To: Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a 'ratio' mode to RCU benchmark.  This mode helps investigate
performance effects on the ratio between selected two parameters.
The command is defined as:

  ratio <gp_type> <total> <param1_range> <param1_name> <param2_name>

<total> is the sum of <param1> and <param2>.
<param1_range> specifies the range of param1's values, and thus param2's
  values can be calculated as 'total-param1'.

Example usage:

$ ./perf bench sync rcu ratio sync 10 0:10:3 nreaders nwriters
\# Running 'sync/rcu' benchmark:
Running experiment with options: nreaders=0 nwriters=10
Experiment finished.
Average grace-period duration: 16494.413 microseconds
Minimum grace-period duration: 7994.842
50th percentile grace-period duration: 17999.439
90th percentile grace-period duration: 18001.923
99th percentile grace-period duration: 23999.068
Maximum grace-period duration: 24000.441
Cooling down (3s)..

Running experiment with options: nreaders=3 nwriters=7
Experiment finished.
Average grace-period duration: 140018.793 microseconds
Minimum grace-period duration: 11987.02
50th percentile grace-period duration: 120999.879
90th percentile grace-period duration: 218000.011
99th percentile grace-period duration: 218006.372
Maximum grace-period duration: 219002.024
Cooling down (3s)..

Running experiment with options: nreaders=6 nwriters=4
Experiment finished.
Average grace-period duration: 210481.539 microseconds
Minimum grace-period duration: 5999.579
50th percentile grace-period duration: 217999.902
90th percentile grace-period duration: 218000.529
99th percentile grace-period duration: 218998.809
Maximum grace-period duration: 219000.652
Cooling down (3s)..

Running experiment with options: nreaders=9 nwriters=1
Experiment finished.
Average grace-period duration: 210782.119 microseconds
Minimum grace-period duration: 89997.154
50th percentile grace-period duration: 217999.829
90th percentile grace-period duration: 218001.299
99th percentile grace-period duration: 219003.072
Maximum grace-period duration: 324116.763

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync-rcu.c | 74 +++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/perf/bench/sync-rcu.c b/tools/perf/bench/sync-rcu.c
index 921520a645ae..73142fd5be21 100644
--- a/tools/perf/bench/sync-rcu.c
+++ b/tools/perf/bench/sync-rcu.c
@@ -55,6 +55,7 @@ static const char *const bench_rcu_usage[] = {
 	"perf bench sync rcu [options..] [-- <command>..]",
 	"perf bench sync rcu [options..] once  <gp_type> [<param=value>..] [-- <command>..]",
 	"perf bench sync rcu [options..] range <gp_type> [<param=range>..] [-- <command>..]",
+	"perf bench sync rcu [options..] ratio <gp_type> <total> <param1_range> <param1_name> <param2_name> [<param=value>..] [-- <command>..]",
 	"",
 	"  <gp_type>: The type of grace period to use: sync, async, exp (expedited)",
 	"             This sets the gp_exp or gp_async kernel module parameters.",
@@ -83,12 +84,17 @@ static const char *const bench_rcu_usage[] = {
 	"         If a parameter does not specify end, or start=end, it behaves",
 	"         the same as 'once' mode.  The range parameter types are validated",
 	"         agains `modinfo rcuscale` to ensure they are integer.",
+	"  ratio: Run benchmark that changes the ratio between two parameters.",
+	"         <total> specifies the sum of param1 and param2, and <param1_range>",
+	"         is the range of param1 values.  param2 is calculated by total-param1.",
+	"         Additional non-range parameters may also be specified.",
 	"",
 	"Examples:",
 	"  perf bench sync rcu --hist once exp nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"  perf bench sync rcu once",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1",
 	"  perf bench sync rcu range exp  nreaders=1:2 nwriters=1 writer_cpu_offset=0:2",
+	"  perf bench sync rcu ratio sync 10 0:10:3 nreaders nwriters",
 	"",
 	"  perf bench sync rcu once  sync nreaders=1 nwriters=1 writer_cpu_offset=1 -- \\",
 	"      perf stat -e ipi:ipi_send_cpu,rcu:rcu_grace_period \\",
@@ -1194,6 +1200,72 @@ static void test_range(int argc, const char *argv[])
 	test_range_recursive(0, &modprobe_cmd);
 }
 
+/*
+ * Test ratio.  Use loop on two range options.
+ *
+ * Does not allow ranges for other options.
+ *
+ * Example:
+ *   perf bench rcu ratio sync 10 1:10:2 nreaders nwriters
+ *   will run the following experiments:
+ *     nreaders=1, nwriters=9
+ *     nreaders=2, nwriters=8
+ *     nreaders=3, nwriters=7
+ *     ...
+ *     nreaders=9, nwriters=1
+ */
+static void test_ratio(int argc, const char *argv[])
+{
+	MODPROBE_CMD_INIT;
+
+	int total;
+	struct range option1_range;
+	const char *option1_name;
+	const char *option2_name;
+
+	if (argc < 4)
+		usage_with_options(bench_rcu_usage, bench_rcu_options);
+
+	total = parse_int(argv[0]);
+	parse_range(&option1_range, argv[1]);
+	option1_name = argv[2];
+	option2_name = argv[3];
+
+	check_param_name(option1_name);
+	check_param_name(option2_name);
+
+	if (total < option1_range.start || total < option1_range.end)
+		fail("Total must be greater than or equal to the range bounary");
+
+	parse_module_params(argc - 4, argv + 4, false);
+
+	modprobe_collect_simple_options(&modprobe_cmd);
+
+	for (int i = option1_range.start; i <= option1_range.end; i += option1_range.step) {
+		int j = total - i;
+
+		struct modprobe_param param1, param2;
+
+		param_print_key_value(&param1, "%s=%d", option1_name, i);
+		param_print_key_value(&param2, "%s=%d", option2_name, j);
+
+		modprobe_cmd_add(&modprobe_cmd, param1.value);
+		modprobe_cmd_add(&modprobe_cmd, param2.value);
+
+		runonce(&modprobe_cmd);
+
+		modprobe_cmd_pop(&modprobe_cmd);
+		modprobe_cmd_pop(&modprobe_cmd);
+
+		if (i + option1_range.step <= option1_range.end) {
+			printf("Cooling down (%ds)..\n", cooldown);
+			if (!dryrun)
+				sleep(cooldown);
+			puts("");
+		}
+	}
+}
+
 /* ============================= Entry Point ============================== */
 
 int bench_sync_rcu(int argc, const char **argv)
@@ -1228,6 +1300,8 @@ int bench_sync_rcu(int argc, const char **argv)
 		cmd = test_once;
 	else if (strcmp(runmode, "range") == 0)
 		cmd = test_range;
+	else if (strcmp(runmode, "ratio") == 0)
+		cmd = test_ratio;
 	else
 		usage_with_options(bench_rcu_usage, bench_rcu_options);
 
-- 
2.50.1.565.gc32cd1483b-goog


