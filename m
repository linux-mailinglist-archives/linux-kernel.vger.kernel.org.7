Return-Path: <linux-kernel+bounces-745016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D9B113BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F374A1CE0CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE92242D99;
	Thu, 24 Jul 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sutqiJ5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6223C8A4;
	Thu, 24 Jul 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395353; cv=none; b=ZkRsCFlOPD4wPchT1sAlc+wLZNHLn9yXCj7W7S+jVu9P8xn3E7yey9uvtZXVvDUKcBdeFp/+NjlvpHBVYkY93Ku8WcV5jkwC6O1yxs06G761VuZfgJhMFoUQ/fRV8fDp66nX6/dFfbsavMMe5lwvRGDZ4RDJtUJt/h4IaAvwTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395353; c=relaxed/simple;
	bh=dyokUYnl8CKaFjexISqdf0G9hN9FT6Cf16Ntp39yhv8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=PMYHJhnmr4XNpimulJjHnc6PO64avJ0ry2Vg8CKT7PNGlvD6K8Nm2pyW269gIQ3Y/yFrukr2XVHi0OY3RGlEXReU/OzcE1ZXC0tldZozn7ValnNbhgpffScYHSNKuRsOyLvUgU86Jy8uorVzQpuVFU3s5TGY6krqLsZgHYnlnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sutqiJ5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468AAC4CEED;
	Thu, 24 Jul 2025 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395353;
	bh=dyokUYnl8CKaFjexISqdf0G9hN9FT6Cf16Ntp39yhv8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sutqiJ5va9YL1LUU1w5BpmwOl6/x+caKzjToqK0jpJPNALHmY/7QLagape3x4ebYN
	 aFlv/JaA5WPN1otMrPERhUqGmi37AHLnZa5v8ePiCvBuk8GSzgzCLsGFDJYqYkFhdG
	 +aVoHLtYq8olyh/5XKrOXTiErQcngh5RdBK2QO+x6Dx4TFTtQ5ceLGOI12Zjh0qZ92
	 n3Zr1zC+HT2tGYMladkbSMuoQIWNkxxnqcRDT9hmbFOHs1hOSqkE4h3A/3fdgOegmz
	 +F+qCeQfyVsJsz8H0Bc21yd2c8P3IouOXGMWO9qYvAgQJ+gNAlDTOq9NN141VdM+1/
	 NCn5ePWYjb3Mg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-7-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-7-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 07/13] clk: imx: frac-pll: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:52 -0700
Message-ID: <175339535262.3513.17348643975736777580@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:39)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

