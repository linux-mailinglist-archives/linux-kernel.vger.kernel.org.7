Return-Path: <linux-kernel+bounces-753642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD7B185DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B211C1C27285
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA219C556;
	Fri,  1 Aug 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsTCdten"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE619C55E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066175; cv=none; b=VPEycESuqLM0QDnwRrW3irjSFzjfzMrZWq5OOkZm9+OLLchD4YCl/qT7r8G8GQtCem6Q6hmLCaYLb4JP+Ft6JlTy/F4FxR8JlpyJT+L4XMahboL4KNeA4kg2ejrxNhUUaqU7rmJALYidOPC7FoNkWfnrDDZR2BN+pKgrT0Hnmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066175; c=relaxed/simple;
	bh=AmW+b065ge5sTI+7pIcNe3kGOs5DStbMkc57uj1AR0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J2K6Kv83/y299kikxmzvkaNExlc4WnmmK46WyVlH76+1JvOLOFfTjkn2eaFjaG7sbZlh3rznxaJ3e+uL/KeDciBOlUBSOwJARKQJOO3AaeZVaVREVS6SZw+NQAnXDvXCkg5DERXk5to52zZaxw7yMeBX9mpZ6ZvUu0KI/vf+2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsTCdten; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57194J6i001555
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/NFK8WhPmlJkIlRULR/68W
	CcR70A/MJjvtlrA8A/Jgg=; b=AsTCdtenObTKWsBWYrdKVkzD7KqRVMMjbdR6nU
	OGruBVtWz4PjcNJW/lKoG8bPg54eDXNXQcgznXEnuw15022C8GRo2rYNSJzd51q1
	i8BcxCzOoIhkFr1SBlP/ttJ+/J+mgzxyZ1RH28+L74fkC7VVGSdnMwu9hlFHrS5C
	lMM3+Vyij60VwBwtcvtzvjEtzoPBnMatx9DD1jkJU8i4L007e7D6K3QkXGAbZZlr
	6a/4ljJRaMBEJXU5Bojbji86wwcncuuKNWQRIth63HjSdVJZESIyRVTMYjQwKyRR
	ORdLZ56EoN31hDe92ZLE8UwqZbAEwYneunvRrcmD3TkQD89Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyucyss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:36:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75a23a16107so419997b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066173; x=1754670973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NFK8WhPmlJkIlRULR/68WCcR70A/MJjvtlrA8A/Jgg=;
        b=BzMkJAAhiFb1zvKaO1cBSkhEzpaIz37RJ41I/uOYZiugGfirb+sado1HKQzf5oka4G
         zUO499J3NoJxqHlg5Qft8G9N9KL2xrNCgbYb4efYTI82kebcrzVxc5++gblbRPbYFr6i
         21lBnHOgBrAPeUT7cMU8+hXWrPv1PAtSgZkWK2GNS81jkr3OcN41SxuPNfwQcNWLae91
         3Im/55SwOOc29yxwDeDkK1BXyB1Gf1eSpbJYXiaYjocYCmk2xNbavMlhi8dbl4G1S3aM
         tWKPSCG9b5MLT7Hhf7+Z7ITVpAxvYkn/OLkPDH42EkPStidubL6tIDtkdvn6fTm+d0wU
         5SBw==
X-Forwarded-Encrypted: i=1; AJvYcCWPxIJnwSR3aCuc+QcV3jlWWn+d0K7odazOfzHz4oO/2wvKEqvuUUTXTBHyXsy3BHlng1e9viBZ8cr/cw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBVorJdm/znAIWJYg/VLa7r0tG8ppY3Tn3WnG1hs5B219Kl32
	izL64GME+4p0xs4WeeJhUaUKpft7z+ax4YDNuvIgNMApaIPYv/3keWnJjqvWxLp27gYJo0AwtGG
	6HZTkhCPx13WvsgIXFpAlnaXPXUi2YcoNpZ17tg4B3qiZCnWinoV32PZ1rf/Auko6euY=
X-Gm-Gg: ASbGncuktx+c88Vb8O5OXo44+nJ4O9oNJzOhilLb4llx2e8knNQZOxSKtl6rhBw76CA
	nujlnFXz19URRrLGMRDzT+QaMtTG4va+6X/8qnWaQFUGB6aPf55/ZcllbEL7R25fQ7oGzKtKmUB
	kXXZuub0QSdgMyLPtxYdBvIfFmUMTOtDPQ7K5TUhRg4ExGK+sL5pSV/CnHy7im1F/ex+VvfrvY4
	K0q2WWEjaU5b3/RlS5NSU9M1uNxYuEiK/BP86T2WE4vOCg61SLbQqioN3DYow0roAgwfjRYICGY
	dAklmhQzZAjp3xsc35gqDT0aGvHxRyLHPfvnykdwsE7CrI+pT8IOEMiFDaEIO+KTtTNRkG0=
X-Received: by 2002:a05:6a00:21d1:b0:748:f854:b76b with SMTP id d2e1a72fcca58-76bec49b990mr9126b3a.3.1754066172593;
        Fri, 01 Aug 2025 09:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BaMIiVnIsuT54Y977OTNu4zKWE0nhR0T93LsNlL1N2tp5wnpv17bakc03Yx5adyaiUQYlg==
X-Received: by 2002:a05:6a00:21d1:b0:748:f854:b76b with SMTP id d2e1a72fcca58-76bec49b990mr9109b3a.3.1754066172153;
        Fri, 01 Aug 2025 09:36:12 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe74bfsm4508775b3a.121.2025.08.01.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:36:11 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, umang.chheda@oss.qualcomm.com
Subject: [PATCH V2 0/2] Introduce initial support for Monaco Evaluation Kit
Date: Fri,  1 Aug 2025 22:06:05 +0530
Message-Id: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nuk5YdFmcxXfd1nrck8qqGlEyUxWf1GS
X-Proofpoint-ORIG-GUID: Nuk5YdFmcxXfd1nrck8qqGlEyUxWf1GS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyNCBTYWx0ZWRfX+eN8oh1ly/EE
 /nXgY2IcUlY+3sa7qC0q//IAprCgP7dgZS51vCwAMb7PiM7RlE5ww06R2owA+dBqFmyXWAq6v2D
 FHHQMbrAUywb75w0Lbuxqn7pMrdqjfnDZi2lNERbApd+0BUtGvsX5ZnqMcBGTUMq0XKv/sP5qvP
 ogcunhrGb9ulnxv9+4Y+ve7phUWa5wLs2S/vSvJwPTtL6Je0/yd2N7rEd0cbkgxaDnyQ09SX5Wd
 M2NhGwfQtZC1NtdrdzAiUCCydcZcAwAvnsoW6T4p76KRqOPqrLXYjQGJwaqEHTqntyZbB8TnS/B
 0jhyvARvEpGoLP0xmRyXTkPwpu4Indc7P5rA0MkmPUQraVYDl3VYGbWeqAS+3f1iX8Uj7DAhA8G
 h/d5NgPwrLuaO30Th2nwDGW1K7CSpB77NCBqz541HEDtKliI2PVDczWotXyYMkNbFm5q8Ay4
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688cecfd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=qf4gfuq51q0A:10 a=2OwXVqhp2XgA:10 a=xyu6GANZigqoUC4sCMYA:9
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010124

This series:

Add support for Qualcomm's Monaco Evaluation Kit (EVK) without
safety monitoring feature of Safety Island(SAIL) subsystem.
This board is based on Qualcomm's QCS8300 SoC.

Monaco EVK board is a single board computer (SBC) that supports various
industrial applications, including factory automation, industrial
robots, drones, edge AI boxes, machine vision, autonomous mobile
robots (AMRs), and industrial gateways.

Below are detailed informations on monaco-evk HW:
------------------------------------------------------
monaco-evk is single board supporting these peripherals:
  - Storage: 1 × 128 GB UFS, micro-SD card, EEPROMs for MACs,
    eMMC on mezzanine card
  - Audio/Video, Camera & Display ports
  - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD
  - PCIe ports
  - USB & UART ports

On top of monaco-evk board additional mezzanine boards can be stacked
in future.

Currently basic features like  uart/ufs are implemented to enable
'boot to shell'.

Changes in [v2] :
  - Addressed Bjorn's comment to rename the board filename and
    compatible to monaco-evk.

Umang Chheda (2):
  dt-bindings: arm: qcom: Add bindings for Monaco EVK
  arm64: dts: qcom: Add Monaco evaluation kit initial board support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/monaco-evk.dts       | 199 ++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts

-- 
2.25.1


