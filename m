Return-Path: <linux-kernel+bounces-764078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F74B21DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E776418860DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720282E3709;
	Tue, 12 Aug 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IayR9ZM0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3722E2DE8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978164; cv=none; b=t0TIlmD0aIt9ih9fDyWHwTCRcn6Ju6b+K7K3zPb8eBlbMfxsakfeU/tvCnzEB1PQ4gFJBcjyFIFxHj+OGjnRXM4qVvZ0RhrovBtzKptbEnt+fSIg9AoA0J7qGabY9yNJtBsR0oxxxLnb5Lo02Ew/sqI5JEd4L8p8GIBNhIZlnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978164; c=relaxed/simple;
	bh=7C5wlqfUGlNAOlcMWP3UIoJSoU7F5CfXh7HAySLy7vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMY/ut3whosegf2Gk2utWhWQrvkbE03sVNzY7euCYUqZePUBKJEIAo7RQFD/nRs3fNQiJNiyY3Ul9bPV+evpX1NNF5GrSQdw+l4YD5AataMoI9b+wwDIupeAapGyesawv+xPfC0j6tz2fPyvCo7wHzoQfpaQx23erN9x6I8n6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IayR9ZM0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4sVYf029557
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B19nWzff1hv
	gEWIyyHXO3w1PVc/KbOyGfSQee+KWYZs=; b=IayR9ZM0ZasSV6SoP4/tcbHneSA
	CVzONprqFBAFD6bBAkrxYqFEfh4bGnVflf2uM08l9ltjaPyn00a89SiO5QsHMEv9
	C3ouXICSo8JfKqDPRJIXTf/ZWxKRin1rDGfsKYItEHzbCC7OxF3yQ4QvyHL/06+c
	yxP7rNht9+3msR9KNWbDRYr36NakZrH5fcweXekorA8WeNdtsOBe/wuj4Pd/zIYH
	u1RLUOOhnNNjQbTDw/bUBQ7mcJBFIL6J3nqsfcBUVhv2T+y1xBcYH7P/o35y66N0
	u2Ddo/J5Hp7VL6wgnJCEgzMP9tFjJRVjMm/DrIjPtaa5T0dGQBoWPUbVVoQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sq4wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:56:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3215b3229c7so5422268a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978161; x=1755582961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B19nWzff1hvgEWIyyHXO3w1PVc/KbOyGfSQee+KWYZs=;
        b=n+0ep9qMxYpcGjyFjCf6ejbdRBhp9N4YOND9WF/aBDS733ysTY8MBygLVaqhxZ/bxx
         DjelmLrEfocu6uzzgITHNe2C3pkHoESXkvcemMEV5lrK+yX8sE/GvObHrYsnHTdA21zr
         KHc7J4C10a8XFAqoqcM6CKd3cNuEk4gVEylp5/61X4c9pCXYsSJiQBfO2qfHDjau+ton
         N+wZ4MFrmz+eVUKyOU4Rc6bjqrmlwLMtsvqiDyZuI6/7Hwqr7YxDmHp/qw4pBDe2hw2y
         4B9wrBC+AhRHa5Zxx5zEaF14zQPcEcPIeZg4RvFJQfQ1TfvkBzIkox6OVZirNV1liI5B
         5ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhFeXPnUafTKQ2NysY8OMD4uBjNiXeCfzoVIb10wDDiG+18/SCbLRnriwx9BI6kjYxGAxmGDtiZw4C4Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTSrmnlhT6q4QPzp1rg4TK8kEGv4mslum7qtVF4+Eb1sG5suu
	dAw1sBPbuvZpHF4jKUswthElKfXukhKhl+hfXeOKucZoHG3K9TeT/FLticg8tjGgMneNfDVsHOQ
	Ieb0vf76pzfod/MU3D3m7A0VghkqqQk2GC1Fz4SBMiIVCj9iGcyhwcJxwyj6S3jgEQS4=
X-Gm-Gg: ASbGncsycZiJDfud1B4AuwznkBTQ020CO6W1goitR6IEXkQ86GmuQADTuczitmFBG9z
	TQHppQYpPmBstrQrZ0BCTvE4k4tByEBqKP3Y+s85wTGpc6ARAIuQ2G08CBgNK72Nd0s20tqeMQs
	PbxdE9tFA33x2bov8C4jgB9cPLt0uKwd5DeONWJ4sRphkNorQlZsDcmixVfsoxZofr73GgUlpGB
	pVGmpxrSvkhrOYFSxnfd3oneMhfXU4dqnTk38GqlMXCxh7bGLaDjcwCwEjAzwxQuxL9aAJCjNk4
	Nfevazjp0rz1kE9gpU8nFQu4qNxStzru94F7EmSa1a9Hjorbmjpi7D40od8RyTlug0Bp8VP55eo
	pOg==
X-Received: by 2002:a17:903:b0e:b0:242:e0f1:f4b9 with SMTP id d9443c01a7336-242fc28758cmr25282675ad.20.1754978161575;
        Mon, 11 Aug 2025 22:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4e8kQp0IrRtj31bzCgS5V3rsipa7Z4QR1lRYTKeX+/QFVw7wAbbooXEt16J/B1HRK7sYNcw==
X-Received: by 2002:a17:903:b0e:b0:242:e0f1:f4b9 with SMTP id d9443c01a7336-242fc28758cmr25282425ad.20.1754978161106;
        Mon, 11 Aug 2025 22:56:01 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm288585985ad.40.2025.08.11.22.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 22:56:00 -0700 (PDT)
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
Subject: [PATCH v4 3/3] usb: xhci: plat: Facilitate using autosuspend for xhci plat devices
Date: Tue, 12 Aug 2025 11:25:42 +0530
Message-Id: <20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689ad772 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=dywq_Bg9ifu0WOeA0n0A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: tRT3pfp0QSPth8MGClumZEpIrNgbPRqz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX8+C/UwHksB+f
 jqLNCKTMLAIQexz9OTLEmAmURay+p11UfYy2RZkuWj+KhAt3/RqocdFxHUHC+KFH29GtgUUxFSa
 4audkBcmjA85yYM8EjNHMLsD0He+wCDey48o2A3TAN4sUsqiyoYNZCymUbw4EOxsPJtb71xouxb
 zDs9QcYSkio+kiYne9qujNtHUw4luFvqxvkFSq2uqiwbZy2xWap/kBlxpYXyOHwaKX2O+FZzjJ+
 G8GLT9+oU6AGgobuGAzR1vXTsGLOk0oOGvtfVi/q7cm/JB6sc1FuDEoPENebvaW03jMKZ6mh+LP
 2YSCcMxi9VDkDsbHquZjtglPom70Q7IVvvtF8iAYlkTNi3nHE876C2e2CHFp1fLNOAWpd74LF7T
 jdYTGuix
X-Proofpoint-GUID: tRT3pfp0QSPth8MGClumZEpIrNgbPRqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

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


