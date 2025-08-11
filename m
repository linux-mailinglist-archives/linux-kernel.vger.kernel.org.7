Return-Path: <linux-kernel+bounces-761666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BDB1FD2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD313B5B31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46B9443;
	Mon, 11 Aug 2025 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwNhIrTS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21C4400;
	Mon, 11 Aug 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754870595; cv=none; b=GG391+gTEVveP0gIivd5gS8+TF+M8JP7bPB3RcvokjeMalwszIinT9csCr9NlFiRGJcRmEJfPuOvbeKWiMQXYa0NDCqzHfJZrO5VSxjeQVKGGFK11AlxSzQkqhm61+gN+GnsLB5bMgSHNPfd7VIWi/PS8RVC2ax5H1kPbhfICWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754870595; c=relaxed/simple;
	bh=X+BdXFqquj9DQr6IZy+gnd+atvFm1saLgYgTBYGsDcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSPldG5gKe5AkcM7Rl9q4AOcKcQBOMU5mwrwcodKm2UO3Sw9Cz8GMy2oIzOItSBmoKnZKjRoP7cB9Fv5XpX9pTG5SOxlvpXD1rv8SgD7rci3bErjzddWfcpt8vuBiZROf3oEAfzutwdk6QpPANEuJnS517e5DgUpQmEqSPJCpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwNhIrTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B93CC4CEEB;
	Mon, 11 Aug 2025 00:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754870594;
	bh=X+BdXFqquj9DQr6IZy+gnd+atvFm1saLgYgTBYGsDcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IwNhIrTSncJxWdZ2aY0n/OpWBzLHtdeDdtqD5+L1CFL86UORnALYCcQp0lr46IJmK
	 QfYpITQOe/3jNfCUoktAuooa3UV0HRXYiD5QT9oe/awIBZjKB1Iha+ntxvt0S8zcUv
	 +5jNoWOfLSKqHgr9ElMOr3navaHtvZCm+yEZYLHaeETo99A2vnX3O1jN5EUlAUzfaK
	 zS/tjGE1uUJRXVuEHgXYMIHi5GVWwHBtVLEpqEnCPb4pAPocc1MrIUHLxfK6R3PdO8
	 Xn9tjuhyZKJCWL3ouaL1S9d4CsrXUm7B3KNegfsW7sl0SHwx/h3Plfvge1bDvhceJG
	 9dYQaxn6JaY5w==
Message-ID: <8358d907-0edc-4ff0-a520-9cec3c84a49a@kernel.org>
Date: Sun, 10 Aug 2025 18:03:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: vrf: don't down the interface when add
 slave
Content-Language: en-US
To: Ido Schimmel <idosch@idosch.org>, Menglong Dong <menglong8.dong@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250807055634.113753-1-dongml2@chinatelecom.cn>
 <aJhNP_xQyENLSF6d@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aJhNP_xQyENLSF6d@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/25 1:41 AM, Ido Schimmel wrote:
> On Thu, Aug 07, 2025 at 01:56:34PM +0800, Menglong Dong wrote:
>> For now, cycle_netdev() will be called to flush the neighbor cache when
>> add slave by downing and upping the slave netdev. When the slave has
>> vlan devices, the data transmission can interrupted.
> 
> OK, but can you provide more details on the production use case for
> enslaving the real device to a VRF during runtime? Usually this kind of
> configuration is performed before data transmission begins. I suspect
> this is why nobody complained about this behavior despite being present
> in the VRF driver since its initial submission almost a decade ago.
> 
> I'm asking because the potential for regressions from this patch seems
> quite high to me. For example, before this patch nexthop objects using
> the enslaved device would get flushed, but now they persist. This can
> impact offload of nexthop objects and it's possible I'm missing more
> potential regressions.
> 

+1

Thanks for staying on top of this, Ido. I have been very distracted the
past few months.

The design choices when the VRF code was first written was either
1) require the devices to be added to a VRF while down, or
2) cycle the device while adding it to the VRF.

I preferred 2 as the simplest choice for users, and so that is the way
the feature went in.

