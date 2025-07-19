Return-Path: <linux-kernel+bounces-737669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299A3B0AF1E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4693B5659C1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCCB238157;
	Sat, 19 Jul 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj8ba4ld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7721D3D9;
	Sat, 19 Jul 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917956; cv=none; b=Icbfy+OMNajTwhm5wQG/lQDBx8SZzsW3rc6L2CSJGLaCVoxZyKhsd7EVTRHPtzES+rHPx4sb5TsOniX0nNTXmk4PCNZt+adP1wdRxV+9L3GmjBSG+OCFDbx93MfhMyxdIBPU975JEhyo4FIbLRLCrv4BXeaen4NoibsRxqZgIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917956; c=relaxed/simple;
	bh=Knn7NXH/voJGn5E+ykscu72HfNFmEb0KB0P1KGSgnTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eth0DIYx2k0P7KPBWuDHQ3+D8lEfQlvRkWvqTd8Z9CRrnA64IEnpPAS0ExV8h34qz9GrP1uWBI9xybZdKV+aOi8LeVl0jMYw7NIoXMZee95tcGhYMHInUL8pBGp5n91mdbS9i28XaW1xhXVlMnn/VjJBcAga2Z1nWisNxUnlk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj8ba4ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D63C4CEE3;
	Sat, 19 Jul 2025 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752917956;
	bh=Knn7NXH/voJGn5E+ykscu72HfNFmEb0KB0P1KGSgnTg=;
	h=Date:From:To:Cc:Subject:From;
	b=rj8ba4ldkynIyCoccybi/Nkzyi3UgU867je3rksRn4nJYoGfK6YvqQlH7Ya3SOPMt
	 Y2a1PhZHPQlgHG49JxtCn+Dgf+cPhnv9PmnASTnLSXApQ9ngHCOrmkRniomHxSRp+5
	 dALdS0XXSzKNlxmeAEIEJrJK8xcgNuekfP8TBTZgVpg8nSM4aCepcpBNkNlf/XoL+C
	 xBO4tk6L4afXHvvQt4O2KB+qc3jZ0KoQP7nOji0Lx+dz9cW6CPr/ZMff+LtV3viMwH
	 Y9PMipAgqfjPGUIFlwTDfignoJgFTloIESH+8bEkW0fA63x7sSHnmsMLVNP+oQTh4U
	 jQ2LLLFYDSXCA==
Date: Sat, 19 Jul 2025 02:39:14 -0700
From: Drew Fustini <fustini@kernel.org>
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V T-HEAD Devicetrees for v6.17
Message-ID: <aHtnwthmTpfkIBMr@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

Please pull these thead dts changes. I've run W=1 dtbs_check and they
have been tested in linux-next.

Thanks,
Drew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-dt-for-v6.17

for you to fetch changes up to c31f2899eab084b3557e9f9e10fc7898113ef18d:

  riscv: dts: thead: Add PVT node (2025-06-30 13:13:08 -0700)

----------------------------------------------------------------
T-HEAD Devicetrees for v6.17

There are several additions for the T-Head TH1520 SoC:

 - Add PVT node for thermal sensor which works with the existing Moortec
   MR75203 driver.
 - Add "gpu-clkgen" reset property to the AON node which allows the power
   domain driver to detect the capability to power sequence the GPU.

All of these patches have been tested in linux-next.

Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Michal Wilczynski (2):
      riscv: dts: thead: th1520: Add GPU clkgen reset to AON node
      riscv: dts: thead: Add PVT node

 arch/riscv/boot/dts/thead/th1520.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

