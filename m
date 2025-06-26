Return-Path: <linux-kernel+bounces-704453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1226FAE9DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E21E1C286D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047C2E541A;
	Thu, 26 Jun 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA9KFSK9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD2E5401
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941394; cv=none; b=ageWDbrSqFk6jUieYIC4l/V0VCK3plFffOf2RpnwWzwGhMDnTv41z1lwy0u1RDQluPOeXJ9mMcrYFHDZViBY24nhWNR2r7dLe1sDZlZgVOKrA+ugIBP1CQBg+UBzsfuYEKFKnMY4hxNVBdb8ZVY2Lybu3O1Cf0WfuG660qR8pXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941394; c=relaxed/simple;
	bh=tbmjAPe9K8kZku7BODFUd9I5r2ppEDax4yKPfCbGKBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+HLEbzVdgQRI34wT9UJKjgpHKfzU+8Rkjxis9pO7viMcxunxevjFVJfFNli70w5sy3zvc7M2cjN1MKHceq4yqC9cp8OsmmH03a+zF+FxIVlncWgeGT8oxEZboau1zNg+9ZGAJxrSTY56E6Xid0lKH+kLVpMEyXqPzLk3QL550Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XA9KFSK9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8T4xpbeiOqSe/DoRZSEQyk76AEAAvRMDQwoAZeiH0M=;
	b=XA9KFSK94LLyq8iCIgMju76KPqtodtJLN540aYsO1k8j0pTg8HmM0P+6S4G1j95DuZo5zw
	vDHiSIHcBhTuWsDm3ASEpsMUcZ+4Ti3Y7S4ZtgXSRlS9bgU15dT4o59xPa21/HILnAC8+Y
	tCsaou7A6MbmMEStFGxQHxahgjUHLfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-IFnfb8ycMiSst3g2Kq6N2Q-1; Thu,
 26 Jun 2025 08:36:30 -0400
X-MC-Unique: IFnfb8ycMiSst3g2Kq6N2Q-1
X-Mimecast-MFC-AGG-ID: IFnfb8ycMiSst3g2Kq6N2Q_1750941390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1A01809C80;
	Thu, 26 Jun 2025 12:36:29 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AB6918003FC;
	Thu, 26 Jun 2025 12:36:26 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 7/9] rtla/tests: Add tests for actions
Date: Thu, 26 Jun 2025 14:34:03 +0200
Message-ID: <20250626123405.1496931-8-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a bunch of tests covering most of both --on-threshold and --on-end.
Parts sensitive to implementation of hist/top are tested for both.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 579c12a85e8f..b354bacd78f8 100644
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
+	"timerlat hist -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
+check "trace output through -A trace with custom filename" \
+	"timerlat hist -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "exec command" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check "multiple actions" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check "hist stop at failed action" \
+	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
+check "top stop at failed action" \
+	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
+check "hist with continue" \
+	"timerlat hist -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "top with continue" \
+	"timerlat top -q -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "hist with trace output at end" \
+	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+check "top with trace output at end" \
+	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 done
 
 test_end
-- 
2.49.0


