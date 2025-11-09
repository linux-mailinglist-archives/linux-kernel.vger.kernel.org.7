Return-Path: <linux-kernel+bounces-892073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0AC4449D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9DD04E3B9E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995C2D3A96;
	Sun,  9 Nov 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzcRUXNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1C2147E6;
	Sun,  9 Nov 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709760; cv=none; b=PzyMKla6HpyY3B7uglsOm0VqIzylqVSXHffM1BhLupJcIbJ306HNl5zsyRLMujg3S2NBbK1RY5GyTt2NaqfljSuxAz8qWACrs8nJu29ZSu6tF9QJi90WMchQ3Ta0Hjw9rTa2pHmMtngIVJfd8tjPbTgNLPWfmKzI/HBGQJi2TtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709760; c=relaxed/simple;
	bh=VeXIMFby4++o7k2a7+34n+EeWMLXw+AohCFf3biSWHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjxjINZXPRMdM0WUzh+G2ge2hh0dZtflyPqKKOTuTVSJmL0SHIe7qtJwMLVwhesxM7wVRt8a8nAhDah7/iuYyA76NN/qCumBpIb+jWwMzEYeIkgDvtdlCppBDjNM/vSqqPZyuyS74xRwqzs/jq+xVYwCVo4cyUdNEzBJeG5C6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzcRUXNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE07C16AAE;
	Sun,  9 Nov 2025 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762709759;
	bh=VeXIMFby4++o7k2a7+34n+EeWMLXw+AohCFf3biSWHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzcRUXNT9/f1tDKe4T6F42zpttJ/aX9MBiZ0jM74+dveROq+XbwX3UtiMCATmeKTf
	 pjIXycds0QVgTvGCxyvIZsP4VATkS9eUX5UIEl0DHKGQhP6x9aRQORyAaRUMcpuD7y
	 ymjXrKjvsPZV/l8CjSLfxXAGJ/3k1EXYUZR+EHFeM0nzpKdDlZ8Hcm0QED+Wd4p1XY
	 UdYW5sG8XF3PsxYz1WECWTZWMIvVHok7/eH6feKhJNQ/bTwZrsE1SSVvjpus/BxHsl
	 6MCMvLVfDQKMBSCjN2+mmAFDMbF5WiaTpPkInR3dcTYqhXlnvyJUdltoiZfs4E0JoW
	 TW4t8VSHrHxQQ==
Date: Sun, 9 Nov 2025 09:35:58 -0800
From: Drew Fustini <fustini@kernel.org>
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V T-HEAD Devicetrees for v6.19
Message-ID: <aRDQ/sam60PIc557@x1>
References: <aRDFOnmcW6GIJ6bt@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRDFOnmcW6GIJ6bt@x1>

On Sun, Nov 09, 2025 at 08:45:46AM -0800, Drew Fustini wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-dt-for-v6.19
> 
> for you to fetch changes up to d8a174babf649346b6dad6784ae1e9bc8417af71:
> 
>   riscv: dts: thead: Add reset controllers of more subsystems for TH1520 (2025-10-31 10:17:11 +0000)
> 
> ----------------------------------------------------------------
> T-HEAD Devicetrees for v6.19
> 
> Add PWM controlled fan and it's associated thermal management for the
> Lichee Pi 4A board.
> 
> Enable additional ISA extenstions supported by the T-Head C910 cores:
> Zfh, Ziccrse, XTheadvector.
> 
> Add reset controllers of more TH1520 subsystems: AP, AO, DSP, MISC, VI.
> 
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> 
> ----------------------------------------------------------------
> Han Gao (3):
>       riscv: dts: thead: add xtheadvector to the th1520 devicetree
>       riscv: dts: thead: add ziccrse for th1520
>       riscv: dts: thead: add zfh for th1520
> 
> Michal Wilczynski (2):
>       riscv: dts: thead: Add PWM controller node
>       riscv: dts: thead: Add PWM fan and thermal control
> 
> Yao Zi (1):
>       riscv: dts: thead: Add reset controllers of more subsystems for TH1520
> 
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi             | 72 ++++++++++++++++++++---
>  2 files changed, 131 insertions(+), 8 deletions(-)

I forgot to cc mailing lists...

+linux-riscv +devicetree +linux-kernel

Thanks,
Drew

