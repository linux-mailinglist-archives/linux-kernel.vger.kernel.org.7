Return-Path: <linux-kernel+bounces-736065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633DB097DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94741179795
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D29264A71;
	Thu, 17 Jul 2025 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dE6z2L0R"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F47256C89
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794934; cv=none; b=LSIYL3Bn8N6W5jqSXtexBJdK4vKuSwKea57C406OplQdG4K/DsA9yTxyZ7Xp+tO6wPRVn7bVzP0pZsvWT4Gb6WiIAeL2ynPkJiOoWM645cbjeYz0170fHnsWXuLUAz0ebTgO4ApcIseHaY+4KU7FT427rQXbHiOMTZDYmQTw7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794934; c=relaxed/simple;
	bh=NTksIiK3ILvCnqxlzcFH7JIUO55H2AfzNNjxdbfSZtE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZYYRjYmY38i0sLyx0/i9gSis2kt9TomyuAcdQGowZcEaFcEFyqKS2gedwncaTuMpHX1AspPWwxrsAAZFe+swcHSK7301iO4r9+AXwLedL+A4So3Pq2krJHWFzAF6LH+otertPk9xDyXB5JboS2DSF49df1ZBpyPJIvKP9/mgl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dE6z2L0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HNEsDY000543
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Yz5ZkUX+suGgaKXr9mUH/0
	YiWBvqd0jdhWimlhmg86Q=; b=dE6z2L0RIlS08dSgqJQ2838ZAB/Wutk8bVcdX6
	d+p877uymcRLeTvoFBuZECpSKgHH/HhQ9CbTBCYTrUQGXwaM2bn+OKuYtw0xevPt
	9ntRRIEVg6wRVCxhqOtNkRngc5zz6hXBi3rpjj9LezjsxcEeiw1xxclBlSJoZ0IW
	4joRQcBh0ect7P3nl/ruwkhiohYL/KhZ9RO3nbG4IDKvlIoNW+9jklLQi5tgdasG
	VSpy41LVWoYlRV9Ym2xKpqpkSg33IiZTlUHWRtQmCQ7dNolwIGN9tag1uUuFPb3p
	OiY17yAOLewA3Z7YD3GvUuFLlkEb4eqQOT/u/Ro3Gp/KuitA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drvhh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so2093179a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794930; x=1753399730;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz5ZkUX+suGgaKXr9mUH/0YiWBvqd0jdhWimlhmg86Q=;
        b=YW1lmccDiRVecCsVPfWRqVZadiaq2IGFlybicnNduDeqLs4JJdVlyyMiSan7bZOk74
         mRsrVeOExHOoUGUp3Skud8xszbIBSysFBB/Ur83mgXVkpv0+Q1Ovx16bZ+2D41q83KUP
         Iqu1LPCg/TG/tLiYSwclxfEYMy0BW9yuUy1AZ/0RKbJjUweUQnm02dO5V5IZ3DJeLBGl
         hQRJDXQE3imTR89zculpCAFiSPyDoHJl0/w0ULp2MT8nxUD8dpHBqGQfeSc1P+tbsE6Z
         nt+LZY5Q+VM7Gt7jkXjr/sa4+bOPC616dOWxJD5TXA/wu+KZimgppKciqjp8nGCjBL1C
         v/hw==
X-Forwarded-Encrypted: i=1; AJvYcCVlHYolreAE/Uh8ooh9sB9sxdhhAhgkKMjE0p4XgkcYtoX65+SdUhPlppgki/jrZ4vTjLt3IoDJqbu3EFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgOuVuhkBNkPzatEmkFMQgwmTUftSw/Wfs7I4GHfy3QatCifp
	c3iWwkDqgQFtzuNdo6kuOCOnYELLhbO/k3cWOqqtuCxlaxr0n54U2DCGt7aa3FRPfvalljQ2u6E
	4hPZwvSL0dlFOksxrjo5hXehecAr+AvZgMZepI0FEBA43N0PpPeL1o9l4ybRBIwgURZY=
X-Gm-Gg: ASbGncvirHlggg2H//9j7/ZAfFJf0FBHZIXDl38Xg9EGSHXL1twFEJ1rqDFMcJh4i7b
	NFIjjVxsK695iAvOorRL9bS04RU/NPnz0d4jmTfZlZpYWhkF8SYnh97Gws8dwkXy4V4BDUgrZ/U
	QovZJ9btSETiJTUO/b3pe8iIEvDstFz68bDIclg1yBFmTux/y6lrbYYN0b3WBO5ssHdvFqUsteK
	5FFpDPwa0vcTI3zNIUt1Rz2PgFElPs8Wur1t6VxPuw3K7u40yhZKAO1fWMaDBp1CwU7W1wrxGhh
	DdYx0Ped4VZOXq56JLQOwMaVSJT+QbAVJ8nVDTyEM6Lwd7HJnItAtdqaxImAQBBWMvsrlNqFf6J
	4B72sRQSLLuDOY8bZtcjv+wWT
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr10698341a91.27.1752794930330;
        Thu, 17 Jul 2025 16:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeZSn04EmYEL+h/t9yfP7/sJS7wsCnlKQu6QgEAKxyzBH79jPsm+h7MWyyQYnvMQSkLJjfIQ==
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr10698286a91.27.1752794929826;
        Thu, 17 Jul 2025 16:28:49 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3cb7sm2002195ad.17.2025.07.17.16.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:28:49 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Subject: [PATCH v3 0/5] dt-bindings: msm/dp: Add support for 4 pixel
 streams
Date: Thu, 17 Jul 2025 16:28:42 -0700
Message-Id: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqHeWgC/3XNSwqDMBCA4atI1o3EPGztynuUIjEPHaiJGpUW8
 e6Nlq5KNwP/wHyzomBGMAFdkxWNZoEA3sVgpwSpVrrGYNCxESWUZ3Fg3VddmKoanAbXBHwWLLd
 WFdJQi+JVPxoLz0O83WO3ECY/vo4HS7Zv/1tLhgkuZCE5q0lOuSyHGRQ4lSrfoV1b6FcQRDDyK
 9Ao2IIKnnPNqLyUPoR0mOUjCt2H2bbtDfDZEZ33AAAA
X-Change-ID: 20241202-dp_mst_bindings-7536ffc9ae2f
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752794927; l=3202;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=NTksIiK3ILvCnqxlzcFH7JIUO55H2AfzNNjxdbfSZtE=;
 b=q2mx7f+qusw7faryQbddFyq4FuzXuMHpT5OooNTFj/X3U+tTXQnAe8M55ksS7d0HsbtyMF3nM
 +fnjv8H99+WCMgk7Jy7sQWsQQjD/gYCOtdZ/IG61OB+HNzVMJw3mpu/
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-ORIG-GUID: GGkRgKpNZRmtFe1NV7x8N-DNkTTiea-n
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68798733 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=HrLnuC2iPlrUScbyRF0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GGkRgKpNZRmtFe1NV7x8N-DNkTTiea-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDIwNiBTYWx0ZWRfX/ADgU3+zQs0w
 owuYaZ0bgBASH5qQqiM8mmcDtR84UATQK0OXECT9m1A0X07FUW8NxBUErcMOnYT3sU1ergiZulp
 p+0SyirxI3sRiVuzgE/HsN2kj4qRC/GD3/3pNX1IZp2eMxkgoxklLtabkilNHdiMuoD2SzNWC95
 +71oCRZccDkZaMM/pwR5nyRome/DCgFwuq0XN1erUIBuo3LHlp+g3bkQ8U9nuwBGsBsXCG3JAbm
 3H9lIpvg0vrXsOSHSXqvz5axkMJaEb7a9hXLwnxK9XvLy34vmJeKZO0w/XM93DwpUxz038FpgRb
 IFx9uOtsgku7FylD0T4rXnsfZxDWeyJS7OY6wtuI+ovpO4n/7IqQqLMdzIHfq+sMy5I8yXhzxCZ
 W9ZwWuZIwjcgo7DqLrndahn5bx5QIuV7wupFVbGKhOjJrZSO6oIBsK3q/WUc/w+V5b07FyQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=790 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170206

On some MSM chipsets, the display port controller is capable of supporting
up to 4 streams.

To drive these additional streams, the pixel clocks for the corresponding
stream needs to be enabled.

Fixup the documentation of some of the bindings to clarify exactly which
stream they correspond to, then add the new bindings and device tree
changes.

---
Changes in v3:
- Fixed dtschema errors (Rob Herring)
- Documented all pixel stream clocks (Dmitry)
- Ordered compatibility list alphabetically (Dmitry)
- Dropped assigned-clocks too (Dmitry)
- Link to v2: https://lore.kernel.org/r/20250530-dp_mst_bindings-v2-0-f925464d32a8@oss.qualcomm.com

Changes in v2:
- Rebased on top of next-20250523
- Dropped merged maintainer patch
- Added a patch to make the corresponding dts change to add pixel 1
  stream
- Squashed pixel 0 and pixel 1 stream binding patches (Krzysztof)
- Drop assigned-clock-parents bindings for dp-controller (Krzysztof)
- Updated dp-controller.yaml to include all chipsets that support stream
  1 pixel clock (Krzysztof)
- Added missing minItems and if statement (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com

---
Abhinav Kumar (4):
      dt-bindings: Fixup x1e80100 to add DP MST support
      dt-bindings: clock: Add SC7280 DISPCC DP pixel 1 clock binding
      dt-bindings: display/msm: drop assigned-clock-parents for dp controller
      dt-bindings: display/msm: add stream pixel clock bindings for MST

Jessica Zhang (1):
      arm64: dts: qcom: Add MST pixel streams for displayport

 .../bindings/display/msm/dp-controller.yaml        | 53 +++++++++++-----
 .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 14 +++--
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 11 ++--
 .../bindings/display/msm/qcom,sc7180-mdss.yaml     |  3 -
 .../bindings/display/msm/qcom,sc7280-mdss.yaml     | 12 ++--
 .../bindings/display/msm/qcom,sm7150-mdss.yaml     |  5 --
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 11 ++--
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 21 +++----
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 34 +++++++---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 10 ++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 20 ++++--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 72 +++++++++++++++-------
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 10 ++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 30 ++++++---
 include/dt-bindings/clock/qcom,dispcc-sc7280.h     |  2 +
 21 files changed, 235 insertions(+), 133 deletions(-)
---
base-commit: 7a88d609b069b7d2f4d10113b18fea02921bedb1
change-id: 20241202-dp_mst_bindings-7536ffc9ae2f

Best regards,
--  
Jessica Zhang <jessica.zhang@oss.qualcomm.com>


