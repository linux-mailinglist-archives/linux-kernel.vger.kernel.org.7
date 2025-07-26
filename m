Return-Path: <linux-kernel+bounces-746593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1FB128AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7C53A83CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436E1DDC1D;
	Sat, 26 Jul 2025 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALdxhURe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90DFBF0
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753500707; cv=none; b=FvFSQOTQ24EU4Cu6CeivWwtTNuTcegT356Q27lMW5UlqYbHIQklPls6gSqdWzur0j2Lc5yu3KHUyr/UJDPKvxXyujAIuYhAIM5KQNQcdFY6++5YoPFdhbKvQRnEf1zr6Lp5x3g0xfZPiXdKq0GyYUat3YPvoW4JmuZEC/mTl9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753500707; c=relaxed/simple;
	bh=M4WbQ7Lx0tAfr3s+O6w1ZfGyU5NQN8GiffcDbPf5R90=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QIm4ANfSXxB7x2nQyAJSCyjyD8jzmZ2/WUY/3CfAkJgtudBJfhK72m2XXd/Bx/LO6WJmw7e08zoDwBB0j4+Dlx8x/5wO8/Tvsay49abQDi6yVLWOdqj1nyRTGYm9LIYRxD6Wc6nzR6Sz9+yMViNyDIOyrzae4kjfCKR9htAb6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALdxhURe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PKxm2R000761
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e/UB9WUrnNaNs+rw95cnjb
	YSPraDRFw09hfhrfmmSsI=; b=ALdxhURe5udMV9br72I5k+BQTkw3RJMlhKiK5d
	DgkA00nwt2TJzuoDwQPDKFRJxY2Sfq4QR70JnNEs8sPzw5poQU4cXNSiuIWL6Gr4
	mdUTFHQMduARzjbMVDWCOyWyCwXeHaSSFz7FYNYrBIBq6nPqGF72wRMxBoD/7Zbk
	pMTipL6LevQyCvaszJyrH51QggHQecvv/JgVLUD9+AUNvNHOE5Pf0jfgpNWEmGZC
	obEFJ/fmDrBQNxlGbTB2/Wj3nEuY5RS9B5jCUX90Qj+82E2Ec9led+gtRLaKX4zq
	ZMoiz3r+BGzMQfBDyOt+I1ietDf6FjvoX2A9oQ1WGfzaM5CA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4848972a9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3f71e509d6so2454727a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753500703; x=1754105503;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/UB9WUrnNaNs+rw95cnjbYSPraDRFw09hfhrfmmSsI=;
        b=aCSNt95nSFhjClRU9v1HtKxnNYqRlB5du/yAh2xwwYOmzstjbXVGyMCmj/Y5XuzZT7
         K4dWnRvh97IplI4elJTMzfRrlrG99Z2NqblD8iT+681DqrZzAUxpefBaOe+dvkLw3Zpc
         RhNmklY8PJHkv+99iDuKylqHM0U6qUS/KRDImiLb6lELUT36N1KX1VhwB9P9liTJ8zuI
         rpT1ulUHfQJSsm/da6AwZIzKAGC0iXhHJ1jsSrJV09RitFbYD9ubLN3HJkPlIWNJ2m3T
         sOjibQ5mHU7SXlNTAvm713ahBP/plBJZJ3R0LV3c01vzRUwa6+OkmqMqW5SPXhqf1602
         QFgg==
X-Forwarded-Encrypted: i=1; AJvYcCUb+2kbHvI99Nb/rN/H8MmXTOMegYrxIwP6EHNkZYCD8fW1eJX1mdw1EjcRm24+pWMueC7+wJpbpmd72OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxCIYKpePdp5aBY1DarX+gdlday/y1H9o1mLv4N4m1xPqz0CI
	qiam+50PoIEz65uPY+SkxmqR4Do5IHmuN/GCTQJkqK6N8V0HjVQyBDgT/8SY1CoTDlRcCRi6LH/
	qDI6zFYnvjryWETYSnhL/jlrGAMN73ct6YOJvXhyD7mWDfzKkeSv/xry9QRF18DrKbXY=
X-Gm-Gg: ASbGncvvYP0rnCwnV6tJQMva8YzQ/7H+PP4UnbKCGVRyZvL4gdnzoeNKaMgXD9jncYd
	0cQUjGHhtH9iAXxNieaQqgjqOfXwFoKsRBi+ip+LtUtl8FP0VJxnCEjHtnPZMHf8B3Q6RNSJYhI
	2K7pHjwb9VYMw9wJw1izOtcdUQeX1Um1SrY/Ee/RYNbM3tZHs+xxAKy04A2yNleCL+VD5+2xSFS
	SH2/XpbHZw5EdogBIPAW+6A9ThEu3b0eeVXW20kZC0giomgQt0ZB5/HN5k9+U4VbIKvoF0prluy
	hK6wVYqKcDLdruyavWaL8O2WnM0BWMm8NSbwI2Mn0i8uTCDB+Ij66kuv/UbF5DrAs/x3s8eyOAe
	Jov5BU42R8ReIoOS4n8MnN231mOwmSLZ/5g==
X-Received: by 2002:a05:6a21:328e:b0:232:7628:9959 with SMTP id adf61e73a8af0-23d6ffe8e2cmr7248105637.8.1753500702674;
        Fri, 25 Jul 2025 20:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQZ2ZymW3QZpjcbQ5da4dY5WLrtwYP3x2anwIcfoXcU/4HEyr7xOrUvy9+avIJM5SPLY9yZg==
X-Received: by 2002:a05:6a21:328e:b0:232:7628:9959 with SMTP id adf61e73a8af0-23d6ffe8e2cmr7248073637.8.1753500702242;
        Fri, 25 Jul 2025 20:31:42 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640881f5a1sm724917b3a.23.2025.07.25.20.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:31:41 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Subject: [PATCH v6 0/2] Enable WiFi/BT node for qcs615 ride board
Date: Sat, 26 Jul 2025 11:31:29 +0800
Message-Id: <20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNMhGgC/3WQzWrDMBCEX8XoXBlp9bNSKKXvUXqQ5XUjqOPGS
 kyTkHevbPeQ0uQimGW/mVldWKYxUWab6sJGmlJOw64I+1SxuA27D+KpLZqBACNQaG6l4SAjGCk
 deelZ2fwaqUvfi8vb+6pH2h+L2WEdsp5yDovZpnr+9VLCG6tEba0XWnPJz+l0pPo8x74OOdf7Y
 /iMQ9/X5XmZc5qQic+TdNhUrrXROKUgYnBNKJ5d7AJa51xjo8K2ieStUmxutE35MIyn5cxJLpX
 +XDTJkh+9l9pr3RGqfwUWmwnuoFDQ8hktWhFNAPkAVXdQxQUvXZ0moVF08ADVtyiuqC6oDNChb
 qXFFh+g5gYFWFFTUG0RCQWBCXQHvV6vP4G3Q+AbAgAA
X-Change-ID: 20250704-615-21c25118e919
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753500699; l=1874;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=M4WbQ7Lx0tAfr3s+O6w1ZfGyU5NQN8GiffcDbPf5R90=;
 b=tdggoYpjrL07xP6Wpk6vpBoUdJOyh2+eUfpqEtfgiPdhGtSQ8LS4GUFbunPVSulkndY3akJMS
 YkDULV0UIx5BoUdTfsNJCwSNSM/nDQowvL8Ss18H14dykjNxnO2c2Dx
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-GUID: m4k9ioyJOvm04Rem35qqf6ri9_54--C2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDAyNSBTYWx0ZWRfX6/3uoyL2CAUW
 6RM0CHG2/cXbJSqhT/iCVpC5540oGQkIEDHmDj4iK8O9bX+M43tMfyYLmjAKyJT7ijMFVYsgv0k
 NePuuUZRqtcP9RFvolAjrTtZ3kgvL47dx9e9SUoipwGN2WeKom9yAX6Dorq3v9TFmP0XjAhgTD0
 /kLlgoBitBVaZRXKxOWB2Kwpfo/s/E/eGDcBRVo96vUr+m7uM+rbzrBPrzVvHlW/SKcP37vXVaW
 0HF5xz6FvoZ5+U32zbdA261JydMqdG1rJj3Xz3WDvYHS67pByCgYGsN26QEp76in7oRvXWEHC2Z
 WU3sbNf59H4TiulOdIL0SsvAjbI20y//KAmTgMFqbn+ihmF4yjraPUcW4a+kCIO+cHN1TgB+t8d
 zAskGXvpzjWMPNDohQmB1txNy5W35yGqtBXRLGzJfyMcyiomwQbwHolz+OZTO+4v0YWioC7e
X-Authority-Analysis: v=2.4 cv=VJjdn8PX c=1 sm=1 tr=0 ts=68844c20 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=TmzUbGvDyKMaPb01JRcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: m4k9ioyJOvm04Rem35qqf6ri9_54--C2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260025

This patch series depends on:
- PCIe
https://lore.kernel.org/all/20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com/

Changes in v6:
- Fix regulator pattern.
- Link to v5: https://lore.kernel.org/r/20250722-615-v5-0-4677e70e25ae@oss.qualcomm.com

Changes in v5:
- Fix DT format.
- Link to v4: https://lore.kernel.org/r/20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com

Changes in v4:
- Fix node placement issue.
- Link to v3: https://lore.kernel.org/r/20250704-615-v3-0-6c384e0470f2@oss.qualcomm.com

Changes in v3:
- Formatting: adjust layout based on reviewer feedback.
- Fix DT checking warnings.
- Link to v2:
  https://lore.kernel.org/r/20250625-qcs615-v2-0-0f1899647b36@oss.qualcomm.com

Changes in V2:
- Correct the version metadata of the previous patch.
- Separate the modifications to the DTS and DTSI files into different
  commits.
- Formatting: adjust layout based on reviewer feedback.
- Updated the email address.
- Link to v1:
  https://lore.kernel.org/all/20241203060318.1750927-1-quic_yuzha@quicinc.com/

Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
---
Yu Zhang(Yuriy) (2):
      arm64: dts: qcom: qcs615: add a PCIe port for WLAN
      arm64: dts: qcom: qcs615-ride: Enable WiFi/BT nodes

 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi     |   9 +++
 2 files changed, 144 insertions(+)
---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250704-615-21c25118e919
prerequisite-message-id: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
prerequisite-patch-id: 37d5ab98a6918dba98ef8fd7e6c91ab98aace170
prerequisite-patch-id: 1693faa1e23bbb0a37d4fb9cbe13e5dd43148ce8
prerequisite-patch-id: efa688b2ddd5744df7aef40182787ee4ceb90c98

Best regards,
-- 
Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>


