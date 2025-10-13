Return-Path: <linux-kernel+bounces-850250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6500CBD2597
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832C21899FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE02C2FE073;
	Mon, 13 Oct 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T4Bf6HXm"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B42FE05A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348602; cv=none; b=cd5Vlf7QTDDDy2vFCg+ge+gp35rwbnk5yQN+Et0GwCtAkokZr+aAGdOgI51nWQrlMPsrdbAPBxKCf+wMiXxF/uqZUjkzwdL6iZaEBDowQ6QlB/6n00x/SZfXdwSwRT3kl8Rp5U13DPH8GQGn1GwhDOv90W+sS627xEEYzZ4qu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348602; c=relaxed/simple;
	bh=uQFbHr84ZhdOMSQ4FYkvxS8K7ZU8bAh58pAmqFc4cc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUhQMXKTuWixgUC264XqwCsCcEQrzCVX1McORTCq+C3QCeO603GYQm1ggWgEAFHy/x6k4PrrFYP/EvGADhU3zTOxZz238g8BX2HkII/2GvPct8Fov/UOSXBQuxD0zoZrfz+dkLRD/gwtNdTrIx3DU0p+tP4JPim8zhJvFeTmKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T4Bf6HXm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso5047387e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760348598; x=1760953398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=541KDVIKt4Twpix35Nx3FbTRvhxdJEaxEaKbxcItGfk=;
        b=T4Bf6HXmq+PLl1egItiMzppPaI9WqiqEUBNSI5/1aPFFWR1/Ao5bcqbc28vbC2AAwM
         ZBdDdzhCQWg5PwLi8gVMjfKY48AMJ/wXcfMDnQVXN31tUAvmJJAZwUv6c/yW4SBbYez3
         JAhgzWb/faa8kBASVVDAAD9oTR6K14+4qj7b3h/qLfcCrs8vaJPnTeNq63QQ1V/Mx6gx
         Fs79qsCI6qB4rX1r6yB1aVwSn8iLsWazqmcoJ17wS5H7vnpiQVBJa1/aZuEXNx3lVYuB
         7l6FyEA8UHqCIX0E074pmRy7Hnz9qjPdKLrGeI7O/ZPwevs4l3vhuesoZEN4ncvmW877
         asBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348598; x=1760953398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=541KDVIKt4Twpix35Nx3FbTRvhxdJEaxEaKbxcItGfk=;
        b=PIgKMevgdPFxiDrzc97ny/tPOPQw9KO1jMsM1COIvd4fmufA04PTjXk3BRJC7UXOqa
         pVYXxJpC9IA2HzpCwy/Gawp4CE/vilqENAAlNBjnBfQRTNsy9l9PthhNqx8LEL9adeMY
         lNHTyBDv2qWydKo/IqBI77O/XtNuNL+c9jKfI6krYnQGxQ63hFWAwu3rmVhsKP9WE021
         aybK6yseu4eh1Ynew4A7WYUqpOCWwYb2asjg8GPdBH5uQgJ3GLxndeZI54r4gXdJ5mFb
         +gTBbImQzK9wy09yEn0Qwvl37ya7zK9cHllC+mDaddNWgzv5aRsXM60omE86N7daX91u
         W+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXuueelaorQy3gvMCTkpy1R/2UH+qfm0BVa/wDzfui0Bagol8+dF/WzCpPnQft8Z4DlpbJKDof51024pfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcMrv709+ug9jfB2g/4WrG18FoWjpAIi5ZUy8DTSx8rKHsM6A
	z0tzwlTZxuiPYSpAy77OK+TO9I8Vkvz9v3GJiTNpSIHHf+YE43RPXG7Db2pBdJ4GUC0zN9kdWAV
	QMTX2K4ExV2hcc2QXxE7j5UpiOJfgVtTexphyCBw3rQ==
X-Gm-Gg: ASbGncvQhXqFGF2T43nTkj8YjETP1qMx+M5y1QXEv5AOTNyKytWvs4THZDz5qAGS+UE
	7pfomDTv/ftsEddPdTg4vrk5D9hmZvTH9Y9drBIfZmRGYI8m6TUPcUcfNggvQR+NG9M33r9uxvC
	eLRmlOIC7K9fzZC1SzorEQz2h6u63LOSnNecmG+J/yJ4xc6vGfDK/ll9x4zqrmY6Eh+wBVjMbgD
	MOrFjbXBCRoESS6ezXDs9+56W2rT8UetsvzDNKrDR7e/0YGfUpuu03nvw==
X-Google-Smtp-Source: AGHT+IGg7+s9CClC0kNjgXyQvkl0V611RaE2K1Xq/BiiwFHeo6pqu80gfj5BX4tm7WD+Gl2m99myhlwQvLt2VF9EKjY=
X-Received: by 2002:a05:6512:230b:b0:55c:c937:1106 with SMTP id
 2adb3069b0e04-5906d8ed820mr5300700e87.28.1760348598267; Mon, 13 Oct 2025
 02:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com> <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>
 <yvbghnxttchfvte3nxr4ru62wqilceil2n7x7dgpa5gnm57ywu@ljrbw3c44qpw>
In-Reply-To: <yvbghnxttchfvte3nxr4ru62wqilceil2n7x7dgpa5gnm57ywu@ljrbw3c44qpw>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 13 Oct 2025 11:43:06 +0200
X-Gm-Features: AS18NWDXSA1oF9u0-aF8f-BfVdVBXnzMX3lhxDXthcbofRI_Rn4NpBjYuSbHa2w
Message-ID: <CAMRc=Mf++D-jbEPmPKc1uAxeH_RZ==B1ybWy7oTWFwJ+kAcHyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linus.walleij@linaro.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 6:09=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> + GPIO folks for the below API query
>
> On Fri, Oct 10, 2025 at 08:32:51PM +0200, Konrad Dybcio wrote:
> > On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> > > Even for the new DT binding where the PHY and PERST# properties are
> > > specified in the Root Port, both are optional. Hence, treat them as
> > > optional in the driver too.
> >
> > I suppose this makes sense if the PHY is transparent to the OS
> > or otherwise pre-programmed and PERST# is hardwired or otherwise
> > unnecessary.. both of which I suppose aren't totally impossible..
> >
>
> PERST# is by definition an optional signal, but I'm not sure about why PH=
Y is
> not used by the controller driver.
>
> > >
> > > If both properties are not specified, then fall back to parsing the l=
egacy
> > > binding for backwards compatibility.
> > >
> > > Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root=
 Port binding")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/con=
troller/dwc/pcie-qcom.c
> > > index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3=
dc06bd2f626f8f53920 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_p=
cie *pcie, struct device_node *node
> > >
> > >     reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> > >                                   "reset", GPIOD_OUT_HIGH, "PERST#");
> > > -   if (IS_ERR(reset))
> > > +   if (IS_ERR(reset) && PTR_ERR(reset) !=3D -ENOENT)
> > >             return PTR_ERR(reset);
> >
> > Please introduce an _optional variant instead
> >
>
> Linus, Bartosz, are you OK with devm_fwnode_gpiod_get_optional() API? Jus=
t
> wanted to confirm before I go ahead as there are existing users checking =
for
> -ENOENT explicitly. Not sure if they are doing it for a reason other than=
 the
> absence of the _optional variant or not.
>

I'm fine as long as it follows the conventions established by other
GPIOLIB _optional interfaces.

Bart

