Return-Path: <linux-kernel+bounces-727405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D2B019AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF81CA4318
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE7283CBF;
	Fri, 11 Jul 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dr58cQa8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2C281531
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229553; cv=none; b=qbED4z4bND0tJ7JVLxBFAlpOZ3P9/ubrZquO7hgLjuyoI5LWmDeb55OBu+yCoCvIg9+D7LLSg7SVz/KwyXDQC9EcRkDHsVq6sV+bRoUvLomEyrMjcOffcMzEuMUcVNwrWBVMTUvoVHogtKv1oKlyw2FrAZ9x8pbhh/B5rgDGg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229553; c=relaxed/simple;
	bh=PUWLtICbEV4L4aRlWDR0eUg09UFWc4K+vrBGp32riA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsjNFMlIX9N262LB56gbcoIjoEsnSb83lUArqUpTI3jIiY9+r/zAZhqpspzIkI/73a3u3tqH+G4fGsfoECyIhPArtOsV6YeJsGfTkLr2MFtttUqCRafy9ehen8RXBRzfr1jl0uvpQ8n219LvQihR2Kn7Byj6OS89i8tTaFOf+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dr58cQa8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7Zr021758
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H0BE0LBDOrjuC7B70yCc4WxoF2P4/T4YLOW
	BcDkRgnE=; b=Dr58cQa8Au9Kq//IpQjchEEbWX1jbEuhhQ6vnGT8GyJDavRhvm6
	DQ621XqYWv/b+54bZLCNGBKeJBM+5gmeifYtVGVs3LqF05EZdSYORvh9c6Oxbn5x
	iSRESzFgOhPypXGtAQ1sQmc53dkovUIU8IF5SuEvFr05Ieohwz3fRZJJwv4uDg10
	76Ir76RyeFwXEn84Y5Q3Glygvc1gNl7INc3AuuJeQHylBC0K/zBL9BIFjBOFkJds
	DfabjTMqYPuRePcjr20ECWuOv4O/JjdA6Z7sKvpXH/Cualeyo8GLtgccq0iBjfNN
	EWB1AzrO6aznxESkx72chff2IS9w4qSGhUA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b198fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:25:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234b133b428so16049645ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229549; x=1752834349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0BE0LBDOrjuC7B70yCc4WxoF2P4/T4YLOWBcDkRgnE=;
        b=tcrb94um7NmcbCb9aoB1flR689SavrROVURyyaa/2WvCrSWyZIG54kpFf5Bk2oJvq4
         dR6Hp/IEWzS4bEZE+LOx0QbESTjqD7rHcpKJ1kZ1ftMEKiIZ2YwkFc6XugycQSdc+KIl
         bJJGF8NTk/XG2NAxN/oYWA6KLPbixIp0J9f7cQs37TOOIzJVnX6t/Pc9TyRgK67Yc6OA
         hMvQjf2Rdw4ZIZwBpU4Ynetl4TUCYnUOwchbcduzTZZl9FEhf1OF1L5IaFDC6oxsosoQ
         NiHMkWfaudM54F10p0M4BWfID1zLbe7+Fto8YRlQKESkswomReiMDWwkF+CyeGCIW/Qk
         xt6g==
X-Forwarded-Encrypted: i=1; AJvYcCXAvwfZOPaYRNrMZWztcuK0wNApd54FeZznAHzaVKHME+tc4pSo4Nc7KpNAICfkLA2USf3Q05eVbmiUKZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRqEYEuSg7FlnSbGGPi8wY8fA8cdV8UNDgfAVUnVEElap5Jdzp
	c1FvXqYMKU5eF3Lu72d0573ggpriFtrg/ZW9sQGFFxTPI/Kt+q5QfLKPozgEc4rhV79n62MUIqr
	/C1e49cLm9ePI3T/NHhD+ZbxgoZ/DpTwLxkuq84Ym4m3oCS8KMJRp4sb957OTUHyQT6w=
X-Gm-Gg: ASbGncsMokcjDAHvHo+dLPz7Mr+dglIyqEqWBPn56FUnPR0KXdyRnCXK/7GIBRWhlMS
	kZfVYXk6r6ubq8Yv7bfJ31KrXpN/tROL2ZC2Kc++3Z+AgOvK8KSttWETmj36y2FvnI5Q3ZEatDc
	aMjgJ9pvJkLnQIMwZDTu7eArXbdhixQ5W5HttzwC93C66/ELU00P1PaGsmJDBCuiNv0iBF+IwPk
	/JycF4QSRQdFadxa96k0SlR1//8zBL/YYgKV36luxWEdgJOWn1ru/iS8FppdtK1L5g+eyz3VE9R
	xNkkWNGrkk6Fgx/evniAHmS6L/uNrkm4OEu7xqQvSeD7Cgd+ybUvugT0qHAqBuotHMT1g3uJTxv
	I7yI=
X-Received: by 2002:a17:902:e88e:b0:23d:d0e7:754b with SMTP id d9443c01a7336-23df0831355mr23342215ad.18.1752229549014;
        Fri, 11 Jul 2025 03:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMWhYRTz9DHMwDnknPY8+YaEh+l+tNPzBDYHrBCVYA0fm1baC/+C2SiR09t+a0HEd6eQzK+w==
X-Received: by 2002:a17:902:e88e:b0:23d:d0e7:754b with SMTP id d9443c01a7336-23df0831355mr23341885ad.18.1752229548626;
        Fri, 11 Jul 2025 03:25:48 -0700 (PDT)
Received: from a10065738a1d.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436839bsm42861375ad.253.2025.07.11.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:25:48 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 0/3] Add EPSS L3 provider support on QCS8300 SoC
Date: Fri, 11 Jul 2025 10:25:37 +0000
Message-ID: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6870e6ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=3bDbtYyfCIv0pmMcAUEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MyBTYWx0ZWRfXyHN1JVi8iVkE
 Pu2X11RyFZgVYlO0rmYOf+vTf04i7s4AX9dvQEmH9yvG625wM8guc676yuHJB1nzEYIyytUAaIq
 IgBW9GKuIS7sXEn+jdfx6kF1mXL0mmh8JrmnA5Kn17ZK8R6HIEgYY+0RYjKkmfO6ebfzzuxoxCu
 VlpveONyO4NcJ7Jk8JA4zBMDWQtgnWRz7p8fH3CSdqdJnJDXn08oVsL8+0gML9KknmFupADxDPX
 kbFpR3TWoaWOmGjsg1BZq2XifghWepAc+pb4VHl4VVwgJM3r0VHTcCJnthnyDanK2iSQ+J6kjtE
 gOlAKDwx+FSXcQ2buPDROMNJ20CnSzNU8uRs92qS/3fAKZwdHHMG4R9J8RbMcLbnKviEqRU4Ei6
 ZpkNnc9cTp/x617l3YX7KuJa7vNc+6cI7/IfBTr3A4Z3ELwbNEf/00NOHgZsZsfeBcnvKUQk
X-Proofpoint-GUID: lUocIQK7D7LOzAwr6ZzQ-ObFDbDMQxJ8
X-Proofpoint-ORIG-GUID: lUocIQK7D7LOzAwr6ZzQ-ObFDbDMQxJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110073

Add Epoch subsystem (EPSS) L3 scaling support on QCS8300 SoC.

Changes since v1:
 - Removed SoC specific compatible "qcom,qcs8300-epss-l3"
   from driver and used SA8775P SoC compatible as fallback in devicetree.
 - As the EPSS hardware in QCS8300 and SA8775P SoCs are same, a 
   family-specific compatible string for the SA8775P has been added to the
   bindings. This avoids the need to explicitly listing each SoC in the
   match table and the family-specific fallback compatible can be used 
   for SoCs sharing the same hardware.
 - As suggested by konrad, added EPSS path handles for CPU nodes.

Imran Shaik (1):
  arm64: dts: qcom: qcs8300: Add CPU OPP tables to scale DDR/L3

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC
  arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 301 ++++++++++++++++++
 2 files changed, 306 insertions(+)

-- 
2.43.0


