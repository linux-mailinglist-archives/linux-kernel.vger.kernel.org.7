Return-Path: <linux-kernel+bounces-831631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFDB9D2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333002E13AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F352E6112;
	Thu, 25 Sep 2025 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FoDhhdoE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F12EA48C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767351; cv=none; b=qdd9rP7Q6M+UKRxUbrO6PG8sM53viMI6scM9qLhW43IA3r5HvqozI8cZ0PYSJpWxBOBmPuAyzIqWUHneduLP3HQXp1DrayGs+VrxZwiVBv6ddaniRKS5QS0OXCz957i9Fj7rVNu7B/DyHD49MGE+XtkAnBE0PDdt3l4UJbzjvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767351; c=relaxed/simple;
	bh=OkC1mLtz16qVJoq2dcpPz2WMUUNz5fHtzWVOhSAQHi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLWkwo5YmhD/U5rVr3+tPFvQ/ES3b25mdm1WUc3DhFFSdteqWjYd7upiyNi4EtAh8a5HrfDZg87yIJPMXP3hEMbDBrk63oML2t0Rfo7vUHkp/B5DvQbsovSn4ImRl2ifDDAxXZDafGiy165XqZO85+EQ3ypjQ/4AiIDTN1U1uK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FoDhhdoE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONeUGL027304
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GwDc2ByWl5B
	YnzIa/5w++Oacjx00R55NFfYXUv0r7SI=; b=FoDhhdoExc/E0oa/RjY6gsGt/Jh
	V2wlsOgUWGGySNr0nKBxTNQ524GE66k9a1tr6uGHvlhxYOvuusqqfuZLoufZv3E5
	InFF9mK4clImcK31E4vXy8zGJVaNJqtlN89+4ziPsWF+sBh/Fyb/0rglEyVf7kpf
	inT29eT8B91jGnDgs+Z4Hs8fU/7w+O5tj2hTyPzX2LQnF0USyrqITFnnJd788LiD
	fy+eN5IEcV9c+OEkHuyMuMceYfWRyZiLCCpThAe4EZlwC7x3NdR4u7Qe2H1H3Di3
	k5Y6MgAqOai0gDG/WUj/SnTuhQf5TOhNwvGjBTBFJ6n0SM5L2MCrshKsYmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv16fdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso8538415ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767348; x=1759372148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwDc2ByWl5BYnzIa/5w++Oacjx00R55NFfYXUv0r7SI=;
        b=qP5TvTuhFszTpGpD1keDOo9T9T9Jc/YQgtC1TTPQhBbKiSf5WkME5yGPHIafwZ4fqi
         5Nd9XG9o6f4MwbXR7sVGOUHWLSHCi6wb+53A9a1r7QBcaG5YK3Fp/vrUgAEYa0B3YMus
         eOUxlj5+G56ZXPY3R4HUHo7N2SooYt/A0jZbIkJuMrfB+WlbwJPE6rc6f41eg2xPqFpr
         DRzGmWfPxG5K1R1bC1TsBDWRv8J/cJ3ywG8BeiWBEmjQh2aUgjLdMs9Ucoehh0OelsDd
         yIn1YpFL9mL/HanRaVBxkM/xNavw99su5B92Om0gWUE+mL8MKJPLPMvUgXUUfAkH/rL2
         m3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU3XZvxPi3CW6ChHiWUO9FfT2MVHiIyHGyrzn9NZY/RsxocIRxqWQxhLvdbR4yKGrGB1DwWQ4lEBz/75Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpjI8JQ+thgsImyky0PQEdW2ZjUpW4YawfS1BatUhoz46AYYP
	1P8uFXNLvhU1suSg4mOefErZNMIg8eJE3pQMJN31tFdtfmYVi0iMaCYY2HboXtLWuFY8/q2HBKG
	ALDXEAp4cM49ysYbF20nJ7MJS7jrntdTE0R9qHxE3ktnpQgT00Chmi+SCASKqX2Uu1Q4=
X-Gm-Gg: ASbGnctfrUIl0hMB2rOQXRt9XhrG0IHXU9Q7P5zvpR/9zLNNMe7YqDNWZTH3tR8YYTy
	IH3tPpjEF+w9AeP211j9Yw2oCh+fd5QQ1b4LEwMpsDmMf3xaIsfMtHGPST7jGh+v0JAm77Xb9cZ
	SUnhfhbMz343nyCpQY1EoaI2XFpQwXNGdQTd/SUfZib4zje/Znwm92xDYGsI0pkl3k6gPNnEABg
	T4USiWrIaerJkSSEgErT5lBt3ElBHTmKu9ZG/xTBnq1AtcKA5qwUAYy6efuaPbQGsCB/RIntXyM
	10UWnnqH+ZDHkHbsMnJriEtbH68SpjfNAExqxgzDR15DaprpETEgYSyF1WUKMhkn13FmZHdVuZ/
	QbVR8+sE5SRE5w4E+
X-Received: by 2002:a17:902:ebc6:b0:26c:4fa9:64d with SMTP id d9443c01a7336-27ed49c69e2mr21780895ad.5.1758767347717;
        Wed, 24 Sep 2025 19:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMKdq/R1VOIoSCgX8QYg7ZQfJNKKkQRcAu0k1AT4ZkR8KlDibAwSZZsHxhiLM+nIZarqOfg==
X-Received: by 2002:a17:902:ebc6:b0:26c:4fa9:64d with SMTP id d9443c01a7336-27ed49c69e2mr21780475ad.5.1758767347265;
        Wed, 24 Sep 2025 19:29:07 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:29:06 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 09/10] phy: qualcomm: m31-eusb2: Make clkref an optional resource
Date: Wed, 24 Sep 2025 19:28:49 -0700
Message-Id: <20250925022850.4133013-10-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5jCpa4HNd-JuJJ5NvxHqxEKfdvV_f6ao
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d4a8f5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8inbgvmG2iPteTk8MkMA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXw8JlylAB4ach
 UPh3bjUs9G/NrsEwYY5dfvaeE0cjXl73dbKJoPnPFgqzz7hwNUno0L4myz0bEvTjpwDgFJmTQNJ
 0vIyK0YRmCGfhw+HO4lGLfB02vYqYvMVXRdDLAiL1MYOdkl3EXFfP8fretapBtlFTLMW7K5+scu
 Ki+KAzYMah6S9xCj+eQPCnxpwMpbgDQFTKQhr0FfM8D5xlnk4I6O6ulQvC8Fs/ykEiAn6h7SRJO
 xpCiIF09dLWyitLGl3zyh3v2gd7ZDlK5/s2NT/mupLvZbSse+9EyMBP9cVHioGNzhKM5kQRuzLY
 r5nv+2PygVr5m/GbvN5XoYnC37UHzm5dryugkshSlcTvhxiaNUH516VCprQGgMCJBxvx42bA8IC
 1yx8VYmn
X-Proofpoint-ORIG-GUID: 5jCpa4HNd-JuJJ5NvxHqxEKfdvV_f6ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Some USB subsystems that utlize the M31 eUSB2 PHY doesn't require a clkref.
One example is the Glymur platform, which contains 4 USB controllers that
all utilize the M31 eUSB2 PHY.  However, PHYs associated to the primary
and secondary controllers do not require a clkref resource.  Due to this,
mark this as an optional clock.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 95cd3175926d..f8a00962f937 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -267,7 +267,7 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(phy->reset))
 		return PTR_ERR(phy->reset);
 
-	phy->clk = devm_clk_get(dev, NULL);
+	phy->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(phy->clk))
 		return dev_err_probe(dev, PTR_ERR(phy->clk),
 				     "failed to get clk\n");

