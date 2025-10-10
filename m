Return-Path: <linux-kernel+bounces-847803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4209BCBC55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97C9E4E7722
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6EF23A995;
	Fri, 10 Oct 2025 06:21:06 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD043846F;
	Fri, 10 Oct 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077266; cv=none; b=Ly/Um1IDT3rx/LIi3kNc+uCED1mNnCSsjJ7OwPZuucC2WQFCxHMyEMUa17yx6qocjpcXt++ZZbRain2LJkh0CNmLHPUJNXQizlfeN804m8tNAXLxVlWGHjWDOXw3rOXH8c5GZU1lmwJAKJaOlOP4MZ/oXS/tlNNootDg+lyddGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077266; c=relaxed/simple;
	bh=2n7qp+xX1Ru863LgIztYUBx3pihhPeHOnyr62/8YyHY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DIxkUAEMiArBwi1N7cNNTLB4r1sqiB9m9Ur/vA6lg6TSkixiXEoyhaYgBpYVMPLAm6lE8FqhpyIV4xGm4Z/IDyMEbcKkgInuTEF9uCtSyCZ5012RwPTvZToz6eYy2vkVxupJOOSKokEJI99oc72Agn0OiCGAsEOibdo9zmCUJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowAAHqhPCpehoLwxkDQ--.18166S2;
	Fri, 10 Oct 2025 14:20:51 +0800 (CST)
Message-ID: <f968ca77-6fc0-4485-a13a-2ed83a7e6617@iscas.ac.cn>
Date: Fri, 10 Oct 2025 14:20:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
From: Vivian Wang <wangruikang@iscas.ac.cn>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHqhPCpehoLwxkDQ--.18166S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45WryxXr4UJr4kAFy3XFb_yoW8ZFy8pF
	Z7uFZ3Gwn7Kr4SkrsIv3WDuF1rJa95Xa1YgasFkrn8JrsxXry5Cr93t3ZxKF1UZryrG340
	vry8WayfuFs0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5IAp7UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/10/25 14:13, Vivian Wang wrote:
> On 10/10/25 09:56, Troy Mitchell wrote:
>> MusePi Pro features a single RGMII Ethernet port with
>> PHY reset controlled by GPIO.
>>
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
>> index 89a35914710bfd15c6ad27cd8d0de7ccf62e2309..e9a53dc7a417117c82f3e467677290bdaeffc845 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
>> @@ -47,6 +47,29 @@ &pdma {
>>  	status = "okay";
>>  };
>>  
>> +&eth0 {
> For node orders in board DTS for SpacemiT devices, usually we follow
> node name order because there's no unit address to go off of here, so
> for what we have here it should be emmc, eth0, pdma, uart.
>
> See e.g. arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts and previous
> discussion [1].
>
> Also, personally I think it would be fine to just add the whole
> k1-musepi-pro.dts in the same patch instead of splitting it up like
> this. I feel it would be easier to manage this way. For previous devices
> these nodes have been added piecemeal mostly because the drivers were
> being developed in parallel, but if you're going to base this on
> v6.18-rc1 there shouldn't be dependency problems.
... and also almost missed: this should have an ethernet0 alias. In the
most common boot flow it's read by U-Boot to set mac-address so that
both U-Boot and Linux use the same MAC address. This allows U-Boot to a
persistent MAC address rather than having to use a random one.  
> Maybe Yixun can chime in about this as well.
>
> Thanks,
> Vivian "dramforever" Wang
>
> [1]: https://lore.kernel.org/linux-riscv/CAH1PCMa35n4dnJ94-EHGrJyU3kztQYO8_v2CkD=rid466zv3+A@mail.gmail.com
>


