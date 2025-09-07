Return-Path: <linux-kernel+bounces-804767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F415B47CC3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A00E17DF0A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72C29D26B;
	Sun,  7 Sep 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZuiEqgn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731829BDB6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757268871; cv=none; b=Vh8idyYzdi3iyeIRLlyYl6BzVyUyCk8IaFlg5w3ueFAhfhGtvwXVtnryyVcJYTv5nbZwW4nTpEfOJXr6PBw48TQL/mOAFL6h0nBh+9SDk7RNozMO3VNIrCSdTh0JJpzusqo4aQRP8ckPqUkhSUT49qAJCufNGr3HeaZ996FuBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757268871; c=relaxed/simple;
	bh=R6KKjfE0n/H51wIYeESx4WmybdDuxempHU7GWuXURpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMSyJns5XuGXwG4nanEPb4axuEG3MonFsZ3P3IAjy8NUKsE4JVJvJF3TiQYoMc3F+P3NTM6h75YcJc28Jzd7XPkxskzSRgROPheousZDV0E8sZnH0tOFFXV/8/V1ESGEXMAs26dNWkCra978DxKP/Y7tmPBL+CXeZNWuyQ0sdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZuiEqgn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587IES8I006217;
	Sun, 7 Sep 2025 18:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HqVMPP7bx9r
	Rkhe1pncl2vK9OwnV++uC7gBR+2Ge7ck=; b=jZuiEqgnGmrXFfS6XPlL92fqqQj
	EqfFMKdp3IJqTX9DChqyIRrbDA6gY3cwEp4/6PcLrpTs90RqZKD1GsEP1wvrEOV5
	f8MXc28eTc8W8yjvRaDohOiaYMzi/BiIgoeBMmyZlD+IAFUFykMyNcmphfE+Cv3j
	KqWOWUcP1FfOIe/Wh1zAnD38nHLxXwMcIudTCQfDxFz1JBq6qJxT1hZnb0hmNI52
	ZlWX3j9f60L+13VqgIAUX98XbgBN0naZTWVWgyai/IfCy773ciuAOMFZYv2vvBwi
	LMaaQhN6zrBNL630hLtPjlubylLT5pj1DZ9nByWnJ0fkyXwsNUk22OwyrKQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63ad82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:14:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so74667115ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757268868; x=1757873668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqVMPP7bx9rRkhe1pncl2vK9OwnV++uC7gBR+2Ge7ck=;
        b=eP5w0NZcl80Q6ZSP2cFKxfk2zDtjBrmcLpgjh9mm9oaySoMkO1QKxlGv1aZu7kP66/
         o9zLvn+B7Ih8jP1qZGXMskoKrOsl9Bv8br2PZ+D5Dbc3KVv7UjzoXrXPQRaI4NBbNdtL
         /opbQLptyGKnKxzx7MljgLxyI31KysgpNcx9313SAKlzrswtg5FVApdgkHiyTw1aOIFh
         hirTj178DPMLYv0m/TdbOGKo8zbxz6UjpRK1CIGozNeZwO0VAFPAtLHbkB1ZHdJzEaMs
         HKSMvbI2Xnilvi/vQjbH+3nNgfFOyMnUnpolqTqksKqaeili+/mn/xYoFmPB55HOmRER
         NzRw==
X-Forwarded-Encrypted: i=1; AJvYcCWMw6G0lUQPJXQ3lzEu/siV8UwGiRSjnBmblJGDhvcBG3u5GpSQUNPmg4obmuMQ9rp0BSNUIUeB0X0BSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdsJM20w7Ve8pPLsxa7pMZELYFPB+r++XBnWafdlZptOkmni+
	3MUe6G46YlmnrFk+jANaHfGSL5pXARInhdsEIOSDdvS+62Moyjidbu+jK5Sz/7VNVdiQwUjLFwk
	nDB9T3S8p3HwDk5ekSWqw1pSARqebGTrgMAtDz7TW6u4cPcZyP0TCVM2BHRVDbbd+THY=
X-Gm-Gg: ASbGncvXgfpY0rPo2Venrrel+taBvWr1b4Jry1JyeVMAOxPRvKLYQ6/NPj8pkXaL1I9
	Bgk36dlbQ87QJVhUzNMIPM9sueL0XudRWMRbNvjhTGNMQGWGYk/5t1ve9b9DIwBP9WjjEwc2x1p
	PRnY90vwbw1aU9hRQD7wAM3pLnUOkXwgo7c+CkWjIOqX3ByWzaNGhFT/WZv1s+9DallVbAwTiyS
	9RKetKtND1x4tuakcEtPP8LOr2WNOVFdIIgqxhX3rEo61a2b8cUO/3Ev57HNezBy1+YuqH5MnIC
	c/akl89oZpfyyyBsqqrKU0Zx7kNCleNJRMiE04Mxks6eeke1DAcS4Ec2L+PA+wbaTZVK8FtWAol
	dig==
X-Received: by 2002:a17:903:1b64:b0:24b:2b07:5f72 with SMTP id d9443c01a7336-251736df041mr62517365ad.28.1757268867491;
        Sun, 07 Sep 2025 11:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExzyBRYl6czyYwC9M0nmWMqo3nas+FD4zYM1tcPoUdDpDX4XkmMGGylyH9dVar7eL9Jvbg1Q==
X-Received: by 2002:a17:903:1b64:b0:24b:2b07:5f72 with SMTP id d9443c01a7336-251736df041mr62517165ad.28.1757268867005;
        Sun, 07 Sep 2025 11:14:27 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cde5b6484sm84074765ad.19.2025.09.07.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:14:26 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5 2/2] usb: dwc3: qcom: Implement glue callbacks to facilitate runtime suspend
Date: Sun,  7 Sep 2025 23:44:12 +0530
Message-Id: <20250907181412.2174616-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com>
References: <20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfX24JhYZLCcWGZ
 YVK0XQWUFLIfO1XO9/Mrhr/izryGkiYQ9tNCm2ipIZd6RX1Jl+Yen+VhOPbQ4hl29jmujCKcnEy
 RJx6CxuBtZD/0rHf4CcN9z6LTM7d1eLm0LsSIwRRUTxSs5wdbHVwMAB0c1sqZhBR8CO3RURY/ap
 sloC+Y41HeBnBgFer+1NJCnfu48ogxT0woAlu7VXw905HU/57A/S4AyniV2aY+acKimV1URdRnS
 5nNARy1jjE7sGH1VKGYgDKpq7fPlPfgqgY/MifVTMRoUfVCR56ddlbTejt3ek/rLC0sC8o+sEqH
 eBOr7jiWGqVxObKGvPChjmd4TiP2pOZUiatwN1S9lvZqxcj18JWH6U6DymbbF0Oo1ITP0cyzSfu
 /oA7PoYu
X-Proofpoint-GUID: A0Rdny5rxZaPzOy9LEtqQ70zm9Ftdpf-
X-Proofpoint-ORIG-GUID: A0Rdny5rxZaPzOy9LEtqQ70zm9Ftdpf-
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68bdcb84 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8 a=ProRYBKZBCDr5nQBVQAA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

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

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 78 +++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 8a9018ca650c..ded2ca86670c 100644
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
@@ -560,6 +558,55 @@ static int dwc3_qcom_setup_irq(struct dwc3_qcom *qcom, struct platform_device *p
 	return 0;
 }
 
+static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_role)
+{
+	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
+
+	if (qcom->current_role == next_role)
+		return;
+
+	if (pm_runtime_resume_and_get(qcom->dev)) {
+		dev_dbg(qcom->dev, "Failed to resume device\n");
+		return;
+	}
+
+	if (qcom->current_role == USB_ROLE_DEVICE)
+		dwc3_qcom_vbus_override_enable(qcom, false);
+	else if (qcom->current_role != USB_ROLE_DEVICE)
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
+	dwc3_qcom_vbus_override_enable(qcom, true);
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
@@ -636,6 +683,23 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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
@@ -650,12 +714,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
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


