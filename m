Return-Path: <linux-kernel+bounces-845081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20172BC3756
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF4A3BA3B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAEB2E8E0F;
	Wed,  8 Oct 2025 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3DcyU/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7142247295;
	Wed,  8 Oct 2025 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904484; cv=none; b=DIo7HFuTCmDfOI3ndM9s3huhfXsCx22yfX1+jAaFV4KoCbHXT0VKufrKZRYx7fDDXyxeJ1rTiIOrhABnBxWQ8Hah/0rzWsbd9+7rpNTiV6qCK5n175NDPUA+bLpURNOrH8yOxWKozckg4+Qna3WGD1w3vI4Kohq313SGFS5kkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904484; c=relaxed/simple;
	bh=zftFoY2NW42CeV+u2LtWYiPyCxMvkvvCeKwoDsOpq1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e3o6k7vQ5Ofz86bKQACrswTPasWm9LERj5qfG0xpglLAzZ68jK60D8Eq5y4phxgOkdPIOZB7PhxdqbL0MB0RGhfrjNNcbFzmPy+vGDV248BWtluZRhKD47fgsxXPyDYwRVq/NQ6eozOY8RFV4VEwdzTekqqPYutmrAUNYXwzPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3DcyU/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFB8C4CEF4;
	Wed,  8 Oct 2025 06:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759904484;
	bh=zftFoY2NW42CeV+u2LtWYiPyCxMvkvvCeKwoDsOpq1I=;
	h=From:Subject:Date:To:Cc:From;
	b=H3DcyU/XACgbUcA0UFao8srliyrovizXB20FA1HoYEJUBUh+k2jqIUrJN94uKoCzD
	 OImKMUfzcqZV0B0fQwad4kB1WZxVyNrMC2vGFaORO0j4/06gudMRbJHzHVNJ3w6SyA
	 aVQaKExMNWjAkOdKxEurAL/+nWeRFvoCwLVuGdPMekvmd9ActOZiA92BjudkbbLaxu
	 KdeGDvEitVcMKXqrQ7TA1eTRLzG2DkrmxotLcH/xnvB/xjwJh6ytVNx63cREHVrAGV
	 0VL9tgDCJt3LiOFTO63iopHnGQ4T33gS6djVgV42jILMHAOIavIQCX7AslvlO3woij
	 6DU7WzLfQOyeA==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH v4 0/3] RISC-V: Detect Ssqosid extension and handle srmcfg
 CSR
Date: Tue, 07 Oct 2025 23:21:09 -0700
Message-Id: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUC5mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNz3eLiwvzizBTdlJRkC3NLM4skoxRLJaDqgqLUtMwKsEnRsbW1AIf
 xr0JZAAAA
X-Change-ID: 20251007-ssqosid-ddc87968b2d9
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5432; i=fustini@kernel.org;
 h=from:subject:message-id; bh=zftFoY2NW42CeV+u2LtWYiPyCxMvkvvCeKwoDsOpq1I=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQ8Y3q87G3P9ic//k6xnhvqVc27gMe22e3xgi9h+7U+F
 jQF258S7ChlYRDjYJAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMROkrw//q1IMdtQwf/fcw
 /DBV7p13THmebdzsG0t1Jlwtf+shUnKFkaHre9saqdeblHdMqdN7wjJ5q8z04K6w2hfvnFfKc4U
 w/ucFAA==
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

These patches are taken from the implementation of resctrl support for
RISC-V CBQRI. Please refer to the proof-of-concept RFC [4] for details
on the resctrl implementation. More recently, I have rebased the CBQRI
support on mainline [5]. Big thanks to James Morse for the tireless
work to extract resctrl from arch/x86 and make it available to all
architectures.

I think it makes sense to first focus on the detection of Ssqosid and
handling of srmcfg when switching tasks. It has been tested against a
QEMU branch that implements Ssqosid and CBQRI [6]. A test driver [7]
was used to set srmcfg for the current process. This allows switch_to
to be tested without resctrl.

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/
[5] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/cbqri
[6] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-rqsc-pptt
[7] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log/?h=b4/ssqosid-debug

Changes in v4:
 - Rebase on riscv/for-next as of riscv-for-linus-6.18-mw2
 - Add Conor's Acked-by to the yaml patch
 - Link to v3: https://lore.kernel.org/all/20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org/

Changes in v3:
 - Fix parameter in __switch_to_srmcfg() when CONFIG_RISCV_ISA_SSQOSID
   is not set to avoid error in clang. This does trigger checkpatch
   warning about "Argument '__next' is not used in function-like macro"
   but it seems that '__switch_to_srmcfg(__next)' is needed to avoid
   the error that LKP reported. '__switch_to_srmcfg()' will trigger a
   build error in clang.
   https://lore.kernel.org/oe-kbuild-all/202509162355.wByessnb-lkp@intel.com/
 - Improve description of ssqosid in extensions.xml
 - Link to v2: https://lore.kernel.org/linux-riscv/20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org/

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
base-commit: 68247d45c045bb7dda923cf2c8d0937ce0e16394
change-id: 20251007-ssqosid-ddc87968b2d9

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


