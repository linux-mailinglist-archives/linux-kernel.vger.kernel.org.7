Return-Path: <linux-kernel+bounces-745017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA68B113C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512435A3888
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16636244668;
	Thu, 24 Jul 2025 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXqetHVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B223BCFF;
	Thu, 24 Jul 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395357; cv=none; b=Q32y936uNIKN9w4lIy8Xe4km4kgczkjWMgLnq2kltDja2FMwpIMvzJPPdm1TE4hy0isQsPEo8vNEm5UADU3pX+C9XTG9br+XS6OliNCb+Ddi9y0sGc/kjg8zbsI6SVoEFvDEdPp4/XBrWe6az+a5kEzMGm//G+Nrt6+xO661mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395357; c=relaxed/simple;
	bh=U2oOEbdJekGXI3A9rV0u8aK5n45P2xwaK+3iBiwkQKI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=PVY6lJS22FOJbmmqYjiaxgODvZIL0b88SKb9d98ujWRJKcqVrOyptsvT7CMV546A2IUF2VKBgtvfqUtx4i9V9C0jspsjoXsjq184IhSBmyPP7XDOjx39a8EYWAIYyAFBD4XOIYo7b1SxNsBtAOzBb4p3FSyLx3J3Gq7cjVyv+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXqetHVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0010CC4CEED;
	Thu, 24 Jul 2025 22:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395357;
	bh=U2oOEbdJekGXI3A9rV0u8aK5n45P2xwaK+3iBiwkQKI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fXqetHVFnvsdrucU3xwpLibN8E4/WY9IYuRC7pMDOPqUvmkWA5BY0gkY5WFR83AC6
	 V9HpZjUwfksxTxjyFwPbVg2xwErQDyRa4tcfEDmoUw/3ng7dLN2SrG+H31dELbuN+i
	 ulZCv0kwBPXfNrGTLdqSbwvh32is89Y1CyjK8pMIhjp89uVDVf1Yvb4aNA6xDwpZRQ
	 36q4tid9lsoohItNALMf0rKqp8TbApiMpv0Pv1nDTmfOrnf4PjUy2fMIktyycV6T7j
	 7Vn+tNWfgFAb5j6gOtFtLVvLKP0Ozg8b30sB/sJWhxqcZYwkl4jRBwhe+bmrI8QjK7
	 KUlBR7mmDY3JQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-clk-imx-round-rate-v1-6-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com> <20250710-clk-imx-round-rate-v1-6-5726f98e6d8d@redhat.com>
Subject: Re: [PATCH 06/13] clk: imx: fracn-gppll: convert from round_rate() to determine_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Brian Masney <bmasney@redhat.com>, Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 15:15:56 -0700
Message-ID: <175339535635.3513.16202959951085662157@lazor>
User-Agent: alot/0.11

Quoting Brian Masney (2025-07-10 14:10:38)
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied to clk-next

