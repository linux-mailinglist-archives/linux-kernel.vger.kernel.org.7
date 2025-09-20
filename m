Return-Path: <linux-kernel+bounces-825475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F26B8BE0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE960A0708F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2A234984;
	Sat, 20 Sep 2025 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JppcwkTG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC0227EA8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338481; cv=none; b=J6hagYlqChp/w6e6csg3AzOlBSzjinvhdHS1VoiUjDR3o8aSmtSLy9/tar6JPrP8OP7nCp9mAPK8yhwwG2dvFfp1sG2LzdiIcMMNItbSEA9seaxGd3UbD1i8kf8csfn5bl/VSrWugfMIYnXd0KPr11xvuWWJz8I762UoSCuBvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338481; c=relaxed/simple;
	bh=dJA73O3dMi/pqX8EKZQSD9wv7GpWdJetJbicq4mFIDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOtWT+sgqjchjXDzSRm3ITDR6Z0qOo/92GdXmA9yEFkn71K0UxmC3XfGRLL6g8C0eRE6HNYWMZfsWNzGYr/72EI7QAEk0r5ObbEGdKLwKvkJx8mYMH5AtkzsmPZAob8FaD3eZiXIRBXU6cm/K8P6Hx+cP/sx2A6idD7tUlwF7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JppcwkTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FWUe023788
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GML8ureMAch
	wx8vpYthv/JvdPI2pl69vuBTqtCyVutE=; b=JppcwkTGoOok13dBZ2ghU/+mHIo
	XOxwUeiHHUSOJf2DQrdj9ftC1MzZzQ6pI9PiasPTlS9psFn9GZbmfKxYfbFp4Bi0
	ZABnsGHn6IGYtEQoImjBW2dpSAWNRO07nyYJPwUy26znHVunu2pWYb/4euPQHVmx
	dip5WkJ4gIwVzDpYYtITei76v+3nvZhC7TUAM1Y5WfXgOFT6ygjCAKyuUeALP1OO
	cjpPVl9FozRpSqNKujWlTSX/WprxkdcvsTwJoa6W9exQg9zQjNoLsNq9nd9aEbIt
	D+83Jgbp4d7A2Z5eZ9oYU5NxDeYXSoO1ZchIq6SxJKVeZJ7w8CjEf22xCPw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwmfxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77d19ec75bcso2489417b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338478; x=1758943278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GML8ureMAchwx8vpYthv/JvdPI2pl69vuBTqtCyVutE=;
        b=kU6g/W+TGfixZWa8iX/QrxeS96hbg2Z4E9hrAnIMdVH10QeyEHJmneZzaUK670PGj5
         wvyB/eNwJui3aO25rv6vvEjYzWNwmJRYn7n846Bdwn8RxdvjCzdX//TVm9iMakDaFCF/
         QMeImVSdCB4qgqL2H2wiJygehQCQsKsoTO9S+YZXdgGRplcOyiTwd8XPvubnIU8geteC
         mXvsGFPzE0js+ODN42/Dn+wiUrJrqdM0tCFHQsl9yqHjCsaHF0StZIO9Ga338BYOZ2I0
         WtIZ6pbNprX1ekEQC65gxEe2I1iVuTzutk4r7ZsnxtTx9SaAgw6hSSFSL4ErI8L10xMx
         CHxw==
X-Gm-Message-State: AOJu0YxRzGgSvPUq9NvLUL2J7jMWudHre3GaPQmRgo9GxC5JgOoXJbkt
	RFwtNdDzWabzG0BCA7wJZjiV62nlhjWUXob6E53d6xgJwjEfslv/ZcWpdvYxjExxU3YWP/ebEH9
	H/CsBOXVtWscK6beqADaBZ8RvLpQnrb0Sp+jGnsnNAlZabhx6H7FGgEv8RTRdPcSiVDw=
X-Gm-Gg: ASbGncujJGcivnwXYFv8uNwURBOw3cBGth3yJ7ILv2G57ei/xLZDdBnc2CR7vX9AemP
	kl2c+pEfeAFkxdjDRvOfUuhbgLylZC/zWqi8knwRkWZR57kKT0QpkjHMDugb6pB4PEFF8jRIkUi
	A4KBtIkvVtYhBkXCFjssNTRxZ+nQfjmrvq+V/VC61NAGxHu+UF8le646blW1T94csIjgk7EqTfP
	/sOwV3fMzYThJcRvBlU5OJApOReX0Qx+nnwJ91AjswLyzcfIQWsIg+LaCy6mYGT0qpBKbob/QIb
	JOPnf5yBjfcNjbnozYMMTGKkpeacVUSlE9llxoUslH4WK7Vok6xl98xlOfFVORy+Z/R16zN4H9V
	SfLSAW1ClITgk903Q
X-Received: by 2002:a05:6a20:5491:b0:243:78a:828c with SMTP id adf61e73a8af0-2927723466fmr8460145637.51.1758338478086;
        Fri, 19 Sep 2025 20:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo3UQ3Zyf00PaJ6fvkX8fIq4kwna0eBd+Z2NMvErSf3djLCGdVAB0D7+Mb7C6OXe9h8e7FoA==
X-Received: by 2002:a05:6a20:5491:b0:243:78a:828c with SMTP id adf61e73a8af0-2927723466fmr8460121637.51.1758338477668;
        Fri, 19 Sep 2025 20:21:17 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:16 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 3/9] dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
Date: Fri, 19 Sep 2025 20:21:02 -0700
Message-Id: <20250920032108.242643-4-wesley.cheng@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68ce1daf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4j6cOweM1wKm_1e2C94A:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7G7VRlS/55Ow
 KMutszYBUDPON8z6Zw0DsWIZWedH3at4HO8HKc3EspkU63dl7hoyOnzYycVIAWpb2zlcDdZ1+2y
 aYQTQ9Q2O4dg7qrfhuQLIU0gC7hILngfT0urjr61bHb1VVPd/fPoOHQI4YrPHnzIo9rHeWbvnke
 /dUX88b4lI+SiDfVnOvn7k5toXEx+Wnft4djAavYu4ldk/xsNRyA9bcRlMau43nVbmM1ndKQR58
 V+7rJY0QF5iHHmNshXZYWP8j7ipgXXucJEBgZE1kdElvNUED9zV79Su3Av0wwvsWNGxPcb9MDdr
 u9VtIqKhZjIxC6MRCsYjsuvLFO79fBQLT0tEO+7GPqIboSQEBE1tt7qaTkBpLZ5FD/NHM7vVD3V
 YJ/xJwBt
X-Proofpoint-GUID: nvKotCFI9a-7DHyVfNzhBpwnXf6n6qhL
X-Proofpoint-ORIG-GUID: nvKotCFI9a-7DHyVfNzhBpwnXf6n6qhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

Add the Glymur compatible to the M31 eUSB2 PHY, and use the SM8750 as
the fallback.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml   | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
index c84c62d0e8cb..b96b1ee80257 100644
--- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
@@ -15,9 +15,12 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,sm8750-m31-eusb2-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-m31-eusb2-phy
+          - const: qcom,sm8750-m31-eusb2-phy
+      - const: qcom,sm8750-m31-eusb2-phy
 
   reg:
     maxItems: 1
@@ -53,8 +56,6 @@ required:
   - compatible
   - reg
   - "#phy-cells"
-  - clocks
-  - clock-names
   - resets
   - vdd-supply
   - vdda12-supply

