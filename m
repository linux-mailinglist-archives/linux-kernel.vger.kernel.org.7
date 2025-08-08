Return-Path: <linux-kernel+bounces-759962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BDB1E4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3753727C39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781D2741C9;
	Fri,  8 Aug 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pt3yZLAr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290A272E60
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643198; cv=none; b=Q9cyH9DZihgDNN/0cnA4Gec10iraS/rGgVlOtr36biEnttapoEXXPMyLBKepzTBzAQT3/YwtmaFVLBi49R09vIa25F1/64BqyXk4VzNuwXfcnAo/wd1ofUNsmGIhm4ASrjyQkF8bJN8KvKx5AH1M0kVSnHzvNdCCOnnB95hxaS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643198; c=relaxed/simple;
	bh=dARtMRs88U+SkvksFaX/4ibKTv2r3ZxeZPWci1xWpd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpvwlZ1i2DCej6A0pHl8Zn7TyAbRmG4H4/tupga7wUeDMMW7x1jFc3i2hclWLXL/9JwIfPHyR0FsWVBa3J4IxHDJO5vIrcp+thO5dCYfdJiW6C0WPyT/8g9hkIjCAjMZXqWA6F0DHlrr5WE8Bl+/yTUjKP5dChz04Pl6f49qVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pt3yZLAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787UXLJ024747
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gdpKkg3HGmZ
	RyeizFHxrsWvpDDfvGRJLvLm05RIe+XY=; b=pt3yZLArRw1Rm/5ncIPIb0qsGfe
	Xl4zM5tuvTrctyIr1g6i9vhW+PTOSy0tGU7pznkOIN0XIfitjU1Shx92DDOnD0IY
	rGW0Cb5sfiOzvDmHaRk+OBS6Vja5U1J8AVIaehXgKrX94UkF3kI0koUzqB32ptTT
	30Vf1VfsXVJvPy+cKwMWGzrD3VSDcUrGjUDdKaa0Kdg1dHK32SRkVM4VgFLNdeMj
	ucNd+xeRz74vK2iexyGFhZZi1dKxS91gsy7BP47MOWXPbYnsgqAFRWn/o20y1d+x
	jbMC80p0hL7KAZHi8ftpqmngjxIyEQVpubALAqCunxagD4wxVj8dgnvVzqQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1h8ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af156a27b1so68953381cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643195; x=1755247995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdpKkg3HGmZRyeizFHxrsWvpDDfvGRJLvLm05RIe+XY=;
        b=HN95GAFRhmPt6WAfLK5MkUmUDimYropt6mQst/haQaDZXhnCHEfGfUQwVBk+2xL+H2
         oHsKDp/nJoTAu5x1u0WcsMza8wMTA/8BuCse1GgrsGvMaKqYPTzM5GsabLTBVSz1Q6Cl
         A4AfrjN3y4e9Jssqe32kPaDN+wjglZlqJQcmM3P9GlCwO9Lvbas+LxcHf70YJwDDDb+d
         O5TmaRaOyCNDOre3hTjRfHjDTeJmPBd1j6bwmieL98OM67H8fwBqTJjg5TdKgChNWDhW
         hJ5hgdFHnQO/akRQ9AhNZMwzQwZA7RREf5T9s0MLP7zaalc7uLo9rlz8f0hJsCLqxOOd
         xWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNG0NG5HDRyBVfCt+q8Cibc84GN2pQXEvC8yHEnBgd3v+bRlsJFDR1UGWMLLn/03Ga3QhfKGCJ4JuLxhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EcNAvZt7Lzg8UoTF5HHnZFWc2BM3Z2G3skuDfestd73kmwcp
	KGsf+XShSs9I+tE51B+PH2oHHoc468FP7Umc/H8/w5CDYLeIUANUUkf/5/ziHJCOcc4SYamwf+n
	9ytPkXnA8PjLaD94e7NpN9bYyNmIpnrs9fiU4jb5aPNrnxghSlbOnO2cGy2Tbeo9i+aI=
X-Gm-Gg: ASbGncvXL8+263UNYMPbuEQdtlnbROoLJnpq95uwyIEgFBrYoc6mEEaLcV5bfS4Zmty
	W4Q09HlQVJpWCMdFbYChtpJwct5+Uh0wJPSidmusOs8s0OPsQd3y3FItB+Z2Q/+mFS/w4iNPxAy
	tSs/uo9Gvfj+IR6VMmF6/txR6yG9qYN0geNbr78B56GyLAEQ7iE7a0NB6EibJZasTLwCLFC5uz5
	MhyeW2fnzSateiwkAj0jPNYg0P3XMAwzy4AsSGvsrQXLfylmcXdL7l7ts848BJ4DjTMVpHZFHEv
	uBhtsLds294C2WWoWDCoNrCYWoOiwz90ZsTGH4zhMD7yNNcaqy/zF9EkDGtl2vWTE8egJ73idwx
	cR2A4/sSTXPvt
X-Received: by 2002:ac8:7d46:0:b0:4b0:8057:1de9 with SMTP id d75a77b69052e-4b0aec61344mr28874291cf.3.1754643194910;
        Fri, 08 Aug 2025 01:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUlMx+GGWyeBlkXQITSAYNbhDzsTQUUeJlNFeViaKa3+u63HbQcCdHN+GInBsmqD4n9/6wA==
X-Received: by 2002:ac8:7d46:0:b0:4b0:8057:1de9 with SMTP id d75a77b69052e-4b0aec61344mr28873901cf.3.1754643193925;
        Fri, 08 Aug 2025 01:53:13 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:13 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/8] media: venus: core: Add qcm2290 DT compatible and resource data
Date: Fri,  8 Aug 2025 10:52:58 +0200
Message-Id: <20250808085300.1403570-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX2bBHY/xXmtGR
 CyN0jrJkC8j5HhFAsokuQ6nyKD/0RJyaj1wBdsyy/e2j0wxhGlXr+yYRXJhHNEN87/mk4TRvPWy
 h8rQMpu+w4aFtwcSToRJx6uCjLcvhNS+ygjUQrtvuo0HVuT8hsy0iTtXwSDA/S9dxGKDqmd74xy
 SUPG4DTOCjXQk+7z0r91hyh/eO+wGoox0URlW6QYe85tzri9o/YsfyXaDfpH2+688kN+mS7LZph
 jbqj+NUchwTGtEKS94RqCVZDrlFqW+3H4qcztq6kMupD8+PT2SIB3urFF2w/KE1EuZjVBPZ3YLl
 0yFAYQsqbfHXZP9GVjhiThYOjsD/Ps4+lhDve7d0EtrWtfW80Iooq3EMrSLzF4oy0SGNBkiVnPA
 GCef909M
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6895bafb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=5fA-3PHwp7xA7VOvTvgA:9 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ij-CTt4JAOYMU60ThFm7EOOkO7aWB4C5
X-Proofpoint-GUID: ij-CTt4JAOYMU60ThFm7EOOkO7aWB4C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

Add a qcm2290 compatible binding to the Venus core.

The maximum concurrency is video decode at 1920x1080 (FullHD) with video
encode at 1280x720 (HD).

The driver is not available to firmware versions below 6.0.55 due to an
internal requirement for secure buffers.

The bandwidth tables incorporate a conservative safety margin to ensure
stability under peak DDR and interconnect load conditions.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.c | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9604a7eed49d..a7c960d1d818 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1070,10 +1070,60 @@ static const struct venus_resources sc7280_res = {
 	.enc_nodename = "video-encoder",
 };
 
+static const struct bw_tbl qcm2290_bw_table_dec[] = {
+	{ 352800, 597000, 0, 746000, 0 }, /* 1080p@30 + 720p@30 */
+	{ 244800, 413000, 0, 516000, 0 }, /* 1080p@30 */
+	{ 216000, 364000, 0, 454000, 0 }, /* 720p@60  */
+	{ 108000, 182000, 0, 227000, 0 }, /* 720p@30  */
+};
+
+static const struct bw_tbl qcm2290_bw_table_enc[] = {
+	{ 352800, 396000, 0, 0, 0 }, /* 1080p@30 + 720p@30 */
+	{ 244800, 275000, 0, 0, 0 }, /* 1080p@30 */
+	{ 216000, 242000, 0, 0, 0 }, /* 720p@60  */
+	{ 108000, 121000, 0, 0, 0 }, /* 720p@30  */
+};
+
+static const struct firmware_version min_fw = {
+	.major = 6, .minor = 0, .rev = 55,
+};
+
+static const struct venus_resources qcm2290_res = {
+	.bw_tbl_dec = qcm2290_bw_table_dec,
+	.bw_tbl_dec_size = ARRAY_SIZE(qcm2290_bw_table_dec),
+	.bw_tbl_enc = qcm2290_bw_table_enc,
+	.bw_tbl_enc_size = ARRAY_SIZE(qcm2290_bw_table_enc),
+	.clks = { "core", "iface", "bus", "throttle" },
+	.clks_num = 4,
+	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
+	.vcodec_clks_num = 2,
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
+	.vcodec_pmdomains_num = 2,
+	.opp_pmdomain = (const char *[]) { "cx" },
+	.vcodec_num = 1,
+	.hfi_version = HFI_VERSION_4XX,
+	.vpu_version = VPU_VERSION_AR50_LITE,
+	.max_load = 352800,
+	.num_vpp_pipes = 1,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.cp_start = 0,
+	.cp_size = 0x70800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
+	.dma_mask = 0xe0000000 - 1,
+	.fwname = "qcom/venus-6.0/venus.mbn",
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
+	.min_fw = &min_fw,
+};
+
 static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
 	{ .compatible = "qcom,msm8998-venus", .data = &msm8998_res, },
+	{ .compatible = "qcom,qcm2290-venus", .data = &qcm2290_res, },
 	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
 	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sdm660-venus", .data = &sdm660_res, },
-- 
2.34.1


