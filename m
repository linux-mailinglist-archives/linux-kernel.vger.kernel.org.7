Return-Path: <linux-kernel+bounces-732517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D2B067FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643994E7406
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F12D12E9;
	Tue, 15 Jul 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ead4W02B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A652C17B2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612489; cv=none; b=aTfHZdEyd5mBzTbCc4R3qKYYQI5p4gLud9SISrEkWTRW3Be5V55Hnv+5U4iyB6P3ThkwJ+aAPG+BFo0IQ8hRlR0iJT/1n4WBdYkVgGtUA6gj5lEupVjGLjfYMRxCHbSJPpPvwSbtPohmWE3NPxNbp1siQpQ4y9mg3ruo+cJnmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612489; c=relaxed/simple;
	bh=O5EiLgNoX4zrnl7zUWRTzCuo9dcfSMTokUeXVORx29c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyGcZb0h/aosLvm4dh8d2ixRBWmciW6mYvWZAWJExPaaOf4zbwc3+Kv6KIzXnyO5c7Piq+s4Ec3860uFSq8+uJxTi6/crp/mw2WULcFGBMGUN8ura6I0g6ZY/4WO3Xb7sL6M8jrUCVrblGh3/vXklSgYnWzDSyIg1AGXXRaMLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ead4W02B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDKe5026152
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yORvCYEbul2
	A41whH+/fjglHUohPhim10fqgtAyMY+c=; b=Ead4W02BGzCyyT51ir5/+OtzIj+
	fEauq1Bl1OZa4SHuq2s/A+doH6/wUaD28CiMwf0Y2RETmd0QYc34TC70KlJJPRMb
	1iswUyDLNl53t4tEPBzZWw7yPBgA6plgpw5fq47xTOErDVk1ddIVy9Z4qoenuENj
	Zkw8l5YEFklhmmeyCSSkDyYi5q6AAc2Pclde96Lhj3XSV7tbQCpEGNr9LIYW2EPR
	jIeBUPEa0C+o14+V3mhC1WoAbLfi5Z071WBoPQJnTAN/oyY7EKIc7SwzBOgxwAph
	JJ+Z7vha/Mccq/g3hnzT8NPy1+0TIY78/INGzu7ewK1KPzBTEgCExrJLjFg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca2ugr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e095227f5dso577069685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612485; x=1753217285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yORvCYEbul2A41whH+/fjglHUohPhim10fqgtAyMY+c=;
        b=p/fkL8jCq8u9z4jsZs4tmVTsieEkBZs9ktW6K87ZFWtJYQcu5LvR4xeoQMSgYXzY5O
         DnzgG5+0uFdCyZddxmmI/u2yUO5dHE+ooPhcw8gNmmiU1GhMJ5RxUTkcYp7rqWdGpkpL
         0a9tyXv1u4np1VCE9fn4s36rV29L9hTKHGvIZbUK0dsWC8zb0SF1NkyNxIzW5iAddTfq
         lE3rkQra0qXKhA/7MyPSdv68voBDi4oKIQcQi8TNK0pq8W4TU73TitbT8wyCueGCn9h4
         RScLYBJEUpu6aUn5kekkxgrHagLjk3cNo1hyjp7zlD50M2h3HgngaHiK4NR88b9KKkI1
         Zlfw==
X-Forwarded-Encrypted: i=1; AJvYcCWtIvKe41/VrvY5jNAJIXziO47Q2Mc/K8MpTTDErO15L2uvRa7KvAMycS91145F2WOxC6aI0SMvruRetc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RG4fYSFvtGlI+hMzhXCTjmn3dxS2rRne2j49xX5y54je9uIk
	+3sg4TxpEcEXoaZ3SuPWFQGCRGsJ31h2ZUi9Lkt5DJroURgb3ihlqIoNKZjU9nvX1MrHT/drkcR
	YsRXER0xVr+p68oU1btaHKwDT9DTEXPQ/b8Q/d4AIdEjbFSmDIxV+QIDr9ni4Emp0N0w=
X-Gm-Gg: ASbGncsaf6iN1qmzHtzsCU4zoxt+0l3O7N77JOqSyoBDVo54v2iE++5oNxIpmm6lqrP
	tpegdHZRv9no8xE9kf8w3pGjIjlhnivIoliyTZUxuGmeAxqDv59xrJflNkh10sfWxLJ9Zz6mjOv
	qr7oRnniYEUVH/PxggBbni3U2ua0/30NaQZNiOHsDR44KvRjlda4S9ohC1z+hLCqkKpfKzobF4K
	pBV3cFH1PryiGHpsRFxBTIYMjOb+PezssrjqHKD5LNzDZYRtuhSTS3aOp3TrAWq+Jj9cO2re52x
	YEx/5OPr0ylzRRwOiNPpLFi4wUichsriFNRUFz9A80YpfoOJJ6eKWGslN+CLTTBY1g13nm2JJSH
	V4crUUqMbWH/12ZFMew==
X-Received: by 2002:a05:620a:170c:b0:7e3:2d1d:bda0 with SMTP id af79cd13be357-7e342a5ee77mr82162185a.2.1752612485411;
        Tue, 15 Jul 2025 13:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeyFhb5+mniM5F4l13WS+hafGISjrNwouIiQonRZXe9PQwVEv9wtSbHfDDjPFl6t5Rf1nwXg==
X-Received: by 2002:a05:620a:170c:b0:7e3:2d1d:bda0 with SMTP id af79cd13be357-7e342a5ee77mr82157885a.2.1752612484855;
        Tue, 15 Jul 2025 13:48:04 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:48:04 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/7] media: venus: core: Add qcm2290 DT compatible and resource data
Date: Tue, 15 Jul 2025 22:47:47 +0200
Message-Id: <20250715204749.2189875-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX/Rcernjt0jXk
 mUEd24CwDkkR2hIRe2BddUfDXP8Gg1YQiwkD4VtsIRNkcFVmRMSmJVpj/7265yDO8O+xLv4VE9N
 VAvA4/U2yTKAbLc33R6SMnbuFJJcUx4tWs1FYyNq7Ch425V8w5negjjPkzY6Lt2oRkKoCGXps1J
 v7MKxtowdLVjMse8nem2Y6WCQiZyOk3nUHI22DOAzG2baqv/hydUUtzYMg78CxAwcO+tYPlAS4b
 +LJ6aarkW9R2kXBsEsd8/VB5ie9cWaZ0ERr4nWhAcL9myIuqFBptKUqqBUX9YRt031mAAylrv36
 lpxqBdo0VCIH+M+u2XyjUg62YmAC3imMvEP7AV5gdItkqAV6JISy2M1wiNQD1fOkJIYefDjD2Cc
 DHdeFd6cSGwxSRhDbzN94kFOPVsHehuiZYhz3yqNKlLMwyt14drEOmYJzOk/rA4OOfeQPHm4
X-Proofpoint-GUID: KWGzRJ50JIgDBXWbHEpOQBJHorRTMi-7
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6876be86 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KS-C2OkT5QpsyoF3dlgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KWGzRJ50JIgDBXWbHEpOQBJHorRTMi-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150191

Add a qcm2290 compatible binding to the Cenus core.

The maximum concurrency is video decode at 1920x1080 (FullHD) with video
encode at 1280x720 (HD).

The encoder is not available to firmware versions below 6.0.54 due to an
internal requirement for secure buffers.

The bandwidth tables incorporate a conservative safety margin to ensure
stability under peak DDR and interconnect load conditions.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bad49f0b4a77..2c9e2e0f95f5 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1088,6 +1088,56 @@ static const struct venus_resources sc7280_res = {
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
+static const struct venus_min_fw min_fw_encode = {
+	.major = 6, .minor = 0, .rev = 54  /* encode min fw version */
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
+	.dec_minfw = NULL,
+	.enc_nodename = "video-encoder",
+	.enc_minfw = &min_fw_encode,
+};
+
 static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
@@ -1098,6 +1148,7 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
 	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
+	{ .compatible = "qcom,qcm2290-venus", .data = &qcm2290_res, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);
-- 
2.34.1


