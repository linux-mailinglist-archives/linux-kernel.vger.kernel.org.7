Return-Path: <linux-kernel+bounces-843535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD2BBFAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1166C4F2669
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F92DEA90;
	Mon,  6 Oct 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nYeqUBkS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A12DEA96
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789223; cv=none; b=c7A4k9VjAbPMmHzpt9MzZqyzp7EhPctONeh4qHzxPKZwBR8YiZYyMs68RAcyKhqMeAR6YoySPBzzVtCUah2OwRg1ekdqnxI8eXrGqyxHQEVQkOKMxZdOPdDk69+r0MGixg8JZliJF34XZ6Ga6YIUUY51Ndk4Pl4VnCOS6iY/f+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789223; c=relaxed/simple;
	bh=wwAOX22I0FMwc3Zh3TmwOoD6CIPx68eD+c21Q+iR4lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeWgicvhGjE4fZjcbTrQy8amamrdKoK+tnb+ymsYJHvmMdek9H53nKX2pSu/E0zm6rcuUR2nNKh8tLmtlrViouGpn7bq97ZrqKuM2I59HclVwcQRWH5M1i74ucmcsfA2w55opYJMqOB08Kg1W+IQo9gMAouJ2Ct8SBVbOAkTDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nYeqUBkS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FObNL029291
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fV/4QT0VA9Y
	jNuWz+QmsYOyq2W7XTcB2wF0sRRRIIRY=; b=nYeqUBkS4063/hTYGK5AN36Mmbh
	vU1kULVBz1JC3xY0gai5o+Sf4MqpM5Ogcnm+es3LqpJUnSGDnVgsCdDejxcFKeFw
	Kc7RVqLjKEM/1Cbszq7y9rL6jNqE/34f3FagvVuJ4SVKxG1nBmJ4bo/0gbb3bA88
	0kOpADXsLvqaWzq8fTzdZfalZfTvD3SFQlLxBkKzzUWPpVHjed7KAQE3cMfbKB/d
	P4rhnKbAal91POcAXZMLMgBl53snG6N3YOHGpFgOXeooFHxjvUxz9QMekdXRtGxg
	MNUk8vSl6jLqqxxb3XZDW+BLgPDzTOjs28xZfhXWy+WaC5VWZYKdJqf0aeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9dwhyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78106e63bc9so5264839b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789220; x=1760394020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV/4QT0VA9YjNuWz+QmsYOyq2W7XTcB2wF0sRRRIIRY=;
        b=OP0QwA6WZKCcP9Z9psWWgahUQ8K9VbxuJG1de1I1RFfINXuwUjt7iY8/jhb5d1wwhx
         NP/exszTFhv6d4476bo/dSkC0KwP14D+Z0P8QKm00AASmvsGVNwB4epoMnXfYpMPYct5
         IQKpfLeEkUoLI705Nv4s7R05BsuCd1xfp9VPHzCRoTaCLTvBs+L+eAmUofyS5YH0U40A
         epYxj9C5n4VyPdo4fLVhkjtvaSnTEub3vsqAFC4tWf/QxKa3JlSyIRb/SN6BK0bQiSrN
         Jvrx1snK/gwtIsfo/kAHE1ovNS/yfhoEBEOrOZINWQ7ZMO7mfLHrtVsNv/dt+Agw3nX6
         +X5g==
X-Forwarded-Encrypted: i=1; AJvYcCWKLxB7W8m3FlsLTlIreodq2X4RuC3YrTbgbdLdb93VsDSzFw7t7VvAI8e4VXLHYcMmb/imJ1nF3AH8CC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGA3Nzh8uuAdS/OV4Q6WIULj6hhX+ie7SzxbbN6pxsGObCUrN
	NhspvIGjij/4XH9bTJ/lZXImbKZh+IQGL/O2NvJRW98A2hNPTHZzzf68ZBsaxe6HclgFa2sjj0z
	KVOhgdexyOFRV0T5kRR+jQPWYBqZdn/pW4bSikDICONdrbnCA/kKgdU8WTc7EaB8Odxzk27Dech
	c=
X-Gm-Gg: ASbGncvJaHP/Ua7fGipQS5dtMD8skVsdn/m66p9LDD5Ag16fSQp2AV23H/Fn8MIqqk9
	E8ToQjp+pKByRp6lOmfpMJFfyxeQjnjtLLI7HL/mArfsopSD7/KuC/sHK1zxt/V1WITNuRsBw3O
	pMM6fNSWyvtQR88EqIQA1AA2PGH3VrC3GDDpvgxWIJmL6miTFLg1tee72gmsYvX8ILFTvqL5kz7
	ZshVrfCDdSBvl34vNKMK6Pge/b8rLvbfNjE0Zwe5Ebix5nb+1y3IZM3iOofIv+SG2epfeba7Q6J
	U2S06rrvDabcQP6XOM6QZ9Ygn3kCNLvw/HYuUbrf/GLSroIcmL2RHMakDUTccF3bvVTB5Srn8Fe
	UW9VHAKKqJmW6gFpwCodBSA==
X-Received: by 2002:a05:6a00:14cf:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-78c98d33024mr17671965b3a.2.1759789219916;
        Mon, 06 Oct 2025 15:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOY9p6MYrcEA1mJuNfdaAQD2CVOBY6X4Jp8M6dIFsvCZVYNCrKOaryyWH6+rHJuR6iNhMMA==
X-Received: by 2002:a05:6a00:14cf:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-78c98d33024mr17671930b3a.2.1759789219452;
        Mon, 06 Oct 2025 15:20:19 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:18 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 09/10] phy: qualcomm: m31-eusb2: Make clkref an optional resource
Date: Mon,  6 Oct 2025 15:20:01 -0700
Message-Id: <20251006222002.2182777-10-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e440a5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=8inbgvmG2iPteTk8MkMA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: MC1ybLze5wj7U_EAn8WWQZDFHyDjM6W9
X-Proofpoint-ORIG-GUID: MC1ybLze5wj7U_EAn8WWQZDFHyDjM6W9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX5IcRCVNkVeg5
 yuOAhs/UAWU1D2WctbZm59lCfzH/W0cQX1/ugAczmg3YLDK40p2X01gz05vQqDevQmPEFjEmkOp
 p3ayBb3HonONPEAKfXReYUUk9EzkXLZ6sOCrLvoj/3xFlwDl5uhbxk/6UGMM5MROaBLqFOUnuYQ
 uj47zWZAS8pwDTAOlFvjUI28DhxtpsI62kPm7HU3JMO9p8IDMTL5qCINmcmt9wfjHeVxGpBHwad
 dKSYjQvAkYN8ydCF6KcsOH+TiMX3wbeaSrrCcfV0DoJIvFsZR6LLWBUD6z26GNqqVKwXL5PmxET
 CpYVc1cSdCdDwFsyprBVJQkDx6iKrFPqst+NtFF8q9RIeYn/91Z5kEm13zhxcmRklo5SQC3PyNw
 yGG5AoqtJxcQ9QGl9fh+/ftWWroZ5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

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

