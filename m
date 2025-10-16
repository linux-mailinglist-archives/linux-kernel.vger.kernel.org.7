Return-Path: <linux-kernel+bounces-855992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CCCBE2BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55D3A4E2AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B2328633;
	Thu, 16 Oct 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGL2Ds+3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938B529CE1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610189; cv=none; b=mc6z05SE1gexYAeL/X5xSYHrf1uTxPQIJkz9XtoTfzAeVbAsw1LIqavLD1I0b5f2TAShV+C47C6/a3U/9f8MrlO3v63fYeuLiOy7dDXTp/kcIhD2DeuHvuXkYZ0WrUXH+GJMg2YHWKPFbVI/3nFa11IFKntgSzj2ofxsb1NCN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610189; c=relaxed/simple;
	bh=ro+tNF+gUAqZ+UpNx7ZFJ0yMEFEGbwRuWWjzDkixuhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUPNh6Cs0eifQI4lkHBBdFe2q+sxV9+CTdQns+DVnJ3pHaRrmOzF4WbW8Tj2AU52r9mpxu92JSwXfnwF6jx/OBsdWd4LFqzJ8heh13pYA2jookWqJral7EcIofseO3Dbd7EKxS4o/bnvHNEN0aoAPEkemRvxcVrZccz/41tosUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGL2Ds+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7W5AY002700
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sz8JUwUQh5UXAFd4fkcefV1DI1lGZM88sJMFZrZ0qqo=; b=OGL2Ds+32NCsDUaj
	wpNZcd52X1rY6Nn2q9Dk3ACpZLbDZC6NRBPHr8faGQzcwa8kNu4UCOKgzKW39Y0v
	NWRySSy/PDr7gFjUoflnpIZPN0yCH8r9OBLzO4sQ5dy96ifxW7xwZJA6ycmNw6DN
	+9Dfjphh6F0pdBMc8vI4QrdbUh1agmdC5jt/2dYg3XTYY7yDFIgJAwu/ocdgedF6
	ss+2vrei8qwZI/dQWR2PU7AYaTamjkRzEIp1uoyCAHCtfOxjrsH6nPNKc99yHdyY
	4NgZSRrsyCIHuw+goS/EFAy4v2YGmJrvmr1Rtb2tmR119X9yEvlnMfVPX0z20V8W
	Awdd/w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8fyh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso6981896d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610185; x=1761214985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz8JUwUQh5UXAFd4fkcefV1DI1lGZM88sJMFZrZ0qqo=;
        b=iaf9KPew2oZX2QhmLAsN5gVhXiwbwwGPOC/4d2A+wltgh71/EvwGMA5JNvdy4OQjLM
         U6RxELdVNMciCptBeOcjv1mG30TdoWIFk2dPKxxxFFJL5bcR1riAVt1Ok+MTCypkfMHa
         QLgaHnMuALsIx1mL7XxZUhFmhyRSdolQ4tvOp6Cik8dU7TogWNM/Kb/3KApczSyIL2Ru
         pFU+RAHxd9wWA4Evni3ma1J/GeTxD6g1WcQM0h5ZAnOcyij8N2Bcwnv9M+ttOLzZ+8RL
         wWWLDYOnCFz0fLrJ6gSUVx//JtNuh7ie2N2EvF2kvW7ruvoohMvgH1p+uArBty7hze5B
         6o/w==
X-Forwarded-Encrypted: i=1; AJvYcCW81tFmN0gZ7/cESk0o2Ovg/tGcb1zcbKKgLWKgRCyNZ9rvGkPSBY5YCVeFwJ/vF26CPHqvbCkRya6z1Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDwKBH622eWNtfDg8LaQdN4nPxWt2hBVW7D6O8yQh4ZGoagG5
	n+FSysd4h7uvTBY4I/VEb6Q8jFaDwhSeA12O2cb5ZdZru1MxNQLQqB3XUk/N+8Mhw+nrXQhTZd1
	wDgVQeMcUQ3HmWRGqQeATk1751fGcYGgxkr/Q0iRnefsWMM6UA8K8rJpRwQI9iYIkTt4=
X-Gm-Gg: ASbGnct9TosLTDlTYjeJXP8qNRoiRYKkv9gwqBLzeE2wd2O4K0sOxV8Zt5vjdRnW8x5
	xXacrQCaGHbhq77VHOzvLUjqVAAxfD/zeETil3BS+8VSu5qJMRiVqFWThHG3s2woC75iVpq+zXl
	2ybJWqsTqbgmmJxaxAqS3mgbFHVcY/BHL1ixcHjUxETfdM2by5Xxdz0EAKo423QTgE+7N7yDvWX
	zEA/HUL+RkE39PrZkGw3Xc+nYyRIXQJuT8zKZcVTNKWGNo+7so2Ex7hUZ/wNwpFn0HlZoSH3UHm
	EelFlb/GxTqut/O2LlociOLVlwqbbowID6QkmYpClivowEQlEG3qDvLiilGTUV2NyDYWc/jfWHX
	7z9ilwSGICzSoTDI53817cJRGwDBL8CK6c4pv3jdjpodUdM4Q45L+uA8hhYmnBMPc6Q==
X-Received: by 2002:ad4:5ce1:0:b0:87c:8cc:fb32 with SMTP id 6a1803df08f44-87c08ccfc8fmr58350716d6.18.1760610185322;
        Thu, 16 Oct 2025 03:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTJFx+oVKLOg4FXLpRTv11tFooje1MWrmp/PHF++hjRsaaMN4+0FjVwr9iijgyEQ6gyvtvwQ==
X-Received: by 2002:ad4:5ce1:0:b0:87c:8cc:fb32 with SMTP id 6a1803df08f44-87c08ccfc8fmr58350416d6.18.1760610184761;
        Thu, 16 Oct 2025 03:23:04 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b3ff9sm36777576d6.56.2025.10.16.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:23:04 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 18:22:44 +0800
Subject: [PATCH 2/3] media: qcom: camss: add support for SM6150 camss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-sm6150-camss-v1-2-e7f64ac32370@oss.qualcomm.com>
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
In-Reply-To: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760610168; l=8579;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=ro+tNF+gUAqZ+UpNx7ZFJ0yMEFEGbwRuWWjzDkixuhM=;
 b=uV3yTcD0NbAokIJ/7uHfsEHNrLNBTDyF8bjoow5be9PWQb3nQBqfA4XtKLzx15HuM2FJSuY6j
 sdc9WHd7PuADoF+J8kdSGPFibf9kZMmo+fQJdoFAW2ruhhAX9eN6mc2
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: NX7kbA3SEFmawVqxxzSs-jTlb8o68xBN
X-Proofpoint-ORIG-GUID: NX7kbA3SEFmawVqxxzSs-jTlb8o68xBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX0uzlE3mzUAvA
 BHAesAodDMMNtVuRGLlyTZxwabFQfPo+YgIUeE4M96CAuGWBvDHqf7g8SsE0CKb1qczLWaaiJ72
 e8+ugkQuHcC9+rcvv7T8/axtdjmDvjHlVaQDG9ywVbpxzS+Gma9VbwhfQ4R2Ymd9oc5M7YfvteB
 ISpKZzvmMVIgcOo1rzn2h1P1LZJgbhVak/pSoLo7caoXmdBhrlmsAp153u4h0iHVWh0m8XoMPR9
 6akEyAyZE2E7zaaVQaToha9hQZ4xmC+bfIhxfP+HO8q7tfhWulpvOlAexquND7hf8DFVDjRl5eb
 XgBK9KfhhWN53x+h4UBQsYH89fLlwPwKfTNHoHP6Wh9jH+rnXLspyiUUikvCKA4xWMRj0Ll4WT2
 1DuH5VIwHnWk2UvXKUjuoKMDnbNMBg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f0c78a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UIQITCPl_wy4yL0u-ScA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

The camera subsystem for SM6150 which is based on Spectra 230.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss.c          | 186 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 4 files changed, 191 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index a229ba04b158739ddfe4076bdd28167a309f13ea..7bc524a9c4bbe3a316e366868e9d636e58d5956a 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -908,6 +908,7 @@ static bool csiphy_is_gen2(u32 version)
 
 	switch (version) {
 	case CAMSS_2290:
+	case CAMSS_6150:
 	case CAMSS_7280:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
@@ -996,6 +997,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
 		break;
 	case CAMSS_2290:
+	case CAMSS_6150:
 		regs->lane_regs = &lane_regs_qcm2290[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_qcm2290);
 		break;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index dff8d0a1e8c228878d03d95aaf91f262b208f9e7..2ec796b6f82d67d7a1bc332a0d770a8185ba3fdd 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -341,6 +341,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 		break;
 	case CAMSS_660:
 	case CAMSS_2290:
+	case CAMSS_6150:
 	case CAMSS_7280:
 	case CAMSS_8x96:
 	case CAMSS_8250:
@@ -1989,6 +1990,7 @@ static int vfe_bpl_align(struct vfe_device *vfe)
 	int ret = 8;
 
 	switch (vfe->camss->res->version) {
+	case CAMSS_6150:
 	case CAMSS_7280:
 	case CAMSS_8250:
 	case CAMSS_8280XP:
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2fbcd0e343aac9620a5a30719c42e1b887cf34ed..51e2522d4d01dd7bb4581c721544835c47b09c38 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1318,6 +1318,178 @@ static const struct camss_subdev_resources vfe_res_845[] = {
 	}
 };
 
+static const struct camss_subdev_resources csiphy_res_6150[] = {
+	/* CSIPHY0 */
+	{
+		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
+		.clock = { "csiphy0", "csiphy0_timer" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 269333333 } },
+		.reg = { "csiphy0" },
+		.interrupt = { "csiphy0" },
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+	/* CSIPHY1 */
+	{
+		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
+		.clock = { "csiphy1", "csiphy1_timer" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 269333333 } },
+		.reg = { "csiphy1" },
+		.interrupt = { "csiphy1" },
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+	/* CSIPHY2 */
+	{
+		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
+		.clock = { "csiphy2", "csiphy2_timer" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 269333333 } },
+		.reg = { "csiphy2" },
+		.interrupt = { "csiphy2" },
+		.csiphy = {
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		}
+	},
+};
+
+static const struct camss_subdev_resources csid_res_6150[] = {
+	/* CSID0 */
+	{
+		.regulators = {},
+		.clock = { "vfe0_cphy_rx", "vfe0_csid" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 320000000, 540000000 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" },
+		.csid = {
+			.is_lite = false,
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID1 */
+	{
+		.regulators = {},
+		.clock = { "vfe1_cphy_rx", "vfe1_csid" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 320000000, 540000000 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" },
+		.csid = {
+			.is_lite = false,
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID2 */
+	{
+		.regulators = {},
+		.clock = { "vfe_lite_cphy_rx", "vfe_lite_csid" },
+		.clock_rate = { { 269333333, 384000000 },
+				{ 320000000, 540000000 } },
+		.reg = { "csid_lite" },
+		.interrupt = { "csid_lite" },
+		.csid = {
+			.is_lite = true,
+			.hw_ops = &csid_ops_gen2,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.formats = &csid_formats_gen2
+		}
+	},
+};
+
+static const struct camss_subdev_resources vfe_res_6150[] = {
+	/* VFE0 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "camnoc_axi", "cpas_ahb", "soc_ahb",
+			   "vfe0", "vfe0_axi"},
+		.clock_rate = { { 0 },
+				{ 400000000 },
+				{ 80000000 },
+				{ 37500000, 40000000 },
+				{ 360000000, 432000000, 540000000, 600000000 },
+				{ 265000000, 426000000 } },
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = false,
+			.has_pd = true,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE1 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "camnoc_axi", "cpas_ahb", "soc_ahb",
+			   "vfe1", "vfe1_axi"},
+		.clock_rate = { { 0 },
+				{ 400000000 },
+				{ 80000000 },
+				{ 37500000, 40000000 },
+				{ 360000000, 432000000, 540000000, 600000000 },
+				{ 265000000, 426000000 } },
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = false,
+			.has_pd = true,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE2 */
+	{
+		.regulators = {},
+		.clock = { "gcc_axi_hf", "camnoc_axi", "cpas_ahb", "soc_ahb",
+			   "vfe_lite" },
+		.clock_rate = { { 0 },
+				{ 400000000 },
+				{ 80000000 },
+				{ 37500000, 40000000 },
+				{ 360000000, 432000000, 540000000, 600000000 } },
+		.reg = { "vfe_lite" },
+		.interrupt = { "vfe_lite" },
+		.vfe = {
+			.line_num = 4,
+			.is_lite = true,
+			.hw_ops = &vfe_ops_170,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+};
+
+static const struct resources_icc icc_res_sm6150[] = {
+	{
+		.name = "ahb",
+		.icc_bw_tbl.avg = 38400,
+		.icc_bw_tbl.peak = 76800,
+	},
+	{
+		.name = "hf_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+};
+
 static const struct camss_subdev_resources csiphy_res_8250[] = {
 	/* CSIPHY0 */
 	{
@@ -4438,6 +4610,19 @@ static const struct camss_resources sc7280_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_7280),
 };
 
+static const struct camss_resources sm6150_resources = {
+	.version = CAMSS_6150,
+	.pd_name = "top",
+	.csiphy_res = csiphy_res_6150,
+	.csid_res = csid_res_6150,
+	.vfe_res = vfe_res_6150,
+	.icc_res = icc_res_sm6150,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm6150),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_6150),
+	.csid_num = ARRAY_SIZE(csid_res_6150),
+	.vfe_num = ARRAY_SIZE(vfe_res_6150),
+};
+
 static const struct camss_resources sm8550_resources = {
 	.version = CAMSS_8550,
 	.pd_name = "top",
@@ -4478,6 +4663,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
 	{ .compatible = "qcom,sdm670-camss", .data = &sdm670_resources },
 	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
+	{ .compatible = "qcom,sm6150-camss", .data = &sm6150_resources },
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
 	{ .compatible = "qcom,x1e80100-camss", .data = &x1e80100_resources },
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index a70fbc78ccc307c0abc2f3c834fb1e2dafd83c6b..b60556f2f226104adb48908bdb436f389fb1e1ad 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -79,6 +79,7 @@ enum pm_domain {
 enum camss_version {
 	CAMSS_660,
 	CAMSS_2290,
+	CAMSS_6150,
 	CAMSS_7280,
 	CAMSS_8x16,
 	CAMSS_8x53,

-- 
2.34.1


