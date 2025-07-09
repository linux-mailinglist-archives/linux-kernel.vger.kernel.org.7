Return-Path: <linux-kernel+bounces-723975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DFAFED49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FA0567C14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39F62E5B08;
	Wed,  9 Jul 2025 15:08:39 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906B2D8380
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073719; cv=none; b=SUxkiBCE2OHkyNc0QY9fvAymsqmBcy1RSp4+uVfZIEgROHEl7h0LqPD/gQxZrlk+ql4mW1322bEx4K5Qs+Er7N3TdyjHQSSnuGLuCWrjNp6pvDI4l02SE4i9rmZ5/f8olTRaStZn7yi5LVO3zCklWIjdnzv62TYIh8jld+t6FAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073719; c=relaxed/simple;
	bh=Aix6fvxMtcyRBsR68fx6tN0wr+CD1afxP1mpdrD6smo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COiCaNNdUoF/HMiB4fK3ZtYZRxRC++3JkdyEO3qlomtSuMz7UsdanhtUPx80Wxt3v5HX7WytgOMvAjA/weI1VrBxfWgt374d4F2/CjxlWsBWwRASGnnY1CR0HuYmBVFyH9ziaz8+Rqo94LIN3JHZCSD7AB6Efn1POpmJ0aJJHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6AB6043E9F;
	Wed,  9 Jul 2025 15:08:31 +0000 (UTC)
Message-ID: <203fba2f-24c0-45bd-aeac-c907297f9a6e@ghiti.fr>
Date: Wed, 9 Jul 2025 17:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Optimize GCD performance on RISC-V by selecting
 implementation at runtime
To: Kuan-Wei Chiu <visitorckw@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jserv@ccns.ncku.edu.tw, Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250606134758.1308400-1-visitorckw@gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250606134758.1308400-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgejvgdvmegrugelvdemlegrsgejmeefudehsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgejvgdvmegrugelvdemlegrsgejmeefudehsgdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgejvgdvmegrugelvdemlegrsgejmeefudehsggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepledprhgtphhtthhopehvihhsihhtohhrtghkfiesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdpr
 hgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhsvghrvhestggtnhhsrdhntghkuhdrvgguuhdrthif
X-GND-Sasl: alex@ghiti.fr

Hi Kuan-Wei, Andrew,

@Andrew: Will you merge this one? I can do it through the riscv tree if 
not, no problem at all.

Thanks,

Alex

On 6/6/25 15:47, Kuan-Wei Chiu wrote:
> The current implementation of gcd() selects between the binary GCD and
> the odd-even GCD algorithm at compile time, depending on whether
> CONFIG_CPU_NO_EFFICIENT_FFS is set. On platforms like RISC-V, however,
> this compile-time decision can be misleading: even when the compiler
> emits ctz instructions based on the assumption that they are efficient
> (as is the case when CONFIG_RISCV_ISA_ZBB is enabled), the actual
> hardware may lack support for the Zbb extension. In such cases, ffs()
> falls back to a software implementation at runtime, making the binary
> GCD algorithm significantly slower than the odd-even variant.
>
> To address this, we introduce a static key to allow runtime selection
> between the binary and odd-even GCD implementations. On RISC-V, the
> kernel now checks for Zbb support during boot. If Zbb is unavailable,
> the static key is disabled so that gcd() consistently uses the more
> efficient odd-even algorithm in that scenario. Additionally, to further
> reduce code size, we select CONFIG_CPU_NO_EFFICIENT_FFS automatically
> when CONFIG_RISCV_ISA_ZBB is not enabled, avoiding compilation of the
> unused binary GCD implementation entirely on systems where it would
> never be executed.
>
> This series ensures that the most efficient GCD algorithm is used in
> practice and avoids compiling unnecessary code based on hardware
> capabilities and kernel configuration.
>
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> ---
> This series has been tested on QEMU to verify that the correct GCD
> implementation is used both with and without Zbb support.
>
> v2 -> v3:
> - Drop if (!a || !b) check in binary_gcd()
> - Move DECLARE_STATIC_KEY_TRUE(efficient_ffs_key) to gcd.h
> v1 -> v2:
> - Use a static key to select the GCD implementation at runtime.
>
> v2: https://lore.kernel.org/lkml/20250524155519.1142570-1-visitorckw@gmail.com/
> v1: https://lore.kernel.org/lkml/20250217013708.1932496-1-visitorckw@gmail.com/
>
> Kuan-Wei Chiu (3):
>    lib/math/gcd: Use static key to select implementation at runtime
>    riscv: Optimize gcd() code size when CONFIG_RISCV_ISA_ZBB is disabled
>    riscv: Optimize gcd() performance on RISC-V without Zbb extension
>
>   arch/riscv/Kconfig        |  1 +
>   arch/riscv/kernel/setup.c |  5 +++++
>   include/linux/gcd.h       |  3 +++
>   lib/math/gcd.c            | 27 +++++++++++++++------------
>   4 files changed, 24 insertions(+), 12 deletions(-)
>

