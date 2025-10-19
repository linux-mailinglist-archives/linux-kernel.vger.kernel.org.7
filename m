Return-Path: <linux-kernel+bounces-859815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60EBEEAC4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50FBC349530
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C92E1F13;
	Sun, 19 Oct 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+gJzz3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4618D658;
	Sun, 19 Oct 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760894620; cv=none; b=rvetVlk29i6EU5ryNAh83BF383wmVgoFhFV5+e3mn3Qqpi+GfrM8tQz+fDcDsyoOv37pP2d/g/tEvZKPSrFiDl9SFqzjaTGZxgTalsImVtZT90hDmoTu+KAimJlryKHt6dZyHoUc/rQZN1Sj4Twe/I4dpfwaZ57HiXPUYaFp8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760894620; c=relaxed/simple;
	bh=YjwgU07lTttycLobcPqPwzVy5bTSFOQ+Tt11e6IE6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o2Z6iA6k21nrEju0P1RO+TRZUkO3mBdgK/4agCULhAyn3UVwdoAMGlWxeLrDbDbgZE8KkV/wGQ3pOkVQr99fZ3APUFx6qpBLjPgyK993WTGFWr6lTuOPiCGbNue/9OMr1uxPGePof317U1evml2sp7ghYPm/NfUjwto2aeziBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+gJzz3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D43DC4CEE7;
	Sun, 19 Oct 2025 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760894619;
	bh=YjwgU07lTttycLobcPqPwzVy5bTSFOQ+Tt11e6IE6kI=;
	h=Date:From:To:Cc:Subject:From;
	b=N+gJzz3ORVwoPCxEgwHELlWleaV/eXlwHdSDnoyEk7zopJVpmaxB1E5YGu6Jus3+h
	 9AJmubMDFHMChgLfXt8EWfNcDiqmGO2Kq8EB31+ApECRdM6uYTpQtBzo5nly75ki2h
	 adHYWL/VaYc2hohr0YtdWNxLWYHLjSyL0tWxKxDFEhBzBChrPjN6NjMTRxwBfUMsip
	 P55eJGfSzy9PYd87YFuEE4/w+hdAGSl1M/9OL75GYYQJLzpcuVueuCacaGK4NCjf/f
	 zioopatQIHDhffQmgmUeyVTZGdVihaKhHxQjn69e/xal7azX95SVU1lisSCLpSpvWu
	 VzMwt7LscrluQ==
Date: Sun, 19 Oct 2025 10:23:37 -0700
From: Drew Fustini <fustini@kernel.org>
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>, Joel Stanley <joel@jms.id.au>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Nicholas Piggin <npiggin@oss.tenstorrent.com>,
	Michael Neuling <mikey@neuling.org>,
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Paul Walmsley <pjw@kernel.org>,
	Drew Fustini <dfustini@oss.tenstorrent.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V Tenstorrent Devicetree for v6.19
Message-ID: <aPUemXdOFZEdkayE@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

Please pull these changes which add Tenstorrent as a vendor and enable
support for Blackhole. It adds the appropriate entries in MAINTAINERS.
The changes all come from a single series [1] posted by myself. Joel
Stanley has reviewed and tested all the patches. Rob acked or reviewed
all the bindings patches. W=1 dtbs_check and dt_binding_check produce
no warnings.

[1] https://lore.kernel.org/linux-riscv/20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com/

Thanks,
Drew

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@github.com:tenstorrent/linux.git tags/tenstorrent-dt-for-v6.19

for you to fetch changes up to a71e6e8eea8ae2d624f097911f43357bba06d2a5:

  riscv: defconfig: Enable Tenstorrent SoCs (2025-10-18 10:44:15 -0700)

----------------------------------------------------------------
Tenstorrent device tree for v6.19

Add Tenstorrent as a vendor and enable support for the Blackhole SoC
in Blackhole P100 and P150 PCIe cards. The SoC contains four RISC-V
CPU tiles consisting of 4x SiFive X280 cores.

There is a virtual UART implemented in OpenSBI firmware that allows a
console program on the PCIe host to communicate through shared memory
with Linux running on the Blackhole card.

Link: https://github.com/tenstorrent/tt-bh-linux
Link: https://github.com/tenstorrent/opensbi/
Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Drew Fustini (8):
      dt-bindings: vendor-prefixes: Add Tenstorrent AI ULC
      dt-bindings: riscv: Add Tenstorrent Blackhole compatible
      dt-bindings: riscv: cpus: Add SiFive X280 compatible
      dt-bindings: timers: Add Tenstorrent Blackhole compatible
      dt-bindings: interrupt-controller: Add Tenstorrent Blackhole compatible
      riscv: dts: Add Tenstorrent Blackhole SoC PCIe cards
      riscv: Kconfig.socs: Add ARCH_TENSTORRENT for Tenstorrent SoCs
      riscv: defconfig: Enable Tenstorrent SoCs

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../devicetree/bindings/riscv/tenstorrent.yaml     |  28 ++++++
 .../devicetree/bindings/timer/sifive,clint.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 ++
 arch/riscv/Kconfig.socs                            |   8 ++
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/tenstorrent/Makefile           |   2 +
 arch/riscv/boot/dts/tenstorrent/blackhole-card.dts |  14 +++
 arch/riscv/boot/dts/tenstorrent/blackhole.dtsi     | 108 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 12 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/tenstorrent.yaml
 create mode 100644 arch/riscv/boot/dts/tenstorrent/Makefile
 create mode 100644 arch/riscv/boot/dts/tenstorrent/blackhole-card.dts
 create mode 100644 arch/riscv/boot/dts/tenstorrent/blackhole.dtsi

