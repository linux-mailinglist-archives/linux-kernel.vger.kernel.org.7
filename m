Return-Path: <linux-kernel+bounces-831340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBEB9C667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258601BC2E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8AE28935A;
	Wed, 24 Sep 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmD2qSQN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53753288538
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754745; cv=none; b=k0UqXPFQt4aIHPKslm59HRk+dKVWxuQeKIBVZTo/NjWv3MfSDy92vrJxH+/ORqdtNzQJ7xiIJ+eLXauGISzHrDhEjPcWEERSlPgVwpi8kyih2uAzKlqfhI+hkp5lY56g8Djk+wAm0GRAWO3gazzRHj0UP72lxZsq6F5CWWQmMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754745; c=relaxed/simple;
	bh=VRmdDNff981CuK71zFSzHByDaEn7tvZTiAzuPYt1F2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mtwW1NC9jiki6gLkyp13OYkKvevwgA52QDoo0N08vrQ2CO/uboyyzeljsKPVnBoXOmTVtex4483yAty+VDyZ8uMlMrqAoMTCOV9us5CaD1XYiQjV/IjFmVm6HZ8XSHilCP6aPfI9P0FhcHUiZOJLMgSL6DVKfYTFdjbo5C4xQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmD2qSQN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD8wNB002776
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u3OjrzALKFkPVEklOHd20q
	VfJiYmmmJvJyvK6y9PLDQ=; b=BmD2qSQNB7TyyNVpgV4DEajkSDHsYDqDjqAXgn
	mJRhdbYLIEJYbbbiZ/bkGdMCm4H8p4xAUQti4ArDRPDDdw2yrQifgBmC6myQf3jX
	Ni3iNscferVjSdDpups8LREseSggsnegx88Stz+FihWspSOdGEF+lkmQt9Hxj2w9
	cxaP0r/dv3B4d+CEN1e0LPLTMLlv+Mb150JlWGZU61hhwyf94yM0MG/4/lZwVe4t
	ZAAk/YDWVyTAvQfBkrE2jweSE7tYeTDCGZWfN++3d9UViANvcHXqoRbOXmf0eK7x
	6yshb+m9OHM1VTxA0qpDWR564r0FalbS5C9TS7h/2xFFx77A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0h5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f64c5cf62so219000b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754742; x=1759359542;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3OjrzALKFkPVEklOHd20qVfJiYmmmJvJyvK6y9PLDQ=;
        b=q/2wzhYd2zYMiN3d+E1q3pifxXXpp/FEQsAiR+MqkCSb/lTkHZYlKRqihtrAKNEJso
         aiuOsxFdwIIc0lMczKh47yCyqOXiFIuBTvDogaC/PijC1oKJiSPij/AdebmtLlQnPyoj
         0muwaqmDNYpHgXjas8hN1Mdjd0hZwWFWyvX6glDBYCMAYCIRY53ioYyot7Swr1rJUmpK
         5A+7Ztg/X9M5Uu9oRp/QOcNAwgZ8wm/A4pq2Tm8atnVK5qQTFMi9e8A9ru2Ojn0PJ06X
         Uaq0PZLuIxfvmSwzLwYsfMvZ43o+sAMtQ5pO7nvbzLoLgeV+MXhkAhofbnGD2oOqkzNN
         HSvg==
X-Forwarded-Encrypted: i=1; AJvYcCWrHkD+rW3gtuFBG5WpjW819VtgU2Kv1rPo3afOlK22Je357cG49Hv8slMxvQ+blGoGsXsHKgb12ntBFOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WMjlref+VlnqdqlPMT56Kr+9wUKgUwyNHqPgaNkgVftrl/7i
	Fj4+vJCq50Nejv2MkwUnky10FfadSPIzALviF+gDArANBm15bL1kW8fOQ7SEnEHursh/5SqxiDD
	0jarhIabPAtNYBVCEpBM4ywPztynozEbTMSkkyWeBBEKFi2ck7n6EqbhMt+aZxoXKjIY=
X-Gm-Gg: ASbGncsKau0hhVcceeC00B6K3SqmGCB0uojXEThL0cb6BmoMDS6JRzMam29CdbY4mKB
	UarQhO5mDtzRVurkIi51adPhojlpayN3wuWsnf0E6HcVINlHLlPnL9qdT5Zv+C50usLOQ7L433a
	zyGhld1Hc7qejAuTYYPS9gYvq2lYaZy89MZAmC53hHt3aCCoCAMdWZ7/QPms322CSxh9tcfWJl8
	63lzSAs08iBTri7YO0yLmf6RSyy6o7UTJhbk/GUxrbAuNcvVwJlCWWSvl16tm2J/kb4n96LdoCm
	h+qBCOeqGB2bE0LpHU27wR3O/s+4eHfCf/uG0HA9E4HHCHDFVHI8ilXCkBboNtZGzpiaEs2SGJq
	7mlDwdB03XajX3qI=
X-Received: by 2002:a05:6a00:9a5:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-780fcea2fb2mr1423389b3a.16.1758754742328;
        Wed, 24 Sep 2025 15:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwxTp3YIwwATUL1FlU2TnVWjJ1Wgh9OSG5lv6otWYOzXo4pxbLjK//2YLzHHF3GNSQe0Eogg==
X-Received: by 2002:a05:6a00:9a5:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-780fcea2fb2mr1423368b3a.16.1758754741876;
        Wed, 24 Sep 2025 15:59:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/9] Add support for Clock controllers for Kaanapali
Date: Wed, 24 Sep 2025 15:58:52 -0700
Message-Id: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKx31GgC/x3MQQqDMBCF4avIrB2I0VrjVaSLGKd10KYyU0QQ7
 250+cH/3g5KwqTQZjsIraz8iwlFnkEYffwQ8pAM1tiHccUTp7hgmCcMtRlcVTnb1CWkehF683Y
 /da/k3ithLz6G8dp/vf5J4DhOjdg0anIAAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=1775;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VRmdDNff981CuK71zFSzHByDaEn7tvZTiAzuPYt1F2c=;
 b=40OtaH/1YUk1q+qTUL0VW2MAka9Q5DiyEGimgGbSG+IOuLZkbBeTh/1D81rVA+RTpSnv15QQG
 9OGNa2Q7XBfAX8RQDhmQBqne6B91X8C/qplVUaLAqYEtprbzfzs7KGd
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: aNyROfsL30rm488MqEms1LrlD8BmlX3e
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d477b7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=NOZdjAmOODemH_SfJxUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXyEUl1UJJuexB
 CpB25QeBmYircv7E8bEgQqJwJD0/1eFJIwmyQUbMuKr+7UbZhyqJ45Cllas2c4mmjvc8vsnJYSl
 lvzWC0Q8olRHC7c8oLH3elVVRMsfIZebX/7FiQpQQmkl0mtUUkxHHSsFPW0whdKqEbP3ubrfbmm
 xr50rPXb6bOIt/9stI8Znr6GGr+vgz51+jp6eaasnzqxNxKL9Z1ezmAdqUTxQGYHiXH6cgTiLIL
 zGWhxz/a86KOba1cLY6KOVX0dz6Z8CzFH0yH9XPWtPZIubqmHMcoyTBDw2jpVVypSULBTbKjFlr
 Ju0u964YTDK7F7WfVLTivGEarcmvB9Qbig7YbbV62lhFUcN25xpc9/QpveBHaqDekgRxE2/8Ksi
 Qgg1sgMM
X-Proofpoint-ORIG-GUID: aNyROfsL30rm488MqEms1LrlD8BmlX3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Add support for Global clock controller(GCC), TCSR and the RPMH clock
controller for the Qualcomm Kaanapali SoC. And update the PLL support.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Taniya Das (9):
      dt-bindings: clock: qcom-rpmhcc: Add RPMHCC for Kaanapali
      dt-bindings: clock: qcom: Document the Kaanapali TCSR Clock Controller
      dt-bindings: clock: qcom: Add Kaanapali Global clock controller
      clk: qcom: rpmh: Add support for Kaanapali rpmh clocks
      clk: qcom: Update TCSR clock driver for Kaanapali
      clk: qcom: Add support for Global clock controller on Kaanapali
      clk: qcom: clk-alpha-pll: Update the PLL support for cal_l
      clk: qcom: clk-alpha-pll: Add support for controlling Pongo EKO_T PLL
      clk: qcom: clk-alpha-pll: Add support for controlling Rivian PLL

 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |    8 +-
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   20 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    7 +
 drivers/clk/qcom/clk-rpmh.c                        |   39 +
 drivers/clk/qcom/gcc-kaanapali.c                   | 3541 ++++++++++++++++++++
 drivers/clk/qcom/tcsrcc-sm8750.c                   |   34 +-
 include/dt-bindings/clock/qcom,kaanapali-gcc.h     |  241 ++
 11 files changed, 3897 insertions(+), 5 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-clk-c60d94492863

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


