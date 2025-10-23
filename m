Return-Path: <linux-kernel+bounces-866199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA980BFF24F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575EA3A9CED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053A247293;
	Thu, 23 Oct 2025 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yl144q6a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB823A9AE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194394; cv=none; b=CeULC753b6kvKq79+mMUQYs23kfpiEa7rb3iiYe9DfFT+h6oV2cZMusXLnlv5HidD62pEw5PAJ8vr56APUEiqoTXAvW/KTwbotX3J5gfWUjoTh+nwobYFjS0JOipZ4F7SvYflenoz9B2LBOZDlDQ9JAIvTwQnxGDq258jxDo3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194394; c=relaxed/simple;
	bh=nyYBG+C521Gf1LNyIwasfoR5n1BHZIoeUKviWVU75tQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sCbLxLjsOv1h++uHEF9LPC5xoH2Hu0yX/rYmYZjmTbSNMQb1HwGxIZE2G1dJIOXCamMOrojmMHqq6mhQaJ0oWeOQJfPz5lfA6R9Ez8AIsjg4BwCEmEuOtKgPaCQscjLsKSKOfEUNGD2UNM3BpF5t8S/8lpCSUrjf442Km7rlk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yl144q6a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIemb7018576
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d6kkudxWu0dxDCjlg0gydr
	n4lcJ8I6aqJcWerzC/ZQI=; b=Yl144q6atOBXe3SPe84OsNOtbYO2j0vP8LHqx/
	dv8X/SGYsUa/sw+SlWHZQetcOz0MnWCf/x/y+fXyj1UmGd/YHlt6qLd/AhJ6+a3l
	202OvjoVYvkqG9z6WNRZJOlTOrcroJwuAuLQQU7kqOzT2ZmNKOb4oNgzlMrad/Ee
	ba5sJKTKT0oJmQXWcvbP5rrNH82qphUWDeIKLTvMXJZzobdvj8F1heFscwhE5ByL
	ae8N2hWDUItRq0Mz0yYVb+2V3yLxC7rSEsCxtdfVhoEqUnSJX+l6I9Ha+3hCGI6L
	0/vA3OFOgH5PQGNOVLgisPWIZFD6Sxb4dp0XLUmBL/hODNYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pq85h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:39:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290b13e3ac0so3903865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194389; x=1761799189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6kkudxWu0dxDCjlg0gydrn4lcJ8I6aqJcWerzC/ZQI=;
        b=TMclNMrYdVNko9K843zZ1k8mOWLt2YkrmXVuRE4bqnE8G0kFIqwM4jSJfPIsWXhfxJ
         SZ7sYGN2DlojRlJQQwpAvKEDdqsNKUHDz6MvtI+Z04S7odbTYQjTxpz6houxv99LTvJ5
         gMtERsVyS2bzyTxCpcSs+J+pQgUSHWfgScfs1TlYKRBIv1Z7JxlKfJdSZR1P7fhPwO9h
         iCkXrREduMEfchzktX6jREO0ohObi+5mjbz3SzXjY5qbJ5/r5B6I9bDTsE73todtCOMX
         zQjPKS/F3SKBqML8F7woWA5+G0zJsacSumvnePJ1IrbRu7l1HJQ06PE/6DRaHqe2Fw86
         dIvA==
X-Forwarded-Encrypted: i=1; AJvYcCWzeE8XXaBaAmRFsvDUQbbG0f7DFG293UoPIXnAn64lP4TJAqgSfwGiTZ9ujp53JOZtcDbZpOwcQ0H4jPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOn+dNI0wGELP/5l52bSWUS793RgW+sAepTJ4IKolNYxYw7om
	uN3gISAQG9TsfHHgCWcplF67moGZBPoWN/p9K2lM00SF65891zwIuWEpjGAsCcY0RPxGMp2dwRq
	Y7o+23wIp9OKXTg27xO/ct8uRsEvIkgkH+nUnL6VUvrAwETCyCeNkRrbdhlHnGc4VNHw=
X-Gm-Gg: ASbGncuh/tosGII1nGyD2p2/bFvubidFpHLt5/c/7jt5cQcxM8caMF0NqcvfMXrny/H
	YYOE2uqXQzIkC/yA0CffT9+/C0K1u22djfmN8nU1rA7NJ/KMfUUux/xaVRYGfBNEoRACSvO+xvh
	n1MMXlieHKAgD3r5oJu+8o2Ey0XiKU4N2TGKzEJ0Lqa+gzDDpPrUB5FIeqW/zX5MOM2LxeUV8Hl
	1qc4i1v93grtx8MaFKjgYBo8UfdA9kpx2Wnl+REhBjeLrWNySSsYxsLzYGLu/5vyepRtLVCpqxt
	b4xq4w1jCRqJeqStckccm5bX2stKUYc+nYs2rl6cpmwvBNXHHJxgZZFzhHvMs64TSk5WthDd+WW
	ogdGO2Ajn4rMGulA77IlWLw==
X-Received: by 2002:a17:902:ce0e:b0:273:c463:7b2c with SMTP id d9443c01a7336-290c9c89680mr264622185ad.3.1761194388619;
        Wed, 22 Oct 2025 21:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe14IfMJmE3gpP70RjdmEvG7bvtjETCimcF/KuJ3HjZi1sWXgTDwZnoAK6qBWI375OY6jIcw==
X-Received: by 2002:a17:902:ce0e:b0:273:c463:7b2c with SMTP id d9443c01a7336-290c9c89680mr264621965ad.3.1761194388187;
        Wed, 22 Oct 2025 21:39:48 -0700 (PDT)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a3f0sm754187a12.20.2025.10.22.21.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:39:47 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Kaanapali SoC
Date: Thu, 23 Oct 2025 04:39:31 +0000
Message-Id: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOx+WgC/1WNywrDIBQFfyW4rqDmaX6lZKHXayNtTKo2FEL+v
 fZF6XLgzJyNRAwOI+mLjQRcXXSzz8APBYFR+RNSZzITwUTNJG/p2S/U+YQBZu8REq06ECC5trb
 uSNaWgNbdX8njkFmriFQH5WF8hiYVs/wZBrze8mV6r3+PffH3B5czhYYZWVVSdE3Zr5x8yzBPk
 0t9oVAYwVjW2saITpYIylpRG12aFq3kkilguiHDvj8AU//12vYAAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXzCXaazk3YXMH
 yeYX2i+24snaBm/do7J98rvtoikCEOfSkNlBXOxlavcVoeelyYfb/PaQTfxMByiHBr/LdYaskYT
 NvBk5G30Aai+F+F7HNMIHh/FrTBfPVNqiWcZypkqYy8MSrZUxL1RgJjaQ0E2b97I2isWXnUwZmu
 QOStLk++U+T3iJq63ILBOQQgXprnfvoOAOUyLrlC1XJusz7LT/VGwNiYG/k6iTdGsOj45sqkR5Q
 ghQLJa32a6A6gOTel+shcRPpWLuvrtCRJKqT3LM6kairwdYWb7oL9cuzWXT+90NRzR9N8+jRMvU
 WfhhDO6Ufa1KJpji/gHkPJMIiMlgnKEDBl82dCncr5QYrd9/M+AEsPmn0iOYJRmQGpPCRQATngO
 bmquU11eKdiASAjiLPuc3YcGSz70WQ==
X-Proofpoint-GUID: wAivjaLhA8JXe0CFtOojnrVt14P81-B2
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9b196 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_cDidGYXCDOhaqYtY5wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: wAivjaLhA8JXe0CFtOojnrVt14P81-B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

bindings file depends on Kaanapali gcc patch header file:
https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/

Changes since V1:
  - Added b4 dependency on the clock patch [Rob]
  - Updated the Module Description to "Qualcomm Kaanapali NoC driver"
    [Dmitry]

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  126 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2154 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58
prerequisite-change-id: 20250917-knp-clk-c60d94492863:v1
prerequisite-patch-id: 74589b64dc18360c773f802e493e02d52ce48ce8
prerequisite-patch-id: 0838e4968ea7bf2c6fcf1831c18e043b081b986e
prerequisite-patch-id: bad55c083296ece4f87573e6abfac5bd8623d52a
prerequisite-patch-id: 4b369fae9593dd9daa252dbf5e289979fef92079
prerequisite-patch-id: a5098157b969d17b6c7d6fa26b9fe034119599f4
prerequisite-patch-id: 649808efe6118765b742a53c5439515e7466bc0c
prerequisite-patch-id: 8e17e701a84a458666012e6ac5d00e280e8b5dab
prerequisite-patch-id: 7e58c87a2d504fc1eb4285e8dcd6d031f229fe08
prerequisite-patch-id: 7ce134f219cc6d8589337762b92bdcb9210dd05d

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


