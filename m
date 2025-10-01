Return-Path: <linux-kernel+bounces-838825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F283BB039C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F7216F511
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707C2DECC2;
	Wed,  1 Oct 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JvdRWBya"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002C2522BE;
	Wed,  1 Oct 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319013; cv=none; b=VP9/8eSRvJtAHRfUriwAiDH136nRqU6fdxT7vMU3fGh5Dbm3Ro4BJBqRc3zhVHREdXzMxX4PpIKoTwTwRLBZ4F+11I5b6zDjGNrQmUpgVhePM/Zi3wLkN+iCqX/l6sBPmo3LXqF4EGiWaH83qC14oi88595sQAWzct+0PovIQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319013; c=relaxed/simple;
	bh=QwWYceFhrlj2n4QpoSYYb1INdrt8SZFnjsPSRKC8Ai8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sT/v8V7aTF3nTBOEtqOtDJx3BUZUJtVXLdEfJ2CfIRB6Qk0SS2MQ59g29LnUi/1dyEF/w4BZK3zeiB3dJXT6ks72XERt/EdUJl537yzhYQ9a8c07Zejhkp6ntDzs0/BBNl6d9UWFUQvSa6cNBBAEm8jGe9fRUFmPTmWXzTqD9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JvdRWBya; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759319009;
	bh=QwWYceFhrlj2n4QpoSYYb1INdrt8SZFnjsPSRKC8Ai8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvdRWByaedr36nrzV9z49Su5k+BFyLuJAdCvn5zRJ7dTh6fnVFJZ43gx7RznmEaDQ
	 OpGNJgMdGzDpzyZzxZfAvSq7s38t/v/UeTzT6JnrQ1O5H7iX8usV7PVy7k4mxwTKrV
	 O2kTui57hrk7bH8gMQnn4Qz0CraaoAfVD+Hg9L2OjXuX+XN+Q79rb2hBmabmRMitQj
	 J3opN7MBT9NWwYzdz7iVKIhv3AtYDfooccdbeKEI42xfYKCljKG+eRDgSUWEtLjKab
	 Ry1qMKKMw06NXMyJ6V7MhlIKNy6ElIEsGU0dfJhfXT6vMrtfuKE3+SJPNFEJF3ljJA
	 28KvNjvVv1L9g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A46AA17E131B;
	Wed,  1 Oct 2025 13:43:28 +0200 (CEST)
Message-ID: <a1a84405-fa69-44f2-b714-4844303a8f4c@collabora.com>
Date: Wed, 1 Oct 2025 13:43:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: mediatek: Refactor pll registration to pass
 device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Guangjie Song <guangjie.song@mediatek.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>
Cc: kernel@collabora.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
 <20250929-mtk-pll-rpm-v1-2-49541777878d@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250929-mtk-pll-rpm-v1-2-49541777878d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/09/25 14:13, Nicolas Frattaroli ha scritto:
> As it stands, mtk_clk_register_plls takes a struct device_node pointer
> as its first argument. This is a tragic happenstance, as it's trivial to
> get the device_node from a struct device, but the opposite not so much.
> The struct device is a much more useful thing to have passed down.
> 
> Refactor mtk_clk_register_plls to take a struct device pointer instead
> of a struct device_node pointer, and fix up all users of this function.
> This will allow us to extend clk-pll with runtime PM things later.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Thanks for doing that - this exact thing has been in my backlog for a
very long time now, and you've done it before I could, and without even
knowing that this was in my plans.

Perfect.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

