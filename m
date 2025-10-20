Return-Path: <linux-kernel+bounces-861095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B467BF1C95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0B2188B9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92141322C7F;
	Mon, 20 Oct 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBTGnF0o"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C052FE066
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969802; cv=none; b=GI5GtRiUTCRit9FPsRkjbFQ++1OzXbo7tzun3SGtE/zRkQm4IvA4JtBKxvrqCm8QaT6ktX5xmYyG9Z0oVBNL/ZRnEgxv+erqQ3DXltI87uD9ofUmLklN+V4vMBi704AmLZ8OEeWpB3E+PSYOsfkAkBPSCTtzm8a/tnUSwjxGl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969802; c=relaxed/simple;
	bh=bqdq9WmXPaR8Gsjoe2b8oxuoY7eohXxoBpzukdwSAp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0gMxfqBW93oSALkWRZtUGLwZ3Shwbasv8hQFzvA0M5tTl2UOvZv10S9Ojx+BdZaPN+bGt60DJF/2qMz3i+8YJ7op0LbP7q23iwvn+VbhCe6v/63slWkxD9AOVPEJeCNksIjLpZgt8YzbctQCMAzoJ8OfZ+f5AiBi50GIj8KWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBTGnF0o; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290c5dec559so33937525ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969800; x=1761574600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqdq9WmXPaR8Gsjoe2b8oxuoY7eohXxoBpzukdwSAp0=;
        b=XBTGnF0oO/ykFeiHWuJ0sK2VjnSv4wGXIBjWTZs1XrUvxDNfd4zIo9fR/2IsN/WdyY
         iUrtBTUgTph8f6rphym+aR8PvqJSFg3FnpyHapNKiDysgEkBVyx8kQ66drEQh6P1S41j
         fnDWtQNJAKSCKJb5N7dz+3b9HX8UQJH6CC38MukZTCr7aSG6oYVAnwWJo1CCEZQWUSuG
         sIlYFzVGAVVFRZFP4Gyc/70vaZ0T/idGY2jQwPRYdSNYb1JseOUk+dxWMJfFfVWqScDc
         Jj3vpVJpzGi9XpjaAjvuIcG7bJUohanYbKWhXBQ50qnzLROZNvhKYmRqJvRvrucnVLuf
         8BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969800; x=1761574600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqdq9WmXPaR8Gsjoe2b8oxuoY7eohXxoBpzukdwSAp0=;
        b=GsLSDUS14VX7XX/Xoqk+STOE/bbng3yh4Ic99QdWW/QTFFIaFh/l4OwOvSzF449X+e
         KSv5Ii2E+47YcaRgKP/snaKlIQYe17Zt3KA2Xs35CX/KX9FsHGtVdbLUzXsZIQeT2wSF
         ebpWMEW5T/Blj6LOCPAzlUjRtQSPOvWkUEHey58EoflTGyPVmyy3unX408NlM1u0aPVg
         VGqI7tPltkGwXfYMmpTUHmRQCExoHfwq7lNtdpnQ5KR8P5mXASJcPznjpeFhI64AxPhL
         1q/iwhH23/Qy+hRwzwJmQpKirnbIm9BEMhj8wDrd5+tkPdklvLktXofVkM5Fx/tnUznp
         PSGg==
X-Forwarded-Encrypted: i=1; AJvYcCVO7TPHHHxdpEjN69gcrUpyFwMRWns8TTrgGO/ZEie4X4KLnfZv1k86i9zU1Y86IoZDOnoI3gFXCEsj0Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2l7pJVMtxp+nF9/zJQvxFu686Gl0eurZ/b9Tvg7DtRgBYSKsE
	G6cN/M0ShZLPIQxN6tDOobjVm4fvypjd5qm/jKylAAwt03elhkbhHtcDZnMM1xSzLM2q031wUKS
	BxrHqfrjpgvg7xrUL/BgR1SZ57Ve5Yj8=
X-Gm-Gg: ASbGncte6T4sxPsV7bGQ7LW+vSEXxcSfb3mudYsSAdI6Ho2eIgM8XxPGBus+X6u5u9L
	+iHaZ8Aqd8hjML4obF5fqS+4anlihn8H12LVaeqXA7BJNFQaMqd4I27e3cYDu4jZMryNlaFyMTb
	m4uQPyB4fEH65rRo4jLgk0p6TSbkERgdQV9ve5OGmgkJ5QNeaXD1xCBqUjweNBc+JqbLve2CuPs
	eOIajNVyZZQkQPs5KAvxYuw67+vnPQOILC9ucRtUrn5MgUgDMfEuI94R2hsbTP+WRSSFVdBLFgg
	flwCIhLCTXpXOc8+98XqA5/f
X-Google-Smtp-Source: AGHT+IF71shr5BTQv0oq5eLWvgxmXcOQ1nEZ8rFk3kgzINgGyypUZnjlZnnQfErZnclV+r8kM1yF7mXz80sc3mNjFCg=
X-Received: by 2002:a17:903:11ce:b0:290:9da8:f88c with SMTP id
 d9443c01a7336-290c9ca6b61mr160740585ad.17.1760969800070; Mon, 20 Oct 2025
 07:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-7-laurentiumihalcea111@gmail.com> <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
In-Reply-To: <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 20 Oct 2025 17:18:59 +0300
X-Gm-Features: AS18NWBTX8pCKgoouBoSyxGFd8xpmwwpvcDYztextRp06KZCPCFp7jOkfhl48Co
Message-ID: <CAEnQRZBd1nadLPE0NSWOJLRNwFEnRhOTENv_vestHCLxe41Rbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] reset: imx8mp-audiomix: Extend the driver usage
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:57=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Oct 17, 2025 at 04:20:23AM -0700, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
> > which allow users to control the assertion and de-assertion of the
> > reset lines tied to some peripherals present in said subsystems. Some
> > examples of such SoCs include i.MX8MP with AUDIOMIX block control and
> > i.MX8ULP with SIM LPAV.
> >
> > Some of the aformentioned block control IPs exhibit a common pattern wi=
th
> > respect to the assertion and de-assertion of the reset lines. Namely, t=
he
> > user is able to control the state of the reset line by toggling a bit f=
rom
> > one of the IP's registers.
> >
> > Linux can take advantage of this pattern and, instead of having one dri=
ver
> > for each block control IP, a single, more generic driver could be used.
> >
> > To allow this to happen, the previous approach, in which a single reset
> > map is used, is replaced by a per-driver approach, in which each auxili=
ary
> > device driver holds a reference to a certain reset map.
>
> Can you shorter your commit message?, basically, you just add
> imx8mp_reset_info for difference auxiliary_device_id.

It is always preferred to have commit messages trying to explain the contex=
t.
I have never heard anyone complaining that the commit message is too long :=
D.

Daniel.

