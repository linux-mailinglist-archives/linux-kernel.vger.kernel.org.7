Return-Path: <linux-kernel+bounces-769114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F1B26A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA4CA04EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68421767D;
	Thu, 14 Aug 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpLLQwSC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581B32142C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183281; cv=none; b=GrqkHf/gV8LZNx7okdcXqclsIdF5ikfPN50jntDhMs0C9aR7dOnWR+429JXUKSH3QcBUPdrOutlGzv0JTFcjoVGNLdHykWAtB3dZeB0n1qxkcBs5ssHbA+LUFI/39pWv+Ge0c/A1tJ9BeSq3cXxfOsuLXavZb/40om0I4ARVBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183281; c=relaxed/simple;
	bh=7Ao2rWjQ/ojqXztz4wSXnsU3LKOpkyHAtipVC883xJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blvtt4w/G/6DE+QrOs9zckhICzy3JkQ0/xyTTk4StD4MKP9r72daIAo5czH3Hrl2mZ59Wqsj27LCRLjeAQdY8exsKdGoc3ELBzOluC8au34pZ6f2tyRSeunzDYkGAItOs57nm+Cio/HFbzWwLKESFpRt2sFdH1WSS4xGZpDttEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpLLQwSC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8s8Lc002778
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tglaKq5MwHPkzJhC/F7WN2IWUMXxho8xACm5J/TZbM0=; b=DpLLQwSCX9cBMEKl
	FWx3GxQQmpTJ6U7GnqyCSmtWxr+KYEDZilKjeIWCCAOLStZxJi+Q/AxZCcjmkalw
	tEjT5tHZh2YzBSCzbKwBiMe5Ii8LT23XztdUzvyiTHPCva+wEj8XyOZHLuWacR4v
	OrLY0q0FQX+dNOZ+OaC2AYxniKOUhqp2WR0HRtLVcAK4PFn8cWMVh3B/YO7Nn1bA
	/xkPpDlhpY/0nt04RsuNT7Yd6awn8eTxL4moR/t7A9xQnJZHE3wKEVS/QNubNczP
	cwWqlRpkmPlB6nPASKPltr4/7NOMGimpW3JsU6Dg7LOS4Sh4yfyKYeHar7JEN/ur
	VsvKEg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv83jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e3353d4easo618844b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183278; x=1755788078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tglaKq5MwHPkzJhC/F7WN2IWUMXxho8xACm5J/TZbM0=;
        b=AavAfDb8ckWyCDl2ijikswh46DF2119h7WRaElK7AFbMaBUMBNaDZpBF3Jj6ZuAU2m
         Jo0OFixYgKQ/DL14uX1KuKbl/aEAumfn7/qKX0Q1vcrgWjvml5PoAXZ4/slPWKa+Xc+O
         OXMUe+M/UQM8KMDlbtHK+RAtNsd56ma737fMeELSWXAXMBuDL7Voy08MbbeEUL13UiTN
         H6iY6hCQ4k9PotVu2R06rDwHjkT2EytngUnaf+EfBkCC9ZkHZ2cdhsyq6Sdi9e08W2mo
         FpZtXTXkCoTwKyPzVaM5HVyclw07Jjtg8jRVFHSWOsl5AJNngRY76NuWD9Qp+cr1g6Mj
         95lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNS9b7KH11QOA0XL7fSZt57jTojbl5bi+nYPp+OHQXasc/h8FcGTQpL+2KP8IVcaUGV+DusETDtHvf7Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56+okA0Z+fBY/XnF9vmw2yYnAFW/R5aSPhFNc+JaAHOrQnOq4
	57WQcyi6xBT4/tkxRF+TG/f7iDRtzwPjbpRkCbKAaWJEo7zURp7we+TsjuS9vW5tO8wzjkI4I+U
	EylWCuBeeig4jy7CwzLeSUDOg5IQJWjICwom41KlaHDU/kW3+s/3jNVgcO10kLA64dsK4aGiqm6
	c=
X-Gm-Gg: ASbGncuOmlSZm3lHZ1gJzn5M3IrgnTN9fy/wpkMKi5gyGBokEvOpdB3v3m0kvNDCrWl
	OMSRnJVb9Mc4f5cuvj9YL4jbE3hVaUKnPLX1+EWbQlAAIJIvZGduzUFELjKR4ElDQUY0IYS0RiV
	oXH+c7M9aMIMXtRygBW3o3ocm2YWB39YYHqbfSGDjdp7ORI+D7ppht4GHHdbasKgzHhMUvPmDtC
	6z2xA1JYnxwBI6bJ89cdqoDDzKKjJJ75EqJJ2kCXU3RSPT6bvwW14TrzwwAmQgq5/sCoGucxFpx
	70C9TvWXZ8WsmWsLqbcN1HosIDhzBFm0mituFLF5iJwLQzU5+Hu6gVPkiNcTnJA=
X-Received: by 2002:a05:6a00:4650:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76e2fc0c9b8mr5979281b3a.8.1755183277985;
        Thu, 14 Aug 2025 07:54:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNVdJy1vrWmBYvpmA2uQhEm7g+HPzTdliF9g3hxn/kU1f8cBwtjX4rjsL1kAtrkg1z9pZ0jg==
X-Received: by 2002:a05:6a00:4650:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76e2fc0c9b8mr5979243b3a.8.1755183277479;
        Thu, 14 Aug 2025 07:54:37 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be718b2d6sm30715274b3a.56.2025.08.14.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:54:36 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 14:54:20 +0000
Subject: [PATCH v2 2/3] interconnect: qcom: icc-rpmh: increase MAX_PORTS to
 support four QoS ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-glymur-icc-v2-2-596cca6b6015@oss.qualcomm.com>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
In-Reply-To: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689df8af cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KQ-1iU-oSatw-PdDDDcA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: -wuJYUD_BoPnAblcwlIaa5sev9jZQMNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXwTdQQVSL5Xn4
 S0CVaOeAoP062z434EWjA38ok0HXRdJ3NDdbT9TmeP7SdtMZUSfLmMWxNW6HCZARXMnpOQkkEtu
 88kElcUSM7+kTJjAXwGucL0IAPWBToRsMjRkPadURa5N6ASuRyYm0v90nwlXovIyWYCYVtLCH81
 JoRukYf1v9kSRd+8cDxhItRy2n3bmd89bi0JQFnrIqfzsJapl1jSZeOrhV9na/zpUCg6qABJ01c
 38gm2cKYE7LZUOhb1HYtRtur/rYf4c3RkFGg1EPJCsUQji75lFaX6Q4tgxgKdGvyYX/ZkBg9RAI
 4hgkBFn1GEuqMRaPQl/SluY48jQV7oeeo+VYJe5i7mRZEU2FUflHYzQ8huVTUO5aZiCVmQGGVX2
 5oY0aR+G
X-Proofpoint-GUID: -wuJYUD_BoPnAblcwlIaa5sev9jZQMNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Update the MAX_PORTS value to 4 to program four QoS ports
available on the Glymur SoC's interconnect master node.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index bd8d730249b1c9e5b37afbee485b9500a8028c2e..307f48412563690049e944907bd80500f263f738 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -53,7 +53,7 @@ struct bcm_db {
 	u8 reserved;
 };
 
-#define MAX_PORTS		2
+#define MAX_PORTS		4
 
 /**
  * struct qcom_icc_qosbox - Qualcomm specific QoS config

-- 
2.43.0


