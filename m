Return-Path: <linux-kernel+bounces-785400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDFB34A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6795B3A76D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4505830275C;
	Mon, 25 Aug 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EsbjFYjB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D412F28F2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145971; cv=none; b=lxEjX7Ir+9KAMN+WMTFx+bccS82t2rbdQR0khA7Xl/i7EIhkRE/et/L6vBzZMrAXsEhqO7Pp2sJTew9FpXj9Rtv14gBkMRS0EWJlNsqKv0M80s6w3Dxg8Oq8Y/BSbwgOIDNawnRBSqpmmHvsHXGaSa/mxWdfvpPNtCdn/7ujV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145971; c=relaxed/simple;
	bh=2CzEcrYm4XTOiqK8m34i8odSZZw0BFHNLZkz/gbIabs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TX9lYCZ6gPw4UsSCT9jkTqDjLMi7D0vkeOM/kkbgtu5kiN/VJ1sUehip6Rco0OTMeAixSLSx4IxyKvEAaxSBkQYvCKfQgmYZ5hYXfPMmFFGN1DrK/C1WKO4Dmua073qgHPGXD+3/F2lGn19ExefAYZDKuBMQLOzcrymDU8e35g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EsbjFYjB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFrBgb010931
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A+MJf3gYcSkZlZ5iU+sJo7
	4M2Td1GfyUqV5Y/ilHPak=; b=EsbjFYjB2Lj8eO22JFGTanrUpr2T5fkcnKHUTo
	lBISo5uLYOOO3CrYD4hABr3v/aEBgBr+iIXZ1+SBMlRLUPmbwM68EyA239VS7vuO
	kmxeRSchNI2Rscehry4/xQJ+3Lj13eF6dW4LbkyVOI4rrNFldDflI8VidiYdDd0I
	BCleUG++tGokvRAENoJvsTgT8DGr1WxE5rlFYhn5pq8gnLVCwbH9nzxWPSshD8A4
	RccK0uy5B26//sNK4Wjj6ChFRMFeBHnuvrty1tv1n+6hlm1PPLe8CIw4US5brMAF
	hcCs0hygjh9E4Na2v5TCPkOWAMKPGsGZSo01lRqOT/NvLXVg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unp18t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2461c537540so47587915ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145967; x=1756750767;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+MJf3gYcSkZlZ5iU+sJo74M2Td1GfyUqV5Y/ilHPak=;
        b=ODXoBb8Vvy74gBXG3EEIc8Hh/o/6Mw80FZ1c21+p8/jZ3XhPmfnM0IVpv27iGxFP2j
         BhubCdN4sHmZcrTN3tGyw0UYIqrJBTAvMTU5+w50EW/jVktUZbqfxra07tqCvZyzydIg
         IjYiARb5TCUT8G5SjrbZKVuKYwoh+ZbzsXLbtKv9Ja6zLmwb4lLc97lrU1kTzZjbu4B0
         E0EA+FtE4mPcdoLHlN6oZxGVSBkDUogzRkM/+LqPrQW3OPi5xkYy822nV7nQ9CdlenNn
         vLgntTHPjkvE7BEysIlbAtyetmAySpDOU4f4f2zGbMP5lVgHGMxhQJd99G1/gu1ICuxy
         xznw==
X-Forwarded-Encrypted: i=1; AJvYcCWs6FBYCW4SiIgUPNH0pSHa+s/8EnSeF3Dx2BrKBWHCkU3PzQCcGHthQ7SL47FILqU7QRhgDPgedd9Q2pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRxMpt2/NbLPwDgpXhC41LNm869y8E9CznYJecC3D4MgLMEhO
	QGrpMr/czVBSvZI/16oX/uQ1BrZp8rFo0fOQ44hGyUEXKNcWNVV8lkXs2LaWLRmd1dJJekOsTi3
	5yiay5GoeT2guillczp/9sO6iB3CAY9uy0nWvjym5SusztYI/VJg2YWTOlx3WaYTLIt0=
X-Gm-Gg: ASbGncvupzBiwPznngj3bCfGsoHxu0Agp5q456fFNDhDQVFRAdumx2LTCtvydKCuDtK
	8gQdNSNhQrHXGyVRZCaCne8R3ZCRnmNgTcruxGeyHqQ2jwc1N/7Hr21opWGd1MdK+At7wV6cuKJ
	cPywYBQuBuGbx5CAg6dqZu4t2kbu4/vqHEbjpZ3y1J/n0UVj/zOLP8kYgHEttZoAeU3UZXZ3Qi+
	Z0htydJabXZkqLW0zPjfx+0PbWZvKOkKtNO1QgZZDqhBdL4MZgU4wFBHcms88LBqrELFGrlEYBG
	OC8TaqAwXW7GQ1zoBMTy7Xc8Uv6vUXRfm/uGBMv7aOIgZCn4+OkXdU1gDBq0s+vL
X-Received: by 2002:a17:903:40c5:b0:246:cc19:17eb with SMTP id d9443c01a7336-246cc19229dmr67934955ad.19.1756145966958;
        Mon, 25 Aug 2025 11:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrQ3rfUy1vjKe9ObjfuC5Y7lAp3eXHihBwf3qoFxZvehwnvsdwwga41y5vUdUY+s9TveoGQ==
X-Received: by 2002:a17:903:40c5:b0:246:cc19:17eb with SMTP id d9443c01a7336-246cc19229dmr67934395ad.19.1756145966420;
        Mon, 25 Aug 2025 11:19:26 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688647acsm74174015ad.87.2025.08.25.11.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:19:26 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v5 0/7] Add support for Clock controllers for Glymur SoC
Date: Mon, 25 Aug 2025 23:49:07 +0530
Message-Id: <20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABuprGgC/x3MwQrCMAwA0F8ZORsI1eDYr4gHjXEGu1bSWZSxf
 1/Z8V3eAkXdtMDQLeBarVhODXzoQF63NCraoxkCBaY+MI7xP30dJWZ5o+Q0e45RHSsjneVEpP2
 djwQt+Lg+7bfnl+u6bqtaSM1sAAAA
X-Change-ID: 20250825-glymur-clock-controller-v5-07c400e8b530
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: kwteyUftE99ZgDtN1xUH-AfxLHdKEL-l
X-Proofpoint-ORIG-GUID: kwteyUftE99ZgDtN1xUH-AfxLHdKEL-l
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68aca930 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0T6YAe87-15ivgeVu1UA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX8zJ/Ss+VZ467
 2I/ewMXAM9TJa9ifQoIt8gcJsipJgCexhSjLc9k6dItBFA6/dRR+aSMmsOM8RgwlOt+OhNoVSUh
 T4+8X6+teu5ErkNlIm6GtGDgo7zXiyLcbedAyoQMflNp49Qdg1rSYVIsBkrBdFtA435RKp9nJ/M
 S9pC74IENpLGBNmTk8yfgRlXmMRZEgXitbjEAihue6O+MVT9Np1fLNb2f+7Hm9fgR6llWVwqpwf
 Yx25QjCwzQGJVqBjfXFQhNDe64Qr5IaVcqyPcKcwLy2SYV0C7Yx0NJlzDZe2y0sUpp4TlIAZkZa
 DeqpGfcylDLl+88B+CWRW1xBcGJvhr4YxkHPkHvpwuUcjTw25Jq58p4k36k7K3YHgidWwGPulbE
 G65/2/uW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Introduce the support for Global clock controller(GCC), TCSR and the RPMH clock controller for

Qualcomm's next gen compute SoC - Glymur.

Device tree changes aren't part of this series and will be posted separately after the
official announcement of the Glymur SoC.

Changes in v5:
 - wrap commit message for 'TCSR Clock Controller binding'
 - Fix the GCC documentation binding for the clock descriptions and
   clock phandles for 'pcie 4b --> pcie 3b' and remove extra 'pcie 6b'.
 - Add RB tag from
	- [Bjorn], [Krzysztof] for RPMh/TCSR clock binding.
	- [Abel] for TCSR Clock Controller driver.
	- [Dmitry] for GCC clock controller driver.
 - Link to v4: https://lore.kernel.org/all/20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com/

Changes in v4:
 - Update the commit message for all dt-bindings to incorporate "Glymur SoC".
 - Add the xo parent for the TCSR CC clocks[Abel]
 - Update the GCC driver to cleanup dfs_rcgs as part of 'qcom_cc_driver_data'[Dmitry]
 - Add RB tag from [Konrad]
 - Fix the broken previous patchset links.
 - Link to v3: https://lore.kernel.org/lkml/20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com/

Changes in v3:
- Update the commit message for all the dt-bindings [Krzysztof]
- Update the commit message as required.
- Link to v2: https://lore.kernel.org/all/20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com/

Changes in v2:
- Drop second/last, redundant "bindings" in TCSR and also align the
  filename [Krzysztof]
- Update the year to the copyright [Krzysztof]
- Align to the new Kconfig name CLK_GLYMUR_GCC/TCSR [Abel, Bjorn]
- Use qcom_cc_probe() for tcsrcc [Dmitry]
- Add RB tag from [Dmitry] to patch #5
- Link to v1: https://lore.kernel.org/lkml/20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com/

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (7):
      dt-bindings: clock: qcom-rpmhcc: Add support for Glymur SoCs
      dt-bindings: clock: qcom: Document the Glymur SoC TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for Glymur SoC
      clk: qcom: rpmh: Add support for Glymur rpmh clocks
      clk: qcom: clk-alpha-pll: Add support for Taycan EKO_T PLL
      dt-bindings: clock: qcom: document the Glymur Global Clock Controller
      clk: qcom: gcc: Add support for Global Clock Controller

 .../devicetree/bindings/clock/qcom,glymur-gcc.yaml |  121 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    3 +
 drivers/clk/qcom/Kconfig                           |   17 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    6 +
 drivers/clk/qcom/clk-rpmh.c                        |   22 +
 drivers/clk/qcom/gcc-glymur.c                      | 8616 ++++++++++++++++++++
 drivers/clk/qcom/tcsrcc-glymur.c                   |  313 +
 include/dt-bindings/clock/qcom,glymur-gcc.h        |  578 ++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       |   24 +
 11 files changed, 9703 insertions(+)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250825-glymur-clock-controller-v5-07c400e8b530

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


