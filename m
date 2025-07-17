Return-Path: <linux-kernel+bounces-735187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE7B08BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC611AA7837
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5C29B227;
	Thu, 17 Jul 2025 11:47:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BC2AE8E;
	Thu, 17 Jul 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752845; cv=none; b=FzJIk3vxAtETzhgi1ksxBV1LDv++nTN6nBZ4DYR/saUBxo3iWcUfde+Xmkl6nxnOP2d67LVABteR5EwyZ8kSjyxJGTW79kSbdYoHEosReh6rO05YAG77FSpnfCr9FGHMr0k5mfg96scXntILQmCfL0VV/oOYQqQoFKchVU1gzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752845; c=relaxed/simple;
	bh=YNxhh3BEV+fqhkHcNvEA0zxqRMWqls2pc6ZMwOr3iC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QevUWp70j/1YM48khsUoEddgjUadSLP77Usoqq8U4u2yRqyquwVIBG2e2Im44+2EBYfugV5M8L6sa7vdAocTA70He+ik8BmxkxWWeAcZ1hWbUPVbi4dk8MbPpgs8Xzw0OYMZE8ueJW7hNAqW28cChkrTNLXYq5MgLmdbmrDPPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0913443A01;
	Thu, 17 Jul 2025 11:47:16 +0000 (UTC)
Message-ID: <4f552ace-5c5a-4749-8fbf-5f7a1f86562e@ghiti.fr>
Date: Thu, 17 Jul 2025 13:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] riscv: Add support for xmipsexectl
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Raj Vishwanathan4 <rvishwanathan@mips.com>
References: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephffhuddtveegleeggeefledtudfhudelvdetudfhgeffffeigffgkeethfejudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudekhedrvddufedrudehgedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrdduhedupdhhvghloheplgdutddrudegrddtrddufegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghlvghkshgrrdhprghunhhovhhitgeshhhtvggtghhrohhuphdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdpr
 hgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: alex@ghiti.fr

On 6/25/25 16:20, Aleksa Paunovic via B4 Relay wrote:
> This patch series adds support for the xmipsexectl vendor extension.
> A new hardware probe key has also been added to allow userspace to probe for MIPS vendor extensions.
>
> Additionally, since the standard Zihintpause PAUSE instruction encoding is not supported on some MIPS CPUs,
> an errata was implemented for replacing this instruction with the xmipsexectl MIPS.PAUSE alternative encoding.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
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
>        riscv: Add xmipsexectl PAUSE instruction
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
>   arch/riscv/include/asm/errata_list.h               | 17 +++++-
>   arch/riscv/include/asm/hwprobe.h                   |  3 +-
>   arch/riscv/include/asm/vdso/processor.h            |  4 +-
>   arch/riscv/include/asm/vendor_extensions/mips.h    | 23 ++++++++
>   .../include/asm/vendor_extensions/mips_hwprobe.h   | 23 ++++++++
>   arch/riscv/include/asm/vendorid_list.h             |  1 +
>   arch/riscv/include/uapi/asm/hwprobe.h              |  1 +
>   arch/riscv/include/uapi/asm/vendor/mips.h          |  3 +
>   arch/riscv/kernel/alternative.c                    |  5 ++
>   arch/riscv/kernel/entry.S                          |  2 +
>   arch/riscv/kernel/sys_hwprobe.c                    |  4 ++
>   arch/riscv/kernel/vendor_extensions.c              | 10 ++++
>   arch/riscv/kernel/vendor_extensions/Makefile       |  2 +
>   arch/riscv/kernel/vendor_extensions/mips.c         | 22 +++++++
>   arch/riscv/kernel/vendor_extensions/mips_hwprobe.c | 22 +++++++
>   arch/riscv/mm/init.c                               |  1 +
>   tools/arch/riscv/include/asm/vdso/processor.h      | 27 +++++----
>   26 files changed, 286 insertions(+), 14 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250424-p8700-pause-dcb649968e24
>
> Best regards,


I tried to fix all the small comments I added, but there are quite a few 
(and using MIPS_PAUSE triggered a new header nightmare) so can you send 
another version rebased on top of this branch 
https://git.kernel.org/pub/scm/linux/kernel/git/alexghiti/linux.git/log/?h=alex-for-next 
?

Thanks,

Alex


