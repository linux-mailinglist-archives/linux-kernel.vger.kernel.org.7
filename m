Return-Path: <linux-kernel+bounces-847955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F1ABCC26A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 911E0351F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD52673B7;
	Fri, 10 Oct 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBmM3tvC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D465262FFF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085285; cv=none; b=qTcM5Enljv46gj+Rqn2sos9YOdhfvU86szEGo8oYU3SiJln9zpLC1gocDvCvMMMtxrjl4IiXJwzngnUrxdXfATufS1paWn7Y1F6e/A9jnPoELPaK/sB1Ms7+uZuSfNsNMOUdOsGW09i9rdpNRjZ58b5fERhQQbJym6B4tfDMYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085285; c=relaxed/simple;
	bh=lAM1OCRdCkIbXWLfPoZpdYZ+SIeHc968B6VtBUf7nJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiU8Q2RbIq5NarRs00B499kOoISf7jZ/1X/6mQdB4ME+ICqRjUyUO0C+1OTGKXRSFrMsNLP00nVHUYB/tlPYf9dVt0NDu7wpg19mTrRExQXfErtickDH+a4J/2+R2ZIX1AAVB0nAlDvlhkZbTQD0QkowsacLUMOXgFMqi0cKdqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBmM3tvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/V9PCnlmfXMNU9IVcL16oTLGCKpj8jIKEGtxCINH5U=;
	b=XBmM3tvC05cS7DtxOw5FQzm6uQPn+TkMvio1/ofHJNd8tmySinU/+OUSJlWA/n2eX05bry
	xElxqc0dCynQ8aI0x4kfwrxICABHrthqT2GV5xXNPj1N8Lc1XiNFMlbQGIhZCk7ZTiDEAM
	zAPkPoQVCETJbYPVdlO0sHuKhUsJ9NQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-jNBY_WpNPVWnwk9Wmrqs1Q-1; Fri,
 10 Oct 2025 04:34:38 -0400
X-MC-Unique: jNBY_WpNPVWnwk9Wmrqs1Q-1
X-Mimecast-MFC-AGG-ID: jNBY_WpNPVWnwk9Wmrqs1Q_1760085277
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF61019560AE;
	Fri, 10 Oct 2025 08:34:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C41919560BB;
	Fri, 10 Oct 2025 08:34:31 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/9] Documentation/rtla: Correct tracer name for common options
Date: Fri, 10 Oct 2025 10:33:34 +0200
Message-ID: <20251010083338.478961-6-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Several options in common_options.rst say "osnoise tracer" for both
osnoise and timerlat.

Use |tool| variable so that the correct tool name is used.

Fixes: b1be48307de4 ("rtla: Add rtla osnoise top documentation")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 8ca424ab0faf..a2f9c03810b9 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -1,6 +1,6 @@
 **-c**, **--cpus** *cpu-list*
 
-        Set the osnoise tracer to run the sample threads in the cpu-list.
+        Set the |tool| tracer to run the sample threads in the cpu-list.
 
 **-H**, **--house-keeping** *cpu-list*
 
@@ -35,7 +35,7 @@
 
 **-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
 
-        Set scheduling parameters to the osnoise tracer threads, the format to set the priority are:
+        Set scheduling parameters to the |tool| tracer threads, the format to set the priority are:
 
         - *o:prio* - use SCHED_OTHER with *prio*;
         - *r:prio* - use SCHED_RR with *prio*;
-- 
2.51.0


