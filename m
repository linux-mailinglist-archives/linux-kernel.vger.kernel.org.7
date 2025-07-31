Return-Path: <linux-kernel+bounces-752181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1526FB1722D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888BC3A046D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9502D0292;
	Thu, 31 Jul 2025 13:36:56 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CBB2C15AB;
	Thu, 31 Jul 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969015; cv=none; b=LIkO4huA72gn5gC4D1KhAB+/+nRHwWpPG+AeAbCUcKjglF7EvLd9RFIpmp1aTHlSwetAOIFK+pSO+HagIfnKlpTSbPnAb2MHRa/fkjlWj6xLKvr8NGQl6vREnC6sLCg0NuMzIXoK4ivxJ1lF3ENH5kBdBxKf0DahgLO7nYvigtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969015; c=relaxed/simple;
	bh=pUddgFY3bTyLpnjqVwtW0u0LS8Fi/74YNvkxstPYw6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBFW+/zRvKgiEQ5n+bWkX0m+1cjDkLULI3hIgfmpJSZRF55jlABbB/exIP8E+kW/eZ1Tqg6ESoAPzHW6aedM+xVtpQj+XYwRF48iwadRmSEX8er9jrG2Grqnfu3UdxGAWiuM48XjbodS6JL4Onp2IUtSOvJ001uxIfTn4MI1IV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73E3542D7F;
	Thu, 31 Jul 2025 13:36:48 +0000 (UTC)
Message-ID: <cf49b59f-d39c-4757-a453-6d3c8a09d1ce@ghiti.fr>
Date: Thu, 31 Jul 2025 15:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] riscv: Add support for xmipsexectl
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Raj Vishwanathan4 <rvishwanathan@mips.com>
References: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemuddtjeefmegslegsgeemjegvtgekmeehhegutdemgehfvddvmeeigedvkedphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegrlhgvkhhsrgdrphgruhhnohhvihgtsehhthgvtghgrhhouhhprdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: alex@ghiti.fr

Hi Aleksa,

On 7/24/25 17:23, Aleksa Paunovic via B4 Relay wrote:
> This patch series adds support for the xmipsexectl vendor extension.
> A new hardware probe key has also been added to allow userspace to probe for MIPS vendor extensions.
>
> Additionally, since the standard Zihintpause PAUSE instruction encoding is not supported on some MIPS CPUs,
> an errata was implemented for replacing this instruction with the xmipsexectl MIPS.PAUSE alternative encoding.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
> Changes in v5:
> - Add MIPS.IHB and MIPS.EHB instructions
> - Rebase on alex-for-next
> - Address other smaller comments pointed out by Alexandre
> - Link to v4: https://lore.kernel.org/r/20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com
>
> This is a continuation of a previous series, which did not implement the full
> xmipsexectl vendor extension. The title was updated accordingly.
>
> Changes in v4:
> - Add support for the xmipsexectl vendor extension
> - Remove the ifdef/else from errata_list.h
> - Replace the ifdef/else with a hwprobe call in the userspace code.
>
> Link to v3:
> https://lore.kernel.org/linux-riscv/20250129131703.733098-1-arikalo@gmail.com/
>
> ---
> Aleksa Paunovic (6):
>        dt-bindings: riscv: Add xmipsexectl ISA extension description
>        riscv: Add xmipsexectl as a vendor extension
>        riscv: Add xmipsexectl instructions
>        riscv: hwprobe: Add MIPS vendor extension probing
>        riscv: hwprobe: Document MIPS xmipsexectl vendor extension
>        riscv: Add tools support for xmipsexectl
>
> Djordje Todorovic (1):
>        riscv: errata: Fix the PAUSE Opcode for MIPS P8700
>
>   Documentation/arch/riscv/hwprobe.rst               |  9 +++
>   .../devicetree/bindings/riscv/extensions.yaml      |  6 ++
>   arch/riscv/Kconfig.errata                          | 23 ++++++++
>   arch/riscv/Kconfig.vendor                          | 13 +++++
>   arch/riscv/errata/Makefile                         |  1 +
>   arch/riscv/errata/mips/Makefile                    |  5 ++
>   arch/riscv/errata/mips/errata.c                    | 67 ++++++++++++++++++++++
>   arch/riscv/include/asm/alternative.h               |  3 +
>   arch/riscv/include/asm/cmpxchg.h                   |  3 +-
>   arch/riscv/include/asm/errata_list.h               | 13 ++++-
>   arch/riscv/include/asm/errata_list_vendors.h       |  5 ++
>   arch/riscv/include/asm/hwprobe.h                   |  3 +-
>   arch/riscv/include/asm/vdso/processor.h            |  3 +-
>   arch/riscv/include/asm/vendor_extensions/mips.h    | 37 ++++++++++++
>   .../include/asm/vendor_extensions/mips_hwprobe.h   | 22 +++++++
>   arch/riscv/include/asm/vendorid_list.h             |  1 +
>   arch/riscv/include/uapi/asm/hwprobe.h              |  1 +
>   arch/riscv/include/uapi/asm/vendor/mips.h          |  3 +
>   arch/riscv/kernel/alternative.c                    |  5 ++
>   arch/riscv/kernel/sys_hwprobe.c                    |  4 ++
>   arch/riscv/kernel/vendor_extensions.c              | 10 ++++
>   arch/riscv/kernel/vendor_extensions/Makefile       |  2 +
>   arch/riscv/kernel/vendor_extensions/mips.c         | 22 +++++++
>   arch/riscv/kernel/vendor_extensions/mips_hwprobe.c | 23 ++++++++
>   arch/riscv/mm/init.c                               |  1 +
>   tools/arch/riscv/include/asm/vdso/processor.h      | 27 +++++----
>   26 files changed, 298 insertions(+), 14 deletions(-)
> ---
> base-commit: b6a4bae2f16162876842127d7507dad84e404f8f
> change-id: 20250424-p8700-pause-dcb649968e24
>
> Best regards,


Thanks for the v5, I'll take that for 6.17.

Thanks,

Alex


