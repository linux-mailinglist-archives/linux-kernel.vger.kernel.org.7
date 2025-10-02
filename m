Return-Path: <linux-kernel+bounces-839810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C81BB2796
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 06:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883A4422920
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 04:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F969155CB3;
	Thu,  2 Oct 2025 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDg9C2M9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824753FB31
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759379041; cv=none; b=MeVK80Wdf/VBbvz7PFM1xyiWyatcCnXQisdo0m2as+rqkhW3j44ch5y2Jp4EDHlvGnyeUhNVnS7HDQaknC4/LH4WLPphjRof+z2UWLcMeNQGB6LXtYsYdgobq2IROtDWk3Ld0L9wcHPeKiK18sJarrJy56nl7yP6cL5llfKNpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759379041; c=relaxed/simple;
	bh=ehu8376cUl/DJNnvCX5i0mJoP3uDOVuPTyuu4WOuiDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juKJw57eqWhUzz0jWFBbfKXpzWdGzz8P7WJovLO0Nlk0dc5YBEZ6058NQpxsbLIZ9yMPEl551niDjBHHGPmUUnx0NTpKGq35LFPrzNn4nAfaUl9G9K2ztBfX0DSJIgNwcyEujXMBuRJM6zE6Dtk30r+qIyspMxwO2ULEp30JptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDg9C2M9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28832ad6f64so6327905ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 21:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759379039; x=1759983839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2QRGst729/DWiP4I9nqZ3Qxmv8ECUfQin2YGfwodis=;
        b=ZDg9C2M9Uf+/XEzOaIAIqAKsFjYHGWSFsWmW/t7xD2L7GGT3WSCcguAQsCyJ5vYzYd
         Tm7B3LvbT7ZwwxwJzWG+Q2AAWXY2y8DlY0TxhFj4Ha/TEWJHUL6FMjnVG0cHZ7DW/p7Z
         te+kgOR3JiTBiz5F6VkmXZJFfE+ZLOs3rnp7daTICR4XkeUPu/4VLncQGHgL2Us7PwQ6
         pgW4quJsmCuApTWyP9L7qI95vG4rYFP1qXIUyErOBpoakJDOdNYXGqFyvWc5S3itljxV
         YZtUpaeoOEUgfGkffQAiiRBcVbIyxengJZOdYAq4qQCixGGXehL9+xYmGeOhb8cfDYY9
         6XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759379039; x=1759983839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2QRGst729/DWiP4I9nqZ3Qxmv8ECUfQin2YGfwodis=;
        b=PuAx9VZxqIkaxOy+d395I8uxZHbTq1uOQ7ovJza3ghAfV39/tyRubtpre0msVievNi
         xMrC3kIrm03VsrOqLjtuSwbwXPHVu31T8XxspnY2/jM5Z90sAgeUOTtLLo+T8ihES++J
         yqO7TQZLB97TNhfQQZnZIp83Rc6hDHjJSfmuEebGpP401mScETQGQa175y0z5lwhGywH
         gw1D/zp8SVAr/QLxXLeQUAsNK4ZyJVEMjOJXiBFc/uWPL4M6oIg06w7oHPtusrQtfS2M
         QMRut4QFiPYtH5WSFh8D7ljnCrp6zOxGS3kkOF3B/nCiadeXlQSjLU9yT/Lmugl6vMA0
         +Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9xvqvJpnWwlxZfKIrHay8Y9N1KtPsmwuvB2kKY/OJjS/9eW0LqFiAZLEX10T9WAaLbjUQLPdTX8/idw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6NO7Sp81HwcqlYVayQWSybYpTR2KWPc9lAEs5xR8yV5gxS9x
	murs/zXEKITu95iHNjCP8fPzHCTra7qCTtGQJSEQltwJWddfNfpNH9O8PNAVVzFzB2Vdq+muZlv
	0R3A6WsW3/pU7GwO1AxSOCbcCtwjpca8=
X-Gm-Gg: ASbGncvL+IJSjLqHO8lXMcX4nndU2m5PvYB+7oRy7I6Sek+/ONif64IS+eT/Q4P6Y3q
	SQ9fB2ShJf7QiPzr8RFR4S5FR1meaUDK0mvkmPWmq83tQU+Ggi9cCVCHdvdssS5c8AfnUbxZsIj
	Xaw8/JkuRy6BH71b52oKRepGUVeRSzThDrM58v3A9RrKtSfafAHkhgVNk2NEGFkQkVVw7eeLlt8
	+Q51NQmd7YEkO8Fg/0TPawpzEvANTFJ
X-Google-Smtp-Source: AGHT+IHgkuju9CUwpPT0WwGqt9+xSzAjEsWxHRza/bmAnljDvo45aLWn/1dVAmMuO1OQzeCs6YLRY6uoy1Dxbms4f2k=
X-Received: by 2002:a17:903:3c2d:b0:269:8072:5bda with SMTP id
 d9443c01a7336-28e7f45aa2cmr81883465ad.54.1759379038825; Wed, 01 Oct 2025
 21:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
 <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com> <20251001-bonding-surging-af8cd0d09e07@spud>
In-Reply-To: <20251001-bonding-surging-af8cd0d09e07@spud>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 2 Oct 2025 12:23:47 +0800
X-Gm-Features: AS18NWCewZBOJ3_bvPqMIiAefrcZiLRdaKPOQ3p104CWc2zI58_oYaZj_KaxEko
Message-ID: <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 2:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> > Document the new compatibles used on Meta Yosemite5.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
>
> You've repeatedly ignored my ack, so I assume you don't want it.
> Maybe you want a nak instead?
>

Apologies for ignoring your ack repeatedly, that was not intentional.
I truly value your review and will make sure to include it. Would you
suggest that I send a v4 to pick it up, or is it fine to carry it
forward in the next revision?
Thank you again for taking the time to review my patches.

Kevin
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b=
/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e1=
09a78d931dffdfe28 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -89,6 +89,7 @@ properties:
> >                - facebook,minerva-cmc
> >                - facebook,santabarbara-bmc
> >                - facebook,yosemite4-bmc
> > +              - facebook,yosemite5-bmc
> >                - ibm,blueridge-bmc
> >                - ibm,everest-bmc
> >                - ibm,fuji-bmc
> >
> > --
> > 2.51.0
> >

