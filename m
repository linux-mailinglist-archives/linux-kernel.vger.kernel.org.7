Return-Path: <linux-kernel+bounces-826249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3DFB8DFC8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDC03B9776
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBE248F47;
	Sun, 21 Sep 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvU0OCkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C26FC3;
	Sun, 21 Sep 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472280; cv=none; b=BGna35IKt2KPLQNmLzGFJTNN6YtJsdcwHnwPU/0nY1lW9UdpgN64VrZ8MEDINJBOkfEwt+zMZbkz/+l3T0UlThKYjrzG+D66br/C6orNr0A5NuFFURaEMR8JnGHhpnXR1L+psYj5Wk0VVH4smX8oa4cDdEDJeoQY/JWdb+9sZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472280; c=relaxed/simple;
	bh=r12EmStA2h/gqEr0ZK7EmIPAe3qWBOe4J8t3GC3Kk1M=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=TQXO81ieNyNzO9uLc63wcOgUwws2QwCniUFit+e4tyCPLkWC2iA3MiVbsAPm2g3P8UO8N1Frq/vARsyTLiGQiNZqP/CbRRPwCs2Uwba5/y5I8DXiK9VKn7NqIjjJ6VGAXKtksrZ2aVUXqozw9GJ6y4mfNpml83QSI9Yd0Nu1/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvU0OCkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F522C4CEE7;
	Sun, 21 Sep 2025 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758472278;
	bh=r12EmStA2h/gqEr0ZK7EmIPAe3qWBOe4J8t3GC3Kk1M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WvU0OCkJQpg1y2Zu21U31mABeO9ZtSCKM0T3K+xHWc4MA7rzayLMD+oMvzZTgQXlt
	 P6m12kuW2Na3o1VqyJBnlfBAM5LMKDh6iarObGXjL9WXFiNIR5H8qBLKGv/8kwxcQD
	 rjJ84P/4HcXi8X1acREVZ0WrIiSyX6AjFRNUBtkr4fBuIuUMoMfMwZYgLjResmHx6S
	 nAuncLd5CBTZLN6zoY+fxnfxMbb4ZGkY7/TfjI6iTQqiJQJy5I7PL5kbZRixz/Wlsa
	 itp/QYxRy/CIaE2+K66G92ltpWQOPLmPhq2YmZFKPZ8a0dtMlZsqmv8YG/DdSOj1HG
	 AKSv1akYsZDpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724083828.60941-1-angelogioacchino.delregno@collabora.com>
References: <20250724083828.60941-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: mt8195-infra_ao: Fix parent for infra_ao_hdmi_26m
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, u.kleine-koenig@baylibre.com, geert+renesas@glider.be, chun-jie.chen@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Sun, 21 Sep 2025 09:31:17 -0700
Message-ID: <175847227703.4354.11700092500204446137@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2025-07-24 01:38:28)
> The infrastructure gate for the HDMI specific crystal needs the
> top_hdmi_xtal clock to be configured in order to ungate the 26m
> clock to the HDMI IP, and it wouldn't work without.
>=20
> Reparent the infra_ao_hdmi_26m clock to top_hdmi_xtal to fix that.
>=20
> Fixes: e2edf59dec0b ("clk: mediatek: Add MT8195 infrastructure clock supp=
ort")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

