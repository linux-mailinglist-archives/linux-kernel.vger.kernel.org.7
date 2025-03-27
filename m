Return-Path: <linux-kernel+bounces-578127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7AA72B29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 09:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B6D18984A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D161FFC4E;
	Thu, 27 Mar 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f78DWvXA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170403BBF2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063192; cv=none; b=bxsqteYKKBT0pyXQcfzX8fOUlUovdBhqMXqeVOkAPgcTcHpQgMteEoeFORajb9hFuym/usy6J40jFfpJYPMzt+zGSK4nb+iiFQSTyWHVnXrwX6Ufd6ZvmdNRGKlOek7fSlEbUlGFZVoSaNVJ0d9hIC+bcIv4QxQG1u5+EDXT/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063192; c=relaxed/simple;
	bh=EbLVbiQlpgq9YG5GIB6FTYiL142vhrzXNYAki+1MxhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5dNZu71zvfwyEmEuzye0o9nLL2SF8AnNkW5zlKG2dO0uk25hEvHbh/Eb0Wxn+k0rghb1zpzgZwKkQdR7g9RF+e6h9JaY0SLK8gxgP/zyU2T/l/O0trp7bB46YhXEwn/3+Z9Bck9ZHOGYz38B82CWyj4AgDBlMKJXp9L8AQlqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f78DWvXA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743063188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BoCOhkTM9KFlUbaH9jkH+YVNAgo79G44mPoieSkwGDM=;
	b=f78DWvXAx/NG0TSZGc7y2zPLAxrr8GSFKRABKJw+1MgSDaeASEzz/QtUPHrUUgJftlEOmr
	RM7QWzc22VvPAQ8OErl9boAsRRlCuP4JKTyYshlKcelfn5saZFLfblPYHMGaRHUD7UaI8q
	0cT3cA37pVfQsPq3xAY/kgsamlVfEDE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-0gFCmPBwPF2fHA64dZ9CNg-1; Thu,
 27 Mar 2025 04:13:05 -0400
X-MC-Unique: 0gFCmPBwPF2fHA64dZ9CNg-1
X-Mimecast-MFC-AGG-ID: 0gFCmPBwPF2fHA64dZ9CNg_1743063184
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E94F1809CA5;
	Thu, 27 Mar 2025 08:13:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.86])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E48B1956095;
	Thu, 27 Mar 2025 08:13:00 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH next] Documentation/rv: Add sched pages to the indices
Date: Thu, 27 Mar 2025 09:12:40 +0100
Message-ID: <20250327081240.46422-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The pages Documentation/tools/rv/rv-mon-sched.rst and
Documentation/trace/rv/monitor_sched.rst were introduced but not
included in any index.

Add them to the respective indices.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 03abeaa63c08 ("Documentation/rv: Add docs for the sched monitors")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/tools/rv/index.rst | 1 +
 Documentation/trace/rv/index.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/tools/rv/index.rst b/Documentation/tools/rv/index.rst
index 8fd16d91d..64ba2efe2 100644
--- a/Documentation/tools/rv/index.rst
+++ b/Documentation/tools/rv/index.rst
@@ -15,6 +15,7 @@ Runtime verification (rv) tool
    rv-mon
    rv-mon-wip
    rv-mon-wwnr
+   rv-mon-sched
 
 .. only::  subproject and html
 
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 15fa96610..e80e0057f 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -12,3 +12,4 @@ Runtime Verification
    da_monitor_instrumentation.rst
    monitor_wip.rst
    monitor_wwnr.rst
+   monitor_sched.rst

base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-latency-v6.15
base-commit: 4ffef9579ffc51647c5eb55869fb310f3c1e2db2
-- 
2.49.0


