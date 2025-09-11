Return-Path: <linux-kernel+bounces-811399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3AB52896
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BA3B3C74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD04257846;
	Thu, 11 Sep 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4dw0eOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89472571D7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571380; cv=none; b=IyUITLD5Sf2NbVs9LSTfheLZgjhrYlG70Z5KA4vCBTgOVEAkoH1fe/Dl3tNcBB8rzP0SKHuZIk2PgBwE7+L9vDwMkDxugKbfODDfz6xmaTO422MnYWolRhZbVJBKiw/plBD3+sx/SdtgYrLt1gAN4BgmZbicBEF1SArtVMRGAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571380; c=relaxed/simple;
	bh=ROX9J4DVISbZb0WSpNLVp5LK08+J+x9wXLeyIYlyDEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OTXIlVyeM4OU+I3ugJhwx0n5yiZaDcZKfooBKyRkdbHcflzjX7RadcKHQerSPEeYNXmCZGRJreGw5D/QdstU2adYEKeUXoaKwkbDzH+cElBpXYnDeobXGwJAvJ9F3u1T5tuzRqN/V2kb/r6bAOICJQXadZXncxaOHWZ+YM3Yk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4dw0eOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E425DC4CEF1;
	Thu, 11 Sep 2025 06:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757571380;
	bh=ROX9J4DVISbZb0WSpNLVp5LK08+J+x9wXLeyIYlyDEU=;
	h=From:Subject:Date:To:Cc:From;
	b=S4dw0eOz3n22Yeeki35UO5y88R0ejc6uP0MsjXcRYh7aEhnIJuBQePwu2Du0gkZkA
	 oFINonXgj6kvCTF6UBQ4Clm9Fko74Kfh+ExQM3qGrP2bA+aU78c5fYkq9lPmIkfJoj
	 JBcdYEUd7dzf3YNeBsA6MGKglmZQx9BGywOKkTaIzegzRDRSfNjWAv2V6V1wMehfw3
	 iGpqZAeQPAEVsd2uNKv9jJkNsQvSzq326IOZVpwbtCxdBqXGufcCzXCjSincx5loKL
	 iHbg1DUp7Tp1GaHu2OR7ES7OXUOtWzEok8t/3uKzrpNDXYQvqd11zThGwy8LOcL9p2
	 KZnEQiTna42Ew==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH 0/2] RISC-V: Detect Ssqosid extension and handle srmcfg CSR
Date: Wed, 10 Sep 2025 23:15:28 -0700
Message-Id: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABpwmgC/x3MPQqAMAxA4atIZgOxoFWvIg61TTWLPw2IIL27x
 fEb3ntBOQkrjNULiW9ROfaCpq7Ab25fGSUUgyHT0kADql6HSsC7w8Zi8i1G72npemfJGSjdmTj
 K8z+nOecPLhFm7GMAAAA=
X-Change-ID: 20250909-ssqosid-v6-17-rc5-fcc0b68a70a2
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; i=fustini@kernel.org;
 h=from:subject:message-id; bh=ROX9J4DVISbZb0WSpNLVp5LK08+J+x9wXLeyIYlyDEU=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWQcytRQ2qlr5vAsuW/a9ksyU3e+fLIvJXdybo6HbuHku
 UqVXz7ndZSyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAm8qeMkeFluFDnK66aH98/
 Fs2ve/Py3sx/M7Yk+O36WS48PWcj/00Zhv/O1xqNv4cb993yXV3tEC4z7Xu9+LL4DUFHtXRyF0Y
 dDOcHAA==
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

Changes from RFC v2:
 - Rename all instances of the sqoscfg CSR to srmcfg to match the
   ratified Ssqosid spec
 - RFC v2: https://lore.kernel.org/linux-riscv/20230430-riscv-cbqri-rfc-v2-v2-0-8e3725c4a473@baylibre.com/

Changes from RFC v1:
 - change DEFINE_PER_CPU to DECLARE_PER_CPU for cpu_sqoscfg in qos.h to
   prevent linking error about multiple definition. Move DEFINE_PER_CPU
   for cpu_sqoscfg into qos.c
 - renamed qos prefix in function names to sqoscfg to be less generic
 - handle sqoscfg the same way has_vector and has_fpu are handled in the
   vector patch series
 - RFC v1: https://lore.kernel.org/linux-riscv/20230410043646.3138446-1-dfustini@baylibre.com/

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/
[5] https://github.com/tt-fustini/linux/tree/b4/cbqri-v6-17-rc5
[6] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-rqsc-pptt
[7] https://github.com/tt-fustini/linux/tree/ssqosid-v6-17-rc5-debug

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
Drew Fustini (2):
      RISC-V: Detect the Ssqosid extension
      RISC-V: Add support for srmcfg CSR from Ssqosid ext

 MAINTAINERS                        |  6 ++++++
 arch/riscv/Kconfig                 | 17 ++++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++++
 arch/riscv/include/asm/hwcap.h     |  1 +
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 +++
 arch/riscv/kernel/cpufeature.c     |  1 +
 8 files changed, 80 insertions(+)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250909-ssqosid-v6-17-rc5-fcc0b68a70a2

Best regards,
-- 
Drew Fustini <fustini@kernel.org>


