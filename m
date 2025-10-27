Return-Path: <linux-kernel+bounces-870901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4DC0BF22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E523BE060
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA72DC34D;
	Mon, 27 Oct 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZuNcoIrw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78942DAFA5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546309; cv=none; b=P1jxOelRWko0SX8MRHlnZHbihGXhBR9IQuzuhuSUcee/tOXN+LZvBssVDvKLtn4sbMhCurffD6DUZkEYiJLMh7MQ/UhcMJtIgKWzbJ4De3q+qxrKpqRay6w8B04+8WyaaYsoNzq9HthPD+JNJdxCtr9jl3nRmvZhAhP/KGI+rtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546309; c=relaxed/simple;
	bh=lCazBQWnIiQL6MPzUDH/BgTEHt7ubvKTmINYfZvjR50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XlCsk5Oie2uda3uJ61XeTMlsE1/+n4pNPfrVyVsmfeuX2BDLqE4CnUNAIvhMjnw47HUoRdfbvEnOZExjQlLEwUQA1VrVj3Kg9/0a413tAfqwFjAMnEUSeC4khZ1MFKxWwiCDIh6EyqrU29yM116gqtnyvLN+XboxFRDuCgwyv6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZuNcoIrw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QNFs611064012
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=teLtNRm505PX8MdgaxTQ1fxSCIYlKPWmx/D
	tUXEpo74=; b=ZuNcoIrwuEC64OO/+W72lW39Zktlb6lwaLtSurDy+OsFs9jK3aL
	Yt9i8WV6K8/unlpcgUdktKbNSfgX0o9HcaOr50IEg2Ft0Wrf4QXqjZQCn6VSyCt6
	mS5wpuxjMqN3My548/NrnRPRkSIlj0uLLBYNWoulHm+/JBfJhtV4LCbjtjkpVCdh
	0BusGdsxLJHQQhdm2dzPbPgTwXq3EBL7xsETiCQq74PqQuqzHfEEw0s0l3svamSD
	VslLlO4mU+AmiPHgr6cMF+gfczjlqHhQl7gxAY16f7vdBdpGFYf4Vtcny6vEeHQ5
	Epm0dgYGvW1ilURMAVM+tKdN3kRyZ2x9d0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6kd4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:25:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2930e6e2c03so44932845ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761546306; x=1762151106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teLtNRm505PX8MdgaxTQ1fxSCIYlKPWmx/DtUXEpo74=;
        b=YQbWpmtUOfyUKloUYHpmugs0r6sueYGGR6wvUb1c7QFTXumvu+uZdoT4RUgooiZMOm
         yd7M/A2sIeZEb9EcXgkloW6xS/pzuJizhi6+gM7NjwvVN/6WBs+RawYacWU5RHQpBVUN
         c41t1coFWftHGpiUdGR22tmsGw6XOH0Arbz0f4sR/7w/PUj1TvDHHjHuVWdPAi2q7fvP
         FOgAIk2Jfe1kVa2EGr2w/k4C+2iSgelB0VEUV9ja7BNsglzi50KySFh86RluHrHghj4o
         eggofUHlT50eZKsdr0wf9UZyBKpFpEoFpuuJ2UbRmZiWHA1xCba17WWah5B8SlIwwIwq
         CcTA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMdRyPFW0WxFsNbwH1e+GCepnR70+TarkM0k7IxsYxU4JRn9i/ZMHLEpVU2/GUSvsFCAFdnCZAPHR6kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjITPoERCnCEQMtnAsBMClv2oIZtwNXsbQrPpR/Js+qa3E+maI
	HzqbcXbpXKtEIv5/Sk/fmo2zGwWKQDg3X3pdnThVE4O/6x35s0Y9H4tgl0YYnrRKnMYm5igll+g
	NIdKlbQF2cA4rkhaFRt6j4tL8s0Klnr5oDvRA7mVAzHXAKbwX+drF47SnK3lIgPKj3TXo7Mhm80
	0=
X-Gm-Gg: ASbGncsUlAa0Ru4ctb3jyOJDE6d64K+1xSXrPZqJU/mGwEdEOQALDGfTyIks3rIYzOl
	mSdafJJR4phl+0aS7cYrTt4VU+ZDhfeIvgCZg1v8SaRcjVSX8gTLps3PxO036wNtWoX/cvHY0Mp
	SgTxTXKdhJcE4yFNGJPK7wRsL2J9Sti22eCAkE7BaFc1mEPG/7N9cgWrsEfuAlijPBprgnRLxh9
	tWPneEbfervhBAMyWmqD4CLk69HJ4WAaDQ4jWn+H6hjSSz0FM5EPwQLD9Oov77TXdkqPKlZgfKA
	TU8CBsmpVnm9M2+9xQ+rl40UZN29EAPn4e/ySazV9EtXd2TgOecZqToaLYu1PZMCb+ZjL1m3r/r
	aVui9g90w6jcv0iKXzRjeb0aOBeg=
X-Received: by 2002:a17:902:f70b:b0:267:af07:6528 with SMTP id d9443c01a7336-290caf83079mr448673485ad.35.1761546305515;
        Sun, 26 Oct 2025 23:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYsbnoxIoDwX1NoZs2UO3l7p3LATS1TmaBH5XzP3HuuA+Rw6QnyKU7CjxwqONWCAnQw26BZg==
X-Received: by 2002:a17:902:f70b:b0:267:af07:6528 with SMTP id d9443c01a7336-290caf83079mr448673185ad.35.1761546304946;
        Sun, 26 Oct 2025 23:25:04 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23218sm68346975ad.51.2025.10.26.23.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 23:25:04 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>
Subject: [PATCH] phy: qualcomm: m31-eusb2: Add runtime pm ops
Date: Mon, 27 Oct 2025 11:54:58 +0530
Message-Id: <20251027062458.1411096-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NiBTYWx0ZWRfX1So8D8FqND45
 e7WCFdu4lHIS8hSFkQsMttnrIYac3AhLZUWH4Uc3vLzPcFIdGL4yVuCbTjzThIgEclmgF+lpqJw
 kbc2m8SFjLK5iC+a5PUCobZFoMNnOutj2fBh4HdN5Ib5M32KCoxBr3bctpeUu7KjwSMjRUumSCF
 yTmDE3/2rYkf9xBaM3j8GmH9gdKIKCfz5Hkuz3yb8Lycr3SfnRxdh4k0vdyeavyIv0+sTk+0AN5
 Qdvtxk0R1nmGKCJSSNbHXsTmzlNqWb4W5+xAZsDBcsyrVhwW+NXcjSRkKFwlvNdutUgCd3eKJjR
 jQVdhqMumgiTE+6BP7PwH0uT9eDQ71fuFMbznfYfOM8ksu/8UGkPXLjE7BVyeoqN+7OSXp1M9yq
 SszJveYnD6ZY284bZbuxbnQ746FS/A==
X-Proofpoint-ORIG-GUID: bD7a8gyx8KtBeuMv5C03y_DUcEwuQu_x
X-Proofpoint-GUID: bD7a8gyx8KtBeuMv5C03y_DUcEwuQu_x
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff1042 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=-Y0lm5QSNLYpoQ5O1QAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270056

Add runtime power management operation callbacks for M31 EUSB2 PHY.
Enable/disable the clocks based on the runtime suspend/resume calls.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 0a0d2d9fc846..1aeb5e3de07c 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -240,6 +240,34 @@ static const struct phy_ops m31eusb2_phy_gen_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int m31eusb2_phy_runtime_suspend(struct device *dev)
+{
+	struct m31eusb2_phy *phy = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "Suspending M31 eUSB2 Phy\n");
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
+}
+
+static int m31eusb2_phy_runtime_resume(struct device *dev)
+{
+	struct m31eusb2_phy *phy = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "Resuming M31 eUSB2 Phy\n");
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		dev_err(dev, "failed to enable ref clock, %d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops m31eusb2_phy_pm_ops = {
+	SET_RUNTIME_PM_OPS(m31eusb2_phy_runtime_suspend,
+			   m31eusb2_phy_runtime_resume, NULL)
+};
+
 static int m31eusb2_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -270,6 +298,17 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(phy->clk),
 				     "failed to get clk\n");
 
+	dev_set_drvdata(dev, phy);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/*
+	 * Prevent runtime pm from being ON by default. Users can enable
+	 * it using power/control in sysfs.
+	 */
+	pm_runtime_forbid(dev);
+
+
 	phy->phy = devm_phy_create(dev, NULL, &m31eusb2_phy_gen_ops);
 	if (IS_ERR(phy->phy))
 		return dev_err_probe(dev, PTR_ERR(phy->phy),
@@ -313,6 +352,7 @@ static struct platform_driver m31eusb2_phy_driver = {
 	.probe = m31eusb2_phy_probe,
 	.driver = {
 		.name = "qcom-m31eusb2-phy",
+		.pm = &m31eusb2_phy_pm_ops,
 		.of_match_table = m31eusb2_phy_id_table,
 	},
 };
-- 
2.34.1


