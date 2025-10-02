Return-Path: <linux-kernel+bounces-839856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D93BB295F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC7517485A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0528C5A3;
	Thu,  2 Oct 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mdinp/KY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6628507C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385325; cv=none; b=tMVRg00BNSRs7Cuym4O1YqLYvrXJ1Zp4nzHZoBkjGWQOGwUY3HvpX/vX7qUlfCcYYSYXHdaKYdX/sfoxDtegw3cvR52kNc2ixcUnEr5yVDd1jfCSwdGhMTimA8fTstObfyFEhm1V/6f0gSxsff7WndXgtIJC5fXo5OioUo7d3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385325; c=relaxed/simple;
	bh=IghswXhFNIp7efTk/BphgUDtNxmQwDcFVTHaXFgsxjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4YZgRebQaUt8rt3+op5Y/K7IIIGoG/uSathuTwLUJH0HhLNJd6GHKDn379J48K1Voi83/aQH+rjXQ34GopuSTIMtQXj/q6t4EdjNA6iWJ8LBLWuhGRWK3EyxZBoaNhCHjptyx+lB8v/IHo1HGd0aUP1j6hXzK7OVW/cpDQf5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mdinp/KY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so677811b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385323; x=1759990123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDMrSo5zE78/yp6K2Yzv6nvOvNQV4+z5IjijgGyjqfE=;
        b=mdinp/KYOqdNKGd+3wpVTON9hWGWNVaAvWRXObcomDwURi/AwzqRGOWisoSi76BCx7
         9iSIWDzBxnyE2zlq1v25myicdZfV5eiEPJI2p6d/sVbOfd8lhdGySo1z6X0o2hMg6GXx
         eo65dvUxG9pciHmtiG1Tkb8cq8y/ZgKZPDvutBliobSGi+8rG+3x4f0zJzUZawAmadZc
         4cqtvCL2Wi9bUi9HOpF0tWGxAsXqT5qakinvHy/6MlE3RNA3kVliZUeOOcyO5jW4ook8
         wtz21var82vZn5Tcl+xY4vJs5rTiQ111k+JdsSOStSewYpFhT6UY9UwEkw0cjaG6+uU4
         GzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385323; x=1759990123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDMrSo5zE78/yp6K2Yzv6nvOvNQV4+z5IjijgGyjqfE=;
        b=nFG6rzlf42bAPgP+rkH1zPoYU5gR3WnukVwCmYPWa40QrUPtbbkgP3JDNEDAnWEhs+
         qpJ4PSeJ4V/a7Z/xnGbxw0jK8WnQ0YjUF/fs9ExEeUic5uvjVmVexdK9BE/eCXsT+jkl
         W72lRSdn5++3tA9nI85BO+LF1P2qkP2lU26ffrxIss+lRy32a/EpWDMsOvZMB6XI7E74
         zynjm4r7mDq0QgUOUR3g/vo/OWmqcHIj8UAvgjVvnbP9Ibg78x95gPQAjyhp+ixyIhWh
         T9eksjWVHHZgIxT3MXucqanza22XqM/moxXBatJdW7FUKlqJjISqsMr4ZL48Hquzv9Qb
         GrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUFYMmTEK9HmOoqgWus+RefDs6+tcuwgmB9QuZtDF72GVZz2/QCTKyFAXSSQTcQ5nmYFoaBUeWXmUL47oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7AS2IuWHsjncx8zNqUFZ6LjvrKyZs0LH6MrD6Q2pX3q3a9ZL
	aLtjWepK6fOIR9tW7tnA2Bi/Uyg32bZOmTBZx9qoggdpuryvUnK5dQnDTwPoUSgQQCA=
X-Gm-Gg: ASbGnctoACrn4lUJFV/3CYHWR+gdp2y6CCqvimQOlOW0Si4IwXkU5GIudo5Z07SbFtA
	cTSe+TZM0444xYxKP5tPIxqu+xS+mjEfRLwNb88s3q6lHkqGMy6d52TFqJV0+1LHigUER8pY9ZI
	lPnWq8KIdmjyD0igoRU89wMvXqjlNutGslP72lLLld6dZKTllPiL49Rwuf/fZZvqsEigW2uqG/R
	x/3SiENp+ZGnzqodmVpQ7Sbc+ohmj6+hhDhT1+ijIgN9ZvbuXNmPsq3pEmNLdevBtW5FHb26DzZ
	SKBHwTTnhKVSMVRJ8DsGbD7atM3o5zHAB9jPqa4mW9cG7t7Rp05pXV6Xp2pnosAgmcVYbI2+/bG
	VTzipGzznPf1zJbM0xqq4gNaYUjVd7uA7eMdhkOeOz2dnc5XkoOkP8UCfIQOR4R8thC8EjIwCyJ
	NpnRA=
X-Google-Smtp-Source: AGHT+IHgKU6jM0c+W5oVcxlG6nEX1xAKWoIfttRFMeLhxyiP4XNtqKsWmTuThx5iRTl4h4Gz11OdUw==
X-Received: by 2002:a05:6a20:9f9b:b0:2ec:f29:1011 with SMTP id adf61e73a8af0-321db7561a9mr8065872637.20.1759385322705;
        Wed, 01 Oct 2025 23:08:42 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:08:42 -0700 (PDT)
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
Subject: [PATCH 03/11] rvtrace: Add functions to create/destroy a trace component path
Date: Thu,  2 Oct 2025 11:37:24 +0530
Message-ID: <20251002060732.100213-4-apatel@ventanamicro.com>
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
index 52ea931745fc..7013d50ca569 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -194,6 +194,53 @@ int rvtrace_disable_component(struct rvtrace_component *comp)
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
@@ -446,6 +493,182 @@ void rvtrace_unregister_component(struct rvtrace_component *comp)
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
index 04eb03e62601..f2174f463a69 100644
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
@@ -71,6 +73,12 @@ enum rvtrace_component_impid {
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
@@ -237,22 +245,53 @@ int rvtrace_poll_bit(struct rvtrace_platform_data *pdata, int offset,
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


