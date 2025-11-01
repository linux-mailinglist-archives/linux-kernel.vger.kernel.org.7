Return-Path: <linux-kernel+bounces-881377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED9C281BB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7EB04ECC81
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E42F9984;
	Sat,  1 Nov 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IqvtGgrd"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58652F2915
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011842; cv=none; b=TDT5kHEkKjKe2qisv6GLehX3lk0GLiJ86nWP8xe6MoI/Z8DoXs+UoliRU1xeEovEjaXy/9HKl6PQV0Z5MKmLb8M4hLj24i3u70RjX2qDMT7e0t16GosdcorpX9hLVECG6zHdFPHwKbofWPCGIzym9U6pMQu0pDGSu8Bm02tkmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011842; c=relaxed/simple;
	bh=zo5YKif/sbpHnYA1aiIFPZB6QxT8hmW+j1PaV42UeZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/7hekcdbKY6vatvqEoGQB9jze0sVUA2M/7rufXF94tuoaWeM9Ss5h2HlZx7qGC9kgLgABHrsh9/2iY52LQE59fhzP0f/rynrGwElm0xEjM8zDCuIAV2tA2mjpsTtrI74GvdxDyH801yZIuKgvSuRCp7+yPlT1f4MZkwFGT7AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IqvtGgrd; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2366228a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011840; x=1762616640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae2lirZMEyfHKsluDGqvTk55hOG0uMkmu2dMvKUo7Mg=;
        b=IqvtGgrdZZnAyKksWUU4nsyUqgKCZ9HtpJyjyOVjddp3JaK5FspjtglxF6ZErGXkib
         P3dTb4BFyDOlJCmqIjH1z4TTLkeuIEi2R3u/ATWEn+uTRFIXuCsHisBtZlJ2HNcM61ms
         m8EropCew07VG2qBjbE/bgeZJkPfwJmf7f9thF4Y+v81gq9ofPzZQm9gX7Bm6xlrGaOZ
         H5KL/Asc104aCwQD/1RvscrK5Hbe9+t+JfeHVw7xbXmNUbQleUy370bqt6eG8PM8mJM/
         B56KpmPWJ3wcrM5cMJA0m+MfnWMoIhHvkrNf7nDKpsEvTP7Oyjxpk39kFPnJwz636RcT
         mUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011840; x=1762616640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ae2lirZMEyfHKsluDGqvTk55hOG0uMkmu2dMvKUo7Mg=;
        b=kKPGO/zl8iIjcm1kg96xwSU5Ugvbv2HetvLEIfEjtlKMaD9iYUgdgaYov1G9inwQjj
         OXZhKHV3oft6OUKSJaxDpv3vcfKFd5H2CZ3EIlwzlHGOXtAH98PCSnb+G4vy6RjEMQiH
         Cg8V/aXTTm9gfRKREbES7+D9OFCAclGDXCqFX9FgEwfQKeA0HSbe46pGFkLQX8DtI/Gk
         H3a/uMwPMkWcvU2hYVKmoFCy5aJqycJIeb8nk1FwF4kNt1U0XrjL870D6OK8oC4szR/c
         A4EngvrxkSuK+Tq8Uk8dJU6oJ9EzZOtc6JQ1+43Rbh9oeyGDiJolX/kN1WzW0oH80/D3
         zM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmxCNeXah7POnimy3Rn9AOGT9k6x8yvG4YIJSApgPFcklh1fy4mDfhUl0s8ZQhgxsfDIkkPBFOC77i1fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqvj1S1UlKodvSVV6g0d3gkNV0GV5/RkA/svA6zLR0rpQLHWN
	l4si3IylL4ikotoFlxeDM05nU5Nh6I1HVcAjWlIqMhdN1GSegnTqnyTjM8UPv/SP+bs=
X-Gm-Gg: ASbGnctUBlZXZHRhgllgKlSFggx0c738WqM6wpgjNcQBHtqbmLd0Pwx05F22F/Veihu
	oTaiDOXvizU0f945C7Fe8InexBP0zZywEUQVCV/RwYk2ba3Ee78rG40Ck0/Hrzbw2ZimFMYKzVR
	2Zq62PwF+yvfjsmQz2HBfJSJXt8xC/qOwODoj4Asyu2h4p42XiJBa74BfPYhdeDF5NcgI0MlPgM
	o0QGn2OJ360E+kaDvI/T0gszUjQoH6ddEpCWDXi4T8i/Xlfmk0jkn8EuWHuxt0Smn5wr2WQlcko
	O4/74Q2tCYgNheF2hncddRRTp4Kay33QjcupEG4/cA8dBkI1xc6XR1tlXyNKwSy/k9YDAgZlUwM
	TG1EUuXxnyNNLhYjIRMFvTWulF3ZFBDSUP89v7YDTpSNpyPg4c3xFFqRp4vazp4JmvI3utYlfmF
	/e1lTTbfEqC6BTwcjdp8McDV1Vm5zhlYU=
X-Google-Smtp-Source: AGHT+IHnu/LkNJmWubjJ09gAWYh0sS09HDl6f2CIH0+AtetQ53djcWevN3kIT2bI6ucVlf4vDM7MeQ==
X-Received: by 2002:a17:902:ea04:b0:295:511d:537 with SMTP id d9443c01a7336-295511d12femr48219465ad.44.1762011840123;
        Sat, 01 Nov 2025 08:44:00 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:43:59 -0700 (PDT)
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
Subject: [PATCH v2 07/12] rvtrace: Add trace ramsink driver
Date: Sat,  1 Nov 2025 21:12:40 +0530
Message-ID: <20251101154245.162492-8-apatel@ventanamicro.com>
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

Add initial implementation of RISC-V trace ramsink driver. The ramsink
is defined in the RISC-V Trace Control Interface specification.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/Kconfig           |   9 +
 drivers/hwtracing/rvtrace/Makefile          |   1 +
 drivers/hwtracing/rvtrace/rvtrace-ramsink.c | 262 ++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/hwtracing/rvtrace/rvtrace-ramsink.c

diff --git a/drivers/hwtracing/rvtrace/Kconfig b/drivers/hwtracing/rvtrace/Kconfig
index ba35c05f3f54..0577f9acb858 100644
--- a/drivers/hwtracing/rvtrace/Kconfig
+++ b/drivers/hwtracing/rvtrace/Kconfig
@@ -21,3 +21,12 @@ config RVTRACE_ENCODER
 	default y
 	help
 	  This driver provides support for RISC-V Trace Encoder component.
+
+config RVTRACE_RAMSINK
+	tristate "RISC-V Trace Ramsink driver"
+	depends on RVTRACE
+	select DMA_SHARED_BUFFER
+	default y
+	help
+	  This driver provides support for Risc-V E-Trace Ramsink
+	  component.
diff --git a/drivers/hwtracing/rvtrace/Makefile b/drivers/hwtracing/rvtrace/Makefile
index f320693a1fc5..122e575da9fb 100644
--- a/drivers/hwtracing/rvtrace/Makefile
+++ b/drivers/hwtracing/rvtrace/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RVTRACE) += rvtrace.o
 rvtrace-y := rvtrace-core.o rvtrace-platform.o
 obj-$(CONFIG_RVTRACE_ENCODER) += rvtrace-encoder.o
+obj-$(CONFIG_RVTRACE_RAMSINK) += rvtrace-ramsink.o
diff --git a/drivers/hwtracing/rvtrace/rvtrace-ramsink.c b/drivers/hwtracing/rvtrace/rvtrace-ramsink.c
new file mode 100644
index 000000000000..676344c9387c
--- /dev/null
+++ b/drivers/hwtracing/rvtrace/rvtrace-ramsink.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Ventana Micro Systems Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/dma-mapping.h>
+#include <linux/rvtrace.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+
+#define RVTRACE_RAMSINK_STARTLOW_OFF		0x010
+#define RVTRACE_RAMSINK_STARTHIGH_OFF		0x014
+#define RVTRACE_RAMSINK_LIMITLOW_OFF		0x018
+#define RVTRACE_RAMSINK_LIMITHIGH_OFF		0x01c
+#define RVTRACE_RAMSINK_WPLOW_OFF		0x020
+#define   RVTRACE_RAMSINK_WPLOW_WRAP		0x1
+#define RVTRACE_RAMSINK_WPHIGH_OFF		0x024
+#define RVTRACE_RAMSINK_RPLOW_OFF		0x028
+#define RVTRACE_RAMSINK_RPHIGH_OFF		0x02c
+
+struct rvtrace_ramsink_priv {
+	size_t size;
+	void *va;
+	dma_addr_t start;
+	dma_addr_t end;
+	/* WP from prev iteration */
+	dma_addr_t prev_head;
+};
+
+struct trace_buf {
+	void *base;
+	size_t size;
+	long cur;
+	size_t len;
+};
+
+static int rvtrace_ramsink_stop(struct rvtrace_component *comp)
+{
+	return rvtrace_comp_is_empty(comp);
+}
+
+static void tbuf_to_pbuf_copy(struct trace_buf *src, struct trace_buf *dst)
+{
+	int bytes_dst, bytes_src, bytes;
+	void *dst_addr, *src_addr;
+
+	while (src->size) {
+		src_addr = src->base + src->cur;
+		dst_addr = dst->base + dst->cur;
+
+		if (dst->len - dst->cur < src->size)
+			bytes_dst = dst->len - dst->cur;
+		else
+			bytes_dst = src->size;
+		if (src->len - src->cur < src->size)
+			bytes_src = src->len - src->cur;
+		else
+			bytes_src = src->size;
+		bytes = bytes_dst < bytes_src ? bytes_dst : bytes_src;
+		memcpy(dst_addr, src_addr, bytes);
+		dst->cur = (dst->cur + bytes) % dst->len;
+		src->cur = (src->cur + bytes) % src->len;
+		src->size -= bytes;
+	}
+}
+
+static size_t rvtrace_ramsink_copyto_auxbuf(struct rvtrace_component *comp,
+					    struct rvtrace_perf_auxbuf *buf)
+{
+	struct rvtrace_ramsink_priv *priv = dev_get_drvdata(&comp->dev);
+	struct trace_buf src, dst;
+	u32 wp_low, wp_high;
+	u64 buf_cur_head;
+	size_t size;
+
+	wp_low = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_WPLOW_OFF);
+	wp_high = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_WPHIGH_OFF);
+	buf_cur_head = (u64)(wp_high) << 32 | (wp_low & ~RVTRACE_RAMSINK_WPLOW_WRAP);
+
+	if (buf_cur_head == priv->prev_head)
+		return 0;
+
+	dst.base = buf->base;
+	dst.len = buf->length;
+	dst.cur = buf->pos;
+
+	src.base = priv->va;
+	src.len = priv->end - priv->start;
+	if (buf_cur_head > priv->prev_head) {
+		src.size = buf_cur_head - priv->prev_head;
+	} else {
+		src.size = priv->end - priv->prev_head;
+		src.size += buf_cur_head - priv->start;
+	}
+
+	src.cur = buf_cur_head - priv->start;
+	size = src.size;
+	tbuf_to_pbuf_copy(&src, &dst);
+	buf->pos = dst.cur;
+	priv->prev_head = buf_cur_head;
+
+	return size;
+}
+
+static int rvtrace_ramsink_setup_buf(struct rvtrace_component *comp)
+{
+	struct rvtrace_ramsink_priv *priv = dev_get_drvdata(&comp->dev);
+	u64 start_min, limit_max, end;
+	u32 low, high;
+
+	/* Probe min and max values for start and limit registers */
+	rvtrace_write32(comp->pdata, 0, RVTRACE_RAMSINK_STARTLOW_OFF);
+	rvtrace_write32(comp->pdata, 0, RVTRACE_RAMSINK_STARTHIGH_OFF);
+	low = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_STARTLOW_OFF);
+	high = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_STARTHIGH_OFF);
+	start_min = (u64)(high) << 32 | low;
+
+	rvtrace_write32(comp->pdata, 0xffffffff, RVTRACE_RAMSINK_LIMITLOW_OFF);
+	rvtrace_write32(comp->pdata, 0xffffffff, RVTRACE_RAMSINK_LIMITHIGH_OFF);
+	low = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_LIMITLOW_OFF);
+	high = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_LIMITHIGH_OFF);
+	limit_max = (u64)(high) << 32 | low;
+
+	if (priv->end < start_min) {
+		dev_err(&comp->dev, "DMA memory not addressable by device\n");
+		return -EINVAL;
+	}
+
+	/* Setup ram sink start addresses */
+	if (priv->start < start_min) {
+		dev_warn(&comp->dev, "Ramsink start address updated from %llx to %llx\n",
+			 priv->start, start_min);
+		priv->va += start_min - priv->start;
+		priv->start = start_min;
+	}
+
+	priv->prev_head = priv->start;
+	priv->end = priv->start + priv->size;
+	rvtrace_write32(comp->pdata, lower_32_bits(priv->start), RVTRACE_RAMSINK_STARTLOW_OFF);
+	rvtrace_write32(comp->pdata, upper_32_bits(priv->start), RVTRACE_RAMSINK_STARTHIGH_OFF);
+	rvtrace_write32(comp->pdata, lower_32_bits(priv->start), RVTRACE_RAMSINK_WPLOW_OFF);
+	rvtrace_write32(comp->pdata, upper_32_bits(priv->start), RVTRACE_RAMSINK_WPHIGH_OFF);
+	/* Setup ram sink limit addresses */
+	if (priv->end > limit_max) {
+		dev_warn(&comp->dev, "Ramsink limit address updated from %llx to %llx\n", priv->end,
+			 limit_max);
+		priv->end = limit_max;
+		priv->size = priv->end - priv->start;
+	}
+
+	/* Limit address needs to be set to end - 4 to avoid overflow */
+	end = priv->end - 4;
+	rvtrace_write32(comp->pdata, lower_32_bits(end), RVTRACE_RAMSINK_LIMITLOW_OFF);
+	rvtrace_write32(comp->pdata, upper_32_bits(end), RVTRACE_RAMSINK_LIMITHIGH_OFF);
+	low = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_LIMITLOW_OFF);
+	high = rvtrace_read32(comp->pdata, RVTRACE_RAMSINK_LIMITHIGH_OFF);
+	end = (u64)(high) << 32 | low;
+	if (end != (priv->end - 4)) {
+		dev_warn(&comp->dev, "Ramsink limit address updated from %llx to %llx\n", priv->end,
+			 end);
+		priv->end = end;
+		priv->size = priv->end - priv->start;
+	}
+
+	return 0;
+}
+
+static int rvtrace_ramsink_setup(struct rvtrace_component *comp)
+{
+	struct device *pdev = comp->pdata->dev;
+	struct rvtrace_ramsink_priv *priv;
+
+	priv = devm_kzalloc(&comp->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&comp->dev, priv);
+
+	/* Derive RAM sink memory size based on component implementation ID */
+	switch (comp->pdata->impid) {
+	default:
+		priv->size = SZ_1M;
+		break;
+	}
+
+	priv->va = dma_alloc_coherent(pdev, priv->size, &priv->start, GFP_KERNEL);
+	if (!priv->va)
+		return -ENOMEM;
+
+	return rvtrace_ramsink_setup_buf(comp);
+}
+
+static void rvtrace_ramsink_cleanup(struct rvtrace_component *comp)
+{
+	struct rvtrace_ramsink_priv *priv = dev_get_drvdata(&comp->dev);
+
+	dma_free_coherent(&comp->dev, priv->size, priv->va, priv->start);
+}
+
+static int rvtrace_ramsink_probe(struct rvtrace_component *comp)
+{
+	int ret;
+
+	ret = rvtrace_ramsink_setup(comp);
+	if (ret)
+		return dev_err_probe(&comp->dev, ret, "failed to setup ramsink.\n");
+
+	ret = rvtrace_enable_component(comp);
+	if (ret)
+		return dev_err_probe(&comp->dev, ret, "failed to enable ramsink.\n");
+
+	return ret;
+}
+
+static void rvtrace_ramsink_remove(struct rvtrace_component *comp)
+{
+	int ret;
+
+	ret = rvtrace_disable_component(comp);
+	if (ret)
+		dev_err(&comp->dev, "failed to disable ramsink.\n");
+
+	rvtrace_ramsink_cleanup(comp);
+}
+
+static struct rvtrace_component_id rvtrace_ramsink_ids[] = {
+	{ .type = RVTRACE_COMPONENT_TYPE_RAMSINK,
+	  .version = rvtrace_component_mkversion(1, 0), },
+	{},
+};
+
+static struct rvtrace_driver rvtrace_ramsink_driver = {
+	.id_table = rvtrace_ramsink_ids,
+	.copyto_auxbuf = rvtrace_ramsink_copyto_auxbuf,
+	.stop = rvtrace_ramsink_stop,
+	.probe = rvtrace_ramsink_probe,
+	.remove = rvtrace_ramsink_remove,
+	.driver = {
+		.name = "rvtrace-ramsink",
+	},
+};
+
+static int __init rvtrace_ramsink_init(void)
+{
+	return rvtrace_register_driver(&rvtrace_ramsink_driver);
+}
+
+static void __exit rvtrace_ramsink_exit(void)
+{
+	rvtrace_unregister_driver(&rvtrace_ramsink_driver);
+}
+
+module_init(rvtrace_ramsink_init);
+module_exit(rvtrace_ramsink_exit);
+
+/* Module information */
+MODULE_AUTHOR("Mayuresh Chitale <mchitale@ventanamicro.com>");
+MODULE_DESCRIPTION("RISC-V Trace Ramsink Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


