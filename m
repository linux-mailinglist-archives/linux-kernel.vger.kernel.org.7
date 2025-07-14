Return-Path: <linux-kernel+bounces-729344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34489B0354E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C211734C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C711F4E34;
	Mon, 14 Jul 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X/Kjhy3A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E4BE65
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468436; cv=none; b=KMkU1tGptWK45rS0rLWJx/QINN0CAbsXnxqQx6Tba3rwxQUuctXmoyG6bkQ8nnLJtgc26fBPLJzdk+31tI0rozP7t1B3MN3Sz05EDGBEKIB2HFCaeAbAUmUNUadyQVLoPfQktUuRkob59HTQk29wO3F3B9ZAWpyQNlW1JOfBPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468436; c=relaxed/simple;
	bh=MIpQ5Q0VIvo+JU7aGA6BR/cFkK3jmGi9K39tdTwVBLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WpgSPrf4xTeG27kVPmhK3gpoNjr9BYqV3Cxa3S8DBNBbi8QTds+PIQmAeQufAb7uQrjFgwElG3QtKfbQ/yD4qdeCkRJ6skHc78t21WLQ8tWAdt7uH74BBUYe+QVnxPJGOjVn8y2fPoawgGU+P0qI8jVXXsjo178DKn74jfV5qGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X/Kjhy3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DN8b8r004164
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SMotp43FosdZ2W0txBdCz1GbIq+fsqM3Dsb
	xm8sifnc=; b=X/Kjhy3AVPBxVQ+MENVKG3xIYwt4yuQe38mZOgwRYcni+DeDjOq
	7XgGu0REyv9IDc4IqtaUQSjoGtSElunY+QLhm3liVyOJrS9cu4Jp35nF2h67MAi1
	cgeMe9Yv/t2a2VV832pCT81ybjvAa7G+X+o8ETmYU+j8O5gZZ8owZ1q90OneMbEP
	ayUD2B6gzZfNmRmoJF9no5Hxik9mrNggyp9swJg6fjzFdDuBWlZSwwQsLFPyAWr+
	2j6g4OTz9atxg0En9Zs2GeTz3xDQoDFqSYTy324HVkalfpJlyJJB0N1yVV1YAsYD
	zpIdhce3RHGlBwNiOLm8WubeAVO2I1uvM+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu836nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:47:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235c897d378so38145865ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468432; x=1753073232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMotp43FosdZ2W0txBdCz1GbIq+fsqM3Dsbxm8sifnc=;
        b=QnNtTjL2VBssRUdA4aRwMIiquY7TORxnpjj7ypTePwHXibjGuJb3nhLTUboxSxZOeq
         1dYYR53RBmBnEN34vZAdpzEJ8DRkfBlboRU2phou2g8VagZPxwq5+6lSbhqslN5WXFAM
         LWQtkBQ0oDqt9PTUOtq4JBsaQtV8s7B77uIwrzI6lQlARJe/DKWDXwlXKOi6W0AdhUYZ
         K8ysBsQkAAqLS6V/uVvYNuJyjiiyT0HopevmlX5Xa5vkBreYDwpiSsSjVmqnLHLiq+nN
         T5KpOFJSK9G/Lqk93tNtBXRCMBOjPu5qb8goG7SJ7mPSWIs+XykAGIvpA0dhyfaPg4Pb
         zzVg==
X-Forwarded-Encrypted: i=1; AJvYcCUAL4Pysu9tZwjgEDc/rWodW76tUoxPmktiAMj/VYIqsk3ktNJnfRTbyYMuSQwKspEqUKLbDQbqGTJurgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFD8S9VSSohSxDpWuqH6wu+HnMLK47CjZtHhfNj209Dfatqiq
	r9XgeBpGfmWzNJ4DGaMpfys2b0mGo7/UvUhnyVm26zUcGqGsKgs7rhVdC+fUo3wSlupntdFeQ0h
	37K6DT94OOv6/kPt51f1ehaX8cWuCxY+xNxOqtPQUhz8c1viQkkZ6VIuBtejhadZiaZA=
X-Gm-Gg: ASbGncsEto3P1ackaW8UrVhz0E2OdippMwEthXrwFhWdtouSZ8cW20dyZ5FEPsd9Ap2
	PazASQRH+VPQg7TNQRv/ICyPNE6eZ4bl/buMWsFWfFx+zbHWLOBte6uQGZzhG71j5a8zRh7lb+b
	11F0yHjx/TRHUwWpLaiGXq//B/PMT4TcxJINaNNSrPkYRzkKxSTZK9Z8Gp3hSAjdqtao1nfNWyA
	O4iysW9aOG0F1Z+VZaMv3wHKTWDbbolC2zyzS7eOPiqRfuhWSdzLvAv+0BnarGcWtqvbSxJm1sz
	y69gpIHD3n1OKWH3y5bPPMB9YoLE5T0HwKSsJsHkYlP9LmIGJ2nDGWaT/Z+ML2QwLt92ljoI0YB
	Yyw==
X-Received: by 2002:a17:902:c407:b0:235:f298:cbbe with SMTP id d9443c01a7336-23dede387d6mr180694525ad.12.1752468432262;
        Sun, 13 Jul 2025 21:47:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/chjcZA9pDzqtEq6QhkNj4Ah8vf7hGn9SFCFAv1D5BS5L27T8vry5begaHNsu51w5tceLag==
X-Received: by 2002:a17:902:c407:b0:235:f298:cbbe with SMTP id d9443c01a7336-23dede387d6mr180694075ad.12.1752468431808;
        Sun, 13 Jul 2025 21:47:11 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323df7sm84017235ad.134.2025.07.13.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:47:11 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3] usb: dwc3: qcom: Remove extcon functionality from glue
Date: Mon, 14 Jul 2025 10:17:02 +0530
Message-Id: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAyNSBTYWx0ZWRfX/7LL5JOVwae+
 FdUKad3Y7DKZoPyoHMvjuuz7/RcnRhFKWkFwCa1U7uY2m0H3fxMKPZQh8e164j3lYveLmJ1hkww
 7G/hE5aOs9C8TV6/0elq+MuMXkna3p/pDTEiJmq3/jA3j+L6yKE/1Aworh6kCCF1DV5Pw+G4dAP
 73pL9wo1SSyFjk7GV+zY3ywVA2b7Foz9hHGj8wLlYdLSK4kA7vcBvVEPgaIDabhvYYtDzFy+TXu
 5Jh9zH8yhqF97YUvFM//uRHJL8AZR67ciFFjtsU4BG3Pp7fyvmWalIcpOn2YW0i5qOx7OFDK/Il
 u4n86lFczSnXHob7WYANu7pkLHY1tsW0znKAEw9oG+Snvp1X1gUBUiq8QYITNy1P9WdDtt2ALZC
 8WDdjgKtQdl0F5Usn/4vRxHxfCuqZ9ba1Cplee+mkEsS6+HVpa8N4IhSjNUkXqSudWsgPIa5
X-Proofpoint-ORIG-GUID: wBYgxegCE-62nsy4SHPgZFnGeCeLnZKo
X-Proofpoint-GUID: wBYgxegCE-62nsy4SHPgZFnGeCeLnZKo
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68748bd1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HsaRtseu1FE5unmruSMA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140025

Deprecate usage of extcon functionality from the glue driver. Now
that the glue driver is a flattened implementation, all existing
DTs would eventually move to new bindings. While doing so let them
make use of role-switch/ typec frameworks to provide role data
rather than using extcon.

On upstream, summary of targets/platforms using extcon is as follows:

1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
effect on them.

2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
driver which relies on id/vbus gpios to inform role changes. This can be
transitioned to role switch based driver (usb-conn-gpio) while flattening
those platforms to move away from extcon and rely on role
switching.

3. The one target that uses dwc3 controller and extcon and is not based
on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
This platform uses TI chip to provide extcon. If usb on this platform is
being flattneed, then effort should be put in to define a usb-c-connector
device in DT and make use of role switch functionality in TUSB320L driver.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v3:
This change was 4rth patch in [1]. It was suggested to make this as the
first patch of the series. Since this is independent of role switch
patches, sending this out separately. Removed RB Tag of Dmitry since the
patch has been changed.

[1]: https://lore.kernel.org/all/20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com/

 drivers/usb/dwc3/dwc3-qcom.c | 90 +-----------------------------------
 1 file changed, 1 insertion(+), 89 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index ca7e1c02773a..a7eaefaeec4d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -11,7 +11,6 @@
 #include <linux/of_clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/extcon.h>
 #include <linux/interconnect.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
@@ -79,11 +78,6 @@ struct dwc3_qcom {
 	struct dwc3_qcom_port	ports[DWC3_QCOM_MAX_PORTS];
 	u8			num_ports;
 
-	struct extcon_dev	*edev;
-	struct extcon_dev	*host_edev;
-	struct notifier_block	vbus_nb;
-	struct notifier_block	host_nb;
-
 	enum usb_dr_mode	mode;
 	bool			is_suspended;
 	bool			pm_suspended;
@@ -119,8 +113,7 @@ static inline void dwc3_qcom_clrbits(void __iomem *base, u32 offset, u32 val)
 
 /*
  * TODO: Make the in-core role switching code invoke dwc3_qcom_vbus_override_enable(),
- * validate that the in-core extcon support is functional, and drop extcon
- * handling from the glue
+ * validate that the in-core extcon support is functional
  */
 static void dwc3_qcom_vbus_override_enable(struct dwc3_qcom *qcom, bool enable)
 {
@@ -137,80 +130,6 @@ static void dwc3_qcom_vbus_override_enable(struct dwc3_qcom *qcom, bool enable)
 	}
 }
 
-static int dwc3_qcom_vbus_notifier(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
-{
-	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, vbus_nb);
-
-	/* enable vbus override for device mode */
-	dwc3_qcom_vbus_override_enable(qcom, event);
-	qcom->mode = event ? USB_DR_MODE_PERIPHERAL : USB_DR_MODE_HOST;
-
-	return NOTIFY_DONE;
-}
-
-static int dwc3_qcom_host_notifier(struct notifier_block *nb,
-				   unsigned long event, void *ptr)
-{
-	struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, host_nb);
-
-	/* disable vbus override in host mode */
-	dwc3_qcom_vbus_override_enable(qcom, !event);
-	qcom->mode = event ? USB_DR_MODE_HOST : USB_DR_MODE_PERIPHERAL;
-
-	return NOTIFY_DONE;
-}
-
-static int dwc3_qcom_register_extcon(struct dwc3_qcom *qcom)
-{
-	struct device		*dev = qcom->dev;
-	struct extcon_dev	*host_edev;
-	int			ret;
-
-	if (!of_property_present(dev->of_node, "extcon"))
-		return 0;
-
-	qcom->edev = extcon_get_edev_by_phandle(dev, 0);
-	if (IS_ERR(qcom->edev))
-		return dev_err_probe(dev, PTR_ERR(qcom->edev),
-				     "Failed to get extcon\n");
-
-	qcom->vbus_nb.notifier_call = dwc3_qcom_vbus_notifier;
-
-	qcom->host_edev = extcon_get_edev_by_phandle(dev, 1);
-	if (IS_ERR(qcom->host_edev))
-		qcom->host_edev = NULL;
-
-	ret = devm_extcon_register_notifier(dev, qcom->edev, EXTCON_USB,
-					    &qcom->vbus_nb);
-	if (ret < 0) {
-		dev_err(dev, "VBUS notifier register failed\n");
-		return ret;
-	}
-
-	if (qcom->host_edev)
-		host_edev = qcom->host_edev;
-	else
-		host_edev = qcom->edev;
-
-	qcom->host_nb.notifier_call = dwc3_qcom_host_notifier;
-	ret = devm_extcon_register_notifier(dev, host_edev, EXTCON_USB_HOST,
-					    &qcom->host_nb);
-	if (ret < 0) {
-		dev_err(dev, "Host notifier register failed\n");
-		return ret;
-	}
-
-	/* Update initial VBUS override based on extcon state */
-	if (extcon_get_state(qcom->edev, EXTCON_USB) ||
-	    !extcon_get_state(host_edev, EXTCON_USB_HOST))
-		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, true, qcom->edev);
-	else
-		dwc3_qcom_vbus_notifier(&qcom->vbus_nb, false, qcom->edev);
-
-	return 0;
-}
-
 static int dwc3_qcom_interconnect_enable(struct dwc3_qcom *qcom)
 {
 	int ret;
@@ -737,11 +656,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (qcom->mode != USB_DR_MODE_HOST)
 		dwc3_qcom_vbus_override_enable(qcom, true);
 
-	/* register extcon to override sw_vbus on Vbus change later */
-	ret = dwc3_qcom_register_extcon(qcom);
-	if (ret)
-		goto interconnect_exit;
-
 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
 	device_init_wakeup(&pdev->dev, wakeup_source);
 
@@ -749,8 +663,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	return 0;
 
-interconnect_exit:
-	dwc3_qcom_interconnect_exit(qcom);
 remove_core:
 	dwc3_core_remove(&qcom->dwc);
 clk_disable:
-- 
2.34.1


