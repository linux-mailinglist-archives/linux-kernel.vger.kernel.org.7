Return-Path: <linux-kernel+bounces-731206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BFB050E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808223A7544
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9A2D375C;
	Tue, 15 Jul 2025 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBssq24u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C635975
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557270; cv=none; b=qXj9mhvWQ9bnGw8hl4FdgxauB4+78GHI7/SoZdMowD7d09LtF8vlujKFsZAyvSmylFiPEdN6X+2SNKKc/dUaDJsP0jDh/oS792dBkmgph3QVxULpL3zvvvcF6APWulcYBKVUOgOOknS1xYSilXJwDbdLVS8nsrqNrNm/xl79G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557270; c=relaxed/simple;
	bh=OdZcOnWlDlS0Dtxl7r8WgOSua/jQ0jnj/DPRfgyS/xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OnEYkmbo4KW7Ps/Uzo96Mjy9C89S4OZZYgaR2H/4gTExP/oeVnyKT4emrAh/nLWaOdG0plrKaCPehnyOMzgaueKyxfMnvS/Q2tJsmqfwXaRvkJXiaUeg6OoWtxZWPVK0lF/763Z1b07AIMrnjGZ/GWBo0+y5vmEE/8Rq0a24Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBssq24u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRcVY029642
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=c3c4FOJ9UeCHswM4DxqKozbwHlRtODnFqma
	Qc+sA9Zo=; b=BBssq24uFDgbMHZedYYBTZ3qlI+JCMPmDPNFF8rMGmmnySjxwI7
	O36oZwK2tT1WE4N802LuA3vBzY0RaYEuCPbxaBpFaglN9c3DFeyuYf1E7BGPGwHi
	mCL3RIhTLMNWdgifLExoxBRXZH0F1izwnxfdijQ7GJyUcYQnErm+YYOjnznu+W4P
	751Gs7RQVb5t/nynPMgaliaoA73K1s4jghafciK6feBOUYQK0aiwNVGlFdtsife6
	/8lisaIn8UBsGr+pXBDf2csqC4sa/cndvwjcT15YQEJz7xpy27KO/6SmXhiDODG7
	dxKa8Nl/bmJd9gMGQ3q2oisTlBNMVIOYz2g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dq1p7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so4152886a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752557267; x=1753162067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3c4FOJ9UeCHswM4DxqKozbwHlRtODnFqmaQc+sA9Zo=;
        b=SN6dF0zdEgU4vJcRdbpZOsNiuZB5ex+wutvN06keofvktkLv6AHb/AeD6lXMecedvb
         sPR+ix2MfCgi0sCh6JMTG+cJb+LQqxIgXx9152XSaW4Bl1VbBXJLnQCt9W3sev4EUg1F
         8DaRNzB8MsZdZV/9IQlAg6aezVwWTkaHNVUfhET3DpLtNbuB3NaSCNx0sTeDilawNudb
         xrS3OcLyfJUtB+qe9r/tnqAHTCpLviyXwjFZ/roPA6tcpg+DheHr5U1MWz+n+kzG/Wp4
         8YGmNozzOdcF9bvulYkJEDNtoUr7A3/R9CvtWu9pcsbUtixIktcX+XojNvlLxj6V03q7
         ZXag==
X-Gm-Message-State: AOJu0YzG5bf8iOnvBqNVSNYaBxXem+JzCeNazr3WZ9/KSv9QiitTvdvD
	W6Fth3CY8jvVBlohCmszzrxijYueTUf/Ps/sYPPZZTHCanAasGFPMMNL6MnFxuYO3vyvaAE8HlW
	bsPHh8Ga66MyRTyvf9cPubH92PskW3pl402kZICjKQTW6Jo+uqnAXCOWkI2q49Xd8Uw8=
X-Gm-Gg: ASbGnct4Y51ehPnf5hfcTrt42ULZl8cjiDgtt0IqjiCIg4aD0J7LlCsiZikFHsK94XM
	UUow/rAmLsCvVJPkCz3ErukEaafJohRZEEtqtgwi/8DEi1cFTJv77RuH2LD1o2DlUaV/QQixmQg
	L7R4wMh0jeFVGsgKrDoejpCRBUkZ+xJrEoOaBcax3B1SEwtD+ywsOaH6pKTNLvKEoAxh+XQN0UT
	MH+X9YP2lOiEt4QSXxwQNPry9mlxh3kOd+HIFrPApXVV7/46lHto8lYUOD4u9NGlTkSwD7Cbulk
	yhwES75aMS+gXME5P6Rr3LZqBOtWmyWMzY2AmuDhJoPtQBpV95fd52CMuCnLXYRkcg5Lr7Ca3j6
	ARQ==
X-Received: by 2002:a05:6a21:7605:b0:232:1d30:cd90 with SMTP id adf61e73a8af0-2321d312340mr12459679637.5.1752557267060;
        Mon, 14 Jul 2025 22:27:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBixWemli7vwhqiHf4hBXxvnp+xBG8sPeb2OboZSZ9D/ipl8EcTiq0MJAoOKcPp5S+rS6rVA==
X-Received: by 2002:a05:6a21:7605:b0:232:1d30:cd90 with SMTP id adf61e73a8af0-2321d312340mr12459662637.5.1752557266629;
        Mon, 14 Jul 2025 22:27:46 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f24dsm11071535b3a.156.2025.07.14.22.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 22:27:46 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Flattening USB controller on SM8450
Date: Tue, 15 Jul 2025 10:57:37 +0530
Message-Id: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA0NyBTYWx0ZWRfX96m3owhhGZYg
 O2gEAWGYP8alPvUQ++KgVtDEeYHlorljZcPB0YTcAns8pZZWYqkIwVoTRLjS0oF3RGw1OOGLRt9
 WsSX+yYvB4VlbXelZOsYO1ktXo726UfCP3E8tuwGi58ylOuFOQ5D1r5DMy+mm4WPITBMOAyQT2v
 xdaZfTHMeMs/h7PoIbUDT2OyQQx0OzLT6CwCXIwZVUQdzeTULmlwcAj2XR0ILsCQGGzy0xrwzNx
 h/qc/ySAli+QyobJHQTVMfCtQcR1JqZ9JE+PxzszEeM0zrlsdgLrOYVnqoxy4+0HI7ZpxztmnMI
 W2Uq7fXIcYznzfuLQa0WqGgeeqZ/NshRwd6Ab7F4C8UL6GSlwiwOJvZlhhTR7b5T4daUz20n9n9
 OylQ5rspc4H8pXbZIEGJHxpkjmPfHE2yKHOqH3aHbcXgSXWkGjzqeo7UFZXZPukFaVd4czr3
X-Proofpoint-ORIG-GUID: OydBIi87XZ4eJPryXueFDDNBqTO0Znue
X-Proofpoint-GUID: OydBIi87XZ4eJPryXueFDDNBqTO0Znue
X-Authority-Analysis: v=2.4 cv=MpZS63ae c=1 sm=1 tr=0 ts=6875e6d4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=UcbzNMOkSj1vwIQaWDsA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=747 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150047

Flatten USB Controller node on SM8450 QRD to move away from legacy USB
Qualcomm glue driver and make use of new one.

Tested the series on top of a QRD. As per Neil's comments, made changes
for HDK as well. Gave a compile test for the sony-xperia-nagara changes.

Changes in v4:
Moved pmic glink node above vph pwr node.
Modified reg offset as per comments received from Konrad.

Changes in v3:
As per comments received:
a) Flattened all platforms.
b) Addressed Dmitry's comments - moving properties from QRD to base DT.

Changes in v2:
Rebase from RFC.

Link to v3:
https://lore.kernel.org/all/20250714045310.2092385-1-krishna.kurapati@oss.qualcomm.com/

Link to v2:
https://lore.kernel.org/all/20250610091805.2997546-1-krishna.kurapati@oss.qualcomm.com/

Link to RFC:
https://lore.kernel.org/all/20231017131851.8299-5-quic_kriskura@quicinc.com/
https://lore.kernel.org/all/20231017131851.8299-6-quic_kriskura@quicinc.com/

Krishna Kurapati (2):
  arm64: dts: qcom: sm8450-qrd: add pmic glink node
  arm64: dts: qcom: sm8450: Flatten usb controller node

 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  5 --
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts       | 51 ++++++++++++++++-
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  5 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 57 +++++++++----------
 4 files changed, 76 insertions(+), 42 deletions(-)

-- 
2.34.1


