Return-Path: <linux-kernel+bounces-826282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F36B8E145
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063F718851E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5F223F429;
	Sun, 21 Sep 2025 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmCLZUUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BC3C1F;
	Sun, 21 Sep 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474143; cv=none; b=kg8MRZ78Zy6qP4ebtHoE8Ma7z+zPpIV835orhIujmQE+xkSKdWdi6elRaHe/RidxVuNDEKEotcTlNIdbjcPlEjMF90ss4YCGW5jRHCHJij9BB6dlO/7KraxzQ4tSy637yVKrcsmhld72EE0Wzg7gj6s5P/RKRSD1Cjb/6ui8kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474143; c=relaxed/simple;
	bh=GDIRBW2DYpqe0b8KOgrutzQSfAz/bITiNwSGWti6DSc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=MLkW4/mYqqG36GzhDlsK89U2ouAgJQ3Kfx3InA6iLxfT6FtpfG5ypn/IKSzo8iq21mtbuoE0tzoPEJ/l9UwOmXg/C1XyeqIyKBNcwaglovv/GV+Z9LfqgiRMMryga7L1RhRMZK7WSg7QSPXgcfBtrm+DS9R3aUHJr+qXvaxN22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmCLZUUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339E8C4CEE7;
	Sun, 21 Sep 2025 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758474142;
	bh=GDIRBW2DYpqe0b8KOgrutzQSfAz/bITiNwSGWti6DSc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LmCLZUUgFCdwJZMjC4yFmzfLl65O2lH3474hraDuq10F+wEc60l3nHSAUvtxw5wl+
	 pUYQHDwswuOXH0FnTcVrEJt0ETKO6vUDlWN7914SxR4/nPMCrhwWfjEjXMRR/dUJe/
	 YrFSxkr6Nd5DUOGIXd2cilXLG94uDvKoi//dbfKAMcqf9avSbPqDOXjsXoAT7S9v/p
	 uTjqS2mC5cddVHv8liiT4AZN8unWmvfIj9VzuqaJAp+l65Z1quVE39rG/vAJI0MtU5
	 CnAVlITmTgmsYALKGih+eiGWn0ha35ifMxOp0AKQQh3YGSyyr04enYprlUOgzTNY29
	 yDU/x9kZkilQw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917182150.93359-1-nicolas.ferre@microchip.com>
References: <20250916080545.9310-1-nicolas.ferre@microchip.com> <20250917182150.93359-1-nicolas.ferre@microchip.com>
Subject: Re: [GIT PULL v2] ARM: microchip: clk for 6.18 #1
From: Stephen Boyd <sboyd@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Conor Dooley <conor@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, arnd@arndb.de
To: arm@kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, nicolas.ferre@microchip.com, soc@kernel.org
Date: Sun, 21 Sep 2025 10:02:20 -0700
Message-ID: <175847414087.4354.17261652271034200852@lazor>
User-Agent: alot/0.11

Quoting nicolas.ferre@microchip.com (2025-09-17 11:21:18)
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> Dear clock maintainers,
>=20
> Here are the first clk changes for 6.18.
> I don't think they have conflict with changes for the deprecated round_ra=
te()
> to determine_rate() topic.
> In this v2, I address the issue highlighted by 0-day robot: build issue. I
> added a patch that is already included as well in an pull-request to arm-=
soc:
> https://lore.kernel.org/linux-arm-kernel/20250916150328.27015-1-nicolas.f=
erre@microchip.com/
>=20
> v1 --> v2:
> - addition of the patch "ARM: at91: pm: save and restore ACR during PLL
>   disable/enable" as the first patch of the series to avoid build error i=
f clk
>   tree is merged before arm-soc. Branch bisect-able. Exact same patch
>   in both trees.
> - a new tag (clk-microchip-6.18-2) is created and deployed for this
>   v2 pull-request
>=20
> Thanks, best regards,
>   Nicolas
>=20
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>=20
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-m=
icrochip-6.18-2
>=20
> for you to fetch changes up to 652b08afba69d5d26fe91098eb832b1bcc0f91c2:
>=20
>   ARM: at91: remove default values for PMC_PLL_ACR (2025-09-17 19:15:32 +=
0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

