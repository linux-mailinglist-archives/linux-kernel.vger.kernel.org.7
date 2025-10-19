Return-Path: <linux-kernel+bounces-859818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD2BEEAD6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C31189736D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE602E1F13;
	Sun, 19 Oct 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXC1seOh"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1A134AB
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760894775; cv=none; b=IIHDrxXbbimTeDi+1VpYOjHO+K8hszyHZ1BoP79xbJ3d0lBxro+jO7s13ytpMdz42Ke7mvh2AO/nDeZFHGt1g839lCJRPCqJnsY0mrdRC8SN5o/5C8bWCgMuKBx3zImH6S+IGRofuB2lREsQ4pZDDzx1QH1/oHNt3Ove/Eg3TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760894775; c=relaxed/simple;
	bh=tY+of9fymNrfMrfVCzbAi5At2Tdm4yqQDQ2JYQ1Bks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBAIn5zjVGPPiQbCoj+R9fhymCx923Is5n266sQXrzcK9/fh8Sect2ZKPtmw3GhTy49O71ko5HVhOIpufBeS3zJHmT41RyHC247U8tbGSwNlcrkMn85gsFYngdEDyoRXYffEduyK4RpbNoox/rECDTzBrlXtOcN2VsbVLHYoZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXC1seOh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so3052132a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760894771; x=1761499571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcGvpPgDi7UhVRE9urqo3zdP9h64sZLMpPk0fu55Wjc=;
        b=MXC1seOhqsyfVXWo6CwLRy54IFaK4rOGL8tO2CrWm1x+cAj1jyud/x3gTEgtiy1ASC
         brHEOtczv+pgzE5ujj+a49Pv1ngk66x5Sici/+m/m8zqOpz9Li2/JNsokKCHZ+774Btw
         boRfaTLyiQ6Ckc3aF/viU76CHwonh5ej9F9nlkM5XSwKsuxVz3+lhwjhkN/Q85JOwm/D
         oZtxfhphNRbEM0qGGXGdUUpoQkAEuuicFnUVr0dMa9jmNNWj8PJZpp9zBTyPhRHKYKCp
         G++DdfrzueKD7MqiLHSOokr9UYkGo/JDFrwIjuVoiD8ruYxszT6U7tPir/8hdGQ/dNlW
         RWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760894771; x=1761499571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcGvpPgDi7UhVRE9urqo3zdP9h64sZLMpPk0fu55Wjc=;
        b=wYQeJ6ucdhqSeFhcPoSWrtlujYRbrwC2Ttf7K46VkpEPPOEskXPudaw0a65X729hvr
         Xk/2Py6KiUIPupF9c+EFk+QNRb+mJLjUvN+lNniahfjhNPGXLABnKKyU0YK/oeC697Ou
         JtiHQxrVzmPuiigl4dSsZSmJKURl4C+9zFjGt8LV9osVOejPkxxvth/GD42Uq7e48sZE
         PIo4hC1FqGKeU4Z8ftFDfKrNbGyJ11peMxQZzwNYNTUYFD3JtxiNfIq27hztpL32PhUC
         4ApFhCA7Zt06Hx/0PFKUmI9E18mMrTjIen00+6CAccpY/7UG5L4KgCkbF82fRMGn7NXO
         2U9A==
X-Forwarded-Encrypted: i=1; AJvYcCXRoFhj6ifNong+FkwjczU4L8NuxiEYjeZ+NIjwDlxSTWmOv2/rb/uibZG8utT4+Ioj2yN/RBbVIu7bkzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVWnBr6b1RfbNTYpNQ90NpY8vWWAGae43nlXqm3SN7ZZAGycx
	VfbUN+9dfvzrsRNhSkbonIAVd02pGIvWok90CUaHNm1GikzSDTyEjNF14KqtlgBpdcAodKjv8WB
	cSfZs+cmFvGwfOid2CshgihmA7Jl1tfE=
X-Gm-Gg: ASbGncsQ+tw0bctZFDTufSK/0LEEwD9xbePgzI6KYeNDib4o1ItNOBx27f9ecHl/Nlx
	D0w3otgJprI4SIyWB8uCdSZShJAei0JezaL3SKPQDo8hL1+1LEro9STaBQaoyYi0nf5sstgfSws
	TOpSMLKDj0B/f9KYVRHWKFgLCCFWCOVUHZCLrJsNuSKp15r85R4+D4tZztWFg5DIa7d7i7bboGd
	XQEyk4VtVubDe8O1nimZyCFgSQLA4MgFmaPd3uDUofdOQA1PR/m5NkkORw=
X-Google-Smtp-Source: AGHT+IGFfd5J/ysr3ek+IDavp0eOZzca1RD3tVOMVHu17l6EPjX9/ntDT7tc4dh0oH9ur/ZRJY759LCgAfbwJubVr2k=
X-Received: by 2002:a05:6402:f23:b0:63c:eb9:478c with SMTP id
 4fb4d7f45d1cf-63c1f640c48mr7170724a12.14.1760894771292; Sun, 19 Oct 2025
 10:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com> <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
 <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
 <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org> <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
 <de5e8643-49bb-4e0e-45fd-51b25ecf530d@manjaro.org>
In-Reply-To: <de5e8643-49bb-4e0e-45fd-51b25ecf530d@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 22:55:53 +0530
X-Gm-Features: AS18NWAFmg8ydtYWZAF7B0PEQDmwlJtX2b2P_doA3LWyhsy_Mw4wWrTiPwga6os
Message-ID: <CANAwSgTZa7PXBuyh9EdDOXCNuCTOHGsJz18pSjP6WUN8sOaqTQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Sat, 18 Oct 2025 at 19:27, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Hugh,
>
> On Saturday, October 18, 2025 14:14 CEST, Hugh Cole-Baker <sigmaris@gmail=
.com> wrote:
> > On 18/10/2025 09:30, Dragan Simic wrote:
> > > On Saturday, October 18, 2025 02:42 CEST, Jimmy Hon <honyuenkwun@gmai=
l.com> wrote:
> > >> On Fri, Oct 17, 2025 at 10:15=E2=80=AFAM Dragan Simic <dsimic@manjar=
o.org> wrote:
> > >>> On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail=
.com> wrote:
> > >>>> On 2025/10/17 18:25, Dragan Simic wrote:
> > >>>>> On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gma=
il.com> wrote:
> > >>>>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > >>>>>>
> > >>>>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O erro=
rs and
> > >>>>>> corruption when using HS400 mode. Downgrade to HS200 mode to ens=
ure
> > >>>>>> stable operation.
> > >>>>>
> > >>>>> Could you, please, provide more details about the troublesome eMM=
C
> > >>>>> chip that gets identified as A3A444, i.e. what's the actual brand
> > >>>>> and model?  Maybe you could send a picture of it?  It might also
> > >>>>> help if you'd send the contents of "/sys/class/block/mmcblkX/devi=
ce
> > >>>>> /manfid" from your board (where "X" should equal two).
> > >>>>
> > >>>> Unfortunately I don't have this board nor this eMMC chip.
> > >>>> I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A44=
,
> > >>>> manfid is 0x0000d6.
> > >>>
> > >>> Thanks for responding and providing the details so quickly!
> > >>>
> > >>>>> I'm asking for that because I'd like to research it a bit further=
,
> > >>>>> if possible, because some other eMMC chips that are also found on
> > >>>>> the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be tha=
t
> > >>>>> the A3A444 chip has some issues with the HS400 mode on its own,
> > >>>>> i.e. the observed issues may not be caused by the board.
> > >>>>
> > >>>> Yes, it should be caused by this eMMC chip.
> > >>>
> > >>> I'd suggest that we move forward by "quirking off" the HS400 mode
> > >>> for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> > >>> downgrading the speed of the sdhci interface on the NanoPC-T6.
> > >>>
> > >>> That way, the other similar Foresee eMMC chip that's also found
> > >>> on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> > >>> the faster HS400 mode, while the troublesome A3A44 variant will
> > >>> be downgraded to the HS200 globally for everyone's benefit.  It's
> > >>> quite unlikely that the A3A44 variant fails to work reliable in
> > >>> HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> > >>> drivers should be a sane and safe choice.
> > >>>
> > >>> If you agree with dropping this patch, I'll be more than happy
> > >>> to implement this HS200 quirk in the MMC drivers.
> > >>>
> > >>> As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> > >>> eMMC Support List v1.84, [2] but the evidence says the opposite,
> > >>> so we should react appropriately by adding this quirk.
> > >>
> > >> When adding the quirk for the A3A44, can we lower the max frequency
> > >> and keep the HS400 mode instead?
> > >> That's what the Fedora folks found works [3]. There's more test
> > >> results in Armbian [4]
> > >
> > > Are there any I/O performance tests that would prove that lowering
> > > the HS400 frequency to 150 MHz ends up working significantly faster
> > > than dropping the eMMC chip to HS200 mode?
> > >
> > > I'm asking that because lowering the frequency looks much more like
> > > there's some issue with the board, rather than the issue being the
> > > eMMC chip's support for HS400 mode.  Thus, a quirk that would lower
> > > the HS400 mode frequency would likely be frowned upon and rejected,
> > > while a quirk that puts the chip into HS200 mode is much cleaner
> > > and has much higher chances to be accepted.
> >
> > I also have the NanoPC-T6 with one of the A3A444 eMMCs which suffers
> > from I/O errors in the default HS400 mode. These are its details in
> > /sys/block/mmcblk0/device/:
> > manfid: 0x0000d6
> > oemid: 0x0103
> > name: A3A444
> > fwrev: 0x1100000000000000
> > hwrev: 0x0
> > rev: 0x8
>
> Thanks for reporting the same issue with the same board and
> increasing our sample size to two. :)
>
> > I wasn't sure if I was just unlucky to get a faulty chip, but seeing
> > this thread it seems like a wider issue. On my board, limiting it to
> > HS200 mode gets rid of the I/O errors, and it seems that lowering
> > the frequency to 150MHz also avoids I/O errors.
> >
> > I did a quick unscientific test with fio; HS400 Enhanced Strobe mode
> > with a 150MHz clock gives slightly better performance than HS200:
> >
> > HS200 mode:
> > read: IOPS=3D697, BW=3D43.6MiB/s
> > write: IOPS=3D697, BW=3D43.6MiB/s
> >
> > HS400 mode with 150MHz clock:
> > read: IOPS=3D805, BW=3D50.3MiB/s
> > write: IOPS=3D799, BW=3D50.0MiB/s
> >
> > so from my perspective, limiting the frequency would be a better fix
> > than disabling HS400 entirely.
>
> Thanks for running these tests!  The measured difference in the
> I/O performance is about 15%, which surely isn't insignificant,
> but IMHO it makes the proposed lowering of the eMMC chip to HS200
> mode fall into the "good safety margin" bracket that I described
> earlier.  I think it's better to sacrifice those 15% to stay on
> the, hopefully, rock-solid side.
>
> I've been thinking more about the 150 MHz HS400 and HS200 quirks,
> and I'm afraid I'm even more sure that the 150 MHz HS400 quirk
> would be frowned upon and rejected.  See, it does make it look
> like a board-level issue, requiring a board-level fix, instead of
> being a chip-level issue, for which a quirk would be fine.  The
> acceptably low difference in the measured performance levels just
> solidifies such a viewpoint, I'm afraid.
>
> > It could also be of interest that the clock used apparently can't
> > provide an exact 200MHz, e.g. in HS200 mode:
> >
> > root@t6:~# cat /sys/kernel/debug/mmc0/ios
> > clock:                200000000 Hz
> > actual clock: 187500000 Hz
> > vdd:          18 (3.0 ~ 3.1 V)
> > bus mode:     2 (push-pull)
> > chip select:  0 (don't care)
> > power mode:   2 (on)
> > bus width:    3 (8 bits)
> > timing spec:  9 (mmc HS200)
> > signal voltage:       1 (1.80 V)
> > driver type:  0 (driver type B)
>
> Thanks, that's also something to think about.
>
> > > With all that in mind, if the resulting I/O performance difference
> > > between 150 MHz HS400 and HS200 is within 15-20% or so, I'd highly
> > > recommend that we still go with the HS200 quirk.  It also leaves
> > > us with a nice safety margin, which is always good to have when
> > > such hardware instability issues are worked around in software,
> > > unless detailed eye diagrams, protocol dumps and whatnot can be
> > > pulled and analyzed, in which case the resulting safety margin
> > > can be much slimmer.
> > >
> > > Ideally, we'd have a completely different board with the same
> > > Foresee FEMDNN256G-A3A44 eMMC chip to test how reliably its HS400
> > > mode works there, to see is it really up to this eMMC chip or up
> > > to the board design, but I'm afraid we don't have that (easily)
> > > available, so the only remaining option is to work with what's
> > > actually available, which inevitably leads to a certain amount
> > > of guesswork and some compromises.
> > >
> > >>> [1] https://github.com/openwrt/openwrt/issues/18844
> > >>> [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84_20240=
815.pdf
> > >> [3] https://lists.fedoraproject.org/archives/list/kernel@lists.fedor=
aproject.org/thread/MCSDYDQVOXS5AZMKA7LLY4QX7JXBWPCA/
> > >> [4] https://github.com/armbian/build/pull/8736#issuecomment-33877605=
36
>

Would you consider the following patch?

As per the Rockchip RK3588S SoC Technical Reference Manual (TRM) Part 1,
chapter 21.6, Interface Description, the eMMC signals require careful handl=
ing
to ensure signal integrity.

I2C2_SCL_M2 I/O EMMC_RSTN/I2C2_SCL_M2/UART5_RTSN_M1/GPIO2_A3_d
BUS_IOC_GPIO2A_IOMUX_SEL_L[15:12]=3D0x9
I2C2_SDA_M2 I/O EMMC_DATA_STROBE/I2C2_SDA_M2/UART5_CTSN_M1/GPIO2_A2_d
BUS_IOC_GPIO2A_IOMUX_SEL_L[11:8]=3D0x9

$ git diff .
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
index 6584d73660f6..f60a1d8be0ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
@@ -327,7 +327,7 @@ emmc {
                emmc_rstnout: emmc-rstnout {
                        rockchip,pins =3D
                                /* emmc_rstn */
-                               <2 RK_PA3 1 &pcfg_pull_none>;
+                               <2 RK_PA3 1 &pcfg_pull_down_drv_level_2>;
                };

                /omit-if-no-ref/
@@ -369,7 +369,7 @@ emmc_cmd: emmc-cmd {
                emmc_data_strobe: emmc-data-strobe {
                        rockchip,pins =3D
                                /* emmc_data_strobe */
-                               <2 RK_PA2 1 &pcfg_pull_down>;
+                               <2 RK_PA2 1 &pcfg_pull_down_drv_level_2>;
                };
        };

Thanks
-Anand

