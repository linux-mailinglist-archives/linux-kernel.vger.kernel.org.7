Return-Path: <linux-kernel+bounces-891584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0DC42FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E913F3ABAA0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F2233D9C;
	Sat,  8 Nov 2025 16:32:51 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7F3A8F7;
	Sat,  8 Nov 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762619570; cv=none; b=dTe8NT8cqT3I4UPbTEd0POdK2ASi6BWDM3SQziCEW253rmW6VPaX4M9ZpNW/sFbHIuQ5nYrF7a4v1uyWZqqxHBZyFF57+t9rQtH3vA8qE3o75ZgV7CuuJPmxQFjuveHiEWJAUSshE9SbQTCTjNcvzSZfuVwsQQflPCdrG7MbhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762619570; c=relaxed/simple;
	bh=uzRTbst0kgv2bSm318LSyNPj0nXrY4uFkeWkM/v6XeU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WRwB13R98w+Lm2KGRVROJzxWu9ZF9KVhEzrF4jM3YQg8F4eh7UuopTX150GWVSkluH5kDkn32+X3nB+eTPXWlsyRbAr4h0dydeihDfwclFlzHhsFp4i+GlFhkRTH/f2NuccIqekIFMWIYzMkAkKneiH3yRByEn8CJCjf8eLHHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [180.172.111.150])
	by APP-01 (Coremail) with SMTP id qwCowAAnvs2PcA9pK68BAA--.352S2;
	Sun, 09 Nov 2025 00:32:16 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
From: Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20251108-hurler-clammy-0df5e778c04c@spud>
Date: Sun, 9 Nov 2025 00:32:01 +0800
Cc: Han Gao <gaohan@iscas.ac.cn>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Walmsley <pjw@kernel.org>,
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
Message-Id: <90B0751B-CEF0-4E73-B3B2-F20D5D055AC3@iscas.ac.cn>
References: <cover.1762588494.git.gaohan@iscas.ac.cn>
 <d17a3a01e2b1297538c419b51953f9613426ba42.1762588494.git.gaohan@iscas.ac.cn>
 <e98a1e59-f3ff-4e9f-a180-79aea9943236@kernel.org>
 <43109A90-8447-4006-8E29-2D2C0866758F@iscas.ac.cn>
 <287444fa-120c-42b4-9919-2f05ab1a2ab7@kernel.org>
 <8ae5d81d-4869-4c39-9561-cb0f87da70fd@kernel.org>
 <20251108-hurler-clammy-0df5e778c04c@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-CM-TRANSID:qwCowAAnvs2PcA9pK68BAA--.352S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5GFy3uw1xXr1xXF1UWrg_yoW5KF1fpr
	4xCFsIka15ZryfKanrKr1UuFW5tw1kJr15Wr1DJ3y8Z34qvr4UXr1qqr4xWFyqqr1UWw42
	vryDuF1293y5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRD7VDUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiBg0ADGkPW4-QngAAs7



> On Nov 9, 2025, at 00:23, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Sat, Nov 08, 2025 at 03:48:18PM +0100, Krzysztof Kozlowski wrote:
>> On 08/11/2025 15:47, Krzysztof Kozlowski wrote:
>>> On 08/11/2025 14:59, revy wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> -----Original Messages-----
>>>>> From: "Krzysztof Kozlowski" <krzk@kernel.org>
>>>>> Sent Time: 2025-11-08 19:29:07 (Saturday)
>>>>> To: gaohan@iscas.ac.cn, "Paul Walmsley" <pjw@kernel.org>, "Palmer =
Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, =
"Alexandre Ghiti" <alex@ghiti.fr>, "Rob Herring" <robh@kernel.org>, =
"Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" =
<conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>, "Jernej Skrabec" =
<jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, =
"Yixun Lan" <dlan@gentoo.org>, "Drew Fustini" <fustini@kernel.org>, =
"Geert Uytterhoeven" <geert+renesas@glider.be>, "Guodong Xu" =
<guodong@riscstar.com>, "Haylen Chu" <heylenay@4d2.org>, "Joel Stanley" =
<joel@jms.id.au>
>>>>> Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, =
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =
linux-sunxi@lists.linux.dev, "Han Gao" <rabenda.cn@gmail.com>
>>>>> Subject: Re: [PATCH 1/3] riscv: soc: re-organized allwinner menu
>>>>>=20
>>>>> On 08/11/2025 09:20, gaohan@iscas.ac.cn wrote:
>>>>>> From: Han Gao <gaohan@iscas.ac.cn>
>>>>>>=20
>>>>>> Allwinner currently offers d1(s)/v821/v861/v881 on RISC-V,
>>>>>> using different IPs.
>>>>>>=20
>>>>>> d1(s): Xuantie C906
>>>>>> v821: Andes A27 + XuanTie E907
>>>>>> v861/v881: XuanTie C907
>>>>>>=20
>>>>>> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
>>>>>> ---
>>>>>> arch/riscv/Kconfig.socs | 22 +++++++++++++++++-----
>>>>>> 1 file changed, 17 insertions(+), 5 deletions(-)
>>>>>>=20
>>>>>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>>>>>> index 848e7149e443..7cba5d6ec4c3 100644
>>>>>> --- a/arch/riscv/Kconfig.socs
>>>>>> +++ b/arch/riscv/Kconfig.socs
>>>>>> @@ -54,14 +54,26 @@ config SOC_STARFIVE
>>>>>> help
>>>>>>   This enables support for StarFive SoC platform hardware.
>>>>>>=20
>>>>>> -config ARCH_SUNXI
>>>>>> - bool "Allwinner sun20i SoCs"
>>>>>> +menuconfig ARCH_SUNXI
>>>>>> + bool "Allwinner RISC-V SoCs"
>>>>>> +
>>>>>> +if ARCH_SUNXI
>>>>>> +
>>>>>> +config ARCH_SUNXI_XUANTIE
>>>>>=20
>>>>>=20
>>>>> You should not get multiple ARCHs. ARCH is only one. There is also =
not
>>>>> much rationale in commit msg for that.
>>>>=20
>>>> The main goal is to avoid choosing multiple IP addresses for =
erreta.=20
>>>> If using Andes IPs, I don't want to choose XuanTIe (T-Head) ERRETA.
>>>=20
>>> Not explained in commit msg but anyway not a good argument. It is =
some
>>> sort of micro optimization and you completely miss the point we =
target
>>> multiarch kernels.
>>=20
>> Heh, and I actually did not forbid or discourage choosing erratas per
>> your soc. I said you only get one top level ARCH. Look at all arm64
>> platforms. How many ARCHs are there per one vendor?
>=20
>=20
> Yeah, it only allows you to enable the errata, it doesn't force any of
> them to "y". Some will get enabled by default when ARCH_SUNXI is
> enabled, but if someone is only targeting on device they can just turn
> them off... I'm pretty inclined to just NAK this unless there's some
> actual value.


I understand. I'm going to abandon this patch and plan to resubmit a =
patch=20
that only modifies the description from sun20i to allwinnner.


