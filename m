Return-Path: <linux-kernel+bounces-737146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D2B0A85D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BDE5A394E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9830C2E3366;
	Fri, 18 Jul 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3OWBQ0B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7711DE2B4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855733; cv=none; b=DSwaZtGJSDl2yNpze4S2wXxcX1X+x9vWrKIBzymBmUktMec6WJGRL2o+MWRvbet/6fVuwdjchwTo5OQChPHxCTnK7WMZneSRElzWqgWHe8xa4wv1ZOPZxL9710xWcBMMoN/Iw6NbQLf2ioKO8iNYylq+MH6QKvO1rPgkhc+q4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855733; c=relaxed/simple;
	bh=IwxC3fpHxLFPYEQoaZS4yJMMljex/qOEtV0vlUC9pvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaAdV6ckNbmD7QLQZ6pZcDhUGghIIB4akjQC92KGqGoGu4s0pm2PiqKOjhltB+Jum6i+9nqaSuUJVIInbeQXZK3hTdl/sUjbS48xIc+mcKztCSJypDhi0J8lqe7zZ7N6K/P8uPvskeKdlPWmxzLrNb2+L5ArMylnG5M2w3BT4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3OWBQ0B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8UNRA016003
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDxbLObSKfcdBQzl/HXRVZp/xBslvDyyovwYDO8QatA=; b=n3OWBQ0B5OhmwxoB
	lQ+mdmXYMAtj12I50g8/OLiwf82gPajXENlXdMddE8LvW+CwHVryG8z2kV9lR28o
	402WqQApieBeRXHIMoXZ16S9P8UeOPy1SlxYK1oYi0L4Mw1rLFXirunoC4ZELLV3
	VWLGTLulil4XW6LOdtetgcOMsoflsVxhOGraQjEbpIfjqKk/I5NtQgLUWj1NunNM
	9D+A+VA0v9UiCbTfGhsse86KmsJiJy2ze9JTmHSLCJuN3gfh5D0SYmFZbgl9LQbs
	2dRhDtUQUfLWxMcSzrEWcEy4dcLoatrppyzngdqFGT2BVx/Jt4K/1k61YqBZ3rQr
	N2QuTw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyy66v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:22:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e338e627f1so603469485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855729; x=1753460529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDxbLObSKfcdBQzl/HXRVZp/xBslvDyyovwYDO8QatA=;
        b=kLsBvTWV01GWKvfDHPAoixpQnVYlTejDPI04+pSwyRRaUB8xrZOOFkVtOZNYJ03kkT
         tuVHBZ1cmxGrmd1yt0V+2OQnbUxeCreDacX+JtPWNr2zd1c3+af25DlM7n9S6lCWsKLs
         JNn49+wHO0ZhRipel6PYw9igwlZeUZOyjB2/eBJwMZzU2jNhIh80OROPPuyEJ2V0SWa3
         VxoAmuR8/uLpGfJHKi275nrKM3IQLU5PH7zblJ0nOIhpiz1waU4/wWcmWkST/+miQoyp
         24STIxrY2QEKxfz5vhZ2/b8lFnlAsnVzVoDNvVcJdsRbBz3j+N5xkut1lkyzUQRTIeEZ
         4Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCU0OlJhRZfAiqJj+IkzxsRZUbeiwpASzh6CFgeYYPhc0Lmzn0Ggpf4fwrAYMmohte+2AikU36VDyXMreBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/zcBFpDL0V3F7+YGRheV9wf1v/wm34v9XqCyUzNHeREkczUq
	OOvApOqbNe9CJwPiuvEwODfPCrcSdBdi8E0s20ABjXAo1pPqcygVcHEuBX72EDXOxQptJHLUl3e
	tyrmSvgWnhgzYZuXLt7ArODgWts6FchN61IfL+ZMHC3FSOaxQw0zyxpBIwMHzmlIyX1c=
X-Gm-Gg: ASbGncu54EscIj64M9BptDt4/VZZGbLa4DgyfomHLgj/fP0aMYLKAiTBKljB40amu6H
	JR4VOc9fqUxRfUSQs6uM9SWlK49dvd2ZCBbfoJBQ8wNljXbWOcNkUC0GSAzzz4t0bgnTGcTm9gO
	53tp1AU/lLsEj5/0p3pOQTlTIrWTYU4jM542TMbF/uyBgG6H6fdiH3AXLJIEJa9fep/+t1FZ+DD
	NgfG9vIGJSPIuk6SmCaLzBc7n37U2QF+inyGceyuTdcMf8hUkGK6AoK1uufDx5Z1jxlxmGY1LmH
	0hLV/5W4HLMEk5D2aHpERKdiydISQYoKqoQYTfU50Yd5qUJCLvWGat5jCCwOZd5utmblVWK8S0u
	gDf4RndwNZsZIOQo2IlxcfzHup/AEqTTGyjw9wNFg5FT/bD/szMlD
X-Received: by 2002:a05:620a:4690:b0:7e3:4416:1033 with SMTP id af79cd13be357-7e356b2ceebmr453841585a.60.1752855231069;
        Fri, 18 Jul 2025 09:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENmojVPRULhryYzYcjKAupjpRcli1UOb7Y9P15EYANIEcwieDAArApyc6GdRKsYu170ABl+Q==
X-Received: by 2002:a05:620a:4690:b0:7e3:4416:1033 with SMTP id af79cd13be357-7e356b2ceebmr453810085a.60.1752855227144;
        Fri, 18 Jul 2025 09:13:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:39 +0300
Subject: [PATCH 1/8] dt-bindings: power: qcom-rpmpd: split RPMh domains
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-1-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13688;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IwxC3fpHxLFPYEQoaZS4yJMMljex/qOEtV0vlUC9pvc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3qE/IIpouo3rTZyCInPRVbbxuttOTY5iXq
 leHAsUz3riJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1RdgB/0ZkP60RomiSf+x/lJdLDp0LsqE8pBA9G4IpWyWsuCWazwfbBFZsNPfLZo/rCelfw3phUG
 ++lgsgFoaKmmgHGxuX2YZkTTC4hqt4XVYC0eWZPZqRBwlwhwBUQ6FKrppEqUUf4hVh3NyToHq6I
 RSfKa54nUCL1Ij/FU1YJhiOxyZv9cS61mZPfbP4RdZ1p5tq1wFPtYhEIf6718YIHEGLUpfSyv6N
 u5ZbIBFya6UaGE7krKSn2kAddk9NThFtKtiWpZN6MG+iTEfiTCyQZlOMiKyXik8+WwFw9RVspIL
 Ntyp7+GmY5JXs8MF8ydA9C5D1wN9uzbaLoLN9cJy4Gys+8aV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fKkQxjWh2WBdiVi9R36O85xsOIfmmTiZ
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=687a74b2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LdBTWnh5yz5cCWo1om8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOCBTYWx0ZWRfXwWe4Q2fjt1T3
 Qsxljc01VUR2PjQHiYMmOK0CiP/x7azlWqdCOSmM72cOM/mXtBSiOIFIhJhL+qP3G0K0kgwps1/
 4k9/sYStaBrJ7fAsUuRD3g38d2M+3Lh95QfzzOpeLOKnyfkokPI6XX2/5r3MFrtB6tbz2xg3M2e
 zrM+kDgM9G411wUILt+OacALe6mUN17NIoFk4P2aLgeG2gW1I54KKRKT7H6pLsWtiHNezkUJOHV
 urK6RBz8UqgxlqXLZIW37GDwmF+WgGgmqGLchvipyrJe7P0YkKMR6HVFUqS9Vi/L7THmo2wxfYh
 KnkAgDVKg12Y5RmsZEc6ia3F/YKr16gpgHiCqew++oRsB/OkNm7Emm68ClTJXuLp72TcwgTbZaP
 LfcIhwo9hBYsBuNs88LEu0kH1MvnjkZSntqFx9yi5K94bJJmvfCBkN7GZUGzf/I4/9ztcvPN
X-Proofpoint-GUID: fKkQxjWh2WBdiVi9R36O85xsOIfmmTiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=834
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180128

Historically both RPM and RPMh domain definitions were a part of the
same, qcom-rpmpd.h header. Now as we have a separate header for RPMh
definitions, qcom,rpmhpd.h, move all RPMh power domain definitions to
that header.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 233 ++++++++++++++++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h  | 228 +------------------------------
 2 files changed, 234 insertions(+), 227 deletions(-)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index e54ffa3614515ca19e7ef93d33c22645c13a128b..73cceb88953f705106486b7e111b3ffc39c85664 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -29,4 +29,237 @@
 #define RPMHPD_NSP2             19
 #define RPMHPD_GMXC		20
 
+/* RPMh Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_TURBO_L4		452
+#define RPMH_REGULATOR_LEVEL_TURBO_L5		456
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO	464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
+
+/*
+ * Platform-specific power domain bindings. Don't add new entries here, use
+ * RPMHPD_* above.
+ */
+
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
+/* SDM670 Power Domain Indexes */
+#define SDM670_MX	0
+#define SDM670_MX_AO	1
+#define SDM670_CX	2
+#define SDM670_CX_AO	3
+#define SDM670_LMX	4
+#define SDM670_LCX	5
+#define SDM670_GFX	6
+#define SDM670_MSS	7
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDX55 Power Domain Indexes */
+#define SDX55_MSS	0
+#define SDX55_MX	1
+#define SDX55_CX	2
+
+/* SDX65 Power Domain Indexes */
+#define SDX65_MSS	0
+#define SDX65_MX	1
+#define SDX65_MX_AO	2
+#define SDX65_CX	3
+#define SDX65_CX_AO	4
+#define SDX65_MXC	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6350_CX	0
+#define SM6350_GFX	1
+#define SM6350_LCX	2
+#define SM6350_LMX	3
+#define SM6350_MSS	4
+#define SM6350_MX	5
+
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
+/* SA8155P is a special case, kept for backwards compatibility */
+#define SA8155P_CX	SM8150_CX
+#define SA8155P_CX_AO	SM8150_CX_AO
+#define SA8155P_EBI	SM8150_EBI
+#define SA8155P_GFX	SM8150_GFX
+#define SA8155P_MSS	SM8150_MSS
+#define SA8155P_MX	SM8150_MX
+#define SA8155P_MX_AO	SM8150_MX_AO
+
+/* SM8250 Power Domain Indexes */
+#define SM8250_CX	0
+#define SM8250_CX_AO	1
+#define SM8250_EBI	2
+#define SM8250_GFX	3
+#define SM8250_LCX	4
+#define SM8250_LMX	5
+#define SM8250_MMCX	6
+#define SM8250_MMCX_AO	7
+#define SM8250_MX	8
+#define SM8250_MX_AO	9
+
+/* SM8350 Power Domain Indexes */
+#define SM8350_CX	0
+#define SM8350_CX_AO	1
+#define SM8350_EBI	2
+#define SM8350_GFX	3
+#define SM8350_LCX	4
+#define SM8350_LMX	5
+#define SM8350_MMCX	6
+#define SM8350_MMCX_AO	7
+#define SM8350_MX	8
+#define SM8350_MX_AO	9
+#define SM8350_MXC	10
+#define SM8350_MXC_AO	11
+#define SM8350_MSS	12
+
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
+/* SM8550 Power Domain Indexes */
+#define SM8550_CX	0
+#define SM8550_CX_AO	1
+#define SM8550_EBI	2
+#define SM8550_GFX	3
+#define SM8550_LCX	4
+#define SM8550_LMX	5
+#define SM8550_MMCX	6
+#define SM8550_MMCX_AO	7
+#define SM8550_MX	8
+#define SM8550_MX_AO	9
+#define SM8550_MXC	10
+#define SM8550_MXC_AO	11
+#define SM8550_MSS	12
+#define SM8550_NSP	13
+
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
+/* SC7180 Power Domain Indexes */
+#define SC7180_CX	0
+#define SC7180_CX_AO	1
+#define SC7180_GFX	2
+#define SC7180_MX	3
+#define SC7180_MX_AO	4
+#define SC7180_LMX	5
+#define SC7180_LCX	6
+#define SC7180_MSS	7
+
+/* SC7280 Power Domain Indexes */
+#define SC7280_CX	0
+#define SC7280_CX_AO	1
+#define SC7280_EBI	2
+#define SC7280_GFX	3
+#define SC7280_MX	4
+#define SC7280_MX_AO	5
+#define SC7280_LMX	6
+#define SC7280_LCX	7
+#define SC7280_MSS	8
+
+/* SC8180X Power Domain Indexes */
+#define SC8180X_CX	0
+#define SC8180X_CX_AO	1
+#define SC8180X_EBI	2
+#define SC8180X_GFX	3
+#define SC8180X_LCX	4
+#define SC8180X_LMX	5
+#define SC8180X_MMCX	6
+#define SC8180X_MMCX_AO	7
+#define SC8180X_MSS	8
+#define SC8180X_MX	9
+#define SC8180X_MX_AO	10
+
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
 #endif
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index f15bcee7c9283e74dc8e6f9b6b6f73c0ced009e4..d303b3b37f18e0ff63929f3fe197151c5a3d3364 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,66 +4,7 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
-/* SA8775P Power Domain Indexes */
-#define SA8775P_CX	0
-#define SA8775P_CX_AO	1
-#define SA8775P_DDR	2
-#define SA8775P_EBI	3
-#define SA8775P_GFX	4
-#define SA8775P_LCX	5
-#define SA8775P_LMX	6
-#define SA8775P_MMCX	7
-#define SA8775P_MMCX_AO	8
-#define SA8775P_MSS	9
-#define SA8775P_MX	10
-#define SA8775P_MX_AO	11
-#define SA8775P_MXC	12
-#define SA8775P_MXC_AO	13
-#define SA8775P_NSP0	14
-#define SA8775P_NSP1	15
-#define SA8775P_XO	16
-
-/* SDM670 Power Domain Indexes */
-#define SDM670_MX	0
-#define SDM670_MX_AO	1
-#define SDM670_CX	2
-#define SDM670_CX_AO	3
-#define SDM670_LMX	4
-#define SDM670_LCX	5
-#define SDM670_GFX	6
-#define SDM670_MSS	7
-
-/* SDM845 Power Domain Indexes */
-#define SDM845_EBI	0
-#define SDM845_MX	1
-#define SDM845_MX_AO	2
-#define SDM845_CX	3
-#define SDM845_CX_AO	4
-#define SDM845_LMX	5
-#define SDM845_LCX	6
-#define SDM845_GFX	7
-#define SDM845_MSS	8
-
-/* SDX55 Power Domain Indexes */
-#define SDX55_MSS	0
-#define SDX55_MX	1
-#define SDX55_CX	2
-
-/* SDX65 Power Domain Indexes */
-#define SDX65_MSS	0
-#define SDX65_MX	1
-#define SDX65_MX_AO	2
-#define SDX65_CX	3
-#define SDX65_CX_AO	4
-#define SDX65_MXC	5
-
-/* SM6350 Power Domain Indexes */
-#define SM6350_CX	0
-#define SM6350_GFX	1
-#define SM6350_LCX	2
-#define SM6350_LMX	3
-#define SM6350_MSS	4
-#define SM6350_MX	5
+#include <dt-bindings/power/qcom,rpmhpd.h>
 
 /* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0
@@ -77,173 +18,6 @@
 #define SM6375_VDD_LPI_CX	8
 #define SM6375_VDD_LPI_MX	9
 
-/* SM8150 Power Domain Indexes */
-#define SM8150_MSS	0
-#define SM8150_EBI	1
-#define SM8150_LMX	2
-#define SM8150_LCX	3
-#define SM8150_GFX	4
-#define SM8150_MX	5
-#define SM8150_MX_AO	6
-#define SM8150_CX	7
-#define SM8150_CX_AO	8
-#define SM8150_MMCX	9
-#define SM8150_MMCX_AO	10
-
-/* SA8155P is a special case, kept for backwards compatibility */
-#define SA8155P_CX	SM8150_CX
-#define SA8155P_CX_AO	SM8150_CX_AO
-#define SA8155P_EBI	SM8150_EBI
-#define SA8155P_GFX	SM8150_GFX
-#define SA8155P_MSS	SM8150_MSS
-#define SA8155P_MX	SM8150_MX
-#define SA8155P_MX_AO	SM8150_MX_AO
-
-/* SM8250 Power Domain Indexes */
-#define SM8250_CX	0
-#define SM8250_CX_AO	1
-#define SM8250_EBI	2
-#define SM8250_GFX	3
-#define SM8250_LCX	4
-#define SM8250_LMX	5
-#define SM8250_MMCX	6
-#define SM8250_MMCX_AO	7
-#define SM8250_MX	8
-#define SM8250_MX_AO	9
-
-/* SM8350 Power Domain Indexes */
-#define SM8350_CX	0
-#define SM8350_CX_AO	1
-#define SM8350_EBI	2
-#define SM8350_GFX	3
-#define SM8350_LCX	4
-#define SM8350_LMX	5
-#define SM8350_MMCX	6
-#define SM8350_MMCX_AO	7
-#define SM8350_MX	8
-#define SM8350_MX_AO	9
-#define SM8350_MXC	10
-#define SM8350_MXC_AO	11
-#define SM8350_MSS	12
-
-/* SM8450 Power Domain Indexes */
-#define SM8450_CX	0
-#define SM8450_CX_AO	1
-#define SM8450_EBI	2
-#define SM8450_GFX	3
-#define SM8450_LCX	4
-#define SM8450_LMX	5
-#define SM8450_MMCX	6
-#define SM8450_MMCX_AO	7
-#define SM8450_MX	8
-#define SM8450_MX_AO	9
-#define SM8450_MXC	10
-#define SM8450_MXC_AO	11
-#define SM8450_MSS	12
-
-/* SM8550 Power Domain Indexes */
-#define SM8550_CX	0
-#define SM8550_CX_AO	1
-#define SM8550_EBI	2
-#define SM8550_GFX	3
-#define SM8550_LCX	4
-#define SM8550_LMX	5
-#define SM8550_MMCX	6
-#define SM8550_MMCX_AO	7
-#define SM8550_MX	8
-#define SM8550_MX_AO	9
-#define SM8550_MXC	10
-#define SM8550_MXC_AO	11
-#define SM8550_MSS	12
-#define SM8550_NSP	13
-
-/* QDU1000/QRU1000 Power Domain Indexes */
-#define QDU1000_EBI	0
-#define QDU1000_MSS	1
-#define QDU1000_CX	2
-#define QDU1000_MX	3
-
-/* SC7180 Power Domain Indexes */
-#define SC7180_CX	0
-#define SC7180_CX_AO	1
-#define SC7180_GFX	2
-#define SC7180_MX	3
-#define SC7180_MX_AO	4
-#define SC7180_LMX	5
-#define SC7180_LCX	6
-#define SC7180_MSS	7
-
-/* SC7280 Power Domain Indexes */
-#define SC7280_CX	0
-#define SC7280_CX_AO	1
-#define SC7280_EBI	2
-#define SC7280_GFX	3
-#define SC7280_MX	4
-#define SC7280_MX_AO	5
-#define SC7280_LMX	6
-#define SC7280_LCX	7
-#define SC7280_MSS	8
-
-/* SC8180X Power Domain Indexes */
-#define SC8180X_CX	0
-#define SC8180X_CX_AO	1
-#define SC8180X_EBI	2
-#define SC8180X_GFX	3
-#define SC8180X_LCX	4
-#define SC8180X_LMX	5
-#define SC8180X_MMCX	6
-#define SC8180X_MMCX_AO	7
-#define SC8180X_MSS	8
-#define SC8180X_MX	9
-#define SC8180X_MX_AO	10
-
-/* SC8280XP Power Domain Indexes */
-#define SC8280XP_CX		0
-#define SC8280XP_CX_AO		1
-#define SC8280XP_DDR		2
-#define SC8280XP_EBI		3
-#define SC8280XP_GFX		4
-#define SC8280XP_LCX		5
-#define SC8280XP_LMX		6
-#define SC8280XP_MMCX		7
-#define SC8280XP_MMCX_AO	8
-#define SC8280XP_MSS		9
-#define SC8280XP_MX		10
-#define SC8280XP_MXC		12
-#define SC8280XP_MX_AO		11
-#define SC8280XP_NSP		13
-#define SC8280XP_QPHY		14
-#define SC8280XP_XO		15
-
-/* SDM845 Power Domain performance levels */
-#define RPMH_REGULATOR_LEVEL_RETENTION		16
-#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
-#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
-#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
-#define RPMH_REGULATOR_LEVEL_SVS		128
-#define RPMH_REGULATOR_LEVEL_SVS_L0		144
-#define RPMH_REGULATOR_LEVEL_SVS_L1		192
-#define RPMH_REGULATOR_LEVEL_SVS_L2		224
-#define RPMH_REGULATOR_LEVEL_NOM		256
-#define RPMH_REGULATOR_LEVEL_NOM_L0		288
-#define RPMH_REGULATOR_LEVEL_NOM_L1		320
-#define RPMH_REGULATOR_LEVEL_NOM_L2		336
-#define RPMH_REGULATOR_LEVEL_TURBO		384
-#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
-#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
-#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
-#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
-#define RPMH_REGULATOR_LEVEL_TURBO_L4		452
-#define RPMH_REGULATOR_LEVEL_TURBO_L5		456
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
-#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
-
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0
 #define MDM9607_VDDCX_AO	1

-- 
2.39.5


