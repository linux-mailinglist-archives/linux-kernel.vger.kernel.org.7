Return-Path: <linux-kernel+bounces-844071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C8BC0EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DE3C3086
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865C24A069;
	Tue,  7 Oct 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFO2KbaA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EC2D7DCC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830837; cv=none; b=GnWHIX2yEeM8JCSmVa3uYDus0XbehKZi2yjDRvSkkQIDb6rOz5iiqBqj1lmPdPBvR4yRaIBnZWxDLTwkaQZw/JQ00t82SplU5W0Sib+YYqXrtpVYZl8OcZMxXFsRXS+hAmIeknW6XACSz3JA1qJBCFIh19ZjMq3IMGFG8PW+Sg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830837; c=relaxed/simple;
	bh=FxlpX1H2RfzCNZAacZWIc1/ddNhlxgd1jNU+mLDaBfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJ9JAgJt6MTo4CIL8KscKoCVtyGtFVKlpmk+h4caVIBb79EBfDxIy1zzrJG1E3gfIl1sviehUkaAl9LZB7TiLLnN2eEvpurmh/s7yxm70T/oALsHtIH3mREG4WZmtF9uOOj1HXRpECb8omZwDuMk89sEEXwp3rgyhVGOOiq/s24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFO2KbaA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfw1qZEbCpaKdybsFhf5WdXue/7jcyGvMTJdXkduoEc=;
	b=ZFO2KbaAusutnfr9ejf+UbEWXCqiEVX61AEiBhoN66BrlXW+Qe6tqCAmBu343m95VVp3lN
	wAYcumbK9kovIbhYhlYk0mbl7tGDd2A4otqW3QCrzcTb+OPgvJToRLmzDk4iHaTSSnZYoy
	kkqLgqEY16Ofy/s2BdA2b3syZ59z6C0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-NxS8-x-lNG-KVC7lxLbq3w-1; Tue,
 07 Oct 2025 05:53:51 -0400
X-MC-Unique: NxS8-x-lNG-KVC7lxLbq3w-1
X-Mimecast-MFC-AGG-ID: NxS8-x-lNG-KVC7lxLbq3w_1759830830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1E71800365;
	Tue,  7 Oct 2025 09:53:50 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A766A18004D8;
	Tue,  7 Oct 2025 09:53:47 +0000 (UTC)
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
Subject: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
Date: Tue,  7 Oct 2025 11:53:39 +0200
Message-ID: <20251007095341.186923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 8d933d5c89e8 ("rtla/timerlat: Add continue action") moved the
code performing on-threshold actions (enabled through --on-threshold
option) to inside the RTLA main loop.

The condition in the loop does not check whether the threshold was
actually exceeded or if stop tracing was requested by the user through
SIGINT or duration. This leads to a bug where on-threshold actions are
always performed, even when the threshold was not hit.

(BPF mode is not affected, since it uses a different condition in the
while loop.)

Add a condition that checks for !stop_tracing before executing the
actions. Also, fix incorrect brackets in hist_main_loop to match the
semantics of top_main_loop.

Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerlat and hist/top")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: Crystal Wood <crwood@redhat.com>
---
v2:
- add one more patch fixing a bug noticed by Crystal in context of
the following one (doing v2 just to avoid conflicts, the first two
patches were not changed)

 tools/tracing/rtla/src/common.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 2e6e3dac1897..b197037fc58b 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -268,6 +268,10 @@ int top_main_loop(struct osnoise_tool *tool)
 			tool->ops->print_stats(tool);
 
 		if (osnoise_trace_is_off(tool, record)) {
+			if (stop_tracing)
+				/* stop tracing requested, do not perform actions */
+				return 0;
+
 			actions_perform(&params->threshold_actions);
 
 			if (!params->threshold_actions.continue_flag)
@@ -315,20 +319,22 @@ int hist_main_loop(struct osnoise_tool *tool)
 		}
 
 		if (osnoise_trace_is_off(tool, tool->record)) {
+			if (stop_tracing)
+				/* stop tracing requested, do not perform actions */
+				break;
+
 			actions_perform(&params->threshold_actions);
 
-			if (!params->threshold_actions.continue_flag) {
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
-				/* continue action reached, re-enable tracing */
-				if (tool->record)
-					trace_instance_start(&tool->record->trace);
-				if (tool->aa)
-					trace_instance_start(&tool->aa->trace);
-				trace_instance_start(&tool->trace);
-			}
-			break;
+			/* continue action reached, re-enable tracing */
+			if (tool->record)
+				trace_instance_start(&tool->record->trace);
+			if (tool->aa)
+				trace_instance_start(&tool->aa->trace);
+			trace_instance_start(&tool->trace);
 		}
 
 		/* is there still any user-threads ? */
-- 
2.51.0


