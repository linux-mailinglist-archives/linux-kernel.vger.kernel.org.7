Return-Path: <linux-kernel+bounces-819015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050AB599FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D712E3A47FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942C34F499;
	Tue, 16 Sep 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="jQayv1VV"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393634F47B;
	Tue, 16 Sep 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032537; cv=none; b=Ch9jYNuGCxbkt8JP+vt5N5Fkkq0c15EmF9HT9OGZ8HafAnRLkdie0S5yNhbNhJvx571TvafwIN4a8ryxX6DOOX5YRJ+TFLHNOH9ndws1hIrNySruzGJPEFv2PVLhnr0wLnMWRklzG9EbW38QEtlga8bGvTzFmk+eaACdZ7oqncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032537; c=relaxed/simple;
	bh=Ivoeh6jfB7yYBZUGzHGv/za9TYvXgujRjCQM9WcQ3lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1z3YOXCxQnbNSR1yoTCqYB+Krn5naJuDCbhCgEpp95T6E3GUrjEkNbNfOaweO6FFWdY3uySKBfglaC3CduJi5AEaL+5WGrcvQUINBFWEkG3XvzxrCCA2W1xKjs+Z9U1JTVXY/YxsweSt8YdlxkAsy/Xbjphh0GPgIOiJthuusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=jQayv1VV; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uNIYRj9GoFIgE0bx3nW1lY0HxQFaZbKTteY8eNBKQ4Q=; b=jQayv1VVFcnT5BAqM4uK/OlAZV
	LYQJq1eiD3b8JQ6j5nfh6GhIW7kNsl830AW0BcyIre0+fpaQe5OovfHNcu2bdd3aXIx0cBUg26kOY
	uCIV44iDgprzcHZycLPQATqNaZj4c6wlsX5K+lvNIKUkhafja4KfRzYxIiCdcsRjvvV45AchOqMdq
	Zy0rQosUwpNiP7PGCpeUym+btRkzwd4P5R9HBEG3iHrS7Z+FMIgjvSHbw+vm2sl0QKuckPdN95Qd1
	aCwXyD/6+9l/KENCZwlZD1iDLCaxI6GnBRjzJ5iPzIG7tjF8LWwpiFBQ+gI9QwICo1BS7yXE6TGWo
	s5SoBbwQ==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uyWAA-00HS9q-OA; Tue, 16 Sep 2025 14:56:07 +0100
Message-ID: <70241f44-2f8d-4945-9c84-71416776cefd@codethink.co.uk>
Date: Tue, 16 Sep 2025 14:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
To: Drew Fustini <fustini@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Andy Gross <agross@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Drew Fustini <dfustini@tenstorrent.com>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
 <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>
 <20250915-mouth-banner-ddfb2e48bdb3@spud> <aMhSSka3gyIcND/L@x1>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <aMhSSka3gyIcND/L@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 15/09/2025 18:52, Drew Fustini wrote:
> On Mon, Sep 15, 2025 at 05:47:08PM +0100, Conor Dooley wrote:
>> On Sat, Sep 13, 2025 at 02:31:05PM -0700, Drew Fustini wrote:
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f924579024290bb355c9b3
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
>>> @@ -0,0 +1,14 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/dts-v1/;
>>> +
>>> +#include "blackhole-a0.dtsi"
>>> +
>>> +/ {
>>> +	model = "Tenstorrent Blackhole A0 SoC PCIe card";
>>> +	compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";
>>> +
>>> +	memory@0 {
>>> +		device_type = "memory";
>>> +		reg = <0x4000 0x30000000 0x1 0x00000000>;
>>
>> This isn't at address zero as the node address claims.
> 
> Thanks, I'll fix the unit address.

Is it time to just assume any dtc can handle a 64bit number?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

