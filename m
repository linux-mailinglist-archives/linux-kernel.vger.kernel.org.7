Return-Path: <linux-kernel+bounces-745843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A8B11F78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23394587C68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A7224B1F;
	Fri, 25 Jul 2025 13:42:28 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F141BF58
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450948; cv=none; b=EOTldbJdFUI77nWKi6MEtnQNyWocjEfYDNAYOTEZntDAvycvn5IJ9OChUp1X3APbCnU7rnIyDjBbvZkPLd2RQx2xq/jUgCi9b88slP5wAXElU3zBuwnjHpfUaP+ADHnvEpkkYSGlHifWGANvMkyiwsxKpH+z+KH1XkUZBfIWql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450948; c=relaxed/simple;
	bh=UzPrUcTaXQUsxHf/xdDXOod06h8AzgEAFDc4Om9QIu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eAjwz/gPp01Xb4STMrJSpyWsW6fGLm70gVaJjHIEm67lGdCkwu15RamQT6b/J2XBkKK84h4adGiRgEjvR47DGLOGysoyG7mbsBUb8VCp+VfcO/vFVew/4AXY2t9/TWmWirq2CgcWTPu3AZSnOWMbPQY1e7p8jcSZ7paByJmmTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B94D143173;
	Fri, 25 Jul 2025 13:42:15 +0000 (UTC)
Message-ID: <fa6f5e3c-3452-41ff-ab81-60f5f31ff797@ghiti.fr>
Date: Fri, 25 Jul 2025 15:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: fix __put_user_nocheck for unaligned
 accesses
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
References: <20250724220853.1969954-1-aurelien@aurel32.net>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250724220853.1969954-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhefgvdetjeeigfdvveekgfduheekkeehgfekvddtueegtdevffefjeehkedtgfenucfkphepleehrddugedurddutddvrddukeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepleehrddugedurddutddvrddukeeipdhhvghloheplgdutddruddtrddugeeirddvudejngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprghurhgvlhhivghnsegruhhrvghlfedvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtlhgvghgvrhesr
 hhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Aurélien,

On 7/25/25 00:08, Aurelien Jarno wrote:
> The type of the value to write should be determined by the size of the
> destination, not by the value itself, which may be a constant. This
> aligns the behavior with x86_64, where __typeof__(*(__gu_ptr)) is used
> to infer the correct type.
>
> This fixes an issue in put_cmsg, which was only writing 4 out of 8
> bytes to the cmsg_len field, causing the glibc tst-socket-timestamp test
> to fail.
>
> Fixes: ca1a66cdd685 ("riscv: uaccess: do not do misaligned accesses in get/put_user()")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   arch/riscv/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index b88a6218b7f24..22e3f52a763d1 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -311,7 +311,7 @@ do {								\
>   do {								\
>   	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&	\
>   	    !IS_ALIGNED((uintptr_t)__gu_ptr, sizeof(*__gu_ptr))) {	\
> -		__inttype(x) ___val = (__inttype(x))x;			\
> +		__typeof__(*(__gu_ptr)) ___val = (x);		\
>   		if (__asm_copy_to_user_sum_enabled(__gu_ptr, &(___val), sizeof(*__gu_ptr))) \
>   			goto label;				\
>   		break;						\


Thanks for catching this (I will add the glibc testsuite to our CI).

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



