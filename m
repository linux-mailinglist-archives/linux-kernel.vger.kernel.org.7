Return-Path: <linux-kernel+bounces-872297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4ACC0FD90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE15D188BCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194EA314D16;
	Mon, 27 Oct 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HUTQt7fl"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A23128CF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588392; cv=none; b=Z3fXXt3ogwPBH4yemiUVYginwiWgIX2YdQg59Tw209pZqSZHnkZx1sbTH1gMi8DrZkSUY8GCsTVvwPJYmV+KOsX4av8tiFhdhZr2ookm50BYAIkL1soHZ1WQMaOBCr6kSFEHEdJvbr48JGkWu/ntVJDcnkCwIbYzMxZsO9NltAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588392; c=relaxed/simple;
	bh=AA5GCYZEMbP5Ax3pEn1tSHgHevbczi1rQeQ8fcw0kZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orUPhBf6ldYhpQl1VbLUMbAx+fHTx1X8Z6LEe7yT7SHUFRSQk2OWxky4TsfDxz2aThPaQry/kZhtGzALIJZg1n81snohgS+8Yq/gGq+YQMdQdhYCTbGrcHEim0PleHYsThSsMEww6LvAzYybsBSa2hO+wJx1GOE9nqgEzobK2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HUTQt7fl; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761588384;
 bh=rNoZEKs9Jg0ddWQ/rYT/Dj9yW6JSQLSPRrnwijVeGws=;
 b=HUTQt7flup4EuJ+ysPhxPwjlOECrhf0OxdtIh4hF0y7q5FW3OyCNmSPgd6VrRKkAs91D0nCmd
 RZiRRmXDNyiSR/jHdP7zZJRo6+i5X6946RWqakhgxB8rMAM3QbiEUjJf6Qa4CSX1H+r9mcmccdK
 ffqV4FvvkwXUubJIGPBmI81wDTPoIRVsOfl0PZw0IoHf65g5FGmhBQYqTKSzyKjRA4YhnmEmwZ6
 eNirGkI8gxUsWwxveEYQ3Dblp4kVCbu4qc86g4YgyS0kZuxC8dmRPGZ59eom+7Wz3skeoOxd7Gq
 7pJ/u25EdMFrpVN6Hr9gjSNzKxvVTrUAunOjnintwB1A==
X-Forward-Email-ID: 68ffb499e1d8d448afcc7519
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <60a1046c-437e-400a-8e2c-391cd471c358@kwiboo.se>
Date: Mon, 27 Oct 2025 19:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Harmonize regulator formatting
 for Pine64 rk3566 devices
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>
References: <20251027154517.136976-1-diederik@cknow-tech.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251027154517.136976-1-diederik@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Diederik,

On 10/27/2025 4:39 PM, Diederik de Haas wrote:
> The regulator node properties in Pine64 rk3566 devices were formatted
> rather inconsistently. To name a few:
> - 'name' was sometimes put at the top of the list, while at other times
>   it was (mostly) sorted in alphabetical order

Personally I prefer to list the regulator-name as the first property, I
think it makes it visually easier/quicker to identify a regulator with
the name prop at top.

I typically try to use the following prop ordering for regulators on
board DTs I submit (and review):

- regulator-name as the first prop (to quickly identify the regulator)
- regulator-min-* before regulator-max-* (natural order)
- regulator-* in alphabetical/natural order

Maybe this preference just comes from a long history of always putting
id/primary key/unique identifiers at top or beginning of data tables,
classes, structs etc ;-)

Regards,
Jonas

> - 'always-on' and 'boot-on' were sometimes at the top of the list,
>   sometimes not
> - 'state-mem' nodes sometimes had a preceding blank line, as they
>   should, but sometimes not
> - other properties seem to have been added to the end of the list, not
>   in their alphabetical/natural order
> 
> So harmonize the formatting by making all properties sorted
> alphabetically/naturally. And harmonize the formatting of the
> 'state-mem' nodes so they all have a preceding blank line. While at it,
> also fix 2 incorrectly indented nodes.
> 
> No functional changes.
> 
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
> ---
> No outright NACKs and one positive response (thanks!), so here's v2.
> 
> Changes in v2:
> - Found more regulators at the beginning of the pinetab2 dtsi file
> - Missed a 'regulator-always-on' on regulator-vcc3v3-sys in q64b dts
> Link to v1:
> https://lore.kernel.org/all/20251026153805.107774-1-diederik@cknow-tech.com/

[snip]

