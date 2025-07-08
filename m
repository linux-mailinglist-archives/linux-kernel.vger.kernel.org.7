Return-Path: <linux-kernel+bounces-722161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A7AFD60B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B44B1BC7042
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65C2E9735;
	Tue,  8 Jul 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfVhxTMy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36282E8DEE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997948; cv=none; b=Zzgs3sHfJwQpIaj9okNljVZjGdPFBw/j+jNYHmaoqncSPGuPNQ4ZH9jpP7mTBT+S3D3NP00v2FIJg6tzq8WCXseTFgvGUyEE+ITreIjYetJb86OQf8g3zYBstJx29kIE1kheAwMnmmIfQ/iZ8NYvvqyRSQ8xrHP2e+h63la4uMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997948; c=relaxed/simple;
	bh=OxNfsPbEJJVN+awzaENbdWaGNtistdBy+KfHPzGS4lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiNoODyuBgvnyTMAF0f5ECKdCO0sP+gr8OUHeKczvcQZAGOgE8N3HH9jatFhAwUiUzimVeC52Oj8JePm0s2e1tjwCwMQCo5QTjVd9KF8ijTdHeotzEMUuijPqTM0pO7gT/tpBGWhwTc7Ea6HVd/zpd0u3w+/dSjTkgbwqZ7gWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CfVhxTMy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAZga032619
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 18:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g/AcEZbY/3L
	hPC//AHj1l8zIdFMRt7GCdZHsFAjwcrI=; b=CfVhxTMyCMloVL52x+jy1ie/Nk6
	4EhBbLG3pKs4UE/hwxt0TxuCXes4k4tNEHK4iuWDToHfVbw1/ulHSa5mLxmWtyp7
	mSgtr2J+pbIIpQdGwwyDpcMwowduoVTHzkMSxqawXbK76r1LUTPz/91ZXDditEpX
	1uzd07OB2cXtEpgPkeuYKoJT07noos1YG6hi8C3Gs7ZZpwLEAYosJECZp7FvjOVW
	9Kt/UO1y4CF4kKdqGV4AUsiryzt8PCXeKBiNWUXfL33VDF3sP4J/f0lEA+IOxHCG
	3kLSS7xn7Mk87cBbRJ9gSyY6h/oavs/4bmTBRNEuZSMMCrMsmLyWQJojP0g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq338u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:05:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a44c8e11efso143578301cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997945; x=1752602745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/AcEZbY/3LhPC//AHj1l8zIdFMRt7GCdZHsFAjwcrI=;
        b=m20FEj3+D0I4NmaEN2hCf2Gri2F9qGKRQWRpT26eT87ggJsNAv2e+tXjbZmqIz0f7B
         hJL0DFHZT2edUVc4KTMyWp+puOwoIpmsqXW4GFAiPkBpXkN/WcYduVtRu+IZ7UViKJEu
         4oA+tNSsJdJ3m1XAocxpTT4xQ4P94XZIzeDN7AYlIkis6uhIm43ZLzIcyHJ3NrEktTae
         WQoJGCTg0CktEZmybiLHvuTGLLo2o+mdSdiUhkNikd8PgyprWmOoFjuTx710NOCeChBK
         eIVo9IRgU0rDfhbz7/GKZ5CkUJKMID7wrHBGEX56H+MGrUJbBRYv8yQEpZr3BG0A/PFJ
         jlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEm4dj9y8MMY+IEVyPql2rDnkWkNn9oW4r9P6s98cLmdJpdmbw8krQ12FrRrbYGqwDTqfv0xOpCcnBLco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtyw4tNaHzMXUklS40mIlbyIPrPojXW5p+HhZUlw89rSZ6UkSI
	v0D5YjlK/dnGxei+bjdAJuXr0OQSPnQak7UTPtHlAXXrz+8bcujv7px7yNhaAQs3wq/w17qFLD1
	aH/WdtO2wW60oR9Q2BsdJz+xga1Gm4nE9SvmUZhDhs6aMRk+24dSqQzTHDnn4tE019Pc=
X-Gm-Gg: ASbGnctCj0ZjOBxE2RNX5QXJZ2/bcCcETxnJp+o+QiXgdz7oalmDRExCl+ew4riSH5f
	GP9G/s6nVe1wvebWgW4XX+vRanBErUzuz3K+KOgO+yBbLmVctz3UTRqxKNcUNX5lMFJiDW0WQ8c
	NLxUislhDMEDHL4T15DT/Pj+Vqw0my3V3wVyi4/QSfxNZEIiLv3QXgtZCreAZMc5uq4XSKSj0YA
	fjJVQcTHIbrn7HYVhK7g8E0zTvhI836dZx+DpH58NlnCQUlpWPe/NtLMMO7xHDF5noP+IF043Gj
	jHKeiDD0pXLJrmC8z/d+r5h8rHsPgQAtzlV+w+VQ+vHs6A+7+nCfrSK3wEFjGOGZcGOJI/+xGQ=
	=
X-Received: by 2002:a05:622a:1996:b0:4a7:234e:6c00 with SMTP id d75a77b69052e-4a9964ac1b4mr275033321cf.2.1751997944358;
        Tue, 08 Jul 2025 11:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkMRM9KKBfHt3zmgrQce93lQ6Cs15i1fHDTvD9lJ6RJtXqxX1W18f2vx1jwlhNHD7f/t/16w==
X-Received: by 2002:a05:622a:1996:b0:4a7:234e:6c00 with SMTP id d75a77b69052e-4a9964ac1b4mr275032581cf.2.1751997943708;
        Tue, 08 Jul 2025 11:05:43 -0700 (PDT)
Received: from trex.. (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0a5csm13394906f8f.29.2025.07.08.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:43 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] media: venus: core: Add qcm2290 DT compatible and resource data
Date: Tue,  8 Jul 2025 20:05:28 +0200
Message-Id: <20250708180530.1384330-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MSBTYWx0ZWRfXyeM+izXs+xpE
 qQ0ow+c7eWYpEzAfLo5iIxXr6+MtpuzAClkx6/bCFkzFDcPydxu21ckn0LfV1oypn/qBbP+f50X
 zat1wXBu5v21UuBK7Ca0B3nUs/xF1/S7nmcKh/Y8MhOIeuArxkStrV60dCl3caC61JJiHVICgLh
 cKxW58c+CepIc/qM3zgqFyXvJvSYj6MH02pVtwl5wARzHaWvJKfkgGo3vayu17FAQjzc0t4MQ69
 m8BjyrOjxp0vrQmHuzN5EYMFl9DaX+GvOq3N0Zv65sGck9JwoL1zJY9kEvZ6FO7hT/ETS56kWZH
 8NeEa2829FwVcJ7rrwBkKj6LZdlB2Yh4AS8sXvZQeFwuitZ0hsNjpzVW64D8IcJC/0YUPSXTABc
 KzWaYoLmoXIt1+ZOGgCGP4hSYmXbXsKOjlk+2bvG5QBpSE6zqvnifQbdPJuRpluG7cJtGVMA
X-Proofpoint-ORIG-GUID: XFoGA-2_f5wB9YpdIxdLr3IUksgojXoK
X-Proofpoint-GUID: XFoGA-2_f5wB9YpdIxdLr3IUksgojXoK
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d5df9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ykJq56P0K5uy9zAsI_4A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080151

Add a qcm2290 compatible binding to the Cenus core.

The maximum concurrency is video decode at 1920x1080 (FullHD) with video
encode at 1280x720 (HD).

The encoder is not available to firmware versions below 6.0.54 due to an
internal requirement for secure buffers.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index a4472cc2088b..a486115bbe57 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -1082,6 +1082,57 @@ static const struct venus_resources sc7280_res = {
 	.enc_nodename = "video-encoder",
 };
 
+static const struct freq_tbl qcm2290_freq_table[] = {
+	{ 352800, 240000000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
+	{ 244800, 133333333 },	/* 1920x1088 @ 30 */
+};
+
+static const struct bw_tbl qcm2290_bw_table_dec[] = {
+	{ 244800, 2128000, 0, 2128000, 0}, /* 1920x1088 @ 30 */
+};
+
+static const struct bw_tbl qcm2290_bw_table_enc[] = {
+	{ 244800, 2128000, 0, 2128000, 0 }, /* 1920x1088 @ 30 */
+};
+
+static const struct venus_min_fw min_fw_encode = {
+	.major = 6, .minor = 0, .rev = 54  /* encode min fw version */
+};
+
+static const struct venus_resources qcm2290_res = {
+	.freq_tbl = qcm2290_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(qcm2290_freq_table),
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
@@ -1092,6 +1143,7 @@ static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,sc7180-venus", .data = &sc7180_res, },
 	{ .compatible = "qcom,sc7280-venus", .data = &sc7280_res, },
 	{ .compatible = "qcom,sm8250-venus", .data = &sm8250_res, },
+	{ .compatible = "qcom,qcm2290-venus", .data = &qcm2290_res, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);
-- 
2.34.1


