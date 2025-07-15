Return-Path: <linux-kernel+bounces-731351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFDB0530F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680173A45AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6582E0901;
	Tue, 15 Jul 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iJpeS8Yx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C992E0413;
	Tue, 15 Jul 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563991; cv=none; b=ez8k61yeSEkds/EoawCfa8VPkLG/WH0awQ7+fyWVoPMbsBliGSPOsYiNDSPbDFwgMmnN9V0HxrVTkeQnAmw2xfiU03y5ZjalqnqQbG0wTIZQUyRrv+VDxYy7vX4cq3bK45Mw+LwoFFJAtC7/0xkU+rhcA+ZVegfXnET9VWP0AIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563991; c=relaxed/simple;
	bh=m61E355kAgNwnf61mkfbfDOJYnKhUsup2CvOlC/E3P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMT8K9NSrJ/6EnyuWtJzjBnjj4OfFcgdM8qW6i0BQliQkl3no+lkfwLjPOFGTesRU7Bv04pwefySC/fhwju7R3X1g1BwzOXbACOfCtL47qho5wfmEfUhVNR/kpbZljDwe0ecxHYzwDYdJIm29bEU5xsqlUBa6EqJvvc6AY+3R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iJpeS8Yx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752563986;
	bh=m61E355kAgNwnf61mkfbfDOJYnKhUsup2CvOlC/E3P4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iJpeS8YxtXjMm7UrtrdbB9W/P8pPaAyqV7+kPnj0Cnh5pB3XsIh9W6Vg4qQ8ZgPHF
	 hUgc7TKCeD66evevdVQ46UFKE9CWxD99Yt12mvL5ogjmTomte+VlwH4Jc3rMsw/eEq
	 NX71b4Pn6JyFePTtCCEijKg2mzRT5LC6EWTbRdLzDkT14vACxKlvm/74ljzr17FHB6
	 RwWi2ptikPr+qAvdfMY82y0DlKmbJ8FX9Os1cG9iRfnAiFjcnbcP/e/CPsVNyDM4Ng
	 M7LcDbGc11gsS2pSWp1X0sTLC2lZQ8FgsRigkqkGC1GVOYQ3jye12S1FaCflUklNnd
	 JUEsJglGKw6QQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 37D1B17E0676;
	Tue, 15 Jul 2025 09:19:45 +0200 (CEST)
Message-ID: <242bf682-cf8f-4469-8a0b-9ec982095f04@collabora.com>
Date: Tue, 15 Jul 2025 09:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] dt-bindings: firmware: Document the MediaTek
 Hardware Voter (HWV)
To: Chen-Yu Tsai <wenst@chromium.org>, Laura Nao <laura.nao@collabora.com>
Cc: arnd@arndb.de, conor+dt@kernel.org, devicetree@vger.kernel.org,
 drew@pdp7.com, gregkh@linuxfoundation.org, kabel@kernel.org,
 kernel@collabora.com, khilman@baylibre.com, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, m.wilczynski@samsung.com,
 matthias.bgg@gmail.com, nm@ti.com, pjp@fedoraproject.org,
 quic_hyiwei@quicinc.com, robh@kernel.org, tudor.ambarus@linaro.org,
 u.kleine-koenig@baylibre.com, ulf.hansson@linaro.org
References: <9560d4d2-5346-4d0a-a96f-c96ebe335f3c@collabora.com>
 <20250710141941.75843-1-laura.nao@collabora.com>
 <CAGXv+5Gzk2hDYFWTsN6V6LOfNyfrYg1ZqhsUHfTJMpOWh6f9ew@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5Gzk2hDYFWTsN6V6LOfNyfrYg1ZqhsUHfTJMpOWh6f9ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/07/25 06:33, Chen-Yu Tsai ha scritto:
> On Fri, Jul 11, 2025 at 12:28 AM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> On 7/7/25 12:40, AngeloGioacchino Del Regno wrote:
>>> Il 03/07/25 10:56, AngeloGioacchino Del Regno ha scritto:
>>>> Il 02/07/25 08:50, Krzysztof Kozlowski ha scritto:
>>>>> On Tue, Jul 01, 2025 at 05:11:48PM +0200, AngeloGioacchino Del Regno wrote:
>>>>>> Add documentation for the new MediaTek Hardware Voter, found in
>>>>>> MediaTek SoCs like the MT8196 Kompanio Ultra for Chromebooks and
>>>>>> the MT6991 Dimensity 9400 for Smartphones.
>>>>>>
>>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>    .../mediatek,mt6991-hardware-voter.yaml       | 70 +++++++++++++++++++
>>>>>>    1 file changed, 70 insertions(+)
>>>>>>    create mode 100644 Documentation/devicetree/bindings/firmware/mediatek,mt6991- hardware-voter.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/mediatek,mt6991- hardware-voter.yaml b/Documentation/devicetree/bindings/firmware/ mediatek,mt6991-hardware-voter.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..173b74c23a91
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/firmware/mediatek,mt6991-hardware- voter.yaml
>>>>>> @@ -0,0 +1,70 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +# Copyright 2025 Collabora Ltd
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/firmware/mediatek,mt6991-hardware-voter.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: MediaTek Hardware Voter (HWV)
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> +
>>>>>> +description:
>>>>>> +  The MediaTek Hardware Voter (HWV) is a SoC-internal fixed-function MCU
>>>>>> +  used to collect votes from both the Application Processor and from the
>>>>>> +  various other remote processors present in the SoC, and transparently
>>>>>> +  turn on or off various hardware resources (for example, power domains
>>>>>> +  or system clocks) based on aggregation of votes done in the HWV MCU's
>>>>>> +  internal state machine, therefore guaranteeing synchronization of the
>>>>>> +  hardware resource requests between all components of the SoC and hence
>>>>>> +  avoiding, for example, unclocked or unpowered access to the hardware.
>>>>>> +
>>>>>> +properties:
>>>>>> +  $nodename:
>>>>>> +    pattern: "^system-controller@[0-9a-f]+$"
>>>>>> +
>>>>>> +  compatible:
>>>>>> +    const: mediatek,mt6991-hardware-voter
>>>>>> +
>>>>>> +  reg:
>>>>>> +    items:
>>>>>> +      - description: Address and size of the Hardware Voter MMIO
>>>>>> +
>>>>>
>>>>> No resources here, so this should go to power controller
>>>>>
>>>>>> +  power-controller:
>>>>>> +    $ref: /schemas/power/mediatek,power-controller.yaml
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +
>>>>>> +additionalProperties: true
>>>>>> +
>>>>>> +examples:
>>>>>> + - |
>>>>>> +   scp_hwv: system-controller@14500000 {
>>>>>> +     compatible = "mediatek,mt6991-hardware-voter";
>>>>>> +     reg = <0 0x14500000 0 0x3000>;
>>>>>> +
>>>>>> +     power-controller {
>>>>>> +       compatible = "mediatek,mt8196-hwv-scp-power-controller";
>>>>>
>>>>> mt8196 in mt6991 is very confusing.
>>>>>
>>>>
>>>> Yeah that wasn't intentional; fyi, it's almost the same soc, that's why I mixed
>>>> them up... :-)
>>>>
>>>>> Anyway, this does not address my comment at all. You again create some
>>>>> sort of syscon for voting, so no. You are supposed to use generic API
>>>>> for voting: clocks, power domains, interconnects - whatever is there
>>>>> applicable or necessary.
>>>>>
>>>>
>>>> Making that loud and clear: Interconnect is not applicable.
>>>>
>>>> The only way to do what you're proposing would be to add a bunch of `reg`
>>>> to each devicetree node for each clock controller and each power controller;
>>>> I can do that, but looks a bit dirty - and still yet another syscon-like
>>>> alternative, but without having a real syscon declared in there.
>>>>
>>>> Mind you - both clock and power controllers are writing both to their own
>>>> register space (and enabling external regulators, etc, for power domains)
>>>> and to the hardware voter MMIO (which means that the HWV, in hardware, is
>>>> fundamentally broken).
>>>>
>>>> After this reply, the only option that is left to me is the following:
>>>>
>>>>           topckgen: clock-controller@10000000 {
>>>>               compatible = "mediatek,mt8196-topckgen", "syscon";
>>>>               reg = <0 0x10000000 0 0x800>, <0 0x14500010 0 0x48>,
>>>>                     <0 0x14502c08 0 0x24>;
>>>>               reg-names = "base", "hwvoter-base", "hwvoter-status";
>>>>               #clock-cells = <1>;
>>>>           };
>>>>
>>>>           imp_iic_wrap_north: clock-controller@13c30000 {
>>>>               compatible = "mediatek,mt8196-imp-iic-wrap-n", "syscon";
>>>>               reg = <0 0x13c30000 0 0x1000>, <0 0x14500000 0 0xc>,
>>>>                     <0 0x14502c00 0 0xc>;
>>>>               reg-names = "base", "hwvoter-base", "hwvoter-status";
>>>>               #clock-cells = <1>;
>>>>           };
>>>>
>>>>           /* Power Manager with Hardware Voter */
>>>>           spm_hwv: power-controller@14500218 {
>>>>               compatible = "mediatek,mt8196-hwv-scp-power-controller";
>>>>               reg = <0 0x14500218 0 0x20>, <0 0x14501410 0 0x20>,
>>>>                     <0 0x14505514 0 0xc>;
>>>>               reg-names = "hwvoter-base", "hwvoter-status", "hwvoter-ack";
>>>>               #address-cells = <1>;
>>>>               #size-cells = <0>;
>>>>               #power-domain-cells = <1>;
>>>>
>>>>               /* SCPSYS hardware voter power domains */
>>>>               mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC_DORMANT {
>>>>                   ..... etc, all power domains
>>>>
>>>> At this point, I'm really not sure that this would be better than just passing
>>>> the mediatek,hardware-voter syscon to the clock controllers - as what I've done
>>>> previously was effectively representing the hardware in the devicetree as it is,
>>>> matching the real HW layout 1:1 (because again, each of the whole HWV MCU(s) are
>>>> embedded into each of the two power controllers, one for System power, and one
>>>> for Multimedia power).
>>>>
>>>> (btw, hardware speaking, the power controller is child of a system controller:
>>>> there are two system controllers - "scpsystem" is for "compute part", and the
>>>> "hfrpsystem" is for the "multimedia part" of the soc).
>>>>
>>>>    _______________________________________
>>>> |                                       |
>>>> | SYSTEM CONTROLLER (SCPSYS or HFRPSYS) |
>>>> |   _____________________               |
>>>> |  |                     |              | <===> Clock Controllers (more than one)
>>>> |  | Power Controller    |     SOME     |       (provide subsystem clocks for iso
>>>> |  |                     |    OTHER     |        during power domain enablement
>>>> |  |     ______________  |   BLOCKS     |        even if a PD is voted)
>>>> |  |    |              | |              |       non-subsystem clocks are voted,
>>>> |  |    | HW Voter MCU | |              |       but subsystem ones are not voted
>>>> |  |    |______________| |              |
>>>> |  |_____________________|              | ===> Rest of the SoC
>>>> |_______________________________________|
>>>>
>>>>
>>>> Hence I'm asking you - does your idea still stand?
>>>>
>>>> Because after this, sorry for that - this doesn't want to be an attack - but
>>>> I'm starting to have doubts about an approach that doesn't involve syscons.
>>>>
>>>> Cheers,
>>>> Angelo
>>>
>>> Sorry for the double reply, wanted to add some more words :-)
>>>
>>> As a note, I also thought about doing the following:
>>>
>>>      /* Secondary SCPSYS block with HWV capabilities */
>>>      scp1_hwv: system-controller@14500000 {
>>>          compatible = "mediatek,mt8196-scpsys", "syscon", "simple-mfd";
>>>          reg = <0 0x14500000 0 0x3000>;
>>>
>>>          /* SCP Power Manager with Hardware Voter */
>>>          spm_hwv: power-controller {
>>>              compatible = "mediatek,mt8196-hwv-scp-power-controller";
>>>              #address-cells = <1>;
>>>              #size-cells = <0>;
>>>              #power-domain-cells = <1>;
>>>
>>>              /* SCPSYS hardware voter power domains */
>>>              mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC_DORMANT {
>>>              ..... etc etc
>>>              };
>>>          };
>>>
>>>          imp_iic_wrap_north: clock-controller@13c30000 {
>>>              compatible = "mediatek,mt8196-imp-iic-wrap-n", "syscon";
>>>              reg = <0 0x13c30000 0 0x1000>;
>>>              #clock-cells = <1>;
>>>          };
>>>      };
>>>
>>> ...but that's also not applicable, because the clock controllers are physically
>>> *not* inside of the scpsys1 block, so that would *also* misrepresent the hardware
>>> in the devicetree (besides still using a syscon in a way or another).
>>>
>>> So... I really don't see any way out of that, which really leaves me with the two
>>> options that I described in the previous reply.
>>>
>>> Summarizing, either:
>>>   - Adding hwv MMIOs (a bunch of, and each very small) to each clock controller (but
>>>     still all of them are poking at the same HWV controller, and I foresee that this
>>>     will backfire in some future iteration of the HWV hardware)
>>>   - Reverting back to using the "mediatek,hardware-voter" syscon, like done in
>>>     https://lore.kernel.org/20250624143220.244549-10-laura.nao@collabora.com
>>>
>>> I tried really hard and thought about this for weeks (actually, started even before
>>> your feedback on Laura's series), but now I'm out of practical options that are
>>> both correctly representing the hardware and not making the implementation fragile
>>> (or actually more fragile than the actually broken HW implementation's fragility,
>>> anyway).
>>>
>>> And besides - re-reading what I wrote after a bunch of days, the first option of
>>> adding a bunch of hwv mmios to all of the clock controllers is, in my opinion, a
>>> (dirty) hack - because those mmios don't belong to the clock controllers, and would
>>> again misrepresent the hardware in DT - especially keeping in mind the fact that
>>> the clock controllers can be controlled with *and* (not or) without the HWV (and in
>>> some instances, even if using HWV, we must still write to the clock controllers'
>>> mmio for extra programming, as explained before).
>>>
>>> Every second I think about this I get more and more convinced that my way of
>>> passing the SCPSYS-HWV system controller handle as a syscon is right.
>>>
>>> Angelo
>>>
>>
>> I’ve given this some more thought over the past few days.
>>
>> I can't see of any other viable alternative either, other than splitting
>> up the HWV MMIOs into multiple tiny reg entries across each consumer
>> node as mentioned..which feels fragile and wouldn't really be an accurate
>> representation of the HW, given they all ultimately target the same HWV MCU.
>>
>> All considered, modeling the HWV as a shared syscon passed to both clock
>> and power controllers still seems to me like the more accurate
>> representation of this specific hw layout, given both types of
>> controllers interact with the same voter logic and MMIO region.
>>
>> Krzysztof, does the approach with scattered small reg entries per clock
>> controller seem as awkward to you as it does to us? are there any other
>> directions you think we should explore here?
> 
> Just to add to the argument, the hardware voter is really just an
> alternative interface to the same clock or power controller; it is
> not a separate controller. Trying to model it as such means you end
> up with two devices fighting over control over the same hardware.
> 
> It really should be *one* clock controller with an alternative address
> space. How we choose to model the hardware voter address space is up
> for debate as Laura mentioned, but modeling it as another clock
> controller is misrepresenting the hardware at best, and causing more
> confusion for the implementation at worst.
> 
> ChenYu

Alright.
Let's go back to the previously proposed "mediatek,hardware-voter" way then.

Regarding that to be a single clock controller, I'm afraid that won't really be
possible because not all clocks in a single domain are voted - especially the
mux-gate clocks can't really be put in one single clock controller because to
manage those we have to write to the HWV *and* to the clock controller MMIO in the
same operation in order to actually manage the clock.

If that wasn't the case, I would've been happier to have all of the HWV clocks in
one clock controller (even though those belong to different SoC subsystems)...
...but let's see if we can (and if it makes sense to) aggregate at least some!

Thanks everyone!

Cheers,
Angelo

