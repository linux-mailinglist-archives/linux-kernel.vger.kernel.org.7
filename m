Return-Path: <linux-kernel+bounces-745013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31BFB113B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0603BDB74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A194123BF96;
	Thu, 24 Jul 2025 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQdHgvYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDC23BF9F;
	Thu, 24 Jul 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395341; cv=none; b=gRz194GeRmXs3PWfHaDO7qQxt8vDj7c1u2XaVGm6pFosBCqiZD41EkZR6vrmRa/CPh9N2YNTRf5jM2vwPDfxbE1GMktvXZrjXa2HXtvEQkecbU4ZlDbVrVhd4c3HqjHt7rG9DEBJzzo4NuekKiBL36vI1A/1L7seKDIbzmMAqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395341; c=relaxed/simple;
	bh=U8UCpGinEEx38TrWd/CPG0HIJt78xJ7Fz9XFgRVUUTc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mb1VTjU4bO2BjXva9TBGt1Dc5UB+8hzh6Z6yBeA9uSvN8CZ0oOOwsYzPF6Ys4gVRRZUVqael05BTirynb5lip4hp+2kADrM+OwfMiYOtyFnmEj2DmWE0sMdmLREKeDJF+ukM3Jw1+YiHqeZ1cxEP21F3br9jnYDG+4dXIaqpGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQdHgvYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7187CC4CEED;
	Thu, 24 Jul 2025 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395340;
	bh=U8UCpGinEEx38TrWd/CPG0HIJt78xJ7Fz9XFgRVUUTc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bQdHgvYzoO7NHFgBWiDmYg0SNxj1OsHhlEBZea4BLgu8E2QHkVIzOvpajBVVC1Jbl
	 AjKfs9GwmpdKIUgMC2WgdaqzXklkNKKTDKHZPyKBCN8HFKozr7VPnE2po+sXYcH0Ew
	 YV32oyt3886w8CVtmHmHwjcgm6ShJjj56KW6L8nlW1VqmlsM2XmUsGkMsMKy6Rk4Xx
	 D4OUf/Wb5vkg4fDiEmMhHLMn1H5WKEpIyLS/2tNCEz+h+DC3/c48A0RE0Q1eCvzxb0
	 NxO5i7QXelu37Q6CNpV0YBnTDV0OoDaN4iDm3CRSlAhBi2FtqHkIN/+D+hVR+o+rWc
	 yuT6kxOhZxNFg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-10-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-10-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 10/13] clk: imx: pllv2: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:39 -0700
Message-ID: <175339533958.3513.5105460189010715284@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:42)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

