Return-Path: <linux-kernel+bounces-831432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D6B9CA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD73327690
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B562D24B6;
	Wed, 24 Sep 2025 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPuGP72A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA852D0C7B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757060; cv=none; b=mLHJpKNHfnK0+TzPUnSjFhgG1TpUslaxLmFw3dxr/Zhpgf7wgBdytdheQMosSflVuJZU0Jn9f/11lXkOBUqa679hlA2qYkh1E4UoBgN0/GlC+Jq2whbxd9JYwu3RS4YUd5ZDNmzpHQ50iqMyE/B7HxjwZykbwEvO2DSaIVkmEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757060; c=relaxed/simple;
	bh=nx0dHtwCuHPuOqGztNINoB6tkECO4h7844UgsOU5S8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a66WCwBcwtfNqQ85LI/8rM1zR4P86HDtDwkDXLoiIXqe0rlTnER2JpD8HkxI5SfJvEYHKD7hd4FaS0XzDjEF0S2lKBkgJbFCKIeKhDgDupZsnf675YuuJpOZ1U6jB6XtugF2tbsIURZwUIziNWi/FFFnLgIqxMtieZahd/Y++dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPuGP72A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD8H79019945
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nR7RgImdeuGECfm8oEmT1uV2KbxxIPWin03Qltlq0XA=; b=KPuGP72APXf3DpDW
	2Jf95yD6XEzRnOm6letcIDnrEe1dfg4PBB74p35V9uE7Syd2p6c7qflDPY6+7ymh
	xBeVhqCJsfw/JYh3WGQRnRlHE81aEDr8qIGCVT66TDMh4Gmz4NKdKh6l1OgWCHbY
	tHUxP9fphphpkgnkG3elQp3ICLuqwUoLdaBORjwAYfoo9lg2Y97ZJZJwsazrmxfo
	VbvOQN2mdWx/0Aa7PiLFADHqzkkaySSkyzjkgV9vbtx92lsw7+/31E/peoPFmGyX
	Aie82ZtVajDUvx8O1xyMs2yDSEKMn8M8XlJ1EROWC1vdShLBPBJ02p/ELGbyOmlv
	SqY4MQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy97x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-252afdfafe1so3516015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757057; x=1759361857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR7RgImdeuGECfm8oEmT1uV2KbxxIPWin03Qltlq0XA=;
        b=LWMLCrQ58ppHMqZS12RFih1pc4KGwW95qIpUhe1Eq95myOtkuIdZaD8MHpwq97gpLS
         Ihp1YFDQ6s1YrbpFZVwfRh1Nx5DmvvAt/efLfcsxigP7zyzEJQ4JkLvQ+lxtSOPdfbx9
         EVyeF2o649VHciPa7oXZjinIgISwJnEDefMgXQLo1YpRYfU1JaZ9PQKAHSxEpP1OOuSg
         cknKLUMNpWijfOi8Gz7a31re2z/TkXI6qVrU7DHQhlA18gTkyW9zFZ6efkyzKXAZ2Wwn
         6K5Ubnv5gR9mdtRSVkSVxs5afSovFrlArxl661w0U1QE7U0P9l/WDdi9vZZQib5ywHgp
         LByg==
X-Forwarded-Encrypted: i=1; AJvYcCU7zoEdQ+6W6cC3K9mNHWzKfwmSZpNKJQlqYy1YT3viho9J2gEl6dVQ6C7hYEXj+gStXk7QsJ+ba9Qae70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0c6EQUFFattZ1o6Wx7f/dAKGuEffN1HMOS5Jg5H5QR4eV4Pbq
	WbEoBXKin98rSLrpp8ZY9ScIp92PiKAEMjNCHnMFsuOtsu9hdGb/jeUK0Fn9y7JCRL/8fW0oj5a
	QshU9BrtE+jBJ9q9ksU28F9novQPRMPdcHalnVwX0yOjwIENjV2YQNiG3lonlLYfk7Fw=
X-Gm-Gg: ASbGncsdvZZ0TLCQUmQzvTLy1UzH77yu7NGMDc8TmXNzqMZNgx7+M2hU8FUxVwsvfjB
	FFscRrSK22ZD0IeQCHl9FW1wgNpv3QsBDIXDUFzxkf+/XS2JL+V3TQa2ew9+R81u5mrxkBa+4By
	lCV0cEtefYHCBLkN9vVcq1bSB2ficw+xaZ6iMWddwDgwjLJUD80L+SbTvgpKgGULK6wxTtjsKES
	mKkH5uW88xm9+qhk8/n5FKBuJU9PFIUkZgujoMYLhhU9iJ481YUkg3F6eitnx/HEymS0jjhRrUj
	huI0b2BigSqZMW7sYgwt2kWoU4+r3vi5wRiRw6cRCxfhyImZm1IbtfqhhkozoR0VSXQ6/im5GHc
	lwnfEBjvYV2WPn3A=
X-Received: by 2002:a17:902:f545:b0:276:b1ce:c094 with SMTP id d9443c01a7336-27ed4a2d56bmr13859405ad.29.1758757057091;
        Wed, 24 Sep 2025 16:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0DpLlCP+Wu//SJaGMVpFeTh4I8dKMTS5/nKg7KoBNZz87O/I+1e3GvUlj2zhRFFWbv242ag==
X-Received: by 2002:a17:902:f545:b0:276:b1ce:c094 with SMTP id d9443c01a7336-27ed4a2d56bmr13859185ad.29.1758757056678;
        Wed, 24 Sep 2025 16:37:36 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d73550sm227187a91.3.2025.09.24.16.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:37:36 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:37:27 -0700
Subject: [PATCH 6/6] remoteproc: qcom_q6v5_pas: Add SoCCP node on Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-remoteproc-v1-6-611bf7be8329@oss.qualcomm.com>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
In-Reply-To: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757046; l=1587;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=nx0dHtwCuHPuOqGztNINoB6tkECO4h7844UgsOU5S8Y=;
 b=RVFCeO9HdLik8U13CFsMJrNsbHYXllD9xRH1xIxUhMQ37oLcPFBlmhUaBH1RzC2f1nAWbNyFL
 e+upGHkHY8kBDmwZTOJ9AvWHysXeySnjMDwe47/OVUydoyMDGFhejhY
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: hR2LaAqIlwdL3lAY8p3D60NRBJJ63B8S
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d480c2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-54vo4t_4OUFHp6kYXwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: hR2LaAqIlwdL3lAY8p3D60NRBJJ63B8S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXztOz8M7Y81Rb
 fQW4YTt1WmfhPgrLd5fXZ4njp9GK8PQpupt2yvrU/jdhaQhJQE5ftUDqxQgCVlbsLTs3ocB82L7
 cQbls1FqQols1rjLvlT+dUfBqfH3j3JuMml5bvIvFdavm3hIRWBESQswDzObhjC1sR+BCpn/Tv0
 SOtjWYLA7nLV8cfjsmGKqPWldNvOB2rbWlmpcgFDVeRwl4Jr+Mloc/RLhzTTxkZcFrxk925bvip
 oMjAdzIOueDchHnQM5My7DAQv9mS+a7lghUJs8Y3Us6D0n/W940IWN9N0US+v49fKjT/mjB0zoA
 kRMww8ysW0vhS9YXNpusaFsgmheI5m5Z3NdpMrzge+LG0KmVrT9WpMiIVJpn8eAORkwrfarsgsi
 X0YvVrgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

The SoC Control Processor (SoCCP) is small RISC-V MCU that controls
USB Type-C, battery charging and various other functions on Qualcomm SoCs.
It provides a solution for control-plane processing, reducing per-subsystem
microcontroller reinvention. Add support for SoCCP PAS loader on Kaanapali
platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 99163e48a76a..5007e1706699 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1487,7 +1487,25 @@ static const struct qcom_pas_data sm8750_mpss_resource = {
 	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
 };
 
+static const struct qcom_pas_data kaanapali_soccp_resource = {
+	.crash_reason_smem = 656,
+	.firmware_name = "soccp.mdt",
+	.dtb_firmware_name = "soccp_dtb.mdt",
+	.pas_id = 51,
+	.dtb_pas_id = 0x41,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mx",
+		NULL
+	},
+	.ssr_name = "soccp",
+	.sysmon_name = "soccp",
+	.auto_boot = true,
+	.early_boot = true,
+};
+
 static const struct of_device_id qcom_pas_of_match[] = {
+	{ .compatible = "qcom,kaanapali-soccp-pas", .data = &kaanapali_soccp_resource},
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},

-- 
2.25.1


