Return-Path: <linux-kernel+bounces-836006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B41BA8914
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15113A913A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D0E27F756;
	Mon, 29 Sep 2025 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dduOpBWH"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67822615
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137350; cv=none; b=M1ee4FJIkEkcA4UxrTCCfKCOHxwnCqClwsFwnNVait0uiflOwZdmshpIYIck3wf7RwXfzqOGy+ticOA64nuyMcP/5IdwqceZRRttpx1GOwWn5tOQtAitc9hkCmEhmdt37P7M/qrCg3gUf4TR8LcdOeeaBMhck2VlBgHVoZTxfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137350; c=relaxed/simple;
	bh=lBuNSNHfNlOFhEVkV+foyyq4/RL6rfGISeiZ2POVo24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTh6QFrlWZZQ4q4XWTOmLHvs73F+Gs2+R5JRQEOfO5MOZbHvG724mz816Yvdl4rtkZVRkHeCO0LZoFPHw0XWsFlTjPq4jDd//4CpnpUY6hQu6zAUySoL19WDvwzvqjkn2PkAnTj1ErHlUl6P/IOoUPoGBxvWB54DsyH3U8NXdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dduOpBWH; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6089a139396so4559980d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137348; x=1759742148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr+N/1oAI1pLjqU6aC2+UuJdu0NBIsxDWcVl4EdcQkQ=;
        b=dduOpBWHLUmbYZtrr2ncDrdvkOkoL9yrcU3OH6+t2nLptL6VD5wRqI6FaRIXQDMHA3
         NdVSbRsBgsrqHHCx/XUj12uqQ8dL+tlApdDPTR4rfpSEi0C3HOU1WEYjunTNnOkXn+mN
         7gRK5TxkEik1w7/REDbxOHclHTkhxO8mazSQkNDEfhuR+5lfFA6wQUYpODPS87Ca4urf
         Dkz5KB31yfyRiQSxmrpKS56KwlbbzCbQ5w4GQBQLc9qlwiJUKrk6RuJEbUkWYLo8H/xp
         axx+XqDqrXfACfKri2s4wfcUzQjSr2w32rmJ9/wKtMkUSLxa9yZ+7NCrSblpIcqplwNf
         5PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137348; x=1759742148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr+N/1oAI1pLjqU6aC2+UuJdu0NBIsxDWcVl4EdcQkQ=;
        b=Kdezx7uhGVjigPVpdgeRcZhrspbWok24pkNjI5DFixeWXyzgQigsJvM1gjgggh/WEB
         EvfB19NkXQinWL3KVrixnMZ1gz4/CZg2unJrCGEqRRioNyOYm08O1A0o74yxUiM/GLjD
         B7ew7t3K7a7gha2UTpIFuvlanNXiYbDNH2OVRek+kwOSQ6EoD6dL8LhET+k3MWlCSZud
         mZuk3UfRhsmkQEYl/gIVEn+qoxlqt34RwHOWHLxZHEptnIW76yrBSWXmGMUalE4pcfCj
         l2YwIdKeaIlpAr4IjQ+SsTQU3sdWQs6qqOYihLwI5hnaq75ftGRbqtrDm/RCiDD8UvwP
         03hw==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZgHgZVATCVU/+bZA9usJUDPWO+IyFKsF9Ehw0+vl46vV4LIbCEKmrBV+V5ZQii5qBT7a3tP+t8totM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LDu8NItr3ysbwgds+S14zAqYVVaNtg9eSKA3VqcSTKoL64Pt
	+hjHtuC+6cqTlqTY5z0PSYVzff+rZywL/2Ii2x8wpDOmu7+WkyeaAl1jw0c6daREwXemjMFPHGz
	BzZJ6vcwMkXRROOOl9Ydu+y1CdHl7stY=
X-Gm-Gg: ASbGnctPcAs1hBLFOxsWP6nzeRtK5zRvJbNHozY6VeX8xXV8sOqHKD+Ed35MULT561a
	sNk496+0Cz+Q0UHA1jMdEWu3hbRqPAy7umqIjBqradkCCP/3AmNRivEkwKHym+SPyqGCIt3adTE
	m7X/Znqs+0ekK22oYmzJI4SEd6/zt6WsPk8vSF4EZp525FqVBP0aDTG5RABi3Tf57BMoZtbL9Sw
	WZi+O9MmRyjQAuF0Ms=
X-Google-Smtp-Source: AGHT+IEqG2WiadrrFUEa9J19hGrk6/NeihwO2YF4Qsh2jTfvkmzgqzQ2Ef58HmGi3ZPxOG7NeW+IecRnhi5uJO6qQl4=
X-Received: by 2002:a05:690e:1a44:b0:637:cde3:c6f6 with SMTP id
 956f58d0204a3-637cde3c72bmr5782117d50.10.1759137347594; Mon, 29 Sep 2025
 02:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925200625.573902-1-tmaimon77@gmail.com> <175890301752.880349.2331946518360447485.robh@kernel.org>
In-Reply-To: <175890301752.880349.2331946518360447485.robh@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 29 Sep 2025 12:15:36 +0300
X-Gm-Features: AS18NWBg8PJuv0n6gCvIlMejilS28fLD8rStQueT8p0_c7fgopvArq9qbAYJTN4
Message-ID: <CAP6Zq1jmmhqYu3C7KHFK2tz9zjW352Bbw4cXeOYSjNSTELrp5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm64: dts: nuvoton: add NPCM845 SoC and EVB support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	benjaminfair@google.com, joel@jms.id.au, krzk+dt@kernel.org, 
	tali.perry1@gmail.com, conor+dt@kernel.org, avifishman70@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your comments

Most of the warnings occur because the compatible strings are located
in .txt device tree binding rather than in the .yaml file.

The only change that needs to be done is in ti,tmp100 that

Could you approve the patches, avoiding NPCM845 compatible warnings?
Meanwhile, I will work on converting the txt to yaml

Thanks,

Tomer


On Fri, 26 Sept 2025 at 19:11, Rob Herring (Arm) <robh@kernel.org> wrote:
>
>
> On Thu, 25 Sep 2025 23:06:22 +0300, Tomer Maimon wrote:
> > This series fix warnings and adds device tree support for peripherals on
> > the Nuvoton NPCM845 SoC and its Evaluation Board (EVB).
> > The first patch fix warning and arrange node order.
> > The second patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
> > RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tree.
> > The third patch enables these peripherals for the NPCM845-EVB, adding
> > MDIO nodes, reserved memory, aliases, and board-specific configurations
> > like PHY modes and SPI flash partitions.
> >
> > The NPCM8XX device tree tested on NPCM845 evaluation board.
> >
> > Addressed comments from:
> >       - Andrew Jeffery: https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-2-tmaimon77@gmail.com/
> >                                         https://patchwork.ozlabs.org/project/openbmc/patch/20250908125938.3584927-3-tmaimon77@gmail.com/
> >
> > Changes since version 2:
> >       - Fix dts warning
> >       - Arrange node order by ascending unit address.
> >
> > Changes since version 1:
> >       - Fix commit message
> >       - Fix dtbs_check warnings.
> >
> > Tomer Maimon (3):
> >   arm64: dts: nuvoton: fix warning and nodes order
> >   arm64: dts: nuvoton: npcm845: Add peripheral nodes
> >   arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
> >
> >  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 732 +++++++++++++++++-
> >  .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 440 +++++++++++
> >  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
> >  3 files changed, 1160 insertions(+), 19 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: remotes/arm-soc/for-next-12027-gf60eaa447dab (exact match)
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nuvoton/' for 20250925200625.573902-1-tmaimon77@gmail.com:
>
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb000000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb002000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@c0000000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb001000: failed to match any schema with compatible: ['nuvoton,npcm845-fiu']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/i2c@86000/tmp100@48: failed to match any schema with compatible: ['tmp100']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/pwm-fan-controller@103000: failed to match any schema with compatible: ['nuvoton,npcm845-pwm-fan']
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/spi@201000: failed to match any schema with compatible: ['nuvoton,npcm845-pspi']
>
>
>
>
>

