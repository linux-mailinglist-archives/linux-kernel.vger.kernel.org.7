Return-Path: <linux-kernel+bounces-834993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C456ABA5FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259871B2180C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83C2DF13B;
	Sat, 27 Sep 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="k1TkaTrK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E661A238F;
	Sat, 27 Sep 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758980866; cv=none; b=tFCTSQ47lzWpGzl84/FuKuBl48dXiAjahcUlYKnIURkA07cyDojFH4FuE/aa5TP6x2LAYLe0iIi8P6gNnPzaTJN6nF66mXhRu11rfkYF8JQyVSwBi2tPb6EaHxlmK5t4m0M7Y+Is7yZKwEOpXGCS932SJswUnztWwRfsuJJ9UTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758980866; c=relaxed/simple;
	bh=eM+SFxnTyTY5kFSJm4wguccBRruiQ5oSyGAxNi+yFM4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LaKZa6adBa6SkavBfqeHHgHh9AYTIbyCEINdw+iGBZFHzzFm6VZo4rUZiD6Tq4ESewLi1NgTQ+Z4GS7cxGOSC6zAW+5MrDFx+cr9kVlPlchd7QeqpTWWg1a4Lb2udxA+G2JuWtYKobmT7pjGdh6h7KVd++clNFep4LOSQPwn2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=k1TkaTrK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758980856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=viO8D+Qu2R6riMUQBJZA4lci0O87eiHC/lld0s2EB4A=;
	b=k1TkaTrKrNDGCaTdjNAzJ54xvUbwa6oLdyeabtuQche1UzsO4we+X1IcKp6h0zBbBkwPKs
	lri59Pl1DSM0NoDtpcluC29zfICKCZ8lSyFHfOPSamPaUJuROwZ/uGt1nhG3J7J2NOe9Nb
	O/KIgDxmBszhbBzxLZb6JZoBLW48y1WlSML5W0dDdw/K553F4HosjgBSnujXaFdEKlx1fZ
	HJFlk5RI4+khI/ZU0gzIf9FbSwPulObZIkJ/MX7RHhJn3TtSOB7KTxYKH8SJ/hDqtFCi2g
	XriAwvbvt71g5BRuVo2C5ryf4QkHuTqP9tV+zbGNOYzYF2NvKczLJTNBblVimw==
Date: Sat, 27 Sep 2025 15:47:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jonas Karlman
 <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
In-Reply-To: <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
 <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
 <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
 <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
Message-ID: <d0a3d5d4480eac12ba5e2b15bcbc578f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik and Tianling,

On 2025-09-27 09:37, Diederik de Haas wrote:
> On Sat Sep 27, 2025 at 3:19 AM CEST, Tianling Shen wrote:
>> On 2025/9/27 0:07, Diederik de Haas wrote:
>>> It is recommended to use the labels in the schematics to define the
>>> pinctl nodes (and thus their references). In quite a lot of cases 
>>> that's
>>> indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
>>> pinctls.
>> 
>> I cannot find any specific naming rules from the gpio-keys[1] and
>> gpio-leds[2] bindings, did I miss any update?
>> 
>> I think this naming matches the current practice at least in 
>> rockchip's
>> dt tree.
> 
> There is an unofficial rule/aim:
> https://lore.kernel.org/linux-rockchip/5360173.ktpJ11cQ8Q@diego/
> But granted, there is 'some' inconsistency.
> 
> And used in f.e.
> https://lore.kernel.org/linux-rockchip/20250727144409.327740-4-jonas@kwiboo.se/
> 
> Where you can just copy the pinctrl labels from the dts[i] and paste
> that in the schematic document and you're instantly at the right place.
> Which is the exact purpose of that rule/aim.

Is the schematic actually publicly available?  I tried searching for
it, but found nothing, unfortunately.

