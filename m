Return-Path: <linux-kernel+bounces-784911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D56B3436C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DBEF4E152C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AC3009D5;
	Mon, 25 Aug 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fvYDCdH6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49A3002C0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131512; cv=none; b=cM6Vu1hnCrFHSbiLmZY1WXY7vZSXoFgCue4d2YFxclU+dYtezyBSmo1LQfxls4Bya+v6wiMOlGna0oj0qxhRQx9cmcAMrxx2lMHO+PPPjAxnqZ7MzzXPi6K3GtIZQWc6sR/qDXCb9d/NC+5uifAFumIH6eVlltI34uPu1pW3hIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131512; c=relaxed/simple;
	bh=gAhbe89jtUjMs+tCQuBkomsR87IKhc9qd6HJdgnxz8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYJMFJOlZlVsb/dpGQ8h06F5XteWFppSuF5H1mF9jFCDV2Xvgi2ZKSzwscRCn1t7jaLdjOufHrYcTVUASEK0Yioo5985opy//vCJl0DipXZ9eAjhOM/U10F6Ijrgjmje8SDUxGLFmxRS7IkGQZTKA7SXzwUKXO+s7gwQ2DW8SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fvYDCdH6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8fibm029424
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uJhqvqQDB3HVRz6gPABXZ4Z20PbjJ0Q4eZGeWqXXZ84=; b=fvYDCdH689Qc92QY
	XDgTTOW7ucZm+OLAYHd8f8/cxjUySobH98y8j9U+XUQtNeua1Z0CyEzuP/YkwE1o
	nSMAggzfsh6RjBsNf1DYg69EJbGDaruInTTPylL7FnJ1l/MyTtTOucUJrSuFcBCE
	6DVYZ11sWKuJune9ss157KL24+SZ2rDxdsXUkE75GM/0TBG2xcCGSma2cPoXip8O
	MBd765ieEazK7RYPDJfxLXFiEdKw4l8wP6T0qJ45ma4Okjp36z0aWDUMcqEYf6pH
	YNWWM9uZBkJ9Zpty8laI4/fGpLJa9ElFZBE7gHb0YqyHJH4NVFt5zsH5l8CPEbcJ
	bgiY4g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6de5dj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so4623408b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131509; x=1756736309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJhqvqQDB3HVRz6gPABXZ4Z20PbjJ0Q4eZGeWqXXZ84=;
        b=tJptmT0FQBz5FiavgkxNt2LKFiTaBnq8qTQHEUAIstPXKvI28zq97s/3ZvhUvoR1ce
         ztW/Dto2IxnqIE4I2e6tJaXcqWdSzn7xDiUbz3cZPfzYiG4P8c6GWq1OZoolTHAIdxDC
         GrKWoqCExokJYqWG05JHFyaiNAaKxz//HSSZOMwNLhc8mVAJe6ccgQ5d84++noiaQlZU
         1Ckf3FRHcpj9prAJ0weNcIanWJn7WBD9iI4WBjkvsk7DCtleGc5JWkiUAf9lsSfVf1s2
         merUFZqI08FpcN4nYccxvCcopOweiGUhj0P/LlAtB91bduFzvVMDsZrlEo07rSDyPEFY
         ROrw==
X-Forwarded-Encrypted: i=1; AJvYcCX9N832PaWyj5vDTIekqxwp+afc5Vh27qxUhvgQMXDaP4nN7tyNPl6AO4mcc6EdmqDC160IW78RPVYxpkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oDn/n75Qlb1fpvtY+CD1fNVyCGGmeTLU8T+Xo4PyE3n6qZTt
	z50YLD8UqhgiQxx1IddA2AKyND7UTaXTSzIDmzRSO+SrSDpANOcSgWt7DiiMFv48sRH+UaerzfX
	7udHUn01WWrHF6A+03K82N15s9FE9zhVQkwpeeULEwAQVUOKSnFlntqsoU22i+0RsckI=
X-Gm-Gg: ASbGncsu1CFKP+NEXfLT/Z2DRDgIUlvDeCw3Co6AqM8TvAfO/faKvd2WiBt95/sChP1
	46qP7esmuBuFHuOEvR7W0ieBEgYyRX/N7vCrQrenTHai/zuXi3Tw/hdJppe8vdwWoPMogvRza9B
	FYC+JKwEbgU7JWH2rEaIACTH3J3uouS0GjXqz3GWB9jA3+lwpRTbaZBnjt5Q8PqfUA6SZmKWKJj
	x8T7xot/H8mHY6bh5coxwkN9QMhdLayhfRBwMxv/4tm0fH53z0RzollA+R9ZcHqKMVnalRWk1Y3
	9bVcLfBRxUEugBQQMVoooQMkBkjn8qcs5samV7K2cRg6z1QiMpav2TVHrLUpZ+OGRG2RrVk=
X-Received: by 2002:a05:6a00:99d:b0:771:58e:5b10 with SMTP id d2e1a72fcca58-771058e5ff3mr5451515b3a.8.1756131508929;
        Mon, 25 Aug 2025 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFNAi2rKuvat9119atkAeteEXRTs4Acy3AzEJ3ZC9cZKTCP+PnnhPW5x3T71qafgNzNby4LQ==
X-Received: by 2002:a05:6a00:99d:b0:771:58e:5b10 with SMTP id d2e1a72fcca58-771058e5ff3mr5451471b3a.8.1756131508321;
        Mon, 25 Aug 2025 07:18:28 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:05 +0800
Subject: [PATCH v3 19/38] drm/msm/dp: no need to update tu calculation for
 mst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-19-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131421; l=1000;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=k1m4e3VK8u1xpO29Y3ltxjmABJorHzY7vguJ8hjD3qQ=;
 b=VkBvuFrfB1Ql4nqRlzbxrdOEfh+A3k5m2zJ0uZQo+MCP9ZGY9kVnH5NQQ8GIU33xIhfE9xTnD
 t6SQXjThQ+0Cc5q6e25GBxtl56Isg88ZTWiukWaloHZXTwSQmZ40lsh
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNyBTYWx0ZWRfX5dQLK3M7XXzl
 h7A3vzyaNbSo7l9tb1ywRXhSm1bC7FmNtLOqLWrlCT3h25qdN3myGg74ctEQhpDSIYjH1+CJARK
 +2PGOOeVGmjiF6lzvd5u/60jnCDfF9XCyWbbCmRETeg45XkHNwsdtRF+LkLgTIvnd4+oYLz8jr1
 dyO/E+myANARs4Pi57B/vs006nTbPwFcl0pM22fsMJjylHMx8UtGv76LbwBvep+0da/CGbkwF38
 mnPGSct0tl//KwyIAxLT2TDaZlVAAXk6odaN7ML0EHaPstb3Qt9GGz6Cxmb7ZP37XHFUSAQQ6Wl
 0m3AHJcksu9eKdAPcsbwsBrJVw3uL8eng3e6C/ssKOMvxS3WWSzjQlXCr3FC3t3LUAmAIiJX1hT
 fKtJvtmz
X-Proofpoint-ORIG-GUID: 6hoCMpxqQh9Bk4Ne1fyRjreZieYICh82
X-Proofpoint-GUID: 6hoCMpxqQh9Bk4Ne1fyRjreZieYICh82
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=68ac70b5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nb1SeSCrlpLBeGjklAIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230037

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP stream is transmitted in transfer units only for SST
case there is no need to calculate and program TU parameters
for MST case. Skip the TU programming for MST cases.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index d562377a8d2846099bf0f8757128978a162745c3..c313a3b4853a1571c43a9f3c9e981fbc22d51d55 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2685,7 +2685,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl);
+	if (!ctrl->mst_active)
+		msm_dp_ctrl_setup_tr_unit(ctrl);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.34.1


