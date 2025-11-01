Return-Path: <linux-kernel+bounces-881373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21722C2818E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1531895DAF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83F2FB09A;
	Sat,  1 Nov 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ioDoXFBw"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE02F9D83
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011809; cv=none; b=p49XTYMb8PI7lZ6jOtGit9x60QKsEG3hkUBig6cEOGl6a4jbQHOha+aV0RUOoiHsap9RiA6ATxKzx135/RhVWO1mw3ZwGBTUxtQCRWPBr5ReZVhYR45qucYUYOQe75mTxhLEu4Bpi5DZHI+xfJit/EoG0J6KxvmAdvZXHdQGFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011809; c=relaxed/simple;
	bh=BvBD0Z9+XjSQERc0S1HJVRiFVdEPJieSXUF2h1D9pgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIDK3Uw+0fD3caw7RUHWf04iswEOW7UF9nuOcXrrTTCwDwlP3dyaqaXpcz7g4oKr+DEawufq9WwFLWGFjQQpnPXbq6FRyKf/BtNq75xb+FLSUNNFLAQTkflz53EWSaapvRmsxdHfZiKvY9CYd+kyX7LUMAhBpZJRwB4rCKmylRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ioDoXFBw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b98e6ff9071so113293a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011807; x=1762616607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOvY7+y3+k/BpOCCJeQtfZUneWdciA55AKvg4KUFkXw=;
        b=ioDoXFBwA8ZOnkRIz/m1RZ1T6qHrTZBye8CD323znd8X8DdztmjfxKtECI8/4QMYZW
         pjpdhassZDBVWEdMG5mXzXajrh9ZayncN1oY2+RrBrQjMidyXUoM+j8DI9SD4zqYCo25
         YK9ysOzdsEgUhTPBVPJAqDVszhNCwMxhH88zHRzIAOZRiqyP228BD5vd2ehgsEXHn4Tj
         TSpcTmO5KDK04JfROR2cee3cdHmid4PgsfTAS90acZFTMWpTE/0Qi5N5xL44Ka05J/59
         5S5tPZKC6uKx0t78wY9oV6+h2yfD5LQmkfRnZ4xWnVb+jULllf5cQc0oWFmrSS6h7tkk
         1fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011807; x=1762616607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOvY7+y3+k/BpOCCJeQtfZUneWdciA55AKvg4KUFkXw=;
        b=ntoh6H/Bv0eRU5EwsQ/TRB+HAXZyXRKr8g0CESL3YAtgqndmTKxF/s3rcUAFdKQqrc
         zldlcLDUGbGMma6MVxp9kmjzjA3N2B4eUukZMMLDXE9Uke4xo2y6v2ZuPXugRvV0hUQO
         Fk01Pl7oKAY8L1V3HpoTCkV9AZKbpmkI9ldgqq/Ow6CtSo1giorXD37ZINnLiOHcsBPx
         nvZs05kpbCZz8yx6NYhI+OCrRqVowEhVxPkpu74/uy3UrLrrHGZyNU3qjURDWvm2nfH/
         Uzi1w7i6cSJjw2InQ/sAn+yLjMazwB220Iyr3Bbrfs2hzbqK2tw5Rm5F00VZcLKN853E
         zmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvOFnYqeLqoSbuTkiTPpXxaGkZ6OVWyRcWuaiR6DS0mdj5ghvIGgOX/DUO1nkk6V4/aKkbUBQSnRxelM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmW8bWmK4NrD5sLyum71R5sguImP4o0IdgOaaUbibw+qvr1dE
	xWXMcVuXs7OwPU4xjVpusAinJREgATCXhHt0+3XT3Z2ZxnAYZf/oAlIbNoKIK6hkPkY=
X-Gm-Gg: ASbGncsk4ROmUeAvg51nVXgIPAvwVlmMFhtYy0YfANPxWgw2N7QpJ8fFn/hR/dClrsa
	8tk8EtzZiTR2DlD4DXzhTiXjtW79byjFXHqm4RwlMU1QhdfG6q+4X59983bv7CIqSsucUXdxTrw
	eBRCzlFZj/LETCJ838dzcaoEw3Ko9oD/BvO5YIDMZX6CNwb7/CURQFtFQOKZZTNg/aOHN2jUaN7
	cozQFrAgafIRNZEfNpwYSd0bsSu5Ssd4pSB2x5SgXaPfjcxzU9W2f83U73frlANgzLBHCI/KZCe
	pxvWihBY9Wpg7ock5FjPX1jZVoGTNuRbhw9r9DC25M6P+MMSTOP7IMX82oMgdzhsskeQWzDVMJ9
	naGmmstfZ60QQArSRWJ/tXuffLV3yFX3udODJSwkqnNMUsMATZdm+gEr5j4XPYt7KCmc/bsgGav
	jM9eg4hjn9phFfyd0ThulhUdf2s9bjqTvDN+xcQXlIx+ss6H4fS5KQ
X-Google-Smtp-Source: AGHT+IEfN3sDw4+c9kAcEeOlETsmvroTxjtc7mSSvF7SLOSV5F4wykTjDG1l/xLBcJfYOVZ8mhA2wg==
X-Received: by 2002:a17:903:41ce:b0:295:82d0:9baa with SMTP id d9443c01a7336-29582d0a17cmr2501135ad.17.1762011806967;
        Sat, 01 Nov 2025 08:43:26 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:43:26 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 03/12] rvtrace: Add functions to create/destroy a trace component path
Date: Sat,  1 Nov 2025 21:12:36 +0530
Message-ID: <20251101154245.162492-4-apatel@ventanamicro.com>
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

Trace needs to be configured on a chain of trace components which are
connected to each other. These chain of components is also referred
to as trace component path. Add functions to create/destroy a trace
component path which will be later used by RISC-V trace perf support.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/rvtrace-core.c | 223 +++++++++++++++++++++++
 include/linux/rvtrace.h                  |  43 ++++-
 2 files changed, 264 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
index 32fda1647b39..7006a4469d62 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -211,6 +211,53 @@ int rvtrace_disable_component(struct rvtrace_component *comp)
 }
 EXPORT_SYMBOL_GPL(rvtrace_disable_component);
 
+static int __rvtrace_walk_output_components(struct rvtrace_component *comp,
+					    bool *stop, void *priv,
+					    int (*fn)(struct rvtrace_component *comp, bool *stop,
+						      struct rvtrace_connection *stop_conn,
+						      void *priv))
+{
+	struct rvtrace_connection *conn, *stop_conn = NULL;
+	struct rvtrace_platform_data *pdata = comp->pdata;
+	int i, ret;
+
+	for (i = 0; i < pdata->nr_outconns; i++) {
+		conn = pdata->outconns[i];
+		ret = __rvtrace_walk_output_components(conn->dest_comp, stop, priv, fn);
+		if (ret)
+			return ret;
+		if (*stop) {
+			stop_conn = conn;
+			break;
+		}
+	}
+
+	ret = fn(comp, stop, stop_conn, priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int rvtrace_walk_output_components(struct rvtrace_component *comp, void *priv,
+				   int (*fn)(struct rvtrace_component *comp, bool *stop,
+					     struct rvtrace_connection *stop_conn,
+					     void *priv))
+{
+	bool stop = false;
+	int ret;
+
+	if (!comp || !fn)
+		return -EINVAL;
+
+	mutex_lock(&rvtrace_mutex);
+	ret = __rvtrace_walk_output_components(comp, &stop, priv, fn);
+	mutex_unlock(&rvtrace_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rvtrace_walk_output_components);
+
 struct rvtrace_component *rvtrace_cpu_source(unsigned int cpu)
 {
 	if (!cpu_present(cpu))
@@ -463,6 +510,182 @@ void rvtrace_unregister_component(struct rvtrace_component *comp)
 }
 EXPORT_SYMBOL_GPL(rvtrace_unregister_component);
 
+struct rvtrace_path_node {
+	struct list_head		head;
+	struct rvtrace_component	*comp;
+	struct rvtrace_connection	*conn;
+};
+
+struct rvtrace_component *rvtrace_path_source(struct rvtrace_path *path)
+{
+	struct rvtrace_path_node *node;
+
+	node = list_first_entry(&path->comp_list, struct rvtrace_path_node, head);
+	return node->comp;
+}
+EXPORT_SYMBOL_GPL(rvtrace_path_source);
+
+struct rvtrace_component *rvtrace_path_sink(struct rvtrace_path *path)
+{
+	struct rvtrace_path_node *node;
+
+	node = list_last_entry(&path->comp_list, struct rvtrace_path_node, head);
+	return node->comp;
+}
+EXPORT_SYMBOL_GPL(rvtrace_path_sink);
+
+static int rvtrace_assign_trace_id(struct rvtrace_path *path)
+{
+	const struct rvtrace_driver *rtdrv;
+	struct rvtrace_component *comp;
+	struct rvtrace_path_node *node;
+	int trace_id;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		comp = node->comp;
+		rtdrv = to_rvtrace_driver(comp->dev.driver);
+
+		if (!rtdrv->get_trace_id)
+			continue;
+
+		trace_id = rtdrv->get_trace_id(comp, path->mode);
+		if (trace_id > 0) {
+			path->trace_id = trace_id;
+			return 0;
+		} else if (trace_id < 0) {
+			return trace_id;
+		}
+	}
+
+	return 0;
+}
+
+static void rvtrace_unassign_trace_id(struct rvtrace_path *path)
+{
+	const struct rvtrace_driver *rtdrv;
+	struct rvtrace_component *comp;
+	struct rvtrace_path_node *node;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		comp = node->comp;
+		rtdrv = to_rvtrace_driver(comp->dev.driver);
+
+		if (!rtdrv->put_trace_id)
+			continue;
+
+		rtdrv->put_trace_id(comp, path->mode, path->trace_id);
+	}
+}
+
+static bool rvtrace_path_ready(struct rvtrace_path *path)
+{
+	struct rvtrace_path_node *node;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		if (!node->comp->ready)
+			return false;
+	}
+
+	return true;
+}
+
+struct build_path_walk_priv {
+	struct rvtrace_path		*path;
+	struct rvtrace_component	*sink;
+};
+
+static int build_path_walk_fn(struct rvtrace_component *comp, bool *stop,
+			      struct rvtrace_connection *stop_conn,
+			      void *priv)
+{
+	struct build_path_walk_priv *ppriv = priv;
+	struct rvtrace_path *path = ppriv->path;
+	struct rvtrace_path_node *node;
+
+	if ((!ppriv->sink && rvtrace_is_sink(comp->pdata)) ||
+	    (ppriv->sink && ppriv->sink == comp))
+		*stop = true;
+
+	if (*stop) {
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (!path)
+			return -ENOMEM;
+		INIT_LIST_HEAD(&node->head);
+		rvtrace_get_component(comp);
+		node->comp = comp;
+		node->conn = stop_conn;
+		list_add(&node->head, &path->comp_list);
+	}
+
+	return 0;
+}
+
+static void rvtrace_release_path_nodes(struct rvtrace_path *path)
+{
+	struct rvtrace_path_node *node, *node1;
+
+	list_for_each_entry_safe(node, node1, &path->comp_list, head) {
+		list_del(&node->head);
+		rvtrace_put_component(node->comp);
+		kfree(node);
+	}
+}
+
+struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
+					 struct rvtrace_component *sink,
+					 enum rvtrace_component_mode mode)
+{
+	struct build_path_walk_priv priv;
+	struct rvtrace_path *path;
+	int ret = 0;
+
+	if (!source || mode >= RVTRACE_COMPONENT_MODE_MAX) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
+	if (!path) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	INIT_LIST_HEAD(&path->comp_list);
+	path->mode = mode;
+	path->trace_id = RVTRACE_INVALID_TRACE_ID;
+
+	priv.path = path;
+	priv.sink = sink;
+	ret = rvtrace_walk_output_components(source, &priv, build_path_walk_fn);
+	if (ret < 0)
+		goto err_release_path_nodes;
+
+	if (!rvtrace_path_ready(path)) {
+		ret = -EOPNOTSUPP;
+		goto err_release_path_nodes;
+	}
+
+	ret = rvtrace_assign_trace_id(path);
+	if (ret < 0)
+		goto err_release_path_nodes;
+
+	return path;
+
+err_release_path_nodes:
+	rvtrace_release_path_nodes(path);
+	kfree(path);
+err_out:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rvtrace_create_path);
+
+void rvtrace_destroy_path(struct rvtrace_path *path)
+{
+	rvtrace_unassign_trace_id(path);
+	rvtrace_release_path_nodes(path);
+	kfree(path);
+}
+EXPORT_SYMBOL_GPL(rvtrace_destroy_path);
+
 int __rvtrace_register_driver(struct module *owner, struct rvtrace_driver *rtdrv)
 {
 	rtdrv->driver.owner = owner;
diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
index e8e055ad6583..4b31ab96e721 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -8,6 +8,8 @@
 
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/types.h>
@@ -72,6 +74,12 @@ enum rvtrace_component_impid {
 	RVTRACE_COMPONENT_IMPID_MAX
 };
 
+/* Supported usage modes for RISC-V trace components */
+enum rvtrace_component_mode {
+	RVTRACE_COMPONENT_MODE_PERF,
+	RVTRACE_COMPONENT_MODE_MAX
+};
+
 /**
  * struct rvtrace_connection - Representation of a physical connection between
  * two RISC-V trace components.
@@ -238,22 +246,53 @@ int rvtrace_poll_bit(struct rvtrace_platform_data *pdata, int offset,
 int rvtrace_enable_component(struct rvtrace_component *comp);
 int rvtrace_disable_component(struct rvtrace_component *comp);
 
+int rvtrace_walk_output_components(struct rvtrace_component *comp, void *priv,
+				   int (*fn)(struct rvtrace_component *comp, bool *stop,
+					     struct rvtrace_connection *stop_conn,
+					     void *priv));
 struct rvtrace_component *rvtrace_cpu_source(unsigned int cpu);
 
 struct rvtrace_component *rvtrace_register_component(struct rvtrace_platform_data *pdata);
 void rvtrace_unregister_component(struct rvtrace_component *comp);
 
+/**
+ * struct rvtrace_path - Representation of a RISC-V trace path from source to sink
+ * @comp_list: List of RISC-V trace components in the path
+ * @mode:      Usage mode for RISC-V trace components
+ * @trace_id:  ID of the trace source (typically hart id)
+ */
+struct rvtrace_path {
+	struct list_head		comp_list;
+	enum rvtrace_component_mode	mode;
+	u32				trace_id;
+#define RVTRACE_INVALID_TRACE_ID	0
+};
+
+struct rvtrace_component *rvtrace_path_source(struct rvtrace_path *path);
+struct rvtrace_component *rvtrace_path_sink(struct rvtrace_path *path);
+struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
+					 struct rvtrace_component *sink,
+					 enum rvtrace_component_mode mode);
+void rvtrace_destroy_path(struct rvtrace_path *path);
+
 /**
  * struct rvtrace_driver - Representation of a RISC-V trace driver
  * id_table: Table to match components handled by the driver
- * probe:    Driver probe() function
- * remove:   Driver remove() function
+ * probe:        Driver probe() function
+ * remove:       Driver remove() function
+ * get_trace_id: Get/allocate a trace ID
+ * put_trace_id: Put/free a trace ID
  * driver:   Device driver instance
  */
 struct rvtrace_driver {
 	const struct rvtrace_component_id *id_table;
 	int			(*probe)(struct rvtrace_component *comp);
 	void			(*remove)(struct rvtrace_component *comp);
+	int			(*get_trace_id)(struct rvtrace_component *comp,
+						enum rvtrace_component_mode mode);
+	void			(*put_trace_id)(struct rvtrace_component *comp,
+						enum rvtrace_component_mode mode,
+						u32 trace_id);
 	struct device_driver	driver;
 };
 
-- 
2.43.0


