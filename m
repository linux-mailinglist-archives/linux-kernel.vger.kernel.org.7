Return-Path: <linux-kernel+bounces-825472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EBB8BDED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CB6A05B73
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50724223DE9;
	Sat, 20 Sep 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3YmAHs1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19761F4621
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338477; cv=none; b=nzGygIRt163UEYQ1Mtg/vNrlIghEYubDC1ndDVCK1qN5dg1VE3DWibL9mXYe9rhy8o5wGCjBl1qmOhAdnCcd2XpIwptlHQ8D4ANlY2+gMfThhsaABEWJ6rV0vZOpp4HIV36o/Gh4a5clxaX9vMpGgGgf3bL741t3UUU2CUgtNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338477; c=relaxed/simple;
	bh=PqUjMQNf8YZ2okXi7HcjlR0ay9cNBzPa0lh9m/FAw9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqYbKXtLpi2xJU2p0c6WcFADFILX5ks9PovgzIWoitZaYP/IoRp+W1ednPSZcPhsEIESAnbsR/kRC7LHjnKfm39872hmqpJQPRv3H2DtiBBLzT32sKh9P3TD5lMZDsT/RnZBHleeAKkOo3TYvpg2IQvQnwhMKWVIIS2PZ7fJJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3YmAHs1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FYWc011324
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mN8wYVl6ESU9lxZvT+z+knTGjWTBarbi95s
	9t96uFCY=; b=D3YmAHs1L6zuwjw06urITN4y7EtDHdeq56luBVMG7I27Lr5atif
	GfJ3PrmQJH4Ag9rXbyWWQMvdgTAjLTeNJBnvG0KACRgZDiw9ranfQnZSXXXjhqaJ
	3YBn7FIVA2kkzTJGsHvLwXDLWmeMfYfEREJh2a++BH56KdStgU0rSbjRmK9/rrgc
	t1RYZaqPsjg+W313FWDVs4pzCON6CuxQhTDwximWmb7d6peYOsIqva9+aRGk4swA
	rGPQkCXBvrXgPrfKYucxbTPJYpMqFtkrozrEYxuSlo9L8D9B72W0Y2VEibD8ciEl
	OiQ4Oglhg7jTf6g/xGvjMIu6jmOmO18zjVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy4f8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f59889so31245235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338474; x=1758943274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mN8wYVl6ESU9lxZvT+z+knTGjWTBarbi95s9t96uFCY=;
        b=k+K3ONqWkqYf5Pl1O2LE8xTR9wgV+8sHYmE1NIdGG1T+nRA2IXMRl3hpcV4XVtKqBu
         bh30kzfuSGi2bFTmIexPKpEj2wmxL5HOl4Yo7+fBxhaasdIxiolRl3cFNWpUSIzTM46d
         M95EdTjRBvQ2LXN7PC7h6QPtzlplIsY5EXbLdsTgYucAOxfPMlhbBDY9k+qEFC9/8gtp
         pqh4fENyPYc+5aKUw+fRkLK2/TZ7y695dzQKT1oI3/D90JWE2Q08O/jIu5Od24EuKZtk
         OSmF384uiOnbJ43QaR7+Wt/ptdcpu+A/NgOF9BflwB2a3Am035JYZ7JK/9WX+vmsZKKE
         J+Tw==
X-Gm-Message-State: AOJu0Ywc7inarF080qDhyfgtDJBAmAnNjaslAfWA/aVXtVH73EvupSQz
	B9SgMrD7s8kQfMORRNoN3WU86FpkPZJdhnst0ECCQzlZJZxiBHRWakFKy495Hp4A2Yprts1Haag
	eVKDva5LTZ6MESEI21dpvs3MXQoeW/AYFJJfJs6kaVM1QzLKx269gh3vldr3+MAX9OOA=
X-Gm-Gg: ASbGncuI48xbG0pgvZbCG0cd3U6NyTum/SKWrCWoRrz4uZJMdoN4uKMq64gGoyNYffq
	qJfDjSVsZiTR02gNcaCxik0R3LylkSX26QyDBc6PKf7L53IA3y20KqyhlZDxjSEzYtGKLf8gjjE
	bivYFIu5+JzDJJUduirNXyukX9q8ZBvhCwkI3Y5qyLJKOpnYnegEYTZvctwclYO/NyfBdez3zCj
	dRqyUYda4Cav5BpiCcCl1b8cUnNiG+Ae0kLinYmTfRrI/r9+JISUyJPahG0IVo9MjCCbsh0oeOw
	pj8g88DtQ6br9cFmAXTvw/ggN+pWTxuaz+WYECvPfO+1O3wguLWUbIcmvJE7LX13racb6PfXa6W
	G9JlqqDqnpZ/Tu3UR
X-Received: by 2002:a17:902:f645:b0:269:a4c5:f442 with SMTP id d9443c01a7336-269ba527e9emr74545425ad.47.1758338473684;
        Fri, 19 Sep 2025 20:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeReC8gmZ5NxVSWhUvUGV0oy+A6Sr9TpiqHXGqgd1xFA4p7XvnSQnBO/UwfTe45cPbjeV1ew==
X-Received: by 2002:a17:902:f645:b0:269:a4c5:f442 with SMTP id d9443c01a7336-269ba527e9emr74545085ad.47.1758338473178;
        Fri, 19 Sep 2025 20:21:13 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:12 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 0/9] Introduce Glymur USB support
Date: Fri, 19 Sep 2025 20:20:59 -0700
Message-Id: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+1zZyZhSE0mt
 gbczaLsbl3VG5ZEXjUW4ZkKRHS0SYwtr3vrKRF7Cy796xQxez7354OZRl6ZhM1HNgNPVNJulDfu
 YDDwZw5i45b/KHv5ySPJdJwakfkL94ar83SWU6/FzAuiyzNTnWrJJupwO92rddqEK1BHYrlp11m
 X4qVUAQe+KgCnJbcj28dI6dR0Jg62wZlIYoqWxj7HyKblEbsMOINyrGUiQjo67MfNi0rdChOw5z
 w/EYN7DUmfh7p5MD9w5JlhZX6RPnyXIZkmlRRMbBns/3BN1EYXm2qMxL+zqfrfKv1PX6CU/Ei6N
 irNTREGnJwek90Ba2W0Ed9K7eDA3pBd61/gJZK9BQ3UszmyBZoiBrjZ5zzY35Z+XxAcNPss9Y4O
 sA+QqGFz
X-Proofpoint-ORIG-GUID: CtuOCgQ-JvK8UYB8PNAqkFXvNT4Bogsj
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68ce1daa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=KpXeH89YwCTRUSzem1gA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: CtuOCgQ-JvK8UYB8PNAqkFXvNT4Bogsj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

This series enables the PHY level changes that are required to support
the type C based controllers and the multiport controller.  The typeC
ports utilize a usb43dp based QMP PHY for the SSUSB path, while using
the M31 eUSB2 PHY for the HSUSB path.  For the multiport controller,
it will utilize two QMP UNI PHYs for the SSUSB path, and two M31 eUSB2
PHYs for the HSUSB path.

Elson Roy Serrao (1):
  phy: qualcomm: Update the QMP clamp register for V6

Wesley Cheng (8):
  dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
  dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
  dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
  dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
  phy: qualcomm: qmp-combo: Update QMP PHY with Glymur settings
  phy: qualcomm: qmp-usb: Add support for Glymur USB UNI PHY
  phy: qualcomm: m31-eusb2: Make clkref an optional resource
  phy: qualcomm: m31-eusb2: Make USB repeater optional

 .../bindings/phy/qcom,m31-eusb2-phy.yaml      |  11 +-
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   7 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  45 +-
 .../bindings/usb/qcom,snps-dwc3.yaml          |  26 +
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c     |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 347 +++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    |  12 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h    |  17 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   |  12 +
 .../qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h   | 639 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 163 +++++
 .../phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h  |  33 +
 .../phy-qcom-qmp-usb43-qserdes-com-v8.h       | 224 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
 14 files changed, 1513 insertions(+), 31 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h


