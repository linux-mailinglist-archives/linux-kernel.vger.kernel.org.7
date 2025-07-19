Return-Path: <linux-kernel+bounces-737686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF8B0AF58
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601FD3A777F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B1237176;
	Sat, 19 Jul 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW2XSfk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E0148838;
	Sat, 19 Jul 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921252; cv=none; b=pDFDxG7mbOlLzwzBuYqpRpGygt6ppsoXUWduL7iEmk+dN+cXah+5TUKm53RxFvL0AyHZQI3RaoPx4Bdt7nNjIydCC6O51euWCdarXYtLX4Z1CfZ5XjRS5GI2MYpFfZcJjelnj5qZYEPXa9hiTZ6YhHWIYatUVk2qJvO6ZC9x6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921252; c=relaxed/simple;
	bh=UxCO5WPTUXNu3CRP7Qky80cDRDWVGcte2oC0s342bx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=USZP+DUQXcGcFE1JYmeoqFLbRb2c7/R2ZOXQJUjjUCQsE9M9LtU7HJdnIP/DPWKVCWwVhKyT6GmlRm3MfjJG/NyhlEheTlP07t0bCgopGoaux7GBxwwmgZ70hM9Vv7NhlcV209l2A3F53IdaqYWpWyKmRdJuFxcrLxjadpKgw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW2XSfk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375DFC4CEE3;
	Sat, 19 Jul 2025 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752921252;
	bh=UxCO5WPTUXNu3CRP7Qky80cDRDWVGcte2oC0s342bx8=;
	h=Date:From:To:Cc:Subject:From;
	b=LW2XSfk2ypjEbdHplGvhJ+qFSlOBP+EyDPeHIyb9OXAwXWBLE3TjWz3htKKcbXjqL
	 7PsLfFsWUd7EtNMQvLE8kebe2MMlcIuInI5UA6SyuOelr1Kn7MnTRlaq/aXTAoa4X4
	 SUrG7Rw3Z4fX1QduaRx3JN94B3jxBwiOaSXVEBiHuURR6MN3Egn62yraXDZB0VwkAN
	 PK2KqKt3G9j4OIrmUHXCiP3YQoz+KPPrVt3KgRuK2F2XzCSFTM/RMo5aryOdHCz3ON
	 mXZs22XGNc3o6qosbeHlWGiy/bZETfh8WyuZR3FBgx+vHBr9ysXmzqmTN0YG0pHnez
	 nXIEwqx+UOR2g==
Date: Sat, 19 Jul 2025 03:34:10 -0700
From: Drew Fustini <fustini@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [GIT PULL] clk: thead: Updates for v6.17
Message-ID: <aHt0ojYyO1OEZTmG@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git tags/thead-clk-for-v6.17

for you to fetch changes up to d274c77ffa202b70ad01d579f33b73b4de123375:

  clk: thead: th1520-ap: Correctly refer the parent of osc_12m (2025-07-13 12:46:58 -0700)

----------------------------------------------------------------
T-HEAD clock changes for v6.17

Updates for the T-HEAD TH1520 clock controller:

 - Fix the parent data for osc_12m by referencing osc_24m by index.
 - Mark essential bus clocks as CLK_IGNORE_UNUSED to fix boot hang
   associated with the PVT sensor.

All changes have tested in linux-next.

Signed-off-by: Drew Fustini <fustini@kernel.org>

----------------------------------------------------------------
Michal Wilczynski (1):
      clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED

Yao Zi (1):
      clk: thead: th1520-ap: Correctly refer the parent of osc_12m

 drivers/clk/thead/clk-th1520-ap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

