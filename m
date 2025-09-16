Return-Path: <linux-kernel+bounces-818546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC3B59321
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD23A7B290A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935C2F7AC0;
	Tue, 16 Sep 2025 10:15:11 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9C2F9985
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017711; cv=none; b=D/2TyMg3lJNSj4Hd3XnMCoU3x86We6zmbtcqVTarXox1+JJf1YFLfnydrRBk0RAaRKCRp35IdXiBVzzOw3QZpnEgtg7eMciAe3b3TbMeUF/w6hFduicULzTGQm44Y4HTHNPuYfmdAaPn+lTY+VGxQ2Sdf9+jP1iRHeER18h6G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017711; c=relaxed/simple;
	bh=HROZpllWSaMccM/VLWuB0kpy0TJhHwHU9kTqwzxCWc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmPScHWDYZ+L84NKQae67b74so8EoR8S4eO5+sebnRJw3JmkSkK6YIJp19b6GysNz6d+jZDMhlJ3ScLxrtms+Gx+5aJYvwRDqkg6VT0sOkRp9dFcLoP8dXVdpye3F5XocKlUN9Avz95C0K/M8pr5DEN8Fu+O28aOfyH9mevX4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8dee4d26944so662244241.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017708; x=1758622508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yxShZZXYgWMyGx047XJbFO5W2W4XcJcCx4gW4jVWvk=;
        b=tYpNWuGdh1ZG0iA+jKmCsOtAM7tui2lT9GP/7hfh0/BBWP2ULEt5LpzGenkjN7jMus
         W8RyZ/z8C3Jj50k9V6SYVire7OoH2rPh0FDO7SXtNdgTU93pUFXf12vH5T/LSDmzb1rr
         QKKfDvcSBgYUx+rbI4VIl52OKKHdXXVYqAIdod8RKEYKYWakp/VgpCm2yiZfcjbvYOVA
         DOEMFLFmZ5fzsdbGRBXu8ps3EedS7ZPuhek7NQc2J+oMatq5x60SDm+IguWQ8IAa3XRI
         pzt/GP77sGSNJW1joBQXidSvProzypUQJgQ4He9SpbLaE2R8xrfnH1snRt8IDLvJxf2a
         7/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUKF6b2f+6d5pONVZNxnmgznglUVpbGMYwLk+NZuhcdw0cezuL+3epkL6DzeEuO8PO4slgx1nIyuL9lKgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gHbeLQfGvgmymCqMFLvzeqGcKKIzF/hkgaqwAocwGZCRX75C
	Vrk7jtOmp6PtItZHynFyOSSnCa2yQGgCvgVbRSCv7jUTMRHDJgpdYniPZxOkAlrc
X-Gm-Gg: ASbGnctyYCWJyw7bZ8rSSLFuIsZjcQKpSziZ5g3ZY0Vl97kUdN+DwzGp4G7wco/LWGC
	7E2TqBlAUj25/mjqBn+W+ULJfh/5G/HDKuBW035GFHTPccWmGNo9L3ozjV36VSgZ3c37AysLblY
	sYHykSzHrE/v5Y1YXAPYxW5cJYc4EwcYA2MyBTJY2za9v5lABZJtN97gEuSiaiV5aiuDt+GhDuO
	W6Y9pUQon+u0PyGr8/U8UgYAJMe2+QBqBsCT8mHDk+4fuGVa3Jy2kouSW5DVHe6b8coWNOp91DX
	T87h5W4hrmniFmPSertHrIpn+J8ixL1b9j9LrJnmO8rHVLBgRaq2wpzYfxXKHzz/UNQEe4Ifjue
	7EHxfDH6d4CfibaEszG090kTq9HcAxU+F6LhXOEh4DqiiLww+EW8cBD+2nAJB
X-Google-Smtp-Source: AGHT+IHgEmrLNUtHRv6dLoMTvVbTF8GbvmX7Tm6n8Qst/aO+Ie347hhH1ccKVrgv+ozbYW+PD2NXeA==
X-Received: by 2002:a05:6102:510f:b0:523:759e:b0bf with SMTP id ada2fe7eead31-5560e9cd190mr6146103137.20.1758017708275;
        Tue, 16 Sep 2025 03:15:08 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd38f8c8asm2628213241.12.2025.09.16.03.15.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 03:15:07 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8e0c90cac25so233490241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:15:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDint/DTsM58EWgF+ac46W5PavInwiI/eY7h5XHueaYx1xPlNgisthMlE9/yPSDw5X2g5bDMjb+ojNwd8=@vger.kernel.org
X-Received: by 2002:a67:ff90:0:b0:569:1c73:46c5 with SMTP id
 ada2fe7eead31-5691c735ffbmr267311137.2.1758017707282; Tue, 16 Sep 2025
 03:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902105710.00512c6d@booty> <aLkiNdGIXsogC6Rr@zatzit>
 <337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org> <aL5dNtzwiinq_geg@zatzit>
 <20250908145155.4f130aec@bootlin.com> <aL-2fmYsbexEtpNp@zatzit>
 <20250909114126.219c57b8@bootlin.com> <aMD_qYx4ZEASD9A1@zatzit>
 <20250911104828.48ef2c0e@bootlin.com> <aMebXe-yJy34kST8@zatzit> <20250916084631.77127e29@bootlin.com>
In-Reply-To: <20250916084631.77127e29@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Sep 2025 12:14:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
X-Gm-Features: AS18NWCbl1r2QYO00aPBgisYLqrkmJmQ3Y4JYZGczVS7GzKJm4yKut71Lemfvns
Message-ID: <CAMuHMdXXi97HN-G_Ozbs7vc141GmbMTPD6Ew6U_0ERj5wh6gvg@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: Herve Codina <herve.codina@bootlin.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Ayush Singh <ayush@beagleboard.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Jason Kridner <jkridner@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Davis <afd@ti.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 16 Sept 2025 at 08:46, Herve Codina <herve.codina@bootlin.com> wrot=
e:
> On Mon, 15 Sep 2025 14:51:41 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Thu, Sep 11, 2025 at 10:48:28AM +0200, Herve Codina wrote:
> > > From the addon board point of view, the only think we can
> > > say is "me, as an addon board, I need a connector of type 'foo' and a
> > > connector of type 'bar'".
> >
> > Agreed.
> >
> > > Also, at base board level, statically defined in the DT
> > > connA is described (type 'foo'), connB and connC are
> > > described (type 'bar').
> > >
> > > The choice to map connA to the type 'foo' connector expected by the a=
ddon
> > > and the choice to map connB or connC to the type 'bar' connector expe=
cted by
> > > the addon can only be done at runtime and probably with the help of a=
 driver
> > > that have the knowledge of the 3 connectors.
> >
> > Agreed.
> >
> > > I have the feeling that the choice of physical connectors to which th=
e addon
> > > board is connected to is a human choice when the board is connected.
> >
> > Yes.  Although if the addons have an EEPROM, or some other sort of ID
> > register, it may be possible for some connector drivers to probe this.
>
> Right, I think we agree that a driver is needed to help in the mapping at
> least when multiple connectors are involved.

I agree you need a driver to read an ID EEPROM.
But why would you need a driver if no ID EEPROM is involved?
If the connector types on base board and add-on match, it should work.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

