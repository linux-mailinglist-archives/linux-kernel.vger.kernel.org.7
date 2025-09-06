Return-Path: <linux-kernel+bounces-804430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67FB476CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125F07C6DA5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45D285C96;
	Sat,  6 Sep 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijb25Xr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E2B1A0728;
	Sat,  6 Sep 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185977; cv=none; b=YD7HwT8+qUb8mcHjIORD93hmfJ17dLWdOHx9Sf8bchCnDy0u1Ifl3ceCtij/mm1WSSnM4QammgtFQxiaMo1HwKrlbzrHKqV7eEbMNKTCyQpYnoKOKB8pMKiKoHd0ZNVF/irQZU+2NxZvR//EmJ/Rk7l9TXv4T/yu1YWlvRC6GU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185977; c=relaxed/simple;
	bh=QHY0+QhCJ0gde/ktx4tvJbgsXT6QCzobFLcyaTfoVhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=reY13wWCDMw9dg+2Rl8XQffwBstyEXM9f0dgxtqLlSHdvAljxw9PejaSR1HARX8oHglKJIyazgsQv+Lyoq89KVFUPxsU2lKhafbGaMj0oS1ao99sC3EllKbMsN/WFc2AmEmNZW89aX65TjjhklplvruHowPAtWgjRT8k6Rb/4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijb25Xr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF72C4CEE7;
	Sat,  6 Sep 2025 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757185976;
	bh=QHY0+QhCJ0gde/ktx4tvJbgsXT6QCzobFLcyaTfoVhI=;
	h=Date:From:To:Cc:Subject:From;
	b=Ijb25Xr3nxmCzkM9SHloRJmes2F0WpNk+nFMs4keCuthT9bvUq0ck8ODZMQMiB0Gp
	 O2ZPVAccI4xifo71rjyV0SGo9y9UUOEV+Ev3EbxQo4+5+1mGLIpkfl3GBEGLRR/o4M
	 +ga2xcx9X8Zoiiq9P1CqPQEuaKZ2rPppFCSDeU3Na7eWTmlw1dVxGjDSZ3ssfUDfbO
	 iiGfCaPzZgRLdVHz2W5b4QZ1vl/F9R5Ke8vmdiQqbe3cxjBCVBM0bOgO54uPP2gz7Z
	 dWoXEnd1JntsOhkU9wZQy1JO82CP9bsg7NDqaCyd7ZKxQNCCYbaq4D/rt2cdNzR//5
	 CBWRnKYpzkPMg==
Date: Sat, 6 Sep 2025 12:12:55 -0700
From: Drew Fustini <fustini@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Icenowy Zheng <uwu@icenowy.me>
Subject: [GIT PULL] clk: thead: Updates for v6.18
Message-ID: <aLyHtxrU4mGFfnFs@x1>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-clk-for-v6.18

for you to fetch changes up to c567bc5fc68c4388c00e11fc65fd14fe86b52070:

  clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL (2025-08-18 14:58:23 -0700)

----------------------------------------------------------------
T-HEAD clock changes for v6.18

Updates for the T-HEAD TH1520 clock controller:

 - Describe gate clocks with clk_gate so that clock gates can be clock
   parents. This is similar to the mux clock refactor in 54edba916e29
   ("clk: thead: th1520-ap: Describe mux clocks with clk_mux").

 - Add support for enabling/disabling PLLs. Some PLLs are put into a
   disabled state by the bootloader, and clock driver now has the
   ability to enable them.

 - Set all AXI clocks to CLK_IS_CRITICAL. The AXI crossbar of TH1520 has
   no proper timeout handling, which means gating AXI clocks can easily
   lead to bus timeout and hang the system. All these clock gates are
   ungated by default on system reset.

 - Convert all current CLK_IGNORE_UNUSED usage to CLK_IS_CRITICAL to
   prevent unwanted clock gating.

 - Fix parent of padctrl0 clock, fix parent of DPU pixel clocks and
   support changing DPU pixel clock rate.

All changes have been tested in linux-next.

Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Icenowy Zheng (5):
      clk: thead: th1520-ap: describe gate clocks with clk_gate
      clk: thead: th1520-ap: fix parent of padctrl0 clock
      clk: thead: add support for enabling/disabling PLLs
      clk: thead: support changing DPU pixel clock rate
      clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL

Michal Wilczynski (1):
      clk: thead: Correct parent for DPU pixel clocks

 drivers/clk/thead/clk-th1520-ap.c | 503 ++++++++++++++++++++++----------------
 1 file changed, 292 insertions(+), 211 deletions(-)

