Return-Path: <linux-kernel+bounces-866522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942EABFFFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DD23AE24A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF1A3019DA;
	Thu, 23 Oct 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QGXNGFRo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F3302CB9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209099; cv=none; b=cPXXeKTPLMJbhLsmx6xIpLOyOwsEXrFWx4ekZXMEA8cR/KW0ZjhHYRNpkANV4WfW23nQXZ3v0+luZa1mfNzk+rBQ/foppGwKx830ohlNmQgUVQNuc4zSIsfDRYyYgWh9nqODOt0aNQ+I/kccP/Hm9G6AwrNgz+/JlD9vQtwtG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209099; c=relaxed/simple;
	bh=NBRovJaqkNcGG3lLAI5DbYycB/1E0nG5kKP88TENNd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InGmSHpf3/LZTnB2OY2rHMoLVDluULfzKNdQANzA4uJbq4QWYjFP84cH99fMQ0OUFj2lWEqClH1tMZrYZLP5Ui7W33r5mZotuYfwHtWaP67WJj5emhi3kxjDeB3WxBJGfJFzGROr1zBOoWJRLR+8NXqO6CRl1W+rTDc7aYY/FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QGXNGFRo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6dfcF000663
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMOYKcOfCkL0s0KLPZmt9lLeSz9YVBHmXBnbsduDHcg=; b=QGXNGFRoc+NG4GqS
	GSv1DA4pfUiUKvaOilnpwGm/QRIGl8VNiUGHTmLbW2ZaC2z0ZKIr4RBlkr/k80ik
	tuMWhC1nTweFkstmIaKUdMRuwv8FLGrqxPE7+PN8BsjQADSjHeu9I/ycN+XH8xu+
	CIWDrJB7+c4PFPDUTyyvK3AruH80ossTFfrwYflUeeYhtHieM3xFs3dlCTzkz/eJ
	WtKnIHGxApZCmWDgISUN9xoSPSNXHKS+UwROlZpxnoa5H0XzWkZQigso/91QyInC
	9l27nMbNoyqOEVldJLkHKhqRmnhxbB7SkOQI7JgfZYontQK8hvdSvDoLzNAQAM9K
	PgMnOQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wdbgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:44:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cf1b799dcso438418a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209096; x=1761813896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMOYKcOfCkL0s0KLPZmt9lLeSz9YVBHmXBnbsduDHcg=;
        b=Ea7MUFZ94lgQbu5DJc6qamioMjQT7SA5po5qpFVHV8gTE/LHKOt+SZU/nmcKSYPL7m
         +3lU+2bP8ZUqihdyElMLwYZNfhxO7HichcGsz7p8bDi4MS8M8//edFeCOPxYZB4oEYPH
         hYU1UCmVFY03HCIIXsZwJtmLiCJ3QjZdjJkIiSeikun416olVraimfBKTvj6VmZlLrPz
         sKH+d8elh1bEHZhfKEpL/gj25guwAbLEjHUNQzWPe3xUgH22DfqTT+YnZYLiPJcL5t4y
         XVzRgNxKRpzB3TbW35h4M/6U0mMUD7towb1+yuBazi9hzqy8DqcCExBTdb5qz5Lg5NKl
         inHg==
X-Forwarded-Encrypted: i=1; AJvYcCXi+3spfGBWp2zfO3KtJkJ1JU1pw8nuY9g9sEnMjTNotwYoWM9bS5vImYNYS/myBSJgL/YTuUz+gIzmOeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykvRYNLKX+gXVzzbfYGd1wirBLAKRhm3LDo3aTj+IeQWL49j13
	oifOnw8JxgPAo95+UZ4PpZMGIRe9UExzKb9medTK4pee6wpXdxTiqUAknhTB8OxR+gi15g63mca
	CQ4NVQRhWIVd9pTcup7OWp0Iwm14PmNW1ytpqiHqLCXeuFyabBVSBDGM0RaJUiZJErhU=
X-Gm-Gg: ASbGncslrdazV1HXpCTZQEc+9txPDwSrnDcN+PUgp+HoKtccfWC626Kr6PuQ+1wppL7
	GBuviKYWeM7yAvvUlwZ9egbOd2hPaZgGEj2zg5M88ROGU+96NVeDa+wuZZHvcN2si4Ja2cNc/6W
	BzeJrT56tuDDDA7+ReH3vXkCkx3sOrEjw4dLaivQ6DG0RyKMs5cJHFmhWu6vv4HaS0R+MD2z6TR
	Xv08idpOl2bHpWpMGyphrB52O8ypjKuWaPOJDgM3FEnZoDBh/vyRmKTQawDalQkIixti9RM/6gd
	zF7VS4W7vL8gK69Q/csZ7gwVDKjWBuEHutT0aPiu/PMp+yvm1Od3vv2UsHxUB0wBrMGvNVf1CVF
	blNE+5u26Z1p5nqW/YQBap+S/9cTNjGH0cQ==
X-Received: by 2002:a17:90b:3942:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-33bcf87f431mr33777082a91.9.1761209096378;
        Thu, 23 Oct 2025 01:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6QS0adJF6pTnwXOGYcJh2KTc8Y209+IAOSTNKlkqPHVZXptbGoDdmb5Pwbd310OlsY3Ervg==
X-Received: by 2002:a17:90b:3942:b0:336:bfce:3b48 with SMTP id 98e67ed59e1d1-33bcf87f431mr33777043a91.9.1761209095912;
        Thu, 23 Oct 2025 01:44:55 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c056fbsm1391414a12.17.2025.10.23.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:44:55 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:14:37 +0530
Subject: [PATCH v2 2/2] regulator: rpmh-regulator: Add RPMH regulator
 support for PMR735D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-pmr735d_regulator-v2-2-452e1b28cd38@oss.qualcomm.com>
References: <20251023-pmr735d_regulator-v2-0-452e1b28cd38@oss.qualcomm.com>
In-Reply-To: <20251023-pmr735d_regulator-v2-0-452e1b28cd38@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        jingyi.wang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761209080; l=1846;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=NBRovJaqkNcGG3lLAI5DbYycB/1E0nG5kKP88TENNd8=;
 b=veWw1zkUQrhmC9aqOesX0Xm8cjMxPGs6W6jFTMl1E4EGD6hB4IkF/4NCNAlt3flfczEKPFM3n
 oFLyxFa5L3GAWcE5rtzUkl4fVivWAaFWJHJVYgW8KBijS9rz6vKWrtB
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-ORIG-GUID: Wt8Hgpa5aQbbN0mPNQHkYOvz3uP3KGmT
X-Proofpoint-GUID: Wt8Hgpa5aQbbN0mPNQHkYOvz3uP3KGmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX4PDHotiHfOyC
 ZTln0xWP2esotDuolLR4AqQvEFx7rRNeaJFxIv7kamhkD1ULrek49g1vlpRXtY0TJxYGibw0OG4
 6GjJhE9DiXMNjboucW38hVaHN0nJd5C8v/DcjBLss5Kav9vUyNIGtn/Xvs82Gp7Q3e14OdCwACZ
 hH2eXfuOs4ae20Lmtp2kU9OqZON6brhVfORl1KZB3YCZcyIMCYb1zBYWJ9JUD3/YPRsuBfKOnlv
 i1HWh4M4LioFtPU1QOsad0venA7ZOPMiNvG9HHZf+4fzvphkhhN5NUpuVTYQuhFz7Eu5+ybU7Fs
 STvIbFnFpfH2dvKYrvWmFPsap+thOodIiSv2yZwt+2BZz5uznbIlISmvf3Jdg1sbnqPtL8puiiq
 h7/9gOahAGXj2HOtFvroCVkR9ccWng==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f9eb09 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ufI_WnuctKyF2eFgXJIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Add support for PMR735D PMIC voltage regulators which are present on
Kaanapali boards.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 0a561f1d9452..6e4cb2871fca 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1735,6 +1735,17 @@ static const struct rpmh_vreg_init_data pmr735b_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmr735d_vreg_data[] = {
+	RPMH_VREG("ldo1",   LDO,  1,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo2",   LDO,  2,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo3",   LDO,  3,  &pmic5_nldo515,      "vdd-l3-l4"),
+	RPMH_VREG("ldo4",   LDO,  4,  &pmic5_nldo515,      "vdd-l3-l4"),
+	RPMH_VREG("ldo5",   LDO,  5,  &pmic5_nldo515,      "vdd-l1-l2-l5"),
+	RPMH_VREG("ldo6",   LDO,  6,  &pmic5_nldo515,      "vdd-l6"),
+	RPMH_VREG("ldo7",   LDO,  7,  &pmic5_nldo515,      "vdd-l7"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm660_vreg_data[] = {
 	RPMH_VREG("smps1", SMPS, 1,  &pmic4_ftsmps426, "vdd-s1"),
 	RPMH_VREG("smps2", SMPS, 2,  &pmic4_ftsmps426, "vdd-s2"),
@@ -1950,6 +1961,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmr735b-rpmh-regulators",
 		.data = pmr735b_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmr735d-rpmh-regulators",
+		.data = pmr735d_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm660-rpmh-regulators",
 		.data = pm660_vreg_data,

-- 
2.25.1


