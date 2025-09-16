Return-Path: <linux-kernel+bounces-818724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3423B595B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D834E5451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17BD30CD92;
	Tue, 16 Sep 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLolk+bk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A127EFE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024287; cv=none; b=fdhyRFwkCexGqgOkV20iZwYamOEQuwl9//3R9nkvnkClPHUak/77szUCTxXqWOT1/tYF2GgctonmkZMBIHU8By5HdGDKWKp3PfFop/4x0vIpe6kywKURggANb4S09fEFpstdv7Epn1WFgVGsji0RLTj1mOMIHS6AnNkA58xpeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024287; c=relaxed/simple;
	bh=xUh5XUbBjpOpz0SoXD7lETMxuGColdpkGmfgztO7nrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BnTicjxrAm3PQQ2rGTWBMG3diK1VO+leZQatZVM+pzylAdXkfOCqA9MB51Qn417DfhHs0dE+zLbdHrix7cGVP0kFUScXeZix01FTH/NYGjq7pIEpkcMpFeNAasdsP8PFesOmhm9mvMT9Pwxa/qv3x668Z2ksTqyUEuft7N56Q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLolk+bk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9mlNK013874
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=w+W9oth6fhri0HzfV/QBf6Xhmg/maZtyf8O
	bMO2KriM=; b=OLolk+bkWS3tsltlBtTTNwucVc5+5K/F5bGXLZ3kfo8dlgxBfZ/
	EruoXh6WoFUtta1aKrdqXAGg7YG/TAUtdruTJcQPzCm0sTinTz7sGoQ6b8YPypw6
	YV6Rgz76xsM1xar0LsGAqCUa6hVjoqZTmjVMIOcN/xivE6RdKpOM8zRd9kAHzxgQ
	BEE8VmRnLLGejjmSfys9DtN8xo0t/7Kb5UWH4/8fd91qcxyyH+Ag7O7q9fe4D5IY
	i3eUj7NIwOsoa9dBDwAEGbX7ai2Ykb26ZRw8IKQlnb2NXCSJcuUqfigZ5jZ6xsVz
	Qx5Nz9hdBckURcyDonSp1GNJT+MslF9KNYg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496x5asvrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:04:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54a2ab0f2aso3084071a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024283; x=1758629083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+W9oth6fhri0HzfV/QBf6Xhmg/maZtyf8ObMO2KriM=;
        b=QZ3N40m8O2Ct48m+DvqN35MhxpPClAunsN1lE0SyUmhn6UIPfFqR7NgUADodjHGdOF
         7w6zC4RLt54t0ffx4vpzSrJevE68nz7iyQI+4XBOvTdDa234Ex88rSvhnx5eaq7QgwhB
         Y9knoogfQ3pUTkMhew8N6TPLqdkPTKo/D/g+SIE7b3HImCed0ncUQmxO2exL1zaV3eWS
         oF+kIYsi9+sQHX/x647g5zG5gG1q9+7mAWKMBSBy8F2HrouJIkuBbDbvfppJTr8QHoEM
         GcEeO2+3DMIKGkw+LA4L9MethYN/hZ3lrabE1ev69Bos8bmnoMxixLfEK1yO6e8OSTJH
         IfQg==
X-Forwarded-Encrypted: i=1; AJvYcCXFhWI6uHXfEtTWI6BwovZ2GBrzfj3BaEXmS1gY3CnDEZ5HyGsEt4WrUKchirwO7B9/4tvHl1LQsU92W54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuh6YW4nfSQK5xgNYOGA1pIg/5iRRwznqjmyXAKE7XOx8XJlG
	IyiGaRkb0vzXUtDwHGppx7j+Uox+bvxnvq2qO4fiDY8DQPzTBtL1jRcQfHdFdlxEjJ8gmlJM9vT
	EpOja28rxaWiD1y9OQ9T1zJT0bWw1KnzxS9NzEmnGUL8xLd3w/tw8qwNkIyBcNddWVQI=
X-Gm-Gg: ASbGncudNnW21hMBpkK0gIwQnZIwGR0lSAfQT2Pb5MjmS3OtlGT+nvpjazLHqiDVPI0
	Jhhh8476XRCbm/7hMBzlhxNMQRdWXI6STtIBpNJVYq6KA0roSDMgGeDJwetGBLfEDQNMQ9BbyeI
	YVw9nrbRiCKCdEZBEy/3Jxczp7fEOy9S7Mg3jA3dzjLCFbepdts2+0Rz2CGA+wwXH1lY38bClJ1
	qKGy/s7OTiEu1xDOnb5tGQEvMrlB8yIFcAtv4N3UfDoqZwx7KVytD0lOoL6f4B2fTsRy+lHNzkO
	PcvRafjIkQguN9z1qC4Og6pugYog5AW74vi6cIKsNBFf+HJObKcdkf0Qrhy65UMkDAUz/WC7RCi
	F1g==
X-Received: by 2002:a05:6a20:729c:b0:246:ba:2d9c with SMTP id adf61e73a8af0-266f4bdfa24mr3552855637.16.1758024283189;
        Tue, 16 Sep 2025 05:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIqXSj4l9GAjmL9lt59m63rsw5wiZleFNjvUVePTkoUn5anrZpPBsI/29/AsNEwgoAx3fnPQ==
X-Received: by 2002:a05:6a20:729c:b0:246:ba:2d9c with SMTP id adf61e73a8af0-266f4bdfa24mr3552792637.16.1758024282667;
        Tue, 16 Sep 2025 05:04:42 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3a9e9ddsm14128397a12.51.2025.09.16.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:04:42 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5] usb: xhci: plat: Facilitate using autosuspend for xhci plat devices
Date: Tue, 16 Sep 2025 17:34:36 +0530
Message-Id: <20250916120436.3617598-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -3bHMvtAFeBOyGhiRA9GnB_gzdwmfNIH
X-Proofpoint-ORIG-GUID: -3bHMvtAFeBOyGhiRA9GnB_gzdwmfNIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMCBTYWx0ZWRfX/n8PdjaxqASs
 YsvSnMorgJvue+T17QnY5FghsBNLopxOxcXN3UyYZIMa4MBruOoLkc1w3bqbQHvAbg0OIXwb1G8
 ZryIQalVh4z8unXZUhFFkCBR1rS028+uAclRvVmzVnbJaAjGte6Tbe9H8a/JsHcB2u6Yn/8W+zP
 FUu9pb3MCPESx6JaRlpLzp46ZYAsNPYBlPXDTi10q4uSG6mRHSbPwndno8vy+vW0WdG8dN7edhA
 PGO7TMPSDWW0sXjoHBgv5QvEeuwg9dP/xJ1fD0kO9uV0/f212RQXEw0A7+H1hz3RIrV4F1+pMtq
 +PuQGWI4hMgla4N8yQ+Y1gVsWL72CdqvVYS3nKxW551HUySlSqZS0yvDQlr7LAAIfiIsDnkwbi2
 MFcUeHbE
X-Authority-Analysis: v=2.4 cv=WpQrMcfv c=1 sm=1 tr=0 ts=68c9525c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dywq_Bg9ifu0WOeA0n0A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160010

Allow autosuspend to be used by xhci plat device. For Qualcomm SoCs,
when in host mode, it is intended that the controller goes to suspend
state to save power and wait for interrupts from connected peripheral
to wake it up. This is particularly used in cases where a HID or Audio
device is connected. In such scenarios, the usb controller can enter
auto suspend and resume action after getting interrupts from the
connected device.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v5:
Rebased on top of latest usb-next.
The first two patches in v4 have been sent separately and merged.
Sending the third patch independently now.

Link to v4:
https://lore.kernel.org/all/20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com/

 drivers/usb/host/xhci-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5eb51797de32..dd57ffedcaa2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -171,6 +171,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		return ret;
 
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-- 
2.34.1


