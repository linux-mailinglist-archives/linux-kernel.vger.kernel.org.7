Return-Path: <linux-kernel+bounces-778376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E0B2E4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCF61BA0F35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234B27A460;
	Wed, 20 Aug 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="S0R+J9io"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474C277C9B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713464; cv=none; b=Vcg6/pvJ92kyUQ/HwGSVF5Sr08u/MuGomPL/YUUv4Ut+8L4ibncNEBCymwtUHXsN0a+8A74KXcPKvUpMK6IcQyiP7aGVrhfNTC/p87ZCqXrQF0jnNCAj7B18lARtC+MI3YouyB32IL7Z6qoHRARLjeN7V/rbDxONUUqFPG0plhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713464; c=relaxed/simple;
	bh=etqFjPFs3vp08TxiXSqimCaG1/79A2Or3SQaEf8w0P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3J7PMVA6KMh5kbK5g25tUvpWLBFgiNX+fyYtnYxXrCrCcj5WgqFdybHpBC0ZDatQt/zsL11EaJ4qO2GpoAorGOO+FwxQ5Dvk8sovKcNW+Fmtxg7/Ds+rKCnILk0PB1S3xgQyKhKZn4sa+3xQRjeduVnMNlqSX/XVd0rtBlRWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=S0R+J9io; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e87035a7c3so13741985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755713461; x=1756318261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq16eDaTYQMOn9zzBVLH7MX2YKx+OdDLLiqd/RRx9IE=;
        b=S0R+J9ioxszKJr5W/BtgJq2Gw7MWtJjLlr2E/46CxnSzN7qKi5gK3Wz8dV18BrHz+L
         6U1LGKMwGbpzEI1JWU+6TbIOJBXojcKXK2WPU331gpcGw58XSR2gL0JUoiMKiNJYPxsY
         x3bgTy0+Exo2MRrVN3ui/SffQS73SV8DiBcnqZxyclMT4J+5TphpQJSZZDBwd2K1fd3J
         zYBJOfoI0hW+J9WbUE8p86hVaWoGXJRTaYor1NUpHHlExL+o0nztH/w2Fg4PwOdHxpG1
         SDvEG2J42ys91ELb3KKjqUktnwuwxGuXZt4UDzDFdKW1qb3QupkrhuWcSUTXWpn8Hz7S
         0ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713461; x=1756318261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq16eDaTYQMOn9zzBVLH7MX2YKx+OdDLLiqd/RRx9IE=;
        b=ZYk9gFMJ6mXY9qLc1PXMg7iQSA6TWPa7ZkqkPIlc8B5nGKeai9YIKLADMg5Mw7prUx
         MHfHKiLHJrDBDokzfOVvcndhcFUwIogiKGNBJndNsH/qikptQx6PygZgBedZ5twyFZYB
         EXA1tq7Xiiem5c3sVE9COfkFG3NouHv5e1c2SyUAinjeYr50Z89ODbWVH6mSAWia/NY1
         T4aomw40i3TAZFaCKfWmTaed1ccsrsVJfdoIDiZe4tPYI8ODhQyuUOdLnMOSE60cmLOV
         Z/VtvaUSL4lK2Qir4VT/HnXULVMD++ybF8FUOi6wrjfBLi+qb8+grZp5EJ3IVfSZC9wf
         e0sA==
X-Gm-Message-State: AOJu0YztxxYxMj/X6gPa12GKESYWIakOpxVl3N0M2Dlc4oF+EXrWBSHT
	YgfDyDagH0aLSMYgCT7he/+X/9MwL/W2nMLqFtEfP8gLWAx0WDox7tyg5im/2yPK2A==
X-Gm-Gg: ASbGncupAQGaWl4q5jxvdwIagkQnJ+5/cnBDmCKcOA/w6Up4cDAwEeXFOgh6TJmqzTQ
	jAFLpi/7mo6k7Zijrc9K4OXm2DfjAdQ3mwzqlDqYYq1Mk2tPy4cmP4O18lWtVqIE4AQ3ckCHL+6
	uoZ1Tg4lZfuPilxZPKwQAnvfG1XLih23Y1SRZpLSdgA/d9XzyL7d1nZhEpa73S5yr1qXnVxWNWk
	ahMQVmePeJAcgiqh8iusAirh2ssxBoV3/2ZBWdBeQijR4QVi028yxRrnTo4h6b6xwQHMO3UlM22
	LFgqiXtFOV5FeN7Lut4RBOjJ1wKR9Z+e/dxLJLmALKnVUhkAJ/M13ZLrac2yw6aQPebFicpxmU+
	OFjHE94sb4NtHRgUrxS6O+tggRN6UvonqHtlmkJ3pgHV4PUrJwAqQqP+5DXHPqyEWg4Y7kzC4Nm
	TgR1IkbN3lIbqxDdFIO08wewD/wplqlWh542I=
X-Google-Smtp-Source: AGHT+IHxSEMhGEa7cC/Xc549bj9LNnxJcU8yUkf8DRST4/na6Np0IFzpa9wqSwyR96VMC4fVeNSogg==
X-Received: by 2002:a05:620a:4550:b0:7e6:20a9:1855 with SMTP id af79cd13be357-7e9fcb7b646mr468924185a.44.1755713461000;
        Wed, 20 Aug 2025 11:11:01 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm977497485a.36.2025.08.20.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:11:00 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
Date: Wed, 20 Aug 2025 14:10:44 -0400
Subject: [PATCH 1/2] firmware: ti_sci: Add trace events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-linux_master_ti_sci_trace-v1-1-2a69c0abf55e@criticallink.com>
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
In-Reply-To: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=etqFjPFs3vp08TxiXSqimCaG1/79A2Or3SQaEf8w0P8=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBopg+yRRf9U93bUOX/Qf7T3PjkuKN5XsQfsWGwo
 rTZnMjw3MSJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCaKYPsgAKCRDc1/0uCzbr
 qi3ED/wO/MtdnWf/w4gZK0rTauaX9xNidQJ8Nh0wJMp4R7fjhHDVutuzdwc/uB/l4tBYhWqTVPc
 jdB+1F01gq5yrNbMDoXMThfKfDnYPMXDd9kSsQZfdltNysj0Mikkx3T1oKcT6iPYLxC4Box4CAu
 rimQdnMRcfZ4nQ0Vn76Zd5DrhEUlX3vKOuQuUYqGMmEaXjgcRumaWvNrw9vzoN11/61pz6Cq3Ot
 kFmDBVaqV+CNLgHQ3j3le0AT/dow+0RKx+NQKp5POFcHcMz4PF/wleJusUhSLxVtdp5ZvQFODVB
 DJFSYLR38U5mpWhL2414tQuUJvd05VIvDxe6HmSUuZjwnPM7HVschUOzKMU0d4fa47vJiehGq7R
 JCUxRR7qNNjM7DhMYcM14xh/lXEmwhO6nBizfbhAe1eAt6SskCMNbfHASpsRKIqm4zKAdvFiSVM
 S9ErQSLc5wHV8C3NTgapXnNb67NnP0TF1t5fgEwKO61ST+Wd/AxdtjMs4NCIySeMG48iv1lfvnS
 wHvaZjzO66h1UpGLsVINxgUnIXIu49Nnm0BGtZzwK0pfj+xAQ+fgKtKW25uyGxJx32yJ6qvd7qm
 KbIWdvRorQs/Ehbi+DJxJaSiUzj4A0Qwu5H0x8wgGrc7QvZBcsugzrPJZbv8QIIRRzNA6RMF+t5
 h/dEZcJcsgnO17g==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA

Add TI sci trace events to help to debug and measure the speed of the
communication channel. The xfer_begin and xfer_end calls can be used
to time how long a transfer takes. The rx_callback and msg_dump trace
events help track the data that gets returned.

Based on tracing done in ARM SCMI

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 MAINTAINERS                     |  1 +
 drivers/firmware/Makefile       |  3 ++
 drivers/firmware/ti_sci.c       | 11 ++++++
 drivers/firmware/ti_sci_trace.h | 87 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a1918beec113b576cf28b76151745ef..a6fac706feceedfc5039ec07de954ac35a9af848 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24631,6 +24631,7 @@ F:	drivers/pmdomain/ti/ti_sci_pm_domains.c
 F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
+F:	include/trace/events/ti_sci.h
 
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
 M:	Puranjay Mohan <puranjay@kernel.org>
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4ddec2820c96fa9be012e89dac3038968bb67039..a055c53bdfa9e5c64adb4e20a9ca6c6661d80297 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,6 +2,9 @@
 #
 # Makefile for the linux kernel.
 #
+
+ccflags-y += -I$(src)			# needed for trace events
+
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ae5fd1936ad322e5e3a94897cc042f6548f919e6..87b1330305939bb6b19bbdaa594b17b266092a34 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -127,6 +127,9 @@ struct ti_sci_info {
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
 
+#define CREATE_TRACE_POINTS
+#include "ti_sci_trace.h"
+
 #ifdef CONFIG_DEBUG_FS
 
 /**
@@ -269,6 +272,9 @@ static void ti_sci_rx_callback(struct mbox_client *cl, void *m)
 		return;
 	}
 
+	trace_ti_sci_rx_callback(hdr, 0);
+	trace_ti_sci_msg_dump(hdr, xfer);
+
 	ti_sci_dump_header_dbg(dev, hdr);
 	/* Take a copy to the rx buffer.. */
 	memcpy(xfer->xfer_buf, mbox_msg->buf, xfer->rx_len);
@@ -402,6 +408,9 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 	int timeout;
 	struct device *dev = info->dev;
 	bool done_state = true;
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
+
+	trace_ti_sci_xfer_begin(hdr, 0);
 
 	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
 	if (ret < 0)
@@ -437,6 +446,8 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 	 */
 	mbox_client_txdone(info->chan_tx, ret);
 
+	trace_ti_sci_xfer_end(hdr, ret);
+
 	return ret;
 }
 
diff --git a/drivers/firmware/ti_sci_trace.h b/drivers/firmware/ti_sci_trace.h
new file mode 100644
index 0000000000000000000000000000000000000000..7f99c41ea08aec6cf64d601576cad29b14c6ad5b
--- /dev/null
+++ b/drivers/firmware/ti_sci_trace.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ti_sci
+
+#if !defined(_TRACE_TI_SCI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TI_SCI_H
+
+#include <linux/tracepoint.h>
+
+
+DECLARE_EVENT_CLASS(ti_sci_hdr_event_class,
+	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
+	TP_ARGS(hdr, status),
+
+	TP_STRUCT__entry(
+		__field(u16, type)
+		__field(u8, host)
+		__field(u8, seq)
+		__field(u32, flags)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		__entry->type = hdr->type;
+		__entry->host = hdr->host;
+		__entry->seq = hdr->seq;
+		__entry->flags = hdr->flags;
+		__entry->status = status;
+	),
+
+	TP_printk("type=%04X host=%02X seq=%02X flags=%08X status=%d",
+		__entry->type, __entry->host, __entry->seq, __entry->flags, __entry->status)
+);
+
+DEFINE_EVENT(ti_sci_hdr_event_class,
+	ti_sci_xfer_begin,
+	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
+	TP_ARGS(hdr, status)
+);
+
+DEFINE_EVENT(ti_sci_hdr_event_class,
+	ti_sci_rx_callback,
+	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
+	TP_ARGS(hdr, status)
+);
+
+DEFINE_EVENT(ti_sci_hdr_event_class,
+	ti_sci_xfer_end,
+	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
+	TP_ARGS(hdr, status)
+);
+
+
+TRACE_EVENT(ti_sci_msg_dump,
+	TP_PROTO(struct ti_sci_msg_hdr *hdr, struct ti_sci_xfer *xfer),
+	TP_ARGS(hdr, xfer),
+
+	TP_STRUCT__entry(
+		__field(u16, type)
+		__field(u8, host)
+		__field(u8, seq)
+		__field(u32, flags)
+		__field(size_t, len)
+		__dynamic_array(unsigned char, cmd, xfer->rx_len)
+	),
+
+	TP_fast_assign(
+		__entry->type = hdr->type;
+		__entry->host = hdr->host;
+		__entry->seq = hdr->seq;
+		__entry->flags = hdr->flags;
+		__entry->len = xfer->rx_len;
+		memcpy(__get_dynamic_array(cmd), xfer->xfer_buf, __entry->len);
+	),
+
+	TP_printk("type=%04X host=%02X seq=%02X flags=%08X data=%s",
+		__entry->type, __entry->host, __entry->seq, __entry->flags,
+		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
+);
+#endif /* _TRACE_TI_SCI_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE ti_sci_trace
+#include <trace/define_trace.h>

-- 
2.43.0


