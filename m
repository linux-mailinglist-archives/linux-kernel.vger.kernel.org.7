Return-Path: <linux-kernel+bounces-725879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB28B004FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE651898506
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BA272813;
	Thu, 10 Jul 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PC+aKiYi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC92727F1;
	Thu, 10 Jul 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157262; cv=none; b=rSjY6AeTcO8V5eVFDW4ZAh1dX9BrkFFai0WZeMAr9ndvZ++iQabpoqpeY9mtaQC+HjbA5NlBK5gqnw/nNUOT3D9lL1f8qnfJu3g0Ker9y7kb/xKuS4OEpR9mLhFbY31rlLoiobXmkY9m5fdSfcIcscsX/GSXcgVhG7b8+ylAAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157262; c=relaxed/simple;
	bh=2XjHkdOkObP5HVj5iejMMSjoEC9b3hAuC6HFJ71aAK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8I0mFPbEpdwrE2fRMg3qITHgWndYu8+J8TubOK8idlfSz5feC6n8+eg/bBwLHSmu24/xHhcgZldWCiFa3lbEBnT3Z1BmM2ckCus6wgZKq5gbPEpoqZ2681hXYHKefPdXKvX2xBCdOiTW9SG89KKJJhVaNBuT0cuTmK0IeALW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PC+aKiYi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752157257;
	bh=2XjHkdOkObP5HVj5iejMMSjoEC9b3hAuC6HFJ71aAK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PC+aKiYiogEuqlNa7TQGKyCx3vgGKlbJ3LCBXKRZ6o/4xDXSvVFGj2IWV3ohYnH8s
	 q15YA5AcEoi54jaepRL9uEen3Ks+cgfy8IN3lKgCbSt/b7XWvpwL2s2uJgwn/JyS4W
	 OfGtIffWq0aCuAqQQsh3AAfQcCSKxgbYO3YedG7wX3u3/vo7lrM7vAzM8+tEiS+8jh
	 9ddmmRg+cDckW8WFvYCQPfBRBXCdIh3KMLfUf0mXuq2z3P6fbkOX7hAE0wdgwVVFOJ
	 4R/+nmf67pi0PGgvns15v1dA09prn64xdvpKJgWWOT9Lms+OgLsPsk3XxqV8ZIJw0C
	 zMlrYgPRAyXdQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:bff:3863:712c:1a2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 01D1D17E08E3;
	Thu, 10 Jul 2025 16:20:55 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: angelogioacchino.delregno@collabora.com
Cc: arnd@arndb.de,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	drew@pdp7.com,
	gregkh@linuxfoundation.org,
	kabel@kernel.org,
	kernel@collabora.com,
	khilman@baylibre.com,
	krzk@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	m.wilczynski@samsung.com,
	matthias.bgg@gmail.com,
	nm@ti.com,
	pjp@fedoraproject.org,
	quic_hyiwei@quicinc.com,
	robh@kernel.org,
	tudor.ambarus@linaro.org,
	u.kleine-koenig@baylibre.com,
	ulf.hansson@linaro.org
Subject: Re: [RFC PATCH 2/3] dt-bindings: firmware: Document the MediaTek Hardware Voter (HWV)
Date: Thu, 10 Jul 2025 16:19:41 +0200
Message-Id: <20250710141941.75843-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <9560d4d2-5346-4d0a-a96f-c96ebe335f3c@collabora.com>
References: <9560d4d2-5346-4d0a-a96f-c96ebe335f3c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/25 12:40, AngeloGioacchino Del Regno wrote:
> Il 03/07/25 10:56, AngeloGioacchino Del Regno ha scritto:
>> Il 02/07/25 08:50, Krzysztof Kozlowski ha scritto:
>>> On Tue, Jul 01, 2025 at 05:11:48PM +0200, AngeloGioacchino Del Regno wrote:
>>>> Add documentation for the new MediaTek Hardware Voter, found in
>>>> MediaTek SoCs like the MT8196 Kompanio Ultra for Chromebooks and
>>>> the MT6991 Dimensity 9400 for Smartphones.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>   .../mediatek,mt6991-hardware-voter.yaml       | 70 +++++++++++++++++++
>>>>   1 file changed, 70 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/firmware/mediatek,mt6991- hardware-voter.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/mediatek,mt6991- hardware-voter.yaml b/Documentation/devicetree/bindings/firmware/ mediatek,mt6991-hardware-voter.yaml
>>>> new file mode 100644
>>>> index 000000000000..173b74c23a91
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/firmware/mediatek,mt6991-hardware- voter.yaml
>>>> @@ -0,0 +1,70 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +# Copyright 2025 Collabora Ltd
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/firmware/mediatek,mt6991-hardware-voter.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: MediaTek Hardware Voter (HWV)
>>>> +
>>>> +maintainers:
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +
>>>> +description:
>>>> +  The MediaTek Hardware Voter (HWV) is a SoC-internal fixed-function MCU
>>>> +  used to collect votes from both the Application Processor and from the
>>>> +  various other remote processors present in the SoC, and transparently
>>>> +  turn on or off various hardware resources (for example, power domains
>>>> +  or system clocks) based on aggregation of votes done in the HWV MCU's
>>>> +  internal state machine, therefore guaranteeing synchronization of the
>>>> +  hardware resource requests between all components of the SoC and hence
>>>> +  avoiding, for example, unclocked or unpowered access to the hardware.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^system-controller@[0-9a-f]+$"
>>>> +
>>>> +  compatible:
>>>> +    const: mediatek,mt6991-hardware-voter
>>>> +
>>>> +  reg:
>>>> +    items:
>>>> +      - description: Address and size of the Hardware Voter MMIO
>>>> + 
>>>
>>> No resources here, so this should go to power controller
>>>
>>>> +  power-controller:
>>>> +    $ref: /schemas/power/mediatek,power-controller.yaml
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +
>>>> +additionalProperties: true
>>>> +
>>>> +examples:
>>>> + - |
>>>> +   scp_hwv: system-controller@14500000 {
>>>> +     compatible = "mediatek,mt6991-hardware-voter";
>>>> +     reg = <0 0x14500000 0 0x3000>;
>>>> +
>>>> +     power-controller {
>>>> +       compatible = "mediatek,mt8196-hwv-scp-power-controller"; 
>>>
>>> mt8196 in mt6991 is very confusing.
>>>
>>
>> Yeah that wasn't intentional; fyi, it's almost the same soc, that's why I mixed
>> them up... :-)
>>
>>> Anyway, this does not address my comment at all. You again create some
>>> sort of syscon for voting, so no. You are supposed to use generic API
>>> for voting: clocks, power domains, interconnects - whatever is there
>>> applicable or necessary.
>>>
>>
>> Making that loud and clear: Interconnect is not applicable.
>>
>> The only way to do what you're proposing would be to add a bunch of `reg`
>> to each devicetree node for each clock controller and each power controller;
>> I can do that, but looks a bit dirty - and still yet another syscon-like
>> alternative, but without having a real syscon declared in there.
>>
>> Mind you - both clock and power controllers are writing both to their own
>> register space (and enabling external regulators, etc, for power domains)
>> and to the hardware voter MMIO (which means that the HWV, in hardware, is
>> fundamentally broken).
>>
>> After this reply, the only option that is left to me is the following:
>>
>>          topckgen: clock-controller@10000000 {
>>              compatible = "mediatek,mt8196-topckgen", "syscon";
>>              reg = <0 0x10000000 0 0x800>, <0 0x14500010 0 0x48>,
>>                    <0 0x14502c08 0 0x24>;
>>              reg-names = "base", "hwvoter-base", "hwvoter-status";
>>              #clock-cells = <1>;
>>          };
>>
>>          imp_iic_wrap_north: clock-controller@13c30000 {
>>              compatible = "mediatek,mt8196-imp-iic-wrap-n", "syscon";
>>              reg = <0 0x13c30000 0 0x1000>, <0 0x14500000 0 0xc>,
>>                    <0 0x14502c00 0 0xc>;
>>              reg-names = "base", "hwvoter-base", "hwvoter-status";
>>              #clock-cells = <1>;
>>          };
>>
>>          /* Power Manager with Hardware Voter */
>>          spm_hwv: power-controller@14500218 {
>>              compatible = "mediatek,mt8196-hwv-scp-power-controller";
>>              reg = <0 0x14500218 0 0x20>, <0 0x14501410 0 0x20>,
>>                    <0 0x14505514 0 0xc>;
>>              reg-names = "hwvoter-base", "hwvoter-status", "hwvoter-ack";
>>              #address-cells = <1>;
>>              #size-cells = <0>;
>>              #power-domain-cells = <1>;
>>
>>              /* SCPSYS hardware voter power domains */
>>              mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC_DORMANT {
>>                  ..... etc, all power domains
>>
>> At this point, I'm really not sure that this would be better than just passing
>> the mediatek,hardware-voter syscon to the clock controllers - as what I've done
>> previously was effectively representing the hardware in the devicetree as it is,
>> matching the real HW layout 1:1 (because again, each of the whole HWV MCU(s) are
>> embedded into each of the two power controllers, one for System power, and one
>> for Multimedia power).
>>
>> (btw, hardware speaking, the power controller is child of a system controller:
>> there are two system controllers - "scpsystem" is for "compute part", and the
>> "hfrpsystem" is for the "multimedia part" of the soc).
>>
>>   _______________________________________
>> |                                       |
>> | SYSTEM CONTROLLER (SCPSYS or HFRPSYS) |
>> |   _____________________               |
>> |  |                     |              | <===> Clock Controllers (more than one)
>> |  | Power Controller    |     SOME     |       (provide subsystem clocks for iso
>> |  |                     |    OTHER     |        during power domain enablement
>> |  |     ______________  |   BLOCKS     |        even if a PD is voted)
>> |  |    |              | |              |       non-subsystem clocks are voted,
>> |  |    | HW Voter MCU | |              |       but subsystem ones are not voted
>> |  |    |______________| |              |
>> |  |_____________________|              | ===> Rest of the SoC
>> |_______________________________________|
>>
>>
>> Hence I'm asking you - does your idea still stand?
>>
>> Because after this, sorry for that - this doesn't want to be an attack - but
>> I'm starting to have doubts about an approach that doesn't involve syscons.
>>
>> Cheers,
>> Angelo 
>
> Sorry for the double reply, wanted to add some more words :-)
>
> As a note, I also thought about doing the following:
>
>     /* Secondary SCPSYS block with HWV capabilities */
>     scp1_hwv: system-controller@14500000 {
>         compatible = "mediatek,mt8196-scpsys", "syscon", "simple-mfd";
>         reg = <0 0x14500000 0 0x3000>;
>
>         /* SCP Power Manager with Hardware Voter */
>         spm_hwv: power-controller {
>             compatible = "mediatek,mt8196-hwv-scp-power-controller";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             #power-domain-cells = <1>;
>
>             /* SCPSYS hardware voter power domains */
>             mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC_DORMANT {
>             ..... etc etc
>             };
>         };
>
>         imp_iic_wrap_north: clock-controller@13c30000 {
>             compatible = "mediatek,mt8196-imp-iic-wrap-n", "syscon";
>             reg = <0 0x13c30000 0 0x1000>;
>             #clock-cells = <1>;
>         };
>     };
>
> ...but that's also not applicable, because the clock controllers are physically
> *not* inside of the scpsys1 block, so that would *also* misrepresent the hardware
> in the devicetree (besides still using a syscon in a way or another).
>
> So... I really don't see any way out of that, which really leaves me with the two
> options that I described in the previous reply.
>
> Summarizing, either:
>  - Adding hwv MMIOs (a bunch of, and each very small) to each clock controller (but
>    still all of them are poking at the same HWV controller, and I foresee that this
>    will backfire in some future iteration of the HWV hardware)
>  - Reverting back to using the "mediatek,hardware-voter" syscon, like done in
>    https://lore.kernel.org/20250624143220.244549-10-laura.nao@collabora.com
>
> I tried really hard and thought about this for weeks (actually, started even before
> your feedback on Laura's series), but now I'm out of practical options that are
> both correctly representing the hardware and not making the implementation fragile
> (or actually more fragile than the actually broken HW implementation's fragility,
> anyway).
>
> And besides - re-reading what I wrote after a bunch of days, the first option of
> adding a bunch of hwv mmios to all of the clock controllers is, in my opinion, a
> (dirty) hack - because those mmios don't belong to the clock controllers, and would
> again misrepresent the hardware in DT - especially keeping in mind the fact that
> the clock controllers can be controlled with *and* (not or) without the HWV (and in
> some instances, even if using HWV, we must still write to the clock controllers'
> mmio for extra programming, as explained before).
>
> Every second I think about this I get more and more convinced that my way of
> passing the SCPSYS-HWV system controller handle as a syscon is right.
>
> Angelo
>

I’ve given this some more thought over the past few days.

I can't see of any other viable alternative either, other than splitting 
up the HWV MMIOs into multiple tiny reg entries across each consumer 
node as mentioned..which feels fragile and wouldn't really be an accurate 
representation of the HW, given they all ultimately target the same HWV MCU.

All considered, modeling the HWV as a shared syscon passed to both clock 
and power controllers still seems to me like the more accurate 
representation of this specific hw layout, given both types of 
controllers interact with the same voter logic and MMIO region.

Krzysztof, does the approach with scattered small reg entries per clock 
controller seem as awkward to you as it does to us? are there any other 
directions you think we should explore here?

Best,

Laura

