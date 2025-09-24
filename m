Return-Path: <linux-kernel+bounces-830400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D3FB998E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0F316B4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAD22E6CB6;
	Wed, 24 Sep 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LpkfQhXp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7A2E62D0;
	Wed, 24 Sep 2025 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712382; cv=none; b=PHIPEeaYy+i8rydcg1e42BlRs49VumJBYey1vZVTBZZrog6RfYuca3jzz1UNg1FmyiVxRyYPggyyXa31RTU0APzuuHfrmis+NhTbIElw09IQcAqbbkyWvSg6JKw/DmLfyC112ObnRs/PJgs1ZwlIe7TG9GF7JT/SGrBtyWJARVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712382; c=relaxed/simple;
	bh=mEaPxnXPWDr4+sD/gn++M63cz2JPCbACYRxAhexmBWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS3rH41+AlfNuKe6Tvw9rFNPdvmYq0oOFL//IXLu6rVQgLL5Srx5dAN8Oeu32TMrKCBRYbcDZ+yXxzN1S1DhRoDgvtCskPjt7XBJOX0I8Of3ex6YR25+3SNgG2WQGP9NYK8ODo1W6kNDXkAAGhupo7DYwwTEi+HYeV8eFwQgv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LpkfQhXp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758712378;
	bh=mEaPxnXPWDr4+sD/gn++M63cz2JPCbACYRxAhexmBWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LpkfQhXpa9huGJydB70kP2swCrNVh7lR5ONAGi2uIpFKwLzt7bt214owUR9Wr9Ywm
	 oH8+UqTL9Bmf1iLkT1rkaCdxYcwgBhYHsTd8IhsZ7oDcq2SKRxb2i5v3odVk+qF8oE
	 dXuhqx9sMNrobUcg8p16NPBGXFpx3v76T8z7go5XExyAQMqSqQDJWNZ5GMfQrsKvW5
	 I6EZTdZEeFE9QTJxHPYzJsjVwZ3efFXGGno2yRvnaH1wvpVh4G2mb1lHpvGTLnZphK
	 u0f8wLM8IE1kImVtn4uApybH4xzHOo0QrQMeVBtmhv/LEXsa7ac7KTSGmVaRXAtLYh
	 672EkJtLChEBQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C3F617E068C;
	Wed, 24 Sep 2025 13:12:58 +0200 (CEST)
Message-ID: <f495967f-5713-47c4-afec-723d4ad005cc@collabora.com>
Date: Wed, 24 Sep 2025 13:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ARM: dts: airoha: update EN7523 dtsi to support
 resets
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
 <20250924104850.1930254-4-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250924104850.1930254-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/25 12:48, Mikhail Kshevetskiy ha scritto:
> This patch updates EN7523 dtsi to reflect the reset-controller
> support for EN7523 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



