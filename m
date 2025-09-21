Return-Path: <linux-kernel+bounces-826361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACCBB8E4F1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01C13BC2E6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924828725A;
	Sun, 21 Sep 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft7MDVZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA32144C7;
	Sun, 21 Sep 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758485672; cv=none; b=taMSukbnVQsBM1tynYR5sGljiuHINj88JMkYT79gKmMMhmjsptlIDmQrs3qeV8gmmjnbsKsiPUj4CQ7qSbftM8JvBMxFCJm38DuX12hfm6xE16sty+F8caHhBZUsGikFHRUvBYBEEbt8FRonPX4PVpD74LNX64ZrmFQCQCzsIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758485672; c=relaxed/simple;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=JVAH6Ivf9otgBi2VpGBlPetWWhNJV7HUK6IlCBNWM0CDkO9Rx3NubAuM4XjDdQnedTl4JUM1d77JV4X5Xqdwz5sTU+coBF2QlKE5+VTT4HDURdT21H98HchtC4lUPWlQ8Tx7WJ6m9u9FZp9rZRs8DpvrZJRPkZ66lGNc4AQ+f2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft7MDVZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22780C4CEE7;
	Sun, 21 Sep 2025 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485672;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=ft7MDVZhvzwLKhSLnLGy4LeQsQqHDTT+WpQBwUZumZg35Q0aCxnefg3NgVlXMCdOz
	 aHocKJn8hvrxBJf7LdYUTlKCfjLsjYhrM8GowuDYuQtydIvjWRELRobP7nVHOIP9x8
	 rQCptIq89alfez9/H2/x1UypW/8/1yZFo7Cx3ZOltpvtgEzXvMHBfZERlM8Wmmnn8D
	 WW1uFGCTgUjNDP6gMe2L2HF6R2vPcg0QhGGM+oGevxWPs4tlTfK4kpG4fnsXeSNwMC
	 Kl8MlM7MM3VHbt7qmyXFHyGG2ncriGbvdU5iM4wnLS5nA6zdTgHPxbjDX16udYWBUP
	 huD0TIQDDNQbA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 2/3] reset: aspeed: register AST2700 reset auxiliary bus device
From: Stephen Boyd <sboyd@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:14:30 -0700
Message-ID: <175848567081.4354.110591763861485292@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:38)
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

