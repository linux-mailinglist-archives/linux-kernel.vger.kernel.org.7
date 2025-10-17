Return-Path: <linux-kernel+bounces-858221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2CBE951E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1938135BCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18591335097;
	Fri, 17 Oct 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdFv7d8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67222335075
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712443; cv=none; b=GYvmJe3F5wYdt2YEIeWiM35ffXGT7+CFu35U2FjgpNuOwHgnFEQ0uph7CsMlV8U8slg4IDfea4aSDdjRoe1qgJYP4sA56FX3wKeHnIyDr+QOpzK9wWwZbClGP6b0kRM0hXtqzZqIUMjTT4TB9W/5zZxb0P17Lg7gekbaUmqaKog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712443; c=relaxed/simple;
	bh=Dgd+l3pCcDMnmxhnKz9B7VjOyqW2djhLzE6UYChDPck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/vyW5hjwI7keKQ6ME8vQrqXAa57iK/l2dA7tPGTvAbbGShLz6UcRhSxtbjKUDYYQRJjS9bx9uza3zhhVic8q/3AM7a+OUrqIKJ984C3cALDwWEl1wCu1CEro31ZPYOrK7z2I2fWog5zjCvGkuMPvtJxuj/widfg91aL5bBRqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMdFv7d8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZVwvtyNqsIzzjoNvH4aAIMQ2MEEUWR/Rn3UkgTbh74=;
	b=iMdFv7d82eu4dZHgA1gShw/W07J3uK+yt80XZbm9BzZcqoLqlKiFQrlqYE5lqu7jFUwD8r
	8LSni46msO6qfA7BNDyF5CUulfKtVNEnOspmRYFBPifzhsk2I/P0Z16gyxuxsclsJnIRCI
	aT9fpt9CCC07kH94IMtWRJbgI/v2hc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-9HcKxReBOPyrtsgM3CZuPg-1; Fri,
 17 Oct 2025 10:47:19 -0400
X-MC-Unique: 9HcKxReBOPyrtsgM3CZuPg-1
X-Mimecast-MFC-AGG-ID: 9HcKxReBOPyrtsgM3CZuPg_1760712438
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2542A195608A;
	Fri, 17 Oct 2025 14:47:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34A351800452;
	Fri, 17 Oct 2025 14:47:14 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/4] rtla/timerlat: Add --bpf-action option
Date: Fri, 17 Oct 2025 16:46:48 +0200
Message-ID: <20251017144650.663238-3-tglozar@redhat.com>
In-Reply-To: <20251017144650.663238-1-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add option --bpf-action that allows the user to attach an external BPF
program that will be executed via BPF tail call on latency threshold
overflow.

Executing additional BPF code on latency threshold overflow allows doing
doing low-latency and in-kernel troubleshooting of the cause of the
overflow.

The option takes an argument, which is a path to a BPF ELF file
expected to contain a function named "action_handler" in a section named
"tp/timerlat_action" (the section is necessary for libbpf to asssign the
correct BPF program type to it).

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c      | 11 ++++++
 tools/tracing/rtla/src/timerlat.h      |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c  | 54 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++-
 tools/tracing/rtla/src/timerlat_hist.c |  5 +++
 tools/tracing/rtla/src/timerlat_top.c  |  5 +++
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index b69212874127..6907a323f9ec 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -48,6 +48,17 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		}
 	}
 
+	/* Check if BPF action program is requested but BPF is not available */
+	if (params->bpf_action_program) {
+		if (params->mode == TRACING_MODE_TRACEFS) {
+			err_msg("BPF actions are not supported in tracefs-only mode\n");
+			goto out_err;
+		}
+
+		if (timerlat_load_bpf_action_program(params->bpf_action_program))
+			goto out_err;
+	}
+
 	if (params->mode != TRACING_MODE_BPF) {
 		/*
 		 * In tracefs and mixed mode, timerlat tracer handles stopping
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index fd6065f48bb7..8dd5d134ce08 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -27,6 +27,7 @@ struct timerlat_params {
 	int			dump_tasks;
 	int			deepest_idle_state;
 	enum timerlat_tracing_mode mode;
+	const char		*bpf_action_program;
 };
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
@@ -36,4 +37,3 @@ int timerlat_main(int argc, char *argv[]);
 int timerlat_enable(struct osnoise_tool *tool);
 void timerlat_analyze(struct osnoise_tool *tool, bool stopped);
 void timerlat_free(struct osnoise_tool *tool);
-
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 1d619e502c65..3c63bf7aa607 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -7,6 +7,10 @@
 
 static struct timerlat_bpf *bpf;
 
+/* BPF object and program for action program */
+static struct bpf_object *obj;
+static struct bpf_program *prog;
+
 /*
  * timerlat_bpf_init - load and initialize BPF program to collect timerlat data
  */
@@ -56,6 +60,10 @@ int timerlat_bpf_init(struct timerlat_params *params)
 		return err;
 	}
 
+	/* Set BPF action program to NULL */
+	prog = NULL;
+	obj = NULL;
+
 	return 0;
 }
 
@@ -96,6 +104,11 @@ void timerlat_bpf_detach(void)
 void timerlat_bpf_destroy(void)
 {
 	timerlat_bpf__destroy(bpf);
+	bpf = NULL;
+	if (obj)
+		bpf_object__close(obj);
+	obj = NULL;
+	prog = NULL;
 }
 
 static int handle_rb_event(void *ctx, void *data, size_t data_sz)
@@ -190,4 +203,45 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 			 bpf->maps.summary_user,
 			 key, value_irq, value_thread, value_user, cpus);
 }
+
+/*
+ * timerlat_load_bpf_action_program - load and register a BPF action program
+ */
+int timerlat_load_bpf_action_program(const char *program_path)
+{
+	int err;
+
+	obj = bpf_object__open_file(program_path, NULL);
+	if (!obj) {
+		err_msg("Failed to open BPF action program: %s\n", program_path);
+		return -1;
+	}
+
+	err = bpf_object__load(obj);
+	if (err) {
+		err_msg("Failed to load BPF action program: %s\n", program_path);
+		return -1;
+	}
+
+	prog = bpf_object__find_program_by_name(obj, "action_handler");
+	if (!prog) {
+		err_msg("BPF action program must have 'action_handler' function: %s\n",
+			program_path);
+		bpf_object__close(obj);
+		obj = NULL;
+		return -1;
+	}
+
+	err = timerlat_bpf_set_action(prog);
+	if (err) {
+		err_msg("Failed to register BPF action program: %s\n", program_path);
+		bpf_object__close(obj);
+		obj = NULL;
+		prog = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 #endif /* HAVE_BPF_SKEL */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index b5009092c7a3..169abeaf4363 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -30,7 +30,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_thread,
 				   long long *value_user,
 				   int cpus);
-
+int timerlat_load_bpf_action_program(const char *program_path);
 static inline int have_libbpf_support(void) { return 1; }
 #else
 static inline int timerlat_bpf_init(struct timerlat_params *params)
@@ -58,6 +58,10 @@ static inline int timerlat_bpf_get_summary_value(enum summary_field key,
 {
 	return -1;
 }
+static inline int timerlat_load_bpf_action_program(const char *program_path)
+{
+	return -1;
+}
 static inline int have_libbpf_support(void) { return 0; }
 #endif /* HAVE_BPF_SKEL */
 #endif /* __bpf__ */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..5e639cc34f64 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -763,6 +763,7 @@ static void timerlat_hist_usage(char *usage)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -853,6 +854,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{"on-threshold",	required_argument,	0, '\5'},
 			{"on-end",		required_argument,	0, '\6'},
+			{"bpf-action",		required_argument,	0, '\7'},
 			{0, 0, 0, 0}
 		};
 
@@ -1062,6 +1064,9 @@ static struct common_params
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case '\7':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb59..da5d5db1bc17 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -521,6 +521,7 @@ static void timerlat_top_usage(char *usage)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -603,6 +604,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '8'},
 			{"on-threshold",	required_argument,	0, '9'},
 			{"on-end",		required_argument,	0, '\1'},
+			{"bpf-action",		required_argument,	0, '\2'},
 			{0, 0, 0, 0}
 		};
 
@@ -798,6 +800,9 @@ static struct common_params
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case '\2':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
-- 
2.51.0


