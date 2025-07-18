Return-Path: <linux-kernel+bounces-737402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF06B0AC0B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EE16F105
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D704221F01;
	Fri, 18 Jul 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeXl4k9G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DF10957
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876961; cv=none; b=rj9OG1oU+nIulUQ04ZVdv0xlpBexIRf4g0ziGVcQ+yM2itqAv62LyFtL1+PGOPXYcthmLupDqQd4o3lY+frjLWOzsSF2JwZxT/qpilm0Q49JX4rY7YUDEMQPONo6ReytBLRCdqdKmSFoomIY3eR5KChoB4QNPUCH1+5ockM72EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876961; c=relaxed/simple;
	bh=+ObMCEP0xXFpmbdqHtBPYDKFpPRzfo7882m39lX89Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NoHMUYpq+piafwEDMhzSlvHmooo2T+RzX9l1+qNewybAZAj8shRu9FjVQGD7up/+5bFDKCxv+GJXgNP4AaIMi6U+d9fb1DVD902+Ug+aMLbBjzqnKlFE+koKRu609F1u+QxNrSwK9mPjIN6UUMPdEEFgByJdG3tPHiuw3q7WPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeXl4k9G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHtQpf015642
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=C0PvvuuzwRxUCUNTXNvI2E
	7eGEwqScHU67dxy7VxDIk=; b=PeXl4k9GhBPXSMyVIKR6Uojtv9cKAkDCsPzQe1
	ZAPxUeWKXFwBqe540fNFoTMcFEIfd2QXFSC34slPxhlAAlJQ7N8qqwPSoYlbPuGJ
	C59oKwWCY92Eb9z0L9RzHq6e1p4HfAUa9PY7jwqq7jkP/JbFtlFUfoZt6R8TzzhN
	w2F8ynS1pj5Qo4e29ZGjii4jBou5FXofRPuEcGSx/txY7Ic1HHjo7/DZOoS6W0mw
	eZZMXFLGjg9se9OVkg19S2JY6aXfq/0sNQV68pAfgqfCnxjYEEnUZz5L2XBrj7DL
	GHfgPNYvF4eDgCA+Al4zLZ9augU/Yup9OqLBh+A6G1u/Xpdw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyyytk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:15:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c36951518so2783210a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752876958; x=1753481758;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0PvvuuzwRxUCUNTXNvI2E7eGEwqScHU67dxy7VxDIk=;
        b=KaeO5d/PXv18TNxO2awva1J4HsbAnEcOLP63+A+oYnQVDFs2rnAxsmQDDH6MB2+ip5
         yrd4g4cIOud61p2o1V4v/VnJSjQuJ6OPjdlgnR7OcdrfLG3iu2RkhbLJgYfD3/ifSd2R
         mP4vAJ8eVlMc4sEAwLjzyYcwokQ2x0rn8Y+au4qhzAbL7bvBrHkn/HbIuKFymcNs/Vd2
         ZH46pDQf7yngzpJ4gRHjQGd6yjdkuZbYme3x0HPARcc/pzJM63riWW3XIzxgnuYHI2BA
         0AQ/bypRDufj83r6G+ZcgFTFJE6GaIG2LqTB58xz+61FXOpPWutBUvA4FPdFa5WBs4ea
         kxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHy8UshgEpNqlofACOrt7nw3JVzmC7f1f5cKy727EtkH1sX/rqX5XuG2iorvp8c/9hQqA3+/37ExHh0sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmKh71RyKMiB13RZ0Ca3dfmZTNEm/2COWob4/cUprjwNjL7Ybn
	zCTAl9gTe18zOhHCUebXidjoYL5aP9v+Hzvmc6yyLv6LSEFKZ4nZ5yWZImpjH5J0N5IBOGriH9b
	uIrY3421j1aLBYsFLI9RzTfIUuB6uJ9El8P3xgD21CL72zKeCQOJGN293WoBSX+az5ubOjBTNAB
	E=
X-Gm-Gg: ASbGnculUblN3UC6xOZGMg9Cz/dG/HelprIBFpHkW5yi7PQwBX952Ug1Zv9Tp/3Ewd2
	2YYOlOTP2LeErsv3dbJs/Wm0j+85JUcmmXUAmnA2ajjEZVnq7WGoeE1UkVBZs7EBS5VPv12IshQ
	M1EHQzamOlNDdzMap5UIyx81oT2uIGzX4+x2qYCWlNMW3hOn/tYNCg/f+8m6zSywwlfF/AsAvee
	nxvLDtaz8OaQHHZcU3TRXe3a7zHzanbKWlkdNHfxfQMjuadCkEYKX9XZ6tRbRss7oSWvHDR1QFu
	yYxtw0KttXM7DQwNmd15xn/qS3NvVGTdaFCGAEM31xVttcZl4PadIF/Yh/fAWL8soo0pzI4PY+I
	sP69GLmuTDljlTLlhtC9zzW1l
X-Received: by 2002:a05:6a20:3d89:b0:22b:f4e5:d0ee with SMTP id adf61e73a8af0-2390db6ab83mr14277058637.14.1752876957747;
        Fri, 18 Jul 2025 15:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBO0ykGTBfx1qrutnG+D2aTIW4RWxzLxSjTOcm4yBjA+VpO8y6BfIeSt9nGM4mM6vLEZlXAA==
X-Received: by 2002:a05:6a20:3d89:b0:22b:f4e5:d0ee with SMTP id adf61e73a8af0-2390db6ab83mr14277020637.14.1752876957315;
        Fri, 18 Jul 2025 15:15:57 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc680absm1795568b3a.144.2025.07.18.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:15:57 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 15:15:51 -0700
Subject: [PATCH] drm/msm/dp: Propagate core clock enable error in runtime
 resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-dp-clk-error-v1-1-9bb5f28d4927@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJbHemgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3ZQC3eScbN3UoqL8Il3zZENLM1MDMzNTE0MloJaCotS0zAqwcdG
 xtbUAe16cUl4AAAA=
X-Change-ID: 20250703-dp-clk-error-7c1965066541
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752876956; l=2330;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=+ObMCEP0xXFpmbdqHtBPYDKFpPRzfo7882m39lX89Tg=;
 b=dgS9lNvWdwfby7lBzTlT1cofoz3lNYpyZ62ENSpTmdID0SgnlzSsj9e0Vdl8ysD9gnJPYJXlP
 3o8Eta1eK/GDXhhc3Dbp8FQ1HzTSVUSTi+inNYbjgPWxPp82OplE178
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: AitJMDuUqK5crk-CZ1mnuIKBsoIlmKM3
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687ac79e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_9WUdxqi14MbyrDA3vYA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE4MiBTYWx0ZWRfX/bOZmzvw+RkQ
 MBlcRBarJBU9rkDvc1dB07S7Nt/tmDdv7Nu3ACHXfmw61RY6JlFuqLf9U8rlyoE8OwaS8PQilmw
 EJwQ6+k2rVHgjqBKIuchCgnf171B9m0Xf0grTePb6LlIFk68wH/t06Mq2qM3EevU8bjVeZwM1mA
 P1QxB+JWseXTQ+5Rw/sEhQLc6Oijn3AlAVAuITBF5Y11tkm6Lrtxqzq8VM9xA3WW2SdSzoe2jKN
 aX4ig20fKrxdjjyFVcHSCBYf1qA8AWxgKTrBH6nPrHPDO1E2mGZODmup3NQvbTF2sm1m3v7cf+X
 kVzt2WE3HswgiHDCeDHWNzYwtwAoQM/HTMpg0HmInyTVCLSA+QG5FljRZu7KfHAEI+DBP14Qah2
 apjzYHiYQMDvrFGcDy85zyDhTsQ/PvSzVGH75z0vwp3fzdV00gWeekZR+La7pWrQibhrrnNR
X-Proofpoint-GUID: AitJMDuUqK5crk-CZ1mnuIKBsoIlmKM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180182

Currently, runtime resume will always return success even if the core
clock enable fails.

Propagate any core clock enable errors during the resume to avoid any
crashes later.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3..77d5e89239d2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -463,17 +463,24 @@ static void msm_dp_display_host_phy_exit(struct msm_dp_display_private *dp)
 	}
 }
 
-static void msm_dp_display_host_init(struct msm_dp_display_private *dp)
+static int msm_dp_display_host_init(struct msm_dp_display_private *dp)
 {
+	int rc;
+
 	drm_dbg_dp(dp->drm_dev, "type=%d core_init=%d phy_init=%d\n",
 		dp->msm_dp_display.connector_type, dp->core_initialized,
 		dp->phy_initialized);
 
-	msm_dp_ctrl_core_clk_enable(dp->ctrl);
+	rc = msm_dp_ctrl_core_clk_enable(dp->ctrl);
+	if (rc)
+		return rc;
+
 	msm_dp_ctrl_reset(dp->ctrl);
 	msm_dp_ctrl_enable_irq(dp->ctrl);
 	msm_dp_aux_init(dp->aux);
 	dp->core_initialized = true;
+
+	return 0;
 }
 
 static void msm_dp_display_host_deinit(struct msm_dp_display_private *dp)
@@ -1453,6 +1460,7 @@ static int msm_dp_pm_runtime_suspend(struct device *dev)
 static int msm_dp_pm_runtime_resume(struct device *dev)
 {
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
+	int rc;
 
 	/*
 	 * for eDP, host cotroller, HPD block and PHY are enabled here
@@ -1462,14 +1470,14 @@ static int msm_dp_pm_runtime_resume(struct device *dev)
 	 * HPD block is enabled at msm_dp_bridge_hpd_enable()
 	 * PHY will be enabled at plugin handler later
 	 */
-	msm_dp_display_host_init(dp);
+	rc = msm_dp_display_host_init(dp);
 	if (dp->msm_dp_display.is_edp) {
 		msm_dp_aux_hpd_enable(dp->aux);
 		msm_dp_display_host_phy_init(dp);
 	}
 
 	enable_irq(dp->irq);
-	return 0;
+	return rc;
 }
 
 static const struct dev_pm_ops msm_dp_pm_ops = {

---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250703-dp-clk-error-7c1965066541

Best regards,
--  
Jessica Zhang <jessica.zhang@oss.qualcomm.com>


