Return-Path: <linux-kernel+bounces-728478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43185B028C4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64674A60221
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678B225403;
	Sat, 12 Jul 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuGCGBLd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B78221F1E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281936; cv=none; b=YA6KIjZHJ73aCdT9gcKSbCY+BLHGXCTEhn78FfYNAeOI89d7tdaxWQ+05zG9qgpFojDWvhYgeFdkloSx1h/vjQ2C9/Y/RzC2rCIv9qgs6FTRQ2mSxciJVgeXdOqcUJwDvA/NPFkqJqTz1whiPr3eg49lQ8p/Hd1fu0iWGWbM61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281936; c=relaxed/simple;
	bh=Nilu1E/giHkwBPy/wf7h3OVA7PlAAogAgyPHnfWsq7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIMYpdKm7cArBgy+wU9DIkINd8L59moW5KNxE/ZTWA79tMtpejCui/Udjg3AWRTVToi21e4CHaZkH1fLkJqBYg++QBisWvoQV0b997oFRyGWYII8Equo66nCapYqpHL+xjFAbxluVSR1wVycPBqt6tzMQEjsnkssT5jDTtONqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iuGCGBLd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBCWQt007995
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hfqgXTQcuvdD+oPZQXvpnC/A02zcRDZ028wqX5sH15Y=; b=iuGCGBLdAI+QG2tw
	lbDd6WMIWvQ/E1JxIK5MPbRReUyQSmYJjqXCz+L1EPUTgXwz6owUkbAwmPYrqhFe
	klzw9sFCc93p4IWbOrI2MO2mJG5WTjx/bgIWLwOU4b9iEIije/BBRBjseS+VxrHS
	UZhqVDQQLoVMs9W5mwLw5cgm15lz1cH2Km1q8NPCYvqT5krP8+dbCoUEkeD5xA5H
	Qw0QnplsfEa3kxcfegiutzRkv68YMSMjTfLouNIIrNG281eQ9o5hjb2lZ4l2wPbU
	Fyaiwdi1/zouVzCJfWEWqyj0k7xVuvg6AV095vmyc2NtiK7HJl8W6MrmOBeKmgDT
	kBxZ+g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31220ecc586so2604513a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281933; x=1752886733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfqgXTQcuvdD+oPZQXvpnC/A02zcRDZ028wqX5sH15Y=;
        b=fgwTEOIAKS2/EcAWN3rEqyuFFjCJxwJd5Q1XTu01hN4GCPze63s01asCPgEJZeECsg
         rd1p62pQjHBC3Yhexg25Bq6CJlZu2JpQ7zsolL+Qi/2CE0AGsw2nQKdKpW4gDUe/3izI
         xPtPspgqtiqAivvkZECzjOOKtUTe072q9U044ajgx2eksOSU2r2SeWpkPZZ/dF92pzGT
         fSCAYsc/kGrYdiv5ab3F+fVgdnPXD5w80mH0VbBbB/CnIfiYtn5FoiW+d6LyhUNEMuIj
         SQ5+P43DxuotjWctWJx/l8aI8hTnznZ7PbjmPTU47gERdhJZ/rnmTys68UOqkjR6pBVW
         SvBw==
X-Forwarded-Encrypted: i=1; AJvYcCV57onS3H6IKQm1/mbjtMJKXU6t4n6rh4pNf7vXXU7Rl3FtwRapwNlr0knLYeCLzPiIQSxLURKD5acbP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvcUYoNYqInMfmcCuR9DM8yc2R8jHKr4MAj9jVU095BQH1sj9
	3GTlfLUL1OqlqOyoc4BwQ7AtyVzxPSBB3WMD/f9RDauE1JTJQ9m79SA1XZq7aDln6fC454/P1cs
	bzjc8SonSzdDaAheh//G/jQrMemr5u7pVOl4/AmJ7N6OymPVTBKNJ5Jh2Xnz24Rz6N24=
X-Gm-Gg: ASbGnctTNwYPr71F4Plqpa+2DkoJum5nLQ/hJfKp3I2nKWv2/bLNI9H3KV/3QyMO6wf
	4Gk6onJkzL4iktrQrUaNYHQFjHLcgbDytWfPkjE1tHGvLTTWWhfLWS7SxuuXX6iG3IVC/PCBBaH
	E+JR6Ydu21hrVt5ND598MwOoezydTXIMtsmBNTMEeDWOnL0PAD/3AllK7StgEyCIbBRkw1Z77Ug
	HXVamS3vHRvkbjRzd1gragr757uvp2YnjGqQc4Jy04VQlcabBQxrr52IdCAumkmXb4xUk/ZKpHa
	+hrl+25C669IaWr6jRl+xnXINFzSD2MSbBoXfXFv5vHVbi/p8HuADMBLnyKp5d7rIJj3RtpNsYW
	0doBZ9o0FYUU51/sr5+xs7wdB
X-Received: by 2002:a17:90b:2708:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-31c4ccc0e50mr6907459a91.10.1752281933206;
        Fri, 11 Jul 2025 17:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7/uPvxLktYrM8ch7LnXCoHhYeFgjupJmhBcRiyeOoV5Mh4IxsfUoFBcoS1rpfP/X9mTjmzg==
X-Received: by 2002:a17:90b:2708:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-31c4ccc0e50mr6907436a91.10.1752281932809;
        Fri, 11 Jul 2025 17:58:52 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:52 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:22 -0700
Subject: [PATCH 17/19] drm/msm/dp: Use drm_bridge_hpd_notify()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-17-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=2506;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=Nilu1E/giHkwBPy/wf7h3OVA7PlAAogAgyPHnfWsq7A=;
 b=zjvhshEsuNvdL2MGy3+vIib7IJ+dS8vv6SU9gQtMA5rPdCA/RooUYT8P7do31i9ZOTW/XcJkd
 FezTzROw+JHCyUc0ytOAv+OniLISzTxmQR4B7pMZtbqSrFb4edr0pQ1
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b34e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vUZxlgmVQAOzQBO0PGoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: JEMLPrrG3jQYlvr3PGNIF3xeTXJ3yhrj
X-Proofpoint-GUID: JEMLPrrG3jQYlvr3PGNIF3xeTXJ3yhrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX0VxCVF9inPlk
 QaU2fGQwqPH7p1jZeks3LXXi0t2jg7yrUo/svMdMcw9WC0RRp0Lywg3Lg4TaYvtcpnOhJCwM9Uh
 rgqf4sxT7ZDVyXlz9kXA19TJktUQwt66/v6nxwhsalduI+iHXaoAnsUF39XfyPTT4zFt/gP64Xs
 fuyzUdGiOl04SmPDZTRUVSlMkc2s8As1GanLT0CqpnKVzaDbtZgT/SzKG9tyrKr/eXj9Rcwxr6p
 IB0VBruy7BxtX+w+QeLrENHvxXlNdk0BvohhVXZP0FniCTmVFMaWH5en1+q5+N9Mgt/P620DW1I
 NWKNZn+NG3y+xQ9olyQ0swKBSzgHlyD4NpfQvkIRiLcJp8PlO+cvrHIPfMUb3vPsVmFR1EO2yJ7
 63lLcXj9uT5BaTi191hoM7VFnqN56tPmStFLXXwIQdpvutLHmEiBbHMm67xw/kmAC+L4knER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Call drm_bridge_hpd_notify() instead of drm_helper_hpd_irq_event(). This
way, we can directly call hpd_notify() via the bridge connector.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 17 +++++------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3aaa603da4f9..87f2750a99ca 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -324,17 +324,6 @@ static const struct component_ops msm_dp_display_comp_ops = {
 	.unbind = msm_dp_display_unbind,
 };
 
-static void msm_dp_display_send_hpd_event(struct msm_dp *msm_dp_display)
-{
-	struct msm_dp_display_private *dp;
-	struct drm_connector *connector;
-
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
-	connector = dp->msm_dp_display.connector;
-	drm_helper_hpd_irq_event(connector->dev);
-}
-
 static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *dp,
 					    bool hpd)
 {
@@ -358,7 +347,11 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 
 	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
 			dp->msm_dp_display.connector_type, hpd);
-	msm_dp_display_send_hpd_event(&dp->msm_dp_display);
+
+	if (hpd)
+		drm_bridge_hpd_notify(dp->msm_dp_display.bridge, connector_status_connected);
+	else
+		drm_bridge_hpd_notify(dp->msm_dp_display.bridge, connector_status_disconnected);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 68bd8be19463..6e12694d5a64 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -16,6 +16,7 @@ struct msm_dp {
 	struct platform_device *pdev;
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
+	struct drm_bridge *bridge;
 	bool connected;
 	bool link_ready;
 	bool audio_enabled;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index f222d7ccaa88..b12a43499c54 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -358,6 +358,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		}
 	}
 
+	msm_dp_display->bridge = bridge;
+
 	return 0;
 }
 

-- 
2.50.1


