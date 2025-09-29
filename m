Return-Path: <linux-kernel+bounces-836146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD33BA8DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556F51C26D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39762FB984;
	Mon, 29 Sep 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BzHnki9z"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31CC2E2DCD;
	Mon, 29 Sep 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141109; cv=none; b=SJAtci8iIkdNSQ+JrBZaAADNODS+RaolTkpaCPhciiEkhMN+4305b6ymdOaJ/TRd4w4D7Hi/zzl7u1d1dvlqi61eRMwkymb/aOwxn3R6BBp3wWs3fP/yFUCFHT4o4v76VSqyCOzeKve/TRiYDVhprN1i6Foi0iPCpuY3moBSpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141109; c=relaxed/simple;
	bh=wi1lnXpHpe4EgA9sOmOK/RWzeQOR0kl2BuZ3cxhqX4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThD0ToBnEFbZRWtR36+pPwpILY2hXOXmUgpsWCetRO574RwoTbSErBCCzkgk6QO2w8tXOkRaa1BV27rJWDVwANZ9IXF9lgpqsCyHm68N7JiTN5mCtzznrk3JWusQvgOIkhjnF1Y/Del7g4UQRwzCtq0q7milnbsPRPFbz/bNGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BzHnki9z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759141106;
	bh=wi1lnXpHpe4EgA9sOmOK/RWzeQOR0kl2BuZ3cxhqX4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzHnki9zN0xlRhHdiXxLQHiBKxHuOx61skzVpSHybCtEQSMJN4+YsT454BAL5om6j
	 KyNRHkb0SVAjaGVte2TOoxUMbGqNhxlcpKjQbSCRrpIPutkeNAh0H8AJyelvTaQH5J
	 9j5UZ3tW5DrJkQCqR5GEPSXDUYVbVCuxtakXFcZssDAHKX3K7yadGTwkmWpcxs8FoQ
	 APDx/0dWcppqTWkpkkt5FlrlbY7z4DR8M+LhG5+PXaV683J2+K0YeRIIyX2pTmgIpX
	 XbCX7uQ+Uk/GA8w+ocvTJmrkmwQJDZYAZmOCRgtOdRJnwEILlQzGRRVShxBurJny7/
	 ZvOOY0kNJzcLA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A123A17E0125;
	Mon, 29 Sep 2025 12:18:25 +0200 (CEST)
Message-ID: <70917563-3df1-4fbb-a602-2f3ecd20239f@collabora.com>
Date: Mon, 29 Sep 2025 12:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: base: Add of_get_next_child_with_prefix() stub
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250925195720.2200088-1-helgaas@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250925195720.2200088-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/25 21:56, Bjorn Helgaas ha scritto:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()") added
> of_get_next_child_with_prefix() but did not add a stub for the !CONFIG_OF
> case.
> 
> Add a of_get_next_child_with_prefix() stub so users of
> for_each_child_of_node_with_prefix() can be built for compile testing even
> when !CONFIG_OF.
> 
> Fixes: 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   include/linux/of.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a62154aeda1b..5e2c6ed9370a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -550,6 +550,13 @@ static inline struct device_node *of_get_next_child(
>   	return NULL;
>   }
>   
> +static inline struct device_node *of_get_next_child_with_prefix(
> +	const struct device_node *node, struct device_node *prev,
> +	const char *prefix)
> +{
> +	return NULL;
> +}
> +
>   static inline struct device_node *of_get_next_available_child(
>   	const struct device_node *node, struct device_node *prev)
>   {



