Return-Path: <linux-kernel+bounces-815381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6FB5638F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02691B24522
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075672BDC25;
	Sat, 13 Sep 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKeJR7NN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F927F724;
	Sat, 13 Sep 2025 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801441; cv=none; b=idx0XzXA5c1uoUdZVj32eNOeD8/y5zX+CXd1+i8X8Fov/lRXbAUUxXpx+IZ4KV+GVJ1LsuIiXz6S1cOWHF58vE+fFsDwkHTVM5wpJg5xAl4o0r/ZneW+BZ3CtkKl6mmYBg4H1mmWDtBHhjoEHLmaNp81teqRJZEN8WqX5FDYNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801441; c=relaxed/simple;
	bh=i0bogOX/tsV96N7qxN1qW4aceR3AWq7X8gaP0+oii1w=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=KDhfazZGINMdAPlfa5AmuDFT8PcdWMz9YbqYPykSWaB9m23iKU+zCyVoIZONPlSeWXYX7acbzQT1GeCoxLJkWq0U6tC1kvL/ebrNu6+KH1vGug0qNl3DXi4p5Fxob0p+HS/LbvkqL61p205Li00mTiLuSIi0MyiAw14BjlLZXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKeJR7NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE1C4CEEB;
	Sat, 13 Sep 2025 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757801441;
	bh=i0bogOX/tsV96N7qxN1qW4aceR3AWq7X8gaP0+oii1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TKeJR7NN5+6GM7hgg+l7XOkW5kO9YlHTfypEzelJcP2u/m3HIy4n66/vDoUhL2rqa
	 Lq3x1Q6bM2AaOMeLZwl8smilcoX/gMGV+8hBc/pw0hxwXAktv3EBJrs0pf6opfzGBl
	 hDq7VB9fM2WLFtWdI/2h8jySg3JhfxyyoiWBzwPuBavyzQw/Se80sJNCQWOTi9dGoB
	 qZctxBjOxjzJv2VHirrDqK1VLxxPfIUeOg3JwvWOA/1a/bEmpt9hEn8UUH03H+LNX1
	 LNwtXjw5riMs4Tn4jNK7VJC/bNXYIiC5zsuXcxbVgEx89d0N7jpu8iEjJgWfTQf1kw
	 eMS9bBmSwdzQQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aL8MXYrR5uoBa4cB@x1>
References: <aL8MXYrR5uoBa4cB@x1>
Subject: Re: [GIT PULL] clk: convert drivers from deprecated round_rate() to determine_rate() for v6.18
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
To: Brian Masney <bmasney@redhat.com>, Michael Turquette <mturquette@baylibre.com>
Date: Sat, 13 Sep 2025 15:10:40 -0700
Message-ID: <175780144026.4354.7838864408360305570@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-09-08 10:03:25)
> Hi Stephen and Michael,
>=20
> Given the large number of patches that I have posted for the
> round_rate() to determine_rate() conversion, and to avoid spamming
> large numbers of people's inboxes where a v2 was needed on only a few
> patches in a series with 114 patches, I submitted a v2 for only the
> patches that needed it. Additionally, some of the other patches in the
> large series have already been picked up by some of the clk
> submaintainers, so should be excluded as well. This makes it more
> complicated to merge everything, so I collected the most recent
> versions of the conversion work for drivers/clk using the following b4
> commands:
>=20
>     MAILDIR=3D$(mktemp -d)
>     b4 am -o "${MAILDIR}" --cherry-pick 1-1,3-3,5-8 \
>             20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com
>     b4 am -o "${MAILDIR}" \
>             --cherry-pick 1-37,39-47,52-63,65-67,69-89,91-91,94-94,96-96,=
100-111,114-114 \
>             20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.=
com
>     b4 am -o "${MAILDIR}" \
>             20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com
>     b4 am -o "${MAILDIR}" \
>             20250811-b4-clk-ti-round-rate-v1-0-cc0840594a49@redhat.com
>     b4 am -o "${MAILDIR}" \
>             20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com
>    =20
>     git am "${MAILDIR}"/20250828_bmasney_clk_convert_drivers_from_depreca=
ted_round_rate_to_determine_rate.mbx
>     git am "${MAILDIR}"/20250811_bmasney_clk_convert_drivers_from_depreca=
ted_round_rate_to_determine_rate.mbx
>     git am "${MAILDIR}"/v2_20250903_bmasney_clk_tegra_convert_from_clk_ro=
und_rate_to_determine_rate.mbx
>     git am "${MAILDIR}"/20250811_bmasney_clk_ti_convert_from_clk_round_ra=
te_to_determine_rate.mbx
>     git am "${MAILDIR}"/v2_20250827_bmasney_clk_scmi_migrate_round_rate_t=
o_determine_rate.mbx
>=20
> Additionally I included the patch series for drivers/clk/ti and
> drivers/clk/tegra since this is all related work.
>=20
> Note the v2 clk/tegra series that I posted mistakenly had extra Link
> tags added when I posted them to the mailinglist. I dropped the Link
> tag for these commits so that those tags don't appear in the git history
> in Linus's tree.
>=20
>=20
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>=20
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/masneyb/linux tags/clk-round-rate-6.18
>=20
> for you to fetch changes up to 80cb2b6edd8368f7e1e8bf2f66aabf57aa7de4b7:
>=20
>   clk: scmi: migrate round_rate() to determine_rate() (2025-09-08 12:50:5=
6 -0400)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

