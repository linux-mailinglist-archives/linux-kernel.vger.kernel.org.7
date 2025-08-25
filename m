Return-Path: <linux-kernel+bounces-784612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37FB33E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172E53AEF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB42C15B6;
	Mon, 25 Aug 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDCU99zf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60872DF6EA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122745; cv=none; b=vAOJhX9kUmLePfZ8B2tlsJbRo4GDi/lV0dpnOHOPKssKxYGyA62jWqsbbeQEQI34r6FT1fzn8mh+EPgpn7qOfp3WQIwMqn2/SfYk7KL/AiseJ7Hx6YSo9i+Lhw9SdE4rY+2DbOudndRx5mbyF/0222pUmzasBiNAYddwDNB425o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122745; c=relaxed/simple;
	bh=WrQJ8y2wkRh0Pm9UxftV2Jxk1mcEkUib4bVXH4a+nuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbDSCB7NEL+wwoRObcATQCX17XuTyAHv8wTLj1+sDAUB6hBR99paYjz99EyPIsc2FyXhS5ug81RTtaKyVFC/89Ro/nXeZp5LRfHvRJFG5ufCL0ZsxNkAkB5zeDGDzkKFePyawMlvPGQhrt1cl5+gdoTPsmpGmgNdmWW6IwCEd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDCU99zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8iLbB008776
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1RD0fxwdT+wj1xPAjqTg5MEtJTG2YBJSBCyvEzZQyeE=; b=hDCU99zfPOpo3lqc
	QnzIA0HfHXmMAQ9o6m0PoOm0e+5yfXdqKA68kB3DdltalXW6KJmqdWKAp+YdIXH+
	OwcN6qpBJDO4LGhjBRhol2CJve6gU8Em/7q2rvJZ88WxmyGflnHavNxTPdKaw0dZ
	jtf2p+dBHZ8uIUYctm1cELUA22Ho9dNM9Twy05FhkMzfbXaLCuNy4/oosJX/dAIf
	P+fCseuEvx91k2V3xsBW3FnTLhIy4ar87C4dmfLvyZdEDjwZS56mlKxRdjdRSm8k
	KXmTiw9KR02c25TtJm+cDxbWeVGfpiD9HPsUDHlvSv82tEYE9gVFd/IfjRcSydYZ
	09bc6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5cuuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b474b68cff7so3551883a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122741; x=1756727541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RD0fxwdT+wj1xPAjqTg5MEtJTG2YBJSBCyvEzZQyeE=;
        b=gQlVrsANzQ6MuviDJugjczvDzGUuhDthCero0+2BWiHrzQXQ18w8kNaE38ZEEAfPid
         QNr7a/DRocTV8GjzQhZmrQsZ+YKEMG/4M3dH7sF8MPuX9FaPCcZZjnx9fuhm76LbDoyk
         l8YNTwRtPsvBgf+UGj2dt9Kn4lBt/KwJhrW1B2SSnC/1OuY/vBrK8xJh6oEFNZP3XBXN
         4t0aTa9iA9oJmoM4e1tNurdqrb+RZ18u0XlIxqrK4yWiLDBDE84KPh5aZTPZmk4P4SwX
         AnsqT/bMkINsVRW99EyXYJFRRRd4qfKRbHA+PT7JXAp+n5DE1rlKg0jR1IV7P4OrqdP6
         sQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVHGAUxlXcBxD4ac9WxUQljv2jiX7wdv6vu/+Tm0tB3rW5feFPA78/ZKRTVm+Go4Hrw35vVK3iPTIqRYGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+s26bKVjFoCh4awbXSrOPQNQMKbcXsvjJHpCoDKMoGLeiWXV
	sSgHiaWKqjtySgWbx69Lm/z4KneImGgRo/SMv5UaTJR4to8tFXvA+KmoOMR9bUxFOi+gR1DqAnt
	KaCD8rgI4xn9hFGzwsJnzq8bkeSSkBZk8QKiCoT1HAXapQZtn8wDKC1zyBa19lLw3/Tg=
X-Gm-Gg: ASbGncudh3pMcC5hNS/MhH5wm2Wcp/raCDEakezvLwNHAIUTw3M+PIIu1HCwSkaPMTN
	jop6jG3iGsShR8sdOLS82TzTxZrg4N9o6s9ystO/3ZW0jTBhDnQJuq86Sp9MkWfUL3SHbozUbLB
	Ao5M8QY/ORXH+cZOKHsL9wvXBCOnpGMjzYpA1H/6te1ZhPHCXXKFQR5QX4eGwFLDkdnv1QVDgB2
	MhEDQE9x2v0M+ZTF1s5kKnCm0CL6Ak/tF0+9Ch8a6fBb74t38xPK8chydp2mH3+jS38QMOCc2lx
	Dt2BJ/kroJX/+u0RZSk43NtNlWyIsbhbMtHd3pAOQYu/9QQ++k3id8ZErrZ3SBvBIBJoxwQZDIb
	KOhPYII/DIbR6fK/G3qzGrZlYjE6LsPMz+/bq3KFH9r2uNy9Ns7REQ2aJhZZdbwC0yGPlzXfHVT
	Y=
X-Received: by 2002:a17:902:d48c:b0:246:96bf:c919 with SMTP id d9443c01a7336-24696bfd54amr85187615ad.10.1756122741417;
        Mon, 25 Aug 2025 04:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaLDyLIvMkQiJKdMioGfxMs/33mkrUVT35+uXH7WGxzy1geJK0Zer8Luo6lAcRhKMl1HXryA==
X-Received: by 2002:a17:902:d48c:b0:246:96bf:c919 with SMTP id d9443c01a7336-24696bfd54amr85187225ad.10.1756122740912;
        Mon, 25 Aug 2025 04:52:20 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:20 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 17:22:04 +0530
Subject: [PATCH 3/3] phy: qcom-qmp-usbc: fix NULL pointer dereference in PM
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qmp-null-deref-on-pm-v1-3-bbd3ca330849@oss.qualcomm.com>
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
In-Reply-To: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=1613;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=gZlFwG2FsBtPkQDUxJ9WIqEJzQC4A40Ol48lNH0eyzE=;
 b=D6EbEOJZPQ86Rzpamaut1ppVk09TGRn58vCjBk8qVEa2c4cjy4SEham80Ams0Yh1KNdQlocGr
 ggkfCvnjmIQBBnRZyJ6QA+WIQiSf623Aq6EZmfjH4CwGqa0rTbtvRrp
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXzL5pD7kZGUhx
 Al7YeNvMYj8fOyhsIIxKnloxfJal9TB38TFnBL+OkvealXR8TS67THqG8CzlwFYczqg9hING64R
 jSd+nK9CI/d10W+lIecz2J4Vh4nYiLfwUxG8U7EaWQ0ACrimRdDx2btVkl6n+4WTrJ6QiHWLA//
 6C1L92fVhF3WPU8Bny+QfF8y4FCAvKHBT9jv67oW14ChFqetPM0dkI3pbwEbnmouo/Mor74hA5C
 gYBJaH57QiKuMQTiQCBm2Kt4k+BlWmID2B3FOOk52F9jjxd7TDwNi7g88a9M+7NuFnqsYkmQ0wl
 EkwkyTqWXR2iWD0FnlynCMBlm3tOSzzEUO1BVwdgIGJ8fYSlgnA3AP6dKzmfEQprhAX/2qcunXX
 b9WfPqRn
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ac4e76 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFmJHyBsCXrKv0U1x8cA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DJ_75JAuFWrW625AXoH1Cb-5SvV0BNcy
X-Proofpoint-ORIG-GUID: DJ_75JAuFWrW625AXoH1Cb-5SvV0BNcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

The pm ops are enabled before qmp phy create which causes
a NULL pointer dereference when accessing qmp->phy->init_count
in the qmp_usb_runtime_suspend.

So if qmp->phy is NULL, bail out early in suspend / resume callbacks
to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
qmp_usb_runtime_resume.

Cc: stable@vger.kernel.org # v6.9
Fixes: 19281571a4d5 ("phy: qcom: qmp-usb: split USB-C PHY driver")
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 5e7fcb26744a4401c3076960df9c0dcbec7fdef7..640f6520f7c1cd78f9e79843a0778c1bee790f64 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -690,7 +690,7 @@ static int __maybe_unused qmp_usbc_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -710,7 +710,7 @@ static int __maybe_unused qmp_usbc_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}

-- 
2.34.1


