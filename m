Return-Path: <linux-kernel+bounces-748198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E052DB13DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96380171CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6CA2701CC;
	Mon, 28 Jul 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="i83f5/RT"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930A265CA7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714735; cv=none; b=aqy4xLh0DhycC1ONxZ7oAkEieA+WxnYqbkpYvuUWSi+cHll6UL2huMok9r7gfmYJGQJ+C1BwyBKLebr1V3g5HyOTwVTlUID+kEerKdr7S9DshGTdfVp914cD/ZWCfSgFy4NZIfB6VwjTqnlSbnSMlDcsKNd0a7KppdMUj/dbtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714735; c=relaxed/simple;
	bh=S6VysJn3tfj3RHRNBao3+8NaQVXMPeUDKXr5m6VFARI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ6U/NuKFqJiSulVe5j6wTaLLJAydZb3AWVRYwiM2uz56tTUKwR/xFijhbW5/wUS1OPW7IhmedEvap4RF9xr322sUJZIdXY/vcYWlZHP4Q6cO+nlelL4b25yxbA1oIIbV9kRr0Iv5L6akdYCbREfA78W964taicVqZh3waoA950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=i83f5/RT; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753714726;
 bh=rYuD7fR6ip+mX8V23wp9elDHlgpDSMqOrMV6oJH+6ZI=;
 b=i83f5/RT17n/yV/dY3DuPKHdw2rCnmdUxrUHfUctyuisN1JIqm/cmIp6qE9T/RyP1xgVf/nKU
 Bc65wrgYAO4oHCrxb2R3Y21yKnxr+jxVkRIxDm2dGq5cMe4oRcINfPr6/xEnSaNobW55YymdORl
 sUyAM+6r9Bv0JUa3vsHZYXgxhf7nXroKG30BQpsYfA2SQ1bqzjft1px5IwMRT+jRY6exH1/D/b+
 HYFeHHeD9mdZbqlyP5fm8gvhs2d56shtx1ljgN/UTeVVCyjnU/uQ0Gy4sJLKFtwDXrCKZbhMXGA
 dd2aSbfIzDmDtejoOPZqUMzcWf4fMILAEJZTdvmRyqXA==
X-Forward-Email-ID: 68878ff5351ec66b15a194ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <65023e38-0f90-4d12-8615-a595e399b516@kwiboo.se>
Date: Mon, 28 Jul 2025 16:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250727180305.381483-1-jonas@kwiboo.se>
 <20250727180305.381483-4-jonas@kwiboo.se>
 <be508398-9188-4713-800a-4d2cd630d247@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <be508398-9188-4713-800a-4d2cd630d247@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 7/27/2025 9:16 PM, Andrew Lunn wrote:
> On Sun, Jul 27, 2025 at 06:03:00PM +0000, Jonas Karlman wrote:
>> The Radxa E24C has a Realtek RTL8367RB-VB switch with four usable ports
>> and is connected using a fixed-link to GMAC1 on the RK3528 SoC.
>>
>> Add an ethernet-switch node to describe the RTL8367RB-VB switch.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Initial testing with iperf3 showed ~930-940 Mbits/sec in one direction
>> and only around ~1-2 Mbits/sec in the other direction.
>>
>> The RK3528 hardware design guide recommends that timing between TXCLK
>> and data is controlled by MAC, and timing between RXCLK and data is
>> controlled by PHY.
>>
>> Any mix of MAC (rx/tx delay) and switch (rx/tx internal delay) did not
>> seem to resolve this speed issue, however dropping snps,tso seems to fix
>> that issue.
> 
> It could well be that the Synopsis TSO code does not understand the
> DSA headers. When it takes a big block to TCP data and segments it,
> you need to have the DSA header on each segment. If it does not do
> that, only the first segment has the DSA header, the switch is going
> to be dropping all the other segments, causes TCP to do a lot of
> retries.

Thanks for your insights!

I can confirm that disable of TSO and RX checksum offload on the conduit
interface help fix any TCP speed issue and reduced UDP packet loss to a
minimum.

Regards,
Jonas

> 
>> Unsure what is best here, should MAC or switch add the delays?
> 
> It should not matter. 2ns is 2ns...
> 
> 	Andrew


