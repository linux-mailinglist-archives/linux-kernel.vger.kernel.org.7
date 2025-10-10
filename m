Return-Path: <linux-kernel+bounces-848895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6EBCEC47
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE78C4F05D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D58284695;
	Fri, 10 Oct 2025 23:38:45 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07E283FE0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139524; cv=none; b=cosFbrgq6J4GC3Ra5LukGN5zX2AuNBTSTIpMmXf7Y2/M+z/oFBAV8KZAxQp8JJC6XWCEbxoQgWKWpxUj8yFWsQqgT8PooavofcFhcueil9u37wQlZH3d5ZXadlxpc5NEHyPjfJ98IVex9tzS7HkZq9CvjBluDb6cYX2V0hGA+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139524; c=relaxed/simple;
	bh=MOvKtjWWZln39LdRDMkstgu0kV+DCHAFevY/Xt2QYv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQpc8c/oGV0sCaVLnT6BvBv6DhYlrodC+47jfXvBX6lmccLyLMd9PBVLvCOywiEzAWd+OfppWaSGu6C2eSZ7053bbMrV7jJ3V2lwFyNC+3/x7UDXDuMv9qwM249RV4cTWCEfAznSQUqoNNok8c94yzgjsWzsHmL4JfXaXd2CKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowADnihT2mOlo80OIDQ--.18197S2;
	Sat, 11 Oct 2025 07:38:30 +0800 (CST)
Message-ID: <035e00c5-6144-4eb9-bad8-1f425832d697@iscas.ac.cn>
Date: Sat, 11 Oct 2025 07:38:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] riscv: Use __riscv_has_extension_{likely,unlikely}
To: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Paul Walmsley <pjw@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang
 <xiao.w.wang@intel.com>, =?UTF-8?Q?Christoph_M=C3=BCllner?=
 <christoph.muellner@vrull.eu>, Vivian Wang <uwu@dram.page>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20251011-riscv-altn-helper-wip-v3-0-d40ddaa1985a@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADnihT2mOlo80OIDQ--.18197S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy5Aw1kCFy8Zw1UtrWkZwb_yoWfAFX_C3
	yUXr9rAan0vFs0gw4rtw17GrZxKay0kFy5Xa4kJrWakr9xWa1kJ392kr9ay3ZxXwsIg3Zr
	Kr95Ja1xZr48ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07b0SoAUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 10/11/25 07:35, Vivian Wang wrote:

> There are about a dozen uses of asm goto in arch/riscv just to select
> between two code paths with the alternative mechanism. Convert them to
> the existing helpers __riscv_has_extension_{likely,unlikely}.
>
> In each case, I have preserved the existing code's choice of asm goto
> pattern while picking between "likely" and "unlikely", namely:
>
>   ALTERNATIVE("j %l[no]", "nop", ...)   -> "likely"
>   ALTERNATIVE("nop", "j %l[yes]", ...)  -> "unlikely"
>
> Since the helpers are just implementations of these patterns, the
> performance should be the same as before.
>
> These patches are also available at:
>
> https://github.com/dramforever/linux/tree/riscv/altn-helper/v2
I made a mistake while writing the cover letter, the correct link is:

https://github.com/dramforever/linux/tree/riscv/altn-helper/v3

Vivian "dramforever" Wang


