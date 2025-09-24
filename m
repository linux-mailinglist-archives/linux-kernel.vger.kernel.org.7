Return-Path: <linux-kernel+bounces-830399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A32DB998DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C78162A72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4CF2E4257;
	Wed, 24 Sep 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bG3AFDyi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9F2DE6F9;
	Wed, 24 Sep 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712368; cv=none; b=QJ+eXj848JWdE+GXs/RhS8pJCl5227G+jmlUA2HJSr/+4KU5121Ft3SzOJ4bXdy9wSBoOFAEqwXFV7plSsmq724fVFSjz4QbwZIJVAa1vhrm6pX9exlAfdEidyysxmE25RNpftP9XN56snZlanopobdHBJpobwu0Hg2GnD3S5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712368; c=relaxed/simple;
	bh=StyC/ixgTVj+aRseOXWVLm4tngSxQFzQsmw3OnQb6/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl/rrLDO4scH0uvvNurE1PCvyIQ4IHi4AHLWEq56IuMZhoD0Y6wUJbnUkohZlA0mt+zs++++IUimPv4gidpXvTFT8G49Ds4cy8CpdspxENPpiwOZuAGVZc0x7OR/TCxCQc4QyLqDSi1S+Yr6c3I/1EqXAkbyjN6BXkkb2/FTv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bG3AFDyi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758712360;
	bh=StyC/ixgTVj+aRseOXWVLm4tngSxQFzQsmw3OnQb6/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bG3AFDyiCxIWHeeIP9y3TqLPh+ah2p8jEDOEPr4JMP8G6122SPwn4qllgz38eQJbC
	 NJIAYIlQAofDbWO/z+C9wFXzc/n+Qkz9csvEEObOV59Ht73r0SZ0gbgNo0WcARmxrS
	 BFkQAdx5brvVqfNYLa27lDYaT8Fo1PAAnqwLo8qectAfa7GNCzINgQo476uUA21ruo
	 bktQadcgbpYISlRe1yFlX8D48KzLFvBTVV9xFiVElePxAIfKX2WMrYLOgMweok7fwb
	 ZcAMcaLZvNOo3QWK65EQgHSgk2w6njoqTfpeGRuZAv80eQW9xg9B0SMpmUtpDjxjAn
	 dBpx9iswOeh2g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 491C917E12C1;
	Wed, 24 Sep 2025 13:12:40 +0200 (CEST)
Message-ID: <7fef0cb3-bc8e-47b7-a8c4-28060f577d40@collabora.com>
Date: Wed, 24 Sep 2025 13:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] clk: en7523: Add reset-controller support for
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
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-3-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250924104850.1930254-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/25 12:48, Mikhail Kshevetskiy ha scritto:
> Introduce reset API support to EN7523 clock driver. EN7523 uses the
> same reset logic as EN7581, so just reuse existing code.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



