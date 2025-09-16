Return-Path: <linux-kernel+bounces-819424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E8B5A07D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7401BC6368
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C72C0323;
	Tue, 16 Sep 2025 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="0e3rb8TX"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67102C0F84;
	Tue, 16 Sep 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047181; cv=none; b=UPIPN8ZnmjA1zM7P0z2zyX/3/9A8C17a1+c6pihSpDryHT990Kjc6+fJ/1VSgV4RDTpu8wu1c/TDeAAuEEyHzGo8EOZfdyT4GOwx/C07C9vCqcD33TwdoffyDgiyuAoMKSbsWOp8jSKYsipb/HutJfTOMA5UN8hfw9dXKzb+0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047181; c=relaxed/simple;
	bh=cJ0ZgA9fSOYGQwYE2169cbLnicc73+0vXxPopTPOXv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5j2pdvrERTi7wsSC922XOGIMUR+Gz6t70C0pvF90uakUYot6fbuLrfWC9ex3SKtA5ow/KP5I/H/C1Bhj9FNkIGPHhr2zekHe78ShTV/i/cYavkyH2wia8fmaocdRGWsieA4+kuAcf2V0l+GUjS+N9TTQ4x2G53XSOM4yRbn+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=0e3rb8TX; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pfR7Xsy4BQPLEp1myu06IGK0gA6NnQf3jtJg3r/Xogg=; b=0e3rb8TXFHuItZMejDHEA/J4qr
	Ncudvij/fFD65016h6R73EusavImCWVjmuJt4DcY6D3nT+YL9bjjqvc2nCt9Nseo2SDVC5xvhM4tS
	JST+mGABW9nUmN5mL8hVq8BPVGB8yK2+yhi5kL1p+LoKrYjKEiaH8h9XmxU2BMevdJrMRC1y1yI3S
	j1hMnf8mAT6yFgJCGcZ+A694Z1TU3R1TjFf31MOt6+6aTQuY6/SC2RFcoVNizOBVBUIg2TZMZkLbN
	MbaJBP6xep/n+a/oEjuWFCwd2LdNFgt+d8xBqXT6CdKZUbnK+H26O6OiZdObrbf2UOf9o+mzZQw9o
	kSQ7Gxzw==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uyaNM-0001Qd-FC; Tue, 16 Sep 2025 19:26:00 +0100
Message-ID: <51960b81-d8df-423f-b24b-4b4ec1e7a245@codethink.co.uk>
Date: Tue, 16 Sep 2025 19:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
To: Drew Fustini <fustini@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
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
 <70241f44-2f8d-4945-9c84-71416776cefd@codethink.co.uk> <aMmd/JQAfPwKuYyB@x1>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <aMmd/JQAfPwKuYyB@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 16/09/2025 18:27, Drew Fustini wrote:
> On Tue, Sep 16, 2025 at 02:56:05PM +0100, Ben Dooks wrote:
>> On 15/09/2025 18:52, Drew Fustini wrote:
>>> On Mon, Sep 15, 2025 at 05:47:08PM +0100, Conor Dooley wrote:
>>>> On Sat, Sep 13, 2025 at 02:31:05PM -0700, Drew Fustini wrote:
>>>>> new file mode 100644
>>>>> index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f924579024290bb355c9b3
>>>>> --- /dev/null
>>>>> +++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
>>>>> @@ -0,0 +1,14 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include "blackhole-a0.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +	model = "Tenstorrent Blackhole A0 SoC PCIe card";
>>>>> +	compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";
>>>>> +
>>>>> +	memory@0 {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0x4000 0x30000000 0x1 0x00000000>;
>>>>
>>>> This isn't at address zero as the node address claims.
>>>
>>> Thanks, I'll fix the unit address.
>>
>> Is it time to just assume any dtc can handle a 64bit number?
> 
> Is it not valid for me to use the 64 bit hex number in the unit address?
> 
>

No, the reg = < > contents. It is a right pain to read split 32bit
numbers and I thought dtc had been updated to allow 64bit now?



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

