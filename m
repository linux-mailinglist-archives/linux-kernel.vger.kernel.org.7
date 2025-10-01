Return-Path: <linux-kernel+bounces-839572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE1BB1EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BF41892EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CD313E0C;
	Wed,  1 Oct 2025 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzHbIRzT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D107285417
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356354; cv=none; b=PztJcl7QWM/xESoWLSjqts87Y36zgoScaD6aBdcA/Fcf8RIhcSQHsPI86fV6E7s46FiKYK6zvgTUVeWhmi62uWoWiGxTj2JBtfnCi61C4fyySR33PlHz1iHKUUVvBJeLkdk5x4p1+O2EDe8WFc4DHBEKhQ2+TOp+gJn+DIhXYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356354; c=relaxed/simple;
	bh=wwAOX22I0FMwc3Zh3TmwOoD6CIPx68eD+c21Q+iR4lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/IHfrfBUTU9QuTv3IxqIseI9uIBjz9WNXNGJ423BcliJhlcaYUH9vfWZeCWK/J3bfuXQ0vGRLbO9OirUxIyhfNhKa6it4a47bQAgzziVvtATZI7ccWLsjvsQKyOjXHubqHE9NlrJN+0aqE6wuBnrtuKwkIalTJharjwZ5TsO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzHbIRzT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcGCP005988
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fV/4QT0VA9Y
	jNuWz+QmsYOyq2W7XTcB2wF0sRRRIIRY=; b=MzHbIRzTXcx0eDmkqISGNJMbVyY
	hTBgZTG7esS5c45IStBAEl3hkYcHKJk3gsznEEvUfhh2m0WCEUmoz2tAcLcWKkC+
	wcrR6u+noOJrNi0nraDv/acNAjVFFoIqiUgncMkKf3PJsTgEt2eDpuvixoXUUssh
	ZcpNJ/hkrlpp1ff8EQ3/d4WZ3kGQBGK5J0ddjCdUn63bRB/txEs3qhTMI49RpuMq
	Ud0VUHd9dVt/6YAUPiKVFMZRrvThXn8fmzlCDoGI1994JD7rQoBt5toyKyNDOXsw
	gf1DVUeKpPq/Izwgmusi1psKBhNa1GaAhRQ5GiBnNu7/nD2OCc8KkO3WCKQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851p0qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3304def7909so324225a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356351; x=1759961151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV/4QT0VA9YjNuWz+QmsYOyq2W7XTcB2wF0sRRRIIRY=;
        b=TBWJhO/KDIdLRt/el4Jcs7qFtvAVoyueCVX3tvkwpmZe/eFFufPnhu6IXXlrrpGyEB
         s49G+L4pbiXM7cphCs5XxEnqD0rToW1eop8CSJOxePV0nNhtqbP7VBcuQsviuDUhIp1u
         +ti+bwUw9H/ZGSaARhddNEKemjaCu2/X9KFLG83fpMBn0zXNNstWTLr6++PAwO/4d4sa
         u9B+DnMVEmXJ366+n9lvTuaytwh4I7t4ZT3AsknPzM+rl/xNIXW2obhpcR8XZtvG8Ha0
         aJyMLf4NvqQiOZ4vDqHiLOvIpN2a1vAVzjtm5OwUFn/H7CwkVO3EfBiE8ZmRFoHwNYiL
         2hvw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGkRM/csZ8z4ujBEqvlSyb1ZvPFOVWUk2QtiGsHCCC8dBRGcKjlbuL08giCyMZU7Px6SsJ5tX3wYdkRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybwDssN0fSwbzs2V2JwuxBuZrBC91GvTz6tVAz35c6VA1rASto
	6Zafsn+q5EJAeTm3Y7Jt7oLtsQIqPZBCR9eZca3jfCdzL0d8AhqZXm7jE+5snWp4krBICARFCvP
	e1cghoNRP4Q/nj//a4X16wsHGsJdMUrbCyVG/JStV7IFKrrNP76B10MoQgh+vdioU2Yw=
X-Gm-Gg: ASbGncvAF2oEfbCLTr6EW3agpM+6DbFgqym9AH/IbBQRTeIJYpmGwIJNDPVTzaqtYub
	RoG4gbOqem6+uxL3CUz3tRSmKRg2p9DZpPfbl0vertglxPonyfRdEg45Tq64XED+IsjWL2KEDOo
	KX88JnCHmrQrO9MIhaKaYpFqLRbUSAJ2QNkiQkvnal4kGNw+Zx0zUb+HH7fXuIhPXMnzueU4xSi
	fmYgM28PNpkKRjSKS8ANvVt6ON/SkNg2GSsNj8NFtGciBD2Vsktv/1/7lxuTlBacRiyrx/j0f19
	qwpflzc8U3HLG1QJShzDfGUt6P4ZCje2aSvxRuBFQikSrs0LFgWTmqWrXeFnKmJG1pwj33zl3Pi
	LRGGMb2N7FLEVPm0T63+cQQ==
X-Received: by 2002:a17:90b:3511:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-339a6e97a92mr6634316a91.16.1759356350776;
        Wed, 01 Oct 2025 15:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmr7R5I47BoSxuFE5aidJ6MkJoBIZ2dG5PdBMeCR3hmk/q1hEeSZK08XFxZ/maDOfJEkItaw==
X-Received: by 2002:a17:90b:3511:b0:32e:51dd:46dd with SMTP id 98e67ed59e1d1-339a6e97a92mr6634278a91.16.1759356350296;
        Wed, 01 Oct 2025 15:05:50 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:49 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 09/10] phy: qualcomm: m31-eusb2: Make clkref an optional resource
Date: Wed,  1 Oct 2025 15:05:33 -0700
Message-Id: <20251001220534.3166401-10-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dda5bf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=8inbgvmG2iPteTk8MkMA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXzdzBUvVgNm0x
 p22dV4HKYG/F79v6CnrLJoeIBmCPeQiKGMEs2TeqGX+VQjfvyYAMgPCKyZ9WmVo6N4sg0PLPDNn
 D551fOEidT97zIDJMxylXC28yXPY4s0ttSaWcfH2tf7eu4tuzivYY1R4qJNdGPhXjsiZVtKOwKo
 f5KTV5UWGw++cKaKqPtFl33FDOETtCUx1/4jaeSTh3AvHrsIcyWIB6RsZ8YVcA2kEQLIgtDgy9R
 uoOCTkn4KKS4sQ/NTfP0cNvyBtylMtcsEi+6T74jyak1LnWxZf2iOsyOIEiVhSUE6v+pHJZTSMj
 3TMjAbi19l8VCo1wvwfWlXqYQGpPJFPM0hOvp3dAtu3CV+aEqkVB4e+DJVBvxa1skgBNujkCY13
 fcj9m0fdN7Wgh7QY7Uf322IaWTYbDg==
X-Proofpoint-ORIG-GUID: 4350tqfZCQVcsNQZiujCMeBN5XHQb8oS
X-Proofpoint-GUID: 4350tqfZCQVcsNQZiujCMeBN5XHQb8oS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

Some USB subsystems that utlize the M31 eUSB2 PHY doesn't require a clkref.
One example is the Glymur platform, which contains 4 USB controllers that
all utilize the M31 eUSB2 PHY.  However, PHYs associated to the primary
and secondary controllers do not require a clkref resource.  Due to this,
mark this as an optional clock.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

