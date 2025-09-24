Return-Path: <linux-kernel+bounces-830552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4418B99F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF3380F93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A62FB0B5;
	Wed, 24 Sep 2025 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCMTcW8/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DB2FD7AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719102; cv=none; b=QbruSvInuJUtqjaKaIkFPmL48Abpql7wkoK93Esg1HaHgMX1X7g7oF/22FIwPHcUG8PuUoKtG8C9GR/a25AA3l7OjKWxH9srqByRw+Mmo5noBdYsOq2ODDcizjm+zyoem5tSYmo6I0D+qIZYV3uc/upCyp7TvSDMSPBnjYLP0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719102; c=relaxed/simple;
	bh=KMWRTBxhzUrCLpchCiypHr9RXPN/vVczjD1fykuzDjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXrahj/+bi0NLXfoGaWIGYaewEzqWxwfMkN4IzyAqHUlItAAkyDCioa3oXsRuespGSoWIevdzWX0p65bRxKNqQZb61IvQfExIKvvdvXNn6UQqpzNkk+mZxmWTwSffIBmTKgoIPGz8iXq7ddjUq+T0y/oxvbPHjGkSriK9m78QF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCMTcW8/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso5226124b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758719100; x=1759323900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML8MT93NBaCozkqy3f5m8pHWK455oP1ORVjpuJLm5oc=;
        b=JCMTcW8/ThqqXZ2v1sJ7Sv+jMJCFLhAKsRkpIKIeQIJXo8qGHTEJkWCLpwmwc5R0uY
         GVtljqd3PmXKubL72WSIzqB35whCYQin+pDyaPoFn1BnVJKhUBiU6QBHi8CNpTH00n9W
         IijKyO/MFWpwgp9vJKaEqPZ32c+mM4Cf+d1Vf3uNbNMJXjYsqc+lOyEoFVyK3D/SePFf
         /MFGjQ9oKE/HmU4BzVJ7Ter8nolDFTqu++ZwA3Yr7aRrAvJyXBEHPWf1hVxmavcgfMac
         bpaR9sib2RtwbhRir8RQf6XUv7utYEG75TQfYUXX5Uyfo2T2P6zykxw75XownAneuRoT
         kl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719100; x=1759323900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML8MT93NBaCozkqy3f5m8pHWK455oP1ORVjpuJLm5oc=;
        b=wOhIHxzG0XM1DV2Vop9I27BUqPIsV9NWMu6hB4N6ssRXZ1KJNS1KOFuP1YplO8fb+v
         xpL8v+zoHjdC8iUqfvvGg+wd15gZ/FF5DAwqBd5YT4g1lIA4E92/MY2HMgsFrojQnfpE
         gY6g3j4UwnHxh379RuzKJFTjxaFmxBtG6SKdf7oetcuwiEutoQbzpBKB9tE3l6JKEfnq
         3REAsCiUi79hvqQJOPiZQ/xQ/CWjxvOnHNM9Dp86FoD5cOC+HZYcVNjPpnwgcr/2TgON
         Z0t/8WtiawQ7JFGMIFsHBkn5HqpCChDv06vk1HEnza1vDGdjeBsbp2KjXU1Z4qJmZqqK
         /mJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyxbQp6Ri6SIs4oRCo6l4n6uAPrWtMgWUZLP00kjaxgZdZNKTeCHUCAjHZipQlc8KxZ3vPy8EqDFIxAI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUTDUdJlYDutIr0q48RD9ZvXwSGEzVctF1F+XtJiICj6U55s2
	FEZS9OgrsWO3GS0qAxQZX/T0w4KTGEcvngEYPQNCHy+IMkVMpJJPb5mKjbBrEu3DXMz9FDZ45wD
	yZ6EWBTFnw7gLVyv3/mbu9Q6i/eLECW0=
X-Gm-Gg: ASbGncusQNX/AtYkrAkrIRSR7fOHWBHVMzpiwdeO2Gc/mYDmvcc3yA5YLxXGUvhKPaT
	J5QAKhosfbyua2tuSveIAVC2SD4YJklo7c6F0loJVLpDt6AqcShqyRdX2HOayhat0Xnd4IUC7hF
	+fuxEvvq0/kZgo+msMakXFFxix8V1k2X6OyjKpdRapoMbSIzkuu9EFl84uvaxBtnMWAhJSE/RQQ
	xHpfRnk
X-Google-Smtp-Source: AGHT+IGCUZlb7GHgT5j+JVNTpOON3z17rHhaJH8wYaV5Fzq+5A7QIaXDxQAJZsuGjTC053XYov/IrdtaNcnRVtX6QBE=
X-Received: by 2002:a05:6a20:6723:b0:2d5:e559:d241 with SMTP id
 adf61e73a8af0-2d5e559e089mr4875908637.7.1758719099609; Wed, 24 Sep 2025
 06:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch> <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
In-Reply-To: <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 21:04:48 +0800
X-Gm-Features: AS18NWDPd9WPADUis1pKLRli7PBC0PtWHTmrvMja5YpnlZ2VdCkq5JfPN2APv_M
Message-ID: <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:47=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2025-09-18 at 10:21 +0800, Kevin Tung wrote:
> > On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > > > Summary:
> > > > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > > > based on the AST2600 BMC.
> > > >
> > > > The Yosemite5 platform provides monitoring of voltages, power,
> > > > temperatures, and other critical parameters across the motherboard,
> > > > CXL board, E1.S expansion board, and NIC components. The BMC also
> > > > logs relevant events and performs appropriate system actions in
> > > > response to abnormal conditions.
> > > >
> > > > Kevin Tung (2):
> > > >   dt-bindings: arm: aspeed: add Meta Yosemite5 board
> > > >   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
> > >
> > > The threading between your patches are broken? How did you send them?
> > > git send-email? b4 send?
> >
> > Yes, the threading is broken. I initially used git send-email, but for
> > some reason, only the cover letter was sent. I then sent the remaining
> > dt-bindings and DTS patches separately as a follow-up.
>
> I recommend using b4, it helps blunt some of the sharp edges of git-
> send-email.
>
> https://b4.docs.kernel.org/en/latest/
>
> Can you please send v2 of the series so that it's properly threaded,
> after applying tags you've collected for the involved patches, and
> checking your work with `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-
> yosemite5.dtb`?
>
> Andrew

Sure! I have sent v2 of the series using b4, and the patches are now
properly threaded.
I also checked the work with `make CHECK_DTBS=3Dy
aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
and the warnings that appear are not related to these patches.

Kevin

