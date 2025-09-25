Return-Path: <linux-kernel+bounces-832645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B20BA001B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EAA1653F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAF2D0610;
	Thu, 25 Sep 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0JAZQvG"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDD2D0601
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810438; cv=none; b=nif8RtVf2LHorNSQdmO8XU8p02LQRL8LIj1tDaQvlPU1GeMs6moGe0LIPGavV9RCvDoB4aEa62MKph7zIbaOcYlK6PjESwN/zO4YQ15IL9ai0sRia7kLwgH02gywQEDWya0YtpD2g35M+yT9zNOv1vuoI5T1WsW+CQ1yxV/gHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810438; c=relaxed/simple;
	bh=h2URbpxQUZ+BCi1wrx/nx2i8C5bokSELKCNO/XvU/mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llgeClXdrhxrweRYhg0eHk97NVJcSbZ2+YaOXBdtqK6WKiHpm0Lk//1YUpvOma4U2/OyYjFnhJ4NlAqSU17jZcTvrLzn0lrNN5UXtz3/tG6DYcvRjeC6YB9vzRXQqT24+FIKzDyJhSN0d2BjIs52NBhNcxtnmbb3L3c4lv6vOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0JAZQvG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78ed682e9d3so7440446d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758810436; x=1759415236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Glm9P9HTH7GF2LUGNVtDEQmwup7tzZ0lSiiqddi2yqw=;
        b=f0JAZQvGEFI4nUcNqbcS+wS5E1Qb+9XaFcPGu0bYIqrA9NKp7gxPWecTOlpSfncud+
         aASrCM7cDQfopSXJDMqV72DvRSiN+3SKmwZbLZA49wrYCFCuJ7Uv8VRbaDXd5uNVXWRG
         /HdGCnFm4RNhMBE0FAcqftuVyOwAeObojPU15VqAWfG/pV+9UDCwCbW5fiSm+zh1U3JS
         tleQZANzLdunzZyTpw+P8Du7tZeluZUosxzG/RB7fVJgakDM/CCTVN7jfjAza8KXm1/O
         9yBXPRNwOS05apHKBgkMAW7hnAIwd5PDRmXtcZpPzqNx3Wq4/HjtCNCMmgnhA57TPHWL
         unog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810436; x=1759415236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Glm9P9HTH7GF2LUGNVtDEQmwup7tzZ0lSiiqddi2yqw=;
        b=gxw/SiDthDJcsSuzHZMrPl4HZZRc+xS28gt7UpeBo+gLvi/+ljrqOMn7GRbdvH89tY
         PLlxbwZX56Xug/xxhfDatgih5vR8z3JcmX0e2DGuvmAL/Exg01u9i6+Fab9qpJCQOcim
         5TpvXHELjxIhjZRMoyMZIIfQT4ZdTUYP60ktjmSMybIUYaDN4Pbk/IfUnH/LFJ9K+6oC
         F9qE3OnDeaV3Vk+V7Qx2hWOJ6SJN3FauRht9DfAuC/lVm/HyusFH9OiLF1dfhslsreZ8
         eSBZ1YjpJzVk5T+22/lhNRbSvRHA3/VqE2QVLR1Z2+N3alLFaAgXjE+Z6WumGRAZAeCB
         Hf1w==
X-Forwarded-Encrypted: i=1; AJvYcCUlqpmz8ZtIFDQVfaYODr3/lqPmP57a91Sc6C3AndfTJ4HfUJVu+YW3kx9HsaJ3KDGfOussGRFlzKYn2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XDY1xoTfbeOfmHdGqNAY1uDsQQdUsLkp/t/IjkFGhzC/EKov
	6nu55Fo3+rlEEhb0QuihtzSfNTJkTxLKG+vzUXTVsEISvexgBv5YmUszaJOiVVokaIHjA4Eg4Bd
	Nzs2Kmf+8ehMUK+kT8Lqj6BvUE5djl4Y=
X-Gm-Gg: ASbGncuy7SRgoYCF3nB81xwPDTmTIqQ3dqTfnBv64VHZ3QJZLgiN64Y6Lz6SxldNLNd
	fBxPNC9BKa+5CN1RvZrN4074UkE3gtakdb0foMYwCC6/rrrD9fWgJfiRFB90Wq6twYwgI6CDWWf
	xjYMdfqSwZzmXtlpoxo+N4LpvS9lFPWc6JNh8QavM6qmqbq7YQd0oQoZBPGXROHO7CJEF5e/rS/
	ozXfG95IMEV5Hobo2Y=
X-Google-Smtp-Source: AGHT+IH9fq+ZHarv12E5Wiwa5ANc8v0SLu1OdwXvzSahIaMx6BArGuHvon1RcjpXEhOi/ie1rgfJtvwPRNtpXcis6uE=
X-Received: by 2002:a05:6214:5095:b0:7f1:3094:306d with SMTP id
 6a1803df08f44-7fc400b2c46mr54245696d6.47.1758810435646; Thu, 25 Sep 2025
 07:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925092037.13582-1-jjm2473@gmail.com> <175880949051.820269.9096832740960574577.robh@kernel.org>
In-Reply-To: <175880949051.820269.9096832740960574577.robh@kernel.org>
From: jjm2473 <jjm2473@gmail.com>
Date: Thu, 25 Sep 2025 22:27:04 +0800
X-Gm-Features: AS18NWD4junFDrz8pZg4TpLnxjmQYCHszyF4BKlv4AvixoXW2PGMp3AIFbDTSgU
Message-ID: <CAP_9mL7RBoy_jhEp4CU7FXtc19UtzP0GKuE15y0isF=bF7XGGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kever.yang@rock-chips.com, krzk+dt@kernel.org, heiko@sntech.de, 
	alchark@gmail.com, linux-rockchip@lists.infradead.org, didi.debian@cknow.org, 
	pbrobinson@gmail.com, honyuenkwun@gmail.com, naoki@radxa.com, mani@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-kernel@lists.infradead.org, 
	quentin.schulz@cherry.de, jbx6244@gmail.com, conor+dt@kernel.org, 
	dsimic@manjaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	inindev@gmail.com, ivan8215145640@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob Herring (Arm) <robh@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=8825=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:12=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Thu, 25 Sep 2025 17:20:34 +0800, Liangbin Lian wrote:
> > LinkEase EasePi R1 [1] is a high-performance mini router.
> >
> > Specification:
> > - Rockchip RK3568
> > - 2GB/4GB LPDDR4 RAM
> > - 16GB on-board eMMC
> > - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> > - 1x USB 3.0 Type-A
> > - 1x USB 2.0 Type-C (for USB flashing)
> > - 2x 1000 Base-T (native, RTL8211F)
> > - 2x 2500 Base-T (PCIe, RTL8125B)
> > - 1x HDMI 2.0 Output
> > - 12v DC Jack
> > - 1x Power key connected to PMIC
> > - 2x LEDs (one static power supplied, one GPIO controlled)
> >
> > [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
> >
> > Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> > ---
> > Changes in v2:
> > - Change deprecated "rockchip,system-power-controller" to "system-power=
-controller"
> > - Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@=
gmail.com/
> >
> > ---
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
>  Base: failed to guess base
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/rockchi=
p/' for 20250925092037.13582-1-jjm2473@gmail.com:
>
> arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dtb: mmc@fe000000 (rockchip=
,rk3568-dw-mshc): status: 'oneOf' conditional failed, one must be fixed:
>         ['disable'] is not of type 'object'
>         'disable' is not one of ['okay', 'disabled', 'reserved', 'fail', =
'fail-needs-probe']
>         from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dtb: mmc@fe2b0000 (rockchip=
,rk3568-dw-mshc): status: 'oneOf' conditional failed, one must be fixed:
>         ['disable'] is not of type 'object'
>         'disable' is not one of ['okay', 'disabled', 'reserved', 'fail', =
'fail-needs-probe']
>         from schema $id: http://devicetree.org/schemas/dt-core.yaml#
>
>
>
>
>

Thank you!
"disable" is a typo, should be 'disabled', `./scripts/checkpatch.pl`
doesn't mention this.
I'll fix it after review if there are no other issues.

