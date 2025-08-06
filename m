Return-Path: <linux-kernel+bounces-757587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93FB1C3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812823A9991
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39128B4E7;
	Wed,  6 Aug 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2QXKArM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946428AB15
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474329; cv=none; b=A9JzKF5NJNbmS14RVZ7lZkcTam5HRK3aMb5tYEwztLaetZBgrxrg+IvNhaF9JEmrWrQ4nKE0gCl37ER1g5gwYQwvG83a/jkNmCACeYl+I88IvqHnecuZgqqPX6QQ0EFcsugCfiMu1tHRaP17PlEod0uzMGMugpdu0LVhiyc0I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474329; c=relaxed/simple;
	bh=Q0jotWCx8lw3kiOXHdKfvvEsJG6bqzwDNL4jvrq7Dm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOM+liXoiwlG0WDVpS8C9OJuPj9KddVabJkh9tOQGw0+wL09g3nUSFcaOKwyp+o2V4XhwUefXHpg1fJgunEj1hXTaUGCEYruF6oRS1zQf6m1a5F0iqixaTBogxIkQzTWtX5nWB6NZ2NLNukLjQyX3/wsALaur6nMqlU8mL5r+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H2QXKArM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766RGkH019544
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fVZRycOyI4f
	TiPSxxA8gtUsZQNfxtdl12OYtC9dsMbk=; b=H2QXKArMU1NTPbiwlrdZx2neW5K
	PfYDAWx++MMcD1Rh2PhtnxdexI0K+fm3mHsPLKCyHg75s1YtYiGNIkaCZ1/jQDoy
	PZ5gy+fZow8eR5+uwaQiualVzOAw9VwccdgVsXXD0xhfE4yQxFk+TO4bweYMMza3
	3pcrvufr5vkCoiDghVWYMePjcdTFLZD01dr52HW9JiFRshkOKS47sQAq/SVT2w7I
	ziPXOl9xSrCZ835i6S2gdLTeGQ0Tw5+AxmHENbb996iHToHDxyqKS8fZz7zzkSMI
	oMXwwAYErM/yfeE94oBLmiA1P5C4S+5LeKwLmCN/VBLVsexcJUea200ZWjw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6t7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:58:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so5198012a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474326; x=1755079126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVZRycOyI4fTiPSxxA8gtUsZQNfxtdl12OYtC9dsMbk=;
        b=JyfsAhZuZWHUxx9mOLQVErrG8epLwHQcis7DR1CeLj/ZT76qQbdPCDqOrKUkDyGfp7
         J1RzIUz/O1fmgErXGeH57+5pfaIs4v1DeysXasvwPzexG48dZgqFFCGoPEMIm8zifpGp
         qBTibK1+ub1C0av+xgDLTDxAfczffGERZgcBKzUE08OOpxFh9wLzQJJZ/GXogbiiq6Ri
         J1iOq9rCUb5/lcFTfLtT2xj0c+dwHA21PjdMaMH1/oRyYYxORlR+yT/kZmC/b+Qhohu4
         7MYby4vgY0+jxx7JIguWHYW9AABeDBSeTYnBEKbmZHMHBiTCIjNKob7EVjWuzQl3VeDm
         SAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZGKDWe1cMJxYzH8NamoSKkRWduAM6DA9JsU31GjhebWN3K098FiWxnTyd6LjX1reT5YIV+OdXPJ2pD/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzus1nAlH1LTQ8K99HvHvcjJqJ7Oc4celLthS8NpFVAN7OklkL2
	zkKn4ou1Lbf9y3LpZ9mPMJT35hNvWr3GA//l4Vs+1zi6PDCR+pQu2k3iX09MeP0mPePOjIP1SNH
	0L5jzNP/J98sACinmgZgIyFbx7LM8pu2Ph6k/iOmXbKH6Wcu7wOAS92Hn0W6aRs2eYF0=
X-Gm-Gg: ASbGncsFF7ANsyIIE0laICSnAKAczP6fO7O/rfVUHypYbOtvZGkRrVjXQQv7rfd09qN
	4rsghfa9iN3WQnOZSMz1//OZEd8ZYEiljc+1WV9U8Hx6hYvO4ZR2796NB1jIxD/anwydhYzmgE8
	HqVJlQFScqp168D9Q0uD411VcJQ0IPwjatrHZWPYMURC+BLHvaHnzmofTso0490GxgjyGpul3NR
	s4aOpZd42fcjWRtDBeSGFYUp6O/XRnsWGIVnfYsYBRYyvpDmDA4hXiRy4/j2+m4EJWbLBbtpB34
	NtaWBL67/ldNyiZ1PWFYYadrDVfW8OpjzM9RdVQDA2v+DnMCbjCfPTlBK73/Ivp9oNFYpNk5paT
	lXQ==
X-Received: by 2002:a05:6a20:7f92:b0:240:265f:4eca with SMTP id adf61e73a8af0-240315267eemr2940577637.36.1754474326220;
        Wed, 06 Aug 2025 02:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq+jEQLnn5Gmoqfhh5VZvBN75Iy0ukWpVZT97ZuZa6Zzjx8vgThnl/2jLYYF3bsWLTSmbQbQ==
X-Received: by 2002:a05:6a20:7f92:b0:240:265f:4eca with SMTP id adf61e73a8af0-240315267eemr2940551637.36.1754474325781;
        Wed, 06 Aug 2025 02:58:45 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm12908799a12.20.2025.08.06.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:58:45 -0700 (PDT)
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
Subject: [PATCH v3 2/3] usb: dwc3: qcom: Implement glue callbacks to facilitate runtime suspend
Date: Wed,  6 Aug 2025 15:28:27 +0530
Message-Id: <20250806095828.1582917-3-krishna.kurapati@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 4xc-hyfrIhDRV_cPEwafPbDzWXNYmtGG
X-Proofpoint-GUID: 4xc-hyfrIhDRV_cPEwafPbDzWXNYmtGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXyVpGKgTZBKfj
 FKZJj9kt5VboOUetNF36HHqkLQ9sY0RpeIOkvhd3nyck7TPV+T1rdqOB6ZdY/vothtYOVYsWb7F
 fiMHH7Hyfd/8o8tidC8mOJvpSF7V4xLOypSzp6v2K2khYV+1Pd9IJVAOqe9Jvu/gIsHxnrTPslV
 bFtrigW7lWC6ugRP+N+RxT3zE8NJ2lAEFqtHSrr1+JYMTBC3tQqfepbkKYNYTlMpwbtZdScGhvO
 qwAENutu6jaRsvrYcQEgKQEeMa7aMdHz/Nfy5awgnotYQVtGTq2sTn+1yZxbvBGP7OEDSJc65/P
 ih7OKFwBn+wm/xJaOtPy/llRrsJbP5vE8jF1bq6PrmObL+294eFtxamgCDbpYhda1iQT13VZgNN
 q59saQnr
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68932757 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ProRYBKZBCDr5nQBVQAA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On Qualcomm DWC3 dual-role controllers, the conndone/disconnect events in
device mode are generated by controller when software writes to QSCRATCH
registers in Qualcomm Glue layer rather than the vbus line being routed to
dwc3 core IP for it to recognize and generate these events.

UTMI_OTG_VBUS_VALID  bit of QSCRATCH_HS_PHY_CTRL register needs to be set
to generate a connection done event and to be cleared for the controller to
generate a disconnect event during cable removal. When the disconnect is
not generated upon cable removal, the "connected" flag of dwc3 is left
marked as "true" and it blocks suspend routines and for that to happen upon
cable removal, the cable disconnect notification coming in via set_role
call need to be provided to the Qualcomm glue layer as well.

Currently, the way DWC3 core and Qualcomm legacy glue driver are designed,
there is no mechanism through which the DWC3 core can notify the Qualcomm
glue layer of any role changes which it receives via role switch. To
register these glue callbacks at probe time, for enabling core to notify
glue layer, the legacy Qualcomm driver has no way to find out when the
child driver probe was successful since it does not check for the same
during of_platform_populate.

Hence implement the following glue callbacks for flattened Qualcomm glue
driver:

1. set_role: To pass role switching information from drd layer to glue.
This information is needed to identify NONE/DEVICE mode switch and modify
QSCRATCH to generate connect-done event on device mode entry and disconnect
event on cable removal in device mode.

2. run_stop: When booting up in device mode, if autouspend is enabled and
userspace doesn't write UDC on boot, controller enters autosuspend. After
this, if the userspace writes to UDC in the future, run_stop notifier is
required to enable UTMI_OTG_VBUS_VALID of QSCRATCH so that connect done
event is generated after run_stop(1) is done to finish enumeration.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 80 +++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a7eaefaeec4d..5195267cd34d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -83,6 +83,8 @@ struct dwc3_qcom {
 	bool			pm_suspended;
 	struct icc_path		*icc_path_ddr;
 	struct icc_path		*icc_path_apps;
+
+	enum usb_role		current_role;
 };
 
 #define to_dwc3_qcom(d) container_of((d), struct dwc3_qcom, dwc)
@@ -111,10 +113,6 @@ static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
 	readl(base + offset);
 }
 
-/*
- * TODO: Make the in-core role switching code invoke dwc3_qcom_vbus_override_enable(),
- * validate that the in-core extcon support is functional
- */
 static void dwc3_qcom_vbus_override_enable(struct dwc3_qcom *qcom, bool enable)
 {
 	if (enable) {
@@ -560,6 +558,57 @@ static int dwc3_qcom_setup_irq(struct dwc3_qcom *qcom, struct platform_device *p
 	return 0;
 }
 
+static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_role)
+{
+	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
+
+	if (qcom->current_role == next_role)
+		return;
+
+	if (pm_runtime_resume_and_get(qcom->dev) < 0) {
+		dev_dbg(qcom->dev, "Failed to resume device\n");
+		return;
+	}
+
+	if (qcom->current_role == USB_ROLE_DEVICE &&
+	    next_role != USB_ROLE_DEVICE)
+		dwc3_qcom_vbus_override_enable(qcom, false);
+	else if ((qcom->current_role != USB_ROLE_DEVICE) &&
+		 (next_role == USB_ROLE_DEVICE))
+		dwc3_qcom_vbus_override_enable(qcom, true);
+
+	pm_runtime_mark_last_busy(qcom->dev);
+	pm_runtime_put_sync(qcom->dev);
+
+	/*
+	 * Current role changes via usb_role_switch_set_role callback protected
+	 * internally by mutex lock.
+	 */
+	qcom->current_role = next_role;
+}
+
+static void dwc3_qcom_run_stop_notifier(struct dwc3 *dwc, bool is_on)
+{
+	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
+
+	/*
+	 * When autosuspend is enabled and controller goes to suspend
+	 * after removing UDC from userspace, the next UDC write needs
+	 * setting of QSCRATCH VBUS_VALID to "1" to generate a connect
+	 * done event.
+	 */
+	if (!is_on)
+		return;
+
+	dwc3_qcom_vbus_override_enable(qcom, is_on);
+	pm_runtime_mark_last_busy(qcom->dev);
+}
+
+struct dwc3_glue_ops dwc3_qcom_glue_ops = {
+	.pre_set_role	= dwc3_qcom_set_role_notifier,
+	.pre_run_stop	= dwc3_qcom_run_stop_notifier,
+};
+
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct dwc3_probe_data	probe_data = {};
@@ -636,6 +685,23 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ignore_pipe_clk)
 		dwc3_qcom_select_utmi_clk(qcom);
 
+	qcom->mode = usb_get_dr_mode(dev);
+
+	if (qcom->mode == USB_DR_MODE_HOST) {
+		qcom->current_role = USB_ROLE_HOST;
+	} else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
+		qcom->current_role = USB_ROLE_DEVICE;
+		dwc3_qcom_vbus_override_enable(qcom, true);
+	} else {
+		if ((device_property_read_bool(dev, "usb-role-switch")) &&
+		    (usb_get_role_switch_default_mode(dev) == USB_DR_MODE_HOST))
+			qcom->current_role = USB_ROLE_HOST;
+		else
+			qcom->current_role = USB_ROLE_DEVICE;
+	}
+
+	qcom->dwc.glue_ops = &dwc3_qcom_glue_ops;
+
 	qcom->dwc.dev = dev;
 	probe_data.dwc = &qcom->dwc;
 	probe_data.res = &res;
@@ -650,12 +716,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_core;
 
-	qcom->mode = usb_get_dr_mode(dev);
-
-	/* enable vbus override for device mode */
-	if (qcom->mode != USB_DR_MODE_HOST)
-		dwc3_qcom_vbus_override_enable(qcom, true);
-
 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
 	device_init_wakeup(&pdev->dev, wakeup_source);
 
-- 
2.34.1


