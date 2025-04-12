Return-Path: <linux-kernel+bounces-601200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09417A86AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 06:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4FA1B685DB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820D16F0FE;
	Sat, 12 Apr 2025 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KkujE1Av"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629115C140
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744431769; cv=none; b=iGPRyiobnmlM42m5+WIivi4F9u4Yol0GXF/dnj04VceZQKYVdknnrrUNJNgPl2/usDqqecJT1P1qsgmIl1rette2UddiXlTFx9iJFIBeitggfXrULx/ojOVrLQu4RTeJL5J46TXsGlScoB76EewMwcX5Xw/W73v/uplKutHJjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744431769; c=relaxed/simple;
	bh=eFZr/xD+uASkqlJan4EtT2GwlyKWYQWYuWBhnlw8OLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVzuEqj2BmpHBdZfFhjPTv3fUqoPQZE+DKedJugYRAMENLrVsd3y/1r0uBMooYCdXBRkZNkWuOn/KSSlJOPpDpBAFub7umXrEUr+WyfgB3yd5/kJNvZKnNKlSKIO82TnkKFGLeWZco6grsSSqA5RgR/PWapAma5MW0cBQXvn2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KkujE1Av; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac29af3382dso446990166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744431765; x=1745036565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05C5L0Gpse8OxdiRbCXeFoAP6LtcohYGcNTzACQG79I=;
        b=KkujE1Av4N1U/wpjTkvmNERAdlFlDCQXfCVVOGo4X5WsMQm7DjoaaKF2RezOQv1v+/
         BinKYxksnzi5haNc1LuioOq2RoK0O+LFbipOtnMPCZCcgQk5KJHT32u/wPq+dzwcfIZK
         +uis9F2l53KDbeX+MuYlxuPU8xcs44JYtO7sQPYh4PSr6AsEq5drvQIj5aZJwaRMlNLC
         mVYs2ozakWG7aDlOX3gASNRXwKOQ3n6rmiSkngigpCVq0gMkBMOwd64DLTgPcIAeZ577
         H47deTbpaxd0Hhqn03VwRhTQ2jjaCoDGy99O4qQfTV70Dhq0/gvYzIGIh1FoWC6tzMpb
         whPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744431765; x=1745036565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05C5L0Gpse8OxdiRbCXeFoAP6LtcohYGcNTzACQG79I=;
        b=Hp6JGaptc2LEp6LmNxU1HK4LnNApGssM469kxNYN4TwHNi+qORQKL/y3eagVIWqvQC
         DGFyJy6vGJx1p9arMJ7tg2oZY/WPXub3KVc5usDf+ltbjGP5PEjdWxXsQEMihCehRG10
         AUGOOCoTs7f+H+98LH43qVjeoDiYdFV8bQDsmK9VdTaunEwXGVRrfJckeUs4golC3pE9
         QrEj8c+epN7LO1L4YD9HqB+0+BZCNaLhlXopBB/SOPm8yh5AdhxXdRRA2B8Z8yOq/hav
         HUpIxS81+Px+oMrztzbM327thTtp9u30+rBrtNyyoHUuQRW9cSmiZc6lNmjaIq7b4tT2
         5GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeuBglZAp6f5Q0QLKOkytEB+JDRE06cVR1A9pxBSXDtXE/Ymrn4zKRkZdqDgph3sbYrP6aNZm+PSu4TiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYnBBikwQm1k9SRe6gPOVRRLdJYPThQhEXnMinrfEkQl5kakj
	vWgZVtC1BjgFwzIQaAEu3yQ+vuR6eENtbvI25ggKiaBXYhFRBEPhtmkcHeDcYxJ1Ei2aAkmIDEP
	wTpNNp/ntPOoH6NvDlZXcvv6JedaF9ipMs2FB4A==
X-Gm-Gg: ASbGncvp1Kndcrpu7ZzflVnhWG8wrYnAkKx0uKucdKqdTZD5Ugp46kkHd2BlRjDoNhe
	T34JDK7JJP6G/LXaTyExe6P45MEny/NQKqbctKPffpcJjukUP8vNfxJ5PbPEQnXSCiEBJVkY6L0
	WJKnm3u7qku4qCwEww4dE1LfS37w==
X-Google-Smtp-Source: AGHT+IGYuiszYCi7qWo9y4ZA32qHFUN/1bWbzAZvEtCTohy4G3Cy1q93jH/uejMtJJyZEjD+1PtKWMiMNzmzfMkJcy4=
X-Received: by 2002:a17:907:7fa5:b0:ac7:b48f:4cd6 with SMTP id
 a640c23a62f3a-acad34ba069mr421800166b.24.1744431764635; Fri, 11 Apr 2025
 21:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-8-guodong@riscstar.com> <20250411140510-GYA22364@gentoo>
 <d2c26d3e-787a-490e-9134-8ffe2f6b8333@riscstar.com> <j35vjluiykbu2gxg5zkoxm67muj5y66zn6tjwhdbnolkyeilh7@cubjbzouewiy>
In-Reply-To: <j35vjluiykbu2gxg5zkoxm67muj5y66zn6tjwhdbnolkyeilh7@cubjbzouewiy>
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 12 Apr 2025 12:22:32 +0800
X-Gm-Features: ATxdqUFBjSG4mlbdp7nE8mXBUsIc0jQlH-3ugDyge5bg-US1BCesmG_1FB96s9Q
Message-ID: <CAH1PCMa6BihBDubJNL2W-kfzUdwwKgiKgW=iz5JsroWQVyhg+g@mail.gmail.com>
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support for BPI-F3
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>, ukleinek@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, geert+renesas@glider.be, 
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 7:28=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> On Fri, Apr 11, 2025 at 09:23:29AM -0500, Alex Elder wrote:
> > On 4/11/25 9:05 AM, Yixun Lan wrote:
> > >
> > > On 21:14 Fri 11 Apr     , Guodong Xu wrote:
> > > > Add a PWM-based backlight node for the Banana Pi BPI-F3 board,
> > > > using PWM14. The backlight is defined as a 'pwm-backlight' device w=
ith
> > > > brightness levels and a default brightness setting. PWM14 is assign=
ed
> > > > a period length of 2000 nanoseconds.
> > > >
> > > > This configuration was used to verify PWM driver changes, with PWM1=
4
> > > > tested and its waveform confirmed as correct.
> > > >
> > > > The node status is set to "disabled", and should be enabled when th=
e
> > > > display driver is ready.
> > > >
> > > .. see comments below
> > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > ---
> > > >   .../boot/dts/spacemit/k1-bananapi-f3.dts      | 32 ++++++++++++++=
+++++
> > > >   1 file changed, 32 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch=
/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > index 816ef1bc358e..d04b57ddeb46 100644
> > > > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > > @@ -28,6 +28,32 @@ led1 {
> > > >                           default-state =3D "on";
> > > >                   };
> > > >           };
> > > > +
> > > > + pwm_bl: lcd_backlight {
> > > > +         compatible =3D "pwm-backlight";
> > > > +
> > > > +         pwms =3D <&pwm14 2000>;
> > > > +         brightness-levels =3D <
> > > > +                 0   40  40  40  40  40  40  40  40  40  40  40  4=
0  40  40  40
> > > > +                 40  40  40  40  40  40  40  40  40  40  40  40  4=
0  40  40  40
> > > > +                 40  40  40  40  40  40  40  40  40  41  42  43  4=
4  45  46  47
> > > > +                 48  49  50  51  52  53  54  55  56  57  58  59  6=
0  61  62  63
> > > > +                 64  65  66  67  68  69  70  71  72  73  74  75  7=
6  77  78  79
> > > > +                 80  81  82  83  84  85  86  87  88  89  90  91  9=
2  93  94  95
> > > > +                 96  97  98  99  100 101 102 103 104 105 106 107 1=
08 109 110 111
> > > > +                 112 113 114 115 116 117 118 119 120 121 122 123 1=
24 125 126 127
> > > > +                 128 129 130 131 132 133 134 135 136 137 138 139 1=
40 141 142 143
> > > > +                 144 145 146 147 148 149 150 151 152 153 154 155 1=
56 157 158 159
> > > > +                 160 161 162 163 164 165 166 167 168 169 170 171 1=
72 173 174 175
> > > > +                 176 177 178 179 180 181 182 183 184 185 186 187 1=
88 189 190 191
> > > > +                 192 193 194 195 196 197 198 199 200 201 202 203 2=
04 205 206 207
> > > > +                 208 209 210 211 212 213 214 215 216 217 218 219 2=
20 221 222 223
> > > > +                 224 225 226 227 228 229 230 231 232 233 234 235 2=
36 237 238 239
> > > > +                 240 241 242 243 244 245 246 247 248 249 250 251 2=
52 253 254 255
> > > > +         >;
> > > > +         default-brightness-level =3D <100>;
> > > > +         status =3D "disabled";
> > > I'm confused, has DT in board file with disabled status doesn't make =
sense?
> > > it doesn't really useful for placeholder, even worse that functionali=
ty may not
> > > verified, so I'd suggest sending along with display driver while at i=
t..
> >
> > I think I suggested he include this.  Guodong tested PWM using
> > a backlight on a display connected to a Banana Pi PBI-F3 board.
> > The above numbers come directly from the downstream code, which
> > uses this PWM consistently as a display back light.
> >
> > But you're right, the exact set of numbers to use is dependent
> > on the display used, so it's better to add them when the display
> > gets integrated.
> >
> > The pwm14 node could update still be added here, but that too
> > might as well wait until there's something to use it.  So I
> > think this patch can just be dropped.
> >
>

I checked the existing boards based on SpacemiT K1 Soc, all of them are
following the same pinmux design of using pwm14 (and pinctrl group 1,
ie. pwm14_1_cfg) as the display backlight control.

That's why the code relating to pwm14, in my opinion, could be useful to
others.

> If this patch will be applied as it is after applying the display
> driver. I recommend to preserve this patch, but move out of this
> series and resend it as RFC. If this is only for test purpose, it
> is better to move this into the cover letter and address it is for
> testing.
>

Yes, it's for test purpose. So, let me move the code snippet into the
cover letter in my next version.

-Guodong

> In most case, patches with some unmeet dependency should follow
> maintainer's request, or has specific purposes. It also needed to
> be marked as RFC.
>
> Regards,
> Inochi
>

