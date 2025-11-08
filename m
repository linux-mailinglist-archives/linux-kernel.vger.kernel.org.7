Return-Path: <linux-kernel+bounces-891524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633AC42D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481D7188D93B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF41E1E1C;
	Sat,  8 Nov 2025 14:00:14 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AA1DE4F1;
	Sat,  8 Nov 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610413; cv=none; b=olRLHdC3g9DJGgC9SfKLV9MCArVCAQSiURtl18qO41k5Z+uWx+9OlYqtbw6ugKMOzYmM6+TljPy2mxCucx4/twAXEvMKWCax55KSYxZY1EIlM4G1oPP3A7PO/N7M2qGdwT5RIrApwqkSP/sQJ60exgco1O6S9BYBt2iLcIHs7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610413; c=relaxed/simple;
	bh=7yBypT11WbeW2bxMeuPHburV16FzltRiYKmtQ3dew9U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dzZgpTS1JSY7UDhXMHtioWz9bXAVolSlhepPS5yRNxicR6wjtxrGVwaRM+EzcaH9fDRd3sdRHg9Bq1SRbrHy8W9/Wi+iiidiRYKzKxQa68YqOnXdAZePGmtFdSEq6mGE1FSro36osMX58Q7yQcCvj31c5LFH5vK1LdKxA+4Aq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [180.172.111.150])
	by APP-05 (Coremail) with SMTP id zQCowAA3pPK0TA9pT6IJAg--.54671S2;
	Sat, 08 Nov 2025 21:59:17 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
From: revy <gaohan@iscas.ac.cn>
X-Priority: 3
In-Reply-To: <e98a1e59-f3ff-4e9f-a180-79aea9943236@kernel.org>
Date: Sat, 8 Nov 2025 21:59:06 +0800
Cc: Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Rob Herring <robh@kernel.org>,
 krzk+dt@kernel.org,
 conor+dt@kernel.org,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Yixun Lan <dlan@gentoo.org>,
 Drew Fustini <fustini@kernel.org>,
 geert+renesas@glider.be,
 Guodong Xu <guodong@riscstar.com>,
 Haylen Chu <heylenay@4d2.org>,
 Joel Stanley <joel@jms.id.au>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Han Gao <rabenda.cn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43109A90-8447-4006-8E29-2D2C0866758F@iscas.ac.cn>
References: <cover.1762588494.git.gaohan@iscas.ac.cn>
 <d17a3a01e2b1297538c419b51953f9613426ba42.1762588494.git.gaohan@iscas.ac.cn>
 <e98a1e59-f3ff-4e9f-a180-79aea9943236@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-CM-TRANSID:zQCowAA3pPK0TA9pT6IJAg--.54671S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF13uFWkGr1UXFWDWw1fXrb_yoW8Kw15pF
	4fCFsI9FW5XryIganFgryj9FW5ta93Gw43WryDJ34rZ34jv3yUWr90qr4xWF1DXryDWa17
	Jr95uF1a93y5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU0uc_3UUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiCQ8ADGkPJyrqCQAAsC




> -----Original Messages-----
> From: "Krzysztof Kozlowski" <krzk@kernel.org>
> Sent Time: 2025-11-08 19:29:07 (Saturday)
> To: gaohan@iscas.ac.cn, "Paul Walmsley" <pjw@kernel.org>, "Palmer =
Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, =
"Alexandre Ghiti" <alex@ghiti.fr>, "Rob Herring" <robh@kernel.org>, =
"Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" =
<conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>, "Jernej Skrabec" =
<jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, =
"Yixun Lan" <dlan@gentoo.org>, "Drew Fustini" <fustini@kernel.org>, =
"Geert Uytterhoeven" <geert+renesas@glider.be>, "Guodong Xu" =
<guodong@riscstar.com>, "Haylen Chu" <heylenay@4d2.org>, "Joel Stanley" =
<joel@jms.id.au>
> Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, =
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =
linux-sunxi@lists.linux.dev, "Han Gao" <rabenda.cn@gmail.com>
> Subject: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
>=20
> On 08/11/2025 09:20, gaohan@iscas.ac.cn wrote:
>> From: Han Gao <gaohan@iscas.ac.cn>
>>=20
>> Allwinner currently offers d1(s)/v821/v861/v881 on RISC-V,
>> using different IPs.
>>=20
>> d1(s): Xuantie C906
>> v821: Andes A27 + XuanTie E907
>> v861/v881: XuanTie C907
>>=20
>> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>> ---
>> arch/riscv/Kconfig.socs | 22 +++++++++++++++++-----
>> 1 file changed, 17 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index 848e7149e443..7cba5d6ec4c3 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -54,14 +54,26 @@ config SOC_STARFIVE
>> 	help
>> 	  This enables support for StarFive SoC platform hardware.
>>=20
>> -config ARCH_SUNXI
>> -	bool "Allwinner sun20i SoCs"
>> +menuconfig ARCH_SUNXI
>> +	bool "Allwinner RISC-V SoCs"
>> +
>> +if ARCH_SUNXI
>> +
>> +config ARCH_SUNXI_XUANTIE
>=20
>=20
> You should not get multiple ARCHs. ARCH is only one. There is also not
> much rationale in commit msg for that.

The main goal is to avoid choosing multiple IP addresses for erreta.=20
If using Andes IPs, I don't want to choose XuanTIe (T-Head) ERRETA.

For example, v821 uses Andes ax27, but it used to select ERRATA_THEAD.

>=20
> Best regards,
> Krzysztof


