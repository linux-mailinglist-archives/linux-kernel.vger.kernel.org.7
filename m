Return-Path: <linux-kernel+bounces-780405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C221B3016F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D16D7B4802
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F052E267C;
	Thu, 21 Aug 2025 17:49:32 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2A4AEE2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798572; cv=none; b=Zz0Z0kFmnbWy76m/k96bJG+ltfwC06yTbjnsUkVgN6jvgDcIRijq1VZGxAt7evzQH450oMa0S6DsmqU62IOXPIZkEr2OPcESRh1AtwKGUQFvaOqNmmWvktnOateyCM/cHDWq+RbUNETemvaywF6Uaxc+wuO39vaLDtm2gQQVW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798572; c=relaxed/simple;
	bh=kMD4SJVNodiFHkp+mCkRlHqWUz2tnVCcqL+x+WIx/Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcCYQpOIh/p7bj2tM5NWFDN7c4+Ivoj/NdmzshIqwSJgBoVDvL9XLhtZyBymeX+bf1E9KtQ/a8ia3/0E8KB2YoxWwMqXI4gZXjYMAfGKzm4d+l0SuHjj9+SH9H3FhyRYE8O8hzzifdPybJH6Nt/k/+JtZZq38wolFTWhcI2GG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowAB3Z6scXKdo5lsdDg--.19280S2;
	Fri, 22 Aug 2025 01:49:17 +0800 (CST)
Message-ID: <871ca57a-2f0a-4b21-be8f-7a26a76fd58d@iscas.ac.cn>
Date: Fri, 22 Aug 2025 01:49:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Charlie Jenkins <charlie@rivosinc.com>,
 Xiao Wang <xiao.w.wang@intel.com>,
 =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivian Wang <uwu@dram.page>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
 <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
 <aKcwtXDJKRf4O_tF@yury> <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAB3Z6scXKdo5lsdDg--.19280S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7k0a2IF6w1UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
	6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
	0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I
	8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GF
	yl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUz_MaUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 8/22/25 01:46, Vivian Wang wrote:

> [...]
>
> And, codegen-wise:
>
> ALTERNATIVE("j %l[no_alt]", "nop", ...) -> likely() ALTERNATIVE("nop",
> "j %l[has_alt]", ...) -> unlikely()
>
I messed up the formatting, should be:

    ALTERNATIVE("j %l[no_alt]", "nop", ...) -> likely()
    ALTERNATIVE("nop", "j %l[has_alt]", ...) -> unlikely()

Vivian "dramforever" Wang


