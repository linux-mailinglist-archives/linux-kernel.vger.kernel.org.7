Return-Path: <linux-kernel+bounces-818162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB378B58DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8388B485E64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACC26E6FB;
	Tue, 16 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC8XY4ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4817C91;
	Tue, 16 Sep 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999787; cv=none; b=PvipL4pipLct/iqQzmbDQuLy5L0vn94cRuIuv4sEAii/9qlokbMIIllgP7DdwCXiIfvqP5kVMVkPWIK49OZoD9hU9lAbRpo7bZk5vcunlOWcJrP8ClJREnAut3/FTt1FoX7vUK72AqI6uhrN6HqWVT5KL+AMUyuWtwPaXoglHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999787; c=relaxed/simple;
	bh=A18KZ9rlQr2JosW5W/tWPmxNteaChiuEhHIIR8hiA7U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dBYPYrlc0zktXZwtOVXCZjuF8Qtn34cH/eO2PalcrNsDjflAeXzrxrihMMU5fIy+03Y60E3L9NcjOqO9rTR/EGut0VUyGge+epck94HU4+no0SDTLnwlt7xdYqyyoHLSvffc8yqBdH9dkJg/pOEOvUiHr+BF8ejnIsqogFpjP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC8XY4ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6B6C4CEEB;
	Tue, 16 Sep 2025 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757999786;
	bh=A18KZ9rlQr2JosW5W/tWPmxNteaChiuEhHIIR8hiA7U=;
	h=From:Subject:Date:To:Cc:From;
	b=vC8XY4ck/xXyYfkSUnV+deexg3AOlbEc1uy2lkdElNLyr0axNlBv2jlPIYcn99BGs
	 kKJaKnPN4td5YPax0g9T7Wq0Leh6bdTLxXkta4n5Cr8lOStYzcOIg5P/xCnLaGLu0+
	 OBM5y8wjxQ29C6dtaxBaV0gxQS/sY7+/PFGqAjxmJemjgIEOSV5URD4Q2QVwn2qjBD
	 syFHgY4gYtAy+7Gpk/7FR1JMQjQ8PDtIAswO1VP0jhmRbcKWESz0ogbosLfmD3q6si
	 ZAgbNOV212Ltkqpj+u5CjtOmuLv+fYAAuGFl+fqLGVl90+RGCCxWnb4cIUjRrCBdxB
	 HljXBnVyHtyWA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v2 0/3] RISC-V: Detect Ssqosid extension and handle srmcfg
 CSR
Date: Mon, 15 Sep 2025 22:13:40 -0700
Message-Id: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAATyyGgC/x3MPQqAMAxA4auUzAZiof5dRRxqjZrFagNFEO9uc
 fyG9x5QTsIKg3kgcRaVeBTYykDY/bExylIMlqyjnnpUvaLKgrnBusUUHK4h0Nx0viVvoXRn4lX
 u/zlO7/sByF/0M2MAAAA=
X-Change-ID: 20250909-ssqosid-v6-17-rc5-fcc0b68a70a2
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=fustini@kernel.org;
 h=from:subject:message-id; bh=A18KZ9rlQr2JosW5W/tWPmxNteaChiuEhHIIR8hiA7U=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWSc+LQypff3T90NfmXewe4LzaPuG3z/Eu69uDg/ZuPdx
 WpvdB95d5SyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmssCPkWE/p52BSLXx+ZD8
 vbs/if7c73xvdrjQk+RfrBuXX/7vOUuC4Td77O3b91J2C6yYKf9Zr2O7sGaKSNKjy/+6f73I6Y7
 mf8kCAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This series adds support for the RISC-V Quality-of-Service Identifiers
(Ssqosid) extension [1] which adds the srmcfg register. This CSR 
configures a hart with two identifiers: a Resource Control ID (RCID)
and a Monitoring Counter ID (MCID). These identifiers accompany each
request issued by the hart to shared resource controllers.

Background on RISC-V QoS:

The Ssqosid extension is used by the RISC-V Capacity and Bandwidth
Controller QoS Register Interface (CBQRI) specification [2]. QoS in
this context is concerned with shared resources on an SoC such as cache
capacity and memory bandwidth. Intel and AMD already have QoS features
on x86 and ARM has MPAM. There is an existing user interface in Linux:
the resctrl virtual filesystem [3].

The srmcfg CSR provides a mechanism by which a software workload (e.g.
a process or a set of processes) can be associated with an RCID and an
MCID. CBQRI defines operations to configure resource usage limits, in
the form of capacity or bandwidth. CBQRI also defines operations to
configure counters to track the resource utilization.

Goal for this series:

These two patches are taken from the implementation of resctrl support
for RISC-V CBQRI. Please refer to the proof-of-concept RFC [4] for
details on the resctrl implementation. More recently, I have rebased
the CBQRI support on mainline [5]. Big thanks to James Morse for the
tireless work to extract resctrl from arch/x86 and make it available
to all archs.

I think it makes sense to first focus on the detection of Ssqosid and
handling of srmcfg when switching tasks. It has been tested against a
QEMU branch that implements Ssqosid and CBQRI [6]. A test driver [7]
was used to set srmcfg for the current process. This allows switch_to
to be tested without resctrl.

Changes in v2:
 - Restore the per-cpu fix from RFC v2 that was missed in v1:
   change DEFINE_PER_CPU to DECLARE_PER_CPU in qos.h and move
   DEFINE_PER_CPU to qos.c
 - Introduce a patch that adds Ssqosid to riscv/extensions.yaml
 - Link to v1: https://lore.kernel.org/r/20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org

Changes in v1:
 - Rename all instances of the sqoscfg CSR to srmcfg to match the
   ratified Ssqosid spec
 - Link RFC v2: https://lore.kernel.org/linux-riscv/20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com/

Changes in RFC v2:
 - change DEFINE_PER_CPU to DECLARE_PER_CPU for cpu_sqoscfg in qos.h to
   prevent linking error about multiple definition. Move DEFINE_PER_CPU
   for cpu_sqoscfg into qos.c
 - renamed qos prefix in function names to sqoscfg to be less generic
 - handle sqoscfg the same way has_vector and has_fpu are handled in the
   vector patch series
 - Link to RFC v1: https://lore.kernel.org/linux-riscv/20230410043646.3138446-1-dfustini@baylibre.com/

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/
[5] https://github.com/tt-fustini/linux/tree/b4/cbqri-v6-17-rc5
[6] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-rqsc-pptt
[7] https://github.com/tt-fustini/linux/tree/ssqosid-v6-17-rc5-debug

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
Drew Fustini (3):
      dt-bindings: riscv: Add Ssqosid extension description
      RISC-V: Detect the Ssqosid extension
      RISC-V: Add support for srmcfg CSR from Ssqosid ext

 .../devicetree/bindings/riscv/extensions.yaml      |  6 ++++
 MAINTAINERS                                        |  7 ++++
 arch/riscv/Kconfig                                 | 17 +++++++++
 arch/riscv/include/asm/csr.h                       |  8 +++++
 arch/riscv/include/asm/hwcap.h                     |  1 +
 arch/riscv/include/asm/processor.h                 |  3 ++
 arch/riscv/include/asm/qos.h                       | 41 ++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h                 |  3 ++
 arch/riscv/kernel/Makefile                         |  2 ++
 arch/riscv/kernel/cpufeature.c                     |  1 +
 arch/riscv/kernel/qos/Makefile                     |  2 ++
 arch/riscv/kernel/qos/qos.c                        |  5 +++
 12 files changed, 96 insertions(+)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250909-ssqosid-v6-17-rc5-fcc0b68a70a2

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


