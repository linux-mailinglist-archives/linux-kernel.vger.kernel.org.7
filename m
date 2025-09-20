Return-Path: <linux-kernel+bounces-825479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B68B8BE46
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58EB1704F2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CF24DCFD;
	Sat, 20 Sep 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISlggu6M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E0245006
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338490; cv=none; b=qE/ruJrNoHGfV+PPteKwa4BQ7KtLwWNBo1Dx9d4SLyAuEqWFb7pnYCF/yA3Oxf7Kf//kYzJXkXU0YW+4djhh+YI2qdFcMnudE8fpD24ZdR4pxv6JUrcFpYow7FqvLMVJPZSdTgruRtrbcoaPo6WY2PzDPkJXyG0Gf/ReRyfvtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338490; c=relaxed/simple;
	bh=Ftt/PftF28xTllTsZoRGsGveRUaR2bB0qq13ptSWTkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPrUzUiHN9LoMT0cyxOCslzPepUKdnLQuYeZCflMOfCkmCrV05LOz3wc7x9oaawXBDX+CHrNeVH0gLtJGpdMzefISlXjMzREAkbVmoavWJV5wXqOAVdRMQ1ET5i9NphbJz4wGOGmQN1elWBXbDZK7iVjQ6dTPNQEhWJ8wCB6JpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISlggu6M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FWdx032256
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kuxKL1PStAu
	Jvwvz2BevRvoak3D7tba15DUzjzxEF+c=; b=ISlggu6MdmJwRtUsXG3GMk/se0O
	tAYwmI438qLshGkuxDTl+CcYaiYGvRjbybK7wZdkWxNhJ/VfzFyME9XYEN/wdxYY
	YNmcD1OpM6ETsSZwXSO3ui7AEcXsIEHTFBBw5XXWK52moZfV2aPp6FGPu7RO0TkW
	ad4t5bxL78cmTlDTyHvQq6HRVk2rBRqHubnNG2XW0iBp3L+60/chun5trfCQ91uV
	FjhqvPdQUlTydnpvDQA/Cj2etFmmMBYKavfWUMkKQlY7hxcV8Vdu7Dq6GIPwYvgG
	odo22MiEfCnsrJbTbi1MejVfM/Dq2RBxjuIOEyUG5mkBGJaoQeOKdwWJi1Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deh3r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f18d99ebaso295848b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338486; x=1758943286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuxKL1PStAuJvwvz2BevRvoak3D7tba15DUzjzxEF+c=;
        b=teRZNivYCBlRE23ANc0vW+PyVPix2AO4261mb4NG8e8VdQM1oSSqNAlXYaK38fmMmL
         VEux288jOg62wfi4iBBKM6ts08A/p6vjT7MEZk39WkR3viJZt9/+MUTq8ZRDBhRCeNqa
         M9tKl2h5UZSD/q9++vyp/Glu3/HK25mvy714BdQBF7o307oRPHOgKDGc6p+oztulCeT6
         3aoT/FliPGxn2X3Zh+MY0rCVGg2v1IcebCirs5CT66bVFaU9Jef4QB+dmCABZGbkklun
         GuxzDZ4YTtF+UpMoUgNqTrXmwJp2/qZEgXJfZhupgZg7uy2eunLeEUg2PzwcSaDp6Ecl
         KONA==
X-Gm-Message-State: AOJu0YxEfIo1F3AwqPlgR/uOGCyaykzELv+QY6cAJyt2iB5EHY2YT+Kv
	n6VqbHcbYcOmTYyKfg8YpwulMNZRdZ1NwJScNg9ZHjMwtpENhbhWg/e0hJw/IXqK3oVcA06sZLU
	HQjfgNRTzVu72xAmnvKr99yG6Yd8vkKNbq2trrWAjr80Z1dHBy08h62dDKS0K/WvDuys=
X-Gm-Gg: ASbGnctCNq5dCxlHHxx+bv8zMc9pup8oZc46Ema7lTPlGHUkbwJFlA2V2XQxvIQWEGw
	d9BMkWiKB1Jw9VkXdUgbBOBJzEzxqGGh1DxGGTOQiKTeMnGO+5c3mcb5pFarPNPV6iblwLwjgRM
	+v7//xDkw4gNYFQs2LViVn5A5s6BWLUG6DlzRxra9FGJgyT9f9z4B76qAh2+u8zmgE2j/L1GkLM
	g0PgBKe8FWKQzRtGFDL9uIFZlPbURl8uWsFSucTPNz58RHX/JhBO75nAboo8AbPv4g501pEKs8k
	6U07f8z5UlBFxvozXLAexjShHnDSo5UBQNlVFzqLl+op4l1oaWGaq9NYxhj7uhW8ESW/ajvYBPh
	ixAOUGfqy9+WgutCD
X-Received: by 2002:a05:6a20:19a3:b0:24c:c33e:8df0 with SMTP id adf61e73a8af0-292727771abmr6193877637.45.1758338485853;
        Fri, 19 Sep 2025 20:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmf7ZyY4Qi299dDqNQLCxEkdP0noay2XXf8NGY+wawk7nSpEhPzEhHKehKKQ4CvBpbINH57w==
X-Received: by 2002:a05:6a20:19a3:b0:24c:c33e:8df0 with SMTP id adf61e73a8af0-292727771abmr6193859637.45.1758338485422;
        Fri, 19 Sep 2025 20:21:25 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:24 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 8/9] phy: qualcomm: m31-eusb2: Make clkref an optional resource
Date: Fri, 19 Sep 2025 20:21:07 -0700
Message-Id: <20250920032108.242643-9-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68ce1db7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8inbgvmG2iPteTk8MkMA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: MF9e9W3NqyhAhgUBCIOiiomW4xKesecf
X-Proofpoint-ORIG-GUID: MF9e9W3NqyhAhgUBCIOiiomW4xKesecf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfXyrhQiJt8uMpC
 DuQkSXiWgL7q13XfDr12G8DKxk+CuhZcEcQEjTXJ4eYByg7ag3RbWlv367owg9Sv+y+uWkXcs6h
 lHilCyFWHrFFNariZJlU9AdknGsCmP03jTeGSimlyhmgO0WVMywrH3Nl4iLuIP3XJgkAjwVcQ1h
 XIDbmNd1uiQyJTluCfDcsQTN2k+6xWGLtb33EL+ZUZGcgthTEPrIe0fHwuFx4jsEInERK5IqnS8
 t/iall77ljkifXFSbp6ojywz6mE0sLcT9LV7li1gHrhYbTxxcPTViKFatQ5tjhZ98yqFUxKZljF
 P+68cDfKPcdkIGhlkMsAh8M3Mg3B5fFNRBf/pyc8oZ1zyjM2Y/2F85Fd/NB0xy/nb+VXcCDRF6X
 5IaopPL+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Some USB subsystems that utlize the M31 eUSB2 PHY doesn't require a clkref.
One example is the Glymur platform, which contains 4 USB controllers that
all utilize the M31 eUSB2 PHY.  However, PHYs associated to the primary
and secondary controllers do not require a clkref resource.  Due to this,
mark this as an optional clock.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index fbf5e999ca7a..f4355d38aad9 100644
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

