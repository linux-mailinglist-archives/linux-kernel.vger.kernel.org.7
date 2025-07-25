Return-Path: <linux-kernel+bounces-745324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0AB1186F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE81C85D29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5302882D8;
	Fri, 25 Jul 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnloMO6a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B22882A0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424603; cv=none; b=pCi07NHk+LJdRuvPdrG1snZ+2SQLwexnzIEjVh8M3a7FAlx18lnC/md4CpII0fVsNvbsPEXuBBCq6LCDU+ChK021EJ1YIKjqKFoJX7hX0O05e2+0fAkZvbD4shTmRu1/NVmOMQ6CvFGYIT1dRkR9mz5U5rGkesUYRZ8Lv7vQDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424603; c=relaxed/simple;
	bh=E0u5NHKCdPJIEfTxEWeqR+t0Kp29cevS+91DXYNko5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+Iv2TpxlGc0XsqDJ6jQAX06mDlx1svgd1CFcySnoNcFhFMj3FBwhAZpYz75ZL8k/nCPLtUDKQ2/cdlD9nafEav/RZiHiS0J9dbHeP6xGQhF38jWNOFtPvTTVQpeltfEbAu1UsAaKT6o+wFsAYjUJOeCuuEFJGujXvbt/d+i6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnloMO6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLmrgE010214
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=h+8rpQA2MVGC7T1ZSRP1J6JwVsqpQ0K/yM3
	DfkG+seM=; b=KnloMO6aqnQbTXGciSUwIXkDYdRJ84Qgehk0P/9pl7pxBKGCQd8
	Rvqa80zW4i9o5sg2LaizOz8Y1uGKpnSyanMXdyONWUlKKv8fB4x9XjNyOEUUiOud
	wjtP41ZiOTIIxk+VfZmdBg5JkUSZ/D4z7ayW1cvpxh7Imdbmw0kvQLIZHbl/iODb
	WCUpmT/koA4VReoXWjV0hNVMJHRDRunKLaZupx+fnatSFP1CR9r1+A3RMXcn8aM2
	aR0LcwTpeGg9EL+jK3GXa6n8/U/ghogUdT+60iHs9qsETBEIE7zSiJzk6B9lMrkv
	IF9bQiUWdIVUMRTjC/Mg4a7jxguz1mk+oTg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t11ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:23:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74ad608d60aso1719016b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753424599; x=1754029399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+8rpQA2MVGC7T1ZSRP1J6JwVsqpQ0K/yM3DfkG+seM=;
        b=HfFdkGewDhOROJLn/Kv2yfV70pDiCHplqZ0xFyb3k1GiTbymprFMFV/Fh1hQ9RTa+S
         PJ0ca5P+/zL0CrWtomia5PtoPPIhYYaZh6IhYhrcUXnd4WHSp2/Ee2dLBRgMq7cUcU+F
         05m62M5Ocw8u86gCSnyrwysxOIBv3NzW7gGXjgFH9tMEzcT/GgXnTUq+Htzs2BYqdX9F
         /qDwW2JQZxbcHMgjr3lM7tt8JgaQcMki6ElrdPQ/YvxB3dI3XWQrSOsI1FtwXN9V5dvC
         Ajs9jvuP7BQKbT7vLMqj1vvQRjBIDv+273e9tgAzUhBjJWYubK4zbyF8t7f2rePv1VzE
         N0ww==
X-Forwarded-Encrypted: i=1; AJvYcCW5lVlCU4Oz9xkK5kS8vYz5FA+UaHnzxg/IDnj/E5kTevsSHaq9KTA+HNdktxV/33bJx9LgGQWYjW0LtRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKApd6f8I44rgFA3ioJDO1uSj1xEh7E9p0vixdhUcW1EI/12B8
	EWyiqiZ9STx4J0DNnJQtRo72Vc0K5yo3SkxYFZfEhTOep0YOiq9mucLlmGtyYkFC+RMezEwR1qQ
	0qhkqjInpWJci64ai4NaUccuWPiHPwGIfsQR2dHGXxYJ3dI9N8jNgMkiNS9UiHSttSkA=
X-Gm-Gg: ASbGncu9GPGqivdif8L5arKVeNgwjpLRxG/ezv4hvOHh89k0rSW1Gjf2nEKhF2s87wK
	OMltv6BDUY2YsiMoIlR8dBWrH7ruybYTkwRflZB44tUuDbeHI8wYvOnJU4sXSxyV8V8zuztj/PJ
	KLjcZcQF+Q3biWWbdqV77KZrsHG6isttiFzqBTlixEpb/KkT/zIGnyq8TrUJ/KgC27o1jcxQO3n
	6zi/2R3IMT1EfgLJVYmhWO29Kq3sY6I7i49hd1vOH7v41BUyVvbTjXg93ZAlu6ZXFofvdSYl/pU
	AZ5PnayljNBf2jtNH7b1OY7PF/PRg5efWuhrv88u0yWE2gShA4XLnR/VqLPrZ/NESGmx
X-Received: by 2002:a05:6a00:4650:b0:730:9946:5973 with SMTP id d2e1a72fcca58-763358483d2mr1316891b3a.5.1753424599218;
        Thu, 24 Jul 2025 23:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj1xluN8FbZiHfwHdnlBmvIEgwOG9qpk8l2JTYBBHhyQ2/ry4/bt7vVkKuqaP3LKXKbrJ43A==
X-Received: by 2002:a05:6a00:4650:b0:730:9946:5973 with SMTP id d2e1a72fcca58-763358483d2mr1316870b3a.5.1753424598818;
        Thu, 24 Jul 2025 23:23:18 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae158ce7sm3100515b3a.51.2025.07.24.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:23:18 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH] usb: dwc3: qcom: Add shutdown handler
Date: Fri, 25 Jul 2025 11:51:58 +0530
Message-Id: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=688322d8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RJ3Zkx4DJpP4D3F6pL0A:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: kF4skpRHg9ghZcNLl8_WGR2lruAACsKs
X-Proofpoint-GUID: kF4skpRHg9ghZcNLl8_WGR2lruAACsKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA1MiBTYWx0ZWRfX8CfCqLPyq/I3
 6eb7h3mMn17truZW/tyDTXQL1pXqii/vYN5zelXVLzNS9HUqIy04G72NPY21pvHMAdVWSxqfM/U
 agdZHimqGl7XG+hiHoxvj/ae/P16rbfkqZdFETea2xGYLfAHCsqK1oJoU1vDuiAgnI3Uku609oq
 J1id7CSxDwUhKaFaQu9sYdA9m/o/Y4Eexjl/CoK5MEv1/kr4PFPbtBbDxzXfuVmTAZurvrsOZkb
 Th+O+ZlM89BguUmeYZZdf/s51VatipLaW9DpprcoXFp0iIIqJBYu9UK7otqC/19iSMZjqiY+NLu
 d+8MVAlHiTKZG+n44JOz8Qik/DRd2U/r2+KJVHDmuTZtKCWOxkzioFZimWnEqzwgcY0FmInkQMY
 TO8esCgGb4TgAkSKwoUtqViOgwLE7ya5uCUEgUVgoJJyYLVTDT95sZbocDo+GxuRgFNNvtzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250052

Currently during system reboot, SMMU disables its translations
while devices like USB may still be actively using DMA buffers.
This can lead to NOC errors and system crashes due to invalid
memory access.

Address this by adding a shutdown callback to dwc3-qcom, which
ensures proper teardown of UDC stack and prevents DWC3 controller
from accessing memory after SMMU translation is disabled. Reuse
the existing remove callback for this purpose.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index ca7e1c02773a..308360a32c93 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -764,11 +764,14 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	struct dwc3 *dwc = platform_get_drvdata(pdev);
 	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
 
-	dwc3_core_remove(&qcom->dwc);
+	if (pm_runtime_resume_and_get(qcom->dev) < 0)
+		return;
 
+	dwc3_core_remove(&qcom->dwc);
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
-
 	dwc3_qcom_interconnect_exit(qcom);
+
+	pm_runtime_put_noidle(qcom->dev);
 }
 
 static int dwc3_qcom_pm_suspend(struct device *dev)
@@ -873,6 +876,7 @@ MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
 static struct platform_driver dwc3_qcom_driver = {
 	.probe		= dwc3_qcom_probe,
 	.remove		= dwc3_qcom_remove,
+	.shutdown	= dwc3_qcom_remove,
 	.driver		= {
 		.name	= "dwc3-qcom",
 		.pm	= pm_ptr(&dwc3_qcom_dev_pm_ops),
-- 
2.25.1


