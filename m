Return-Path: <linux-kernel+bounces-835009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF0BA6079
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CC380E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342A2E1F0D;
	Sat, 27 Sep 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XvFFGawF"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71C1AA7BF;
	Sat, 27 Sep 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982389; cv=none; b=bQb1MDGGhJhARJDVJcfZwHKCK6jewkNK7qLXiX+g6Zy4HrbHunbYW1trjz8ZAq6Tkisg4kxRZYjO2SMuqSGC2sOQykZK3XvURXSTpIwLMG8ZuVPFiWTuYWDuoZ92Pt8/jBSNArOAIrZEWP4+QwufTegpiUCruzGT25CuoPUK2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982389; c=relaxed/simple;
	bh=lEKbqGUID36RSDPHCWsAinzBiREfkAC6EbtkTLO9gFA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nWCu0v8aBNw8q46qpk0eKRfVwUqKTTlesWfgda1ngLMWTz0n1aKgFF61i5z9Nzs6dl76vqDXLzQO5hIkgKOPYq6Rh7DJmXXeNQwBLQhJN385cuOEkK5EO3y3Bw/xbGcUCY3FOcPHppdF+zW9F7+PoMHOMChwF71iwf6enLDJcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XvFFGawF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1758982385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDJxiELqf4U5lRLf3tONs5cV8e4+Ke0rdHsBjyMJTgc=;
	b=XvFFGawF9nEueZNw9RqkWyjr9N8/47dhxMb5QRL40fuerjSMVv8W9/oetahfHvOLEznbrt
	JyefKJ8hg3cHMZabL6U/H/9xVZwMy/GA+6O8Pw3Mm2mLJ1Bl/Nmqt0wAsl63/ksGSFsPJn
	CakoeRrz8K50V5xW8aKa7zYpj9Xaf/XSJ3yypekBG7hfPlYmdi9WXBqPk/GDNkc/0UBbgh
	6XQlRVRxBV0Txmsx6FnUecyPFggfXf8KCg2W75xHtEeYxy/IpCB+M4Wwj8xwy1Nk4XJ8C9
	K710to/g0Ys4WvTwNRk4voXaPB1HEl/xX6qyl1L0tKI7ub0ecfWpWMUQKuEacg==
Date: Sat, 27 Sep 2025 16:13:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jonas Karlman
 <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
In-Reply-To: <ad4a7dda-8f6f-4d2a-84d9-838611f2285f@gmail.com>
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
 <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
 <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
 <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
 <d0a3d5d4480eac12ba5e2b15bcbc578f@manjaro.org>
 <ad4a7dda-8f6f-4d2a-84d9-838611f2285f@gmail.com>
Message-ID: <5aa5862c4f744b5eb67ad6fe0677e7b1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2025-09-27 15:52, Tianling Shen wrote:
> On 2025/9/27 21:47, Dragan Simic wrote:
>> On 2025-09-27 09:37, Diederik de Haas wrote:
>>> On Sat Sep 27, 2025 at 3:19 AM CEST, Tianling Shen wrote:
>>>> On 2025/9/27 0:07, Diederik de Haas wrote:
>>>>> It is recommended to use the labels in the schematics to define the
>>>>> pinctl nodes (and thus their references). In quite a lot of cases 
>>>>> that's
>>>>> indeed the case, but not for gpio-keys (USER_BUT) or these 
>>>>> gpio-leds
>>>>> pinctls.
>>>> 
>>>> I cannot find any specific naming rules from the gpio-keys[1] and
>>>> gpio-leds[2] bindings, did I miss any update?
>>>> 
>>>> I think this naming matches the current practice at least in 
>>>> rockchip's
>>>> dt tree.
>>> 
>>> There is an unofficial rule/aim:
>>> https://lore.kernel.org/linux-rockchip/5360173.ktpJ11cQ8Q@diego/
>>> But granted, there is 'some' inconsistency.
>>> 
>>> And used in f.e.
>>> https://lore.kernel.org/linux-rockchip/20250727144409.327740-4- 
>>> jonas@kwiboo.se/
>>> 
>>> Where you can just copy the pinctrl labels from the dts[i] and paste
>>> that in the schematic document and you're instantly at the right 
>>> place.
>>> Which is the exact purpose of that rule/aim.
>> 
>> Is the schematic actually publicly available?  I tried searching for
>> it, but found nothing, unfortunately.
> 
> The schematic for NanoPi R76S is available at
> https://wiki.friendlyelec.com/wiki/images/6/60/NanoPi_R76S_LP4X_2411_SCH.pdf
> 
> For more information please move to
> https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R76S.

Oh, I see.  I'm sorry, somehow I got the NanoPi R76S mixed up with
another board whose DT has also been submitted recently, [1] for
which I was unable to find the schematic.  I already found the R76S
schematic, which was actually really easy to do.

By the way, it would be good to provide a link to the schematic as
a reference in the description of patch 2/2, if there turns out to
be v3 of this series.

[1] 
https://lore.kernel.org/linux-rockchip/20250925-print-defog-992c12970b37@spud/T/#t

