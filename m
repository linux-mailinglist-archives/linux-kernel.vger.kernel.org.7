Return-Path: <linux-kernel+bounces-746985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03723B12DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D6E17C4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 06:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E71D54EE;
	Sun, 27 Jul 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWSRK1Nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45471B4F2C;
	Sun, 27 Jul 2025 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753599136; cv=none; b=h52Q0lWUeueAIzlEFXrDODRmwgkXV6uUf2IJbQp/dJho1vr5hzjVQr3cDJC3eggV2Cj6LUmSq2G4E21iAWLz7DFGf7FTSgIZUH4Qkzx6sLv6HScfsA8c6EQvMR8ZHkOjU/ZT0ss9d8QJZmmvVwkg1Q5BaxIrFTsV2FmmQ6v6A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753599136; c=relaxed/simple;
	bh=89nwfcpWhG4The5bzIvwZ2AeAhUiGyIGCu9Y2b09isU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=brYBems6lCbrZYWqiFOXMUusF4qSomXLRlMxvJFJd6qNal7MuSIW2NAZT331Z2oqgC8VD9FXF1I/nvp8ndH7rDTiDuxGURFPEUcpdqdD89K51C1o5taxwHxr2Nw5XFhftvvAGrfdHFFwjeGw2yueSGjvIuIRi3kiuP5RBYRBnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWSRK1Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E0EC4CEF4;
	Sun, 27 Jul 2025 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753599136;
	bh=89nwfcpWhG4The5bzIvwZ2AeAhUiGyIGCu9Y2b09isU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SWSRK1NwIfXiI9zTmyS8ZK9xXaK6cQvQM0oUQh5BoAoBlQn1EtkA9lWi1d7rr/b8i
	 klO3eLs1W7vf7OdFcUQzWdevZ6Adoo2/SVTKJ+3doPvXPZZ9HVHY1YvkleJcckaNwm
	 AyMiHq9/l7j0RweaJ2izT/7RWqwe7Zp7IL8wQicYNNhVVgtN2aC2rnyqLB8YHOQJef
	 WTvNrB2PBNN7F1dAz12aOCc/Kf2tHd8MC1Fg2qJqoRm0EanG92oNtPUzSpBDCBptYr
	 QyAEVciEaE/Yd3aoIT/sMI7fPfWZO/WpujmBTbtOIcwMkChk+mIu/ShyLA5+JfMc53
	 /MvxQx9Oq462w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250625054114.28273-1-shubhrajyoti.datta@amd.com>
References: <20250625054114.28273-1-shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH] clk: clocking-wizard: Fix the round rate handling for versal
From: Stephen Boyd <sboyd@kernel.org>
Cc: git@amd.com, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Jul 2025 23:52:15 -0700
Message-ID: <175359913574.3513.18062722598979944673@lazor>
User-Agent: alot/0.11

Quoting Shubhrajyoti Datta (2025-06-24 22:41:14)
> Fix the `clk_round_rate` implementation for Versal platforms by calling
> the Versal-specific divider calculation helper. The existing code used
> the generic divider routine, which results in incorrect round rate.
>=20
> Fixes: 7681f64e6404 ("clk: clocking-wizard: calculate dividers fractional=
 parts")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Applied to clk-next

