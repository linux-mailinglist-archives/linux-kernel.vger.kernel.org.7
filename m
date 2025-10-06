Return-Path: <linux-kernel+bounces-843065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAFBBBE574
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5960B4EFC9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA62D661C;
	Mon,  6 Oct 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pjso6MV7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E12D5C95
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760890; cv=none; b=G9QVo6a/5GJi8HTyDfxPVAWpNobLcaY7OYhS2M6IOQW5PZJifCAhdmgBdmyrQ0dIhbGdTA2yUE2NFZ6yRh2AM/alcg1LE7+Fq49nwvR4z4xluj5QhfSbvvQ1Np0+4oDmWooLOUzCcILurqgrLjboebJ94V0CkBqaZm7z01lh7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760890; c=relaxed/simple;
	bh=36M0MNbgV00Pqi5+l51V9XYis+XFYGG0olx3EDkVhg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgBEPBCbWpYSB2wJ2hHwD7c8B8pHsTAY468EzPz5TXu5Mo4S+O+gCdujd0hNZyviTDbYe7D+sNiSOrafC5QbjYEpYiuit5AR45g2AxtQYZQHxei+vBZe7JgyVRckzgzBWPVe3yevnvThteJPViAQFXyvG1/zHxGTTnq/nO0hrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pjso6MV7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759760886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG62RW4qXh/xHnupCaMWDYV5gWCoTE5hgP0ELuR9B7s=;
	b=Pjso6MV7nJqAjtM937ItmLGyekiTZe1GD94cvejJr0zsVUqlXRRAsYoc4pf908q6Tkumr9
	wLK/0fHu4HcOh8IqBCb0KO+VxFHkg4HMHez/+vWHAGZyjA6b+QSWxULAaEmWyJC6q9trnD
	elWxYgpTg9QZUX156/nN7rszmxOlFcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-jBEpJYMKOe65fpJr5IJDzA-1; Mon,
 06 Oct 2025 10:28:03 -0400
X-MC-Unique: jBEpJYMKOe65fpJr5IJDzA-1
X-Mimecast-MFC-AGG-ID: jBEpJYMKOe65fpJr5IJDzA_1759760882
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82DD31800447;
	Mon,  6 Oct 2025 14:28:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B25418004D8;
	Mon,  6 Oct 2025 14:27:59 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rtla/tests: Extend action tests to 5s
Date: Mon,  6 Oct 2025 16:26:15 +0200
Message-ID: <20251006142616.136296-2-tglozar@redhat.com>
In-Reply-To: <20251006142616.136296-1-tglozar@redhat.com>
References: <20251006142616.136296-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In non-BPF mode, it takes up to 1 second for RTLA to notice that tracing
has been stopped. That means that action tests cannot have a 1 second
duration, as the SIGALRM will be racing with the threshold overflow.

Previously, non-BPF mode actions were buggy and always executed
the action, even when stopping on duration or SIGINT, preventing
this issue from manifesting. Now that this has been fixed, the tests
have become flaky, and this has to be adjusted.

Fixes: 4e26f84abfb ("rtla/tests: Add tests for actions")
Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise actions")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t  | 4 ++--
 tools/tracing/rtla/tests/timerlat.t | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index e3c89d45a6bb..08196443fef1 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -39,9 +39,9 @@ check "hist stop at failed action" \
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check "hist with continue" \
-	"osnoise hist -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-	"osnoise top -q -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"osnoise top -q -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "hist with trace output at end" \
 	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 check "top with trace output at end" \
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b5d1e7260a9b..b550a6ae2445 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -60,9 +60,9 @@ check "hist stop at failed action" \
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
 check "hist with continue" \
-	"timerlat hist -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"timerlat hist -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-	"timerlat top -q -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"timerlat top -q -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "hist with trace output at end" \
 	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check "top with trace output at end" \
-- 
2.51.0


