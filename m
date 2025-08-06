Return-Path: <linux-kernel+bounces-758092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D634EB1CAB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF1D74E37A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A372BDC28;
	Wed,  6 Aug 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1ETTCVE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030972BCF68
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501173; cv=none; b=CIbeTXcoeNvr1rGyfzzS02Ph0/B2dc5/UNQ7Kl/zAXMyZvak/xhipBKq8xDOGVBOzEej2bD/YDQtPGRf3KWPLgytcYsnHqhghCi46cW0lYdur5Q1tJVmRVXT/0aiwpV63GI0BNbPAuKgy9Mk3aOhbO9Zhnmt5+++LdiWzxMvu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501173; c=relaxed/simple;
	bh=ISijb1E0+ZD77bkKk24Ne4W33w2AVxTmXoDiNWMIs5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZD1/3QS6qjiQ7DZYdO1nGXDkb543yp+pIFG3cbkYGSo04j1/rFOtnTkeTTLMJfhrMQ/mLezxJN0i3UPj40hp27/0ZLehLTgeY78vqgZN+ihItKNfJas8o+XbCpVYYL9mcAcl4sX7br2vUkW/UK7/QJxDJz+XksNeTPMb1z0TAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1ETTCVE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CtEw4031579
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 17:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5V4MfdEEJjF
	qpxnuJxY+w9W+JqTRsjaxsk3+BJSZB8s=; b=a1ETTCVE3M5VttGfMhCLvribLSA
	V4YlRLkXvHdLKyegh+w89ShSkseZsFeEU3LABX5s/QN+a5Gr5l9xBneU8bCPju24
	3L23tP2zJUvKmYeqraXw3oBhtCpPf3rm3LRZtwY1FkHHKQtu6cyRjj3atDddp3EQ
	zm1IIko37h2pG/INl1SpHLGs29wu7NgosGTwYSU0AVGiuSO5H+Ux1Dc3MFr9Gwt9
	B5FGrcZc+1WxNsOeA4PnhUXLPGNSHjGAlkswAm5cueZziRrEh/QHb6EB2Z6o/4yh
	rRrJkhkD5+sSN7CcxrerbMd4onb5CxSMJtOe3Bn20Qye74m7zuJylCDNgqA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybbkgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:26:09 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso302654b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501168; x=1755105968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V4MfdEEJjFqpxnuJxY+w9W+JqTRsjaxsk3+BJSZB8s=;
        b=xUWyPv6UiVc/DrDfoAboh/PecckcnpDselqidTDnxUaUS/4ak9nP1QaAXbw35RLF/p
         wqX6NctlPKJAvJIzDpZCZf1jS7F2269QOqEt1AF3CrsoPE6efSKJUOsb3yTvmGN3Vzs1
         OrlqZ2FEfeadkbczPHdPq6bHZCRWFNkVcLNy8u5nXOtkpkLD/LtS+qtx5z3Rn+sjG3sz
         1fNruu6yGd8OrcKmv2T1fkpFm0fgBua9rD8LGy9ddcSdkpOQmuTI10V/pE/7+Y1Ki5cg
         Jkky81BdeQAmRSsku4Y9a5Y8VwCj33aUYD8PSwGPaA2HnsSIgr5VV00ttcXbfHQoBHoQ
         up/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGA6ITU46kM9CIuYU3cBZKOfJ226Dkfy08URDgmmOy/uqOJ1US9f7c41WyPwNPW+rnc2GAfaKkpCj5uAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QcrhGESvE+uUnRTvHqoJ8CTeZbp9kFE+p9DPxoIGgsokAQG6
	T371QoBWP7DxSHmiG4bPaGw3/TCMYnc1sltcwMpGtrvGLNBVEUbsrX1Sj+JxMazv6el6rGmb1GA
	dDf4do6Ym/vp2ktJ/hW1p/fMWwNx5qA3DIsyApaj+rnB2gcLsHx1C+jb6WB93U2NFSa0=
X-Gm-Gg: ASbGncuItkNeLlMkztm5ueXKMVxjefidWh5LsN3v6J6GPoZTVpW0lDVIvIuujG/Qwyw
	hKdWKlqUbcKetuLCtRqKj7HXVpouLbKOmr4IdKqnUtUlQA5qbSaeQsebFyBbK06yDnvr+Wr29Xc
	CK4uf1j1a++ZH9c8xYCPVKODUyIFVtQ8L6UxlcQNFPOGEQsPLVW9TliiGcjmyfRpLPEvkS9J9FT
	J+R5k6tEt3nBVP2a7X2yE85DdhHfBi/vDKHllWxBsrDHNlz6OeuyZk+If3aaL7PlqtftZdAK01s
	WGkzozTRcvt2SA5SuklQtw2MtyvmE4CKuPBivfOgX3HD/HZMdFsn9/N++XDNWTBadgM=
X-Received: by 2002:a05:6a00:8d2:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c2b06edb7mr4844971b3a.23.1754501168281;
        Wed, 06 Aug 2025 10:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJeF+hA3Sf4UAVGOsX40s2DjOot938v+1PjGjJpA2MdTWEdlqDKL/EvOlgI7sVXx1RVnBAQQ==
X-Received: by 2002:a05:6a00:8d2:b0:76b:2c12:334c with SMTP id d2e1a72fcca58-76c2b06edb7mr4844944b3a.23.1754501167795;
        Wed, 06 Aug 2025 10:26:07 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f417sm15866210b3a.44.2025.08.06.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 10:26:07 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 4/4] soc: qcom: mdt_loader: Remove unused parameter
Date: Wed,  6 Aug 2025 22:55:31 +0530
Message-ID: <20250806172531.1865088-4-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX3MONQTuOfS7u
 bHk9epbCR+GA98liVzecDLftYNjbrYGp2CrOgfA8Qb+IOS5tQnNlmyE33cAW35eGpZc2lC3j1W7
 BXSTE5yLtkO94p0YzF/8xUVFcReDl0AWZIJGGx+0WrrsYBP+faHdlTiY5Ctu21q1g17hN3mRqhc
 GfLu7/W5X6cx9JePpTMCLObYGXYHZGHKS7DRXKzQn44B7cfOa+9Td2YsCgrVmAr0TKHyYTrOqMU
 m5RWHHb0/Rxo822GECRDNqpcFlgio+Uk4HAlOLzVmD23m98VQUHy6jaKzG2JhlkrWWdfc4lwlLG
 04OJbcwlyvxNa5+O2sa8ZsmD/ZZmKW0P0Zk591ujJqS8btUrWNkIfymdkKT2Q8ylt7u/riiws2W
 LP2w8hK/
X-Proofpoint-GUID: zsOmh3nb4exNxD6zX_JG_ExBvbpE2SLV
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=68939032 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QQi8RNdjS96tJPzaHcwA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: zsOmh3nb4exNxD6zX_JG_ExBvbpE2SLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
used in the past for logging it but due to code refactor this parameter
is unused now.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
 - made this as separate patch.

 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 145bd1374f07..8210fb3dd51a 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -302,7 +302,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
-static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
+static bool qcom_mdt_bins_are_split(const struct firmware *fw)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_hdr *ehdr;
-- 
2.50.1


