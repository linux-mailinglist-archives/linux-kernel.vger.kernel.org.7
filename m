Return-Path: <linux-kernel+bounces-828411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F072BB94911
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1B048354E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465330F80C;
	Tue, 23 Sep 2025 06:33:09 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244635959;
	Tue, 23 Sep 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609189; cv=none; b=bcbDQ5rdY+CnCB44HJNVw42cCq+IpdZy8ZjalmlXVduHmVD2Lb1j0nQb7Q8WaxWCKUExc6yFevzc4WqguA1kAy1cj1po6BMoRfCqAoNfS/YfZKaBote6uA7LRPrKvSMuBvCleEd5Y8tsrxL3HY9zfn4LRxC9jsQlcdYF4VphtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609189; c=relaxed/simple;
	bh=w3b4zSTXCS0lYSgsxj/hTrhvi+qKcLscSoeWJ2+i5B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7LCbmdd5qBxK0XP/7hNNSrPImqjLw/Q9A5w3PIld+iNsUJ40zsmYuyyEcVQW2hPldqfF39CKtlBvMaf1I6kee9tqVM1z0pV4ZFWP3WiiGegbfQJZ16IX5CKmOHtPzFFaeoipff4KBPIfMbuJHEz4KVMcbhep4vuDWux0fGcrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.102] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowADHaBILP9Jo2ZlyBA--.58809S2;
	Tue, 23 Sep 2025 14:32:44 +0800 (CST)
Message-ID: <54a959f7-a2e6-4622-97fa-18408afa0998@iscas.ac.cn>
Date: Tue, 23 Sep 2025 14:32:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@gentoo.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-3-aurelien@aurel32.net>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250921210237.943370-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHaBILP9Jo2ZlyBA--.58809S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4xCw4DuFWUAFW7Kw45ZFb_yoW8CFWkpF
	WvkFs5G3yxKr13CrsFvF15WryrJFnYg3W5CrnxCr1UArn8uFy2kr4fK3WDtrZ8Xrs3Zw17
	Jr4ktrWDKFy3taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Aurelien,

On 9/22/25 05:01, Aurelien Jarno wrote:
> The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> MAC addresses of the two network interfaces. For this reason, mark it as
> read-only.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 3b6e4f52e9aad..574d10fdf9b82 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -115,6 +115,15 @@ &i2c2 {
>  	pinctrl-0 = <&i2c2_0_cfg>;
>  	pinctrl-names = "default";
>  	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c02";
> +		reg = <0x50>;
> +		vcc-supply = <&vcc1v8_sys>;
> +		pagesize = <16>;
> +		read-only;
> +		size = <256>;
> +	};
>  };
>  

I wonder if it would possibly make sense to specify a nvmem-layout here.
The BPI-F3 I have here has this in the 24c02:

00000000  54 6c 76 49 6e 66 6f 00  01 00 20 24 06 fe fe fe  |TlvInfo... $....|
00000010  XX XX XX 2a 02 00 02 23  0c XX XX XX XX XX XX XX  |...*...#.XXXXXXX|
00000020  XX XX XX XX XX fe 04 XX  XX XX XX ff ff ff ff ff  |XXXXX..XXXX.....|
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000100

(... with variable parts replaced with X)

And, AFAICT, this is a "onie,tlv-layout" with fields:

0x24 mac-adddress
0x2a num-macs
0x23 serial-number
0xfe crc32

As you can see the mac-address assignment looks bogus with fe:fe:fe (it
is used by vendor code though, so at least it seems to be intended). It
does appear at least to have useful information.

Can you confirm on your hardware? What do you think about this: should
we add it now or add it when we have users?

Vivian "dramforever" Wang


