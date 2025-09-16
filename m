Return-Path: <linux-kernel+bounces-818111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBADB58CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196133B8AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F32C11DF;
	Tue, 16 Sep 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfjzT/zQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310D1E9B1A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996665; cv=none; b=lLawy8umksrgSSlvrFo10rjj0GIwrcgdHoLK/FHTUNV4AcBOEh2fRNVZeGM+m3139SbcxaQ5vT/v4V36+DDHdSSu3x0yeDOciZUXbxfhHKm94MBY1rKMG6OBIDboklLYR/PJgFHg1Z3r9BSk/JVYSro5LSLKPtwRGYgIrIxHTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996665; c=relaxed/simple;
	bh=d0F5+UgTCzgn3IXwRvcRolaBOhApuSrgUcOQlvXYqh0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SM2zV5Vqc/ToJRCeI4g7pATwVUMURCdPKrxHpL7l4ImbPLshT5lB/ibhfx1jGRWtoKwNOk31bXk7lJhNI3cdxOvBUBXxRmLWaaVqorzLAPVtJ4/6l5tpnMc8DSg3YGu0OEzNbWA0hnqLEFqA5MdKIiB6SKVFa1ZDUBqt7BAxkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfjzT/zQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3q67Z019431
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y2TOoktq0KjQ4asl3Zg3mi
	+Gd0JBZ13V6kqk/o6P8Vk=; b=kfjzT/zQiWMlFV2ZNJwjZk+Xfodb7maxd5b9cH
	2ZhxOXotYAhQTRlFjCD5ZkgRT8Po0o3WqTHMKKsAA2kL1EgekK7fBigEu+D2XXPp
	miDzgqU6IiNta3VcVhjsHcYwg0xOf9aM+9j0VtKAGyuTCqLKz5BuMISAA6Ke5lQW
	XqSffUgIE41bhkXgiyay3ww1OFct0l61GtKOGAC8R76Jqf8xS52WfmxQl1oM8Ftl
	TE02HEFOzdUHFHrPwQqUl3kq2m9+c/KJm4K/jCBgU9fkljzrIm0Ow5fhbLFasIyj
	14VoLj07fJLQAgtf7+hAFwqK2cMNE33tDcJ79HSkg0wZCOng==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9bqdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:22 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-435de5b55e7so1500909b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757996661; x=1758601461;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2TOoktq0KjQ4asl3Zg3mi+Gd0JBZ13V6kqk/o6P8Vk=;
        b=QEhEZdDCYPTDZkhExd+q5pOvMEfKLEU+XTMEU2kvk1q82rtNJqIQ5mA+oOmafJv5Pg
         iuC+XOHec98467hhLj6LBlkSM+Kz+/TOq6ndgkzZB7QAxaModu0SDRKDbxZ7H0PVMFQD
         MDwi6ZQvYrRxOyg/c9Lw7fE5bmjVrn5domgpok0QIsxYLvfSO5cLQc3huNzGwLkzXqYN
         IYO4t5m2QcinSIqDrXv0KeWzR7cxtY5M+w5gt3Htlolz9HWX90488X74wwyHLOYV6m3j
         VBUVunInCFyV2x2qwnkp+zI8D4JA0ypJ66KRJgabrI94neXDIpXQnqqNaLwobkfus/KE
         iiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ezHgXg311dXflpHUqXsxStuXQIMxCJYsjyQCW2Zsj4FOIb/CwfvdVtvTxHHD9gN0E7q5inzEohXVHQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4K4ikNSQmQ7HWNrqx2RRWrpw2FlUXyVrMGC6S8xY/08r2ztP
	0LwyGhw56hOrZRSCkZKeJaR+K5OqI3QBGuBP0EXZb5EAq88I99gLvBx4uoawhtkw2bYJeuYnCbF
	CCPeZEDaKYIaH/ynPZjrJbX/EwZfyABH1v2IUiC4wjvEGRdCVpt4XrycBEWWgwqzbSLP+Slbwp5
	0=
X-Gm-Gg: ASbGnctfYM0sbBHpYS/pBffo56rR/szcrnPxAJcZYwxwfpzXoIa8CFKR426zwefAYJx
	Gzxn7PnYCWwP1cAx454EXgiKdsFD37Lyg9qkP4vOnuAUn/aEL4kd3MadEJs3pQ1Q8GeTceJkZUg
	asLmXRDjcFxjIeerlGsuiVys2vmPyJQdv+t594xXKUcL2FgZa0N2A8oYXKW556Zp06/llVh4M8W
	UboJy3Qt0Z/rCqTUz71/cSRorkYnt41ak6mlMQL6F2iFPpCzRgrE1OfaoWmtGkOxKs2d7HPPpd7
	C+1FOhiSkzJR55flhOzRi0ruPEqDbpoWLGANxLFunS6Pi16Y//uNixj5t2neij4N7K/7otIHuFQ
	9ucymDpIXrfe2zU0z1TYa+/3GdkmPbDD12oNxFZg=
X-Received: by 2002:a05:6808:2e48:b0:438:3cb9:920e with SMTP id 5614622812f47-43b8d9a8997mr8375523b6e.28.1757996661166;
        Mon, 15 Sep 2025 21:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcGYEoc87vyrKj/Rrl2HfmchHYzlGT2ZjDf00mVGz2E3zBuHzG1PaPqqOetTeoFgR2BFTFSQ==
X-Received: by 2002:a05:6808:2e48:b0:438:3cb9:920e with SMTP id 5614622812f47-43b8d9a8997mr8375510b6e.28.1757996660742;
        Mon, 15 Sep 2025 21:24:20 -0700 (PDT)
Received: from [192.168.86.59] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a73075sm2772862b6e.19.2025.09.15.21.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:24:20 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH v2 0/3] arm64: dts: qcom: qcm6490: Introduce Particle
 Tachyon
Date: Mon, 15 Sep 2025 23:24:14 -0500
Message-Id: <20250915-tachyon-v2-0-4f8b02a17512@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7myGgC/2WMyw7CIBBFf6WZtTQ82iiu/A/TBcJUJrFFoRKbh
 n8Xu3Vzk3NyczZIGAkTnJsNImZKFOYK8tCA9Wa+IyNXGSSXPdeCs8VYv4aZoeq7k+6E0kcH9f2
 MONJnL12Hyp7SEuK6h7P42f9GFoyzqvhtdEIp5JeQUvt6m4cN09TWgaGU8gX/l2TppQAAAA==
X-Change-ID: 20250910-tachyon-e3548941397d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=d0F5+UgTCzgn3IXwRvcRolaBOhApuSrgUcOQlvXYqh0=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBoyOZz+FgAXgCG3QIzr/KKCM0MpOGzwVOtyiP0V
 7PgrMEJk7aJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaMjmcxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWYbxAAwrKS/p9TDQyofwik6KhyMAHTgeKKgG8UQBGOg/F
 Ae8Koo/IOyvr3ivx4viTeUMpvP28G2yD0Sjk0GNpwZGyRkaNHfpRT9JZc/HBFXQrkYWxzIPR4Qo
 ymJnHyAJliVb+DoPUsS1zWWRof/Cr40lmoizNEuMsyVR87uc2nW8qcSaqX+LJWZDamfkuIPYxBm
 Xm9ahRUOzx5E9I1/B0UzqVYq8P3QkGeFNcCrntc/oCcmNWINxnvVYWchWoRoG8vCCd1MEKHVtRR
 bLvwrkvPmWLr7r0EMY4RkoqJUjEFDrCNNkN9MET1Cbjhb3Dt+DaXbq9ku9DukW3kN2FYjn9Z43a
 vgNhna02B1JAIX2qMGu2FNjH1XXlCRXeHGygYrUBZD0XhYYla8ZzR+v5OhB515hrej9Drevhc65
 7yvW89kduSkFL9u/b6oPdT11xGkYurJ5Ub3j5ryryifD47cQqnLoqPbQMG/CLgd9g53+NAS+7Rg
 RDGOWxwNi0QO+qhUz2L7sO/S2tIBB7LePcHhNIJfS+dCx40avPry9HhiqpZlBl278szkhcUNoVq
 98HT4YwYDg2dGyWDnzolYYowsVP4+SMr1oJs+qN02g8dLYlSZ3TloqT5lLIKE32b0KrmXk2CIjH
 sq6E5/Mfc50DyKbvEjrKrLAopMwsxmt3aSNCQqRC+XEk=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c8e676 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7AODkVuKAAAA:8 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mczXGPDCzB4sW3sFK7IA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=sRHRY8H3vKB1GfNvUtpx:22
X-Proofpoint-GUID: Zh8AqdlUluR-mx5Qs8QscBW22cKrmo31
X-Proofpoint-ORIG-GUID: Zh8AqdlUluR-mx5Qs8QscBW22cKrmo31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX+oZxIy/gBS/C
 azd+Qdvteu8Mb1Z6akOarSapkl8GxF10yHB/rhwsSnqWrwLqhkV5t/8AHKBfEJt1AgPAG+0xgTp
 fqgZnFTS0/zcQMmWwWJRPy4OdrXxCnCmdsqiFVozj6jjVzCzkRvi3jQ4GpiG2xDyQjwsbMToZ/N
 XKbNPZWTjQ+zHRr61xLXcjKrxIwQCzKbFGQemYyYtgWocv/9j8sz2hzg6ft/hrfXZlribxOaaiP
 7qYtqElJbJLQvC+iReDXT9RgFbIZ9q3gdl9DUMR6f7ac22+xZZ75FTp2jRWuUtgIhekNaIJGvt6
 cFLGZl9hqnGxytt6IOfTMwSdJKqXQRc1+ODTsWWCnYKjFf1PG40Za8u7ICXwIqqyfHOc3jR2yh0
 Vw2gHSPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

Introduce the Particle Tachyon board (https://www.particle.io/tachyon/),
a single board compute with 5G connectivity and AI accelerator.

The boards currently ships with the Android Boot Loader, but replacing
this with abl2esp allows writing a EFI System Parition and OS partitions
to all of LUN0, and a more UEFI boot experience. A prebuilt version of
abl2esp is provided at [1], as abl2esp-v6.elf.

With a (very) recent version of QDL, a flash programmer from a Tachyon
software release, and a full distro image, this can be achieved with:

  qdl prog_firehose_ddr.elf write abl_a abl2esp-v6.elf write abl_b abl2esp-v6.elf write 0 image.raw

The following firmware files are currently used, on top of what's in
linux-firmware already:
  qcom/qcm6490/particle/tachyon/a660_zap.mbn
  qcom/qcm6490/particle/tachyon/adsp.mbn
  qcom/qcm6490/particle/tachyon/cdsp.mbn
  qcom/qcm6490/particle/tachyon/ipa_fws.mbn
  qcom/qcm6490/particle/tachyon/modem.mbn

In addition to bug fixes that has landed in v6.17-rc this depends on
[2], which is available in linux-next.

[1] https://github.com/qualcomm/abl2esp/releases/tag/v1.0
[2] https://lore.kernel.org/all/20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com/

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Changes in v2:
- Fixed qcm6490 vs qcom6490 in a couple firmware-name paths
- Reordered once pinctrl-0 vs pinctrl-names
- Provided speed property for i2c1 to avoid Linux informing us about
  picking 100kHz (no value in downstream)
- Drop a of_graph connections and properties that was already
  established in dtsi
- Link to v1: https://lore.kernel.org/r/20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com

---
Bjorn Andersson (3):
      dt-bindings: vendor-prefixes: Add Particle Industries
      dt-bindings: arm: qcom: Add Particle Tachyon
      arm64: dts: qcom: qcm6490: Introduce the Particle Tachyon

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/qcm6490-particle-tachyon.dts     | 864 +++++++++++++++++++++
 4 files changed, 868 insertions(+)
---
base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
change-id: 20250910-tachyon-e3548941397d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


