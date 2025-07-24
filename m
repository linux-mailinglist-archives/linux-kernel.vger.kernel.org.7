Return-Path: <linux-kernel+bounces-745019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21EB113CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC995AA3BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277412459DC;
	Thu, 24 Jul 2025 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1F0mBUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238623E342;
	Thu, 24 Jul 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395365; cv=none; b=YjPhXHJzH0uKfcvJX0hvWVK3CIk5KzPmsDF1lSj58qzSqJRQwdM9Ca7E8/sZG6WTs2y2KdC9KMQOsGZhLF69dwmS4frWBB/o/3YGhK47r+qRKqa1JdsMXgBqhQcFvbPVXT5Bqm1bE1XWT8ZVqJnkDPOqS1c9LhGNKpxJ5Gij++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395365; c=relaxed/simple;
	bh=M6BKurNGI48HNi/DpysGBcT/yGh6myOqXQArZ7Fvyls=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=G6es6puw8G7bLjyl4JwV6GQh3C8GCnAM6NJIhcci7BOb+pGN7kS70BBU2ZLlsaM16sJ0nzB17VdJqwoRKeCKLnpedImpSsKETi4pyw0nr/sZAAbew4PKVmWFJkW8vcqLztrCjVPnHHC4SJ7aqP3r5C0b6XQVLldm11CZHwCC8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1F0mBUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC5CC4CEED;
	Thu, 24 Jul 2025 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395365;
	bh=M6BKurNGI48HNi/DpysGBcT/yGh6myOqXQArZ7Fvyls=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=d1F0mBUyw+cVAirPzfSnUo/Fej1VOADI9otww8ivZmQPlcP55qcD42IkVPBGgZehX
	 xabLhf3UKmqHOd5V3SMgwDmiV3ArWrPPeVSEPX5FUbljfurj0DbwGNMkLlirYmoJAi
	 ys42AyZXhGohqr//0qHxnubf16Xvz/elWu52GuDxpQPkjyNlIMSw3OpqlMY+zbLspm
	 xsYvKFS8XG9Azto4F9//LMiCLRBBlHFr/0SXWhFt9ujV5Qk5qjXHKG5ruk5WC3YV5Z
	 9NCNB27v4KKfTKKeT5bxmx4lyxAJZnEZwW2mzaitrVl9/hnrbxTcrUU7nc30nZJtfC
	 cattaiZ+lKG/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-4-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-4-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 04/13] clk: imx: cpu: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:16:04 -0700
Message-ID: <175339536426.3513.280133875163880352@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:36)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

