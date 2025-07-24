Return-Path: <linux-kernel+bounces-745014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D598B113BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736C87BAAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBF2417DE;
	Thu, 24 Jul 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNccOgOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382923C4F3;
	Thu, 24 Jul 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395346; cv=none; b=Z335iHk7pEv1DW06hazWcrMHWUinRBtdLLlOAifBg6hos2y3MW2Xf9vnq+GV37EmNrhFmWou9J/6LuThv3bbTwdJX9n+Oe7mDGn+Bxp/6ECjiI1v3zSrlBHCeDgLm40AXGd/17fnZya9RxqCAjT6UOODB7JdRxPC3xb1dTWk5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395346; c=relaxed/simple;
	bh=Otn8nzbO29X9b9QOTmDaE+I0bCuBf0fjEQ4FVCl8lEM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ulympN/64XebVA+rW02AIfnI7gd4t5mueMizu0NVCJae22kqrbP0euj5XQN4vHud2keti8Sg4iXdPl3L8/3hIhjnC3iaf4bESSKyamRmb13xJxq4aQ6WhI0J3dWgncvK68dePH3Rwf7T5SnrgnYYRcBko7P6ZRfY6RJy8qsBxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNccOgOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA0C4CEED;
	Thu, 24 Jul 2025 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395344;
	bh=Otn8nzbO29X9b9QOTmDaE+I0bCuBf0fjEQ4FVCl8lEM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rNccOgOlmhDnelDafBSd/9xAWCa9L32GTg2hHW1nk3wvZoIN3+Q+8W1P5xD0N0drw
	 Ap7PM5rQddEw52PhVzv+nTU97qRSm0XaKeo868upFZJiRBZXfkuo0rELLYhozt+m+S
	 Twfkmceghi6Qjzo+aTAxsiIAIm8rQVCsplS/3R18QShbeiP1rKITKqUpjp8Ta7duzP
	 IZy98HdNMjOzIjXNsW/fjssOZvbYINBsJE9zi9yvy++VeM/lwouK9IqDNo/6JoZIez
	 uZ6TZeG/4Awcio9YIx+imCpQRgGclOv2dfl4Qaip5or4UNTxmJzlq5U/rZOYG21P8J
	 +ue6dB9zpW0JA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-9-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-9-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 09/13] clk: imx: pll14xx: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:43 -0700
Message-ID: <175339534376.3513.2033168620689843824@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:41)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

