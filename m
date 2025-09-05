Return-Path: <linux-kernel+bounces-803668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA97B46387
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059725A1DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AC277804;
	Fri,  5 Sep 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGZ/VsHA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AC22F77E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100239; cv=none; b=lnTWY4hfz7TrWwGP/Vd4SpP3NyNJR6jzDbETA81XDS86i8ToDMFdCN7a+EVg4W2cdr2pv7e5mQNfx0JV5mKMZiKu0XeSgec10FH6veYADCKKt/4bHL5K1le1tB/jCMJ/0Yy7RTBQ7NwSIoHEpbbiSLV5j2tPb2J9shpL2ejaXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100239; c=relaxed/simple;
	bh=Ys7I0Vup5e+goKhaFRUnMnqwTwTRcNpk8G0crlrK/6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ph8lzepngHLwjV8HAaBawsBQof1slu4sRgc6pjuvLSUY3M5uKpUxhxfORTm3szoQi+8EddskiMVVixwNbV111MeaL7caNa5foRcnZdxewNn9iH0bLRZo2k+uFc+vASQfNmU6Lv/5AOvJAullx3JihDSpC6ACSj8xucLgBAyRLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mGZ/VsHA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GC7J7024727
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 19:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rkxfFku32rNsgPlmlaOW3d
	U+2FHQgFK8a7/yM2c+LOY=; b=mGZ/VsHAAm8wnkDsGFQRWMKqaTWsfuNwrwqtwb
	khfZNHWYflRN5Roq+UxdEvA9lfTuEOJESKWrN/cNgX3FmnCfnVw3koG2RZY4mz3Y
	S6oK3vCYRyE/FXcwYk9P6H4CqwSnUnBhW3ShvPNg2peqimuaBo/TK8nJHhrYqD2M
	F9iilHkzVkBUofqbCCWEUWF7S8BLLCGj7X0zwoUpQumXyp16HTOtwl5SmJcaJh+Y
	NYhXGmsJlXlwDSVj4JAwqA/NdzywNUKw308S6uN7fZyfy6FSJ1OSA1L1zm0WdH8a
	cqFx4FFb2bnYQ3ykrZ/eVYY/ODhUIeCrwy1Bd/pg93NxfhWw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fv6a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:23:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24c9e2b6533so6939665ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100236; x=1757705036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkxfFku32rNsgPlmlaOW3dU+2FHQgFK8a7/yM2c+LOY=;
        b=wzRgmaOsvJnMKBGFaug3PLxCmHICNj982BVoCxLn1Vd37Q2LcjNRM6M+h/3i1kOmOf
         MRXt2WC+GTAFiBE/3JqHbIfIDxHtvoeJcFAOkt2Hf3rVIDck/sKsmY73Ynh8OQ3dNK0D
         ukgPdhPAurD1eQl4rePdiODaOsujGSEBrqvjQ7FNScWZm6VQiOx0KnlPS0okh24AkLLS
         RoFvNGtc8dAYvqO82rsubFY37ojX3FjN8Kg1hxhKJCQwKrW5/Wf7kpCKXjpK4J3XLxit
         hq7oalEQryLpB0G7ERl9vwoWn7TTKEYpB91dniXwmBK87hWWKtHlw4UrqQ7x+Z6lJ+So
         i46w==
X-Forwarded-Encrypted: i=1; AJvYcCXp2FbFMQWs1193OVNudKUo6MZ+mP4iS8hSIgsK+0y9pZ8QnduGMjznZqfsJhwtEXWBEWFKhjUDjLec6Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMVqb+lB07CgejoEZTtINwUuBF2GHk5WrZtx8t5IrDdgLD2lX
	EfEfJfgCzOrLQLROY31bLMlW2LGmQNhYmKTNy/C0ZDUjncLs86ze1dnorEw2YO9f+lzIxWED4c9
	yZnRvShjLQObzzLReEQ1GjOi3o5yrMZ5Foh93vpe/8KVKwFj+28OqIXdvcM8Gufhs6iE=
X-Gm-Gg: ASbGncsKgMAlxquhLk0E5T+SUplPiK7X7NhvYM+44ZA8PJ6UfsWhgrOOLSYSHNgbVmd
	8F3llgf8FZGkLj7ehXYkc4SpohHUa17lRZ2mVddxNfZa/jzg4CGCuQ+ILUqRrekbOUIbJmZ80Q8
	Wq6tt+lEw7XJlDIBDyU1bYxwqt4et7qw00IcNxgyGAtg8IHW+HjKrN/odGGVgvaboI2MbdGBRHo
	iiCCdPD2rKQDE+2VtG171oxQGHacL1FJqvJwARRQDLnSTJ1CakJbRSBnkb2Z9ebi5TBmUGe7ggs
	edY3gY0BY31A2IMaGLlAMqG3phoPpgT+OiUE6m1718hTviyPLo0lQuCkDPXcbn0DEw9brkQ=
X-Received: by 2002:a17:902:d487:b0:24c:cfcd:7356 with SMTP id d9443c01a7336-24ccfcd76demr52229735ad.0.1757100235726;
        Fri, 05 Sep 2025 12:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSve3MkXASk0rHIk8zSoxBNSXQLr2f6Tc6YJC3NXSYVl4cpZyjhD/y1aPYD+OSMduL45l4QA==
X-Received: by 2002:a17:902:d487:b0:24c:cfcd:7356 with SMTP id d9443c01a7336-24ccfcd76demr52229505ad.0.1757100235188;
        Fri, 05 Sep 2025 12:23:55 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc1a82a34sm52397055ad.151.2025.09.05.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:23:54 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: [PATCH v4 0/4] Introduce support for Monaco Evaluation Kit
Date: Sat,  6 Sep 2025 00:53:46 +0530
Message-Id: <20250905192350.1223812-1-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX0vShztwq32KZ
 iZxXsvwTDyNlCxkHqoXoEchkx05sXdaU7Hn5jGl6C3Vpium1D/qLcyvzQXSOnj7LLunSWlB251w
 5k2PDjLOmu3j1DJfqhwIMDFrTvK0a3gs6r+U6pBaLQRUQxLn+C6ufV9J+bAUV1LuBkFhP2efYvF
 WRDjYlsaCiqjmuD0bsm80PXuJuk0CUdJakcl12Wfiw+uBSwFHzdSVt5cDiNzUrF4lFbOPPOh5Cs
 9TjEFMuaJDBvu2t9t0FWGV8e0TT8V15ksd/tIE/r5EHIIOB6yz2mj3Xfh9UHQmIFWH+McTsSBwZ
 tpcxIAJXvZrfmauwnuXj34tFO+hasuhquY7xtUN9jEGlcSWsJZ7EiAv0Jf1xIFMFCj4Hz7UQbcC
 ZjxiZ9Zb
X-Proofpoint-ORIG-GUID: tXR7MwQ2oWa93QcPyjROKwGIZUGlbvvk
X-Proofpoint-GUID: tXR7MwQ2oWa93QcPyjROKwGIZUGlbvvk
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68bb38cc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1rJyDK7wihIfqwlA9s4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

Add support for Qualcomm's Monaco Evaluation Kit (EVK) without
safety monitoring feature of Safety Island(SAIL) subsystem.
This board is based on Qualcomm's QCS8300 SoC.

Monaco EVK board is a single board computer (SBC) that supports various
industrial applications, including factory automation, industrial
robots, drones, edge AI boxes, machine vision, autonomous mobile
robots (AMRs), and industrial gateways.

Dependency:
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.
---
Changelog:

v4:
 - Remove LPM mode support for all the regulators - will be selectively
   enabled later for the clients which support LPM mode voting [Bjorn].
 - Add the correct copyright [Bjorn].
 - Refine subject and commit text of Board DT change [Bjorn].
 - Use generic node names for GPIO expander [Krzysztof].
 - Drop firmware reference from commit description for iris video
   decoder change [Dmitry].
 - Update Board DT patch commit text to indicate USB OTG mode will
   be enabled for USB1 controller once the VBUS control based on ID pin
   is implemented in hd3ss3220.c driver - Similar to discussion for
   lemans-evk [5] [Dmitry].
 - Drop Signed-off and Co-developed-by Tag of co-authors instead mention
   the co-authors in the commit text.
 - Remove the redundant snps,ps-speed property from the ethernet node as
   the MAC is actually relying on PCS auto-negotiation to set its speed
   (via ethqos_configure_sgmii called as part of mac_link_up).
 - Add Audio change to support capture and playback on I2S.
 - v3-link: [4]

v3:
  - Include changelog in proper format and make it more verbose [Krzysztof].
  - Fix subject line of dt-bindings change [Krzysztof].
  - Move the H/W peripheral information added in cover letter to commit text
    of Board DT change [Krzysztof].
  - Include 'qcs8300-pmics.dtsi' in the Board DT [Dmitry].
  - Enable below peripherals as suggested by Dmitry and Konrad to include more
    peripherals in this series itself :
      - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
        for peripheral communication.
      - I2C based devices like GPIO I/O expander and EEPROM.
      - USB1 controller in device mode.
      - Re-enable Remoteproc subsystems ADSP, CDSP & GPDSP as fix [3] is
        merged.
      - Qca8081 2.5G Ethernet PHY.
      - Iris video decoder.
  - Update the Board DT change commit text to reflect the above
    newly added peripherals changes.
  - v2-link: [2]

v2:
  - Address Bjorn's comment to rename the board filename and
    compatible to monaco-evk.
  - Include the bindings for monaco-evk with the existing qcs8300-soc
    itself instead of adding a new SoC binding.
  - Drop remoteproc support as qcom remoteproc driver is currently
    broken in upstream [3]
  - v1-link: [1]

[1] https://lore.kernel.org/all/20250623130420.3981916-1-umang.chheda@oss.qualcomm.com/
[2] https://lore.kernel.org/all/b376d130-2816-42b1-a8c1-1962ee0c2cd7@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com/
[4] https://lore.kernel.org/all/20250826181506.3698370-1-umang.chheda@oss.qualcomm.com/
[5] https://lore.kernel.org/lkml/d6816cc6-c69e-4746-932e-8b030ca17245@oss.qualcomm.com/
---

Mohammad Rafi Shaik (2):
  arm64: dts: qcom: qcs8300: Add gpr node
  arm64: dts: qcom: monaco-evk: Add sound card

Umang Chheda (2):
  dt-bindings: arm: qcom: Add Monaco EVK support
  arm64: dts: qcom: qcs8300: Add Monaco EVK board

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/monaco-evk.dts       | 511 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs8300.dtsi         |  77 +++
 4 files changed, 590 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts

--
2.34.1


