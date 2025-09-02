Return-Path: <linux-kernel+bounces-797442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB644B41089
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C0702ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D22E88B6;
	Tue,  2 Sep 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jG0UvFMd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1F283FC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854032; cv=none; b=q36/qVnDZqcCT3j0B/XKaZphVcFsgdQtmR0ZGPq0uG4IR5m1U1eaaKgisZGTRD/bvhrd9HfeIWgL11bJ2Njfkggg2XBCIMErav1E0GOMI0zjtbGmzPsZu1L/xTa/vPm6PKy+fPU3tzG+53WlrVOQRJ6VllPc3k/O4249SWCoJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854032; c=relaxed/simple;
	bh=tQc6Y5Bsiiea2HywNjxgjTAh2ShMYLKZglVKp1Iwxp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeJ2g+a4kxtDpdniWsNwXVAD7JwtEv+Zc5G+exvvqLUp10jX8LdYUowU0pU7RijqAHm5JTGAdYJhopeIRfbj4zc1OXm1UuiKe9FdeLpGPyIOU9RTGLj2vm+K/HQaTdyxug12C261DNnQqfmVQ0RGQOPRCkb/N0s6M0qOfOI0/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jG0UvFMd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCVS024047
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 23:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zd0Lprzr3Kw917hPg2BQnERLEjH2IUBAYq51p+NcSlY=; b=jG0UvFMdyH6XyE1K
	N2jcA7Ij51Zs01jOcmUzif39F2eRb8lYd3gffHOyGB04GqPQmjAEB/UvPXkOKwZt
	YtINtb7l+MKqKJ0jVI+dcJ04gnPiYxwFIWxOfNeZUUmBvALTMSC4hZb/LHGPsqhl
	duXd9OT6xPszRtVPPO8EI03bKSNDDOwPiVN8PCe99X4Zm0KOIyozeCeLQW7ls1t/
	sL42ZC/GPH+ft6oSN7FiE06sncJ4qKG18AlrO5vCnOmgCaX+aWYgUpn+ILRR/vx+
	pLBxWTQQtFYsqoGSFf7WssM8VIpH12Y5qIsh9e3X2KWMN5fWFjmB0cvOfdNbrQBp
	PJ5uPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush31bvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:00:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329745d6842so703200a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756854028; x=1757458828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd0Lprzr3Kw917hPg2BQnERLEjH2IUBAYq51p+NcSlY=;
        b=W2dgH3NY0ByYK7wRAJMOX6cwoL2Kh00UIKDty5YC3MM2XKAkJ7UtMlhUnn9Q+wO5ZD
         nNI+T4O9W2RpuEyjtJ+courc6lb/VicmzZ9Y2+GcFyTmCOWOsg0f+W+lZTuX8LpyFuj2
         sW13FgRfU12B+vRisOZYHwMxuDfS8CgBSrNF7O1mPfh2/t0SMbEjUSBYOK6Xz2XPZfBU
         mxfJXpKv/q6JI8y0jN//M0zirjrejde5hQFYEZJh32UqIC0siDxwVC0wkhLfQeX7yHyJ
         0qOvT6IbHUyeRaq9ZaNr/dwzHVDCScpEn3VDhzR2vEJxxil5NisyCQFAZQxmaJlSjSFH
         fNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaj0IkOb7VUqo3a1pHhq9oA22gfNUoYpxHHbDDyeku0Aq3uT0WaI+cTd2YB6mYLfPpvoqeys//jcfdqS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGG4y8M/rS+VYFEIyAmaJQsYU4YFtEbtoLJvZQUtfMoxEDTJZO
	3YrRuhSYGzdrsbrQqtKmAQAJvN+bpBh47KRMTIpbbF/BC94VyR2+rQI3V4qJaPjfnSzMFhXNVCT
	chmWjvrT2vx+xz79G1ooad5qkvpXhe4/QDPaT3auXJuKOaghaF9RnYxU8W/NAY4KrEgE=
X-Gm-Gg: ASbGncum5BZdTtiHnALVDWxBhdTaozpNOBq+SRzeNOQw9jzvv0plkt/EAT0e73q+9cG
	BN7ji9huDapwtq8GI6i8aURil3y+f4DNZeTseqvUWhwnZUdTKQ8GnLBS2LxrG0JqmG3h6C+ZDFN
	jdNboeK3HFhg+T33p/REDBUbZjFipJ0hrKca9Hft9b8XA8qfOlTJi0VPTrJCuGq7K/m2aptem9X
	RUNMs4GthupDtYka195ir+riWRAkQCkHuOIOmd97DBX5hJFM0mC8EKGv3lTNDUSqkKV3kXaSIE8
	3PJg4BvnctD23OZTrMRF8xMWH2HNCdtdN5hIO+6Tz/JA9+HL4+vUN9Epj74Vst7Cr3suic4r0dQ
	IzOb3EA8v1rXE3b7HIQ4vcaxE
X-Received: by 2002:a17:90b:2dcc:b0:329:d47f:c25b with SMTP id 98e67ed59e1d1-329d47fe8f4mr3404376a91.7.1756854025811;
        Tue, 02 Sep 2025 16:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQYhZGXz4aSi5BuIlQQO1tbdiEjDHqMtjtMg306jjPNJf/8/j1CGcxS6BZzUhy4A2DwcBc5A==
X-Received: by 2002:a17:90b:2dcc:b0:329:d47f:c25b with SMTP id 98e67ed59e1d1-329d47fe8f4mr3404352a91.7.1756854025220;
        Tue, 02 Sep 2025 16:00:25 -0700 (PDT)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32a698ad4c1sm1875866a91.5.2025.09.02.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:00:24 -0700 (PDT)
From: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.com>
Date: Tue, 02 Sep 2025 16:00:04 -0700
Subject: [PATCH RFC 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rfc_split-v1-2-47307a70c061@oss.qualcomm.com>
References: <20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com>
In-Reply-To: <20250902-rfc_split-v1-0-47307a70c061@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756854022; l=1143;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=tQc6Y5Bsiiea2HywNjxgjTAh2ShMYLKZglVKp1Iwxp8=;
 b=uZrym3CVPNMvmBtZVtgfm4vNtFnQc23iaXz5MtlQ9OmrB1zeCq7etU7b51WO+ZDPYlTkZ3VBP
 wT51ISo8lizBmT5nqROe8RMgHE3Xxp+oX61YoSGelOR2tZLfY0FQgQH
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1ZOfM78xf1kt
 cXcQ+a+yMD1BqoTr7YramQr3OpAdnP35UqNPzJ7qq2FPfCFvCQ7bvjzY7PixwJw+ZSIcUmLRLL1
 0m1h1l6SRksvLkT2uWplSSOMdm3eSpAOTicNkXIpJ0+Dn7RFRJKk6ixEvYZjq7/o1jWXFfmmL9p
 JirIka17bkFmAw0R1Oq6YO/fB0mKxlC7fqCfLNlcSPH1uqntq4Ira7Tm5/+ok5UMjTnEn1eClxc
 ClzbdONxRcXuBCgpI2pbsuFNR8TJP7+k8U8xBXH1LTkodL2ow3Vyv47b1VscdtIX90ev2UExU7x
 MixMaTU2v+u66QVNEHZ/wG2C22wle6UDdzovqP0qwOEy/7oyraQZJQwXlq7A3KhxH4Dl45IzKJG
 yCqhcncb
X-Proofpoint-ORIG-GUID: wO3oKgGrGGhY0Ea9HmKbte-PkJ87Qqxl
X-Proofpoint-GUID: wO3oKgGrGGhY0Ea9HmKbte-PkJ87Qqxl
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b7770d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3VFMuRvh7oFGMF0ZDtIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.

Signed-off-by: DEEPA GUTHYAPPA MADIVALARA <deepa.madivalara@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..d3ee7736b74b0f277d3208782e3ac3282eca1e6b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_AV1:		descr = "AV1"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
 		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;

-- 
2.34.1


