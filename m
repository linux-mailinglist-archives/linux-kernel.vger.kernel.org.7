Return-Path: <linux-kernel+bounces-877647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A935CC1EAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B8518819E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8643346AB;
	Thu, 30 Oct 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IoYtH0iX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cPkjOQMg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA53081C2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807638; cv=none; b=mYd/upSHJTVzjmL1SJ7FRIOzR4fLhgu/ZmCQJv3tWx8gOF3KmRmLLIuWkygpI7B3ZZ81xXJS/L2GcPycx6qWKtph9GUm5O7hpc3XvCUj/mkYecUIlKo/7wb2qFofpLzT7iBs2hrwTmVRQmKS+/pCzjTgK6dOJvVGMmymYFPVhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807638; c=relaxed/simple;
	bh=DSP0RYR4BmXibqx7IUSmnSQ47NHXteY7yJtMQO88UP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7ribpXmOLro0GBMdaTLpeQMhl9FJHLuUyjH+FkatExDTSV4i1MokD47zfTP1T9NTYPGidp0mncGnhEvzJzI+iGbifr4orWgUYSH4R0m6pPfromqx7enG0hQ0Q9QyDb31C0betyvRyuGU0c3x0ppqGRTeq7+72qIMyWOOfxJKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IoYtH0iX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cPkjOQMg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TLLOfj1697216
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUBZezXctNZUTvhj4jU3CP7PPArzUZna/FMnzKRKs/c=; b=IoYtH0iXSHh6k9PP
	EdiWqkrc6lk8aPI/Ew6u52eIh/upcZkR5MDYbIN0UeQGCGl1Jtgb3UTD3ElTv/8U
	ebx0jzubXzkB9992kGMRGu/+nSYySo//YMy5kItGHa61kq4yZSVSEWUVYd87rCB6
	tiYYqF+WFC0F2j1aUzKMmP6qM2ImMT1TK1uh8TBvnsrPc+mfOl0yn6GbQSomYvxi
	7c016+prILa117s09r1RxZQ87vUxMpkqigJXcTA4K9YDodyCftiIppI8PgI56S0y
	TevF6V6kfZI5WRpTORw4bJfGnPam86jnE+ITRtpui/OqIDo1YgpeYkPqkB2SBIa8
	cXp3Hg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv1byg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:00:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2698ede62c2so2303945ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761807627; x=1762412427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUBZezXctNZUTvhj4jU3CP7PPArzUZna/FMnzKRKs/c=;
        b=cPkjOQMgyvp1zYoWmBwCmNZpS+Kyf7MN/zCQ773azG+K/5QN4LQgQ7CMLjX76Unp9r
         NbDaOTgPmIN0yhVCCZ9ePIuMbMP9i9C8eopX1S+wjdfmFzVjqN8luqG+7/4q+b1zdPe0
         66Zv2ukYdBpYrebo8hjLMHIYYSIVggVzlImpwPxo3CY1XGcGJ569a2gt72z9rOeGjiV3
         igqCVNzsoi2m//75bFv9LD2CPLSvpyA2I7vlIFU2ZRcCAGQ9G1rmVvwp2ugelje0TKDI
         8i2XPO/WMb+zGhkI121vaqhYL5WCffU+Mmr8tKzwpB5g6D883CsuP/RB01XcY4uSDIWG
         R5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807627; x=1762412427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUBZezXctNZUTvhj4jU3CP7PPArzUZna/FMnzKRKs/c=;
        b=hW8vBC6JM6q1xOwjzQepKyPlLX6q2RFO34OQ4dfKRXbtIEWvKc8F1syqhZu8rkfqo7
         NYx11x0jqMrQDyQD0U07uksFfEkWv4SeQye2W/v6FdvmGu1LKZbVz9B/h/8AivMsjPb5
         rdfhW3g7uYtX6v3AF4tWOSOYCaw+A1aRyZhc8zI55RFK3nN/5pT9xOSEC7HyH4bbAbFU
         iEbuIZ9PzZHF6IOfp5PG8PldH++Y4qZ23YM9Mo89t3oPDFmATKbl1qBZMfdS13FkLvyO
         VjVXZe/9ZCsjuh3gf0g1xlcPjj+pQ2z2Ro6ouRfir+rV3senceG1KQ1dUqLwP+MNsfFT
         UnJg==
X-Forwarded-Encrypted: i=1; AJvYcCVjLXRYutrEW0cPCuDf7JuQIN0q39L/P7TwupKLoiE3bV2Ru0x7g+1wv3Y2V4jX+3+v9FpGIUMlX0IEFbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTipiAi26Q9s9qPD+paleJeT64+HTbmY2wvYQsTi9voLhr35Q
	lbO5x5m1WQSLqH8NelyE3NrO+gMHprtWVaMnCJhlBm2/yaOBmIHmTyvGQx0sCunqjvecMO4Wum8
	j48t6RaPrGnTgJ+g+BNu4x+NFl3ACwN+8OCb6af50Eld4IcJ+9EI2hi/xeuEALsVQ9RQ=
X-Gm-Gg: ASbGncuo1dzeFCVb+oNvp1Jwxf5KtUVHZ0VZAbje7iDtGHDASjAQuvgnFkBV8igb1Po
	BaETo1lacPUO9M5kdJPKrNMEiOa1mDx0IO1LFCpDiCJfVdwcFmcshMKH1avVg7QBtDGh8BBlh8n
	hs6tdAKkhkB60yxEekpp3iWD6GXwH8oZUPtJRcbB4Ik4PJQLue09hBMuJHSSR9JiqskhykA81Iw
	I2Db/Zqmh4GewjM7/wISV7L6lMHnf99KztFrxeIboANYJ9KR8auWUDTS8e5zTwUSs16SS6UzxkA
	Yg+N3xoq2PAgTcp/LCzKjo3/eHaocLeK2a+Zw2KpyO6MXSQciZnhGuyjznponXmFfCsbJeu+jN8
	/awOhEP6HZRI3tyiXamKHx/Dm0eDX6MCxdrcdq0LOnlaugciUd0DY2quWafk=
X-Received: by 2002:a17:902:f101:b0:266:914a:2e7a with SMTP id d9443c01a7336-294deec3018mr26279985ad.6.1761807626725;
        Thu, 30 Oct 2025 00:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdslsaWsoG4zsyjqgYfwt6Z3rdZ1U+hkfdV+J7do69K7rWHlvoTT+46HkH4s2Yl9Fp2Cxvig==
X-Received: by 2002:a17:902:f101:b0:266:914a:2e7a with SMTP id d9443c01a7336-294deec3018mr26279535ad.6.1761807626037;
        Thu, 30 Oct 2025 00:00:26 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a73sm177671325ad.74.2025.10.30.00.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:00:25 -0700 (PDT)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 00:00:07 -0700
Subject: [PATCH v3 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-av1d_stateful_v3-v3-2-a1184de52fc4@oss.qualcomm.com>
References: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
In-Reply-To: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761807623; l=1154;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=DSP0RYR4BmXibqx7IUSmnSQ47NHXteY7yJtMQO88UP0=;
 b=0WMtZEe/tBnXp3+5xyjVoKFhYzyXZg5HwdMYCozn8Yt5hskJhnmYMQpWrNMGItNuJZCIaHz9n
 7tn/p0l2T0zCvNAOd+pF604B/fGhmhJft1XzwEO3bOPsdTVMLXqQDCf
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-GUID: 0aC8Cgx1Hn_z_481FW90lkOZ7aTIReGU
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69030d0b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3VFMuRvh7oFGMF0ZDtIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 0aC8Cgx1Hn_z_481FW90lkOZ7aTIReGU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1NSBTYWx0ZWRfXymK1e7f4ImrE
 CqPe6WsEp1+3LjB9HpLpyyxMCpUYMDPsFTT8th3E8uef2x0To/Un87fom5cdVvh1n0nboUOqlXH
 mzozDIM3o3aHHKOI4kUyECw8eYLXlCLjOPVRGVPHoU3YztDaLtN7C2t8BR3hUGrP3kRTgz60VfP
 7Re8FKNy4BLLlvHsBum5uU3pkMnvTh8BGgsBJsOUKu/jo3dBEzbY/XQbpQ7A3DsFUyvhRhSyVdL
 8xXS7g5LXERJeHS1Ks1ztKs/VQnEJrx/vaAbcKIHJRyWS7KACyKWD8B/47G3hGAhgIt8VVxRAxx
 DiJANheWTskliaxlUaq6QWRh2SOfuO2Ak4zvCzNaE7A6uvi+MYQ3sGE/M24wwTq3F8CjedCVfaq
 1ND4zpRoYc6CnxAi1Kr501rwUUbyQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300055

Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.

Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bdfdf45c5de2f2ce885f219007718a54b5c86251 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU stream"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
 		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;

-- 
2.34.1


