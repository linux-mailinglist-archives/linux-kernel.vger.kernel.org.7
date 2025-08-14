Return-Path: <linux-kernel+bounces-769112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF372B26A66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2602A0476F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69F202C3A;
	Thu, 14 Aug 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfUMkKbD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6532142C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183272; cv=none; b=WAgAGnPdSmUsg2zpQBlja1yQBj21yUtaz5evVSdpSQruREQPTt/EsCdJEmkloupKCCkfbuXQUFc5LuQBWrJ4nJtAdJYxsryV6I42IBK8VCrzaMAVG1buZBY3hJlKwB69VhligatDu4Jbfs+NKJreJV9th+sLOg3t5w8HoNlsblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183272; c=relaxed/simple;
	bh=sTDazc1yIq3qWxjwXzAUfJ9okZVEuQDE5VUa+DaPuIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dv8R/pl1NLRZPRgNSKDkBYCM22gM+wuc0pqdqkauR1TVGIS+rY2pGfpzGPOb2cXZ2R45jtM8yV/s3ctw3/vyVUiLSfj8GuZOErI3OGf9dlfoa6klMKcKS+3K+BJzEWMTSPhYF+lUtDN2ZYx0WDsAc12tzMsZP3Qt5i7UDfed/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfUMkKbD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9RBHV011072
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jnWjRH8kAJZ+wsaNi0TeGo
	upyd6TNOm/RN5MzRClQ+Q=; b=lfUMkKbDkqpUsAPwBXSj5jF/jfQ/JRbiiK6LpA
	4ILrreo9memIIofnUnQMy3gUaCxx5rQRsemEkCM5QYWUMuOjP1xklSTWN0oYVNpO
	FJ5igztjUhYG1apgSyQ1w5RMe5BZ4QCNZPj7aep89Nznc7x3LbRvy1rLB+Wekdlp
	ZKgFm3WqrDPvDDCpp2v/MfIcjqyFxxnrLLpDUqq3ta44MKSynRqQ0CIoGgBia/rL
	R9qm44+AEWCU7WmJzpmrogj2pF3GGo8z0IwHsQ0YMy174xWsqk+lrD4cguo0NdSA
	qgk37DYBid+XV84LZ88gviJZWBsC86l/hQly87TFfYINyGVA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbk85f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:54:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471757d82fso663261a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183269; x=1755788069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnWjRH8kAJZ+wsaNi0TeGoupyd6TNOm/RN5MzRClQ+Q=;
        b=wpYofhU8iSF3euJ503Xa7PSmbo5hU4PDOhKJXcGRAMkIojAyASAf+UQZBH4nI2LDPc
         7IjvXoVJxRdPlvlFnttXdNqj/jSVO9Ke6A/wIp04CokOLidACxtKVEvyo2u6r3KITv/k
         +CIj3tUDrfk61YkcsGiKN3iuzCVwGVtem+qcU5++zMZBc6kc6YtRHAuUiwfsu3u9El19
         Mi2mW7w386Ezy+0qfD5P9K7ciy6F+bNbgsyuSmRUWzywyoM18PP08B2ZZi1WoRMlo3G1
         T4eqWqYsqrbKH+6kXYRl+wm5ZQRR3M7opdjTHIFPzfqaPIE28AnH3HK1QYI7bgNIbANZ
         GwIA==
X-Forwarded-Encrypted: i=1; AJvYcCV21yGj9WF2ezYXNTK2ynQQ+H3LDenU8Dm+Agpy9Isu+NzkZHE/O/Sxn66yqNzolEKvAO3Ub4LZ/Mb2tjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntDqczVt5HSr1os65VDuH7z4GXr4l8uNx83T7KUKtdCSeMF4U
	AIzwCpiit9jpQDwIAPMWPVnFhdzaweGrnc6BSa4gm2D62uRueU9/6AYuYgqgCx7ZaBBBJGzE6Xh
	/uQaROQyjv+miBzq4na6qnjHk72r9NhtArfXe2Xq4f9bKL3KXTn8YT/538f7DgSURoXc=
X-Gm-Gg: ASbGnctyTxUmrdyUQkX0xPI7Oyg5z3NOJTpWPqJmSLQGVktBkg6UaN0wfhXwt7CbQpC
	Sviq9a1IQHQwX18heyaHn6V4qqP9mSC4O+8/kl01YfyNLRhpw/T9y7icVnCTjzpZ9MWyJjfZStK
	9d25sW1AQszNMD4JSc4OhkL4kLSXYcVVllrvhOK23f8Bc9frsCtemcoga5puLFbEMYFaciKZPwi
	m38xXdx4wrMvI87EPOBodnbQTf/pB3TWJ1dErSPrVMeB/0vtbrRj4AN+akSx52fTcs0L3tjn8Vu
	UYL+aDSGv+9oKzpMXojNMJuMQHZ0Qwb3TmIZ0nuuF9zWzPPIm2/jh62DFCdVnXc=
X-Received: by 2002:a05:6a20:2591:b0:23f:f934:19b9 with SMTP id adf61e73a8af0-240bcfc6b0cmr5657418637.14.1755183268812;
        Thu, 14 Aug 2025 07:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxL/zbaKfeuWHI0X0OWza3tJ4fqkY+GAuDg0fSfwz8nRrmhB07AjtsS2mow3MVEiJzFL3yKg==
X-Received: by 2002:a05:6a20:2591:b0:23f:f934:19b9 with SMTP id adf61e73a8af0-240bcfc6b0cmr5657372637.14.1755183268365;
        Thu, 14 Aug 2025 07:54:28 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be718b2d6sm30715274b3a.56.2025.08.14.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:54:27 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add interconnect support for Glymur SoC
Date: Thu, 14 Aug 2025 14:54:18 +0000
Message-Id: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr4nWgC/0WOzW7DIBAGXyXi3LX4NdinvkeVA15DQoONA7bVK
 sq7lzStcllpDt/s3EhxObhC+sONZLeHEtJcgb8dCJ7tfHIQxsqEU66oYRJO8XvaMgRE6FBJ1vJ
 hbD0jdbBk58PXr+zjWNnnNMF6zs6+FJq1TDElVCNpXWsODBY7X+xns9g1xPdUSnPdbMQ0TU09f
 +LsrluNW5/2V1tNfZbx/zKMCS+AaV5zitFl2CWozhjtKTdWj/0uH87BFgePJ2HtDwNTslOUMWM
 QOzdYLThyNVAhRq+tEogoJPPkeL//AA9wekIzAQAA
X-Change-ID: 20250814-glymur-icc-9c54162bd6f1
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689df8a5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=TcYuhgBYnFsORjw0c20A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX8doVd8nj8aHx
 y9wBqCmI9GmLYDZCJOARKPTkJtzRcUFyW0t+llxvfaSchmLX7kIgiEMox65Rb2WCG6RQQS+eVxv
 /FhYrLexeVdsd+RWK+jBDlvyRBW2FFR7jQCaHXo25ut7o5WaJuR36/VgSUjFR1lwUPxvYa2W+GE
 BNdTYB2Tks54tbUoRDBhlgSIa7fKj7oNm+4V6JCCbFsX5iofixYTMA58jmMaf9rdjbWPqrDbW2e
 6BM8pn5ZbnMX+O8/tkadfnTQtmehpvwhH1f9Ou9EejVlJoq75gMhhFirBN4U5Td7PjLrMasow4S
 ZpDooN+n20HfTG2s6I/r0E4rPLWafhAFg9O2O+8Y2oLSQZByC8Oa/JU0CYpbbb8yjlKopLoXaYN
 nZ380W1n
X-Proofpoint-ORIG-GUID: YLXgXpyUrmrR6OngfypVGQGDdGkshpIV
X-Proofpoint-GUID: YLXgXpyUrmrR6OngfypVGQGDdGkshpIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Add interconnect dt-bindings and driver support for
Qualcomm's next gen compute SoC - Glymur.
Device tree changes aren't part of this series and will be posted
separately after the official announcement of the Glymur SoC.

Changes since v1:
  - Replaced static IDs with dynamic ID allocation in driver [Georgi]
  - Enabled QoS config support for Glymur SoC [Konrad]
  - Updated MAX_PORTS to 4 to support video master QoS programming on
    Glymur SoC.

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: document the RPMh Network-On-Chip
    interconnect in Glymur SoC
  interconnect: qcom: add glymur interconnect provider driver

 .../interconnect/qcom,glymur-rpmh.yaml        |   84 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/glymur.c            | 2259 +++++++++++++++++
 drivers/interconnect/qcom/glymur.h            |  185 ++
 .../interconnect/qcom,glymur-rpmh.h           |  205 ++
 6 files changed, 2744 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/glymur.c
 create mode 100644 drivers/interconnect/qcom/glymur.h
 create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h

--
2.34.1

---
Raviteja Laggyshetty (3):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Glymur SoC
      interconnect: qcom: icc-rpmh: increase MAX_PORTS to support four QoS ports
      interconnect: qcom: add glymur interconnect provider driver

 .../bindings/interconnect/qcom,glymur-rpmh.yaml    |  172 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/glymur.c                 | 2543 ++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h               |    2 +-
 .../dt-bindings/interconnect/qcom,glymur-rpmh.h    |  205 ++
 6 files changed, 2932 insertions(+), 1 deletion(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250814-glymur-icc-9c54162bd6f1
prerequisite-change-id: 20250812-glymur-clock-controller-v4-59887f028a7d:v4
prerequisite-patch-id: 3f2811249c8a302f59430e6c66d38f42058c38d9
prerequisite-patch-id: 0f69dae48c7a4c6b0b39d0edc5d5f114ac464e13
prerequisite-patch-id: fa24158f66c7291a63dc20e384d13a44ad008858
prerequisite-patch-id: de42c5bedc98965fb14256108743307f738dc34a
prerequisite-patch-id: f1872a81e0bdf89b2e26397d8eb6dc1ce7eeac1e
prerequisite-patch-id: f8c9dd47ab2e9baaea8acfa0698cd48908ccec47
prerequisite-patch-id: 4d61cfd61bf324419714776a0a5c9686dcb944ea

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


