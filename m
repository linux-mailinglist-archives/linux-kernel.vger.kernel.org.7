Return-Path: <linux-kernel+bounces-769612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF563B270F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85DE5E657B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E227A11A;
	Thu, 14 Aug 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRgj/z1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D552741BC;
	Thu, 14 Aug 2025 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207692; cv=none; b=qeTgFXLEFS9BXCOCE/7TvanoSeQQZcckNA1b7+E4KMbdnb4fqBB6rjI11aFptOWQ4RYuOALRIybU/+F2MLBdia1nPjDOPwTt812qEwJ5T2V6cPQ2dnaeGxSdRL8k/c7iTfVs5gNTb7hm5KBjk6qCaHJ3S+SA1zinlCG2jFUx5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207692; c=relaxed/simple;
	bh=XpjluEZ8H5pLOiJHA7AUh9oyRFQD8PeuQTTh97tsq9U=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=KL3A12o6InMsw9oPDmHA23Tw6fr1Em2t/+UZbFb/OS073gLqFlbDAe02GTKbhJwNem3Bc2kkO7hw8jHwc46Z5binLMiSzz/wqjnbP2qw/J1kjGvQVyn7v0Tf2MEqKEe3SN35dSRUKSD6kQ5rWd9hekCFCuS7xeOuA9VEKRAiMJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRgj/z1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAE1C4CEED;
	Thu, 14 Aug 2025 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755207692;
	bh=XpjluEZ8H5pLOiJHA7AUh9oyRFQD8PeuQTTh97tsq9U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NRgj/z1cvEgJyXBQ237hZb4g68kcU39rNyObxpXybo4Toq/q88n5EitTlmb4i6fLS
	 wQXxP/rSVFSO6DVMedJOd0vj7uxiU+sOEraTqcLPA9e7QClXi63U0u4RXxZMIfoI6w
	 Vzgr/vp98hNB6N7CSRa8w/Sy5iSdhGXe/5cFBSQUFA6+Ij2uP+SziCj4Ipvvl0qwpK
	 pFEDMAX2ukLGNT7t15MdS1vvcX5+VlaP+MnCCWWtNOw07kAAj9j3w8735XNlfvwGbd
	 X3wxZyT56wXkOD4IP7530q+Bg9WHYl7bOgd/45JeK4jcbsRjwNL8iMOn6fhgGz19q6
	 vQ6epzOLMQvCA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250807072241.4190376-1-arnd@kernel.org>
References: <20250807072241.4190376-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: npcm: select CONFIG_AUXILIARY_BUS
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yixun Lan <dlan@gentoo.org>, Sven Peter <sven@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Andrea della Porta <andrea.porta@suse.com>, Robert Marko <robert.marko@sartura.hr>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Andreas Kemnade <andreas@kemnade.info>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 14 Aug 2025 14:41:31 -0700
Message-ID: <175520769182.11333.10774075645197488076@lazor>
User-Agent: alot/0.11

Quoting Arnd Bergmann (2025-08-07 00:22:37)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There are very rare randconfig builds that turn on this driver but
> don't already select CONFIG_AUXILIARY_BUS from another driver, and
> this results in a build failure:
>=20
> arm-linux-gnueabi-ld: drivers/clk/clk-npcm8xx.o: in function `npcm8xx_clo=
ck_driver_init':
> clk-npcm8xx.c:(.init.text+0x18): undefined reference to `__auxiliary_driv=
er_register'
>=20
> Select the bus here, as all other clk drivers using it do.
>=20
> Fixes: e0b255df027e ("clk: npcm8xx: add clock controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

