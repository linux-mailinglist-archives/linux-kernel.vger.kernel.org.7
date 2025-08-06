Return-Path: <linux-kernel+bounces-757588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE37B1C3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0628A188C468
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22128B7DD;
	Wed,  6 Aug 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0FWgY0j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0928B4F4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474333; cv=none; b=Xrk10pPeaNhFLQ2isc3p3Cyz4RNoq5H3wW7sDmI83jCkYnSIo0Q15uCOm8OfSoFyp3YNKgWd0iV7ieHstm1uQGdLTJPfGdhJhIEm7z2s8dn66b5/AFYSZ5cH0ssX+W5ascEKyLt3rKz0yAziDEeG3HnpQxRrv6ayq0NaD1yN6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474333; c=relaxed/simple;
	bh=7C5wlqfUGlNAOlcMWP3UIoJSoU7F5CfXh7HAySLy7vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWvNe+2YboKrQXkvh+QO+nVfzh2CukjUnnfPxAGq3XOBI7EreAnnHvdNGiZcfu4ltlO8JWPVYDc/S/YXmMLWUwg1coh2Z+shwW/sD4HY/bqG1Jy7EEJH1UbBw3QdCoe08Z7k5+K0egeelPPA3lL601iI1IszK3x6udQn8k787Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0FWgY0j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766F2Oi013679
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B19nWzff1hv
	gEWIyyHXO3w1PVc/KbOyGfSQee+KWYZs=; b=O0FWgY0jMXuZvT8INsirFECgW5K
	yAvTdwuWQpyn+n+3PbrSYZfbh9xUk5G+1zIamaYqLy3mmuB/9a1XkqsA4p+K0ZfD
	tk632x+Q96nyU08O5uBtOota5YhqzwYOFbYlpYQdhdeNZIuzM+8TfZMkJ2k3jXaH
	zAFOFEdouJCxRI0KuhlNCIgaFq0tNR9YEXcuv+6uK4WbbWpIlOmB+Rjx5+zsXKCt
	MVyeesfOaQdOUN03gx3/Myawm614X5Tw2yJiiMLZpKMAZYGgojEXH67bf+8WF0Jn
	KxXUsEuKyXV6wKOHb+q9WqOEO9b5AkXstsASyu3+HenRO2sQtBgjTJKiHgA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyct7de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:58:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38ec062983so4402254a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474330; x=1755079130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B19nWzff1hvgEWIyyHXO3w1PVc/KbOyGfSQee+KWYZs=;
        b=T9MLgyPLSkK+c6cck32RT/lsZdvWq87Eru0KASbFmfTEN9JOHi0cg822L0m6W/fQiM
         +Uff+7ijVsv9+AHlPxoK3GT2hlC3JvC5bNvh3KXbzwU8DEU3WdC2QRuZ+W9Fm8pIfilv
         7Q0WLMuAnHiwR386zjKCyTPSKNTqeR/w+G1lnYIL1f0k7ol/pneknRYhXDONQ2f45PWi
         oc1LpZ8RzPVBSBNdM1XeBWoQcv7xsLXhYvJvXbXaKroDujHI+rlk1gTeDjm3U6hf/ZHY
         15BQ+N9km4EwibAYN8VyoVc/YV+BR07B8iDfqw17ePhv6ohWzvRQh4vHziLW8uKDSUxx
         iGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaeUXL9taeBkh0+bZfkZDT8FboAsE6Nz1/A6JXafYwb+q5Y1OGIpG9saw1snUh/dCwBG9hcY+leWQf8HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndPAtmURRS2RI+fK/zA5UNNZGwSw51r7pyebQFAx8iuvr3/4i
	K/UvuDYu6/liS7cJTH0NYXA8FLrF1QT/JgdbbRITuide1jJtiwCZmogiFGBHJ4lptoGior07IBr
	R4v5VzwQB5D4r/1bOu1BGhW9OILyT+zToxHdBS1Nmd9xE5N+M8ey4ZtSzBhWzQLqw3jw=
X-Gm-Gg: ASbGncvYO67HrHbFIDQE6u5gAu0v6yvbBLxxuWb9IDAdE5StgOFiZfG5v9W1epnFYPL
	T1hIaWVq2iDugRTpO9rYxIxJu9eeRm0J53F1OskJmI+vwIzd8CHixWnOm7Bh+FkpSPYJRrnHY3s
	BMJe3x8nPu7O8w83TZRorJH+PLVBRN5uBM6G0zE+su2duDtcXpMoklNUjRex66+G0EwcyT1AZKI
	24OxQYc0b45sLShQnWBRjjpQ9t9IFx/yemcOadbMub9fgA+2SqR9CyVRNgtrXeGEGwjYRuDqmn1
	4xHf/SZ/HihYX3bzy91PW9UD/lfHtAdjQ5/20+WNmOpfoZl6TH+oSFP9BvgIKVZXM+5/X2gCyyw
	Juw==
X-Received: by 2002:a05:6a20:2444:b0:240:168b:31b with SMTP id adf61e73a8af0-240313ba206mr3530574637.16.1754474330148;
        Wed, 06 Aug 2025 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/N/vlYYg4Dqy9ayFzEBj2EPPs7KLWGVpyO2t2adkmVNL/8seoql8c6zh6YHE7zaDAdVt5Bg==
X-Received: by 2002:a05:6a20:2444:b0:240:168b:31b with SMTP id adf61e73a8af0-240313ba206mr3530546637.16.1754474329760;
        Wed, 06 Aug 2025 02:58:49 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm12908799a12.20.2025.08.06.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:58:49 -0700 (PDT)
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
Subject: [PATCH v3 3/3] usb: xhci: plat: Facilitate using autosuspend for xhci plat devices
Date: Wed,  6 Aug 2025 15:28:28 +0530
Message-Id: <20250806095828.1582917-4-krishna.kurapati@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: wDQmoCTUe-10Mi4qL3iN8VTxqw4nBGGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfXybyz/dCPdO5A
 SUurhlpXwtfhfd0taous9bx4ElKYDqGWPIhKq4dlWEMJ0Wmhajae3cY6g+7ISBdkzlJutOoGFZn
 K9u8+p5WfzPbTivZypYbVlZU7J0oQBBYilpPQ8F4IZdtn4hOehUCvSIZm145jfkjVitwbUddVk7
 brzFF19F3YaSy3hMBrbRQFH6rMBLft5htBFUMK4nA0xJxO6B9OCHijaJaM1aYr6rWEN4FP6tQW9
 wv4sfkBdoWnA3asLbpYjrGSC3Aub7glDrpTVtrIWRprd/A9zbvwK8/FsbWGsJiSTZdz5T/4g2DW
 4YRJ6SqTscmdSoad0/cTSmylM5qBvGYUO3Nz93PA6P6Sbd2f/Dx0AjiHCv/XOp5NGT7Ggxy3qUb
 6ruwhXSm
X-Authority-Analysis: v=2.4 cv=JIo7s9Kb c=1 sm=1 tr=0 ts=6893275b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dywq_Bg9ifu0WOeA0n0A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: wDQmoCTUe-10Mi4qL3iN8VTxqw4nBGGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

Allow autosuspend to be used by xhci plat device. For Qualcomm SoCs,
when in host mode, it is intended that the controller goes to suspend
state to save power and wait for interrupts from connected peripheral
to wake it up. This is particularly used in cases where a HID or Audio
device is connected. In such scenarios, the usb controller can enter
auto suspend and resume action after getting interrupts from the
connected device.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
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


