Return-Path: <linux-kernel+bounces-735393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA9B08EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E127BB837
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57511F130B;
	Thu, 17 Jul 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUkb5wRy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF21DE894
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760901; cv=none; b=XbNmX+A9HqBdSVkuMRvKQJCTmEK9w20dSqSKa/TK2Wub+8m28dSnqwOHB8GSEwXvmNfJ7Q75Zg8wC27k1GZ4nPc/cnl7xBxqS0dKXiRBUHdXeKeDwC2IjVDbxoCqejUNldJKUdYN/3aqk9K6UgkPjAJDmmZRUUt5ZxHcK4oAk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760901; c=relaxed/simple;
	bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tXobxn0YHN5ZGkpxlD0VYV9lhWdzv92qNa3cCEd8G75EqN1EchBScBQhJlmzloM/sCLq2YaH68q7Wlczzjr5lPg0ZgPMM6WO0afNqBiXCXliRsoiGV+D7u6zgZiiq8ybhOANfppVEPXq5exbyzIiBD56pMBDhn3wS5sPlS4atXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUkb5wRy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBuncI025180
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pXji7w03b38emMA9vb5J3M
	JvatE27Vxj2JoLrEFkbvQ=; b=DUkb5wRywSO/YzhBHoThRutav7lcjS4xzXeDF2
	Oq2RYGobttVW46n0OFmJkJr/3K9wVb5fS+g8Do6AHOqXev27nRsOTPfzyeNqcie+
	NUjmJThNdgV8SVf7+2VODfenC5VQo5fJZw7Ux6hY3fcNdjCu5+lbjeULN2sbLlnt
	2nlhvdk8Tf2tsD4q6oHinbSM/MNrV0rQ8IdTFeOp7zSIi3fMzrEMiEea1g1EZaTn
	G4GtawRWcnjWsoafFHSYyd+ljloMN3E2xXFz2MXJh+3+XaLgbnEFUtzcVMkTvBVl
	IzXiUyEm8JiCGVwJSOR33z0SvwQIsqdzihsVFVk/suxFTnhA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqc3pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:38 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-740774348f6so1073244b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760897; x=1753365697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXji7w03b38emMA9vb5J3MJvatE27Vxj2JoLrEFkbvQ=;
        b=LFon7JOb4bUW7tbBsAQu8F0XZWaS8urWnJbQKgQZ2xSHXfRx3DX3vmDxhnkWe1XOAP
         XVNa8QyuwO5wI2fiaINH/8yC+S6wPDZ3UcmLeU+JEhWEqfCDFPXTgkpLwTDAX2ulJgfK
         FYYXgPd1C4vYRQHdsoicA0bMI3G1npJtNxrHH6Oa54ITWdJrAfKxpK2RRgWx12BT2dXv
         vLzrlatL7F00K9EJXc6F7QU41mxrdFYdZBnQjSMRVAhgeMBEKA+ZkjCd0O3pM4WmGRmn
         ov13BHsNLVh2tpUGdZyXgxEFkuZV/gYuCHi6O3h1RcOirKRdlDXZ0mk8oYiT2Ej3y8Rj
         LK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNpXXTLWrwxNyJRbfUHu2EDzohGtEQzUnbh4DxJPBMkOi2lnB1FCf2dhqFEpknAPfV8ixH3BdEOoKAfdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVd7V1IGIN3iHsETwIjEiRmI0Onjlp5+oO8RR8P07hezX/q2KV
	2P++Eup4F2tQWtFg5pIPlgSNf9D0bRlkonvNt3wB7dAPSuCnEObNbJzXsbFzKvTVTgLeCAHdu/G
	x7EwdQaVPrFM5hOaWICmpn3tophggoB/x0Zvp9pYFC/5MLZOVxk206Z6iOBwScOPVKoc=
X-Gm-Gg: ASbGncsl0GasWR6MpE7W634wplZ5F1FVI5NgRAL8C4zkF9qryBis6Gysf5dIUfiC0nM
	MaOsqislUJwDifmx4cAknp01QJfJyeQ7jmesd36cI3YpSX5iPz6cDX+2jANn8/uYJLOT6Q1GJGW
	g0KqvtKVGSQR9iF7Y0aRzseO6eEir0/Ct/rK8SUFdQubIPcHy86EEQnIORiUCXsp5NJffyeF/Ey
	c5BjE1ERSw5+kRC9lOgqVO8HmH+dk/mBSWUgQTRV5wkPLTrP6ZQPOedoDdIq1DfoBh3WdNMDtf3
	o3fkeHa3PVil6UeZ92AwsUuiFwXsPp5BSo0d5TnYJT6SQZfxKhjeh4ZwSseN68MRxmGZ702MGsU
	=
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251722637.43.1752760896641;
        Thu, 17 Jul 2025 07:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF45A+lgEoQb8f4TyEa6YkAJM5UqE/OX4TYBGRzoYifUxZTa8/Qrlg8/ommRgyQucY5cADfQA==
X-Received: by 2002:a05:6a21:151a:b0:238:3f54:78e9 with SMTP id adf61e73a8af0-2383f548d09mr9251480637.43.1752760894322;
        Thu, 17 Jul 2025 07:01:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Date: Thu, 17 Jul 2025 19:31:15 +0530
Message-Id: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACsCeWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3fyCgviC5MxUXXNLY0MzgySjJENDYyWg8oKi1LTMCrBR0bG1tQC
 91UdPWgAAAA==
X-Change-ID: 20250717-opp_pcie-793160b2b113
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1757;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0BTQfC2w5Rd4VcCTtFNmuoBqEatSoZ/OgMG1M6bwx54=;
 b=yZHyhU2ZmPe2y6FRKoFJIShRvrs8JFdyP+hmuU3SAHzGxMKpB3+iCxlbylH9wPkKzi6DgxqGt
 csXPI+55WroBjWicfathL9vSadm88SK0hZ27fR6A63Od80rp/Tj8H8D
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=68790242 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: pyiRF0KKsvJ3vMTcw2Iy2oVTXFKZwIlM
X-Proofpoint-GUID: pyiRF0KKsvJ3vMTcw2Iy2oVTXFKZwIlM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX9W8XyUGl41Wh
 P1L94obfhxH8PZF/r/BgIi3hNEnUDUNSArEuC0RmvCpaZp1fvyWwOHdqahx3q0Ql2etjwJe5RJT
 yEDMhgpe/r9BBrjP6YiQtDthFEjDYAM0zoiO3RoI4jZItKsrC4H10lW8RAePdsI3S8zEV3krfat
 VqYGl/gV1LDUdzQJ61eN1MeChUQVOY4qy3Eth9HQZ/YsK3BW/NZMmid2Y7/9re+KpmOP5ID/aei
 r4SsddBORNbL3NXKhWgfjyavW9tnlKubA+767vXihTj0VA6nw8+5fIYRgZWX2z9Tr1RnEnWqo+3
 ZATJiPOc2aiH0hqxFdUvFBUfzSt8VO1rwClTFyEJllrKnbsFSfxiSSoLARimhYb2ziBgtPNTg+T
 glMsRX9NuX08oHmVp+o+/0AzFSerpuULU1t3ODnndQe3TBqnJxV1n6gib8ad48KWqEJphCZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=877 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170123

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

To avoid conflicts and duplication in the device tree, we now define only
one set of OPP entries per table and introduce a new mechanism to adjust
bandwidth dynamically using a `bw_factor`.

The `bw_factor` is a multiplier applied to the average and peak bandwidth
values of an OPP entry. This allows PCIe drivers to modify the effective
bandwidth at runtime based on the actual link width without needing
separate OPP entries for each configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      opp: Add bw_factor support to adjust bandwidth dynamically
      PCI: qcom: Use bw_factor to adjust bandwidth based on link width
      arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP entries

 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 17 ++--------------
 drivers/opp/core.c                     | 37 ++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h                      |  2 ++
 drivers/pci/controller/dwc/pcie-qcom.c |  8 ++++++--
 include/linux/pm_opp.h                 |  7 +++++++
 5 files changed, 52 insertions(+), 19 deletions(-)
---
base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
change-id: 20250717-opp_pcie-793160b2b113

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


