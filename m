Return-Path: <linux-kernel+bounces-813384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3041B54462
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D74A48290C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD952D3A88;
	Fri, 12 Sep 2025 08:04:02 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164F2D3EDA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664242; cv=none; b=ICfaq9wLUkCYw3xraiKHig7MRqQyXbqRcdnFg6czfEseITZGt9uBY876/quqwWRN0bS6MJDkYVXV9wQvOuUNF2aa0lNXQQ1Nx0BUefuOv/H9A+U9RRXbhguC/wuhO6cywVvjeaI5TrREtOeb+b2epGgXDa9IrmlQSIX4o9t/RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664242; c=relaxed/simple;
	bh=gKHmOFdjteVQekqifxHYJRIaWWSXQL0vXGjMWK55q9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SMGY43HRrs3Atp644ian9R761E1VVUa1UrW8PPVBM1dLGQ4hfWAKlCPUqNoGLD93xX1o96OstKLAQ+IJXAKGDY/kK2AePdBrsmkpEasPwBrLPMgXW4BDBrSf16b6ZUuax/yhzL4cwQGrKMsCjO3ThKS8vW6tQoOEeYbEXOhJ6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757664229tfcf1c9f8
X-QQ-Originating-IP: MOVI41uRyW5p5cEv7SezyJeQOa4kceDau5hySL1MHYQ=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Sep 2025 16:03:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9888739823542151369
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH RFC 0/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
Date: Fri, 12 Sep 2025 16:03:28 +0800
Message-Id: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDTw2gC/23Q30rDMBQG8FcpuTYl/9MOkYHgA3grQ05zTraga
 7emm5OxdzfdVBC8Cl/C9zucnFmmMVFmi+rMRjqmnIa+BHlXsbCBfk08YclMCWVFKxUfAU/AcYT
 10PO9A06EAQmiJudYqe1Giul0JV/Y89MjW90uR9ofCj99v2wpZ7jyi+r+pgslnWmFqMvZWC55K
 YTXET/SkTAt55T6UIdh+zAP+keQUhitrKu1VVpYX4xjeqO+RsCyTfqE5ZBzvT/Ae1G2v9QOprC
 5QqADWOygQYrWuzbGznStxahapxGcAK9dbN3flgkiUoPOe/QaIMrOdo1RJLxSxmFjvGpRBjO3O
 sjE5+lpWlQ9nSb+87dsdbl8AWIuIX2RAQAA
X-Change-ID: 20250912-radxa-dragon-q6a-eedcdeaf3e66
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757664226; l=3260;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=gKHmOFdjteVQekqifxHYJRIaWWSXQL0vXGjMWK55q9w=;
 b=CvTQMWVHz7kIwgpbp6habsPrzjCjPBZUDfuKuoNsSVkv8TYXKlPNmdVEKDkxiQDqhVbT5mE1Y
 VsGkzNUvbqIDxDfXSMZ9VCzn1x46/SoMQYrdH4B+zuZ3v07e25zeHA/
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzSDQCFWCzVTs/ABCc051YB3b3bOC38ilkMmVVvfVlEE6Nx9a/E5C6J2
	EmPJ0OoSGsZ12/QJiOnMNPh7nCb/mVg1xgY4pvpq8K2nz47MhNfKUyUqHTVIrpWV/e+AMIR
	LjjdmwtZER4L2scVsHFLPb8CnfO0QEFeJIWKmI0Kload7I/oSe6t+TenzKVOm/lL9CZf4EE
	TkU51knKgnYEPitCwLee0t1z6jPK49sLlQjwYhPRRZVRCgB1YdlR7tPG1OAtNItUTJofLAe
	yuZSOdcY4dthyPOEzEtXn/ZuCdqjCr23wiu8NCjEvUBpZiDd5HfWufqIiFxWxXJZnHOEFqU
	VYA3TjEYILK3kS/aD0Vt2+FXwD0JjG2wCYBhD3m+9bUFg3gr/rwdnry09u9EQ6ynqXiVkI4
	DH1+rOaHIVxo9FWiwozTmhw6kpL5PUPF8vTcB0uBLZqw/L1B4Hya9g91HX00lG9FY/5M0jY
	vP4EDE7PV6etAvPTtecXR3DwsOZ3V15OuLimQXJJs4tK77+ceg/+ZJIKgC+r0KfaHya+L+D
	pQClFMpkm2eih+2r8A00GhWadREPy0MBcj+n2dtmshpxjYsfRy4xrPl2XqL/mqhyP762xAa
	sPWvYa42nIDSggwti4cQk5g/WsExVYz3Mh3T9IDGp+TLxNoXHThA+0c3NUdbwYn33lHcc7g
	Jk80SSADgW9IpJ+StzI4wyCUn6IEb6bcWB50wYtyxLe0XkEfeButPkDGVm7DFqIDBfIa3Xx
	mhg4HBnIEZ/L2PIxcX+WKa+IsEhuIq0Pc0yE4EavMPN9faV1flp17E9kCSiYFDjOouiShlq
	MryICYIyWOvZ7CGO0hXbp23nGA2BTW+w/5IfIDaRlwBedsdYQtqRpsqWQZuIW0uVyhckncw
	10UDb9at4AbP2if42mfycWuKX8Wp3Mhry2VQXBb83ZoZJ3NQL0g/Zh7LgQgVIjbiBR1CnJh
	R3YfchVy1z80XK1loZk8nmlrzjXoW2C1jlJLk2mKm6tKP4x/n65ft1wLLXDp4oWmd/CeICV
	Me9hw2qVWg7PLTtBDq
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Radxa Dragon Q6A (https://docs.radxa.com/en/dragon/q6a) is a single board
computer, based on the Qualcomm QCS6490 platform.

The board ships with a modified version of the Qualcomm Linux boot
firmware, which is stored on the onboard SPI NOR flash. This allows
booting standard EFI-based bootloaders from SD/eMMC/USB/UFS/NVMe. It
supports replaceable UFS 3.1/eMMC modules for easy user upgrades.

The board schematic is available at [1].

Features enabled and working:

- USB-A 3.0 port (depends on [2])
- Three USB-A 2.0 ports
- RTL8111K Ethernet connected to PCIe0
- UFS 3.1 module (depends on [3])
- eMMC module
- SD card
- M.2 M-Key 2230 PCIe 3.0 x2
- HDMI 2.0 port including audio (depends on [2])
- Configurable I2C/SPI/UART from 40-Pin GPIO (depends on [4])
- Headphone jack
- Onboard thermal sensors
- QSPI controller for updating boot firmware
- ADSP remoteproc (Type-C and charging features disabled in firmware)
- CDSP remoteproc (for AI applications using QNN)
- Venus video encode and decode accelerator

Features available with additional DT overlays:
- CSI cameras
- DSI display

ALSA UCM and Audioreach topology patches are available at [5] and [6].

This series is posted as an RFC because it depends on several other patch series.

[1]: https://docs.radxa.com/en/dragon/q6a/download
[2]: https://lore.kernel.org/all/20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org/
[3]: https://lore.kernel.org/all/20250902164900.21685-1-quic_rdwivedi@quicinc.com/
[4]: https://lore.kernel.org/all/20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com/
[5]: https://github.com/alsa-project/alsa-ucm-conf/pull/601
[6]: https://github.com/linux-msm/audioreach-topology/pull/24

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Xilin Wu (2):
      dt-bindings: arm: qcom: Add Radxa Dragon Q6A
      arm64: dts: qcom: qcs6490: Introduce Radxa Dragon Q6A

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 1208 ++++++++++++++++++++
 3 files changed, 1210 insertions(+)
---
base-commit: 51095600e8c19d53729a7fbd273abc4435a25e9b
change-id: 20250912-radxa-dragon-q6a-eedcdeaf3e66
prerequisite-message-id: <20250902164900.21685-1-quic_rdwivedi@quicinc.com>
prerequisite-patch-id: 257564b609217fda19c9f3424fcd9f6e2ce3ef3c
prerequisite-patch-id: a8f21781f3bff140260100b74041752000c06000
prerequisite-patch-id: b46127e2433ede17cc5e1a012f58041c6ef97b13
prerequisite-patch-id: e8978c5a30373c3ff312b2c8720f586c389f18f8
prerequisite-message-id: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
prerequisite-patch-id: c7a057030b78afbbb231280de3765294c006c6f8
prerequisite-patch-id: 56011305aa35e4c64fc7d63950764807cb81cc4d
prerequisite-patch-id: c3d3b313ac6abe4ec10fd820b6a9bbc63fdbdb82
prerequisite-patch-id: 63ee94d0ccd40f60a98b0004d627ad2e7b440d25
prerequisite-patch-id: 392e8f1902571e5035d5af72e40dc474b5f1b274
prerequisite-patch-id: e38fba722bdabc02ba09d2dc51df7010dbe28168
prerequisite-patch-id: a3ca5dba8def5769ffb4b95df2963da60a736f96
prerequisite-patch-id: 4c0fe8d677d73aaf1b5b842e072246d84729d1c4

Best regards,
-- 
Xilin Wu <sophon@radxa.com>


