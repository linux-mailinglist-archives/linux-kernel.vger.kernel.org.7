Return-Path: <linux-kernel+bounces-864338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E57BFA8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D0D3A554D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC92F8BF4;
	Wed, 22 Oct 2025 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmarEOxH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEC2F7AAF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118140; cv=none; b=Us6vw91LgN7HsY46LSo7S3Kftzl2VTE+WM93kmXYU0A50DH0oLOUHSJLVXXNc9MSgxqMyc6Z2WEzdQo7EeqxTamDH3AEuzrs/BWghreWr9J+cetKjBzZ6qrr/pkdVFwCZB3y7qYEg7s/gUWe8kD3xBEeUpsyoBCm/Av9s1lRNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118140; c=relaxed/simple;
	bh=iE+wj1nJKoqGaptWFJM86DR2OUp09Tooy3IwgRAiN2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DG6Za+OazYwZM178bCELUUnOxJKeIEwYiDfodb7UhUXZGWqtokGNr8J6kt31XpU9FaeNVOlZnw+r44T6QgfQ/ReIehdkuejQA3YiAGZMtksliS0QPhl+L40t8vkq6IeeLNAzULoFDtCmfq75X8s2HAw3+aw/+KZuprLsMikXzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmarEOxH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LNGpTO004936
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DGlg8C4BGbAwf7Yj52Ofip
	eoKnBYKkeSW3ovRD14QZM=; b=HmarEOxHKbvjRLhCrq++6IVs3+Bm3m1/H0UoQ0
	MCGM4GmmIwkZoMwU+/XMSETUGWXWV2A9g/Gecqe/hEixJ6DI1+6NLTQkFArTTa+4
	rWt/P9hR4Yz9F1WnAwan1JxBWFlcAwqmtH+wlaj1LRo8B2xd+M/dDz41Gq6J2sOK
	xgexvmtP5Py9c72e5N/mz3n2oAqHWmCT+xJhsHXDl+Lx1WIIKnil4peZ5Ljrb6lV
	jYEswz500rOtcY2SHZ+eYh2sYm24Jyd0z4HYVkqMjnWgm6gEBeUv0kyu2hZEkqzn
	2k1EuOm30vVp7fv1yTuKCKRVChe1theUfRBONB08dlY9PVKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkps9730-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1888068a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118137; x=1761722937;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGlg8C4BGbAwf7Yj52OfipeoKnBYKkeSW3ovRD14QZM=;
        b=nxTHyU45/XTaTrM2AZrezFaVk/fE1L62+NrnYCtDLhxsdr67VEl5gg1wxwM5bHLRWW
         AMfx1LIDCDWoEAAOVRH1sAaIGwZyHDwzq1XzsulnlMkS9lZ1AtXW52MM8TIZRiHj+lNO
         X0prYLGX/sCCKWyeTXuh5qtikxSgIavkTWKRkyiweBsekAVmp74XhDYbfK546izu8d44
         jSPven/oJr1i+hrRtAitgUo5W2Ra6W36e8F8QDeu3BGkicJGWUkCjP0of7kUwEed4LvE
         XiFHtObwCLAoDZ7KDLXid0MGnE1y4u0n8UCEZIyYMGlEn6ynDTfr0zd66ywxjhHn+vqe
         tYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtwkyYjJeuKeuK0O+pXeI806liWl+/B+18ucwXyaAaQCd8DBMpz2j45/eXF4XmYYNwGX1MzzedJoD65qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm23h0MDWO6DLIPerxBunBtGBgxD9wqkKQ23KiYcaeWGfbYKHl
	osdwdFzdpuEYo/OCOaF6YsucLU/d2VaVLVHxC0zfKSodv3Min3Lsn/4Gp9sqH1BFZ288W5/47tV
	DywqhKvfJpAj+ZoskKVG81ppPn+BRA6uQC7QE5Bd8Murpuw/b7zCVyDMsRvz4Lco9npQ=
X-Gm-Gg: ASbGncu5w98pclYiKCY01CCQijjy2fFDw+2c1ttaafveTRSpf25TM6xuq+YCt5Z0JqN
	q2NVKeKopE4OhewyuKb6Awc9TIsyRcTaZkVj+DOsTIHEAsolFoeWmRnY9lb/c0Pn4Ax+wFhhVeQ
	OjEFgPeHmJq2bOtqcNSvaR5M62Ccqf9gl8KYr2DwLEcbsMvmVANvkNJDHDEaLyB1wKeTKJ7V1b4
	GC1Bi45GtqPzsSDMmjnr+lbgztk+ScLz6UmgYiokVkhwodpS7NSz+wk+3SKwJXxDFXgp0TMfr8e
	rzGJRNMA7EjYJWuINU/Ga36/xsXZ3lOBlYjcMP+xwx5lcGwxJVv9hak/iywASfuUc04t+b+OITg
	P9kRC8txH7eV2R/jbB7tztGv3p5rvqpDBsz1PO40c9RjBJ+bzpw==
X-Received: by 2002:a17:90b:44:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-33bcf8fd82dmr23899341a91.27.1761118136860;
        Wed, 22 Oct 2025 00:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN227kUpyZjkmpdeHrnrNo9N+lV5dc2dEsaPN37OJQMnUXIZ2XEbYkNywC0naA6sW+ZJ/KPA==
X-Received: by 2002:a17:90b:44:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-33bcf8fd82dmr23899296a91.27.1761118136310;
        Wed, 22 Oct 2025 00:28:56 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4498d0sm1687342a91.11.2025.10.22.00.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:28:55 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v2 0/4] dt-bindings: soc: qcom: Add soc related bindings
 for Kaanapali and Glymur
Date: Wed, 22 Oct 2025 00:28:40 -0700
Message-Id: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKiH+GgC/2WNQQ6CMBBFr0K6tqQdQawr72FYtKXARGmxo0RDu
 LstWzeTvOTPeysjF9ERuxQri25BwuATwKFgdtR+cBy7xAwE1FIA8LufOQXLDfoO/cCNUVKK0xm
 aGlj6mqPr8bMbb21io8lxE7W3Y/ZkR56NSK8Qv3t3kXm8J4SC6i+xSC64OmrRgJNN1atrICqfb
 /2wYZrKdFi7bdsPk+H7J8wAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761118135; l=1309;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=iE+wj1nJKoqGaptWFJM86DR2OUp09Tooy3IwgRAiN2A=;
 b=isjUOSIQMyjtDRZQ1G4Kw/FYLSRqchF3+CWscRwYErlkL8j5dLT3Rw0aVJSrhO5/qP3SBeF3H
 MjjO0P64WxXCivn3dDKg4EiEv7EYPvvs/NLBmquf1uYbIzOJeekZLm/
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX8Gv4sBYaYXVN
 W+4PAGYwfV6K95yKXKy5w52bzpKRwZWH8qWvdtDySMRgqBNRDVuBLekoGAXyPBpQ0XLDQMLtAyC
 G99ObUm0dxjNHzMJI/GtR/FWio29zvgV0AZ2uuJC0EtRuWGTBjT4JVU4ed99M/sRdV6AKyVMTI4
 HjbtpULU7/JYhbIJAmRjAXwnX9c0lzBXPcwLUJ2ZPyLr/1ck18/R0PtsPizQrC94oEZ03tCPGpy
 yM4mc9GsWORpdz95qzVgAic3E2uPJn9U2hKVwEPogcAFMhYKtpmEVCRBOZOdoBanObuvp1Bw/oI
 gzdbPcwNRWxc+sFqdj5rbXkFr8elV394NYUKhBHapDC/4QRxdZ5rDmWTlN7VyyGhp4pXKgD2AzS
 HVR3MO/G7ZP01ANuj6JlK3s3nudh2A==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f887b9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x1lwz7GVZOURCrER9fYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hWYnarbcbGzzav1lVfgMqD9KeOEpJPaL
X-Proofpoint-ORIG-GUID: hWYnarbcbGzzav1lVfgMqD9KeOEpJPaL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

Add soc related bindings for Kaanapali Platform including aoss_qmp,
imem and scm. And add aoss_qmp for Glymur.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- Fix capital letter in subject and simplify commit message - Eugen Hristev
- pick aoss_qmp change from https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m4bbee2db112a471cdca7aa63477b7147691e6852 and rebase
- Link to v1: https://lore.kernel.org/r/20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com

---
Jingyi Wang (3):
      dt-bindings: soc: qcom: Add qcom,kaanapali-imem compatible
      dt-bindings: soc: qcom,aoss-qmp: Document the Kaanapali AOSS channel
      dt-bindings: firmware: qcom,scm: Document SCM on Kaanapali SOC

Sibi Sankar (1):
      dt-bindings: soc: qcom,aoss-qmp: Document the Glymur AOSS side channel

 Documentation/devicetree/bindings/firmware/qcom,scm.yaml      | 2 ++
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 2 ++
 Documentation/devicetree/bindings/sram/qcom,imem.yaml         | 1 +
 3 files changed, 5 insertions(+)
---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251022-knp-soc-binding-bb9110682752

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


