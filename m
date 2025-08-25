Return-Path: <linux-kernel+bounces-784917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332AB34392
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371975E7396
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DB3019C1;
	Mon, 25 Aug 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WE3VhV8x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51730149A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131537; cv=none; b=U8l+bDY3xvKld5uguLHRnYf2wtWoXjPKPuysSN3pdY3bNxg4uEZNGqRzvwBJqggg0iPBuuCColOHfNhfRbIDSc1VZ8McL30QHPmb6qS5pW2xLnY+rszaxbKp0FM2UN3vax10XzFvQ1KU+vxs7gfgTtB2+eQ1M0f70+JaL2so9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131537; c=relaxed/simple;
	bh=JkSFQSxYmzXtoQxC7rSWB7KE9kDbTY3oS8rwFDz1TxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmxdYWADPPPdK1pV56tudIiD8hcD+ANNd7HeThmcHEfRfH6ugTcUPpuhPK7SIknx+K4bzQWq66oyy0evCu6ExnEEoXnWrrfIa+heZRV1ivfw4/KiqcaEPPB/a1D+ClswoFTr9hcur7AzEk+sSOU3ibC8YBlHjWVnirMskq41cxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WE3VhV8x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8bvOk014293
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M6wHYbSvg7X6j+hxKHpKI5Xd3HiTiQ5a6PIWmFXRLBo=; b=WE3VhV8xruhxECoO
	l4c+2fW9Y/peDX9IcqV1KHaQj+t4oNPb51aj5bbwyJd6PbuvHXALDf1wxUkiz/rJ
	eP/lVlgTCIgEN27RhrYVjjKRzmVb58x7GE43TSozz5b8d9LoV7B4SAZvR7ywg/9O
	0+lIDqAa8z74feLeFaoteBNfPyak5HuNndGG/6CSfKsbgaTblCUcUHuPu6ACUkSj
	jYqdw0A4JlpXh4AhB/1MEKigivh0VVWpelxn209vop1DtWw6iLCmnysdGuDIBo/w
	VjRiVL3RfsA6Sfr8ApBYh7OASOkOtG+rWkE1TSTMH2t2enuk9CQPNEEdZ15mzc8E
	bd6FrQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x85beg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7704769dbb0so1714874b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131534; x=1756736334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6wHYbSvg7X6j+hxKHpKI5Xd3HiTiQ5a6PIWmFXRLBo=;
        b=AarU4MmswV2ceZgC2580PisyniyVYVqQV2qN6XFJ+ef7xHT4nlJInr0859Ew0mpamM
         E5pCLHIN8V22fR7Z/QGEEEed1qBbHW12or3+K48xLfZIPrgC8HNexzgkPh9yvgT8370R
         u6RM6NZa8NOnD0l5yTv16W89IteTxQsB5+z1YimyrUvlx1QlPDn8gElVBTCUS73LWwqs
         trr8rL1yYxhNmi236rEGeE/1i5w1WtY3KwMtAx1+5ngdofNi/n4UmiY5doveRAR29DNS
         TcdtdO/pCzykEDmsS7sCmMhUNxu8qW1yx+rA2qCVYge+NGcBD1gLkC5V0SKf8DmU+p8U
         u5hg==
X-Forwarded-Encrypted: i=1; AJvYcCXYztX3rbG2BNIzYxvWHFp2WhsfCkN/eF/ItDdNCVBkcO/C2iGAyXVPx3n1Ry7Ms1pJmYiR7IYLMzW35Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxelK1PrFYswZSsf+udRSar612tPikVeCOzqN2sh/b9SsCTKt1u
	uXH/16OQeQXJs4jgVE7h8Up8vI8oZS2uXJWRt8fosu2o8eps/Zsux0ihHdMGI+CsYeWTbsJX9n3
	ksLeMvIAkmTSOylil3+gFWuTzxUE7Hk1mkIzC3nEpm3w5mYgCAdyH47qzCRVs/+FOj1Y=
X-Gm-Gg: ASbGncvTzDx7hDMmRtnpnVB3wb/FQcBhM05/yPRLubdpVMNZ51XGuvkIA7P08JsvOME
	86uXOarKHtUn5LAg73ALObIVXNPXFise1EgPF8lSmBF2e1USH3oAyzr6yxHu9JJWmTNmM5DqW7J
	34hPglnF0meo8QN5rSxT96pcGbaNXHm9AJdz8W5kCdjKCLD5aEZAouy4tTSZHXq8OCr+GhyjjaM
	s0urXwlawi8jVJn8BwiV04gArEZIYuXlWfnEmrA8Svm9MuVAd7iANEXYOyCSIFEC6h3LgxThbKl
	y38aa1H3WK73KanY6tF4BBrxfYgMIZXquTc/8defQ31tNFMXbsluRjH58laRLb4NDd7ySJQ=
X-Received: by 2002:a05:6a00:391f:b0:76b:e936:607 with SMTP id d2e1a72fcca58-7702f71282fmr15614247b3a.0.1756131533929;
        Mon, 25 Aug 2025 07:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOIe57ydGXa++MErfMnONFuNJjLar/gSG8BXw2uySW/CV1EwrBjfkSzqdOpuu88d/5cAafZg==
X-Received: by 2002:a05:6a00:391f:b0:76b:e936:607 with SMTP id d2e1a72fcca58-7702f71282fmr15614219b3a.0.1756131533415;
        Mon, 25 Aug 2025 07:18:53 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:11 +0800
Subject: [PATCH v3 25/38] drm/msm/dp: Mark the SST bridge disconnected when
 mst is active
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-25-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131422; l=1007;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=qVUepIjusQu0oiyKhdBBjZ9rnYnedg/dO8rrWYD3he0=;
 b=Mm7SH2QVnkdWkXUKoBGe917JO2ug8TJ3B1CNvrWGxVgZ6cUb76kGHwuP9NdkG7IbSysBIbP6M
 lj+R8gKVMGzDFE9MsunfScMTtGGQAGp/JTS7OfT9zluAnBOGNoIRbGp
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: d1iMgCsvPxSSPutRlIMtpesdl20FS54w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXws1d1LA+tWjj
 PTrt6cZQlGT/TDIs2dmcpKxTvc46HJgq8Ju9u7iN3kR5xeQYpd1buai33w6J1XNdiYngn6G5Bw6
 9s4OQdxfMhsUgTQvXG/+NwihR/4TC9lSFBCd+qAnE/1HwZYuyIgjvdyofQXspb6HXuQGbrs+BGG
 vmnZrMLPHJ6MFnS1q0GOycmUmYzdWkyT3qNV+QXkEWcevNMvS5brR5A9bhR+n7+EgWDBwKaOCQk
 J1Yilux2kjPONmLk5w3zxwNehf70AzbLu/E2JL1DtZ4TsWnaKjTb6KeQ55E1EFhy/QHeYV088Ou
 MBrlj92e14yBMZ1WRpHL+DKz66G+iA1fzTBc/IaUSNhAZ3zVEc/QHfoRvjlELmggzRvEgfqtBom
 11vWkHeL
X-Proofpoint-GUID: d1iMgCsvPxSSPutRlIMtpesdl20FS54w
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ac70ce cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ao9NmXljvuVdf-BuN7wA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. This patch skips
detection for the SST bridge when MST is active.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e2e6b0ea2f9dbfe49a599ca19b1d205669365c4c..cb433103d439ac6b8089bdecf0ee6be35c914db1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -986,7 +986,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge, struct
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	if (!dp->link_ready)
+	if (!dp->link_ready || dp->mst_active)
 		return status;
 
 	msm_dp_aux_enable_xfers(priv->aux, true);

-- 
2.34.1


