Return-Path: <linux-kernel+bounces-734775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A36B0863F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF10162C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB5B21ABDC;
	Thu, 17 Jul 2025 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v9YIMMiC"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF06214818;
	Thu, 17 Jul 2025 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736212; cv=none; b=hM0UkRuMJ2ng380mNgRH16whsQlHGE928aBEg+CJ5pFTAiFEzkxRJ/8+GhtUrOEvqw2ron10innbSbTcuYvIKWrRxEn+U1A4RncWf7K5um1cdEGPNC3GDXce42W5m7zH/2c0XvOTL8/vx7YKG7en7w9mzGPpPdXQHwguvDpmzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736212; c=relaxed/simple;
	bh=jHjMV2xBJawe/oOTiIyI28isXyG/lzzb72n9lxfPhPM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LoX5BDFDoZMY7ZxkFgIuHzaiaZlcM5fXcPyHl1aQDoeJzRtnxYcXmYaREQwzVvX4nDT40K6G1krzO8L7tPuYgh1KGgmp+6YHiYXPuV4WIR7UPVZrtqY47lxUp17T7zQvj/zo3/sRdR9Pb7ny0f/PebkDWstMs4WooGBdMLnlPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v9YIMMiC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H30kul022877;
	Thu, 17 Jul 2025 03:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=D2/S8v3aa6hBRNh3w2/IBfsMgN/
	f2bhDnK4NOoM0qV4=; b=v9YIMMiCDU6i1t+s0WtHKENPYhUd9QwGJmHzoKs8U9c
	eBj7U3gi2GObRXLvrfiDLOU4JhZUP8wvqnO2frFYt01tMQRWu10NHzEkhTdBo7cn
	wl8uyrArKwn4Ul6DObbk5+T/8jd3KafpqlADrjGBlOLD6eRZmuRw1SPyonPSSpyu
	SD5J+tpk6544+A2+ReemRrq8k35k3ONlWwtsj41qfFXBfyheF/9MT1yj1PDXWPmy
	40a3LPwG/20vxS/QAkpzHbBltOWpadYFzYRCysqboRBcFb8ESmU0lb/A0rBHSGGh
	O02iHs3DU6v0HtdZpISOJ+mXLh9XnOtPrJfiljTLiDw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47xcpmmd5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 03:09:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56H79q0u046678
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Jul 2025 03:09:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 03:09:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 03:09:52 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.72])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56H79bDN005035;
	Thu, 17 Jul 2025 03:09:40 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v6 0/2] Add ADI I3C Controller
Date: Thu, 17 Jul 2025 09:09:19 +0200
Message-ID: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+heGgC/3XR20rEMBAG4FcpuTaSc9NFxPcQLybJdDewbTWpV
 Vn23U27gsXgVZiQ788wcyEZU8RMDs2FJFxijtNYCnPXEH+C8Yg0hlITwYRmhikKIdIoPR0gz5i
 oAM2V9dp61ZKCXhP28XMLfH4p9SnmeUpfW/7C19t/oxZOGWXKWrQsQO/dE4xwno73fhrImrWIv
 TeVF8Wjsa4DCMJIVnm589xWXm7e8JaB8a7TlVc7L+r/VfHSKgO8NyZorLz+9S3XldfFe9spqby
 D/o+/3oab8O29LGm+TZgMmDNsSzo0Dz+NiS30I62PzjQhhHJswxHQB6nQl9mYXfjjujgHGWkph
 jgfGs07I1srnW0NiF51EiSCZwgdOhAt985Y1kFp6/oNaAM+a0MCAAA=
X-Change-ID: 20250604-adi-i3c-master-2a5148c58c47
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gastmaier@gmail.com>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752736178; l=4969;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=jHjMV2xBJawe/oOTiIyI28isXyG/lzzb72n9lxfPhPM=;
 b=fSYCB0zrlpwTGzh8RxIKrBmN8kF/9vksJOKrOiKTgAMK5k0iyELOzSEy+wjnNs+BCBpW1kfej
 vLTtxpJlHJ3AbUg+Df1ULaKOyOk48+7BGUaQNWCZ82rNkyJ4Bp2hlEJ
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Z97sHGRA c=1 sm=1 tr=0 ts=6878a1c1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=XCmqdGZo9p5jl8pCkIMA:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: PRok4_ADdO77z1XHJsh60-WS0tI1nqEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA2MCBTYWx0ZWRfXyGubynAT/JKl
 hOdBD4AZiNCI9X+Wy1dgwxn/GcnwwynNZGaEtajpn18wU7npXPvrNjg79Y40ZNkTJ7uEJnuVFG6
 KEiLaDwzHW3zoax+LRi2BTb+CemwpufRzzNaVkDYCx23BdhWeNxph5PsP6PqL1j0PDyRKtuAG71
 obemEAGUoBING2FFxLAgOAMhFob6G1KBpjvOviGUEU/LRJu471yJc3EYW3wrnVujqYw2z46hNYM
 3IeJf0Cj2hpucls+g9GTd78mXa+qG4mMqSvlSCJaMJp864bOSke7SWflIoxQEt9/pOeh/105O5A
 72XQr23OetRvmx+bqj28idjkA67yikVetS1GMgeFbarBV3l0bboFNy4p9Rsp0eqPWU/aZlZSU8P
 lR0XBqvDDMwl7JvdfA5fULAhkmaTmCQKQgHttOWrBjqYY/409pGGsr843A4A3+7tylcZOZYD
X-Proofpoint-GUID: PRok4_ADdO77z1XHJsh60-WS0tI1nqEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170060

I3C Controller is subset of the I3C-basic specification to interface
peripherals through I3C and I2C. The controller RTL is FPGA
synthesizable and documentation is provided at
https://analogdevicesinc.github.io/hdl/library/i3c_controller

The main target for the I3C Controller IP is low-cost FPGAs.
In this version the driver supports IBI (only the MDB), I3C and I2C
transfers.

Depends on https://lore.kernel.org/linux-i3c/20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com/T/#t

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Changes in v6:
- Format 0x05C undercase
- Link to v5: https://lore.kernel.org/r/20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com

Changes in v5:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Use semantic versioning major field for dt-binding compatible, with
  the format adi,<ip-name>-v<major>

adi-i3c-master.c:
- Rename MAX_DEVS to ADI_MAX_DEVS
- Encapsulate REG_CMD_FIFO_0_DEV_ADDR var
- Reorder struct adi_i3c_i2c_dev_data fields
- Start addr at 0 instead of 8 at adi_i3c_master_get_rr_slot
- Minor rework on adi_i3c_master_handle_ibi to most logic out of the
  lock. Even if length is 0 (BCR[2]=0), the mdb field is extracted and
  written to the slot buffer. Since the length is 0, the written data
  doesn't matter.
  In a future update with additional bytes support (e.g., bits 31-23),
  len would be incremented and an IBI FIFO would be read.
- Version check against first stable release, major v1.
  Driver+RTL features updates affect the minor field, therefore check
  for major == 1.
- Link to v4: https://lore.kernel.org/r/20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com

Changes in v4:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Add -1.00.a suffix where missing
- Extend clocks descriptions
- Add minItems to clock-names, to match clocks
- Use header in example

adi-i3c-master.c:
- Regmap:
  - Add new controller info registers (dyn_addr, dcr, bcr, pid)
  - Always decreasing fields
  - Add line break between registers
  - Reformat REG_DEV_CHAR_BSCR_IBI to use easier to read FIELD_GET,
    FIELD_PREP
- Read controller info from regmap with explanation comment
- Use linux/fpga/adi-axi-common.h macros
- Use __counter_by macro on ncmds
- Use __free macro
- Use new i3c_writel_fifo and i3c_readl_fifo macros
- Rename bytes to buf when nbytes is present
- Use scoped_guard instead of spin_lock, spin_unlock
- Reformat loops to read fifo status, use while single line alternative
- Drop adi_i3c_master.max_devs, use MAX_DEVS directly
- Use devm_clk_bulk_get_all_enabled, dropping clock name match (CHECK_DTB does it)
- Init spin_lock
- Init list head
- Link to v3: https://lore.kernel.org/r/20250618-adi-i3c-master-v3-0-e66170a6cb95@analog.com

Changes in v3:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Small reworking of the description
- Add -1.00.a suffix to compatible

adi-i3c-master.c:
- Misspelling
- Remove REG_CMD_FIFO_0_LEN_MAX since it is a HDL parameter
- Use adapter timeout value for I2C transfers, as in
  https://lore.kernel.org/linux-i3c/aEBd%2FFIKADYr%2F631@lizhi-Precision-Tower-5810/T/#t

- Link to v2: https://lore.kernel.org/r/20250606-adi-i3c-master-v2-0-e68b9aad2630@analog.com

Changes in v2:
Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
- Move allof
- Rename clocks to axi, i3c

adi-i3c-master.c:
- Update license year
- Rework regmap to use FIELD_GET, FIELD_PREP
- Reformat regmap to have FIELDS after REG, prefixed by reg name.
- Add overflow safeguards to cmd, tx fifos
- Fix macro related macros (mostly erroneous `| ~BITMASK`
- Use guard macros, remove goto.
- Simplify daa logic
- Replace devm_clk_get with devm_clk_get_enabled
- Solve 64bit->32bit warnings on x86_64 systems by casting to u32
- Immediate clear irq request flags, then handle it.

- Link to v1: https://lore.kernel.org/r/20250604-adi-i3c-master-v1-0-0488e80dafcb@analog.com

---
Jorge Marques (2):
      dt-bindings: i3c: Add adi-i3c-master
      i3c: master: Add driver for Analog Devices I3C Controller IP

 .../devicetree/bindings/i3c/adi,i3c-master.yaml    |   67 ++
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   11 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/adi-i3c-master.c                | 1019 ++++++++++++++++++++
 5 files changed, 1104 insertions(+)
---
base-commit: 51963783b876a2f493a3eac0ea9eba271cb6809a
change-id: 20250604-adi-i3c-master-2a5148c58c47
prerequisite-message-id: <20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com>
prerequisite-patch-id: 5443f14ca82fc08593960fafdb43488cce56f7d9
prerequisite-patch-id: 647084f5fe09f4887f633b0b02b306912a156672
prerequisite-patch-id: 6f582bb2ef1aafb66f26c515a19d5efa06ab8968

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


