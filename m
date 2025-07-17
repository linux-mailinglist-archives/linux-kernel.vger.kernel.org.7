Return-Path: <linux-kernel+bounces-734938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA03B08882
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2646B585B47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A942874E7;
	Thu, 17 Jul 2025 08:55:05 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A82868B7;
	Thu, 17 Jul 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742505; cv=none; b=X3nnt0dBLU51vks1OI8x/0nFIhFY1Czsm6+Mh1b2gFivJEYBPLglI0RInidgpTUgDJDWMu4YCqfxF9NaYMNZyjB5FEcrWHgLUsn28xAgxtDInznxyXCGG95wKrxAKWP09Ervsar/dgtV8/v4Adg3qrio+RNHtD6iluP2C82Jeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742505; c=relaxed/simple;
	bh=tqxIONYX1LCYkk1Pt0xkmkCz19munA7lGobAGYzCGbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM5x1tvHlN2fzWBpR7eo1ERGjTM2h1wf3CcDUoWjpjousTL8R5UhCY4GUdCW1dvVJXea3DmLihnWLS/FqUId5LCgp9Vm7kEKdU5TUq2LkkDC39pyucs2qIZwcdgWstGO9StkJ+SVlH9yYXwAc6jaigzS0ouX+FM/8S5jw169R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15AFA41DF1;
	Thu, 17 Jul 2025 08:54:57 +0000 (UTC)
Message-ID: <3daff60c-0cf1-437e-bc70-8c84f1866613@ghiti.fr>
Date: Thu, 17 Jul 2025 10:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] riscv: Add xmipsexectl PAUSE instruction
To: aleksa.paunovic@htecgroup.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250625-p8700-pause-v4-0-6c7dd7f85756@htecgroup.com>
 <20250625-p8700-pause-v4-3-6c7dd7f85756@htecgroup.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250625-p8700-pause-v4-3-6c7dd7f85756@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppedukeehrddvudefrdduheegrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudehuddphhgvlhhopegluddtrddugedrtddrudefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrlhgvkhhsrgdrphgruhhnohhvihgtsehhthgvtghgrhhouhhprdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvl
 hhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: alex@ghiti.fr

On 6/25/25 16:20, Aleksa Paunovic via B4 Relay wrote:
> From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
>
> Add MIPS.PAUSE instruction opcode. This instruction is a part of the
> xmipsexectl vendor extension.
>
> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> ---
>   arch/riscv/include/asm/vendor_extensions/mips.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/vendor_extensions/mips.h b/arch/riscv/include/asm/vendor_extensions/mips.h
> index 757c941cfd86e9fced6169b1a82200e6bb5c6132..f8eca0bcf53e2de1bbdc66821fe95987105ed85a 100644
> --- a/arch/riscv/include/asm/vendor_extensions/mips.h
> +++ b/arch/riscv/include/asm/vendor_extensions/mips.h
> @@ -13,4 +13,11 @@
>   
>   extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_mips;
>   
> +/* MIPS.PAUSE is an alternative opcode which is implemented to have the */
> +/* same behavior as PAUSE on some MIPS RISCV cores. */
> +/* It is a ‘hint’ encoding of the SLLI instruction, */
> +/* with rd = 0, rs1 = 0 and imm = 5. */


The comment block should have been like this:

/*
  * ...
  */


> +
> +#define MIPS_PAUSE	".4byte 0x00501013\n\t"
> +
>   #endif // _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_H
>

Unless there is something else to change in the following patches, no 
need to resend the whole patchset just to fix the comment block, I'll do 
it when I merge it.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


