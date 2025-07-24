Return-Path: <linux-kernel+bounces-745011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F59B113B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87F416EAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369623C8AE;
	Thu, 24 Jul 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQZAl9tr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF623BD13;
	Thu, 24 Jul 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395331; cv=none; b=SKgjmy+4aPyBYy5f+tbIUoO2TPRjoe+6PjOb9jjWiy4g0ZDY2FivO39JTUgLu/WTjrIzg2o2VQEr69B8a6izS5N14I8fmns+xh9wEgl2k0gnJ+3tlgfoxJyWAf9fWzIUjwXsuV85gDQyJLkgstGLEp++tPyA6saGtGrlYjFJL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395331; c=relaxed/simple;
	bh=b5wwNSYnHQz8rEHHzayMJYGIkaZ7ofYJ9ZKDth5/Vjc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qhFnI9uqYbFCxyu1k/3h4Tcdzpa//PUaBnpYK22VbplsRb3g4BGTZ3yTILInfsG5oKRoWt00RVUIzMc6bIqnsZRbVE2OCd80OVOYdH3kDQozJDPHhFWDCltH2RPlkmVFSFJw9kgppt11onwPsM/SfH6/WsWMeuFhaTdwwwgG3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQZAl9tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A2BC4CEED;
	Thu, 24 Jul 2025 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395331;
	bh=b5wwNSYnHQz8rEHHzayMJYGIkaZ7ofYJ9ZKDth5/Vjc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vQZAl9trsVv+h51rkUNIy6NbD5mwpTfNRSHgTNjNJ9Jii7ET9Np2KJCuRvqyL9z2i
	 xGcbT0bkh+SWkKxIh19TbFGCwyxpXO4TuGMVMGvYtAngvoEcFog8wX0ONZsbPgv8ke
	 RBCOwWIMBB7IChNhh/2dm7AIdEgc6Eo026WHApa3E8paAKinzFxdktXSXgIs1etdkQ
	 tMs91P3bULBMEJXQ9sQuW+Ijl/073lMf3EeUJ7zeOxRYYvq8XWtX4S60eMk9BUu6Mj
	 BR7Oea+ynJjrVManJ6+joZ8TWLyd8JzURUIgiDJgb5cuvYumj4MIpxhEsff6Z27hv5
	 Xg83Xs1Das1xA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-12-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-12-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 12/13] clk: imx: pllv4: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:30 -0700
Message-ID: <175339533054.3513.1721914103224553281@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:44)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

