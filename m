Return-Path: <linux-kernel+bounces-826470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59ECB8E9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80DD18993A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E325229C;
	Sun, 21 Sep 2025 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dUv2jddi"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8329A1;
	Sun, 21 Sep 2025 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498956; cv=none; b=Hqid5EOWrIp2SGRdY594YOyA31jKrGp2Vpl6Dn0oBseVFtfcd+j7AGYMB3QkkkjCzHg++0JeWaUOEzTupkTWEF7tdEz9awLEywWNTXTTKk7Wgbeh2e+sdCAFfeMizdmJpUJWVNbO7uICPsnHaJqETnv7iOAOt4ZGRu3s78UeLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498956; c=relaxed/simple;
	bh=G5zDmYfHlGUKAXlip7xI/PIKkRJuPWRKz/ZJBtpZ3GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh/E4y5NTlhUjPcWnKnMucgsho3gVJpfbMp6U6FBbtQ+Kt5VBaoknN0jmwdV2u89kSWYNsI79VhyeVhbbOfSdCdgoHcAVsob7teItRbMB4m8vLRqpJj8jmO7UBp/VVE+L9v0qTkbe+oOoXbnNN/wqoPb+/OFlpba4f4awUzQQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dUv2jddi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 017C625770;
	Mon, 22 Sep 2025 01:55:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PseRyeRPgRIP; Mon, 22 Sep 2025 01:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758498945; bh=G5zDmYfHlGUKAXlip7xI/PIKkRJuPWRKz/ZJBtpZ3GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUv2jddiWZTUN8kyIaW++P6X4MuyrQGyTjCC2Btb8KZAUCbxfnZfiLKzD28I8RPg0
	 ftP7uBkBg1pP0bz2tNe/wMMjRyPURfoRz04Eh7AXeEP6Q/DVPVlKa7w4TXz7jgXnTG
	 w63KOdI5Py7di1axh3wUtHDFJis8u7XBwBmoNyadYVogJtvyvj2sgO8p8XgXIw2yIo
	 1dRayEZ4t8oPJPEwRnOYSwpLGh4w8vAcYDpKFC0pwHmoKFjsYr+nkY4Y8hYgMRLnuk
	 rwOdSPbw525Cupa/ezj2yrZPfliBd6sjEilzj2FAlM56SNXTo5OqVw5n7N9Ys5blj0
	 HXBMHp1wYRlJQ==
Date: Sun, 21 Sep 2025 23:55:31 +0000
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Avoid DT fetch in possible_parent_show if clk_hw is
 provided
Message-ID: <aNCQc4_TuJ4CJg_n@pie>
References: <20250705095816.29480-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705095816.29480-2-ziyao@disroot.org>

On Sat, Jul 05, 2025 at 09:58:17AM +0000, Yao Zi wrote:
> When showing a parent for which clk_core_get_parent_by_index fails, we
> may try using the parent's global name or the local name. If this fails
> either, the parent clock's clock-output-names is fetched through
> DT-index.
> 
> struct clk_hw pointer takes precedence with DT-index when registering
> clocks, thus most drivers only zero the index member of struct
> clk_parent_data when providing the parent through struct clk_hw pointer.
> If the pointer cannot resovle to a clock, clk_core_get_parent_by_index
> will fail as well, in which case possible_parent_show will fetch the
> parent's clock-output-names property, treat the unintended, zeroed index
> as valid, and yield a misleading name if the clock controller does come
> with a clocks property.
> 
> Let's add an extra check against the struct clk_hw pointer, and only
> perform the DT-index-based fetch if it isn't provided.
> 
> Fixes: 2d156b78ce8f ("clk: Fix debugfs clk_possible_parents for clks without parent string names")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> 
> This was found when fixing the wrong parent description of
> clk-th1520-ap.c[1]. Without the patch,
> 
> 	# cat /sys/kernel/debug/clk/c910/clk_possible_parents
> 	osc_24m cpu-pll1
> 
> The first parent should be c910-i0, provided by an unresolvable struct
> clk_hw pointer. osc_24m is the first (and only) parent specified in
> devicetree for the clock controller. With the patch,
> 
> 	# cat /sys/kernel/debug/clk/c910/clk_possible_parents
> 	(missing) cpu-pll1
> 
> [1]: https://lore.kernel.org/linux-riscv/20250705052028.24611-1-ziyao@disroot.org/

Hi Stephen and Michael,

Is this patch applicable for CCF? Thanks for your time and review.

Best regards,
Yao Zi

