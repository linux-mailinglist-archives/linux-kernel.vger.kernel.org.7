Return-Path: <linux-kernel+bounces-736577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA673B09EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF31C44C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77639295524;
	Fri, 18 Jul 2025 09:10:48 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FE217719;
	Fri, 18 Jul 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829848; cv=none; b=WHUHlFpFRFvDf8AeuB/fgC0KKmtKJt4krVyxbI5kEnAPvcf8Mcq+tyP+FJTycQsxDLkn+gm3JPyNung+kSv1wALeH7s+dY4Di62eEE2x2SIo1kd6bsdmqGjYPxkPHP9CO/uXkhfsM22Zdk/01iAiHQOuh9Fpcvtj9Iv+Uo9Edec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829848; c=relaxed/simple;
	bh=cBX8jb8/E8dXl35jg55xxJT05v9kGOTkRga0coGmOZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOI38YwKxalKSMA4nJXUsA0ElL88Jpp4mHRqz5Nr9NYbsuRTb/ujZ5RQh2n2UPJ7WXLALpw4QJDZcD0TEzI886pDwvj3DVaaaUrKYc9gA47X33o+oBeAmBuZIxja1642SYAP9kI4hRCDrRu5yKdYdfdLkZYG63UyqU0K5Jc0F+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAnulp+D3poBZ4XBQ--.32570S2;
	Fri, 18 Jul 2025 17:10:23 +0800 (CST)
Message-ID: <8ade99a6-84a0-4e69-8ebf-d9dfdc9141b5@iscas.ac.cn>
Date: Fri, 18 Jul 2025 17:10:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add OrangePi RV2 board
 device tree
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, dlan@gentoo.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 palmer@dabbelt.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
 <20250718084339.471449-3-hendrik.hamerlinck@hammernet.be>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250718084339.471449-3-hendrik.hamerlinck@hammernet.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAnulp+D3poBZ4XBQ--.32570S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4kWr4UWw4ruF13AF1fWFg_yoW8Ar1DpF
	Z7uFs3AF1DtF4fKr42g3W8Way8urn5XF47t3y2g3s09Fn8XFyFqwn29ay5uF1UArn3uFWq
	yF4UW348G3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
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

Hi Hendrik,

On 7/18/25 16:43, Hendrik Hamerlinck wrote:
> Add initial device tree support for the OrangePi RV2 board [1], which is
> marketed as using the Ky X1 SoC but has been confirmed to be 
> identical to the SpacemiT K1 [2].
>
> The device tree is adapted from the OrangePi vendor tree [3], and similar
> integration can be found in the Banana Pi kernel tree [4], confirming SoC
> compatibility.

This isn't particularly crucial, but I wonder if we can do something
similar to a jh7110-common.dtsi arrangement, where most of the boards
sharing similar designs can also share devicetree source files.

Easier said than done, probably, but I think it should be possible by
just comparing the vendor dts files.

Again this doesn't need to block this patch.

Yixun: I'm assuming you'll be handling this. What do you think about a
k1-common.dtsi?

Vivian "dramforever" Wang

> This minimal device tree enables booting into a serial console with UART
> output and a blinking LED.
>
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
> Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
> Changes since v1:
> - Added the aliases section to the device tree.
> - Removed the memory section, as it is populated by the bootloader.
> - Replaced unclear copyright similar to the other K1-based boards.
> ---
> [...]


