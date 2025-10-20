Return-Path: <linux-kernel+bounces-861078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F269BF1B93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688C81897F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7883195FC;
	Mon, 20 Oct 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UjckIrLk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B2320A0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969206; cv=none; b=RHqxVkRds9IfbATN+CEHRCZHP6pgbwTSonyk/RN5c/Fl7JCIHZcxBhsoRIoausmR6nO4Lf2GEW8m9TzG57W4crGIFmSoM7piGcBvyj+oM/NWepWwRZW2EnLMznyPYwJXPGUscte/aEyRmp5T7ADo0aP9MB0ko3qQUR1D9JFGRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969206; c=relaxed/simple;
	bh=Pflb5s+SJUFaJBxo0UKXFW7gXNOuL5Iw15aBc9AITb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgJ5ALbllNWqiRELKtziNEexk8OyrKiZNJQRDHwV1zpjkVW9ZkwEaiDKFnpVqZwxZeghc3msNaYUnKtEh7D0YO9CfRp8pbBn0oYk0z+cPvxFVGNjPrd8sBWBVHJzEWv9fO5V4eOI1G4WGn2yony1ItYI3hMLnKXiVnR19XeQEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UjckIrLk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Pflb5s+SJUFaJBxo0UKXFW7gXNOuL5Iw15aBc9AITb8=; b=UjckIrLksIfw9rYYkmWqAmVSIo
	rTyZFqdvbheIOnWfSV5jlPjiq6ydD7k2N5zlbS0qQUjsW2xRr0jbxdOHnkBQBLaA8ZQZeaZJb4/eb
	YjiTSWuWIktubek2jlZm4KVyKM8/19QqCvzBrjmuQ8wJxJRvWwhXOejTzMKidvGBAqx2XrEQNdc2q
	+sQhtx5Eqo0g+Cav2OtV6IE4oTlEXW6HgFJusgH3SsrU5oglwCMVaavJZN6alTbkRx6BVc+vuu+8U
	6pIF+QMIDgUwrJqyZZqHV1GWzDQ4ZwJHVjsD1nguzj1m33Elbf/feRQP1hNIRcXwAFOcDPYLGWdMD
	jAWH3zmA==;
Received: from [212.111.240.218] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAqX0-000213-GG; Mon, 20 Oct 2025 16:06:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Brian Masney <bmasney@redhat.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Brian Masney <bmasney@redhat.com>
Subject:
 Re: [PATCH v2 8/9] phy: rockchip: phy-rockchip-samsung-hdptx: convert from
 round_rate() to determine_rate()
Date: Mon, 20 Oct 2025 16:06:37 +0200
Message-ID: <3378525.aeNJFYEL58@phil>
In-Reply-To: <20250810-phy-clk-round-rate-v2-8-9162470bb9f2@redhat.com>
References:
 <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-8-9162470bb9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 11. August 2025, 00:45:36 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Brian Masney:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>



