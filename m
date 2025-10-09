Return-Path: <linux-kernel+bounces-846407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA9BC7EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702AF18880C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BE2D1F61;
	Thu,  9 Oct 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HraFy0Jq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564A2D192B;
	Thu,  9 Oct 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996872; cv=none; b=mR7wXMannuDuyiHmQzT5R6f/9kQ+8HPWpJFD+Xqmr3nya9Zs6vMNBxHNvuBC7BSC6b1N35xEqXDJyVWnCqqfe8QpIPnW73S5eflyg6FmgvnqYwokCYuhRr3AsukIj76aEp7zU9c2Qef3QrYATlzmdHPfdJOonOqacoYLyLm64U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996872; c=relaxed/simple;
	bh=DqlFY+zfg6KeRhIUsiMUfsKdx6WZau+HnPPKOGqJT/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DojvTMwoCyOZ03Ll6Y8iZ9qX54MDNJD4W/RI67GB1SE4iWwQsLMZfoS5NQ2+aGk6nN3JYfi21JYhqhGDptAgN0sLpgdF1Zwax16S6bUnyvBrm5O4wV7iYVXR7nUs8rXTxzrHvsttnq25rRgKLWrjhUP9jQfCJA9SkSvGseZ4hMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HraFy0Jq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759996867;
	bh=DqlFY+zfg6KeRhIUsiMUfsKdx6WZau+HnPPKOGqJT/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HraFy0Jq12QWJzCAJx0MZgvEv+7d0nrcabfSHjL/SqWVQ7Epcrobd0lWV6FM2IQmR
	 Huivx/Eu6nvWBbFkTSVrdBEdCznxgZc5ySyA8bwxQnZpm0ZvuAEljijPVma2jEHg/B
	 7v+myiidksIx+pA1rXWr2KX/EvyiObJQxQLtzAKYcw9k5sDuL9Odu8q19GBjavKefC
	 kHXbKVM9rlSgBD2/8oO9VKPBjni7r9phgpNVc/JVaY2ew+dIVL4cvpjFYHwlboWY1K
	 337eRRqWiJlrzRbI0KqhipLMlDzgAUfzt6yZhBE8PB453ST4A55RiSbhPfZAKIwujC
	 yXxWwIvI1tJ5Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49AD217E0CF8;
	Thu,  9 Oct 2025 10:01:07 +0200 (CEST)
Message-ID: <602158eb-472c-4443-9dda-aadf2a6c9f6d@collabora.com>
Date: Thu, 9 Oct 2025 10:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] clk: Respect CLK_OPS_PARENT_ENABLE during recalc
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-1-170ed0698560@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008-mtk-pll-rpm-v2-1-170ed0698560@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> When CLK_OPS_PARENT_ENABLE was introduced, it guarded various clock
> operations, such as setting the rate or switching parents. However,
> another operation that can and often does touch actual hardware state is
> recalc_rate, which may also be affected by such a dependency.
> 
> Add parent enables/disables where the recalc_rate op is called directly.
> 
> Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
> Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



