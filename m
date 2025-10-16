Return-Path: <linux-kernel+bounces-856303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC375BE3CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6955E0418
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0933CE90;
	Thu, 16 Oct 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WHfXtQqP"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5133CE81
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622467; cv=none; b=b/LN1tQa05C9gPWsxVW5YqK7BU8f+TNgY5GxCj8eWW9vNEMSgjdrzgTKXDsT3pJgr4btBN8U4wkJi7WItlhYg7Cy2xLGJI+dW1p666FFGkEj3Vh6Hxuo17SUjPnyhwPyVEHUMkiIHA526M/LcGXibV3cZdlbGM+T5Fafed3G29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622467; c=relaxed/simple;
	bh=TIbHy+Z0k2K3fCKi+VbpjiLs1/PVwuQj2mTAMPKziEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A00ZC1VnDRtqQlZwPzuEhh5jKNbD4QhjpwVhBqqwGSpWRbE2nO14rjqfPDu+Fak4OmqJtztHQfHoV1fSg8WUJKZdr6ORCP92A4vKHo4okNODSAh2H3PLd/SXEXm8D0e6UfBD/zFv1K4GNh1aMWFQiBgiqqQIYlb44I1Guld+2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WHfXtQqP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579d7104c37so1021376e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760622464; x=1761227264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hV7HDDV7d/rQjqNE9K7eRYtxgXH4WZBCf1hQsUW93I=;
        b=WHfXtQqPKkEGO46qVkvlvyWJ+B1Ceoz9Ox/0y8uojf8ZpboEH6vIJgrt90Ke9GBbuM
         7g3eqtGtB1TD2PQnEr3qso4aqvorEEamDUToYDaTmYG8A6iKj/rJ25b+MRkFScDK140b
         TsnelOmQ9yz9EkPJ2KTOHoa8OFo10ucWwo2+h4paQQ2Nl0ZrFUa/LtPihYKTdC0DKEAZ
         L/jPBHMzJ0g3jK5UOOSp0SAjlXyJAa5zmHPniuL0IgN8hkGlizEAdd4Q6O2I8Vd9K2nf
         61njAkHNXHM/7Djad/3YmfvtxVbrE+t5EcxEI9eZLPL/eMkPXIiRtzckJ918wQnwB7pF
         SlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760622464; x=1761227264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hV7HDDV7d/rQjqNE9K7eRYtxgXH4WZBCf1hQsUW93I=;
        b=iOYO+FmZ8D9xOM6dTAv+ifOmJBong5Js+snz7BTz2yo0KEDhfSp9QH+k5xEKpNJTyS
         gT+s3qnAVx4hNVTAqYCZuMVR8ce4TgBLgcm30nz70cPUHNXfu9HYl1XgqiGbA8cYsVhG
         nKFQTDOESh8l1yX+oVxBITHMUaCLjAst0LIHQ9XXdNlLr4narv8scGg/s62jOIeuZMCp
         XOSYpb8Ly3uA//D9ink8GGsiZfoDbCf1JoaOzJoOiHzpdgLUeShhPyEw8ahfEE/t4QYf
         Qj0JjjvLsH9/U0dBEDiS3IZ7A4fmd3ktuTiW0t9/u7+Vpw6K0W2FmtGKoinVBmcus/ms
         y2yw==
X-Forwarded-Encrypted: i=1; AJvYcCWDStD97/lBijWEvyEzzS3DYhoiNlS5TxBcNkcR3kqZv8Xz1WkI2zC1+9pb+Gr1496KvxTEEOMDVELNl+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWRgwAYnHvvJh7O7PFNABiZ/OjEvpGmzyi5gmPxWTlGu18YOF
	j5n4lSc8g29NYpZF1336J4PJ4AdAx3/fc4za8i/NGzb6+7T2AfgBArw5hQpJ1fuMZ0EsW7g90XX
	4+4z3InLgYsj+/hanqMcw3GV9JePE/fNekLTePEqUh/mjozGhDVkJpIs=
X-Gm-Gg: ASbGncsVbXvp8CdpgAtPu3DAjG1vsc5z6ZS2JGzGh269iU7XYaauK3SbjhK3tkgPLa3
	1eNCNbQpNSJQfkDbduKk3kQQTU+Gjy5FCmz5j+ImqEcBTNR8ySYk83OMioJp4bW9xXkCC42D9Qt
	V/GHvKXCtWUw5sJaSzD/NMUPfj9dl82mvc88TkPmmZw5gCeVAPKV2UZHttCXC6Tf3a10wysXVeA
	RlMuEYDnNjC9CPkkh0vhucJUjA89/HxLpiQzTl1azFen/Lt1tI3OeFL4wMnFeW/wJ/oSd5TSOeG
	OzTogIdBl4mX2Gtx
X-Google-Smtp-Source: AGHT+IFZia1iEzr/3s7m2nxQ2YoGGpQuFa1cdLn3lelUEXgdsXE4QurhRg0vcVlptY3DWxqKgY6TbGSuBWeTV6sA8n4=
X-Received: by 2002:a05:6512:3192:b0:58b:138:cb63 with SMTP id
 2adb3069b0e04-591d845d4bamr82383e87.0.1760622463385; Thu, 16 Oct 2025
 06:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014155358.3885805-1-ioana.ciornei@nxp.com>
 <176060910602.64650.7023197009719546944.b4-ty@linaro.org> <o3oknl2onntkl2dgzpzsjm6xeunqxrq3j5afo5zb5gdy6xyo2r@4ctlictxhdlv>
In-Reply-To: <o3oknl2onntkl2dgzpzsjm6xeunqxrq3j5afo5zb5gdy6xyo2r@4ctlictxhdlv>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 16 Oct 2025 15:47:30 +0200
X-Gm-Features: AS18NWDVv8MlP6uw2dQyaHqupGAESjmFAAgPFTaJOd9tBhON_tj8pkU25B2KAgg
Message-ID: <CAMRc=Mepg=Cw0yUouEi9sJw+rPh3xRCQsbgYc=GVCsLXr3GAXg@mail.gmail.com>
Subject: Re: (subset) [PATCH v6 0/9] drivers: gpio: and the QIXIS FPGA GPIO controller
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Michael Walle <mwalle@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:25=E2=80=AFPM Ioana Ciornei <ioana.ciornei@nxp.co=
m> wrote:
>
> On Thu, Oct 16, 2025 at 12:05:13PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > On Tue, 14 Oct 2025 18:53:49 +0300, Ioana Ciornei wrote:
> > > This patch set adds support for the GPIO controllers on the QIXIS FPG=
As
> > > found on some Layerscape boards such as LX2160ARDB and LS1046AQDS. At
> > > the same time it describes the SFP+ cages found on these boards, whic=
h
> > > are the users of those GPIO lines.
> > >
> > > Before actually adding the GPIO driver, patches #2 and #3 add and
> > > describe a new compatible string - fsl,lx2160ardb-fpga - which would =
be
> > > used for the QIXIS FPGA found on the LX2160ARDB board. As opposed to =
the
> > > other compatible strings found in fsl,fpga-qixis-i2c.yaml, the
> > > fsl,lx2160ardb-fpga imposes a unit address for its child devices. Thi=
s
> > > will be used in the next patches when the gpio controller node will
> > > define its unit address as the address of its underlying register off=
set
> > > inside the FPGA. This requirement is described in the yaml file and i=
t
> > > only affects the newly added compatible.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/9] dt-bindings: gpio: add QIXIS FPGA based GPIO controller
> >       https://git.kernel.org/brgl/linux/c/d5896130a8781de5ac8970dbb7083=
ce4cd6fe57a
> > [4/9] gpio: regmap: add the .fixed_direction_output configuration param=
eter
> >       https://git.kernel.org/brgl/linux/c/ae495810cffe29c3c30a757bd48b0=
bb035fc3098
> > [5/9] gpio: add QIXIS FPGA GPIO controller
> >       https://git.kernel.org/brgl/linux/c/e88500247dc3267787abc837848b0=
01c1237f692
> >
>
> Thanks!
>
> How are the two remaining dt-binding patches going to be handled?
>
> The driver changes for the new fsl,lx2160ardb-fpga compatible were
> merged but not the associated dt-bindings changes in patch 2/9. And for
> patch 3/9 there are no associated driver changes.
>
> Ioana

I would assume Frank Li will pick them up? Ping me if that doesn't
happen in the following days, I'll pick them up into the GPIO tree.

Bart

