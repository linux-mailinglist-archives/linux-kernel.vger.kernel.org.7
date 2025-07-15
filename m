Return-Path: <linux-kernel+bounces-731519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8AB0559B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD353A6BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD712D5423;
	Tue, 15 Jul 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bq11qXDC"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0B2D46CE;
	Tue, 15 Jul 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569827; cv=none; b=EwhkvB8XBuSUjAEmheColXOn+LeQZj4RgGJJs1Hofyb0DVDSR72KgFzMvIN5pGCkVwjH4H4FW4ecM3ndJfOE3auCFmRYALvI5GBB+f1OanOZTdJX4Yv6X/c9wJNaLDKMX75c8pjL+kCJxXaDzSHGluyzIeqpjwH9wDhqNZDpHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569827; c=relaxed/simple;
	bh=lf2izMzH9Jx97O4tYryK+CTatIWQzDXPgr1tb0WKuOk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Xy4VLsapWAZvbdRdZgMDJhVFnH6IKed6R3vzE2ppejcs4pXr7VFvr5BUDcvKHta8SKrrcscPuntRo9W4xvgtB2+i7E4h2s6C5I+l8cBSDKIwE76TAYcQQm4Jw0CfwMzg00H5Qn9d23YIhrYuTlG9qPpzRVqKJkc+dCwcHIRwEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bq11qXDC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7A7bN024208;
	Tue, 15 Jul 2025 04:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=eY4kj9lMyJ9t9VdXKSQQpX7IzsO
	Ex39670yvbQXOdvc=; b=Bq11qXDCNq3XlfsmEwDOqtWhjeZ8OaWPvzpV2KQmub6
	htNBLM1ux8P3M0uaifebbU6uYBV2KyilZoPxD+NOg6FQBZs+FVYtFBzkDEt/jRi6
	b6saTChlWMavuzsyqoo54eXrjKLZIM0H8cFcXgS15R7U2f9xDST+mVVqStm3L7UM
	y+kjuvgJaEOkeTCJdztOmhawcGL5NFPgU0/USpK6F5oOFsvkF9PKNksdtBxTpRB8
	38ylrwwQ+/gLhfIfKE3UxYRaAyrABRdjj0C6eo1meGEaqQ3QVVt2rhN0+Yvpwizs
	Z65lU8djRxL+CrDCm183tgr8shuUo6cyG7/GaLP5b7w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47vec314rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 04:56:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 56F8uiX6005590
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Jul 2025 04:56:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 04:56:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 04:56:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 04:56:44 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.81])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56F8uRA4019186;
	Tue, 15 Jul 2025 04:56:29 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH v5 0/2] Add ADI I3C Controller
Date: Tue, 15 Jul 2025 10:56:02 +0200
Message-ID: <20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKIXdmgC/3WR3U7EIBBGX6XhWgx/ndKNMb6H8WKA6S7Jtl2hV
 s1m313a9aKm8Yp8hHNgPq4sU4qU2aG6skRzzHEcSqgfKuZPOByJx1AyU0LVAoThGCKP2vMe80S
 JK6ylsb623jSsQJdEXfxaha9vJZ9insb0vfpnuez+q5olF1wYa8mKgJ13LzjgeTw++rFni2tWW
 x52vCo8gXUtYlCgxY7XG17aHa9XHmQjELxr6x1vNrza328Kr60BlB1AqOkPf7uXk+j9o5Q83Rt
 iPeWMa8mH6ulXrFbpZ1oOnXkiDGVZh1PYBW3Il9lgI39eineYiZfQx6l8n2xBN1Y72wCqzrQaN
 aEXhC05VI30DqxosTzr9gNnhnoUAwIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752569787; l=4831;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=lf2izMzH9Jx97O4tYryK+CTatIWQzDXPgr1tb0WKuOk=;
 b=wByvV7jcNj2vLFArNyV2OS04wRO9rrFHC6u2G85WYKs405UFXTCOh+ZWeJ5rN6rxqboA2aB0O
 S9ddabi6zwHDJKKZHzyT1lvhwK2a2gVkA5Qx4CjbFpOugjlwK4pDBda
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DPQ0Phg40GMr3rv0W4C4cWH94S-o_5VF
X-Proofpoint-ORIG-GUID: DPQ0Phg40GMr3rv0W4C4cWH94S-o_5VF
X-Authority-Analysis: v=2.4 cv=RY6QC0tv c=1 sm=1 tr=0 ts=687617d8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=XCmqdGZo9p5jl8pCkIMA:9 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfX9Q0o/u2twJRM
 CzQfBTaV52h4W2bMGIafrLCvNpqN5ITkYHEOl8ZBrk0IOWVfq73RbQAzIlcV8V2nRNE1uHcNVgJ
 pTsWY3YQMkqhreK9PkmsLuYdAIrF7HS/1RHBlZfWkmOyD62/Q+9u23CiM6Cn2sKRTbHFGNKXiic
 TL4Pmddzd+3KrPg6WkUnRJsnvkvg7s2zbc7WAq9eAFE2UJLFCztRupNICBB4zum8w7HYhMD/X9B
 DGGB3JZb6aCzZqZbtHIWPArfgkarZANOsh8VOs0I0kjEgqd5eBqp9WBsz0G2747hitQ7ACi/Ani
 j59pRHx3Ol6BrqMXqQcce0eMIuUEKEPNzwYDdw1aRJXE/LzHxR6qa3MDWzSjNROBi4TaZg/UWEV
 yTwAtpbaMrN12qy1QGKiLp8bmYT4etzxdytRhdA5amnFk6kQ6K9udlzw4m8N8UScb60+tGQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150081

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


