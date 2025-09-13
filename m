Return-Path: <linux-kernel+bounces-815377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED44DB56387
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C976B4805B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B32BD037;
	Sat, 13 Sep 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We1IPP37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F42BD012;
	Sat, 13 Sep 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801158; cv=none; b=Lfws99LjO3gxdlZ2Cg70E3WTj0Sz62brMbx009/9uGUFHYk1QhzAmp5/9zbsDAyQyE+97tPU+CPGecZBFH8xuwE8tO0FQPOYXR83TOVi91XxIirle8HhdyW9Hf0x3lrJ3EaQyA6sDd/l0dM5Vl1pl86J31LVVRGAVMbpLahZWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801158; c=relaxed/simple;
	bh=fuRN9sDs6dXkvQ77eK0VxpVXR3WpUFozkEd78OmmtIQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JFY8NsnP4UjnrCaVd23ON2KvXcz7hyjP84nvnRcwHakgllHcsRvNUemqNZvkDGHeSpbI9koQFJlqG4wIp5+MpiR8d6X56I6EiWzisx29gJpBJecig74DLZZ9F6JWH/AGUlJFFdVx28u6JxOv2X2rsMYN5Grtcevja2me2byAvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We1IPP37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5BFC4CEEB;
	Sat, 13 Sep 2025 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757801157;
	bh=fuRN9sDs6dXkvQ77eK0VxpVXR3WpUFozkEd78OmmtIQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=We1IPP37ACpr4Dzx9imqWs8RBtMbfJ0aPIIGonYxVnzzE0YoY9L0wvLxb3n15N/x0
	 1XcXEBJsUxH5WKPJy01d7yms75Ra2pMC5Dr6uP4TfknhyeHUE5CS7P7bw54Gg3RSWu
	 Ss76ZOnuaIDAWi6mYM4BU4XV2AyCKbr5MWIb1Y9fRknSfGNTX13kuz5Gki9BSrbEZe
	 /VUBhc/Vrh9KMlEIzk02idGYtkf9BEisHOF//lRdLCZcR2G9K15h7ZpYMVXiKbwb3b
	 PZTduFEp88X7F7W41WWYyigrL8i1JVg5esTBm0m+F9nKhCeHuC7iCY/JoQVAsaJXYR
	 cufAiI7N0YKtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250909171321-GYC7803064@gentoo.org>
References: <20250909171321-GYC7803064@gentoo.org>
Subject: Re: [GIT PULL] clk: spacemit: Updates for v6.18
From: Stephen Boyd <sboyd@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, Michael Turquette <mturquette@baylibre.com>, Brian Masney <bmasney@redhat.com>, Alex Elder <elder@riscstar.com>, linux-clk@vger.kernel.org, spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
To: Yixun Lan <dlan@gentoo.org>
Date: Sat, 13 Sep 2025 15:05:56 -0700
Message-ID: <175780115692.4354.14857999848718953911@lazor>
User-Agent: alot/0.11

Quoting Yixun Lan (2025-09-09 02:15:03)
> Hi Stephen,
>=20
>    Please pull SpacemiT's clock changes for v6.18
>=20
> Yixun Lan
>=20
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>=20
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/spacemit-com/linux tags/spacemit-clk-for-6.18-1
>=20
> for you to fetch changes up to d02c71cba7bba453d233a49497412ddbf2d44871:
>=20
>   clk: spacemit: ccu_pll: convert from round_rate() to determine_rate() (=
2025-08-26 06:07:45 +0800)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into to clk-next

