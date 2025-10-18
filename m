Return-Path: <linux-kernel+bounces-858901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7585CBEC2EA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49731AA5859
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC73E185E4A;
	Sat, 18 Oct 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao84iPUQ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20B19DF4D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748144; cv=none; b=KzOG/BCZtfoozrDveop3f+KC4EOSMCSKo6TJA0RQqMQPwNVpNclS8BenkagcZ/ke3ZdbMxNJIfnKupn3p7YwfdGTKdqG3avk9Uu5d1FPIIRcFThy4iGR+olUwhmNwSzJYIzL1mSHffSrbxhsJSMtwa2ny3lpmDfLT9x9Dcj6AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748144; c=relaxed/simple;
	bh=PXX+zXygMXA5cduTiwAF4Wgfy9h1+5FUkT6YP7tskS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5sCquBjtZPPHWRc8FlMMkTZSZ6iboKETBmRWbYJViDh6GfvFYKPfTGkwx0bunJzPgI/I3sjGEju3DhYhDIep8NAQUP44RdFkQ665H7FyeAsTu3yH8hcSl6JhSo1s+GPoPzHr/az9vASr+MJ05le7mSJcRIxG4aJhkhBjBieHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao84iPUQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ece1102998so1909021f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760748140; x=1761352940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCVClA/PZ0uZGRS4AfUm3xUrlpb2SVIYbrS2oxr+V7g=;
        b=Ao84iPUQ9Z0CffurDIHdLsNmhD++Uk+5fkBIGbRTiCO9Q0g6pt8wkrY4EyjnN+SmWF
         v+aInPBSdLUqXODQIaMZzBf+f5Qt18kEt0xYvbFaZ72pBoaRRrQoBF01/lfcGi2A76rj
         rHKLUcKI1QYQLqVN6jfFre29tWibmpiQRs7DUlCz5Ad7I30m18ezO7STBANfNaXZFZAj
         KecmRmvDi3CLpD9bgLZwKspJ/8mMfEEq5T16FRE0P5XIvofEIoqIYjdUbxKkteR/t/Mt
         QTjVf4GhufSAxw6at9E6Ta+Qg3Tx4hglh3FjcyVtMVyRCKmd/8PiuVy6oaFEXe339KHy
         HSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760748140; x=1761352940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCVClA/PZ0uZGRS4AfUm3xUrlpb2SVIYbrS2oxr+V7g=;
        b=EdQDQ59AoIBgTIvE/uJSaok4kBqRrtH/yI0mdPYEJX8GjKB2e+rLsRFgwoy+Xh3Qjf
         jvckHnvnkxoqiY5D/g9fGilm3XtNN4WB/XrZLhmbVRUK7Olc/m5VbPU3Y4hA0ezvhw9g
         jEICzByCgaqtvtaA4SEaMKhc5S3fHJrkXiA1/CAl5H43XPVuoBIYaLk16RHcN9KHkLKb
         cOCpsz/Infgu3XlZLsmCglJaghxVS+HSfc+8E1ET0cRo+OZHKbBsoP07qVhKEa072A4o
         pUtuvqitTRHlS13S4wiY0TU2qVCqEA/Ot9NJGPfgKIMIykNwOjWFl+hh2sKCty4vwTPl
         AebQ==
X-Forwarded-Encrypted: i=1; AJvYcCWibmEyRXHTvf+olUTBrU6nGByiIZccw3ken14ZcIf6XNdgKxIush77feD7o+Ac6zwJiAAnfFOyvrHqrkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJGrGPt0TxzZQNOCrKKy7iQJimiq73SfRAKFlIjmPICFnjO9g
	8iF1fZxff+0yac0S63rslp8HX4DNqTEaehszxRE7jLc4Dc6Gts/Sy3fP+1Fc78DQnzO4fBZh7rl
	zVEXKl4PIx8rJ2Xhv4WWfMfW8SaL0jag=
X-Gm-Gg: ASbGncsUzVWe6EDN1i8viNK6Y1NbWx6/C6070gtPeIeYAuOQ79jSmuW8I0maEN+YOV7
	RArsdrTUW/ElJtMJ9vgLw8BJ4IjTVkJw3Pv4COZMVZKNzH7empuyXs755GD8TTmkGje0skI9a7D
	MrkpVX+Z2NV6Uzfro3s2aBzQ5avcy+911RzCAJqPhtpkvnJkvRVsCRGlFYtxD2oM5YtJA2bj951
	BDMla4jlGFA9eKwWCRPvab+yNOBNageh0g8Mhu3yR0meFVsPeJt0lsJQDIbnPLVEySM8bbSqRGc
	uvtX46KHmnBD7uRiwzrO9CxxK1Q=
X-Google-Smtp-Source: AGHT+IEnZJdKEv8HpBuO5avxk7qhlo5bK8j/kw4uDQDaUY5tFqvMdnLtIwWLG43QGsF9cLs4FirJoib+MaszcUlXcUU=
X-Received: by 2002:a05:6000:3113:b0:427:7ec:ea41 with SMTP id
 ffacd0b85a97d-42707ecea7bmr2787799f8f.57.1760748139778; Fri, 17 Oct 2025
 17:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com> <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
In-Reply-To: <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Fri, 17 Oct 2025 19:42:08 -0500
X-Gm-Features: AS18NWD1YMiDaJdbECom22kokRcA-tOWvJZCxltW1Yp4Akxq7VR2jmB100bExfM
Message-ID: <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:15=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail.com> =
wrote:
> > On 2025/10/17 18:25, Dragan Simic wrote:
> > > On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gmail.c=
om> wrote:
> > >> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > >>
> > >> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors a=
nd
> > >> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
> > >> stable operation.
> > >
> > > Could you, please, provide more details about the troublesome eMMC
> > > chip that gets identified as A3A444, i.e. what's the actual brand
> > > and model?  Maybe you could send a picture of it?  It might also
> > > help if you'd send the contents of "/sys/class/block/mmcblkX/device
> > > /manfid" from your board (where "X" should equal two).
> >
> > Unfortunately I don't have this board nor this eMMC chip.
> > I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A44,
> > manfid is 0x0000d6.
>
> Thanks for responding and providing the details so quickly!
>
> > > I'm asking for that because I'd like to research it a bit further,
> > > if possible, because some other eMMC chips that are also found on
> > > the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be that
> > > the A3A444 chip has some issues with the HS400 mode on its own,
> > > i.e. the observed issues may not be caused by the board.
> >
> > Yes, it should be caused by this eMMC chip.
>
> I'd suggest that we move forward by "quirking off" the HS400 mode
> for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> downgrading the speed of the sdhci interface on the NanoPC-T6.
>
> That way, the other similar Foresee eMMC chip that's also found
> on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> the faster HS400 mode, while the troublesome A3A44 variant will
> be downgraded to the HS200 globally for everyone's benefit.  It's
> quite unlikely that the A3A44 variant fails to work reliable in
> HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> drivers should be a sane and safe choice.
>
> If you agree with dropping this patch, I'll be more than happy
> to implement this HS200 quirk in the MMC drivers.
>
> As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> eMMC Support List v1.84, [2] but the evidence says the opposite,
> so we should react appropriately by adding this quirk.

When adding the quirk for the A3A44, can we lower the max frequency
and keep the HS400 mode instead?
That's what the Fedora folks found works [1]. There's more test
results in Armbian [2]

[1] https://lists.fedoraproject.org/archives/list/kernel@lists.fedoraprojec=
t.org/thread/MCSDYDQVOXS5AZMKA7LLY4QX7JXBWPCA/
[2] https://github.com/armbian/build/pull/8736#issuecomment-3387760536

>
> [1] https://github.com/openwrt/openwrt/issues/18844
> [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84_20240815.pd=
f

