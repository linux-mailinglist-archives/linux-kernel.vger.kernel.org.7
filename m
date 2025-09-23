Return-Path: <linux-kernel+bounces-828811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62234B958B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D443B705B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE1321262;
	Tue, 23 Sep 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/qp0n9N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB9274B55
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625336; cv=none; b=VHS3T31Ats+0zAcAMEx0pRHKp/AkAlIUwmKHBCKoFF8xsq7DTptFF5EqFNjtAJU2DZGQOLGlwiW0XYdMZTkQBmGSUkDpYlspMG2KOJSBDTjTznM6X5vCE1y03gUj9nx6wQ+2W+/MX/NH7sn68KgoeC1FwrHpl/pnMhrcaMRxDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625336; c=relaxed/simple;
	bh=5hEBAumSRnPCha/Ny/m++/pZyTtvzKOFLtKUlv8WYhU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AKmosG6DNQdU3OaRQj9irhrtMBULwiTh6jEvvnN8Rn3AZy6hnRLH2iGka3PlGcpZX9gIJKX4BthrcaWpdC8DSkaDWHHb2b7CRIR2HLWtjwhcoXL481L6iDUDm6K1YsPfZDZ8hpJoRPP/M0CwECWNdhZOWflficEBPxNdsHD7ID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/qp0n9N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HFaV001998
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GCCtjueZgBHRf2lKO9QvuT
	Vc8R/RhxwXGzaoHvYzDdU=; b=B/qp0n9N78pOX/CQWvRk3WSTHYwwQLN2W+XFVh
	dnlApt8tgnof2c1eP4noj6GmRQTC9OiCT+kVI8tFIics3zaFRGJd0hfGLVrYCODg
	Ozj/t4mYn/VJLvmNWrC/sBKatH2ldqUpwCTo2by1kF8+hiBpr7I1Dk2d3Kpe0FO3
	YhqJIK3ITyzYRS/pj/D/Vt8boUjMM1dFBJGOZfLat5SL6qxCLmUHdPuBCjpQbXOc
	ipPmKAz1IaQ0yPjdwy/hK/QnXZzygWswqqRm/QvhTsaH4ARxuRVZ17vqjpabPgkH
	QbrLKUQlIndUgXrsN9laM1vXcNowDdP8ZaGrfALkZDMPWyKg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fg5dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78efb3e2738so81741976d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625331; x=1759230131;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCCtjueZgBHRf2lKO9QvuTVc8R/RhxwXGzaoHvYzDdU=;
        b=prf+Bxg8m1QQYeaoU/TxGiM5Eyq/Ty9MYhp3712P3A5vOcoLaVyiEf4gv15vae1wns
         xZHUvN10EDGhJxIoPbTV6RDZ6LTEEcDBi33NR/kZjNuH2Zayj34y4i+EqOOkCyTCVOvX
         S1ok9UVuXNQkuMQg1NNNGsfa99eayc8wfW7GZvDHvi42eco9WXAd3GvEMmTG9ZEF/XXP
         JVrk5jGSrnwbRySgdDkbbUymHRFZTullT83czn7epc+AI1IWaOs1fT8KlRWwJX48B4mI
         u15vx461aaeH/bcCxhu29Y9MJ3gPWFgTAOFZ4MsS8rOiKZjBtgWYP92GNY7uwR8KX3EA
         2ilQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnyHUVYssEqbCbhYAuXJO//FAFENGb2wjyaH8Jsm2R+SOQTvroLGr4NT4vZIlXpjrnOafTSWXyrwb3So=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrjVOA0shNEeqmJp03lmCYZNYx2ttHhOClAOhNF6A66VVslJv
	xvgb2kVs+G02rD1z3Lkjfb0KahqOvu3gPhCkm9rFe50h6H6+2ZNXlxzik4fJrw+wIapa2vqpMhq
	dYUD2fE/cCXCD1bKNcIVxCrowsuQyXIAp9/BUM7wkiz0JOgZ3Eb3b2OayJifEuGguXXM=
X-Gm-Gg: ASbGncsZwNHPLDSD5WcaP0+wFg43SHnxOd79fh3NPiJgVswj5XTNhTM7BTo9h/fJv+O
	GtzJWN68Qdk2lCp+GDPvwaN9E0clgPqRJ7P1zytZvTlUutTjnGFx5vqN2B/iKhwIk3H0i2XfiJt
	w59jLPc4ptswEXiGw6UHGqB72sK0JfTKMjVosV75Lm/xHZ8xXmt7IC25vhqgADq5shhCgcY+VkM
	6etqEub2ykadP7OOlaHnno+DkGngL1yqZxBN94rLlFZBnjr4cNmjPteDV6kRIHj4PWnJnqOoByu
	EVMqDAW5jXKkEwCYjBq3PyelRZpMQd0JLgL66daGY9LMNbEREANPvwnhivaWgYrz1alIa0ajY2z
	Q6vBaWspwOuySHLYKm9O4WTvdaSDoZZTqcYN0mExzmRiMFaSVO0u5
X-Received: by 2002:a05:6214:20ef:b0:70d:a91d:2ec4 with SMTP id 6a1803df08f44-7e716d467e7mr22730256d6.49.1758625330886;
        Tue, 23 Sep 2025 04:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsFNNHaOMJ0Dvt+QYoMrgLHz7i5vsL16oR9PxtXAbrChfsujy9S7H0z5WkxgV9KWb7cMrvWg==
X-Received: by 2002:a05:6214:20ef:b0:70d:a91d:2ec4 with SMTP id 6a1803df08f44-7e716d467e7mr22729526d6.49.1758625330338;
        Tue, 23 Sep 2025 04:02:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4537csm4075975e87.27.2025.09.23.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:02:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for sm6150,
 x1e80100 and qcs8300
Date: Tue, 23 Sep 2025 14:01:53 +0300
Message-Id: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACF+0mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNj3aLUvMTcVN2UkmJd0xRzkxQzQ2OjNBMDJaCGgqLUtMwKsGHRsbW
 1AEOh8EFcAAAA
X-Change-ID: 20250923-rename-dts-5d74d6132f40
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3505;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5hEBAumSRnPCha/Ny/m++/pZyTtvzKOFLtKUlv8WYhU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo0n4wYArVdXVon0JH98ViR+JTPByVSEXNFQb1r
 zraqatvJkCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNJ+MAAKCRCLPIo+Aiko
 1eXpCACIFEaqSDVyKtaSdzlP/SEPJgi3gtn84vuZrJNohZvAjLzQ+nCKVBeLnO629smbi0JlW8I
 uMuC/ArjQPbvOTvG1EBcveLto9p7i34o6sWRIfK6zsKIGsWqtmFdq0yvmhv9kq8lPWOZcy8ik5/
 gac/tZNqT2nbMe1eupMF5TMSmGkoHmrH+nq85lMzEfNjKJCJ9L5ZcbNfDChDtCj7fNVDrY6sQpS
 puZZKpSfM3pJtmnFO831NzGUsbHg4ukGQV0ipe31DH3PX7mB3dyDLN5UlZ4nBdYYy4Tt4BDZsLF
 /I5XhdAcJJSZnkNlPV5Tn16k9zlmIKCjFMfNluVVM6vuAd21
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: MyiehPOGjMl2G2JE5wlJuyrE-jncRVw_
X-Proofpoint-GUID: MyiehPOGjMl2G2JE5wlJuyrE-jncRVw_
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d27e34 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CLCcR14eWKlEiziUIbcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX0znhFyZyWvL3
 H4OBGB7igGX/FyhbXG2Y+USAW8UItgy7S+ncJi4IESrLKWdrw/AnMPQKQKGi+sbCV9cW6n2ziUM
 QhKWyMYV7oyiyyMlrserNnoOUbrT2HOvp2b9M1/lFUs7L8SSI+Wzn4FDOi9kD5OvG+i/UdhyykP
 tzJYyTpZzclsXR6Jkj+2+QhKXH6n1RyeEPWZbnDbnxDhrPWsxcf6VWnpYVqhu6OP2fY5a25uF+a
 1FRYGQNiJCksCcRuI+1w6/YQzPszBYaVxQ1PUdOZbIkQ9JtMvFjN+kP5Dsnq0KUrTr+1mejkzqr
 nMk3LBSOu+DFx6Pd+ycgqoJTWBI4MH5BxjRbZMsW2M3C0+R97w5xVj0iyhxWI98LyHYW1FPUeDv
 o/7jd7Zz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Bjorn said to me that he disliked the conseqeuences of renaming
qcs615.dtsi to sm6150.dtsi. Let's increase entropy even more and rename
even more base DTSI files.

Leaving jokes aside. It's not uncommon to see different names for the
same SoC (or almost same SoC, with no visible differences from the Linux
side). The platform now known as 'lemans' is a good example, because it
had been using SA8775P, QCS9100 and QCS9075 in different contexts for
slightly different modifications. QCS8300 / QCS8275 is another example.
All such names cause a lot of confusion when somebody tries to follow
the actual SoC used by the platform.

For 'lemans' after a lot of trial, error, Naks and reviews we've settled
upon having 'lemans.dtsi', the core DT file for the platform and then
naming individual DT files following the marketing name for the platform
or for the SoC.

Apply the same approach to several other platforms, renaming the base
DTSI and keeping the DT names as is.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      arm64: dts: qcom: rename qcs8300 to monaco
      arm64: dts: qcom: rename x1e80100 to hamoa
      arm64: dts: qcom: rename sm6150 to talos

 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                        | 4 ++--
 arch/arm64/boot/dts/qcom/{x1e80100-pmics.dtsi => hamoa-pmics.dtsi} | 0
 arch/arm64/boot/dts/qcom/{x1e80100.dtsi => hamoa.dtsi}             | 0
 arch/arm64/boot/dts/qcom/monaco-evk.dts                            | 4 ++--
 arch/arm64/boot/dts/qcom/{qcs8300-pmics.dtsi => monaco-pmics.dtsi} | 0
 arch/arm64/boot/dts/qcom/{qcs8300.dtsi => monaco.dtsi}             | 0
 arch/arm64/boot/dts/qcom/qcs615-ride.dts                           | 2 +-
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts                          | 4 ++--
 arch/arm64/boot/dts/qcom/{sm6150.dtsi => talos.dtsi}               | 0
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                               | 2 +-
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                        | 2 +-
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                       | 4 ++--
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi        | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts             | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts           | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts           | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi           | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          | 4 ++--
 arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts              | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts          | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100.dtsi                             | 4 ++--
 27 files changed, 34 insertions(+), 34 deletions(-)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20250923-rename-dts-5d74d6132f40

Best regards,
-- 
With best wishes
Dmitry


