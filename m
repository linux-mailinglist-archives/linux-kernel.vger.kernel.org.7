Return-Path: <linux-kernel+bounces-824670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E56B89D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B90F5A5126
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C18316199;
	Fri, 19 Sep 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyv5x5qm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00ED314A63
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291075; cv=none; b=uZ0ONKRNI5p2Q2Lf1oZWkqXKKNwHVeeWILQDNf60cP61sUflccrOh9DN5sOhDYF34mhQcvaywhiE4I9ZowrJFOOT8Trrm8Q47R+UEG4UF+DT4XQIL3Vdh5bhLij0IoKp+cwlSmbcAYL5GDp885toyOzFqKgnGz338ttDlwQdyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291075; c=relaxed/simple;
	bh=6qgIJ8u1gERU6N730C3amNcSnAQVHmP8n9+eh+nLyvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzO4TYbfh56btsHRZLJZ/JvHO/7wxfN9HdQZRKGp1yDeNbKTM3vvobQUiiYQjyTeesvYvA/dkZITOu09QU3augRO5yar9XEao3AM9I16bRgydjtnQf4JLgVJjW1epzli3/2lSdtdIS8YZErUOSJphDmW7aGM7R9gZI14jQCSPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cyv5x5qm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH7zL8z2soHypFa78bT6ajSkmjk69JdopeRXpRBTaNc=;
	b=Cyv5x5qmChhQ+RAIxNm3FZABx+1m3f68YWmr6g5RnfspT46+fmlyW3tpxmQ+dF/2+VH/ZA
	j+7uQRH2g3EeRwcpTAh3jWCx+wOrsXM30zUeR3vUW48HYsPQmLkcBADJJN+S2g6tMubtRC
	rFcYgOnt/y+cvyJeLOleR3B5JH0tIDI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-g44b1rImNkS4630dZW4snw-1; Fri,
 19 Sep 2025 10:11:08 -0400
X-MC-Unique: g44b1rImNkS4630dZW4snw-1
X-Mimecast-MFC-AGG-ID: g44b1rImNkS4630dZW4snw_1758291067
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB72A1800359;
	Fri, 19 Sep 2025 14:10:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2F541955F43;
	Fri, 19 Sep 2025 14:10:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 09/20] verification/rvgen: Remove unused variable declaration from containers
Date: Fri, 19 Sep 2025 16:09:43 +0200
Message-ID: <20250919140954.104920-10-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The monitor container source files contained a declaration and a
definition for the rv_monitor variable. The former is superfluous and
can be removed.

Remove the variable declaration from the template as well as the
existing monitor containers.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/rtapp/rtapp.c                    | 2 --
 kernel/trace/rv/monitors/sched/sched.c                    | 2 --
 tools/verification/rvgen/rvgen/templates/container/main.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monitors/rtapp/rtapp.c
index fd75fc927d65..17f271231c99 100644
--- a/kernel/trace/rv/monitors/rtapp/rtapp.c
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -8,8 +8,6 @@
 
 #include "rtapp.h"
 
-struct rv_monitor rv_rtapp;
-
 struct rv_monitor rv_rtapp = {
 	.name = "rtapp",
 	.description = "Collection of monitors for detecting problems with real-time applications",
diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
index d04db4b543f9..dd9d96fc6e21 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -8,8 +8,6 @@
 
 #include "sched.h"
 
-struct rv_monitor rv_sched;
-
 struct rv_monitor rv_sched = {
 	.name = "sched",
 	.description = "container for several scheduler monitor specifications.",
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/tools/verification/rvgen/rvgen/templates/container/main.c
index 7d9b2f95c7e9..5fc89b46f279 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -8,8 +8,6 @@
 
 #include "%%MODEL_NAME%%.h"
 
-struct rv_monitor rv_%%MODEL_NAME%%;
-
 struct rv_monitor rv_%%MODEL_NAME%% = {
 	.name = "%%MODEL_NAME%%",
 	.description = "%%DESCRIPTION%%",
-- 
2.51.0


