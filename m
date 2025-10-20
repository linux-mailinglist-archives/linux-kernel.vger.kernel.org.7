Return-Path: <linux-kernel+bounces-861076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A7BF1B87
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78207189BAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196930215B;
	Mon, 20 Oct 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yjg46oik"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6A431DDB7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969185; cv=none; b=td0SzWQnW8tuKAreSna+qac/6SfRjJqtbKWO7SEJzgqMfZ/4aBGm9Ob8SNdgzzHofLquK7xBrc07BcXGWyBMnIyLpYU85eCdGQy5Y1KMIBhxJ0ZHHK5bBSyMAdwBoj21gJsfKadffj/GpRzNHSeLTkqqFCERgyHFgz9RdPhafXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969185; c=relaxed/simple;
	bh=0PWnVKIiov5KTPY8I52QIFf+vtTOPlLahNCTbyp5PPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxqsWJ2YcW6C0rbj6GPj6peWSv4j2WlrLWumdVD1W5DlLCUlJSSJ9twXhgCSDxPK3zkurRT8v2dbZBVGacYFk+rEifS/5DkQ9WwvtFxSM/C/E3qAo9tJEgKCGkVxSpC9zd5l7+04Nq6vxRORaGoZZc21SLVrwExAsrb1heHsVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yjg46oik; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=0PWnVKIiov5KTPY8I52QIFf+vtTOPlLahNCTbyp5PPc=; b=yjg46oik+aetf7YnXtGPN0VGZ+
	h6il6ri2MY+hGDwuUdoRtlH6a+lMGLhy+KKASiNd5f+d4eXgAGmpH5DzpCK3H3fUnn9kOn48pO7Yx
	DcXyqKHBiVBaP1IxNrF0uJdY+bKNpGIItjOP2532bhdJGK9mMlxKSB788qk/4zcBwWynXX9Nk08kq
	yJz7qVWrv5mej8Ng/DjvWKg/NAk+o+v5V4LuF7nPr54Pxc+Bn5e1YZG348I20YaCoGtJtGK++4CwQ
	+9M3DaTuZESlxpHh93EkfvIbF1RJb3TFNeDBBCXN0gLf1m9SD50o6rf293TDiBkaN3g+s3Q4HxKUn
	L3Xkl8YA==;
Received: from [212.111.240.218] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAqWc-00020A-7K; Mon, 20 Oct 2025 16:06:14 +0200
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
 Re: [PATCH v2 7/9] phy: rockchip: phy-rockchip-inno-hdmi: convert from
 round_rate() to determine_rate()
Date: Mon, 20 Oct 2025 16:06:13 +0200
Message-ID: <13870920.uLZWGnKmhe@phil>
In-Reply-To: <20250810-phy-clk-round-rate-v2-7-9162470bb9f2@redhat.com>
References:
 <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-7-9162470bb9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 11. August 2025, 00:45:35 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Brian Masney:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>



