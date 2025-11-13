Return-Path: <linux-kernel+bounces-899616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F07C5879D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96EAA4F2A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739D3590D9;
	Thu, 13 Nov 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="hXL+fFSt"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BE2EB853;
	Thu, 13 Nov 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047038; cv=none; b=qukigK5Pt9vWPwMftohGSZpN4rEHUqMfVwEIC8yK9UM69vGZcgbOzQGd2kGORJ05HWiPVdhtFFEGXKpWama6IxSXqpKoxhjQ/3FO/eAmC45ZItROaNQAi3SjjpCmIrS5lQogfKL4ef2DhSy7g1WegtQGi5FpS/7O6rXERKNRz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047038; c=relaxed/simple;
	bh=T3n7uGsXw8/exc2MdTHyFvaIfrDg+W4gycMLUTTp62k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgStd5F11ZcsVSyE2ciq75yMUhUtJLkwuqXiXJlNOpW8iQeKu4U3RGqymc1csu2uOAGDw/WO4Lsro7pCEJcVJG+YFNoLO2Iu5EQZS6OCTuLY59iONn6pUy37dZlttHXWqkFLV2di5PCsl2blAgOCUbwMVBb1hofd4eoqHhomDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=hXL+fFSt; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1763046978;
	bh=5AGNvaURvHGKAavyDt3SYJlevQsgOCQzedVhKN3nGVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hXL+fFSt1lF8fqaJhdWEA3T+ShmM5u/Xbf2lHvu3gDBmJqfAIZnz90g8kW1bkujvH
	 px5RxeqKofIflhoz0eTfbb9T5DxdtDorPZFcXz9FS3JKdz71pKojqBBaVOIxRyGjwH
	 lCNjQVnpwYI6vPbmUiH1wKlm91jOCWG3uAvOwn90fw4uSS7EJHp84vp4p0MWm7I1O6
	 LncojllfI5h8FEhShvcfF/nCceH0btWwhhkd2m6Uw2mGwqKZnPFE4dHYCh0AUk4cUN
	 jT1stvHhQkdvhp9/fzCc0pX229Tp8PlDHqKeBSoCpw/8aEIzf9WuFdXfD5oZXncwd9
	 j9t+Ab9nUJqTw==
Received: from [192.168.2.54] (unknown [74.244.53.222])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id AFF95B2202BC;
	Thu, 13 Nov 2025 16:16:14 +0100 (CET)
Message-ID: <4a55301a-ef7e-4b47-8151-621cfba36ddd@freeshell.de>
Date: Thu, 13 Nov 2025 07:16:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>
 <ZQ2PR01MB13076544E2136E7E7C2EEDA1E6CD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAJM55Z9KyNK1n4i9FxbLor4HTQKqK8WKA2svjPVvKXihw_E+sg@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAJM55Z9KyNK1n4i9FxbLor4HTQKqK8WKA2svjPVvKXihw_E+sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 02:42, Emil Renner Berthing wrote:
> Quoting Hal Feng (2025-11-13 04:42:05)
>>> On 12.11.25 21:54, Emil Renner Berthing wrote:
>>> Quoting Hal Feng (2025-11-07 10:55:22)
>>>> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S
>>>> industrial SoC which can run at -40~85 degrees centigrade and up to
>>>> 1.25GHz.
> [...]
>>> Currently the JH7110 device trees are layed out like this, with a nice separation
>>> between the SoC description and board descriptions:
>>>
>>> jh7110.dtsi               # JH7110 SoC description
>>> |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
>>>    |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
>>>    |  |- <VF2 boards>     # Final VF2 board descriptions
>>>    |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
>>>    |  |- <Mars CM boards> # Final Mars CM board descriptions
>>>    |- <other boards>      # Other JH7110 board descriptions
>>>
>>> With this series it moves to
>>>
>>> jh711x.dtsi
>>> |- jh711x-common.dtsi
>>>    |- jh7110-common.dtsi
>>>    |  |- <jh7110 boards>
>>>    |- jh7110s-common.dtsi
>>>       |- <jh7110s boards>
>>>
>>> ..which I can't even give clear labels like above. In other words when new
>>> patches are sent in it would not be easy to explain exactly where each change
>>> should go and why.
>>> I'm also worried that you'll find that more of the peripherals on the JH7110S
>>> need special handling and a new jh7110s-... compatible string. Then I guess
>>> they'll need to jump from jh7110x.dtsi two levels down to jh7110{,s}-
>>> common.dtsi which then both describe SoC and board properties.
>>>
>>> If you're serious about calling this a new SoC then I'd expect something more
>>> like this:
>>>
>>> jh711x.dtsi                  # Peripherals common to both SoCs
>>> |- jh7110.dtsi               # JH7110 SoC description
>>> |  |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
>>> |     |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
>>> |     |  |- <VF2 boards>     # Final VF2 board descriptions
>>> |     |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
>>> |     |  |- <Mars CM boards> # Final Mars CM board descriptions
>>> |     |- <other boards>      # Other JH7110 board descriptions
>>> |- jh7110s.dtsi              # JH7110S SoC description
>>>    |- jh7110s-common.dtsi    # Peripherals common to all JH7110S boards
>>>       |- <JH7110S boards>    # Final JH7110S board descriptions
>>>
>>> I know this will mean some duplication in jh7110{,s}-common.dtsi, but I
>>> would prefer that to not having a clear explanation of what each file describes.
>>>
>>> Do you think this layout could work for you?
>>
>> Yeah, it is clearer for developers and maintainers.
>>
>> Considering Conor's suggestion, what about:
>>
>> jh7110.dtsi               # JH7110 SoC description
>> |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
>>    |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
>>    |  |- <VF2 boards>     # Final VF2 board descriptions
>>    |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
>>    |  |- <Mars CM boards> # Final Mars CM board descriptions
>>    |- <other boards>      # Other JH7110 board descriptions
>> |- <JH7110S boards>
>>

JH-7110 and JH-7110I reference docs are listed (not any JH-7110S) at:
https://doc-en.rvspace.org/Doc_Center/datasheet_0.html

Does the JH-7110I use the OPP table for JH-7110 or JH-7110S?

>> Move the opp table from jh7110.dtsi to jh7110-common.dtsi.
>> Remove jh7110s-common.dtsi, because only one board uses JH7110S now.
> 
> This patchset adds 2 different boards. Has this changed?
> 
> Also this would mean that you're not using the starfive,jh7110s compatible or
> any other starfive,jh7110s-.. compatible strings, so effectively you're not
> treating it as a new chip, but just a board that needs a different opp table.
> 
> I see now that the opp table is effectively the only difference between the two
> chips in this patchset, so if that's closer to reality then what you suggest is
> fine with me.
> 
> /Emil

Are we now re-visiting Hal's suggestion then (during code review for
Milk-V Mars CM and Mars CM Lite) to split out the OPP tables and make
them per-board, as before introduction of the StarFive VisionFive 2 Lite
board(s) ?

Can we then do as from where we are now before this series:

- Move "the JH-7110" OPP table into jh7110-common-opp-1500.dtsi

- Each board jh7110-{deepcomputing,milkv,pine64,starfive}*.dts includes
said OPP dtsi file.

and for this series:

- Drop the adding of a new compatible

- Add "the JH-7110S" OPP table into jh7110-common-opp-1250.dtsi

- Use existing jh7110-* prefix for "JH-7110S" board dtsi and dts,
include jh7110-common.dtsi as usual, and include jh7110-common-opp-1250.dtsi

The exact filename pattern for the OPP tables I suggest here are
approximations, however that idea is my suggestion if we're just doing a
breakout of the tables and not a new compatible.

I am positive on having the 1250MHz OPP tables split out into dtsi
instead of stuffing them into the VisionFive 2 Lite common dtsi. That's
all it is?

-E

