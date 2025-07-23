Return-Path: <linux-kernel+bounces-741667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15342B0E775
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CD0547A90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26688139E;
	Wed, 23 Jul 2025 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVj8/JYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A9184;
	Wed, 23 Jul 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229229; cv=none; b=FYog+76wDr4a/dReX+hs6DQKD5Rc8X9oiOHboGoVbrirNdhclWJjhYKCoU8wzbNVu2ZcJcxw7uvUmBx1F4MHjjClIHCt1/PW4YnO9n8CWndXYYnHX2Jk0LfaSNMBB7K4F1p4Nr4prKfI1QMlIo/nG0mgZQZVYCyCoQOq3eU6lYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229229; c=relaxed/simple;
	bh=T1uMkldXB60o/GHBIhUkrUgZ400UoTd0hvAVPNTV9ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfD/axMyzCp63TrK47lNOk7bow8eP+5x2+oNWZoUCIP4BT5G6IEYCReA8unFjri5u7MSfEfVnxTCBWOU0zTezpT/1a4qwgV7XnuYvUwagdkRUOyBjvjQbsla5FQMvnc7jV/p7YF/wh+6E/C6HBMXQQhRTavZAzWeV5vVfgl52Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVj8/JYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C438DC4CEEB;
	Wed, 23 Jul 2025 00:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753229228;
	bh=T1uMkldXB60o/GHBIhUkrUgZ400UoTd0hvAVPNTV9ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVj8/JYZUEDetgHxhIHVqgIK0ZRtqkmctDXvOOHBi7tCxiclLISeODTJ4LvOiJsEw
	 mFH5c2MlJXA1THON4u2Or7reHLvLQqFW5oZa3MtGNaDvtMwQH4y1wbooVj2fy8TeKS
	 bCpnfKPasQpjB+K3jgJhIvozcDXDs+r48J1+FuCrI856C3wtwydwPIbzRW1nclcfOB
	 xVYnmWe7CBuYdM1yCdduVD1qwjH3PfXycg2pu88nET9VKfen+tqcdyWXXqbHMoQWj1
	 9E0s3szUZwu6huiwCd+Dfjq4RkFhP10qObqmWAyoWhpRHxXkb6VOoEGxp8yiMl7TB+
	 SEyYyDRXe8gaA==
Date: Tue, 22 Jul 2025 17:07:07 -0700
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: thead: th1520-ap: Describe mux clocks with
 clk_mux
Message-ID: <aIAnq5jWARhj8XuO@x1>
References: <20250722080535.60027-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722080535.60027-2-ziyao@disroot.org>

On Tue, Jul 22, 2025 at 08:05:36AM +0000, Yao Zi wrote:
> Mux clocks are now described with a customized ccu_mux structure
> consisting of ccu_internal and ccu_common substructures, and registered
> later with devm_clk_hw_register_mux_parent_data_table(). As this helper
> always allocates a new clk_hw structure, it's extremely hard to use mux
> clocks as parents statically by clk_hw pointers, since CCF has no
> knowledge about the clk_hw structure embedded in ccu_mux.
> 
> This scheme already causes issues for clock c910, which takes a mux
> clock, c910-i0, as a possible parent. With mainline U-Boot that
> reparents c910 to c910-i0 at boottime, c910 is considered as an orphan
> by CCF.
> 
> This patch refactors handling of mux clocks, embeds a clk_mux structure
> in ccu_mux directly. Instead of calling devm_clk_hw_register_mux_*(),
> we could register mux clocks on our own without allocating any new
> clk_hw pointer, fixing c910 clock's issue.
> 
> Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
> 
> This replaces the second patch in v2 of series "Fix orphan clocks in
> clk-th1520-ap driver".
> 
> Note that the c910's issue cannot be reproduced with vendor U-Boot,
> which always reparents c910 to its second parent, cpu-pll1. Another way
> to confirm the bug is to examine
> /sys/kernel/debug/clk/c910/clk_possible_parents, which obviously doesn't
> match c910's definition. There's another patch[1] explaining and fixing
> the issue that the unknown parent isn't shown as "(missing)" in debugfs.

Reviewed-by: Drew Fustini <dfustini@kernel.org>

Thank you for refactoring the c910_i0 parent fix without using strings
in the parent data.

Before: 

==> /sys/kernel/debug/clk/c910/clk_possible_parents <==
osc_24m cpu-pll1

After:

==> /sys/kernel/debug/clk/c910/clk_possible_parents <==
c910-i0 cpu-pll1

The system still boots okay without clk_ignore_unused and peripherals
like serial, emmc and ethernet are functional.

Thanks,
Drew

