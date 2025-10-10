Return-Path: <linux-kernel+bounces-848834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49476BCEA89
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75AC24E48E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FB26D4C3;
	Fri, 10 Oct 2025 22:03:57 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40B264614;
	Fri, 10 Oct 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133836; cv=none; b=PgcRW/16Vs31Bgh8flFu+F7+e1Aruwv3jqhQDOXnm0qmidCOBias8WvwlBa0S7h51MLua3CGI95SaG9Lnkh7z1Gdz5HoRiL0bMDyx3AXfsTPUdTvbInT27CPAvE3Es5qiIkyE+MBbFIGXM4+uv+SIkZNYVO2rSg2ub1JvWSaWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133836; c=relaxed/simple;
	bh=WAQH2h36TSL7hjHlp7jybFBleTDmQfIXfTTqppPG6/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4zbfHIZ3ioEVNXE22AzR9RgxRnqB6Ie/2MSx7rw7kZH67jqSs8lOXzBRmIo95/nLLmFeylTXsoBQ5s3Tl0AU2K+bbjaAgJOodKUkWiXuR7pgwZsoPrwaFh/tfFLRgtPvRW3Bz2/tXgU2kgMPl4FBDk7y36fRdQpcsTCj4AfAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.81.247])
	by APP-05 (Coremail) with SMTP id zQCowAAXfRa2gulo4BSFDQ--.31232S2;
	Sat, 11 Oct 2025 06:03:35 +0800 (CST)
Message-ID: <0d50502a-0709-49ea-b412-927c17f15b60@iscas.ac.cn>
Date: Sat, 11 Oct 2025 06:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: interrupt-controller: add UltraRISC
 DP1000 PLIC
To: Lucas Zampieri <lzampier@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251009082013.1331361-1-lzampier@redhat.com>
 <20251009082013.1331361-3-lzampier@redhat.com>
 <9ae53c6d-613b-4a25-b672-88ffabfef4fa@kernel.org>
 <CAOOg__BTJw53uTK4h_o4GK6x2D0XutTSQMpb-BDXh22Ac0-q-A@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CAOOg__BTJw53uTK4h_o4GK6x2D0XutTSQMpb-BDXh22Ac0-q-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXfRa2gulo4BSFDQ--.31232S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UAF43WFyxCrW8Jr4rGrg_yoW8ur4UpF
	ZruFyqyF4vvF13u3yIqa10kayI9FsxJF9rKrs0qw45CF1qgr1rXFW2ga15CFn2vrs2qrWj
	yF4I934fJa42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2wIDUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 10/10/25 21:57, Lucas Zampieri wrote:
> On Thu, Oct 9, 2025 at 9:39 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 09/10/2025 17:20, Lucas Zampieri wrote:
>>> From: Charles Mirabile <cmirabil@redhat.com>
>>>
>>> Add a new compatible string for UltraRISC DP1000 PLIC.
>>>
>>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>>> ---
>>>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml        | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
>>> index 5b827bc24301..a419de50f5a8 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
>>> @@ -74,6 +74,8 @@ properties:
>>>                - sophgo,sg2044-plic
>>>                - thead,th1520-plic
>>>            - const: thead,c900-plic
>>> +      - items:
>>
>> Missing SoC specific front compatible, me thinks.
> Right, if I'm understanding this correctly, I would need to add the
> sifive,plic-1.0.0 fallback compatible to indicate register layout
> compatibility. However, the DP1000 PLIC has a claim register hardware
> bug that breaks interrupt handling without the driver quirk. Should we
> still include the fallback even though the generic driver doesn't
> work?

See what the thead,c900-plic thing is doing. The PLIC compatible should
be SoC-associated model, and then CPU-core-associated model.

(I guess *theoretically* the PLIC could be external to the CPU but it
doesn't really make sense to design a core this way.)

Supposedly [1] the cores are called UR-CP100, so it should be

    compatible = "ultrarisc,dp1000-plic", "ultrarisc,cp100-plic";

And the driver should match on ultrarisc,cp100-plic instead.

Vivian "dramforever" Wang

[1]: https://ultrarisc.github.io/ultrarisc-devblog/2025/06/18/dp1000-spec/


