Return-Path: <linux-kernel+bounces-826248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C4B8DFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119577A8F05
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6A246764;
	Sun, 21 Sep 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbDmoYfU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F26FC3;
	Sun, 21 Sep 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472260; cv=none; b=AAuf0Gz1aHkxEs+ateKeEVFt2Ln7KxNCDG9TSSPOR88tDeaoLzMwFV7Zdp5DPFPAdYEdBFauAPYiqHRrbsGf7Y+UG9VKBkjK9k63RSMD+t0LFXIxpCxEgS+lha16oBWw8z5I1zWpP9pcvoPpfd75hK2aOp6jpnR2WaMOM9gzH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472260; c=relaxed/simple;
	bh=T13PpfofiomlNgg6/ltRzK/T/BI06+Nnoby+OscX+ss=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=IDzAeqHVwtqh8LXx+YtOTIWKz+CFnJrQzlhA/KEUe4ivrScLWqxzRQUHkYinXsGdGG05ba+03rWIUsw08Qq4wB5CTX4bdriik/NM6k+67W4KlAhbl/+EyUVABRlNbwWOe7VqJm5HlOegtaGxLDueQC2Kn/gfKF/xmGMJ5dD9ipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbDmoYfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A6BC4CEE7;
	Sun, 21 Sep 2025 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758472260;
	bh=T13PpfofiomlNgg6/ltRzK/T/BI06+Nnoby+OscX+ss=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=gbDmoYfUOjUvEQRhREN2Rt8FcPLK6s8LsMM6YYLQhRR7JJUtCnSQbjSblIIVtERI7
	 7g2csSK4a3b5r4tu48i9HubMn0GH8GT4IqBucX879MowRdiGBZ1gWIDvEX9VZshXJe
	 9EP4qyX4EvGqAG1o2tjTpC82fXoeCOhroEP9UX6F3usSUJLIRw9IXZHxC226ifyUZ8
	 sN2A2vUQn6EvZsZxYgd14iQGwGdlgrL7Xq4ESgoYoi/N9l8/2wGu30/1jQT93AXFgT
	 hvHGSwpFTOeQqudqIbj53A8X2QirFkgFbKxPzxPSH4CpiyHxXJ2jnsyP+G/81K72c4
	 zc6Xr+kWop6jw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZyRIy22aS_Yjoavg@pidgin.makrotopia.org>
References: <ZyRIy22aS_Yjoavg@pidgin.makrotopia.org>
Subject: Re: [PATCH] clk: mediatek: mt7988-infracfg: SPI0 clocks are not critical
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Sam Shih <sam.shih@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Sun, 21 Sep 2025 09:30:58 -0700
Message-ID: <175847225898.4354.5439045355673574414@lazor>
User-Agent: alot/0.11

Quoting Daniel Golle (2024-10-31 20:19:39)
> SPI0 clocks have wrongly been marked as critical while, probably due
> to the SPI driver not requesting them. This can (and should) be addressed
> in device tree instead.
> Remove CLK_IS_CRITICAL flag from clocks related to SPI0.
>=20
> Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Please resend this if it is still applicable.

