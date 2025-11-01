Return-Path: <linux-kernel+bounces-881376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8830C281AC
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126364E4008
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD92FB09A;
	Sat,  1 Nov 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ltAGTjVa"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4972FABFF
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011833; cv=none; b=pDfw/J/accrN9TlJbdY+SLEeZf88Z9ptXrilW8vpadYBTQiZ/8V/uZuAw4DmRRSFU3951mndPjq6ebfPs8TrQ6otp6Fbs9HIYgzG9bhEAPcLgE4UaIZePvruSjGf+G7aVfO9Qg4teK48cWPiiaiV5jzYSa529k9nIIiX5BUulzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011833; c=relaxed/simple;
	bh=1/PSRddxMss1ZLh6BKodL70umd3EchlKrwrkzcSbhDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYXEK5HQprHSUkEv9N4ILWnYX1VhQfr/41pYbBpZ8BCgxgBCtyChR/33XXtDIEBvi9haFAuOkb2pLTaYdFMyZF/9X04imbAtUULA/WfWfamn/w73PWrjFAUo//HPGY8Q6mZuEGwcMK9OyN9RGO/r1/Bn4yrO6C0mYp0cFrXvrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ltAGTjVa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso2808672a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762011832; x=1762616632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cNRcLxuGh85qOUhHhakMZrIP7xVwXKqva0C/jWYbVA=;
        b=ltAGTjVaEoEzdubkUW6z1KjhT+VCJk2eVIiIKTvA0I0dNXfkFFUROtNIMBXAyiX1pQ
         GojLX/x3ZtanzUdvgzN67TzWzfOqtWajWp7qfWYfuS30I8TKzvNAOSSNgVPNLD4NRuZP
         7I6okhqzjmfNYLIqzofVeVTrLZp2Ts2atef4EFJIADidwecG7oO1bHwfAFIjwwyUBq6J
         jk/PC+AaJ0QtUifY7zSUgywmAqiYYW3yVV+GtTUcXa70crSiRFilq+prym4rLQbw9s6U
         YzM3xUJIkqheeaP24Hz6yv5JGWve0VnZr8hyRP7YUxW0azlBppsr3MElydrubXwKkAIB
         y9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762011832; x=1762616632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cNRcLxuGh85qOUhHhakMZrIP7xVwXKqva0C/jWYbVA=;
        b=AEsCJ4fJ2rDZCwwlQNLGHfJwhDq0JtgFwvhlkUVZJjkWjoT8plaz2XsTJUdqBKJy7w
         5JnXcI/Vq9kLbB6TrBq2cp/59a3iYysv3Xqipm/nJYrX855PN0IDdBfSXVpQZgj67TYd
         EEM0InqWL35l3ybJY/CiihWHhfHpCfHKNUYkJe5vZOBsIogpTyrXNeq+moOvYWxVxm/7
         L602ztz3GJV7t6SRgsjBNErdd7QzKtt8O6WLU7fKsyy6K2FlY0+q0rEK/6FhvpG88kOV
         nOJLNXMAIfV8CYoWS/wOomjQNL0TGCvNzcOwYw0AAb/OmqTxiWuUBUBy3E0Ly8UzZ0zN
         28oA==
X-Forwarded-Encrypted: i=1; AJvYcCWB77GgLMjF2BhHaH6A25yZbV5S7ssKVcCsNQI5MwlYX99CxxbOl1IvveY/j6DQDLCSqP++rtKNV9VXvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlY3pYnKRI81ojdWmfqtQKEZoWnX3SQppBEEpoyTDqhSUWDwy
	KbyNBLmPapBHJsYaz6UEVKg/JPSc10UrtJ0Z0xvgGZV7Q0juvc1wjpKKfGKX5Dvechs=
X-Gm-Gg: ASbGnct1kUHsoNfYbPZiKYN+jYTHKzinfADBHkQ0MDeTEus1IFFVnKGgG+5T84bDhYH
	IaI8jH39BQDZVR4/DGCYG41EaBROewYGRw0vhlYy/8Q2YYyywPqk9o0z5fMmaAmafWCnwYmA+a+
	bzYNq5AbPwaulO42ZWc2xdCyrBie5Ts033Qnoy4lr5YrsM8WPo4aoqLfYna9skToi2GJx9BTxY2
	85oOnS08TkEfO/2cx579ldLrvndqIRk/M/SaCJWvbvXCqLEZcKGQqWfnqcAGi3eo2h630fs3T4S
	TLM9Al0bL7QGbMoJIE3rQOTD1gBUZUGGF2lOeobGw0GENs+PY0PRQrtijGc4I0Fj7rD9Jrp8gt7
	kBPPS7KRdyMv2kW85uU7oNGllrScPsFYVjSdp56dg3AxR7DSSeebjR9db2PrbkUpEO5vyXUyfFA
	8ymNNMUV0ZeGnDz7SOD2OUnKrkXCV+2l4=
X-Google-Smtp-Source: AGHT+IE9dgmddcRbzfRQuPturLe2P+J6B0ktYW7UkJ98oGijMhfJoMmqTs3LZbQLk6Eea6Hsg8gvAw==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2951a4dfc4fmr100179015ad.36.1762011831758;
        Sat, 01 Nov 2025 08:43:51 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm59990105ad.105.2025.11.01.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:43:51 -0700 (PDT)
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
Subject: [PATCH v2 06/12] rvtrace: Add function to copy into perf AUX buffer
Date: Sat,  1 Nov 2025 21:12:39 +0530
Message-ID: <20251101154245.162492-7-apatel@ventanamicro.com>
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

The RISC-V trace ramsink will need a mechanism to copy trace data
into the perf AUX buffer. Add rvtrace_path_copyto_auxbuf() function
and corresponding trace driver callback copyto_auxbuf() for this
purpose.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/hwtracing/rvtrace/rvtrace-core.c | 22 ++++++++++++++++++++++
 include/linux/rvtrace.h                  | 21 +++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
index 35bd77d6880a..b955e5f3b048 100644
--- a/drivers/hwtracing/rvtrace/rvtrace-core.c
+++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
@@ -675,6 +675,28 @@ int rvtrace_path_stop(struct rvtrace_path *path)
 }
 EXPORT_SYMBOL_GPL(rvtrace_path_stop);
 
+int rvtrace_path_copyto_auxbuf(struct rvtrace_path *path,
+			       struct rvtrace_perf_auxbuf *buf,
+			       size_t *bytes_copied)
+{
+	const struct rvtrace_driver *rtdrv;
+	struct rvtrace_component *comp;
+	struct rvtrace_path_node *node;
+
+	list_for_each_entry(node, &path->comp_list, head) {
+		comp = node->comp;
+		rtdrv = to_rvtrace_driver(comp->dev.driver);
+		if (!rtdrv->copyto_auxbuf)
+			continue;
+
+		*bytes_copied = rtdrv->copyto_auxbuf(comp, buf);
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(rvtrace_path_copyto_auxbuf);
+
 struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
 					 struct rvtrace_component *sink,
 					 enum rvtrace_component_mode mode)
diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
index e2842e8728d4..cecf6c153ca6 100644
--- a/include/linux/rvtrace.h
+++ b/include/linux/rvtrace.h
@@ -277,9 +277,28 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
 int rvtrace_path_start(struct rvtrace_path *path);
 int rvtrace_path_stop(struct rvtrace_path *path);
 
+/**
+ * struct rvtrace_perf_auxbuf - Representation of the perf AUX buffer
+ * @length:   size of the AUX buffer
+ * @nr_pages: number of pages of the AUX buffer
+ * @base:     start address of AUX buffer
+ * @pos:      position in the AUX buffer to commit traced data
+ */
+struct rvtrace_perf_auxbuf {
+	size_t length;
+	int nr_pages;
+	void *base;
+	long pos;
+};
+
+int rvtrace_path_copyto_auxbuf(struct rvtrace_path *path,
+			       struct rvtrace_perf_auxbuf *buf,
+			       size_t *bytes_copied);
+
 /**
  * struct rvtrace_driver - Representation of a RISC-V trace driver
  * id_table: Table to match components handled by the driver
+ * copyto_auxbuf:Callback to copy data into perf AUX buffer
  * start:        Callback to start tracing
  * stop:         Callback to stop tracing
  * probe:        Driver probe() function
@@ -290,6 +309,8 @@ int rvtrace_path_stop(struct rvtrace_path *path);
  */
 struct rvtrace_driver {
 	const struct rvtrace_component_id *id_table;
+	size_t			(*copyto_auxbuf)(struct rvtrace_component *comp,
+						 struct rvtrace_perf_auxbuf *buf);
 	int			(*start)(struct rvtrace_component *comp);
 	int			(*stop)(struct rvtrace_component *comp);
 	int			(*probe)(struct rvtrace_component *comp);
-- 
2.43.0


