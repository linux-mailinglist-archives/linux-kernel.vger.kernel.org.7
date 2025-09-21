Return-Path: <linux-kernel+bounces-826250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB2B8DFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B92A17B416
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5A23D7EA;
	Sun, 21 Sep 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw7LW1px"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAF1B043C;
	Sun, 21 Sep 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472342; cv=none; b=AXMhpPh8AhwMd5nP0aZ/QAONztMAjEXF5YK3dsJh7Uxm+zKrTSgRUYPmFqGWxoRHW+mzBP6vtzZ2sODzStRkvHtzX4F3jMgCgU4pd29oYC2Lc1V2lVGxfLcsDugntiZZ9DlkGms0C0mUTQ5bwtzzlqe8s7Z8L9esjKszI2/63bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472342; c=relaxed/simple;
	bh=o7JjWeGGQ0v2Ko7Mo+dsmnbg30iUAUCIfFBaMDWT9tI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hzBkvtH1xOjpPi4gHSuHxJ27ze3ZNjh9TpYuUHk17StdVW9+5SAsIMLc2AurLoCBi1VR6//n2MHkS4SgsAswaxngM7FppCJpK41oLCE3QCVTx/SN2MIvtlVNdyfk2luDqxRsEkdS8+0pQoy7oqONfnBeX1taGACni4Rvyu2j+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw7LW1px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6B3C4CEE7;
	Sun, 21 Sep 2025 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758472341;
	bh=o7JjWeGGQ0v2Ko7Mo+dsmnbg30iUAUCIfFBaMDWT9tI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Fw7LW1pxhtXvGuUHilZObl9bVqfPchGMZ5D9O+9gd3EGObtzu6tbPo6AS4/v5jkcm
	 78W9R64ypCztgI+hyLs3RflqmOwAvrZIm3RLFTVpqO/EmPlU/tUxswP7zTYxNpSrvP
	 olBxJh96aFPPA79Ls+9D9Koj4T2fz8jRr6d7HiCPnJBtXX2sJ62B6D6ve/DDGQQGc/
	 43P/cPWmVq0NotjAovVZ9AkqeDSSkKwSQzgum2JVHO2C1yElIMdUMyya7TEjQrPDtV
	 CNXelg8ahOBWZa1ASarh2P9hOr7EhH7PmuKs1Z48JaLe839tzoY7IQvgp/cGvCtRNs
	 J8+rkL6HDTV5Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
References: <20250724083907.61313-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: mt7622: Add AFE_MRGIF clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, mturquette@baylibre.com, geert+renesas@glider.be, u.kleine-koenig@baylibre.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, robh@kernel.org
Date: Sun, 21 Sep 2025 09:32:19 -0700
Message-ID: <175847233984.4354.5445163873849956727@lazor>
User-Agent: alot/0.11

Quoting AngeloGioacchino Del Regno (2025-07-24 01:39:05)
> Add the missing AFE Merge Interface clock to MT7622 to make use of
> it in the audio subsystem.
>=20
> While at it, also remove the useless CLK_AUDIO_NR_CLK definition.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

