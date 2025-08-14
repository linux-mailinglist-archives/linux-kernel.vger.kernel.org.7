Return-Path: <linux-kernel+bounces-768367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1819B26058
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E645A0AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3A2F7454;
	Thu, 14 Aug 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxJTJZ2q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566702F60AA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162241; cv=none; b=Xs/8mMipbZrpNmtrTuLyVh8K9QZydaX9EXQcFqvc4i65g1nJYV31JvSwjGsD7LD5JnfH04PIlx2gi/7lhwcdnz9MpI5eq7rn2ckSEH4lOTBAU4uh0YZcZmUTz5dy2Nj76R0TcD08KJb2zY6UCJ9J+/FVCpOLtS4vLxEgD2iEKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162241; c=relaxed/simple;
	bh=iMJRmARhSb1qXSk4SUYiXVNL3suv0fUyow+jfxnnJDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfQMfhDdX54r/ickhRXki9aliRfK6sFaEEGqxZEEZW4T5tCV4D+cY73lFixXAKNMuK3eva7DITj7kjhqbq/gieg89uF1frVEvPtrwdpHaNnDGfBuKtPYbNx1y+DECkTDYQoENBlWFJsD/jfp5WZ19Mp5QafvFP/VqfdE/MUH+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxJTJZ2q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMwihv012964
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IwbNIn2nq6yZlb6xLIzEou48MqgT0iaVMEMsW/WzzXw=; b=pxJTJZ2qCq+VpQnQ
	iquiYT8KXL0uf9XG3NeWQQdsOHwTXimb+tuVX/VfqobrD2ZSpbCdxCXULJPUu7Br
	/U9ihwNNEs5rcwtmFxseEBOFDhuY1tahvRE3VHY6fLy62PyzED5pbQY5/hVeKj/k
	Yt6qhw2zs0k3o6BP+LEEc8TqZUOzyKVQRyqmUa3i0ELOsy4fkisOfTlBCbdGl8Mh
	DGkbXh0g/bXxj6rJ2kulr1dEfhtavgrO9Lgmr8E6lKyD7YPH7CvFLB9D1cEUxLlG
	2hAgs6iGxDx73cGAPx/68yiYADVqG8VdbmdmTNBIMyzT7tCIIb74S5THN0ulVUPQ
	LooJQA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6twrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:03:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c7ad98so27954751cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162238; x=1755767038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwbNIn2nq6yZlb6xLIzEou48MqgT0iaVMEMsW/WzzXw=;
        b=X3NmKTqc5U21gYe0c28fc10qCoF7PBBngnKAEvLG8QlRfLXgEf9wKWd4LfURqPy6XE
         MeCodfDFLpB2jACq78s8c6VTGcK0IQ6d8xyt9qXFgu4y2mLPHdVGw5ACMv5oj71Fg7Fj
         67Y5OMAvOmqJMjR+rBiqGeP7vyXUfREVpJuZ+scT8PTwLpYUPSBayr8kEBnyQY/6ihVH
         DZGb7+kTa+iwulDQ8PBOEz03E/lS+DH9MrdEILVVDJD774Wx+vhW32BHJmkQbqJTUMYm
         GO3jsoxVDkoLV9r5T88AlCJ6g4Ko140MyKF2k8R1xlNhgLVyvphqS5iZP4zzFUZv1Tnh
         rioA==
X-Forwarded-Encrypted: i=1; AJvYcCVeCyh5bWdD/Ua6ZarZ2rtfhz0cko8BZN+f8B3h0zrQ+uK6OskYmlwbuaOIJeia8Himfyl6k4ukVAbh8iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfiEMT/VnzRnlEC6zhxNU7KjBtBNAhUFozyofYbpKECynZgh+
	RjnRDwQ3S9UNis8ScgS5UG4XlW1RGDTp1oeq8eCM1pAPV2nnE7/W5lqGWfM4j7tGGwFt2K0P20F
	xK9dnteY64XRNIMSblhZTSy9uYS8/dOwZkNtQWA+isfgYfYDEft3/NDuUrvNvFpAIHLo=
X-Gm-Gg: ASbGncvmApH371kwI5jfnGP73p+Zo+ycz9DoATXrBEKgyTLCpT5wm0L+bk1yC6YU2zH
	xNf+HtgRKmJQ3YB7uNP7kwXfShvQO0plG/7kN+PHPlRtgx9+N71vCECYO+KZZaIL/ZrEEp01w2A
	qI5whik4+BnWnSMa6aIoYGJ6zYVFA7B1At3dXlsJ/5ivkBKOKEsVOv48zeRxtjLDeQc/GqkbPEz
	a7KSCIbq3HYjIcT/v9Cl//Kut9V+wVOmMgcRh80T2aBG03BcYlJO8fJKIJZQz4wbMwpDURdoWYi
	DelbskvhSX644iyNLt8JpecqSpSPSD3pJG0qNffJ1z+p+4HierN7L9T60UFuTJYjQ1LdHMGp13w
	n2UNiwzLgT23ymIKCADIT/Xqc7qdjYFoX1iVsyUDAzqusIjNSBuzx
X-Received: by 2002:a05:622a:8e:b0:4af:f25d:e2b0 with SMTP id d75a77b69052e-4b10a9cc07cmr27540581cf.8.1755162237852;
        Thu, 14 Aug 2025 02:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5ndUZeYqkNWDQoj2EKZFvT82uY0VC8Cv2swBSR7P9JT3fLWisPRgnABIUullFaurpyb7ihg==
X-Received: by 2002:a05:622a:8e:b0:4af:f25d:e2b0 with SMTP id d75a77b69052e-4b10a9cc07cmr27540041cf.8.1755162237374;
        Thu, 14 Aug 2025 02:03:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cec11asm1720061fa.23.2025.08.14.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:03:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 12:03:52 +0300
Subject: [PATCH 1/2] drm/msm/dpu: simplify bg_alpha selection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-dpu-rework-alpha-v1-1-b4baa4ffa8fe@oss.qualcomm.com>
References: <20250814-dpu-rework-alpha-v1-0-b4baa4ffa8fe@oss.qualcomm.com>
In-Reply-To: <20250814-dpu-rework-alpha-v1-0-b4baa4ffa8fe@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iMJRmARhSb1qXSk4SUYiXVNL3suv0fUyow+jfxnnJDQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonaZ5C08EvEWaNICCToRqfci+V/llxHEZsK7d6
 VHKUWQyiSWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2meQAKCRCLPIo+Aiko
 1aECCACyvWUX7kkfk8qmbd/L2OFNGcQOvCZ5c/p3qwoUvB2bm1hsP8Ggmq3+xYl6tpyuNmTjgSx
 xLpBlujHfcCypZG5gRrjLcoCwaiy5ixvxUvUweo/kZ3eHHgIXQUPglVwY4oHBqgCWl4AEf1XT9L
 v/00spXJh6cfVYBhs+txtWUk5P1DIUNcccPAqcn8wskRcEYrzBpfQA6XZe5LAqN7Bhi/HeYhqfA
 /kmU5irHbeOX+C4Sq+nBdwZIxdqCD6ZRKpF42JPYXfN9tOb2wxJySN9FWeg0wHHqd/dRChrtXap
 waRolPzQ5Lxh21Hfzx7eg8hC+iSHSIxAR+xBGBwAMSWrSTjT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXzC3LPdilflbf
 YvUfxj6dyYdpnOdcn9Bs5btG9yDpEjYKJKaMwFMVsx6jbCqr+LSP19epR5h9qNFWnwZMchwJBjk
 LVqFvl04/D3DLVDIbx/5dZip5sVUmj/6wJr/Zs5YUgqprQ5XrZ66/cmc+sqo1QgpjKTQeW2uYqB
 ejSv4dvDCVqBRhVbBrw5Pp6ld+qvxo8GlxOKZ6fmZuPc5g/yFBdCo8Bj7Ov83QZiSl4t/1a2oB0
 RZUNs21UIdwxP4cZIHhITbQFPAXyJ4N9S7HlBsv7zBJ1EOcxgbClssnpxaHtD4gowH+knKFhCe6
 Uru6B0xLs7fmmEeCZlYznESewt7zOblhgXE86M/yoS5K+dP1p3LPUc9/SoY9vB8tzS7RhSG9Uqw
 5HLMHL4n
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689da67f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ID75BBqnTVE1V_rUnp8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: USUV-EEe2AJOi0qBZlyozxotVbiTDsbk
X-Proofpoint-ORIG-GUID: USUV-EEe2AJOi0qBZlyozxotVbiTDsbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

In order to be more obvious in fg_alpha / bg_alpha handling during the
blending programming drop the default setting for background alpha value
and set it explicitly in all cases.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index d4b545448d74657aafc96e9042c7756654b4f0e7..651159e8731194d75b52c05158bfd1c9bad8b10c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -335,13 +335,13 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 		max_alpha = 0x3ff;
 		fg_alpha = pstate->base.alpha >> 6;
 	}
-	bg_alpha = max_alpha - fg_alpha;
 
 	/* default to opaque blending */
 	if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
 	    !format->alpha_enable) {
 		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
 			DPU_BLEND_BG_ALPHA_BG_CONST;
+		bg_alpha = max_alpha - fg_alpha;
 	} else if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
 		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
 			DPU_BLEND_BG_ALPHA_FG_PIXEL;
@@ -350,6 +350,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 			blend_op |= DPU_BLEND_BG_MOD_ALPHA |
 				    DPU_BLEND_BG_INV_MOD_ALPHA;
 		} else {
+			bg_alpha = 0;
 			blend_op |= DPU_BLEND_BG_INV_ALPHA;
 		}
 	} else {
@@ -363,6 +364,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 				    DPU_BLEND_BG_MOD_ALPHA |
 				    DPU_BLEND_BG_INV_MOD_ALPHA;
 		} else {
+			bg_alpha = 0;
 			blend_op |= DPU_BLEND_BG_INV_ALPHA;
 		}
 	}

-- 
2.47.2


