Return-Path: <linux-kernel+bounces-731164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A377AB05040
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C824A3F56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE32C033B;
	Tue, 15 Jul 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/jOg/EH"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BE1B6CE4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554039; cv=none; b=MoFDwInOfZ8EJYGU1/AiVYp8VIjyiXo8CDkESGAMFIYSg0pJThEEgui1Af3TYIS3scAcfAI0+2HXU5FQ0UaHMeSGxRz1izSCI6DatLBZquYuGG3h2tPE263VlJ6ReoK7LOs6UFCytc8apZNwH9h3+21pN4/OpVRVwDKY8iPP44Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554039; c=relaxed/simple;
	bh=FOxgwnII6/eVg4E/3nnl9MuRLqfPOsJYiWbre0j2DhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrkkdB0F2YKZi+pejSQiae8dE0VVGA1cjT2VePLvMpxKiMycm3ctArYLXuA9Y0dJJX9iN5QYcnCcXltUXx/WL2TmyPXSSlJ0EUg5n1QGqcOBiOEcssr8yGReMY39mQJ+LCo/Miu2wCfCub/SmQvhXWGclTIAvcQ7wIJC/erx62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/jOg/EH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32ce252c3acso23909691fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752554035; x=1753158835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UENFYNOoNWpjIcdHl6EeeyZIE3QIPB2VQaDR+AO/Djo=;
        b=A/jOg/EHKJZdk3i/WJ4Rv1PL2fSp7Zi9uAkzwMzBPNv1pk+lI5lIJkX28iOF23frKc
         oa6fLezAsV53/+kwEDxa7o0EKBhupGMRUYhi2rWYHsYPOeycl+F0zt1eh3WpH8YJM035
         bM4mcAD3U7fLdDk9OV8coJsy/m92DDIerMwjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752554035; x=1753158835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UENFYNOoNWpjIcdHl6EeeyZIE3QIPB2VQaDR+AO/Djo=;
        b=Xe+Ofrcvi2htI392bSZ7JXxTrfvEEmk28+VA105KAsPKRvOWoIBvjb8gHW5CIg6e+I
         NOkFl2JAiplH28wG3E+leM35qaDe2mbg10nGuy7JkyP9Pr8y7bwakCJS1dOpTtxeCzrg
         MZTHtqDJbH1e4IbpSRueMwveF6AdugJP7YTp9NJcKqbhWtg3HIAlZeXHcUnSY3KX2sY3
         CVlT2O/jT5dsCvJSor9i/oJu73wIK2czi/39LnUM4/zAY5VqSFrh5drsy6u/CvKVMbJJ
         RSmGe/6yOM03aRoUrj/XWl42uPOIsWf1F7NhP0F71YpUDz3MK8fzUS/i8UpZ9O3Qc5m5
         hCQA==
X-Forwarded-Encrypted: i=1; AJvYcCW7JIw444RmhSpmBLIng0VMW2msakbQ5emQV0/m67fmd7gIFSlFD5DIMpGFsWjq3wDJOF1CzfaGLx/hbw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrWUimM1ks+lQlDZS4Hoth1NJ2dbFt5u+lPd9xbuWOc//e5Bo
	qQE8PZXxhe5UdLOWdmICvgBQcv0keyzvd34nckXFlp100FfjVNgDfB4Tvw12kQpeVcKkT1wgGpq
	RQgdwtpqzULKSsFD1veV0R+ola2gtaVuiKiROsRAj
X-Gm-Gg: ASbGncv4rg02BnmcPfPh5GaJjXC16txrlnB1d5J+31N8J7b1da5Kzf54Xk5bJr7FiUQ
	hP4a2glwsN/WzqRC3Adblp4cELZ4Tju0bvMTDD7v29JL6398/6j4zqsE6jKAi2VY6AjWQ60xirs
	6+yeZ/PTvSIq47r7Mo4014DUBuTJQkbNe8iiNBhTvOwTXTh49G12lxSJ2RTEAvR45CzzbbyTudI
	KSJSoq8yxo5fQgWxBSZIGfnLE+N6ZV4L5s=
X-Google-Smtp-Source: AGHT+IGT42IK43/qmuJkYbs0B4NDx4DnQZ7A6On/J08wsMTVxqrrSOxinBGIjC1Xv+05ywz7QVbCGKdiqwYy49BtWHU=
X-Received: by 2002:a2e:96cf:0:b0:32a:666e:9f14 with SMTP id
 38308e7fff4ca-330533d4946mr36098621fa.19.1752554034785; Mon, 14 Jul 2025
 21:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9560d4d2-5346-4d0a-a96f-c96ebe335f3c@collabora.com> <20250710141941.75843-1-laura.nao@collabora.com>
In-Reply-To: <20250710141941.75843-1-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Jul 2025 12:33:42 +0800
X-Gm-Features: Ac12FXwNcWWWFDsXlYNBMHE507zSJPdaLhNF9Htt5k2XbSwWXHodlW0LQNdN1Js
Message-ID: <CAGXv+5Gzk2hDYFWTsN6V6LOfNyfrYg1ZqhsUHfTJMpOWh6f9ew@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] dt-bindings: firmware: Document the MediaTek
 Hardware Voter (HWV)
To: Laura Nao <laura.nao@collabora.com>
Cc: angelogioacchino.delregno@collabora.com, arnd@arndb.de, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, drew@pdp7.com, 
	gregkh@linuxfoundation.org, kabel@kernel.org, kernel@collabora.com, 
	khilman@baylibre.com, krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	m.wilczynski@samsung.com, matthias.bgg@gmail.com, nm@ti.com, 
	pjp@fedoraproject.org, quic_hyiwei@quicinc.com, robh@kernel.org, 
	tudor.ambarus@linaro.org, u.kleine-koenig@baylibre.com, 
	ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:28=E2=80=AFAM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> On 7/7/25 12:40, AngeloGioacchino Del Regno wrote:
> > Il 03/07/25 10:56, AngeloGioacchino Del Regno ha scritto:
> >> Il 02/07/25 08:50, Krzysztof Kozlowski ha scritto:
> >>> On Tue, Jul 01, 2025 at 05:11:48PM +0200, AngeloGioacchino Del Regno =
wrote:
> >>>> Add documentation for the new MediaTek Hardware Voter, found in
> >>>> MediaTek SoCs like the MT8196 Kompanio Ultra for Chromebooks and
> >>>> the MT6991 Dimensity 9400 for Smartphones.
> >>>>
> >>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno=
@collabora.com>
> >>>> ---
> >>>>   .../mediatek,mt6991-hardware-voter.yaml       | 70 +++++++++++++++=
++++
> >>>>   1 file changed, 70 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/firmware/medi=
atek,mt6991- hardware-voter.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/firmware/mediatek,mt6=
991- hardware-voter.yaml b/Documentation/devicetree/bindings/firmware/ medi=
atek,mt6991-hardware-voter.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..173b74c23a91
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/firmware/mediatek,mt6991-har=
dware- voter.yaml
> >>>> @@ -0,0 +1,70 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>> +# Copyright 2025 Collabora Ltd
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/firmware/mediatek,mt6991-hardwar=
e-voter.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: MediaTek Hardware Voter (HWV)
> >>>> +
> >>>> +maintainers:
> >>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> >>>> +
> >>>> +description:
> >>>> +  The MediaTek Hardware Voter (HWV) is a SoC-internal fixed-functio=
n MCU
> >>>> +  used to collect votes from both the Application Processor and fro=
m the
> >>>> +  various other remote processors present in the SoC, and transpare=
ntly
> >>>> +  turn on or off various hardware resources (for example, power dom=
ains
> >>>> +  or system clocks) based on aggregation of votes done in the HWV M=
CU's
> >>>> +  internal state machine, therefore guaranteeing synchronization of=
 the
> >>>> +  hardware resource requests between all components of the SoC and =
hence
> >>>> +  avoiding, for example, unclocked or unpowered access to the hardw=
are.
> >>>> +
> >>>> +properties:
> >>>> +  $nodename:
> >>>> +    pattern: "^system-controller@[0-9a-f]+$"
> >>>> +
> >>>> +  compatible:
> >>>> +    const: mediatek,mt6991-hardware-voter
> >>>> +
> >>>> +  reg:
> >>>> +    items:
> >>>> +      - description: Address and size of the Hardware Voter MMIO
> >>>> +
> >>>
> >>> No resources here, so this should go to power controller
> >>>
> >>>> +  power-controller:
> >>>> +    $ref: /schemas/power/mediatek,power-controller.yaml
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - reg
> >>>> +
> >>>> +additionalProperties: true
> >>>> +
> >>>> +examples:
> >>>> + - |
> >>>> +   scp_hwv: system-controller@14500000 {
> >>>> +     compatible =3D "mediatek,mt6991-hardware-voter";
> >>>> +     reg =3D <0 0x14500000 0 0x3000>;
> >>>> +
> >>>> +     power-controller {
> >>>> +       compatible =3D "mediatek,mt8196-hwv-scp-power-controller";
> >>>
> >>> mt8196 in mt6991 is very confusing.
> >>>
> >>
> >> Yeah that wasn't intentional; fyi, it's almost the same soc, that's wh=
y I mixed
> >> them up... :-)
> >>
> >>> Anyway, this does not address my comment at all. You again create som=
e
> >>> sort of syscon for voting, so no. You are supposed to use generic API
> >>> for voting: clocks, power domains, interconnects - whatever is there
> >>> applicable or necessary.
> >>>
> >>
> >> Making that loud and clear: Interconnect is not applicable.
> >>
> >> The only way to do what you're proposing would be to add a bunch of `r=
eg`
> >> to each devicetree node for each clock controller and each power contr=
oller;
> >> I can do that, but looks a bit dirty - and still yet another syscon-li=
ke
> >> alternative, but without having a real syscon declared in there.
> >>
> >> Mind you - both clock and power controllers are writing both to their =
own
> >> register space (and enabling external regulators, etc, for power domai=
ns)
> >> and to the hardware voter MMIO (which means that the HWV, in hardware,=
 is
> >> fundamentally broken).
> >>
> >> After this reply, the only option that is left to me is the following:
> >>
> >>          topckgen: clock-controller@10000000 {
> >>              compatible =3D "mediatek,mt8196-topckgen", "syscon";
> >>              reg =3D <0 0x10000000 0 0x800>, <0 0x14500010 0 0x48>,
> >>                    <0 0x14502c08 0 0x24>;
> >>              reg-names =3D "base", "hwvoter-base", "hwvoter-status";
> >>              #clock-cells =3D <1>;
> >>          };
> >>
> >>          imp_iic_wrap_north: clock-controller@13c30000 {
> >>              compatible =3D "mediatek,mt8196-imp-iic-wrap-n", "syscon"=
;
> >>              reg =3D <0 0x13c30000 0 0x1000>, <0 0x14500000 0 0xc>,
> >>                    <0 0x14502c00 0 0xc>;
> >>              reg-names =3D "base", "hwvoter-base", "hwvoter-status";
> >>              #clock-cells =3D <1>;
> >>          };
> >>
> >>          /* Power Manager with Hardware Voter */
> >>          spm_hwv: power-controller@14500218 {
> >>              compatible =3D "mediatek,mt8196-hwv-scp-power-controller"=
;
> >>              reg =3D <0 0x14500218 0 0x20>, <0 0x14501410 0 0x20>,
> >>                    <0 0x14505514 0 0xc>;
> >>              reg-names =3D "hwvoter-base", "hwvoter-status", "hwvoter-=
ack";
> >>              #address-cells =3D <1>;
> >>              #size-cells =3D <0>;
> >>              #power-domain-cells =3D <1>;
> >>
> >>              /* SCPSYS hardware voter power domains */
> >>              mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC=
_DORMANT {
> >>                  ..... etc, all power domains
> >>
> >> At this point, I'm really not sure that this would be better than just=
 passing
> >> the mediatek,hardware-voter syscon to the clock controllers - as what =
I've done
> >> previously was effectively representing the hardware in the devicetree=
 as it is,
> >> matching the real HW layout 1:1 (because again, each of the whole HWV =
MCU(s) are
> >> embedded into each of the two power controllers, one for System power,=
 and one
> >> for Multimedia power).
> >>
> >> (btw, hardware speaking, the power controller is child of a system con=
troller:
> >> there are two system controllers - "scpsystem" is for "compute part", =
and the
> >> "hfrpsystem" is for the "multimedia part" of the soc).
> >>
> >>   _______________________________________
> >> |                                       |
> >> | SYSTEM CONTROLLER (SCPSYS or HFRPSYS) |
> >> |   _____________________               |
> >> |  |                     |              | <=3D=3D=3D> Clock Controller=
s (more than one)
> >> |  | Power Controller    |     SOME     |       (provide subsystem clo=
cks for iso
> >> |  |                     |    OTHER     |        during power domain e=
nablement
> >> |  |     ______________  |   BLOCKS     |        even if a PD is voted=
)
> >> |  |    |              | |              |       non-subsystem clocks a=
re voted,
> >> |  |    | HW Voter MCU | |              |       but subsystem ones are=
 not voted
> >> |  |    |______________| |              |
> >> |  |_____________________|              | =3D=3D=3D> Rest of the SoC
> >> |_______________________________________|
> >>
> >>
> >> Hence I'm asking you - does your idea still stand?
> >>
> >> Because after this, sorry for that - this doesn't want to be an attack=
 - but
> >> I'm starting to have doubts about an approach that doesn't involve sys=
cons.
> >>
> >> Cheers,
> >> Angelo
> >
> > Sorry for the double reply, wanted to add some more words :-)
> >
> > As a note, I also thought about doing the following:
> >
> >     /* Secondary SCPSYS block with HWV capabilities */
> >     scp1_hwv: system-controller@14500000 {
> >         compatible =3D "mediatek,mt8196-scpsys", "syscon", "simple-mfd"=
;
> >         reg =3D <0 0x14500000 0 0x3000>;
> >
> >         /* SCP Power Manager with Hardware Voter */
> >         spm_hwv: power-controller {
> >             compatible =3D "mediatek,mt8196-hwv-scp-power-controller";
> >             #address-cells =3D <1>;
> >             #size-cells =3D <0>;
> >             #power-domain-cells =3D <1>;
> >
> >             /* SCPSYS hardware voter power domains */
> >             mm_proc_dormant: power-domain@MT8196_POWER_DOMAIN_MM_PROC_D=
ORMANT {
> >             ..... etc etc
> >             };
> >         };
> >
> >         imp_iic_wrap_north: clock-controller@13c30000 {
> >             compatible =3D "mediatek,mt8196-imp-iic-wrap-n", "syscon";
> >             reg =3D <0 0x13c30000 0 0x1000>;
> >             #clock-cells =3D <1>;
> >         };
> >     };
> >
> > ...but that's also not applicable, because the clock controllers are ph=
ysically
> > *not* inside of the scpsys1 block, so that would *also* misrepresent th=
e hardware
> > in the devicetree (besides still using a syscon in a way or another).
> >
> > So... I really don't see any way out of that, which really leaves me wi=
th the two
> > options that I described in the previous reply.
> >
> > Summarizing, either:
> >  - Adding hwv MMIOs (a bunch of, and each very small) to each clock con=
troller (but
> >    still all of them are poking at the same HWV controller, and I fores=
ee that this
> >    will backfire in some future iteration of the HWV hardware)
> >  - Reverting back to using the "mediatek,hardware-voter" syscon, like d=
one in
> >    https://lore.kernel.org/20250624143220.244549-10-laura.nao@collabora=
.com
> >
> > I tried really hard and thought about this for weeks (actually, started=
 even before
> > your feedback on Laura's series), but now I'm out of practical options =
that are
> > both correctly representing the hardware and not making the implementat=
ion fragile
> > (or actually more fragile than the actually broken HW implementation's =
fragility,
> > anyway).
> >
> > And besides - re-reading what I wrote after a bunch of days, the first =
option of
> > adding a bunch of hwv mmios to all of the clock controllers is, in my o=
pinion, a
> > (dirty) hack - because those mmios don't belong to the clock controller=
s, and would
> > again misrepresent the hardware in DT - especially keeping in mind the =
fact that
> > the clock controllers can be controlled with *and* (not or) without the=
 HWV (and in
> > some instances, even if using HWV, we must still write to the clock con=
trollers'
> > mmio for extra programming, as explained before).
> >
> > Every second I think about this I get more and more convinced that my w=
ay of
> > passing the SCPSYS-HWV system controller handle as a syscon is right.
> >
> > Angelo
> >
>
> I=E2=80=99ve given this some more thought over the past few days.
>
> I can't see of any other viable alternative either, other than splitting
> up the HWV MMIOs into multiple tiny reg entries across each consumer
> node as mentioned..which feels fragile and wouldn't really be an accurate
> representation of the HW, given they all ultimately target the same HWV M=
CU.
>
> All considered, modeling the HWV as a shared syscon passed to both clock
> and power controllers still seems to me like the more accurate
> representation of this specific hw layout, given both types of
> controllers interact with the same voter logic and MMIO region.
>
> Krzysztof, does the approach with scattered small reg entries per clock
> controller seem as awkward to you as it does to us? are there any other
> directions you think we should explore here?

Just to add to the argument, the hardware voter is really just an
alternative interface to the same clock or power controller; it is
not a separate controller. Trying to model it as such means you end
up with two devices fighting over control over the same hardware.

It really should be *one* clock controller with an alternative address
space. How we choose to model the hardware voter address space is up
for debate as Laura mentioned, but modeling it as another clock
controller is misrepresenting the hardware at best, and causing more
confusion for the implementation at worst.

ChenYu

