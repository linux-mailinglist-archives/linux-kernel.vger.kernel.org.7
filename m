Return-Path: <linux-kernel+bounces-769139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA76B26A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180DA1C254DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCAB21C9E3;
	Thu, 14 Aug 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pffvzpt6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93321B9D6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184153; cv=none; b=mbeEtPxa2tkvP2ee/HfK4z/vVqzDgWFs2Z1X/RI8JZgYfMOaluCbemfPD5IRnOCFrzsUkPuqvM6eoMZzegvIuQQ1wf4Ov/OIsb7aAb2HZHxik621FyoL2E1dTOlb4OXoUa+ZiyiiM/bjRlsLL7LBgwUiV85QNLEjkQ772A7/5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184153; c=relaxed/simple;
	bh=PDHixAkCz2hUGn/9QvUEliZqbUZBqmNiqr4tcOzsd9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJ3E462Ifr1zr6DJbCJdS8KJBG2ESbngl+szSRBEzLKPieStJfS/MHWckAXjNeE3MVK2k2p1XbWCufhoE3KZ7/nPWmJE2OehGUDqz/AFZtsZBPoPTdUmMNaFGnDKj4opbNpu+iZAmZniN1TutC3+AcRm6lrlhFXCIQhrNzHp+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pffvzpt6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgY1l2hyeaoTtIgLtZ3jRMog3VIP/D81DWJyXRv2tfE=;
	b=Pffvzpt6iGgRDEuMzXkkJcuwzQ8V0hCsEKcOaHDOshiMHuYiLccMu4rbQMfzZJ885mckQc
	Qfsqdt5ibpeTW/0hO3SH1GwxNbeepcjh+szPTotxYFOoWxzWOKlRVtPLZB1/3DOtyOcetg
	p00Y7MieEYXsntS5lOgYBDv4ypp6y3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-b7gB0mZxOAWE-kngaOnexQ-1; Thu,
 14 Aug 2025 11:09:06 -0400
X-MC-Unique: b7gB0mZxOAWE-kngaOnexQ-1
X-Mimecast-MFC-AGG-ID: b7gB0mZxOAWE-kngaOnexQ_1755184145
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 718EF18002CD;
	Thu, 14 Aug 2025 15:09:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 229361800280;
	Thu, 14 Aug 2025 15:09:00 +0000 (UTC)
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
Subject: [RFC PATCH 07/17] verification/rvgen: Remove unused variable declaration from containers
Date: Thu, 14 Aug 2025 17:07:59 +0200
Message-ID: <20250814150809.140739-8-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The monitor container source files contained a declaration and a
definition for the rv_monitor variable. The former is superfluous and
can be removed.

Remove the variable declaration from the template as well as the
existing monitor containers.

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
2.50.1


