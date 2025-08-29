Return-Path: <linux-kernel+bounces-791314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC69B3B53E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723D817A361
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786D2C3251;
	Fri, 29 Aug 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXJuG4K3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7212C21E7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454300; cv=none; b=dJ+dEVonx4/QTTvhnuspfldMpwQfmAD85kYFGATdE4rtXK8NYZpHnIP+tC0G17n4pKX22ESu69MsxRsGx1JR3IIDyr4F0HVWu1rHgytGOy+Y1qPfGQyxkGNYiJPJwHAtmvQ3SnuMXN/LXJZ8+G2O7sGw9+XdkxXAdIvrESSqF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454300; c=relaxed/simple;
	bh=2PKGQycBUFlWqOeCmczdNYF3bcFIHeNZBIXA8HRAk4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pFd7jEifyXn71I8VkhepdeZZUY3do3wavOcB0auV/AvrjZQXRgA25GLntEK+tsuU/7/YbGokd7MSd1Z8nYYjRKcQYfMzgdRYRHxFcXU77PrZqvjrg6qR3yEBesppOgbN+avW3SQJQbRsZZ82rg3WM0tgo8CU6mnldfro7OT7l1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXJuG4K3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T5tTwU021676
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nMmvvuBBHOBvmrBWmarNJi
	Kf7qrOg4JEex2f2Ps3aKM=; b=LXJuG4K3BgRrfeZMimgCglFvWnzC3A6JB0c5b1
	gWZAlKyZD1vBDheU1lkx2rB7d86lUE6d8hZMb7hzJ2dYvgVmpOrfddeR9oVHFmRp
	qD4EtZbCxAIWzC7vEta6BXyasLicDH0iYYIFySMPxFlUIIs8kfTr9lJ7QXEOe3VY
	uQTNShypSf92R2zOpM7NTtiAQGxqaR4skZMEP0btSOnQpAgurJ5lNQeNhpo/9OdS
	lZYGdh8DuGL6z5OeuPxKu3iKb6BEA9uRmmIgpcv0UCMgo/XEHyaDRi2haDWIdJ26
	cKognMvQdFp56GC3U2sapYvWcsMUUZDa4Gz5YU907J/N7VjA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615u5x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471757d82fso1468435a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454295; x=1757059095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMmvvuBBHOBvmrBWmarNJiKf7qrOg4JEex2f2Ps3aKM=;
        b=PfCHO2+2R1c5M7I1QDO9qcWxoGHcHPdHZIwlYraMZ5nNPyOiIF9+ElxnsU/8fpRBjH
         L0TGkNzzvSI0Wn3iypwG/47+zbwWILA5gxSUPvmCqITIMN0OIN/0YgktmlmpaRT5Vt3d
         HuJm42ndlw1cDnDCYesX+YDJ+Z/b7fuWBvHyWucgEoSlqIoDYtqnXxZHjcO1aBA+Oyq7
         D2y9DU+RgmwBYRN71JFe/hy5ZB/fTzK0sOcFPDwFXftEpNcE4pLZsL/MOR1ISr/crb0U
         0bKIQ5K71YMRRH14cpMovyfCBlzlE218oEVQvsqeVvBk7ip9X1eq5b7yJ+SnW1SF44x3
         s7gw==
X-Forwarded-Encrypted: i=1; AJvYcCVLPob0EocB04aazhjvIqBZT/BlgVKPXAkCTLXjDJVOK+m1dkD7NGlHeIYXQ2RJ474MEyRXFOGzAJ/zepQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7JC+tULQ80pLQtbAO8mmoCn9HeKkIcWr8Mcalo+04ryPDP/yd
	4IcuqYDVXWUZmn8am/ENLMJ4ju01HDmRCF3Zgi0aqk9lAihQmHbhjiLbolmXtOp6TjbR7s4upzg
	HWZ0kqkg4afWi1JmF8+DOTtH9Hr2U4fcH2x6PySSmGK0pUACfF5cnQj6rhTRjJxLL1dQ=
X-Gm-Gg: ASbGncshuA0mVhCoSuCdQv9SsM6+bVkA/LdMO6Ikll52EkZcwuW9M2mhPdofvKcOneb
	H/ANS5xPbzvYihwRaGrJRsbPLHlTvpc5jf3LildYi2k1sGNdI+E9iSPkEFXtK5P2y/gIfMXN8V8
	25dUBhn/iwP3FXi5j4s4rFwiGHSooXkWu9OzRPdGNo5dZD1hLU7wY4AkQlRrCvLNFgE5gNbwWLE
	VTRnS/nVs0XNWqwc8suoYTTCWmOpJLPXQNcu9KtrInQjtKHRXoqrDtpdk2Ozd7BqY55odHeiUnb
	KhOUiBvvNLLINCGPgVmGJ3/ptGGPPJhG/wXkGLti1WP3h+XRrtm+6WYYcQxW4/c9
X-Received: by 2002:a05:6a20:3d08:b0:243:7136:2fee with SMTP id adf61e73a8af0-24371363240mr24723747637.16.1756454295485;
        Fri, 29 Aug 2025 00:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfNF9XR64zX9+kWe4I9diEOKRZ4goaSDhqBkb/7GI5U8d7hw0kot9p8BjaG3AyVB9EFyxlvA==
X-Received: by 2002:a05:6a20:3d08:b0:243:7136:2fee with SMTP id adf61e73a8af0-24371363240mr24723722637.16.1756454295007;
        Fri, 29 Aug 2025 00:58:15 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bb5dasm1554416b3a.55.2025.08.29.00.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:58:14 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support for Display clock controllers for Glymur
 SoC
Date: Fri, 29 Aug 2025 13:28:02 +0530
Message-Id: <20250829-glymur-disp-clock-controllers-v1-0-0ce6fabd837c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpdsWgC/yWNSW4DIRAAvzLiHCRgFpr5SuRDd9PYKLMFxlEiy
 38Pso9Vh6qHqlKyVDV3D1XkJ9e8bw3sR6f4httVdI6NlTNuNOCCvi5/673omOuhedn5S/O+nWV
 fFilVjyZ5BwCeUFRrHEVS/n31Py9vLvJ9b5vzLdWBJ9/aZO6SBe8QrBiKCQI5cVMffAShKbJl8
 SLI9tUlrNLG65rPuTNp4NAnLwSTRUYaex9JwjAMFqxH500zlNTl+fwHS8mF//EAAAA=
X-Change-ID: 20250829-glymur-disp-clock-controllers-50f728887bae
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX1b4ExTefbjsr
 /y4ACHm57fpjqbzJvlNYOBJ2XMXLLCaU9tVV3jujIe8QVXU0/euIuv1NhQtOxXS4zzdIOzWGA0a
 bq0BFFNCBRlF08U7VInLw8MkfxqN/w/HKNHyGL+YAYaxyAe2fDtcyIt5gdaBaGR2/Yb11bBTQa4
 6WqOeimaIJeVV+992x/hjUH9NRlwQJaLJE7LXBM0+xUT2/VVOnpxCkV0wmYl3sHDMx+YOP+pjLu
 LV6yHt9Fmbsab8ULe5rh81jtAAbJ2F1yFW8K8MfdFcNzxUYVtxHTOrO7z5UjIli/XGEYzTXLqoU
 pUGevsxdPK8dRgPKKKP3b2l9U2zxRqiCpcbkOz2WB2ulCfExQ+OYMKT6h9VnjOeX9dCeqLH/Fml
 WycqxqFb
X-Proofpoint-GUID: EkD03lRfPaxrvsdfV-9VzqnZe0KmuAzj
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b15d98 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=01lUyKRgbtoGor2CX9EA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: EkD03lRfPaxrvsdfV-9VzqnZe0KmuAzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Introduce the support for Display clock controller(DISPCC) for

Qualcomm's next gen compute SoC - Glymur.

Device tree changes aren't part of this series and will be posted separately after the
official announcement of the Glymur SoC.

This series has a dependency on the GCC clock controller series posted
https://lore.kernel.org/all/20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com/

Compilation of the series is dependent on which has been added as
dependency.
https://lore.kernel.org/all/20250825-glymur-clock-controller-v5-v5-5-01b8c8681bcd@oss.qualcomm.com/

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (2):
      dt-bindings: clock: Add DISPCC and reset controller for GLYMUR SoC
      clk: qcom: dispcc-glymur: Add support for Display Clock Controller

 .../bindings/clock/qcom,glymur-dispcc.yaml         |   99 +
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/dispcc-glymur.c                   | 1982 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,glymur-dispcc.h     |  114 ++
 5 files changed, 2206 insertions(+)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250829-glymur-disp-clock-controllers-50f728887bae
prerequisite-patch-id: f1872a81e0bdf89b2e26397d8eb6dc1ce7eeac1e

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


