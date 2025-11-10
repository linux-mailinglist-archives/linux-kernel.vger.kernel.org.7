Return-Path: <linux-kernel+bounces-893755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80404C48426
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99A13AB897
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E432FC866;
	Mon, 10 Nov 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pefX5QbF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gKu619o+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5C28B7DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794688; cv=none; b=hp2MjY9Q9jPVyhT9naPtYfFNLUJBBiYAKSqKeYXP8+1Xq7dkP0rT65dH2RfXDCPxNigRPIATl+Yq0E2KzgTxql2/ScLEZZ1hAW2WQj8CPNVEFoP1IIEXvm6saaDI5gUN/ojeFMLlvBmV4Ug/fvQrxFrpus7705mvvsk1/71Ej04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794688; c=relaxed/simple;
	bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWVtRBRtfY0L1kPYxtNULl7SLSbUbMl75wUpF+1Y0MuLsQ//ngzbtwNmQA8QCeXTtIMD2r29awv7xesTGI4lxnrSS+htcz3mRAQBuY/9xEYtEuNl95h1RSclpks/POc5Q5982/hl0fkHBBnYA24Dc8LR5pvJmR8NQVJNcIrbooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pefX5QbF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gKu619o+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAGYNEI4070794
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=; b=pefX5QbFhFPxMWvq
	WEqX56c2bZF/NoxpQmnZAWt+Lkl02FkvcTAAD9ENCMOl+gw+syWgArhpcatRaVhz
	OsLx3+5UGGqGP6R4HIkcKSErnvRAi9C70jhwOWWFmsthUI6n+4BodjkgylCjZWjg
	JV2sBIsricxd2Jzi/iKtTEPxeq3fLTh2m7UYRvGVEyntoCWkYNiqJ/T/9J7nS7l+
	NUBP0qlH0EIDVg1pCVWKs5ZgD7c+WZGYCqgLV0kjXGXC/JJJRdLN2fI1ybHHiJKd
	cnTnG14zAxscCkqswdUccF4fNv5g9EUmqg49u8aCIgtxvTM4IQKoxvcbuAiVodIc
	JbU6lA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abkpj84ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:11:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88947a773so83473361cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762794684; x=1763399484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=gKu619o+cA7AbBtn5p2+XXIKKKdK3h/LGjTBasXz7LKbhRpJ5g44ReHMKtCZJrFBuM
         HWdjhRFnxMLsnMAyn2e3WFHiX/LPuZWUyl5dR3BOKfPoXPeoBgLPrqvGJRVeuZr1E8CL
         scQMAN8LIN8XoMMtCZmoNyxZIvCMlPfZ3AZPZDsO8mzEEQZvSSa74HfFayjf7hXcRyIu
         Nb7vcDAnFWeobz3BW4hYHwj+GALUHVWd3ibFyctXc/RXLSv2eUsFkCTR5v9cXY4WGGcC
         Sw1IczfL/Oc4ZcI/a1Njq2EY/iHRctdyYA3ilPyJLNINjpqvpwO+LZ0vttkCezBEcdgf
         NJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762794684; x=1763399484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U76nAoGUFZhSMgN3LNNB9B5figDIPjE3gLJdeoHmGms=;
        b=RYR4Qdn6ion71PI86iM3ISICTg1T1TtdrTMzSincXIFOtajvBFG71IMDxbnAFMn21u
         By+fVErvsA0r1rrfPiUu8qtkhaVVRByRNNfBtXBAX7QnkViifyre6KoKjTXX2RioZqeG
         ckzIC6lCT2++JGkWMFumeCqYEcU92QKDy1fidNY6m8zBB4wWKRKvNdpxW1IgdGbWttXL
         b74sIrb86zhR2JFKfxja/ktxYErOCEeuQn1tRDGW3GZujaRCEZ2VaNw/bK1iQwx21EEV
         gaX6t8H/6fkwh12mAXiNph39f0gS48OXar/S603giomKAuRSe8ueGZsQMrHvDVYNMEPC
         6D+g==
X-Forwarded-Encrypted: i=1; AJvYcCWcHKsDSELGxR6nSxaRY3kn8mW+vL7gQzXdw1kGy4olMT4+71jc0Nog1J/9qj42UjdK1s3+abYT4jFVEmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWS9pbp0I0KNNSEkwUc/nkMkZ2ZP3LjRUAtTcr5L8LqQ+nqZT
	0gl1lQ9rMeMZKoE9XUhTPtrGGa9DYEF8a0Lf8O1peoYpU/UrhI1Brs1UTvgbCsrgYhHepVvDdn8
	OzFmRQe3a42PJpvHkwzeSg4bDYMI8cMvdp2QBx9c45kKcGN8J9Yk4vDq2TGK+3XPV9x4=
X-Gm-Gg: ASbGncvL6F4YBNbmdDhQdGkYPZ6cbYiQJR9OZPGfUU/gtjr1PLy/2epRrzaE5E/xi1T
	UROkV3TlyQ5KB9OcDyPbO6B8CUddGQAtyjvn6pdfqPB3D7wCVSunT6FEL8SmY8p8F68ElVQQM8W
	GqKVIcnipn23RAtTlYh4vHeeXZK4tW/oC1+ka1ScncENouFCXbvoe1KqOmpikrgni340odXqAwI
	f04xVZ6jUvQWDLhK6oU3RPenlmbkNFOLRrWmLQssgw4A5f4jljFIXfqLdIR/+WRAJQUx6APkqwT
	PINPY0Fx4ze2cuSuCZe7CCWr0XVVd+k8IYkl69N798eHRkTe4D/ULXoVgikiTkzEC2H9Y0K9fV/
	gOIBRl/dqjW74WfSMpGQFgmw=
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr12379101a91.11.1762792704047;
        Mon, 10 Nov 2025 08:38:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoVMuhMcPsQUnqMT/Oy8cOyzF5h70KIN3Q83LoJcFWHaGhmdTuOn6UcLQhDffxl/Uu5uGmCQ==
X-Received: by 2002:a17:90a:ec84:b0:340:b86b:39c7 with SMTP id 98e67ed59e1d1-3436cb91cdbmr12379065a91.11.1762792703541;
        Mon, 10 Nov 2025 08:38:23 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:23 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:08 +0530
Subject: [PATCH v2 02/21] drm/msm/a6xx: Fix the gemnoc workaround
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-2-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=1529;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B0t21POhzhnkPllkO0aJhsfTVayUVxYvYda/rajz62U=;
 b=5LGxm8q7C7nTAl599JSjm02h9F6JnfyOhlzuY9M+RH/QtTw4F1E31ZgmBsJOxt67zTsOJpNGK
 U43gtcuNh5UCTjwVDvswqSwaglhNGbvuhplr6cbwINEpI7UGgZnf/qy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 32fawLyQpXd0eV6phlexeHBspeFTb1f6
X-Authority-Analysis: v=2.4 cv=GZoaXAXL c=1 sm=1 tr=0 ts=69121cbd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gggc3m2WwWe7Cuz57AEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 32fawLyQpXd0eV6phlexeHBspeFTb1f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NiBTYWx0ZWRfX/+R4W539nJeT
 UQPx7FRB6sZrv8nqQAoPLaccwTO9CVfNvKq6Gyrtf+uvX4LljWuc5RpDsxTCc6LOzW/KF/OE0Uz
 QGamnR/U/4O4PNfOOmxAS5in/HFJSgs9T5tS/ae2OT/eh4iI9GeVLWor5UubcxUxe66tyWpYU03
 WeB9JejDiJaFqf2+BGxQc/If8kuv6VFZYbpUCk7ki1WF1Uvfrk20ZBWOOdkPyOm6WcErd27BbFO
 TXEF84O7Hv0TAgsIkhj5P7CuOG/00XGUWmfwv1Qf42tMbLVedjM93SaosD2LKFfJXhzmWATSbHu
 oGgc72Dlkvw3DqjP6zy7eTYyiTufltMJRzdvMqAOx0pabJUmnBBUz4+WyHKXZxKKMc8iVPr83LZ
 oR8IdV0LlRfUTtcZsy00I5QC7BoHnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100146

Correct the register offset and enable this workaround for all A7x
and newer GPUs to match the recommendation. Also, downstream does this
w/a after moving the fence to allow mode. So do the same.

Fixes: dbfbb376b50c ("drm/msm/a6xx: Add A621 support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 4e6dc16e4a4c..605bb55de8d5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -485,8 +485,9 @@ static void a6xx_gemnoc_workaround(struct a6xx_gmu *gmu)
 	 * in the power down sequence not being fully executed. That in turn can
 	 * prevent CX_GDSC from collapsing. Assert Qactive to avoid this.
 	 */
-	if (adreno_is_a621(adreno_gpu) || adreno_is_7c3(adreno_gpu))
-		gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, BIT(0));
+	if (adreno_is_a7xx(adreno_gpu) || (adreno_is_a621(adreno_gpu) ||
+				adreno_is_7c3(adreno_gpu)))
+		gmu_write(gmu, REG_A6XX_GPU_GMU_CX_GMU_CX_FALNEXT_INTF, BIT(0));
 }
 
 /* Let the GMU know that we are about to go into slumber */
@@ -522,10 +523,9 @@ static int a6xx_gmu_notify_slumber(struct a6xx_gmu *gmu)
 	}
 
 out:
-	a6xx_gemnoc_workaround(gmu);
-
 	/* Put fence into allow mode */
 	gmu_write(gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	a6xx_gemnoc_workaround(gmu);
 	return ret;
 }
 

-- 
2.51.0


