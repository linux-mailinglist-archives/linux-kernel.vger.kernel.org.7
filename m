Return-Path: <linux-kernel+bounces-823527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2526B86BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FE83A6A95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DA2E2F09;
	Thu, 18 Sep 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5FQPO83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BE2E8B6B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224677; cv=none; b=UmCfu1X2Qj8jQOF0Mp+a8HgHBuAfEB9vIp3MQJmEYMjZy0VHGA2fGdiEZ05rftruSPxwZL1BwS3kbtQxOn5zPq3BP0VqzH3Xf9qBYIPfhLURMJUq99WLYI3Rxd2D0iwrg0DvPyJbS2kTgEKKO/qpO+7eUHKTClBlO0SIIYuUxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224677; c=relaxed/simple;
	bh=xDt0aZagELXwSkTdz82ubamN8Iov86wVWkejVlcjJIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoAAXkpZn5+ZFDWFoJEbtOlIeIUBHen+2j8eHQAhCYIJv7WkmoyxpwR08iw6DRoD14lRivAFeNUy3NcaK19BQ/x+IcuIBVIgC8dtwgobNnZCh2+iv0lDxizt3hQJr0ZnRCcwRAFLsLQwIwFxczyNeP/xVhRsWF6nsw6IzYyd1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5FQPO83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27E7C4CEE7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224676;
	bh=xDt0aZagELXwSkTdz82ubamN8Iov86wVWkejVlcjJIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A5FQPO83h0wKAhG07kgXFOaEJL6tYOKh2fngOkQril0hLbZZmjcXeUljfduKCCRtw
	 iu5a7LRoSizH9mS7jRyB2aoEuKfAW9PjFckimlYt5jtT3qSKl61anUHL26sYTjXFZT
	 iEptKin3FfZqNyqbg5AdBSIfuGaisOmRuyCeWERgZDK8djiEvFIqqhGzx5ZmgnhJg8
	 FxJghXNarV6GlowxrFhVzePBJ0mkLauCqyFcpiK/Xo8mj+CwtboUr8mNg28+yE1Jbc
	 PXocGgLKhGWeV/CYGp1LzcLaOEepB6683LUzRmsxcv/Fn8eX6s+tjsOKcymfBsCtOZ
	 uFD1ZuZ6eY8lA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2350899a40so133371366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:44:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxku3F5WUUtOt8EV29UwuOx1Ydi7JcEXII/ppwVZOmhp+ysjS15
	rQ0oc9vAj1fssOePTjo6HWMRXsaQh28x0yZfEFphgnAu/CpC8As/CWtHWMV4IxHkJ/QqFBPxbfZ
	BoQ0y8Fi+lrvfiwV7bobDtpp+hxC3Zw==
X-Google-Smtp-Source: AGHT+IGAhcnuc0wpWw/s1p4UA6lxTrINGFr54H6UilY1ZtrPf2GcAEbRMuog4KleHa2rD/k9wiHS+9FlPpcBXhXUlUs=
X-Received: by 2002:a17:906:6a1f:b0:b04:85f2:d26f with SMTP id
 a640c23a62f3a-b24ef6880fdmr46219566b.25.1758224675450; Thu, 18 Sep 2025
 12:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916091858.257868-1-lpieralisi@kernel.org>
 <20250918135555.GA1540012-robh@kernel.org> <aMwjcIS/rvxkSZdr@lpieralisi>
In-Reply-To: <aMwjcIS/rvxkSZdr@lpieralisi>
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Sep 2025 14:44:23 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XKT+HkE0W0BLKbQ76RtgBrKToLAVaWOy80mLkD=x0+A@mail.gmail.com>
X-Gm-Features: AS18NWA_awGPL2y1OiG42_bMmJJc8tA99I270bH2QK0xh_S_5QTtemDGIGlw3EA
Message-ID: <CAL_Jsq+XKT+HkE0W0BLKbQ76RtgBrKToLAVaWOy80mLkD=x0+A@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Sascha Bischoff <sascha.bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:21=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Thu, Sep 18, 2025 at 08:55:55AM -0500, Rob Herring wrote:
> > On Tue, Sep 16, 2025 at 11:18:58AM +0200, Lorenzo Pieralisi wrote:
> > > In some legacy platforms the MSI controller for a PCI host
> > > bridge is identified by an msi-parent property whose phandle
> > > points at an MSI controller node with no #msi-cells property,
> > > that implicitly means #msi-cells =3D=3D 0.
> > >
> > > For such platforms, mapping a device ID and retrieving the
> > > MSI controller node becomes simply a matter of checking
> > > whether in the device hierarchy there is an msi-parent property
> > > pointing at an MSI controller node with such characteristics.
> > >
> > > Add a helper function to of_msi_xlate() to check the msi-parent
> > > property in addition to msi-map and retrieve the MSI controller
> > > node (with a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to
> > > provide support for deviceID mapping and MSI controller node
> > > retrieval for such platforms.
> >
> > Your line wrapping is a bit short.
> >
> > I had a look at who is parsing "msi-parent" themselves as that's
> > typically a recipe for doing it incorrectly ('interrupt-map' anyone).
> > Can we make iproc_pcie_msi_enable() use this? It's quite ugly reaching
> > into the GICv3 node...
>
> I am not sure I get what you mean here. Possibly iproc_pcie_msi_enable()
> can reuse this patch's code if I extend it and make it a global function,
> yes and somehow use that function to carry out the check for an
> msi-parent property with no #msi-cells property or an #msi-cells =3D=3D 0=
.

I meant using of_msi_xlate() (or even of_msi_get_domain()).

> Don't get what GICv3 node has to do with that though, sorry.

Just trace what the code there does after it gets the MSI parent. I
didn't study it too closely, but why is a iProc PCIe parsing GICv3 MSI
stuff itself? There's either some missing feature in the
irqchip/domain APIs or it's being dumb.

Rob

