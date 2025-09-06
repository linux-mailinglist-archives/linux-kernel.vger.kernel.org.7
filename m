Return-Path: <linux-kernel+bounces-804431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D4B476CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132755A4114
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5F23A9A0;
	Sat,  6 Sep 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaTRfP0k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE219924D;
	Sat,  6 Sep 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186144; cv=none; b=BtE3EX1nWZwjhZuLqOBgoSJgaZQHgrQ0V6ybvoxKwsu/A4yrrVLkH6SIJg1R04ADQj+ocNzsAsPtlpC5cCZU/Fo662vDbKJGBAR089FT23fDuK7p+TrIBgnGVNmf+aVVVtGOFPsDVBi7eqcfftxhJhC6qWg6R/c7WMU/eT1BvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186144; c=relaxed/simple;
	bh=XOwKVqtcDN9k49oRYkZUzZnxSFvtc1z2zGDKWcxVwjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L4/8bbHK7u44gPLyOIUVaf+u28SzEKdm56p17m5WvzKcaspJHHSo3uCsIu7k5nmle1E0mq7GnN2uwBgxnyzc38oxJ53hjTaE+uqcro1OYjsSJT68ivvitA93ps4wE+bqY6Z5VN7TTCpe5HamM74ODlVYiwhcD369PanuGkVuJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaTRfP0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD96C4CEE7;
	Sat,  6 Sep 2025 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757186143;
	bh=XOwKVqtcDN9k49oRYkZUzZnxSFvtc1z2zGDKWcxVwjM=;
	h=Date:From:To:Cc:Subject:From;
	b=HaTRfP0kXVAUlsc6FZ3zqW7nlDOh7zgiy4DkAhm44KE91VFS0XCE9ZvNhotvxwcKv
	 Vw4AKa5gX3wKmS/s0BKSaINpc7bVFO+qbVDgm4R6JelSOuWXKevQb2h8aFUL55bSl7
	 +cZ5B04PB3nAQqwTDPC6glf8tZQKpmyJqBybjuVaG7kv7SpNwOuG/A+7uhwk6wgvJa
	 GGxmU+GO2ccDmW9KNMCDhOfUaOvBSP0mZ+l3X/2o+iWpf/O2aFX85nMBVjNEvW1FM6
	 IQyo7V/ux7ZI/vxr3UyyVtCF9yjEX5gVcWo0cYU5X4nwRIZpl1k9ynzzqgOH+oXhil
	 DrYytDbQi5uIw==
Date: Sat, 6 Sep 2025 12:15:41 -0700
From: Drew Fustini <fustini@kernel.org>
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V T-HEAD Devicetrees for v6.18
Message-ID: <aLyIXR1G9DUzwGWc@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-dt-for-v6.18

for you to fetch changes up to dfa743da83ab7ba51ec5692d5939ba1bab4b78c1:

  MAINTAINERS: Add RISC-V T-HEAD SoC patchwork (2025-09-06 11:05:03 -0700)

----------------------------------------------------------------
T-HEAD Devicetrees for v6.18

Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
the GPU using the drm/imagination driver.

By adding this node, the kernel can recognize and initialize the GPU,
providing graphics acceleration capabilities on the Lichee Pi 4A and
other boards based on the TH1520 SoC. The display controller and HDMI
output are still a work in progress.

Also included is a MAINTAINERS patch that adds an entry for the T-Head
SoC patchwork.

Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Drew Fustini (1):
      MAINTAINERS: Add RISC-V T-HEAD SoC patchwork

Michal Wilczynski (1):
      riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node

 MAINTAINERS                           |  1 +
 arch/riscv/boot/dts/thead/th1520.dtsi | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

