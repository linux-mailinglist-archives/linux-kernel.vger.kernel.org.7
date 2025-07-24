Return-Path: <linux-kernel+bounces-743976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79EB1067B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9536AE6B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9F274B5F;
	Thu, 24 Jul 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lI7Ro7Hd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58628C2AA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349367; cv=none; b=Q9zrQeANnVOa3iKlxtAABNtOwAA8LDcBboUXsARbN7EpGZ0J1/Z5VgOf8Sa5+YGKGI+DRyVmV6hgxTXm3507Hd6sW1OYQMEp3zmaE8RRCFIBRhfYkLbgRt46eIGE8LGj872rzbU9nio5dIZZC0hdJ/mQC1LLyrIRJFMfwQgqQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349367; c=relaxed/simple;
	bh=PPHlJY0DBTcDAyhfFMcfSfIO7XmnVHjq+LatoXOHmkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nc47I0g8rcpsgbn7kN7+DaJtikmz7UNnUZABA5QI59h67Aty8Cti81cGFZma/9y4ghxovkk/PRubveCo7n9j1Nt1AvxImyxyU06/Qf7oLxuUtIbrlG92p3i+GPSs4JIE0TcNlcEn6J+kymfEGPD6I2iHh7fqhurJ7W+gJHFzNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lI7Ro7Hd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9NgCV022229
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	moYVE4cTWaiaAnOXhb632zZFM1UL32qTF0JTX3SvtkI=; b=lI7Ro7HdcPEwvycZ
	i9oVlLDxas5mhM78zMZFs7DZk1h9GerNubNEHnL+M4ilmDOs5GXKW9HfqFSQ27V1
	p4o8Se822Q+o4u7VbrQShnhpqJYGGm/kWg87lOe5J2FrguL2U3sDfaC1xJBexAIa
	URbHPGL/55JGF0M253trHrFE5X73PwQTe3GRkppDs6+QvO8D7IUYYkjBBNbE+PMZ
	rI5bnVHniCnrioGFgGLVM4FDVCBSGBoZOtHrkHPCCmJ8APzIbfUOt9Nnh2dqF+h3
	lAY3/Pmce7kg9DKPUM0ynqj3WDRHC237tTfKzWUyHDbHGf/NMO2Haf6sfBRbXxLm
	93k9hQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48313kjusx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2349fe994a9so6905305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349363; x=1753954163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moYVE4cTWaiaAnOXhb632zZFM1UL32qTF0JTX3SvtkI=;
        b=wK4a/HGH7s+tslUB3x3tIXN9iNIHuNCiVRH29nz3oZxvmkNs6LaDuZxkdo8wlCwraj
         ws9PAKJxLsMDnpBrkTCeDUlOCIMeBJ32SjEpnIhagz58CyPVQkVC9pz0AP5XLpq7VK0P
         LJdBBVsQRl4eCYnTlvzHLrUnEaLZX5AdQOxYDG/1vv4P9SCYggvcdsaRlGojADnbQXj/
         JpLLKZxHZTDLj/uLJVdZrHgDdCyOCR9ycN3UuPfx5ArT2eo6d0csF8u1osf3otTfkElS
         Lb032aul5wLTXahnQ7CU1QrRkd+8xJ9u/Zwyrhe0lstEJy7uDX4/yY1nszeBW7n4NlJh
         tkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB6XvupbiZGaZxWue2R9BfOZhatBGK5mhVtlDEdxY0/Qu9//KgyMek/VXS7xbwfY11txQx4xsPnc5yp0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxMNCl72OXXqDSzZaAmjI0qKIaalc8jSNrCPtv8Sqp0LOryly
	uBhlQzDhGL4TOHEiSvsCBpU4cpZXt89sScBt4eXtoXQU9PVmPHfAljJm+TMtL0ELK1xhrXir1Qt
	Rwyua43rJbaQkWKaWjWO0qQMLMi8ON/wPxPVVX5w+/gRDyJ3DotxveRDMXe4HY/z2YRM=
X-Gm-Gg: ASbGncstoXOkiHOsnHgTzIk3mLrtOkYNoMKpEFiMEV34QDLAckQ4EOFVP0nOrvWjulV
	ikrLG/2BXYsuAhjHyHFHrCPUyemq2J6E1lE4mzwT9viHslPftXJkoPxfwWz5wFWeJdyy/zUmOHD
	FakxSixwSIj6JVPVVN0PIbTdxvKXgMrz1e0z2bLrSMx+Pm8+5NgGA5rUB4gIawKYo4z/Qpk1egS
	TVYX+3XQFZ/N/K9OjpnCtMV5m6SSABZwEZjYpS19GnNQU/7T9DN6dtfxYlU+VFouCndcjDkPq6u
	ku3qsPrmxpfgHFR4VjaCcNBCQzdDSS8oXLCl1shPJFHAPQ4agYQ0LBoUWfXsWpzg
X-Received: by 2002:a17:903:198b:b0:235:e942:cb9e with SMTP id d9443c01a7336-23f9813ac30mr82926015ad.9.1753349363184;
        Thu, 24 Jul 2025 02:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzUDlAxoq2iIvpAwTAbSpSv3iI8qSUmVJX5tT0OXMmNLVHMLk0kaGDM/qQeIZUKeuV+/ACeQ==
X-Received: by 2002:a17:903:198b:b0:235:e942:cb9e with SMTP id d9443c01a7336-23f9813ac30mr82925285ad.9.1753349362286;
        Thu, 24 Jul 2025 02:29:22 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f8a0sm11276505ad.24.2025.07.24.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:29:22 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:59:09 +0530
Subject: [PATCH v2 1/7] dt-bindings: clock: qcom-rpmhcc: Add support for
 Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-glymur_clock_controllers-v2-1-ab95c07002b4@oss.qualcomm.com>
References: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
In-Reply-To: <20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MCBTYWx0ZWRfX+TlbBvIh4L+E
 8ahfRFF/pdIwlQkZJyME+o0HPAAU4Cc31lCbk5+2UCfSiqmaPKx8CtQF/dEkpopvBIlHaCe4O5w
 GKdhjWRLWHvBlnOzA/hL9N+MCuQ1br9hMfbuxCt8Qrvo9dkuAkZeX3aZrDdCN8KoqcdnfgbcYy9
 +t4X23FBy5UB/n1t7iS35pS0gK7b/P15dujbSyVsCXkzSYiPqvzpdn4hhCEv2k7qlyCMdAejitR
 G06lbCgsgxhJP49ASqH5i/7VJRH33XqrDabBpu7pfLvhndKbNAhEMr3lGLzDKehO5ylYXlib3Lc
 JSpkbhu1HbEZn2xlBMOtnYffB0Ki1HUT724X8Z2x/2PYyt5HSr1+D6EzAMtaiWCm3OpZ4v8/dZq
 tcJKC5XH/+k/S8AW3Fnz91t3dY3G3kqm0sy6W7zY3buTCw+NB1mEAl8YqbYEhvrRyelv4Vn5
X-Proofpoint-ORIG-GUID: 0LEiPiKRaW5qlJKi9DkmidTThOP5kVqR
X-Proofpoint-GUID: 0LEiPiKRaW5qlJKi9DkmidTThOP5kVqR
X-Authority-Analysis: v=2.4 cv=C/TpyRP+ c=1 sm=1 tr=0 ts=6881fcf4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZmWPdgOBrplkPgKrADIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240070

Add RPMHCC clock documentation for Glymur SoCs to ensure proper clock
configuration.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index a4414ba0b287b23e69a913d10befa5d7368ff08b..78fa0572668578c17474e84250fed18b48b93b68 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,glymur-rpmh-clk
       - qcom,milos-rpmh-clk
       - qcom,qcs615-rpmh-clk
       - qcom,qdu1000-rpmh-clk

-- 
2.34.1


