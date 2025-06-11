Return-Path: <linux-kernel+bounces-681821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB145AD57C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600E91E045C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DD2BDC0C;
	Wed, 11 Jun 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbLvsGAg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8C2BD5A1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650254; cv=none; b=gq6idxEEJHj/hlTq31Af3sSwwZhilQ/dghRHIjqLhxFJApoI4yI3oW22fFx5hIa0swoEJK1SoOJ4IctoSeRuLBHjR/L+yjJakc9EO7+FwrwwZ3bkZN7EdSx3mMDiVA7dujtLPQ89uu59ksaNZ9m9ewm7RyuY07dugdK4rZfkgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650254; c=relaxed/simple;
	bh=Go5JGuIZNIfDL3ZeStX4Ulz3lvP95/gd1jxsbDwz00U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozyB9rzaDqR+GIRVU6KuVcTEUBKFC6jS87G04L1/Cg3xC5aH22mV6gS9CmHzI4UP36vtzg+hh7OJZi71IDgz77NWpHA3ylL3ZYu5HvSQmdlaZ+QQKOfb/3uHRhdYewY6E8GQ9Z9jk6xcZz8daePCXOYZBUJUgW4ornBOGDflchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbLvsGAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHi0wdPt/H6x9IskZMhJkRdb3PKUTgsnf0jUg3nci1o=;
	b=dbLvsGAgq+PUe+Ml4EgUNgoZizAkP7O1TqUOnSCz4vH8VtRRKNNA1MEqV+Y8UAoLsb5Shs
	9GNfYsITv3r+FqWpF6JfTywYWzfw3KMZAj1RdTtxRE/jx5L5MWJkWz/2Hd7abdaq3DAK2Y
	lc7qQvmg/oCugz6nmXod/bMlru5ULS8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-mUbO50PBP1uwErUu09FLoQ-1; Wed,
 11 Jun 2025 09:57:29 -0400
X-MC-Unique: mUbO50PBP1uwErUu09FLoQ-1
X-Mimecast-MFC-AGG-ID: mUbO50PBP1uwErUu09FLoQ_1749650248
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCD1E1800286;
	Wed, 11 Jun 2025 13:57:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4D9119560A3;
	Wed, 11 Jun 2025 13:57:24 +0000 (UTC)
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
Subject: [PATCH 7/8] rtla/tests: Add tests for actions
Date: Wed, 11 Jun 2025 15:56:43 +0200
Message-ID: <20250611135644.219127-8-tglozar@redhat.com>
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

Add a bunch of tests covering most of both action on threshold
(-A/--on-threshold) and action on end (-N/--on-end). Parts sensitive to
implementation of hist/top are tested for both.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 579c12a85e8f..b810b36a04a3 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -18,6 +18,8 @@ fi
 for option in $no_bpf_options
 do
 export RTLA_NO_BPF=$option
+
+# Basic tests
 check "verify help page" \
 	"timerlat --help"
 check "verify -s/--stack" \
@@ -36,6 +38,32 @@ check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 30s"
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 30s" 2
+
+# Actions tests
+check "trace output through -t" \
+	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
+check "trace output through -t with custom filename" \
+	"timerlat hist -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "trace output through -A trace" \
+	"timerlat hist -T 2 -A trace" 2 "^  Saving trace to timerlat_trace.txt$"
+check "trace output through -A trace with custom filename" \
+	"timerlat hist -T 2 -A trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "exec command" \
+	"timerlat hist -T 2 -A shell,command='echo TestOutput'" 2 "^TestOutput$"
+check "multiple actions" \
+	"timerlat hist -T 2 -A shell,command='echo -n 1' -A shell,command='echo 2'" 2 "^12$"
+check "hist stop at failed action" \
+	"timerlat hist -T 2 -A shell,command='echo -n 1; false' -A shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
+check "top stop at failed action" \
+	"timerlat top -T 2 -A shell,command='echo -n 1; false' -A shell,command='echo -n 2'" 2 "^1ALL"
+check "hist with continue" \
+	"timerlat hist -T 2 -d 1s -A shell,command='echo TestOutput' -A continue" 0 "^TestOutput$"
+check "top with continue" \
+	"timerlat top -q -T 2 -d 1s -A shell,command='echo TestOutput' -A continue" 0 "^TestOutput$"
+check "hist with trace output at end" \
+	"timerlat hist -d 1s -N trace" 0 "^  Saving trace to timerlat_trace.txt$"
+check "top with trace output at end" \
+	"timerlat top -d 1s -N trace" 0 "^  Saving trace to timerlat_trace.txt$"
 done
 
 test_end
-- 
2.49.0


