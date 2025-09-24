Return-Path: <linux-kernel+bounces-830325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2CB9967D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D78819C58A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705C2DE6F9;
	Wed, 24 Sep 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PF3IuZuW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D612DCF73;
	Wed, 24 Sep 2025 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709259; cv=none; b=Pa/Kkgry8N5ISPwu19wnRdGeCAEic0vBtl24j4bFsHi2UhIUaQcdNBfwk61zCgU3LDdbefETCqo1uvcsxsbSyclizPLKtPFcWGd9qnMufJsfgrnH+vbBMfD1SnMcDMJdZPk4KppaF+dXR06dYUL+a9smnsWxRhgUXm41Bju2nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709259; c=relaxed/simple;
	bh=Gb7PLFsKmlEYtoQ+aSKKrwMrUf84Ic9+Nei/2tc1Lxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ar3Katetkf/wgmABfhSnR4mxATDSbzGU/tVHolknkXGdmzTSNEetc4igJ78uW+VcLvpy06JtWsxWqqF6uHMFf6+lF6w5SDuJ40F7uzg87A5KpHxebW0eMHpbH2bI6it33yyvjtlMq2sAkvWVpLoir7WDetNWzpCJlIoDyrvc3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PF3IuZuW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758709252;
	bh=Gb7PLFsKmlEYtoQ+aSKKrwMrUf84Ic9+Nei/2tc1Lxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PF3IuZuW5KjDpZZnwN7rak4k2wlBmhb3VPhdsEay7moWOSeooNtZ4NPu3lTZctsiV
	 bdf+jiRSVT+9ESuC4nzb36pg6sNIH4aSajXTTDWvKfv72/uzA91rqXtWIPSK8tM/n3
	 IE0dnzApRzsUQznDaludnVVfwARWDTpPAcJZSwduUwobSYljpkX0O5rVWsvBqpldGi
	 HYYVpko0B/4hBiCsoLkji/aT+MWkS6XsAITgkYSgJuUPQb8j19DPd/6/w8iYBv9Z9M
	 Ym0a0OxraPSziLhT2wXQNk4u58EKDse5j+HiC83paBNuRfGbY0bclNi38EOZGqbBkQ
	 lFbDUlAnuMD6w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B34717E124A;
	Wed, 24 Sep 2025 12:20:51 +0200 (CEST)
Message-ID: <76a5e9ee-b8b3-4f7f-9410-9133263358bf@collabora.com>
Date: Wed, 24 Sep 2025 12:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: en7523: Add reset-controller support for
 EN7523 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924094112.1918444-3-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250924094112.1918444-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/25 11:41, Mikhail Kshevetskiy ha scritto:
> Introduce reset API support to EN7523 clock driver. EN7523 uses the
> same reset logic as EN7581, so just reuse existing code. The patch
> renames:
>   * en7581_rst_ofs to en75xx_rst_ofs,
>   * en7581_reset_register() to en75xx_reset_register()
> because they are not en7581 specific.

You ignored all of my comments (sent at v1) on this patch.

Regards,
Angelo

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---

