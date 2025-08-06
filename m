Return-Path: <linux-kernel+bounces-757586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546FB1C3EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B455B3A6163
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89C28AAFB;
	Wed,  6 Aug 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wxi+Htik"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65328A72D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474326; cv=none; b=H/k6Jt88PdEpMffll+eqHALkwVa/jmamR1QUVX2jn2T/gQV/DKAWsB23LVlDt1N9DS+yj+TDsOuMl2tqkUnCQaEplOtcYeBlw9/Wn9A0ZzWGo1N03OkkXdLTXBius7oZaTyCxrg4A7CjkCQE1zmFinhtrb4YOcWLcdu91CCNMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474326; c=relaxed/simple;
	bh=ju/IORgQMB5tw2a5Yi2XNxvS1dzi7whPBV6L6KZ0pV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7BCao3So6JusWY/+5BVPmllYFJPLZoaiTF6RnFcxS+h3gnsEv1aGeRAqQImhh9gRbF7xUs0mTvms/7TbQ/JYnspgubVSgLuUY8h1P77JyaUYlS2k/PVVexKPm/YcTGZ/q5aAfmHDKzsJ1A32LJRqZASt9JtJ1c2zNS2mgH8DTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wxi+Htik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769ekpC032245
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x7ELA2sx/Md
	WoybRTVV3B4u5eWgexiePTdCJcLkR0o0=; b=Wxi+HtiknpYF6cQ0xPD0k0Z/0mI
	tiUZI+pbXoa+NEbiDqS5fk7jNdPTaSViK5KVkk3ex4D6mrr66QUOfsFg6i0Oj9OH
	TuU5ofrI3XzGRYkKMIx4T+HuFrp/sjmg/Tw4rzUECwQjtWbPmk9qkos87AYVqGGU
	3hK3jLcbaLQZOizGvPVlcCkkvekQIBCV8CVFLuP0ADJ7JjOOjqGxw8wCFSVlIMym
	E0gb5pVtL911GdHFBoLQrdzm0LMzbwkZgkXqEfP+Yb/Pwb4/yzgp3B3qix5eAfwE
	yBhd354VTFfIK3pBqhvM35XQb8cgYVAJex+4Ht4jaVoIEPj0f7tWvXmhwxg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2tc4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:58:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so10529626a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474322; x=1755079122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7ELA2sx/MdWoybRTVV3B4u5eWgexiePTdCJcLkR0o0=;
        b=AnSkzHZTAznWbZxrGgNh+dlGMN8hATwZUWCKIRSJ0hZjLG0R13UNdAm+RogO12iZso
         I5Y6/mVIpai9w/Id9NOVm5Lg53f30Z1xaVpad6pxjhI3Bhm9vo+YvZfJ/CeF8qEPbwcK
         5rbpqyHom/Npzd1QckyKkFu5lru74mdtl1dzr4vOYD8XxAjukqOvCsZ/TAR8NKgIxar6
         E1XxgcCYW+JWOgfziT8dvQh7B/5Ak4EbJoFV3Xo6UhN2TdQPW39D+jAJ7xoKhwBfkNzI
         Whhp19i+qsv3dZj/9w7ZTGuAqlL5M75KSsH7fErPQ1D3jCTYdl65IQ1ZEvDFaS8rl/h2
         mF0w==
X-Forwarded-Encrypted: i=1; AJvYcCWinLIFhQvEhzuZJKm+z5aeyAZrxu/F8QUnpeTuFlOQzSPGiAeRZgC3qQ1cyR7Ez95437eAxw1hVd9+N8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNirREX37uEUM75ldp08JXEdCkHMu2JcoLomeDH+iX0JAP9prS
	Y8po/Mdojf3iwKzAFXRkL9w1hPe56DHL3GUiWnhpDmnKr+edEqXjNkbfbIga8w76PDyMbWS3QUJ
	MYRj/3EIT8GhgfitaPu6JLKSYJRHwZPfqBMsfFQ9CdmRAoohEhzceJVWeYPJ7B3bPwRM=
X-Gm-Gg: ASbGnctcS63K6nZINWMV5Ecu5urgoOEYwrK54QxLun5bI71iRHtDc4NpkifGP/+QJhn
	zUaj21CH8Wbgx2hK1zUf2cGjyLIY4pn2Orh+ybA9d7dDdK1tcBUzy2PzeqDmHyuNM6Ud4Bvcu7Z
	VdISujYRQcLe5VfB3bDk1PULkE63pztoxbNuPsnUqkrmJ+PXvIWGWscputJvibJkqThTpMsenrn
	SnaA7Ln++TMi9ZT46z9WUbZXfCS3UfHbmy0eQX+dF1nuXu21LzR1q6tAAqIrvmYI+s07MyQur0q
	jTziM31lYd7aoWz1h/rEqQSTUaUibmSHHBLP0M3AMLwKsA9wbCCdcuGs6O9JqQxs3X10OBPwg2s
	uNA==
X-Received: by 2002:a17:902:e748:b0:242:9bca:863d with SMTP id d9443c01a7336-2429f59ce44mr27650285ad.55.1754474322024;
        Wed, 06 Aug 2025 02:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuMxZalx+X0hAPVDbFCyTqiK4CqecAEXQQJUNlBXvwPtaAOHPwbvTXEoeeBROEhQvq+lkCKg==
X-Received: by 2002:a17:902:e748:b0:242:9bca:863d with SMTP id d9443c01a7336-2429f59ce44mr27649955ad.55.1754474321497;
        Wed, 06 Aug 2025 02:58:41 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm12908799a12.20.2025.08.06.02.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:58:41 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3 1/3] usb: dwc3: core: Introduce glue callbacks for flattened implementations
Date: Wed,  6 Aug 2025 15:28:26 +0530
Message-Id: <20250806095828.1582917-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com>
References: <20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=68932753 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9UFxAfr_hboBSpCGZXUA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: VwhsSv3JFLaQMDuKEgzy5-Bxxh-NI9Uw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX5AvCILsXUSdH
 L0N1Use1ioPQqv9MYw3vSmtuBPUHMtPi7tjiOujSqE63H9od5ntOBoXRRmMQ3ViQ0ZbzXiM3zBK
 t83la2pgSCWttg/VufFqwlxK/gs6xBcvyw9QWcaY8+vC3GdnCd/nfPgCzM36WS2JhQ0fS+RXOmf
 gBtqhMdwyley/8JKFZ2KU3jr2+67UOCjFt3JMFFd+ZIxgLLPzmPalLqGddQfFbsNiR0ulV1WHWd
 z14Vpbjhx4u3Qvzbm4Ovouh1oernv2iMXBoKXQYnLfYZOc9eMdoTmyVmvySAfzfRl7iaRheyoUV
 BlpTfRX0VRU8WfdGTmvb8xJoR3s9oTwDeJH7DhAKX3qVNYUs46VXH5ulK8L/UzvMjJCvUUd4YmB
 l81ot59s
X-Proofpoint-GUID: VwhsSv3JFLaQMDuKEgzy5-Bxxh-NI9Uw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

In certain situations like role switching, the glue layers need to be
informed of these events, so that they can take any necessary action.
But in non-flattened implementations, the glue drivers have no data on
when the core driver probe was successful post invoking of_platform_
populate. Now that the core driver supports flattened implementations
as well, introduce vendor callbacks that can be passed on from glue to
core before invoking dwc3_core_probe.

Introduce callbacks to notify glue layer of role_switch and run_stop
changes. These can be used by flattened implementation of Qualcomm
glue layer to generate connect/disconnect events in controller during
cable connect and run stop modifications by udc in device mode.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c   |  1 +
 drivers/usb/dwc3/core.h   | 26 ++++++++++++++++++++++++++
 drivers/usb/dwc3/drd.c    |  1 +
 drivers/usb/dwc3/gadget.c |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..392ba86c69f5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2351,6 +2351,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dwc->dev = &pdev->dev;
+	dwc->glue_ops = NULL;
 
 	probe_data.dwc = dwc;
 	probe_data.res = res;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4..095311e636c5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -992,6 +992,17 @@ struct dwc3_scratchpad_array {
 	__le64	dma_adr[DWC3_MAX_HIBER_SCRATCHBUFS];
 };
 
+/**
+ * struct dwc3_glue_ops - The ops indicate the notifications that
+ *				need to be passed on to glue layer
+ * @notify_set_role: Notify glue of role switch notifications
+ * @notify_run_stop: Notify run stop enable/disable information to glue
+ */
+struct dwc3_glue_ops {
+	void	(*pre_set_role)(struct dwc3 *dwc, enum usb_role role);
+	void	(*pre_run_stop)(struct dwc3 *dwc, bool is_on);
+};
+
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
@@ -1168,6 +1179,7 @@ struct dwc3_scratchpad_array {
  * @wakeup_pending_funcs: Indicates whether any interface has requested for
  *			 function wakeup in bitmap format where bit position
  *			 represents interface_id.
+ * @glue_ops: Vendor callbacks for flattened device implementations.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1197,6 +1209,8 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	const struct dwc3_glue_ops	*glue_ops;
+
 	struct clk		*bus_clk;
 	struct clk		*ref_clk;
 	struct clk		*susp_clk;
@@ -1614,6 +1628,18 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
 int dwc3_core_soft_reset(struct dwc3 *dwc);
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
 
+static inline void dwc3_pre_set_role(struct dwc3 *dwc, enum usb_role role)
+{
+	if (dwc->glue_ops && dwc->glue_ops->pre_set_role)
+		dwc->glue_ops->pre_set_role(dwc, role);
+}
+
+static inline void dwc3_pre_run_stop(struct dwc3 *dwc, bool is_on)
+{
+	if (dwc->glue_ops && dwc->glue_ops->pre_run_stop)
+		dwc->glue_ops->pre_run_stop(dwc, is_on);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 7977860932b1..4c91240eb429 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -464,6 +464,7 @@ static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
 		break;
 	}
 
+	dwc3_pre_set_role(dwc, role);
 	dwc3_set_mode(dwc, mode);
 	return 0;
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 25db36c63951..999b2e436622 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2658,6 +2658,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 		dwc->pullups_connected = false;
 	}
 
+	dwc3_pre_run_stop(dwc, is_on);
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
-- 
2.34.1


