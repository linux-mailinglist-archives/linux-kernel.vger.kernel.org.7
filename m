Return-Path: <linux-kernel+bounces-745020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D3B113C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A2E1CE528F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823524677B;
	Thu, 24 Jul 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvPFB0vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0E23F40E;
	Thu, 24 Jul 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395369; cv=none; b=glyG6UxjIfNBD/I/+51pQQ9sz9qIWgd/LPMyyBDb4HgAizB9t26KgOnuRiylkxxteU4RsMRrz91GytcG67lhv8/qH64aW/v5xhb8fF0ygX/n9qW5vpay0b7AAA6DZazUjFynABfYIVy3uFXY7xZW88Xcvt3chUKWSxuekWxti0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395369; c=relaxed/simple;
	bh=SpVetdFsSyXnn6b8ojWdDyu7cAVOzViuBAf4H4DsFJw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=cbeMm9MTUdFK7iJ/d5LhMd4xV4iABF+pcsoTPBHWnd4iHodQvLf5X9paLuULuNUbBsOp8I1GVwiGP+FTZoRVLwSV3IH8ADwvGTOXQ1vxG35UttIejZJ5sfefyxetNnExbs176E5cRt9GGtAJITVv4tQZHVNUw3NT8yaTlRhqKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvPFB0vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18DEC4CEED;
	Thu, 24 Jul 2025 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395368;
	bh=SpVetdFsSyXnn6b8ojWdDyu7cAVOzViuBAf4H4DsFJw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FvPFB0vlD9sI30fE0J2iUFVqzaYllyWbIhmLwuZ3olE5NJl5zfpkfGx7KU+PRdzbN
	 VBgAjfxhCiSIpgORjMk9JA1Gv0Jyowf2FctfXdG4EEVee9jrgYy2cmE34RmM60if2D
	 041BPvXM1+dQwTcaBoud0tlZ+auXvFluoEEFGuNeioQPDgbKkpnTkRYn4C+8bQMO4p
	 7AT+MHkdTlxeghLgs0RC0pozS8BSgNpt5aySw4hmZmyZS6p2A/qSfr8ev7vb+wv7/P
	 V3PfSSKbQJE7qMUzwIx7LDgcSHOhBt0ljYYw+x6xjYw44ZeEO2AJFk6T4CnXAyO6bC
	 +6I4DWUCoZZag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-3-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-3-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 03/13] clk: imx: busy: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:16:08 -0700
Message-ID: <175339536800.3513.2964091155762156167@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:35)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> The change to call busy->div_ops->determine_rate() instead of
> busy->div_ops->round_rate() was done by hand.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

