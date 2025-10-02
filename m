Return-Path: <linux-kernel+bounces-839857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E227FBB2965
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D987A55DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACA296BD2;
	Thu,  2 Oct 2025 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dfSyplzA"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167E2877DE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385332; cv=none; b=ZePZuYbJ1R3dHjEJ417PfNZPBiIUdH9RqxW6MgIHTqRs+4Tz6lr9h9Mbs3YJvd1pToKy4DGlXgzbXe6Ei+aBrP7X4aUwNELuaR6+DjjM6dCv0EFz2s7yjbHcb0VQnU8LTBRoJk9WNwy6AkJ/95kwD4Cqw7zTQWy/WmkGWWaJ6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385332; c=relaxed/simple;
	bh=+xq60ZeSAVV1ocmjyOiB1hqUauhWVy1UVAEnUaHfa1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cxzo25lKgJCCnrEB+cGT8K1EWYh+TVgBP1xNe7gv8nWs+De8SuYs3k9sJ0Sq13epFh24rVzU54A1cE+P6EVu9ZI5bAmcUM95DRc8ADE02pwAu6F/udDlhhVj8U8ObiTg8HcCCvisJ4sY2KkqPPOUpLV8nEqlC0Bmhodrm8GPSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dfSyplzA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so874397b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385329; x=1759990129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JHjFWe4nSJBuXJLW+4dSgn35y5ppiBpVluUI0Wnqq8=;
        b=dfSyplzArAgDDnWXl0t/mvTcBjYRLmErc9ZyXY1iMdI8qrSMZ/057fk6ktwrkqoTWm
         A+vl8mXxHvKa6YKw83ZuG80AmjseBxd7OguZGZLqyLEDhjpPJLd3syc+xX/MCiJw31Ft
         TC1nK1of8MKzk3wIEEDYbPDIopp6t3BMLitq/tQlVddltB2QzjAVpft1uPeYDQVioCD0
         pmoEoqQVVuvKh94YZJirFcNZynm9VtjyA5JRLhyeWXvK07e/HOHkaslW3ivCziO3KVxK
         yiuwE7OLFqT+Uo0f+giPK50bNQyhFHMoJQwvFRuA/paCOWHxf4f9GS/ael9BNhj4V6yI
         KLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385329; x=1759990129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JHjFWe4nSJBuXJLW+4dSgn35y5ppiBpVluUI0Wnqq8=;
        b=mNqr1InYBIfmBWtOQXDWOuO+p/O9Y/oOXsyMmx0HEGRMnKGhC6TZKzuvGuGZnI0DxL
         eaNbwUi12+psT1sBBo0/tt2c0U0XX60+paMGl+YQ0aNZb4oIDp6UHozYche2VSbJiYTk
         rLjr9JnhzwXTMn/Z8cUL5323KXO8RMpf4ArYO4wUDcvQMiIsIJPP63XjQDNEFSRUcsQA
         juqYCzN2MQpCifLlBHprvAgNuAmHo444tKGNguZUP9L5QU1ynM5DCWLAMvkNJI3vebgr
         0S1zWFMyNTxZT4bjcRYI12/oHjCCeWOMCxZ/3dpTm/VMbZZjS6X6ywV5VoM8gCcIScP2
         DWVw==
X-Forwarded-Encrypted: i=1; AJvYcCUQXKpL1faoYcQ2r3n8WcjFF6X05ArbSDin9XMTFJmPgjXoNEWoTlcacyk9C7Ulf9fZBjzj5KyXvTNUUfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcIrmUekZ6zaJ1QD1GP6gzIQ5v/CV72C1f+3Nk3i1rGopflV1
	mG2VZ2ULU0ep0nBcfOz77qhNLgGMSmpFcdSI733fWz9XkjV3P3SsjE9KS3x1PGkI3eQ=
X-Gm-Gg: ASbGncujqskEGqOKYnrUPpW5Kow+3+0H0hNYDFWHYLo6I/Q6JbWXYUP5FzKe/s/C5hq
	4eMhO3rSx+IJojeL2MnnOtWRErj7IV7X7Y0WA1C5DhbVUfag/hDCmCxIyNK7K/ZzHtc8fFifQnT
	TI5yup8tBXJCfY6vcgvRZi5IGhQQnMX/nbZY3Uk9j6J1cDnxs7fSBUMPxnR9wgjc5eQEDWBXv0f
	miSiZcsUvyp42rWfiJ1tloWlRXn4V8CsF/nnkJfrFdmXBHVvCNjsIHNSP6EWSc5fi4E1UoRYtWm
	xcdYgFFaQSYBf54VGO6YFq8dfjnrJinhB70V+w7n428Rof2rJQXmN6zSEdWfNqmaECEHynxz5eQ
	YwLldB2UkE8qdos8EK3nxhfKeQBUTA3oGonw+JE+S72YUCuOnNq4RrQhyiNLVrdx7gWj6RVwpkq
	VXCJ/IY6whpf6n3Q==
X-Google-Smtp-Source: AGHT+IEVQ8syUgiiA1nKnyUpyfhQ8Ilp5w1llqzl73BCypyrqi5ezsbXFBblcxqXVmPTbmDs4OeyLQ==
X-Received: by 2002:a05:6a21:683:b0:251:e4b4:7a44 with SMTP id adf61e73a8af0-321df6c2562mr8435299637.41.1759385329448;
        Wed, 01 Oct 2025 23:08:49 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:08:49 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a component path
Date: Thu,  2 Oct 2025 11:37:25 +0530
Message-ID: <20251002060732.100213-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mayuresh Chitale <mchitale@ventanamicro.com>

The perf driver framework needs to be able to start / stop all components
in a trace component path during its operation. Add rvtrace_path_start()
and rvtrace_path_stop() functions for this purpose.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/rvtrace-core.c | 44 ++++++++++++++++++++++++
 include/linux/rvtrace.h                  |  6 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
index 7013d50ca569..109be40d4b24 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rvtrace_path *path)
 	}
 }
 
+int rvtrace_path_start(struct rvtrace_path *path)
+{
+	const struct rvtrace_driver *rtdrv;
+	struct rvtrace_component *comp;
+	struct rvtrace_path_node *node;
+	int ret;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		comp = node->comp;
+		rtdrv = to_rvtrace_driver(comp->dev.driver);
+		if (!rtdrv->start)
+			continue;
+
+		ret = rtdrv->start(comp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rvtrace_path_start);
+
+int rvtrace_path_stop(struct rvtrace_path *path)
+{
+	const struct rvtrace_driver *rtdrv;
+	struct rvtrace_component *comp;
+	struct rvtrace_path_node *node;
+	int ret;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		comp = node->comp;
+		rtdrv = to_rvtrace_driver(comp->dev.driver);
+		if (!rtdrv->stop)
+			continue;
+
+		ret = rtdrv->stop(comp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rvtrace_path_stop);
+
 struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
 					 struct rvtrace_component *sink,
 					 enum rvtrace_component_mode mode)
diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
index f2174f463a69..e7bd335d388f 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
 					 struct rvtrace_component *sink,
 					 enum rvtrace_component_mode mode);
 void rvtrace_destroy_path(struct rvtrace_path *path);
+int rvtrace_path_start(struct rvtrace_path *path);
+int rvtrace_path_stop(struct rvtrace_path *path);
 
 /**
  * struct rvtrace_driver - Representation of a RISC-V trace driver
  * id_table: Table to match components handled by the driver
+ * start:        Callback to start tracing
+ * stop:         Callback to stop tracing
  * probe:        Driver probe() function
  * remove:       Driver remove() function
  * get_trace_id: Get/allocate a trace ID
@@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
  */
 struct rvtrace_driver {
 	const struct rvtrace_component_id *id_table;
+	int			(*start)(struct rvtrace_component *comp);
+	int			(*stop)(struct rvtrace_component *comp);
 	int			(*probe)(struct rvtrace_component *comp);
 	void			(*remove)(struct rvtrace_component *comp);
 	int			(*get_trace_id)(struct rvtrace_component *comp,
-- 
2.43.0


