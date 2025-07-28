Return-Path: <linux-kernel+bounces-748333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E941BB13FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDD5161B83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1B26D4C2;
	Mon, 28 Jul 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AeJ8famU"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD62135B8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719324; cv=none; b=gaJHTnTLp4pW2PaEtmVuiSqmKok4xHo00apa+KQ9b72CJSMgAJpFyzKkbM1NYBuPtHpTjhVnJGEIEOroLzjIHPq7Z3wMc8eRffwzxjJWqZk6RYcLjKE5Vu0csE8He4ehc6QfQtraoQqIhxB4OM1ch2DaqYh5P3xjy84ncOYnQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719324; c=relaxed/simple;
	bh=BCfUUYKQ1xq241UcO7MK9HvQXF4SGL/WSpSW5L/EWXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwzIlrrvgp1rcKV8dCULPveluBwE5/gKX2yUlFrsH1H8DQltsmaDvSLuM512I/yFG0qpxLI4aN4MAxHoWZ/OMwCR5nA8IbLAvd3fNk3zLt4QI2KJ8TstqvRUZerk8ky9LIs1HPDjqxKjnq2sLNX6OikAM8AWCg9QR0xqwShGEzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AeJ8famU; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753719321;
 bh=yaCB5+6pv7RrcGxi0FU4X29YAIYEhab8mZkiMc3pGGo=;
 b=AeJ8famUKTS9+jjDD083tr8mImacSEVhvenCzuHluAR6YliMBcDmhBhSo+13LTk6JKUn8BQ5Q
 KPFpajS93GD3MTIockesXapOB2O/d7B+62w8zd8Klg8jwrkeI27DsM4gHgV4BhLqvsrzykUilqR
 sa9iwMoN9adR9i/QtD0UIF7//4rraXir+/q5y7PSeD+WLiec85GPG2oR6oKhCfprAOjO/9h7sTH
 esmsQQzW8v7oKWV+0bqV4iiwKyF8CHzDOA3Su0TZoAmQLOFfWiaOUDNThFw0rKNr59lnQV8g28+
 KN1gOgaZ3H5Nexysn092wwErTzUhmEW3DOaBebsn5IDQ==
X-Forward-Email-ID: 6887a1f2351ec66b15a23517
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <030aff6c-531b-4be3-9176-83fcff21d539@kwiboo.se>
Date: Mon, 28 Jul 2025 18:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: realtek: Add support for use of an
 optional mdio node
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-3-jonas@kwiboo.se>
 <2504b605-24e7-4573-bec0-78f55688a482@lunn.ch>
 <badef015-22ff-4232-a4d0-80d2034113ca@kwiboo.se>
 <9702f3da-f755-4392-bf2b-28814ee0a8c7@lunn.ch>
 <1c639c62-cc07-4b3d-a18b-77f93668b88f@kwiboo.se>
 <2f942223-8683-4808-8f7a-4f46e18f402d@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2f942223-8683-4808-8f7a-4f46e18f402d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/28/2025 5:40 PM, Andrew Lunn wrote:
>> When it comes to having the switch being described as an interrupt
>> controller in the DT is also very wrong, the switch only consume a
>> single HW interrupt. The fact that the driver creates virtual irq for
>> each port is purely a software construct and is not something that
>> should be reflected in the DT.
> 
> I think that is not always clear cut. Switches can be considered SoC
> of their own. They have multiple hardware blocks, which can be
> described independent, just like a traditional SoC and its .dtsi
> file. The switch blocks can then be connected together in the same way
> SoCs are.

I guess you are correct, thanks for clarifying this :-)

> I've not looked at this particular switch driver, but the Marvell
> switches have a similar single interrupt output pin connected to the
> host SoC. Within the switch, there are at least two cascaded interrupt
> controllers. We implement standard Linux interrupt controllers for
> these. That allows us to use standard DT properties to link the
> internal PHY interrupts to these interrupt controllers.

Makes sense, I will describe the phy interrupts of the switch in a v2.

Regards,
Jonas

> 
> 	 Andrew


