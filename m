Return-Path: <linux-kernel+bounces-786500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA0B35A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07EB7B61BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885FF2F619C;
	Tue, 26 Aug 2025 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsKij185"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD252206A7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206188; cv=none; b=aT2pFBugBZavjqPhK2Vc0QqSIPhSnb2aBZeFUazsMYJ/jeIvgISJZI7o5TV5xvLQq/FfjqRNz0SCbaaFvvcRraDRGS6RJf3+7Ba47aRJ0gn95p4+UbmVYorMKI+ze9+fCyi4wO9zJTvFcIR14EHGuK3RvQUrCkSbIBM4acmzZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206188; c=relaxed/simple;
	bh=jBBl6A3Sxsg2d6MaEgBHO65kZTpSDglRvHQ0xA/RmfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V55LrGyb8UeKJB6Zi/2SO3vgZOQ08i+jSi4IuWq4zY6M5el0n9jVljtHJ60f2bj2MnlNRLSlW8bZnhL85wtnn4vbQL4C/QqlFARywLKyygSz/oLoagKHfKlLQS4PDgd19JdMv5ePFkg/GFtLvAg5/JLnb43QNyAKNztMyG+tUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsKij185; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4MQpE020705
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kofxhc8N7wzIQRIEJ2kzWHMlZjkxlt2XuX/b69ntAxg=; b=jsKij185oRIwGFTC
	G06TFUIWYpY4f12Wthm6UyjD6BDpogiHwBR6oQTJqXJs9d6zyTjzlfzacvztGpx1
	6+2gq8uEzZhUGwTY3XUnaTZG2vvLVsix1mimyzh5+WrtbZnAPN2bk0XSZ1/Ehdfn
	D+qKWrXdDwsuWb5GvzzPpwdzoN5pXN17XAvu1HnDL6w1RH2Zbuq74p5/5OGBfVsP
	q5KJ9qOMEo4EOt/n8RoinQMfvEQayXUbxoWeUuu4GkKl93yb65TbPuJDLmqy2ohr
	ToDiFU6Za5dGLHYATDccYyUHHujnEcFUP2lra5k+6MazM49xbMValf447RHkwGQm
	Pns/Ew==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x88jtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:03:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2465cc58b28so26235485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206186; x=1756810986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kofxhc8N7wzIQRIEJ2kzWHMlZjkxlt2XuX/b69ntAxg=;
        b=jyey70+JM/AQOcZGE4Hm7xgNSAU462l8/28866MFvs4eIsuCviop5YADPZ1FWXa1nD
         2FKpjOe/mWpJ10UDBC8gKvAb/Q9j/vG6BkcA5Wb7WX5Kxr/HYr1x9Hel5LpuRp85pXvE
         S69pVvhFWiUqGc5YPjl3XY3b7Mn8y+mzN9HpOVC0VTqxX5mw4cjGL3fQAqSbueLXB1bC
         g8IaUjZPcD3RgErFE7RGFd25kcJ4al779NO4Klioji5q67H9TzadYlILLedivfactf3c
         sUaVpkzfDGgj1OVJB9gTjU0FAn1GRNLaCXkAFU1umo4wLAnMolU1HzoUH/zLlRRxEkuz
         MjgA==
X-Forwarded-Encrypted: i=1; AJvYcCXanCzYhgnYwm+Xr9lsEpyi6zKTYRUBVzLT6lEL4h4g8m9ne6LfZif+z+0p8l1trrWf/I27ALDsHhjk+lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdnM5neDkhE7y+jxq5oZsb7Tt53/77JfsBc9km5rWuW6B871s
	56jNW3ZDX7Pf0TYjTG2zrkjRyaL+7xRrUiXEAYqEvSHJBxHMfspgjj/uXjZmEe9Rc4P8/fzx5le
	NxWupC1ULeq01rAVvMAbKtRClAl+adGgSPDYvSMw2xAX+D7nDMOjgTwgvuS0mwDnmbUg=
X-Gm-Gg: ASbGnct1sdj5Wpib8g3+1Zfrjr5rDx+G+u9+t9wrYxDOIjgFw44xZpJ4YfmAJ8vf3lz
	U++zST75S2o/EloS7FQIsg1wvalDaGTj7rOsOhDqzZiCIQr87/fzclbuPKxku7oVOhXRyoFnolC
	O26eZin8+qkcP7m8BojbHmVprIAibL9QKMUQB6QzfReAN/vZKDj2Mhliekh9SH99VSqrWoZyxBU
	y6NzDhZ3xH33NWzMar7ZAM27xFWCQH5d29PYVWOw35WiraRgwPu43awCiz5yJ/Z2D4Zcx53TYEf
	XN8KD7fwBxrvV1eP6bmvqD1cYoWimV20k5bH9aVy3ZaWLhpG3gvumvtqkYWVz0dLQqfX0pmcbsk
	=
X-Received: by 2002:a17:902:ce90:b0:246:d769:3018 with SMTP id d9443c01a7336-248753a2757mr14868445ad.12.1756206185942;
        Tue, 26 Aug 2025 04:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNR5imklYJZBTdqQxwSRi1KNrrUdX7w5o4w6VRejdpd1suCFnhxoCDkM0yPiR7w9hpzP36Fw==
X-Received: by 2002:a17:902:ce90:b0:246:d769:3018 with SMTP id d9443c01a7336-248753a2757mr14867625ad.12.1756206185313;
        Tue, 26 Aug 2025 04:03:05 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:03:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:32:53 +0530
Subject: [PATCH v3 1/3] dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v3-1-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=941;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jBBl6A3Sxsg2d6MaEgBHO65kZTpSDglRvHQ0xA/RmfI=;
 b=1sSlBVLmp2op60IIE8JykrDJE0XwehHkU6lVFh/THdWWUN/8OY+3uAMfhq9qj47gOcrJq6838
 saX8h+IJs2zD3adnZjsn0lc2ZPZOrgWNOHOhUL3j+p6YIKzf1F66i+b
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: dynfsqAKdqZrpU4qMs8StFIp7ntMGivr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX3OJc2Gd1Z1tW
 ZWKtLhE8uJplrgJYejxtrhguqj53BRD9MwW9O/PgXzsD0TyzJmeADYQm8ptgWFwrGLdYUxIdBPJ
 KpSs91z+doEJAEGyBgS0kPajMvP9/XvlitiF7iefDLa4aqZQbrtLt3QlSQd4eMGys5XtBo9Z6C0
 A5ER9rWy+Rup9nXMn7a9DjuKwDb7wZXjGQxAFgH7vfCn8+jh+3nGck8ZF+5iA4O/VTUBT4y5Ukp
 N+K/3g2gOkpY6bFk3Zlo2qzxllgu+F6j140fdzdxn9hPVKGE9NjOkuMYh+2KyJSyRy7sreDZjeZ
 4FVCdEHc9hqUlh9X5mzeDQT3IaTUW8ntClfjwLjpw9P48THmLbtc9goFdcEjo0JXnkeNKgoCkmz
 IXZBSvCv
X-Proofpoint-GUID: dynfsqAKdqZrpU4qMs8StFIp7ntMGivr
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad946a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ly1VyIkaSgMpB_u5KqwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On the Qualcomm SM8750 platform the PCIe host is compatible with the
DWC controller present on the SM8550 platorm.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index dbce671ba011c8991842af6d6c761ec081be24cb..38b561e23c1fda677ce2d4257e1084a384648835 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
+              - qcom,pcie-sm8750
           - const: qcom,pcie-sm8550
 
   reg:

-- 
2.34.1


