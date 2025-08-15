Return-Path: <linux-kernel+bounces-771096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36907B282D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2180F1D00B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BCD2D8382;
	Fri, 15 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV4s99cy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3E2C15B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271283; cv=none; b=HyPDnNjLhbCKa8r/fBkvjrmiOgXZ91D5Q05pbkX0rBOZ7nM/OUlqAPEIomuNwZnsNQcFpsdIiE5zrzQ0AxPaNkN1ktPHAx0ywlX2cB4BR9qHV9Mkb7OqdvAFmChE2YbU2AP23cizJ5Iwt73mC1aPrBR7jS1LnGbijrOzcn10YqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271283; c=relaxed/simple;
	bh=MhXp/fPIZL0duqn4iDlN2g/3TmsxA0F6/Y+4Fg3Oogs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b2wY8Q8LbM3bDIqt/KebKs9GT3r0t8TmRW871qEOv5a2CVKekwIddHbAZBswSXSskOdPK2E40YNG2B59CD+vYK06r4IOT7ygeF8XHh/Dp04J9XF8BmpFNhxfFKC2aroPZMpuXhOvbW+0z7VgAb1sFmnf6yQKY4JQmrnuJ7o7uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV4s99cy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FELEUW022605
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g+Idl0Z9XcKWlohwID/DKU
	sWWH1aq7wh7EFh9rQ7yq0=; b=oV4s99cyHZFy+UzRK2yKPGbi2pdeRcgpF6KfRJ
	IbYlJ6+pIbCL3T8GF/cSh6BFuZ6SRYJy+L4+bfty0wY9fACy+us2zJkxp3qPtnyy
	coL80LQVG1/4nl9BAR1dUe3Vjj+dP7Fj69labWb7WU/DeNJA02L3GfvKfO/qcXLC
	mbRKDw4JFxDAcdNAGtSjJBg1WtjOt/nHQQFzxXAZULCxYPpXoQx9CRaUbLkBUQQA
	Z+jQ+rQKU6I5a0ieKaheN+UiQzIhhPag8vEmrvSiYBc3WVtz/9UI51gPEZvDxO14
	IrmaSWJEjCWqq8S76izbtKdNKI2d+fpjsItz5oAqXaX1AjJQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxhks4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:21:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a927f570eso42993296d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271279; x=1755876079;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+Idl0Z9XcKWlohwID/DKUsWWH1aq7wh7EFh9rQ7yq0=;
        b=DzSGJEcBo2rFWN6TLa4UGhuqZQvmCRR3ZT42x9DRtPW+rB9AnKT5jWhP6fQ3sYyueR
         S1fkWT6/sdw1gMEUcoltvK2PMiST17GsM1R/7gS4+oSiOj6Y/pCy0IsSNtIptIYM/kMF
         X1pfRDJC/coM8hwvPoHAat1WftaLUfB9UNhBlvA/k3jcan/O2Yf4DsZPdBvivxxdFrmf
         xrC54n/NMOQ4iW5lV0kQEuY+V7rMYMIPy28lhOX+FK5Ip58cIZfalJ20/wh4iq8Epq2H
         ieg/UO8zKc23QqNPX5x0JRkIHa8GijCapqOD8UU5p4UHC0MZESu9hBkYbmiVyjz29oxT
         A2SA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ifN3wvMgNuA3dIHVOfptWIClTL2369iQgcoXqnCM+dc9MDcgUQqxMXtuR+FDxqAwdWkC0Q29vnGhdt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0bLmfSnfvWUCk++AopdzeKV8H2pa7O7/cJcElPontARrRBDh
	/w9nB8WE4X8KbLRcsUSp8yfv/BtE69f089WisTw6MisWg0+H4tttediKeoGDT9qypuTnatzT6Qt
	YEZ6LN/2aIpt2Yo6xwY/QXFqRRWf3m/lJ2VaPX0sf4G3GVODm/wE6sGH3D3oZo8ozc38=
X-Gm-Gg: ASbGnctFARIuXGR5TNgbU0RX2hZiXAjkKp3o4S+mz4L+pBZgEL8q1OlFSXJeSmXpu8Y
	N6ok+actTALjUapCm4BXHfXon9jSzfiMA/bMj7grVTnxp1QvspktL2LZU9DUFupOWwtgt4oV0yf
	H3WDCrUPvqeoNvPwM29+Pbuaq5sq5yIzk7GWGVnKb71n39+U20+lFqNXZCoMgw4ot7/IylJRc/U
	NstE2IpHq+YGEDDu/Pc9U2iCn72wlQmlp6xPMAWUF5RMkGi1rPE3ALcQVpfVdZBYlHEsZiv7sCr
	ZkoiLDsajL1roGgDShwr2YQLaDVgx5N4WdukfG/yry8amk0sdY8iFYDYCS721QiZ5fNt5l132to
	1ln8rsOXBf6fg0SpX9TBNqb3mnuCNRBsySIydi2tPUg4AxQDzxVDE
X-Received: by 2002:ad4:5fce:0:b0:709:31f8:fd96 with SMTP id 6a1803df08f44-70ba7b17e4cmr26400646d6.20.1755271278915;
        Fri, 15 Aug 2025 08:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaBrfvvSpMdjiKGCL6kd8iXm7swFbZQ5AFnvhsfAn56VpGfW3GepZvAUU+AsC5CJ0jSSN4rQ==
X-Received: by 2002:ad4:5fce:0:b0:709:31f8:fd96 with SMTP id 6a1803df08f44-70ba7b17e4cmr26400036d6.20.1755271278298;
        Fri, 15 Aug 2025 08:21:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43b992sm3921361fa.25.2025.08.15.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:21:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 18:21:15 +0300
Subject: [PATCH v2] drm/msm/dpu: add support for 4:2:2 planar YCbCr plane
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-fd-dpu-yv16-yv24-v2-1-eb08531814c3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGpQn2gC/32NTQrCMBCFr1Jm7UgziVFceQ/pIuanHZCmJBosJ
 Xc39gBuHnwP3vc2yD6xz3DtNki+cOY4N6BDB3Yy8+iRXWOgnlRPRBgcuuWNaxG6BSnUjyBO5II
 5BwlttiQf+LMr70PjifMrpnV/KOLX/pEVgQKVMRcprbNaiduTZ5PiMaYRhlrrFwgwHmSxAAAA
X-Change-ID: 20240222-fd-dpu-yv16-yv24-6bf152dfa7f3
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wv5uC4RQRHmvAs68qHKZxljKlLnfQU03RWVOByU+dqE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBon1BtPrZfCPEi08HCWelXcb92WnzvWD7NeIXIC
 DAY2rNGwtaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ9QbQAKCRCLPIo+Aiko
 1WX0B/9tQ9mYZTbCeyyqT9wRFTYQjxrMwO1bTF8D9mi08bKz8+l+VN8NN4oggS9Ta5LHF/+Bz3o
 iaUvJvIaipbxZYV9wldCEbl/vPMtA0G3gHI1/dKxsOZBQiXoikBfrdLeSnKBQYzWkdfrQA39oNx
 JeWw2YNPHY8LU0GmYUwUITlVsauVBMn/IKchzhrph3h8a6DCLO6FNe6+9sHomN0QCqdbypAh8TQ
 JR/etZTpEAxAnG515wq9a/cVcXiW+7kQJfZraeQVo5yR0S5aGhF1woyfqmKtJgH0EM37nUaTJcW
 5zQh1099swC3C/70Ej0BIqxszU9lC4h8K8fn/scZ+bRF2SWc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXzJiXQWkK+W67
 P7EYSw6mNPNwpg8wlC0HKbSfFM5mnLInInAAcEYE+Q80ve5iBpx9gGzML29RE+p9wecPqnZIx9f
 qE05d5coB+RryW7DeZLwpNDgVSjhpdy8l6T0POGPSzTXr3Otn8TCq1cEPaW07N1ewwVZTWDJtDj
 2Ayf3NUCXhdH1qQYUfQEOmkUi55IiamOMoylkd+qSDX90UigCzWKyBiLnnD3m1d3aGAc6/Kabhb
 b/BE14+y5EhbefRxHR9KkQ5WAKMaW/xE6IoyspHQ3lxAeLlQPJZGlJEbwcAiNA5P6H59aKcuBiV
 /EZBs/ZnDQKez/mHTPUWWDX050jCAHSRCzy6b6KkHyu49WPLZu2vn7BbVcQy9PVRQUIArhZEp9e
 ztG4jJ/g
X-Proofpoint-GUID: 75uPSMbJyKcLWPXBbQsYl8duU2GWa-_f
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689f5070 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ZlibHMbJTRG0YE4QOoMA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 75uPSMbJyKcLWPXBbQsYl8duU2GWa-_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The DPU driver provides support for 4:2:0 planar YCbCr plane formats.
Extend it to also support 4:2:2 planar formats.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Dropped 4:4:4 formats, they require higher clocks.
- Link to v1: https://lore.kernel.org/r/20240222-fd-dpu-yv16-yv24-v1-1-4aa833cdc641@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  2 ++
 drivers/gpu/drm/msm/disp/mdp_format.c          | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index e824cd64fd3fdf2ab0db92794a0aaa57c109decb..b1ec781ffd23065edba76ab9fdf8b377c8dce6ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -183,6 +183,8 @@ static const uint32_t plane_formats_yuv[] = {
 	DRM_FORMAT_YVYU,
 	DRM_FORMAT_YUV420,
 	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU422,
 };
 
 static const u32 rotation_v2_formats[] = {
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 426782d50cb49d57a0db0cff3a4bb50c5a0b3d1a..481c04cb085827175003d9944258420d56021704 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -511,6 +511,18 @@ static const struct msm_format mdp_formats[] = {
 		C1_B_Cb, C2_R_Cr, C0_G_Y,
 		false, CHROMA_420, 1, MSM_FORMAT_FLAG_YUV,
 		MDP_FETCH_LINEAR, 3),
+
+	PLANAR_YUV_FMT(YUV422,
+		0, BPC8, BPC8, BPC8,
+		C2_R_Cr, C1_B_Cb, C0_G_Y,
+		false, CHROMA_H2V1, 1, MSM_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 3),
+
+	PLANAR_YUV_FMT(YVU422,
+		0, BPC8, BPC8, BPC8,
+		C1_B_Cb, C2_R_Cr, C0_G_Y,
+		false, CHROMA_H2V1, 1, MSM_FORMAT_FLAG_YUV,
+		MDP_FETCH_LINEAR, 3),
 };
 
 /*

---
base-commit: c8b9adc58cd171fb13e3554ef91db95c066ffc19
change-id: 20240222-fd-dpu-yv16-yv24-6bf152dfa7f3

Best regards,
-- 
With best wishes
Dmitry


