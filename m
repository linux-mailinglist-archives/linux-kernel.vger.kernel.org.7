Return-Path: <linux-kernel+bounces-681823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DAAD57BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DF47A56F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33F2BE7A1;
	Wed, 11 Jun 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB4VYZji"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD72BDC37
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650261; cv=none; b=XdS1XuXxzXX2bfYpbhVvg5vctVcrWb0uKTUyBr5Ertv6l1VrtzYSX5eIZDhtHJroBty1j7jbzIf1o/hUAW3M3L3jlm5V6WF9tqV2u8yXTtRBzECbSEo8bcYtsBIE0Z4AwFEAEn0El+eQOgPaq11b18vB23gVrgy2n0OArZ4HR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650261; c=relaxed/simple;
	bh=+3YUBwLdVlM80y5Z4ZZxUmJSTsY4yq9GlGFZH30XYBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7NYlBiBhTM7XgUFkCSRxUg3n/KM5NtZC/JC1KLCnPuJlT/EcMfARfLbz8jBkRw5hAIKry44OqjuP5+vJhEGrovqYwFoD1PwwfFH4B829OwfM93PKy0b15N+tlM5Y0/iH9Z9iJI2GmAImINh5udmWzf/66tekBZi4ZEQFhqzvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WB4VYZji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwFqatCUz2bA7Mz3zTRUHBJnezMkE02OL4O8XuLPGfw=;
	b=WB4VYZjie1NK5LthE2PUf0LWbIxUX+Yx/3xMlAuGEMbO3rS0Wxo5lqx99XHBQFlNK4hXHX
	wb2ZPQuChJVPchAd2kJ8o8XSEeRNr75UT9xq7UkuDh+Zf8nC2lu5AuhRh0Jernw5sllOKf
	zzGVFIwxTlG/Xq/87iMGM+OUD/hQFdw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-a5HsY95xNlmqw8ZCGRhxFA-1; Wed,
 11 Jun 2025 09:57:33 -0400
X-MC-Unique: a5HsY95xNlmqw8ZCGRhxFA-1
X-Mimecast-MFC-AGG-ID: a5HsY95xNlmqw8ZCGRhxFA_1749650252
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9655195608E;
	Wed, 11 Jun 2025 13:57:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56FF919560A3;
	Wed, 11 Jun 2025 13:57:28 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 8/8] rtla/tests: Limit duration to maximum of 10s
Date: Wed, 11 Jun 2025 15:56:44 +0200
Message-ID: <20250611135644.219127-9-tglozar@redhat.com>
In-Reply-To: <20250611135644.219127-1-tglozar@redhat.com>
References: <20250611135644.219127-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Many of the original rtla tests included durations of 1 minute and 30
seconds. Experience has shown this is unnecessary, since 10 seconds as
waiting time for samples to appear.

Change duration of all rtla tests to at most 10 seconds. This speeds up
testing significantly.

Before:
$ make check
All tests successful.
Files=3, Tests=54, 536 wallclock secs
( 0.03 usr  0.00 sys + 20.31 cusr 22.02 csys = 42.36 CPU)
Result: PASS

After:
$ make check
...
All tests successful.
Files=3, Tests=54, 196 wallclock secs
( 0.03 usr  0.01 sys + 20.28 cusr 20.68 csys = 41.00 CPU)
Result: PASS

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/hwnoise.t  | 8 ++++----
 tools/tracing/rtla/tests/osnoise.t  | 4 ++--
 tools/tracing/rtla/tests/timerlat.t | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 5f71401a139e..448877564b8d 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -10,12 +10,12 @@ check "verify help page" \
 check "detect noise higher than one microsecond" \
 	"hwnoise -c 0 -T 1 -d 5s -q"
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 30s" 2
+	"hwnoise -a 5 -d 10s" 2
 check "set scheduling param to the osnoise tracer threads" \
-	"hwnoise -P F:1 -c 0 -r 900000 -d 1M -q"
+	"hwnoise -P F:1 -c 0 -r 900000 -d 10s -q"
 check "stop the trace if a single sample is higher than 1 us" \
-	"hwnoise -s 1 -T 1 -t -d 30s" 2
+	"hwnoise -s 1 -T 1 -t -d 10s" 2
 check "enable a trace event trigger" \
-	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 1m"
+	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s"
 
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 44908fc01abf..6a4dfa31dc55 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -8,13 +8,13 @@ set_timeout 2m
 check "verify help page" \
 	"osnoise --help"
 check "verify the --priority/-P param" \
-	"osnoise top -P F:1 -c 0 -r 900000 -d 1M -q"
+	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
 check "verify the --stop/-s param" \
 	"osnoise top -s 30 -T 1 -t" 2
 check "verify the  --trace param" \
 	"osnoise hist -s 30 -T 1 -t" 2
 check "verify the --entries/-E param" \
-	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
+	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
 # Test setting default period by putting an absurdly high period
 # and stopping on threshold.
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b810b36a04a3..291d047420c3 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -25,9 +25,9 @@ check "verify help page" \
 check "verify -s/--stack" \
 	"timerlat top -s 3 -T 10 -t" 2
 check "verify -P/--priority" \
-	"timerlat top -P F:1 -c 0 -d 1M -q"
+	"timerlat top -P F:1 -c 0 -d 10s -q"
 check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 30s" 2
+	"timerlat top -i 2 -c 0 -n -d 10s" 2
 check "set the automatic trace mode" \
 	"timerlat top -a 5 --dump-tasks" 2
 check "print the auto-analysis if hits the stop tracing condition" \
@@ -35,9 +35,9 @@ check "print the auto-analysis if hits the stop tracing condition" \
 check "disable auto-analysis" \
 	"timerlat top -s 3 -T 10 -t --no-aa" 2
 check "verify -c/--cpus" \
-	"timerlat hist -c 0 -d 30s"
+	"timerlat hist -c 0 -d 10s"
 check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 30s" 2
+	"timerlat hist -i 2 -c 0 -n -d 10s" 2
 
 # Actions tests
 check "trace output through -t" \
-- 
2.49.0


