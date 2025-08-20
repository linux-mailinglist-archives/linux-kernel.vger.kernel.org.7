Return-Path: <linux-kernel+bounces-778377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3AB2E4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65046A27747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0E22773CD;
	Wed, 20 Aug 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="ScQ5WqDX"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E79279334
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713466; cv=none; b=uUhtyE/rbJ9Q9pbthmXfEbAgGvO/QV/1hXBoOgVjG5mMhC64Sxz4BiLMNWMSvGE73Vk4e9+VpFGqNptzxGipye6zxyz1eaLLU/7XuEVqM6pLWsSiipNlzit/D75qrcCjY24QUu8vOCFjaGzIrvWIG0neLwLUbscVahyBUNJCk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713466; c=relaxed/simple;
	bh=a5AYMxBqdJDz6gkrxlobXlcTTsJboGuBBxIbO2fep+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bctav0KPVSxeVTohnv5ymEEclZYB/uPZPbEm4Xl1GIYWS/D8GlAcOuQQJEjCIAebdS23zyaBnexqMvv+oDDm5RqKxRmbVJ+qU8TKMwpr/34h4wzmR3jRoq7F9FK3Slq+ju06gcQ9AHgbufBLWdwpc+8HNPdxpUNJbwyNI6zXI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=ScQ5WqDX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a9f5dfa62so2293486d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755713463; x=1756318263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEg9IzJfORmEUVVC8tp3QP7XHlH+b0gTJgTrq0ptJu0=;
        b=ScQ5WqDXI7SNslQQibKXPDO/FwX/9aBx3xSJKPEDx5KdgublIoLF3dT3vmr0ozgTmt
         n2GaACW9DrM9DUUn3fIpN4vfn1ZjkqshxY8Udjdec9iURh5lMDT70YKxaTq3tYpqcZew
         a1U5m9AJi6rex4guVIAXBJ3PxNz1FvNy9jQNLflP9km9pr6jQLOgvvK9swyvpBTzgy0n
         F4f647uYzRZjHrI3Aq6LyAyExv551USMtZrPW1ZCCY3b9WTWbm5ohpcgOULh+kudcNH3
         VhZlhUaqtKTeIDvpR7tzTAs86+AHS09FOsddi410hhZZL+rvgb/x0AGfRlHFBPA4i+4Q
         4Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713463; x=1756318263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEg9IzJfORmEUVVC8tp3QP7XHlH+b0gTJgTrq0ptJu0=;
        b=hR03jx9asTFBZ14keoktaTts4jCQzZZUZW5AJvn2qX94/Q+AL44KA0Zaqi7ery/K3k
         cQfCCSbp1gJhZbz4tJhisRzfwqOzwCmHNv9n6bumyF+R5WO/gvlWQ7VTxsOB7WwWCp/+
         64lJc+uLG1MNwY7S0a2vkx0vrygcvVq2iymR7tiiNV5fXcOeRAoGdr2X6xtukib8nfCe
         UoiZr7Hj0A6i1De0uZJt5DARamo4VG5SHKchteYOrry7htoJeiNJCQi0hYWlbidJxgHd
         +YO4388dkhmn7S3H5opwGILdgwiQ38tUwUryLBx0IpuaBLsoGevvD32YBezlT0N27sH4
         KMOg==
X-Gm-Message-State: AOJu0YwFufcU7LmHe+1U0edJtRXY24NFkA1KvswAK0y1TTozvxMi1UrR
	iTHp5Y4ItrzvEdpGAO+Cx2uPuQh7we2+gZcNnvmKmerECrnX+ZP6PGcQJp4UpH0iUA==
X-Gm-Gg: ASbGncs5iIGE4IKYyPd45bK0ko1obWdgggmVGSFppRQmC8ulgaC9box5va949MXt1Kg
	yjBcWB5WvML5d5e00iMCABSOUxDEJBvZ0V1HQOdCS9ctbM7Flbj1SZdRx/CXtYG3dLsYAuLE0pe
	stciZl6vgNTwgEyW4NKIOdI/34FCassdv+wpDnLJRW7berrKB9rS+D4Z9PZol5WOQqldOz0l+lx
	q4D48JLzhElhYHMJh0h/mIsYsSSVk+dz6nB5AzHq1BhB4t2EjwVj2LqdVQJ43A2I45fZLZAMtTD
	ayV76iZRIwlOUTl2dYlzrGsNyr95Stx1i8xBj6d2aY8Cwx2v8sGkK5UPKPyL2i4+Ns/4T9Ho3Am
	C8fH5n0alRk59EhwacxvMkxdTIqI0BPn4mwPwgI39hEX7UYf8iqq1B2kyHzPcjULGxKz2JfY0DW
	iYhYeTeIAqvLzMmlBs+1Ajla4UURo8NSZ7sYJwMqMCTAvzXg==
X-Google-Smtp-Source: AGHT+IEhwtbBn17CFSkW+x+E31JWfVdYnrpp1FxIk0F5/CAtt0bQ5xc/VvPHKPM3nmoyKj+xtB3uWQ==
X-Received: by 2002:a05:6214:d83:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70d76fe0302mr39522186d6.27.1755713462700;
        Wed, 20 Aug 2025 11:11:02 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm977497485a.36.2025.08.20.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:11:01 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
Date: Wed, 20 Aug 2025 14:10:45 -0400
Subject: [PATCH 2/2] firmware: ti_sci: trace: Decode message types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-linux_master_ti_sci_trace-v1-2-2a69c0abf55e@criticallink.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=a5AYMxBqdJDz6gkrxlobXlcTTsJboGuBBxIbO2fep+o=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBopg+y65DfxJcmBr7YNYJ54nyOqO3l3NJUMUR7E
 KADuw/pnDiJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCaKYPsgAKCRDc1/0uCzbr
 qnB4D/0TzDsPJ7lRUNl2m1uohyDVNtltT1shOqGDs66CxsyOs6kuIzGUc+yEVSIhPMrkY1iKD8X
 G+heAKTVSssyrwBiEWItF318NblLONNj9uU8OPndwP39HMJgcPbC/9J3Gvr6S6B3SSsHSST4Svr
 CaVqCfxh+CNuVrnH2cM/MuNIG0yigWUZS5BkV88qdqG3xVykc91T769HPEqXkCuTc9Qn5SD1VXG
 T5A0FziX8wFILfXfBXLNztp2+jR5s2f89oYVQFyzZ9+xDLgIQKjIgEFm3sLLy4K1cBJOPjmFdPh
 g6dcdaNOX6fbRLAlBKebIXRn5xcDieK8IbY9NWRuIND9wrWTCRTBt8zyEJZXgmJpBpmwPEFavm/
 uLsyVSE1DJbQi+AQhzf0aghepy1gqWntTK88OXH4hgUeAN2ON8LsHcZOK+665FmZwuWrdbwHGpQ
 Q0VoETLzgwZdVkJ0BnYIlgIF5KTJ92rXaFJANPVsRbQGWHJvi6GJeFq3tdx9TkM9JvXgrAT6IhU
 hzfoGW3GvHCMmATRgHFiQeKyymbsD3sCoZEuvZ7nv5xq5eGNJdlc3MAtFsXh6Mig7EiUfWLDdsQ
 CNwsna+Yv4mGWYItziGkFwyXbqg6VR3rz7ddrJ+DQsUzrXNTK6ZuXPNnQqTtWV/4f0WXjSRbKT6
 UMSvOKeRXSdKAkQ==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA

Make debugging easier by decoding the ti_sci message types

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/firmware/ti_sci_trace.h | 69 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/ti_sci_trace.h b/drivers/firmware/ti_sci_trace.h
index 7f99c41ea08aec6cf64d601576cad29b14c6ad5b..88a159e13907d7d7806b312a2ad3103c106d1972 100644
--- a/drivers/firmware/ti_sci_trace.h
+++ b/drivers/firmware/ti_sci_trace.h
@@ -7,6 +7,63 @@
 
 #include <linux/tracepoint.h>
 
+#define show_ti_sci_msg_type(x) \
+	__print_symbolic(x, \
+		{ TI_SCI_MSG_ENABLE_WDT, "ENABLE_WDT" }, \
+		{ TI_SCI_MSG_WAKE_RESET, "WAKE_RESET" }, \
+		{ TI_SCI_MSG_VERSION, "VERSION" }, \
+		{ TI_SCI_MSG_WAKE_REASON, "WAKE_REASON" }, \
+		{ TI_SCI_MSG_GOODBYE, "GOODBYE" }, \
+		{ TI_SCI_MSG_SYS_RESET, "SYS_RESET" }, \
+		{ TI_SCI_MSG_QUERY_FW_CAPS, "QUERY_FW_CAPS" }, \
+		{ TI_SCI_MSG_SET_DEVICE_STATE, "SET_DEVICE_STATE" }, \
+		{ TI_SCI_MSG_GET_DEVICE_STATE, "GET_DEVICE_STATE" }, \
+		{ TI_SCI_MSG_SET_DEVICE_RESETS, "SET_DEVICE_RESETS" }, \
+		{ TI_SCI_MSG_SET_CLOCK_STATE, "SET_CLOCK_STATE" }, \
+		{ TI_SCI_MSG_GET_CLOCK_STATE, "GET_CLOCK_STATE" }, \
+		{ TI_SCI_MSG_SET_CLOCK_PARENT, "SET_CLOCK_PARENT" }, \
+		{ TI_SCI_MSG_GET_CLOCK_PARENT, "GET_CLOCK_PARENT" }, \
+		{ TI_SCI_MSG_GET_NUM_CLOCK_PARENTS, "GET_NUM_CLOCK_PARENTS" }, \
+		{ TI_SCI_MSG_SET_CLOCK_FREQ, "SET_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_QUERY_CLOCK_FREQ, "QUERY_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_GET_CLOCK_FREQ, "GET_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_PREPARE_SLEEP, "PREPARE_SLEEP" }, \
+		{ TI_SCI_MSG_LPM_WAKE_REASON, "LPM_WAKE_REASON" }, \
+		{ TI_SCI_MSG_SET_IO_ISOLATION, "SET_IO_ISOLATION" }, \
+		{ TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT, "LPM_SET_DEVICE_CONSTRAINT" }, \
+		{ TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT, "LPM_SET_LATENCY_CONSTRAINT" }, \
+		{ TI_SCI_MSG_GET_RESOURCE_RANGE, "GET_RESOURCE_RANGE" }, \
+		{ TI_SCI_MSG_SET_IRQ, "SET_IRQ" }, \
+		{ TI_SCI_MSG_FREE_IRQ, "FREE_IRQ" }, \
+		{ TI_SCI_MSG_RM_RING_ALLOCATE, "RM_RING_ALLOCATE" }, \
+		{ TI_SCI_MSG_RM_RING_FREE, "RM_RING_FREE" }, \
+		{ TI_SCI_MSG_RM_RING_RECONFIG, "RM_RING_RECONFIG" }, \
+		{ TI_SCI_MSG_RM_RING_RESET, "RM_RING_RESET" }, \
+		{ TI_SCI_MSG_RM_RING_CFG, "RM_RING_CFG" }, \
+		{ TI_SCI_MSG_RM_PSIL_PAIR, "RM_PSIL_PAIR" }, \
+		{ TI_SCI_MSG_RM_PSIL_UNPAIR, "RM_PSIL_UNPAIR" }, \
+		{ TI_SCI_MSG_RM_UDMAP_TX_ALLOC, "RM_UDMAP_TX_ALLOC" }, \
+		{ TI_SCI_MSG_RM_UDMAP_TX_FREE, "RM_UDMAP_TX_FREE" }, \
+		{ TI_SCI_MSG_RM_UDMAP_RX_ALLOC, "RM_UDMAP_RX_ALLOC" }, \
+		{ TI_SCI_MSG_RM_UDMAP_RX_FREE, "RM_UDMAP_RX_FREE" }, \
+		{ TI_SCI_MSG_RM_UDMAP_FLOW_CFG, "RM_UDMAP_FLOW_CFG" }, \
+		{ TI_SCI_MSG_RM_UDMAP_OPT_FLOW_CFG, "RM_UDMAP_OPT_FLOW_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_TX_CH_CFG, "RM_UDMAP_TX_CH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_TX_CH_GET_CFG, "RM_UDMAP_TX_CH_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_RX_CH_CFG, "RM_UDMAP_RX_CH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_RX_CH_GET_CFG, "RM_UDMAP_RX_CH_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_CFG, "RM_UDMAP_FLOW_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_SIZE_THRESH_CFG, "RM_UDMAP_FLOW_SIZE_THRESH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_GET_CFG, "RM_UDMAP_FLOW_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_SIZE_THRESH_GET_CFG, "RM_UDMAP_FLOW_SIZE_THRESH_GET_CFG" }, \
+		{ TI_SCI_MSG_PROC_REQUEST, "PROC_REQUEST" }, \
+		{ TI_SCI_MSG_PROC_RELEASE, "PROC_RELEASE" }, \
+		{ TI_SCI_MSG_PROC_HANDOVER, "PROC_HANDOVER" }, \
+		{ TI_SCI_MSG_SET_CONFIG, "SET_CONFIG" }, \
+		{ TI_SCI_MSG_SET_CTRL, "SET_CTRL" }, \
+		{ TI_SCI_MSG_GET_STATUS, "GET_STATUS" } \
+	)
+
 
 DECLARE_EVENT_CLASS(ti_sci_hdr_event_class,
 	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
@@ -28,8 +85,9 @@ DECLARE_EVENT_CLASS(ti_sci_hdr_event_class,
 		__entry->status = status;
 	),
 
-	TP_printk("type=%04X host=%02X seq=%02X flags=%08X status=%d",
-		__entry->type, __entry->host, __entry->seq, __entry->flags, __entry->status)
+	TP_printk("type=%s host=%02X seq=%02X flags=%08X status=%d",
+		show_ti_sci_msg_type(__entry->type), __entry->host,
+		__entry->seq, __entry->flags, __entry->status)
 );
 
 DEFINE_EVENT(ti_sci_hdr_event_class,
@@ -73,9 +131,10 @@ TRACE_EVENT(ti_sci_msg_dump,
 		memcpy(__get_dynamic_array(cmd), xfer->xfer_buf, __entry->len);
 	),
 
-	TP_printk("type=%04X host=%02X seq=%02X flags=%08X data=%s",
-		__entry->type, __entry->host, __entry->seq, __entry->flags,
-		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
+	TP_printk("type=%s host=%02X seq=%02X flags=%08X data=%s",
+		show_ti_sci_msg_type(__entry->type), __entry->host,
+		__entry->seq, __entry->flags,
+		__print_hex(__get_dynamic_array(cmd), __entry->len))
 );
 #endif /* _TRACE_TI_SCI_H */
 

-- 
2.43.0


