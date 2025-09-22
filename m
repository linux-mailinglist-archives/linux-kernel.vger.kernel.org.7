Return-Path: <linux-kernel+bounces-827096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6565B904C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6EB17A393
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFB2F1FD6;
	Mon, 22 Sep 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K3A1IcUS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF291B808;
	Mon, 22 Sep 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539154; cv=none; b=PjWAg+E6lFy8ZDxCfrOL2V/QdVGG3JWj3j4wlYbatJbDWE524uWNaACw03yLJf+ZZ+lU0Qxht29T+Jh/b6h5cIXxJ1qEI/q2MqvsuOyJvRqZtrIwR4S7apAv4L3u2fcKD8nxxa8nagr/cKC6taN7oCkaNbV7+qCip8WLYKeW4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539154; c=relaxed/simple;
	bh=R4tlWJgzes/Y4DKi4qcXXpLirntdDRaHq2QxnEkO0WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duVgiidZjugGEE/XHijP43GAPSVi/vR2A/JUohxlQjYsaQhOYGq0F17cSNZnUoYWBmJeHiisny9ciUAmpZsKokyGLqt/++ZUkxIaLXIcnV9W78aboZp6c6Gk1qKBzRw0TEhfgOxirQ/0qONzkql499NMS5SzoN7ULZaDcEkvwp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K3A1IcUS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758539151;
	bh=R4tlWJgzes/Y4DKi4qcXXpLirntdDRaHq2QxnEkO0WI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3A1IcUS1C5LiZIFZkICC+3I+uhRd2Cudsmvef2QmWxJO3L+1ZokRE0lFf82kKr2G
	 qMluh0T5op0YcZ9KAZ+oAMQpwxGTAqXwfIiU3Fcbq9+6X6xVxhAeayQsyE0ajcFpSF
	 0PvrwtfkyU6ZFXDYxHCOK92w4EpZjCQar3nK/6XzvzFtQGVpcBhaM7w6UNj912elWv
	 arwFBKwPCvUF9xlkKy7wS6p9SGaKSkMDjMdy8bf4vLNbH9vCJonQICrSjPCdC73Qkk
	 BqxfRVgbPebd85Vu9utTqJygdc4IbZ6fnM46A+JQ3QkT8PzugjWzGL4WVPXT7FPo69
	 MVqQLhk3iy4vQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3E5417E0125;
	Mon, 22 Sep 2025 13:05:50 +0200 (CEST)
Message-ID: <6657bfa7-9a6e-49a1-890f-81cf655940a7@collabora.com>
Date: Mon, 22 Sep 2025 13:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] ARM: Add support for yarisxl mt6582 board
To: cristian_ci@protonmail.com, Matthias Brugger <matthias.bgg@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/09/25 20:23, Cristian Cozzolino via B4 Relay ha scritto:
> This series adds support for Alcatel Pop C7 (OT-7041D) smartphone
> board, named yarisxl, based on MT6582 SoC. It also includes some
> preliminary patches. More in detail:
> - patches 1 and 2 add support for mt6582 to platform code
>    (verified by looking at generic mt6582 downstream source code)
> - patches 3-6 do some maintenance work to mt6582.dtsi
>    (I was unsure if squashing timer node patches into one)
> - patches 7 and 8 add devicetree and dt-bindings support for yarisxl
> 

That's simply great! Nice cleanup and nice addition - the only thing I can say here
is that seeing simple-framebuffer is a pity, and that I hope that your plans are to
continue with systimer, clocks, spi, i2c, apdma, mediatek-drm components, etc :-)

In the meanwhile, for the whole series

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Keep up the good work!

Cheers,
Angelo

> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
> Cristian Cozzolino (10):
>        ARM: mediatek: add board_dt_compat entry for the MT6582 SoC
>        ARM: mediatek: add MT6582 smp bring up code
>        ARM: dts: mediatek: mt6582: move MMIO devices under soc node
>        ARM: dts: mediatek: mt6582: sort nodes and properties
>        ARM: dts: mediatek: mt6582: remove compatible property from root node
>        ARM: dts: mediatek: mt6582: add mt6582 compatible to timer
>        ARM: dts: mediatek: mt6582: add clock-names property to uart nodes
>        ARM: dts: mediatek: mt6582: add enable-method property to cpus
>        dt-bindings: arm: mediatek: Add MT6582 yarisxl
>        ARM: dts: mediatek: add basic support for Alcatel yarisxl board
> 
>   .../devicetree/bindings/arm/mediatek.yaml          |   1 +
>   arch/arm/boot/dts/mediatek/Makefile                |   1 +
>   .../boot/dts/mediatek/mt6582-alcatel-yarisxl.dts   |  61 +++++++++
>   arch/arm/boot/dts/mediatek/mt6582.dtsi             | 142 +++++++++++----------
>   arch/arm/mach-mediatek/Kconfig                     |   4 +
>   arch/arm/mach-mediatek/mediatek.c                  |   1 +
>   arch/arm/mach-mediatek/platsmp.c                   |   1 +
>   7 files changed, 142 insertions(+), 69 deletions(-)
> ---
> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
> change-id: 20250920-mt6582-9339d7fceb34
> 
> Best regards,



