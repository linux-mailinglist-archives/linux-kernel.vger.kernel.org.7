Return-Path: <linux-kernel+bounces-679031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74FAD3193
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39257A9FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994928CF5C;
	Tue, 10 Jun 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhZcr6mL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BC28C87E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546858; cv=none; b=m+75nQHiOuCdslEkW8jvqDnbjmL+/bD8Mm7QEhD3D6yyuf5AEUL5DwEA0PGCDLUgBj5MnNU6mFiGhpaRqZ9uaTcHitH32JX31dAwkwBjp7KP8KLmCqZEyuddT1IGjzPj/kzlj4MOwlXQ9k+DtM6vTxi3i51gQkqZAcv3Apg+EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546858; c=relaxed/simple;
	bh=iru2/JKFS5VA0xmf3oFMPSCbMsMXc0mxSWJDqq5yqUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e82YdfZAKVkR1fVxnGpyuVB/7fcy1uTOq9/KMlTZW8shEVnDGDNmMTmptnIRyRFczrIVveJh3UQgbd/PoFPeKZnlzEggbvEdMBOpcauZYdRjwILrYW4Afs2J3giz7EmnKglGWIyQMvW/EXyz1IIyzIZ/zxeniDQ1hNIKoiSEs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhZcr6mL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559MLpX6026500
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RnvvbqWSyaQ
	3j/Id/nFgBao1+PiRTLwvAm3KqEZeyH4=; b=mhZcr6mLXGhdMTrkWimSjOHFr99
	S6yb2YI/nu54D5M8lD+GyQe6OmMA2umhEzUPs4kLak8vIE6ds0hXw6gaaOAIzHYy
	1+JrtpfY7qvHWG3KWxN3Shq1RrL2XYD1duvxXUz30+C49jWA/gVFqy9PNcTccI6I
	0EcsJLpm4NbgkFXjXhH4zkx8EvTnaDoOCp6TZBIlIVzHz5h3yglLLG6rXR9jCI7q
	CyPCOIRpFet85S2B64oNnSNDtpoEcHcrk2qBv13V5Q7++1m90lSmafT3O1RRfm2M
	pbRmN3Y5OWOudPB3r1uX3yxcwUFfQExNazlumfD1M9pDXNaQ8R7x/vP8WdA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ce9rve1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 09:14:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2350804a43eso84506455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 02:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546855; x=1750151655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnvvbqWSyaQ3j/Id/nFgBao1+PiRTLwvAm3KqEZeyH4=;
        b=GqrT7oWStfQ8NAWRAraHHfrhxEY7+SRpqqaI7qE39m032LByx4GuLFsT3tjPUpNN+n
         9dOex+GCz1mCaK8GF9F5OroM+qpu0EjuhP6+FSzRCdawI0fszooNM+0URLMHX06sKQ9P
         H7tvMtjhmLn641CvZPdFX5a4k6FrRn9mGpamnUBOKL872rK9AyvC1eiKwkUtr1gqsJoE
         u+EkjywODpcFFFOPbSHCMo+hZJLXUsE0PyLR2VA9h/53OX3Jrq3Q4PXkS2bC/GCunvVB
         SG+/t3EVM4QUHZlpd/XyK3D5pLzcDTZ50M3e85inT/8OVMQcH8Zcb8wHgwi1UwCuacIO
         8dPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXZoGENvUfUKYGvmoFh3AHiORkNgHQXNNBzCJLML/HkZyc513RZq06vhjRR2Y+O/4CKZBkGlxySEgGN90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9i2DdSmz1T4hDJLUAkeuouMHaAHIhAbf7XKH5DMkA8U1tGxvy
	/IHDePsifCYIIBwofeiEc28/WTPVtcE+suZY0Q9DFVWx9FKgvcgURiGBjqxoTNqL5S2+poQIfOM
	UvfAub+uvY7SW7SUWd7/FI0EM5qlUxczLCF+dZZqbIUUG8gBfWvj01tjfJmmHFJPPK00=
X-Gm-Gg: ASbGncs1GVnLP/6nt+jv28TkwbXJz9yV/3F8+hxHWq6C7xHORk8IzD5e1JfFuPMFj5f
	IwHMqp9QLCB87erpOKNfll7BZTaJIE6D5pBiR3F0XnPyvsrF0QiZSwCynjje5pGDbqCiGNeY8gb
	wxbBJfTrQ2MC0HUtxpuh5OjpINfhgUjBmDO8YTihl1GtS0PKgFgDCkcA2ljLibNrBecVTM01Bmg
	v/MoW8V6wcOrjSxGJLIWl4S1QjaL7D2ySPfjMD9kHaUuWuw5CbqWgaQuFljbql9G+IwZ9rcf0Ou
	jDh8n7OwgpLk6i2ujKA2LSdnbkXmDTUC7DYS8KU25IVeDmBQi1KvpNmcDYux
X-Received: by 2002:a17:902:ecc5:b0:235:eb71:a398 with SMTP id d9443c01a7336-23601deb495mr246989585ad.53.1749546854791;
        Tue, 10 Jun 2025 02:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQwCxRk7YOVwl4mE79Lsr5OwMTss00V2UBmwFjYouuPybuq+HoxmG2443b8pdtM1P9I7UPTQ==
X-Received: by 2002:a17:902:ecc5:b0:235:eb71:a398 with SMTP id d9443c01a7336-23601deb495mr246989165ad.53.1749546854336;
        Tue, 10 Jun 2025 02:14:14 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc3e72sm6913550a91.31.2025.06.10.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:14:14 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v2 3/4] usb: dwc3: qcom: Facilitate autosuspend during host mode
Date: Tue, 10 Jun 2025 14:43:56 +0530
Message-Id: <20250610091357.2983085-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com>
References: <20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 46-D0UQX_KeDpx_WxEHEtdtcelvtT49F
X-Authority-Analysis: v=2.4 cv=drjbC0g4 c=1 sm=1 tr=0 ts=6847f768 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=5CM_793GkT3ZRPfwn_AA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 46-D0UQX_KeDpx_WxEHEtdtcelvtT49F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3MCBTYWx0ZWRfX1fZ7IGEOpbD4
 a3Dr83jDdSJmnbTop6hJkkUxGRmXjU8FUAHrucS/iwJYyEWpB8u/SyAs5g4V0+nXouRrMCE9qUI
 o4xwSM/0/QzUpXyMCiaftr1AAoQvVe141p4Z/qkBNEKcYzVx9zAXlBKFlzEKTtsi8GtF2hfn8XT
 8rQMgjKgXJk1xyUjMxCPqJ/Ik7jeK4HggOBKjGdzb29IAKC9Cw+bWIdYDrKEC1df403TNfWER+R
 tOWXgXX272+oCw31ji67Z0cDTS2cKZlwfjHoXLfoDKrGqLl7ovKCh/CH07r/femd1qjK2B7Kyal
 YMWc4Aviz43e5+UWD3bV9jWMOHT2PuL6Qc9Ve4cgFnZM8CbYOj25y96Z2WoGIslOBsA1igdGcTA
 fsiftIxoglnTxjvHNLXzKOPM9vhGKnt7sUoApmVHb9j1q6Rs4tdL3GkckP7SOiXhnHYGNQy+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100070

When in host mode, it is intended that the controller goes to suspend
state to save power and wait for interrupts from connected peripheral
to wake it up. This is particularly used in cases where a HID or Audio
device is connected. In such scenarios, the usb controller can enter
auto suspend and resume action after getting interrupts from the
connected device.

Allow autosuspend for and xhci device and allow userspace to decide
whether to enable this functionality.

a) Register to usb-core notifications in set_role vendor callback to
identify when root hubs are being created. Configure them to
use_autosuspend.

b) Identify usb core notifications where the HCD is being added and
enable autosuspend for that particular xhci device.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 62 ++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index d40b52e2ba01..17bbd5a06c08 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -95,6 +95,8 @@ struct dwc3_qcom {
 	 * internally by mutex lock.
 	 */
 	enum usb_role		current_role;
+
+	struct notifier_block	xhci_nb;
 };
 
 #define to_dwc3_qcom(d) container_of((d), struct dwc3_qcom, dwc)
@@ -647,6 +649,39 @@ static int dwc3_qcom_setup_irq(struct dwc3_qcom *qcom, struct platform_device *p
 	return 0;
 }
 
+static int dwc3_xhci_event_notifier(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct dwc3_qcom  *qcom	= container_of(nb, struct dwc3_qcom, xhci_nb);
+	struct dwc3	  *dwc	= &qcom->dwc;
+	struct usb_bus	  *ubus	= ptr;
+	struct usb_hcd	  *hcd;
+
+	if (!dwc->xhci)
+		goto done;
+
+	hcd = platform_get_drvdata(dwc->xhci);
+	if (!hcd)
+		goto done;
+
+	if (event != USB_BUS_ADD)
+		goto done;
+
+	if (strcmp(dev_name(ubus->sysdev), dev_name(dwc->sysdev)) != 0)
+		goto done;
+
+	if (event == USB_BUS_ADD) {
+		/*
+		 * Identify instant of creation of primary hcd and
+		 * mark xhci as autosuspend capable at this point.
+		 */
+		pm_runtime_use_autosuspend(&dwc->xhci->dev);
+	}
+
+done:
+	return NOTIFY_DONE;
+}
+
 static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_role)
 {
 	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
@@ -659,12 +694,22 @@ static void dwc3_qcom_set_role_notifier(struct dwc3 *dwc, enum usb_role next_rol
 		return;
 	}
 
-	if (qcom->current_role == USB_ROLE_DEVICE &&
-	    next_role != USB_ROLE_DEVICE)
+	if (qcom->current_role == USB_ROLE_NONE) {
+		if (next_role == USB_ROLE_DEVICE) {
+			dwc3_qcom_vbus_override_enable(qcom, true);
+		} else if (next_role == USB_ROLE_HOST) {
+			qcom->xhci_nb.notifier_call = dwc3_xhci_event_notifier;
+			usb_register_notify(&qcom->xhci_nb);
+		}
+	} else if (qcom->current_role == USB_ROLE_DEVICE &&
+		   next_role != USB_ROLE_DEVICE) {
 		dwc3_qcom_vbus_override_enable(qcom, false);
-	else if ((qcom->current_role != USB_ROLE_DEVICE) &&
-		 (next_role == USB_ROLE_DEVICE))
-		dwc3_qcom_vbus_override_enable(qcom, true);
+	} else if (qcom->current_role == USB_ROLE_HOST) {
+		if (next_role == USB_ROLE_NONE)
+			usb_unregister_notify(&qcom->xhci_nb);
+		else if (next_role == USB_ROLE_DEVICE)
+			dwc3_qcom_vbus_override_enable(qcom, true);
+	}
 
 	pm_runtime_mark_last_busy(qcom->dev);
 	pm_runtime_put_sync(qcom->dev);
@@ -774,6 +819,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (qcom->mode == USB_DR_MODE_HOST) {
 		qcom->current_role = USB_ROLE_HOST;
+		qcom->xhci_nb.notifier_call = dwc3_xhci_event_notifier;
+		usb_register_notify(&qcom->xhci_nb);
 	} else if (qcom->mode == USB_DR_MODE_PERIPHERAL) {
 		qcom->current_role = USB_ROLE_DEVICE;
 		dwc3_qcom_vbus_override_enable(qcom, true);
@@ -794,7 +841,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)  {
 		ret = dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
-		goto clk_disable;
+		goto unregister_notify;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -817,6 +864,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	dwc3_qcom_interconnect_exit(qcom);
 remove_core:
 	dwc3_core_remove(&qcom->dwc);
+unregister_notify:
+	if (qcom->mode == USB_DR_MODE_HOST)
+		usb_unregister_notify(&qcom->xhci_nb);
 clk_disable:
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 
-- 
2.34.1


