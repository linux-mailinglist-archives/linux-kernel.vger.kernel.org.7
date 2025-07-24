Return-Path: <linux-kernel+bounces-745010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B02B113B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CE91896DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B223BF91;
	Thu, 24 Jul 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E66zGOvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484623BCF1;
	Thu, 24 Jul 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395327; cv=none; b=fgkbWy39XBCA8jX1yS0lFgmwjVp3X78W8hkVQpoZ0XTBAcIfNETFoVdaJY88DJ+JmDwXfwEc/huGBptv+9syWMWStjg7/+1Q/wHcivd6tL+O4XTISeAicmtrVMTzLONoVA3jeaT2jJqGGKq7kCxF/o5C+vo1qWEIVdW8PCxLUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395327; c=relaxed/simple;
	bh=grSCuiAwDCBeCFH+68Z8byC7gM3bxL4Cu93vNJLHf8w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mp9wYmFrWSYxsMl59+28UK/DKZ3ZwYe1Ogid1/QOU2Dp3E8OeK4wWikwb/+dYTf1fA9z1N9Dcq0CN4apTeePP7QmV0WntbBx65LQ3ZiScMrhx3bIsWQX7VMxFxldKH195Wj8WhO+IHPLc4bT860RsnKjdgfHi6DYtHcVLZHH02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E66zGOvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666DEC4CEED;
	Thu, 24 Jul 2025 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395326;
	bh=grSCuiAwDCBeCFH+68Z8byC7gM3bxL4Cu93vNJLHf8w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=E66zGOvbXj5RU5mFjLO7+U5lA78MW2mEnLgq4Yw10ocYgTS9wWCaT5qcComr+19ca
	 moKsRzn4JTOUmxti3xQ42p3YtHr+01g4y8gfg2RJcsN52svsajtgN90h3wBSls8GPW
	 7HL3BHdnI9arfRP+sXSiQ8SLIQzflf5l7kEfnbsozcwjyS76YO2KQqIX5KRqEK4y/0
	 UYCVaYrr3/uzzmpf5rdnmG6VyGj4ubuDBboQ7ILH/HK5yaqaRdF/pta+ooCSJf92zB
	 7n71Gs4+X+M2tbji+lOShk7cM2F7U0ZRnJY5G/jvxJqjJ/2STLXPoRkjOvqjEYRYDQ
	 MAbAd2ix4Y+Eg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-13-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-13-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 13/13] clk: imx: scu: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:24 -0700
Message-ID: <175339532491.3513.6017087056878306040@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:45)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> This driver also implements both the determine_rate() and round_rate()
> clk ops, and the round_rate() clk ops is deprecated. When both are
> defined, clk_core_determine_round_nolock() from the clk core will only
> use the determine_rate() clk ops, so let's remove the round_rate() clk
> ops since it's unused.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

