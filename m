Return-Path: <linux-kernel+bounces-870296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B9C0A677
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86DA4349712
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B423C8C5;
	Sun, 26 Oct 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAy3N3PX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221E1DA60F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477488; cv=none; b=QopTlLy04nbu8NakOxDAJe8rHjEY6Xdpcz/PXq7fP5BvgoR7JCG7izZB5WCoo5jH5xODmeSZ5IQ9Rx9+hijUo1ehe4/fOTReHvgK4giNUSyYB6xGZyOAEOQI024O9+D6ZOtmd7alskeDQP5wdecDIyDqw4cLNXtEjDp/5gnkK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477488; c=relaxed/simple;
	bh=AFar811F9iCO3PW/bUYkCvTbMI/jIlhhcC3tuFxatKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwZM7HJffN8J4dwDRlDmmhY5mru5Fz8d4+41rXzELkJBFlLrF+9kyO5E7D72rsukmPjA7zyM58RFYSRp9033hb1beRit4sXngAbRPv6n1EYlremvnv9Ja1lWQrwixq3pmrcsgIqTVnM0Nt1dIRJbisP3p0yBxXxcsoDBnfxfPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAy3N3PX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q6w2mm3395077
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PP4ZLZZk5lXfWJld/o73iVfzszWgXXw0Xp/
	OfYD7kEE=; b=WAy3N3PXBNBKdNFk4Rxa1whB1VCIEWua4IvyKx9nEvM25T5ZsiX
	oj1jrHjHo7nUyHfJjToelvgr+qos2aVn8w7Xmhm1ioJc5vKJeU9HYs/nlIgIPRCC
	dnnCiTPVaqUmPJrk17Qe8GYvQr1CA8e4FowX22NPey9kbXbLqTR7aqpnLHdMstMS
	Jhh3V9y/xu9/N4Y+f3hxm2LeOlT9vpvWk6lm7qPUhryP6rBt4ncRmS7i9+4BzCEm
	gvzozPKCb1dwY3KXv4BPkTfx041cCsqiyKX3fnLl5t7tCS/y7USMW5qAAN6Eg3KV
	RGLmt0sauKWIO3zalEULyn/Pbe+/tkqTa3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nkaj124-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21394eeso1143162a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477484; x=1762082284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP4ZLZZk5lXfWJld/o73iVfzszWgXXw0Xp/OfYD7kEE=;
        b=qFiZxfI7oXsAGGT6PcwnyhM2fYPw6VtsJwoMFlAmgbBUdGev3PSqYL6UYFpRKWxAJi
         RNY2P0zWU4MQ3lABBKfkXZZHYp2+8Cu8j25vaWC8+Ng35Zey9rpqSPpgBovylyJi6X2n
         FV6R3hYe1KhSisZ/KlDrc236cC8mFdSlDmxCyqBjWr48r2KDpk2aEfeQiBvdN5p07tc3
         cVM09f6AJc0RUcKLNDtYa/qx/JvX7rkfd3ySwFMBIsIUan2T7v6h7XwKubE8qmPs6DdK
         1+t/ZpCY9/25bvzTYzZEd2QoxXNnYNsR/D7xOCvMGzCqANDjr2gt6/Vr4vXA2AxXiXqw
         XlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt/83hmlR9NJk9G9x7FFza0carfh19laOoLNT3khry3YhoYJYPBBdaABMaV3vOAo0zMIfJpkHvk5+ZYbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFt6mISiiMyPq2UNdbnIWBlWAXWyMXWvUJSSg4SsL1b1Mghrw
	xZvt8fHGXyV/1tNF5GoHjqvTc9jnCSCifPH/xjYjZUUBEbpfYsTZAdX/MrMjkIn916exwogwQFv
	nvZB062VWSVc19CfgZxZkZ6Ih2thLif1haJNSSm9D1ioy7U6xKemKG87mebYC/V38iA==
X-Gm-Gg: ASbGnctaZO3doRgn6YTLOg6pDX9FBS2D9UiVNELChfplRztgPNBoe1eA8mxjZG8JMvU
	mcF0zRgqEw4rObKNcoVH3hayuk4D49WG0bI0DwklswQd2qxFZWR3iPR+zP2HsmJibKKssOfDLWA
	3NumlUlhcqYcAr0E2B5Zfu65u1nqhxoZe9/GK/gU/VgGyl+drDtjD9i5D2wyzp1MX38s+25pLlK
	LHe1mU5Dc0c/EcvDlLR0lyIpK9KJ93hd4uy26BogeYh2LtE9vybDveG23tOYJFBkgOVphBxbRn9
	3kaSxz+OyQwp2ovYYPk1Q3Wjp/wTSQExwRyPJWqTpex7ErOIX2RyVCsxxr7xQe/JbGmakcvemNp
	rGTfDCPYq6axXDga5fyiFQaqU+eXF2A==
X-Received: by 2002:a17:90b:1b09:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-33dfabe6c8emr13999429a91.6.1761477484384;
        Sun, 26 Oct 2025 04:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSo0JH7nP8ynm5o4I7Lm3GCE8tlnKfzC4jpWmfkVLIzkCK8S3DvUDI2E8nIlJhjI/sdz/55Q==
X-Received: by 2002:a17:90b:1b09:b0:33d:55b1:e336 with SMTP id 98e67ed59e1d1-33dfabe6c8emr13999397a91.6.1761477483755;
        Sun, 26 Oct 2025 04:18:03 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:03 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V3 0/4] Add SD Card support for sm8750 SoC and boards
Date: Sun, 26 Oct 2025 16:47:42 +0530
Message-Id: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=68fe036d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8g3-L627ePlETrSfAJsA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 8fI7t-88hKNlc9eGSPsAlqpmg6jntc55
X-Proofpoint-GUID: 8fI7t-88hKNlc9eGSPsAlqpmg6jntc55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfXxKgWP7wUT8B3
 CWSNH3MO3ELdAR6icSNmhNkMTirHo4QHszb6kqKHsDEEOzgvFvhUVSK/1Lor5+L/fzpJAC2OmwR
 FTtv14qBhgzRO6SlPB2Y0cFCGqrFHvPoHquQATZjZIU2/CdOjr1+X/Gc+6eTmPUpBLusLwZtO0I
 7KkzKCjiHvEZdfLQA8A8170PuvuGMby/JOCAgNZNuhT619qkKd5FI5fyQznynxGhUXrdgLwxkIU
 Q8zA0B6d7lj+IAKUi29YgOjfd8ULKYInwzyjLhthX63kx8kYkWv8A+uo8rUlmrClyigmk+KnABW
 I4pDwH332fKZmOLN7rdFJYzR3kgyklIoeUhEr2CgAUFSUoRMhBsViPMEsaRdWbQ0aUhCi7ul3e5
 N/XumlBGjZGaeMsreZd2SQN0PhCiew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

- Changed from v2
    - As suggested by Abel Vesa move the GPIO configuration for SD card
      detection (specifically the pin settings for gpio55) from the
      SoC-level device tree (sm8750.dtsi) to the board-specific device
      tree files.

- Changed from v1
    - As suggested by Konrad Dybcio the patch into separate commits per
      board and did formatting improvements (e.g. aligning < symbols,
      placing each item on a new line).
    - Addressed Konrad Dybcio comment to use SVS_L1 for opp-202000000.

Sarthak Garg (4):
  dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
  arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 23 ++++++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 23 ++++++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 54 +++++++++++++++++++
 4 files changed, 101 insertions(+)

-- 
2.34.1


