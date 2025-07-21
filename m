Return-Path: <linux-kernel+bounces-738887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E9FB0BEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7053B60A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AA286D62;
	Mon, 21 Jul 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvfQX42u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA892868B3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086235; cv=none; b=b0dHQTxe7PwIZkmkCmK7Z2lWC6iN0lP6nyKQl6Y6+Ed11WL+1n6wSiuCLGR3xUAolkj22h7tV1neFa8Cd1PVceOF2aNwOWUWX54M+ULgZ3TDANJLhaCO0MvglMVdFe1VHtD3j5+VpgU/2hu89ti9Absz0Glqfyb8BASqlHwBxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086235; c=relaxed/simple;
	bh=gZvnCyzT94DpCREmxdginhfhek6gmlmOdWnTxReCN1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9NgUNZgTFgeh97BJjk0KjxOCybuT2BZQGW0AI/MNe+miMGhNn2EHHtvxO/HgOtz5HH4Yj3wChBJrZm+7iUX8tUamdMmmjLBzSc099BXaz2eIrSK9ozRhXAXfk/1OoEBB2ak8OatT1F3v2EEJhdlAgkG6gS3niTc1oZtTK1p1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvfQX42u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj333lUCIB4V6IPQk4nZylzE1knRGwszQN1YzGQpw1A=;
	b=JvfQX42uwVBLo4131O/B5l4NqWRu9s4ae2+0ZIkKXvgLQNvzbyRxJfLdlPvuzzorQv0LN2
	/XXO18pxiHQK95vRxpZE6o361g3pD/RZFLOUZtAlnboMDzRzVbPD6vJDlQxs5sVmbtLNQD
	4lcEcHoebv6B2CxNxeREBKO+c9mPw7w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-pKY6H28BP8GOJbK_f1hdCg-1; Mon,
 21 Jul 2025 04:23:49 -0400
X-MC-Unique: pKY6H28BP8GOJbK_f1hdCg-1
X-Mimecast-MFC-AGG-ID: pKY6H28BP8GOJbK_f1hdCg_1753086228
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E699C19560B4;
	Mon, 21 Jul 2025 08:23:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8165E195608D;
	Mon, 21 Jul 2025 08:23:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 01/14] tools/rv: Do not skip idle in trace
Date: Mon, 21 Jul 2025 10:23:11 +0200
Message-ID: <20250721082325.71554-2-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, the userspace RV tool skips trace events triggered by the RV
tool itself, this can be changed by passing the parameter -s, which sets
the variable config_my_pid to 0 (instead of the tool's PID).
This has the side effect of skipping events generated by idle (PID 0).

Set config_my_pid to -1 (an invalid pid) to avoid skipping idle.

Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index c0dcee795c0de..4bb746ea6e173 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -431,7 +431,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	if (config_has_id && (config_my_pid == id))
 		return 0;
-	else if (config_my_pid && (config_my_pid == pid))
+	else if (config_my_pid == pid)
 		return 0;
 
 	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
@@ -734,7 +734,7 @@ static int parse_arguments(char *monitor_name, int argc, char **argv)
 			config_reactor = optarg;
 			break;
 		case 's':
-			config_my_pid = 0;
+			config_my_pid = -1;
 			break;
 		case 't':
 			config_trace = 1;
-- 
2.50.1


