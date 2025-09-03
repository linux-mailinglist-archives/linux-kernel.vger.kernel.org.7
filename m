Return-Path: <linux-kernel+bounces-798919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE631B424B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB77B9D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3284A313E2D;
	Wed,  3 Sep 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5VsLliO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300D3126B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912438; cv=none; b=Ct5GsWaUchZh1SU9rf6h/xKkssCoBQYN+e8KdXMA9L46KwNX3y9a5mtoGH1/8hQjchIcAZOh5XMCFVeaCG2DjHm03e15Xt13HPbcQ3vwGwSu7SVZT/stEaZUDpp4qrBmJSayGeTgqcOUAAJW50uPgk5wQTEsSCTTpVjRGtaSMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912438; c=relaxed/simple;
	bh=N9pCrJsrksPZHbfTDg3q0oMKXZzLcwpcCHloRxnFnzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbgKiwlkFVNfloPdCw7iTXzz/RcqhPAOgmr//m52RpHYCgeSaScMxie8IigyyyyOMUj/LrDdUEZyA7uZUId7fRSW/RZC4sUdV9U+eHegHbZYsW+IepAXLIgUWsNR+fWqzhdAXu5BVjwemRA9sR9vJvcwUsFvmOmWlYE4XBWpdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5VsLliO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxRum030324
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mDN4FfFt8TdXKMwEo9wkMwI0x1P9k50TGR1
	4bDK8xzM=; b=W5VsLliOExXoWdTEvI97N03SCEg3k9x4P3WY3fbXXOhdlm0m/Nw
	GUU6QMpf64C9ZFE60FGl3wX9TonziiRYH9mrYWKRG2zZz/ZDsQS3/nKlS7x08Nza
	w6a6c+OxFAt+PS7Ab8bggQHKyzsrHAKdv34MatbQiAlqRf6Sor04YyTbcvmjgyVA
	tRnLrZlGt54grw+VGz/DvQZurTJBjwK/K4/khHx1engzjqBoqsEsBk+G0M0/PQnU
	foIH1XdO8yrTgxxyAxPHtRsAvdJaoAjwNld/rJ3k0dIPJ/99l8a72uY4W6gvDm+i
	wH1OBRyRjNdET5WdoY2E6qJfu+aBUIeuD3g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpca3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:13:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24b0e137484so429925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912434; x=1757517234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDN4FfFt8TdXKMwEo9wkMwI0x1P9k50TGR14bDK8xzM=;
        b=bOqT6+K6++S5s+qJmHNO66mKDqrjz0Kz8ULLmtvHjncl2QRisdXRc9SFB2hn6irC3e
         pHBEgvKWWBZZcRYbzmEG0NmATL53yU5DVALYLpsaBPcZY1UVUcxicR5od7T23xm0z0TP
         juTMKFKkqatA4WVnyi/jegxZBjoSuWxNhiyq62NxR6FWzQd3/FVwJ9ajsJDoIeWEj/8c
         YHTwo83FhINZa1/0gMhmDRR2eyPfBPfRBMOwvuNHC/slheNb8cVrzcVr4IXetE/gRXou
         F6/bYd5L9y7SS9aAdQ7zrnJhUDh5tyjP74WbxrfoCie5hK+N6UsODZna4BclkuEgQclw
         czQg==
X-Forwarded-Encrypted: i=1; AJvYcCXb5FjZml78zpJypeiSvwk7mFPtehAto8wn34dYYt7jmASVk2ws6MmVxzNe0DrlWfEJzsG6BxQvyGzZt8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkU/iUwcDOTcMbWie1oWQQXz5aKNh5rxjMz1RZ9Yp/0JjfpNZR
	Kor5BArV5n4zc34LYEUYr0blU5ki0Au/uJ4FIDCQCiOgJE+fWpA/7pFSWfDpyo/tuweFnyrM2W1
	tBB9PfJJCtOk8PoQ9UqEVp3zocyEd3TThLQSDdhK8bghUBOeagPQwnBj9oWk4qVJzPAE=
X-Gm-Gg: ASbGncvn+vZwOLqR91JIY67T2Vrj/BrnC7CwxDbQjhq0z6AIKKbfzsxkZHbWi/3U3w2
	NvHXDQhNB7+D2Mcu8PKVo9UM3qVZv6Goto90E1E47WNJk/DoCUmQFsBUHwlMUHhE7KhZnSrlXKx
	IhoMfgqqhFdqP2yOYp9LHMB6WmaA0PQpqmjwSWNSXFDa5RmUVgQyn7luRmQGVO6PfwOudsw8ksK
	IiS6a1P+JxfpTICnGK53XjsbbMFphqEGF99jGW6ikB1gV2eGeshNeATZTH8zQPuYOPRzscKp9hT
	NfxI9o2FvIZOysOlzsTWyPqGnGWS7RmFEpfGKV5E4pqkmUf/XWn6IX7/2H9h0hzj4V2BRamf37R
	D
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr235877115ad.3.1756912433735;
        Wed, 03 Sep 2025 08:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsAqlt44R0py+c/3EHwlf1O7gYiuEg3aN1wafjI9wkjmT6KV6B7i2h1KnrO57/tqN0i5gGQw==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr235876585ad.3.1756912433048;
        Wed, 03 Sep 2025 08:13:53 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:13:52 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
Subject: [PATCH v9 0/8] Enable audio on qcs6490-RB3Gen2 and qcm6490-idp boards
Date: Wed,  3 Sep 2025 20:43:29 +0530
Message-Id: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: er-1hDeMMpJAGQMhVnWHlA9HcwmPyq07
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b85b33 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=eK7tGN94E5jGERbYYjcA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: er-1hDeMMpJAGQMhVnWHlA9HcwmPyq07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXwxjg/EEv9hQC
 HeHAxtAeP5eJeWrpeEtDnrlAy5JjZZ/sGuyVW/QAqAiY7pah4Y+4hFoxizcD+koZ+Fm65n7xdDK
 a3uPoyfr2NNk+iRnfIflx2E3OZeXMjPKKbzHxfP9cii/n1auKPsDvq+e1fmZFi+yyXBggCWkyUG
 iujqVzPJxr4b3O5aKjaptkFGUhkDhz1oIlxQP88wIMP+O3oxZ/ID1XVlrm2Y3c+XMFmeUpQh6XJ
 20qbm58PQnj6xWw+pNOg3wrOGXQwrn6l/bkOrnU7ZKVQMIeXX6ThIItc6QLXFkLFR6EFEmP0Ly7
 c5v4RjYgJY/6yoHKGPqVfiB+DWC+NCVn8LOqHReoE8n93qs1m44iXOPtAvZGaK80/utJ/7dtvq4
 rR31w50A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Audio support is now enabled on the qcs6490-RB3Gen2 and qcm6490-idp boards.
The updates include adding the necessary audio device tree support and the
required dependencies.

Both the qcs6490-RB3Gen2 and qcm6490-idp boards are derived from the
same SoC  platform. Therefore, the audio support changes are included
in a single patch set for consistency and ease of maintenance.

changes in [v9]:
	- Enhanced the commit message for patch 2 with a more detailed description,
	  as suggested by Bjorn.
	- Dropped patch V8-0002 (pinctrl DT-binding) since it has already been applied.
	- Reorganized the patch series, bindings are now presented first,
	  followed by DTS changes.
	- Link to V8: https://lore.kernel.org/linux-sound/20250821044914.710044-1-quic_pkumpatl@quicinc.com/

changes in [v8]:
	- Added drive strength for all lpass_dmic pinctrl nodes reported by Konrad Dybcio.
	- Rebased changes on top of the latest kernel tree.
	- Link to V7: https://lore.kernel.org/all/20250720173215.3075576-1-quic_pkumpatl@quicinc.com/

changes in [v7]:
	- Addressed the review commnets in dt-binding patches from Krzysztof Kozlowski
	- Rebased changes on top of dependent patches
	- Link to V6: https://lore.kernel.org/linux-sound/20250715180050.3920019-1-quic_pkumpatl@quicinc.com/

changes in [v6]:
	- Addressed the review commnets in dt-binding patches from Krzysztof Kozlowski
	- Link to V5: https://lore.kernel.org/linux-arm-msm/20250625082927.31038-1-quic_pkumpatl@quicinc.com/

changes in [v5]:
	- Added separate patch for QCS6490 pinctrl bindings.
	- Updated commit message with more description.
	- Addressed the review commnets.
	- Link to V4: https://lore.kernel.org/linux-arm-msm/20250527111227.2318021-1-quic_pkumpatl@quicinc.com/

Changes in [v4]:
	- Fix DT binding errors by adding dt-binding clock changes for ADSP base platform.
	- Link to V3 : https://lore.kernel.org/linux-arm-msm/20250520062618.2765109-1-quic_pkumpatl@quicinc.com/

Changes in [v3]:
	- Added protection-domain in gpr services.
	- Addressed the review commnets from Konrad Dybcio.
	- Fix DT binding errors reported by Rob Herring.
	- Link to V2 : https://lore.kernel.org/linux-arm-msm/20250429092430.21477-1-quic_pkumpatl@quicinc.com/

Changes in [v2]:
	- Created dtsi file to handle common audio nodes to support Audioreach.
	- Addressed the review comments.
	- Link to V1 : https://lore.kernel.org/linux-arm-msm/20250317054151.6095-2-quic_pkumpatl@quicinc.com/

Mohammad Rafi Shaik (8):
  ASoC: dt-bindings: qcom,lpass-va-macro: Update bindings for clocks to
    support ADSP
  arm64: dts: qcom: qcs6490-audioreach: Add AudioReach support for
    QCS6490
  arm64: dts: qcom: sc7280: Add WSA SoundWire and LPASS support
  arm64: dts: qcom: qcs6490-audioreach: Enable LPASS macros clock
    settings for audioreach
  arm64: dts: qcom: qcs6490-rb3gen2: Add WSA8830 speakers amplifier
  arm64: dts: qcom: qcs6490-rb3gen2: Add sound card
  arm64: dts: qcom: qcm6490-idp: Add WSA8830 speakers and WCD9370
    headset codec
  arm64: dts: qcom: qcm6490-idp: Add sound card

 .../bindings/sound/qcom,lpass-va-macro.yaml   |  23 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      | 207 ++++++++++++++++++
 .../boot/dts/qcom/qcs6490-audioreach.dtsi     | 119 ++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  80 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  99 ++++++++-
 5 files changed, 522 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi


base-commit: 3db46a82d467bd23d9ebc473d872a865785299d8
-- 
2.34.1


