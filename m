Return-Path: <linux-kernel+bounces-769148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF917B26AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B003BA331
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DD22B8C5;
	Thu, 14 Aug 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzdChFPJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205925B692
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184209; cv=none; b=UU4DqR7KrHrIeZC74yDOU9m27Adc8UlaRoVakFS5KwEzVnaKdbcqnrhUAcp5prlVK+v+QH1Cwd52qLxU0ChF9Sw2JbYJHtIzXdiF8JzgsuiiHEPrt1BYg2t49KZZ4uXfbdQfgLm+ng5xh6amq2EBwtAXxWeumY2RxO2/Ibz+ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184209; c=relaxed/simple;
	bh=TbAyM75ete4KxOq3Wb5GKnqC5jxCBw/JYCErZmv9xuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRVyucpbuf623p7wuhBUaH7UIfb1t4bOd1Z1yUo4S8OhEoGmIzxh7L+f4gdmdyn7zl7/qriKQOdNrBZeIZOsVv8IvAxO/Wibvm4ICQWkLRloisp++fkmIOK42O0Az8desn6kVYeT+GGguLOS/LhHa2ky4Bx8bylTAGU4KcCgyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzdChFPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKc50jFzFH6l+wMP8OBNSn2fspct4LoKqLl2E2Pv+sk=;
	b=QzdChFPJVL7Nhetvu71WTa85kEguhO7pRgEGm0+0ZkdZLvSJBDL3QGfbIS1jSs/hhxM8VO
	mSbOcx9hTw1srQ9GoHtNjyJ55hkKwCHGwHdvZDMm40/S6YsTOaQm5uhdxUU87krFu64/M4
	iw18xguI6ns0G1nxQmxgzqvta3YohLU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-oSC69V7cOmmzSB6WD2x4wQ-1; Thu,
 14 Aug 2025 11:10:04 -0400
X-MC-Unique: oSC69V7cOmmzSB6WD2x4wQ-1
X-Mimecast-MFC-AGG-ID: oSC69V7cOmmzSB6WD2x4wQ_1755184203
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35998180035F;
	Thu, 14 Aug 2025 15:10:03 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB7A4180047F;
	Thu, 14 Aug 2025 15:09:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 16/17] verification/rvgen: Add support for per-obj monitors
Date: Thu, 14 Aug 2025 17:08:08 +0200
Message-ID: <20250814150809.140739-17-gmonaco@redhat.com>
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

The special per-object monitor type was just introduced in RV, this
requires the user to define some functions and type specific to the
object.

Adapt rvgen to add stub definitions for the monitor_target type, the
da_get_id() function and other modifications required to create
per-object monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py     | 20 ++++++++++++++++++++
 tools/verification/rvgen/rvgen/generator.py |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index 1f6ad11117ac..951bdb893592 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -23,10 +23,14 @@ class dot2k(Monitor, Dot2c):
         self.monitor_class = extra_params["monitor_class"]
 
     def fill_monitor_type(self) -> str:
+        if self.monitor_type == "per_obj":
+            return self.monitor_type.upper() + """
+typedef /* XXX: define the target type */ *monitor_target;"""
         return self.monitor_type.upper()
 
     def fill_tracepoint_handlers_skel(self) -> str:
         buff = []
+        buff += self.fill_per_obj_definitions()
         buff += self.fill_hybrid_definitions()
         for event in self.events:
             buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
@@ -41,6 +45,9 @@ class dot2k(Monitor, Dot2c):
             if self.monitor_type == "per_task":
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;");
                 buff.append("\tda_%s(p, %s%s);" % (handle, event, self.enum_suffix));
+            elif self.monitor_type == "per_obj":
+                buff.append("\tmonitor_target t = /* XXX: how do I get t? */;");
+                buff.append("\tda_%s(t, %s%s);" % (handle, event, self.enum_suffix));
             else:
                 buff.append("\tda_%s(%s%s);" % (handle, event, self.enum_suffix));
             buff.append("}")
@@ -130,6 +137,19 @@ class dot2k(Monitor, Dot2c):
         """Stub, not valid for deterministic automata"""
         return []
 
+    def fill_per_obj_definitions(self) -> list:
+        if self.monitor_type == "per_obj":
+            return ["""
+/*
+ * da_get_id - Get the id from a target
+ */
+static inline da_id_type da_get_id(monitor_target target)
+{
+	return /* XXX: define how to get an id from the target */;
+}
+"""]
+        return []
+
     def fill_main_c(self) -> str:
         main_c = super().fill_main_c()
 
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index b80af3fd6701..5eac12e110dc 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -243,7 +243,7 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
 
 
 class Monitor(RVGenerator):
-    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3, "per_obj" : 4 }
 
     def __init__(self, extra_params={}):
         super().__init__(extra_params)
-- 
2.50.1


