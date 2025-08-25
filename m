Return-Path: <linux-kernel+bounces-784603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E247B33E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494313A2928
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFD72EAD0D;
	Mon, 25 Aug 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQ1TtDuc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BA2C3252
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122287; cv=none; b=fjGAxdtSHbCEF7JyLCPF38KYWd3MMKyvI4kI+RONee55OApqkK4uLMaYp77nTxiMaXm+GGU/KJWlIxH7DSG4UFz9jg/cWNKwPirw8RLxEDEYzXNpSMp602yIO+txzcQLnxieBTEWXPGgfpVKbWVdUSFfcBzgw+E4Uqj3+6nqeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122287; c=relaxed/simple;
	bh=UJmean4gt5Gu55sIqy9g9jKViEoi/+RJ93Q3S6RKxAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AoT/IVgxW9VZpWTYbC35VoY/MJwalZQdG63W8VmlUJuw5K3AbRNKKfYcNIBY/yVf3Zok9EWuNXavt9/0ZiWEqT8JrRQsCqb0digDZQQmM2VEDc4eCpk6L/v+FRaJl4FkyYk9XKRkNWPds/I6Oda+HNtnCs8H64hEi2qddTo/ofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQ1TtDuc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8S6w4027709
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XfR5EkdZUrkbl2iXkWVliKw0IbYWigt1xPN
	3ZL2fjwA=; b=IQ1TtDuchQYpOrf0yM14F+vsunUrC/XHceLWaWV2IpRBE9PHZ2U
	kvVZKY1hzM71fqE9836NY1Tj6qj3V8XB7+D5QnmQ2MIHruj9akOkxTr3Tk2wyZZH
	6ImwrkOVf/xh4XJsnF0HI7PIOMGncn6Lr4YNBWng9A8FgzA2KJAfoJ5D3jekn4BH
	2JRBnCo+7edV1wN6apZgCH9nQrypbxVKoOtu1US4H2F/3E/+ESMpohhCoIsz30wq
	QXAAf04ZSMdnS8pnTaAXd5zfb8DIdtewTI8n2MDmlMiCEJFdLAvFdqyO9qAEXR01
	eSl5slcwSmLHfeUr4iIMx0V+NqBdY0032qw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdvuh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:44:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so4486077b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122283; x=1756727083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfR5EkdZUrkbl2iXkWVliKw0IbYWigt1xPN3ZL2fjwA=;
        b=SUEIIg0oHAOskAyl4xdQg9+kIYaR66BTNRPC4zUbOJ2rR0UXJWAHS8qe+Hfat18o3E
         Ty9LTTKgY7E5vUmx0cx8hI5n6fdXR+YiAi7x799kk+FkaDVxC4PnfunGNktyZxcbYmb2
         G3c8CNwdrdkqFyDOtmMZttcUXrLt9t+9dYRnG+nQKbGhVhWKTXNdoBMJoW/CNc6v5OLM
         sVFs4ihoABMcn6k30+ufJ2ZuOYcmBX9AY5a07d3mTLMe4meJt+rYWJcghD6idCVPqbiQ
         MdvxklFZc/mAZZBhyQvAmCulXbAmdmZKqrDzOf1j14tzLMpkmtXRWgRKrrMBWp7LR6gI
         50fw==
X-Forwarded-Encrypted: i=1; AJvYcCULnJuJ0hCEK69oisTYCJ1H3/SBfTj2n/rC0c3v6Rq3Io3/jza4N/gZULliMemyql5HLww0LFifB6djocc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfExx0xdcwOiYRnUtxST3YbUKPmUdOQjwi0yhvrveKABLMjKVu
	3WWl8SRqDk1xhmLrkIoUzHaYmybyjlz5WkCfFyMxuXEsi8I6ROAf62x7pAaFrR7YOpLo3d6pOnV
	5z3ERE7skHkmxZRc+ejwJ4lrrm6JTbgKjs/76+CbkzSishl5JaXvZ1UaRxKBPQ9Cev5w=
X-Gm-Gg: ASbGncu7ggPaPCByvNvuzwa8hP6vl+BLlPuFY8PUp1OlG70xuSZHklOtwOulUuzpAsG
	UzL54ktk47xDuRbIDA5spuoFTl/sOWZFuour2rHt0WZebmupmBcsKq/seDsTq7XX3tWyyVjbquF
	j3j9TgoUT5GQEmpUGMjsxzGG+ZQno0wCodIUoloiNqJOgXMaT3+Cvz3xAGuPKf+hZcqTOVVYChF
	KyLQEimEpujaFPRXbd9MKHaQiTxry1qfttUkn39hxluDBPN6tRQmWo/Oo5rn+sZ4zjdDSlDmDbY
	zJaG5Km0Zvdam+2xuXAdnLX3fKpY3oDxFvNag4mftrFDID2Ym0xctVYE1ls+AomAgWdm
X-Received: by 2002:a05:6a00:1892:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-770fd32f6a9mr4361911b3a.25.1756122282696;
        Mon, 25 Aug 2025 04:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQUtRCvLODn84AR3KmhV6AwAJG+s2Bif6J0ApwMPHtqyxbHrh+g4yqish90gz2rYBQm59EA==
X-Received: by 2002:a05:6a00:1892:b0:770:fd32:f365 with SMTP id d2e1a72fcca58-770fd32f6a9mr4361887b3a.25.1756122282126;
        Mon, 25 Aug 2025 04:44:42 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b2a06sm7155385b3a.65.2025.08.25.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:44:41 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Date: Mon, 25 Aug 2025 17:14:33 +0530
Message-Id: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cS80vymUc_2P33gk4HeY5pLvp6qYBb6l
X-Proofpoint-ORIG-GUID: cS80vymUc_2P33gk4HeY5pLvp6qYBb6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3D3Km8tgb87o
 hbdduIC43tQ6bIbe+C6FxvVqmdfwcQh71GsaBNAJRm6EBcaVGYY6h7Bg9oIkOKGutaE14nT+dTK
 EUMV6GXY1dSNJGi+obhgW4nh+23mgRyqDIEqpdSBo3a35SFVryeS5ntoP0DOioBGwD4XI5CpCSt
 EyxnxxUFzEuJXsIHlsHFexhdTkZ+ZszA6MCuHXcfnPxEypALQ2UtcHJtg4+NkAwTWMJys/e63Zq
 JSxFJPl93JmJxBJhGFy0R8t6CanS+CifwmLfEsPt379/MtUtwIw5GCgQEp0+ImirVhkiES1Q3MF
 YFIpGaVuSD+F0N6KdOVRjpnenVFKVjZDMVANFzwR3CPTgBkpHE86CLGHa/eInUpWAy8A7SfnMEr
 +g3vWK5v
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ac4cac cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5T-qrpAWhFLbsOtPRRsA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

When multiple DWC3 controllers are being used, trace events from
different instances get mixed up making debugging difficult as
there's no way to distinguish which instance generated the trace.

Append the device name to trace events to clearly identify the
source instance.

Example trace output,
before ->  dwc3_event: event (00000101): Reset [U0]
after  ->  dwc3_event: a600000.usb: event (00000101): Reset [U0]

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c |  2 +-
 drivers/usb/dwc3/gadget.h |  1 +
 drivers/usb/dwc3/io.h     | 12 ++++---
 drivers/usb/dwc3/trace.h  | 76 ++++++++++++++++++++++++---------------
 5 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..b814bbba18ac 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -830,7 +830,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
-	trace_dwc3_ctrl_req(ctrl);
+	trace_dwc3_ctrl_req(dwc, ctrl);
 
 	len = le16_to_cpu(ctrl->wLength);
 	if (!len) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 25db36c63951..e3621cc318ea 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -271,7 +271,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		status = -ETIMEDOUT;
 	}
 
-	trace_dwc3_gadget_generic_cmd(cmd, param, status);
+	trace_dwc3_gadget_generic_cmd(dwc, cmd, param, status);
 
 	return ret;
 }
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index d73e735e4081..dc9985523ed8 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -131,6 +131,7 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
 static inline void dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 {
 	u32			res_id;
+	struct dwc3		*dwc = dep->dwc;
 
 	res_id = dwc3_readl(dep->regs, DWC3_DEPCMD);
 	dep->resource_index = DWC3_DEPCMD_GET_RSC_IDX(res_id);
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1e96ea339d48..8e8eb3265676 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -16,7 +16,11 @@
 #include "debug.h"
 #include "core.h"
 
-static inline u32 dwc3_readl(void __iomem *base, u32 offset)
+/* Note: Caller must have a reference to dwc3 structure */
+#define dwc3_readl(b, o) __dwc3_readl(dwc, b, o)
+#define dwc3_writel(b, o, v) __dwc3_writel(dwc, b, o, v)
+
+static inline u32 __dwc3_readl(struct dwc3 *dwc, void __iomem *base, u32 offset)
 {
 	u32 value;
 
@@ -32,12 +36,12 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 * documentation, so we revert it back to the proper addresses, the
 	 * same way they are described on SNPS documentation
 	 */
-	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
+	trace_dwc3_readl(dwc, base - DWC3_GLOBALS_REGS_START, offset, value);
 
 	return value;
 }
 
-static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
+static inline void __dwc3_writel(struct dwc3 *dwc, void __iomem *base, u32 offset, u32 value)
 {
 	/*
 	 * We requested the mem region starting from the Globals address
@@ -51,7 +55,7 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * documentation, so we revert it back to the proper addresses, the
 	 * same way they are described on SNPS documentation
 	 */
-	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
+	trace_dwc3_writel(dwc, base - DWC3_GLOBALS_REGS_START, offset, value);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index bdeb1aaf65d8..649bc536ca20 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -20,46 +20,51 @@
 #include "debug.h"
 
 DECLARE_EVENT_CLASS(dwc3_log_io,
-	TP_PROTO(void *base, u32 offset, u32 value),
-	TP_ARGS(base, offset, value),
+	TP_PROTO(struct dwc3 *dwc, void *base, u32 offset, u32 value),
+	TP_ARGS(dwc, base, offset, value),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dwc->dev))
 		__field(void *, base)
 		__field(u32, offset)
 		__field(u32, value)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->base = base;
 		__entry->offset = offset;
 		__entry->value = value;
 	),
-	TP_printk("addr %p offset %04x value %08x",
+	TP_printk("%s: addr %p offset %04x value %08x",
+		__get_str(dev_name),
 		__entry->base + __entry->offset,
 		__entry->offset,
 		__entry->value)
 );
 
 DEFINE_EVENT(dwc3_log_io, dwc3_readl,
-	TP_PROTO(void __iomem *base, u32 offset, u32 value),
-	TP_ARGS(base, offset, value)
+	TP_PROTO(struct dwc3 *dwc, void __iomem *base, u32 offset, u32 value),
+	TP_ARGS(dwc, base, offset, value)
 );
 
 DEFINE_EVENT(dwc3_log_io, dwc3_writel,
-	TP_PROTO(void __iomem *base, u32 offset, u32 value),
-	TP_ARGS(base, offset, value)
+	TP_PROTO(struct dwc3 *dwc, void __iomem *base, u32 offset, u32 value),
+	TP_ARGS(dwc, base, offset, value)
 );
 
 DECLARE_EVENT_CLASS(dwc3_log_event,
 	TP_PROTO(u32 event, struct dwc3 *dwc),
 	TP_ARGS(event, dwc),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dwc->dev))
 		__field(u32, event)
 		__field(u32, ep0state)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->event = event;
 		__entry->ep0state = dwc->ep0state;
 	),
-	TP_printk("event (%08x): %s", __entry->event,
+	TP_printk("%s: event (%08x): %s", __get_str(dev_name), __entry->event,
 			dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
 					__entry->event, __entry->ep0state))
 );
@@ -70,9 +75,10 @@ DEFINE_EVENT(dwc3_log_event, dwc3_event,
 );
 
 DECLARE_EVENT_CLASS(dwc3_log_ctrl,
-	TP_PROTO(struct usb_ctrlrequest *ctrl),
-	TP_ARGS(ctrl),
+	TP_PROTO(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl),
+	TP_ARGS(dwc, ctrl),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dwc->dev))
 		__field(__u8, bRequestType)
 		__field(__u8, bRequest)
 		__field(__u16, wValue)
@@ -80,13 +86,15 @@ DECLARE_EVENT_CLASS(dwc3_log_ctrl,
 		__field(__u16, wLength)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->bRequestType = ctrl->bRequestType;
 		__entry->bRequest = ctrl->bRequest;
 		__entry->wValue = le16_to_cpu(ctrl->wValue);
 		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
 		__entry->wLength = le16_to_cpu(ctrl->wLength);
 	),
-	TP_printk("%s", usb_decode_ctrl(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
+	TP_printk("%s: %s", __get_str(dev_name), usb_decode_ctrl(__get_buf(DWC3_MSG_MAX),
+					DWC3_MSG_MAX,
 					__entry->bRequestType,
 					__entry->bRequest, __entry->wValue,
 					__entry->wIndex, __entry->wLength)
@@ -94,14 +102,15 @@ DECLARE_EVENT_CLASS(dwc3_log_ctrl,
 );
 
 DEFINE_EVENT(dwc3_log_ctrl, dwc3_ctrl_req,
-	TP_PROTO(struct usb_ctrlrequest *ctrl),
-	TP_ARGS(ctrl)
+	TP_PROTO(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl),
+	TP_ARGS(dwc, ctrl)
 );
 
 DECLARE_EVENT_CLASS(dwc3_log_request,
 	TP_PROTO(struct dwc3_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(req->dep->dwc->dev))
 		__string(name, req->dep->name)
 		__field(struct dwc3_request *, req)
 		__field(unsigned int, actual)
@@ -112,7 +121,7 @@ DECLARE_EVENT_CLASS(dwc3_log_request,
 		__field(int, no_interrupt)
 	),
 	TP_fast_assign(
-		__assign_str(name);
+		__assign_str(dev_name);
 		__entry->req = req;
 		__entry->actual = req->request.actual;
 		__entry->length = req->request.length;
@@ -121,8 +130,10 @@ DECLARE_EVENT_CLASS(dwc3_log_request,
 		__entry->short_not_ok = req->request.short_not_ok;
 		__entry->no_interrupt = req->request.no_interrupt;
 	),
-	TP_printk("%s: req %p length %u/%u %s%s%s ==> %d",
-		__get_str(name), __entry->req, __entry->actual, __entry->length,
+	TP_printk("%s: %s: req %p length %u/%u %s%s%s ==> %d",
+		__get_str(dev_name),
+		__get_str(name), __entry->req,
+		__entry->actual, __entry->length,
 		__entry->zero ? "Z" : "z",
 		__entry->short_not_ok ? "S" : "s",
 		__entry->no_interrupt ? "i" : "I",
@@ -156,28 +167,30 @@ DEFINE_EVENT(dwc3_log_request, dwc3_gadget_giveback,
 );
 
 DECLARE_EVENT_CLASS(dwc3_log_generic_cmd,
-	TP_PROTO(unsigned int cmd, u32 param, int status),
-	TP_ARGS(cmd, param, status),
+	TP_PROTO(struct dwc3 *dwc, unsigned int cmd, u32 param, int status),
+	TP_ARGS(dwc, cmd, param, status),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dwc->dev))
 		__field(unsigned int, cmd)
 		__field(u32, param)
 		__field(int, status)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->cmd = cmd;
 		__entry->param = param;
 		__entry->status = status;
 	),
-	TP_printk("cmd '%s' [%x] param %08x --> status: %s",
-		dwc3_gadget_generic_cmd_string(__entry->cmd),
+	TP_printk("%s: cmd '%s' [%x] param %08x --> status: %s",
+		__get_str(dev_name), dwc3_gadget_generic_cmd_string(__entry->cmd),
 		__entry->cmd, __entry->param,
 		dwc3_gadget_generic_cmd_status_string(__entry->status)
 	)
 );
 
 DEFINE_EVENT(dwc3_log_generic_cmd, dwc3_gadget_generic_cmd,
-	TP_PROTO(unsigned int cmd, u32 param, int status),
-	TP_ARGS(cmd, param, status)
+	TP_PROTO(struct dwc3 *dwc, unsigned int cmd, u32 param, int status),
+	TP_ARGS(dwc, cmd, param, status)
 );
 
 DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
@@ -185,6 +198,7 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		struct dwc3_gadget_ep_cmd_params *params, int cmd_status),
 	TP_ARGS(dep, cmd, params, cmd_status),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dep->dwc->dev))
 		__string(name, dep->name)
 		__field(unsigned int, cmd)
 		__field(u32, param0)
@@ -193,6 +207,7 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		__field(int, cmd_status)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__assign_str(name);
 		__entry->cmd = cmd;
 		__entry->param0 = params->param0;
@@ -200,8 +215,9 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		__entry->param2 = params->param2;
 		__entry->cmd_status = cmd_status;
 	),
-	TP_printk("%s: cmd '%s' [%x] params %08x %08x %08x --> status: %s",
-		__get_str(name), dwc3_gadget_ep_cmd_string(__entry->cmd),
+	TP_printk("%s: %s: cmd '%s' [%x] params %08x %08x %08x --> status: %s",
+		__get_str(dev_name), __get_str(name),
+		dwc3_gadget_ep_cmd_string(__entry->cmd),
 		__entry->cmd, __entry->param0,
 		__entry->param1, __entry->param2,
 		dwc3_ep_cmd_status_string(__entry->cmd_status)
@@ -218,6 +234,7 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 	TP_PROTO(struct dwc3_ep *dep, struct dwc3_trb *trb),
 	TP_ARGS(dep, trb),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dep->dwc->dev))
 		__string(name, dep->name)
 		__field(struct dwc3_trb *, trb)
 		__field(u32, bpl)
@@ -229,6 +246,7 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__field(u32, dequeue)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__assign_str(name);
 		__entry->trb = trb;
 		__entry->bpl = trb->bpl;
@@ -239,8 +257,8 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__entry->enqueue = dep->trb_enqueue;
 		__entry->dequeue = dep->trb_dequeue;
 	),
-	TP_printk("%s: trb %p (E%d:D%d) buf %08x%08x size %s%d ctrl %08x sofn %08x (%c%c%c%c:%c%c:%s)",
-		__get_str(name), __entry->trb, __entry->enqueue,
+	TP_printk("%s: %s: trb %p (E%d:D%d) buf %08x%08x size %s%d ctrl %08x sofn %08x (%c%c%c%c:%c%c:%s)",
+		__get_str(dev_name), __get_str(name), __entry->trb, __entry->enqueue,
 		__entry->dequeue, __entry->bph, __entry->bpl,
 		({char *s;
 		int pcm = ((__entry->size >> 24) & 3) + 1;
@@ -290,6 +308,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ep,
 	TP_PROTO(struct dwc3_ep *dep),
 	TP_ARGS(dep),
 	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dep->dwc->dev))
 		__string(name, dep->name)
 		__field(unsigned int, maxpacket)
 		__field(unsigned int, maxpacket_limit)
@@ -301,6 +320,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ep,
 		__field(u8, trb_dequeue)
 	),
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__assign_str(name);
 		__entry->maxpacket = dep->endpoint.maxpacket;
 		__entry->maxpacket_limit = dep->endpoint.maxpacket_limit;
@@ -311,8 +331,8 @@ DECLARE_EVENT_CLASS(dwc3_log_ep,
 		__entry->trb_enqueue = dep->trb_enqueue;
 		__entry->trb_dequeue = dep->trb_dequeue;
 	),
-	TP_printk("%s: mps %d/%d streams %d burst %d ring %d/%d flags %c:%c%c%c%c:%c",
-		__get_str(name), __entry->maxpacket,
+	TP_printk("%s: %s: mps %d/%d streams %d burst %d ring %d/%d flags %c:%c%c%c%c:%c",
+		__get_str(dev_name), __get_str(name), __entry->maxpacket,
 		__entry->maxpacket_limit, __entry->max_streams,
 		__entry->maxburst, __entry->trb_enqueue,
 		__entry->trb_dequeue,
-- 
2.25.1


