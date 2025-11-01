Return-Path: <linux-kernel+bounces-881374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748EC28199
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E7854EB0C3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF02FB601;
	Sat,  1 Nov 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lA8Raf54"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A512F83CC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011817; cv=none; b=a0T3yEUJJAJZuMgngSTl3C6yiLiHXad+oSQ0ARxefU94dYwCe5ux8fSfXyA1UpPtzDeavc3HizOCpH//rBrCdsc5MX2gVCkHB8CYr6gj8P0FTtTnidOlfIvgdLmEOKACjXN0dMERucYDJ04+nGUYIoT5RvE0SZoY4+BGeKDcrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011817; c=relaxed/simple;
	bh=/B8Y/5QX6tFLftY6wKUyS0+gWGKDmzQfDNzD5G0vJ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BibQ8XC1UOiyX3nCIyZZ15dR7ytk6wnULR9/W/fvcZ8f/nOoSg6LhXLbwQPonVetSR1VRcNdUEx05yi/EUugSJjqZ4qjDJ6Vx1B565scKlEaI3oJlyiXfiyMzAs93nRXWPAFW96Xh+wKkLle6rJ3N7/+GunkOfEoG+SwLjyrAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lA8Raf54; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26a0a694ea8so24279495ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011816; x=1762616616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfEP9PIU9MbWencudNocKuygkeJ/OR2b1cy84VkwN7s=;
        b=lA8Raf541lNlrj10Km9ucFx3K0m933YJP23P/cPyGjVsDZO6nuhKp+CqGTpiYZumYt
         zwlOWdGxopQ+DMMT3Tdvsj6jJ3pKEKkZtq8SfVn5WsXCQvWye7/xW+3YYXEly/Qb98jA
         fKOWJgXgxh+gzQrdmNkM5DWyUE8uwFHfjxVMbhHpVyFZ78NXG3nsVBiiERC1sL8+6Fp7
         om+CR41O2CUV+VmoH5kgQwKZ/z3XfaLdPYpW23EZCHuEyM+6IAzv8dMgQgB+lbHNooFx
         9gLr3Bxu/tOj2CVmo0vosyea3yVw7+txMMCQiA/L7Kyyz7wAFTsErEOAIe8ch0uhL6zr
         erJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011816; x=1762616616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfEP9PIU9MbWencudNocKuygkeJ/OR2b1cy84VkwN7s=;
        b=PnmN3SnGBOxcg33MxKDhUXAzHNzPTQZVNK6b/aROJylwu6vFW87AyoRTCVtkQDTrEM
         p6PhByvLtb3RkcBFNQgJuQgShQJjohCQzYqOHlHGn3F4omv1PmxGmTKig8gm3fZo0x/m
         1gjhHBCCDLVe/4Q9AM/rSpTE0g7G1dgv8l2HqSWdjX7dQl4/ijwNH7sFC8It7RKeXSGD
         xr/tIwktrarLufOZDlwjP0bSXRTkr8XVubTF0wIO+QtJrZsDfJLK+jyuBp9OQRlUP1ta
         wg2S1wASks2vOsn55JE7xNVQaHD5Ac3X882Mzv3HK6IhGXdAsnX11EaUZZsBGjdWVFlU
         /d3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQVBzzNWV9Rzp7aqoNlGQRHk66cJCHh3GaDtEKUqzXnOgvnSeHMl8t/8QzooCMh0x/gr5zYz5A2D/sZJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgU8G+APDn/trE3GqG4IHiRqCCllx7kYtE0IXBMmP7/cU3bXI
	x59DIqT9eFYFa9gxz86FKMpqcAirhvyEmUWvqaP9fH0FB+jB09CSfEy/tgc+SM4wcBs=
X-Gm-Gg: ASbGncveBQ2kyOvbsPBQ/BcvQAGK8r12/PCmBWe+5CphuLkDLN+qeqIJY/1D+astdO/
	0w54LyA5Ver+ehPJTjCxRJGYzMqBqAKQ9kSt7dFRHKPLmBO5D9S3PwKD7aTwOKaYKY0VWPq/Cwy
	qdaAQATM5esWpXTHFdKrW5lWVn3UAJTF42++7yG7T4nVgdBodIKmEMeLG5O+9JoetojIftbe4+l
	Sx7hZwejoHLINUXw+Of3Czmp7Dz/xTs9mwhYxMeeFgouHRlUt2N91oE28GY2PYPYt9yk6LKWM0L
	3PpGylgy/4dV+pq7GhkUkNzBG7h4lLthseOd7wG6dXXJlfJ8kNtgKInZCTa4x+Z+CJL9HDpLdoW
	yKOrtJxT9lyeiG11z24aLzeuwpCyzTeaLsD0hnVt/XrtID6rJHHzpsj8EVeKv+VsdXwttLCSQx2
	DUOuLNriUnkoSFaQJ4i7TsBQ/KyGUfiNtjB+48IcjJWw==
X-Google-Smtp-Source: AGHT+IE3shkEkgNOrmF/SQpIoxDdNl0ITxKDPFu9uZQNBFl+V+HOFkfpCYl/Xzoqo1IWNRiPw24eiA==
X-Received: by 2002:a17:903:2285:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-2951a4bf845mr83133985ad.56.1762011815528;
        Sat, 01 Nov 2025 08:43:35 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:43:34 -0700 (PDT)
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
Subject: [PATCH v2 04/12] rvtrace: Add functions to start/stop tracing on a component path
Date: Sat,  1 Nov 2025 21:12:37 +0530
Message-ID: <20251101154245.162492-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101154245.162492-1-apatel@ventanamicro.com>
References: <20251101154245.162492-1-apatel@ventanamicro.com>
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
index 7006a4469d62..35bd77d6880a 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -631,6 +631,50 @@ static void rvtrace_release_path_nodes(struct rvtrace_path *path)
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
index 4b31ab96e721..e2842e8728d4 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -274,10 +274,14 @@ struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
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
@@ -286,6 +290,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
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


