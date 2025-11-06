Return-Path: <linux-kernel+bounces-887962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213DC39753
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33FA44EA8B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B402882D7;
	Thu,  6 Nov 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx6awSaD"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0A27F19B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415453; cv=none; b=Y2yNHPs8Oy6k9jy301SfpZc/r7e+vgGFhu43JkV7D1lGnvz9IE9ndhXRWpySZAmW51NUCTTNgZJNMrhL58kw0zqVZ9WSUlV0udE7NAnVBWRBDxp6gKheojqOKAiXjkqW8ZSKLI8+A2qwvShabsSchro0OcEAesGMuiO8foVjWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415453; c=relaxed/simple;
	bh=p3t1Nu3/jaRiIeOqwFNK5UrO9I5BIOo4m9uqYA+ne9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5LiDiNkwmbhCfisjpr9vKRSpuOdtIJmLY96j0d2OFuf3Sdn4Uz5E0B0h+uzZlEP/doH+VNVttuM9dcE46IdlJqJPDvwU8lXexO7WuYYKuLA1ou0WeOULxD7YpRQI3smshNlZ2OAdRI1YLwn5qrnVfR0fE3z+ElVU0TWwJ0BMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx6awSaD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b729f239b39so28397966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762415450; x=1763020250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oSZTMv5D/sOGGLnpJ+IvuCz5xyHo5sq+jQga6CKtnM=;
        b=Yx6awSaD7lS9u7PttF4PUpdeWss2Yn7T4chucVApGLMuE2r1Q9G+1luxSzXa1vAg9M
         MU+heyTc4xfsXpCsUWqU+9oEZArL6hjBqOOGUopCctJTQeP4xhVgmsMdDgNE5bcqrvVA
         YsMMhuLDt5no2Gcn9fFhXvlS9o7PrtuxmSKDw6LwgHeN8iUsvgrCBH0tqdNb4juFJxLr
         tiToJvoUjcHVejsrUWswgtTcQOZ/BZJNS1ZFt/de73t4b9shCmhS8du99ZeuZY8DdmVk
         oi5gHZ6bVcr8/V8pEP7w4XekiVS1NxYpGshEA053EPy3NbRQTfO8le9PNI9ZrSKGNiA3
         lDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415450; x=1763020250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oSZTMv5D/sOGGLnpJ+IvuCz5xyHo5sq+jQga6CKtnM=;
        b=Ol9i/O4B4S3VHac9+ME05Kq0YMsr7nHUv1RF0TmkLjFRi65pM8Iid4d6fDtXfdkXnx
         YiZLijymYnpO40L1p6xPRRfMOpDfiMD9RorD+4Idj7F9VSVzZkEA4WpNL7QQr22fkucL
         YwdoFd9x+RJdC0SCAOb3cHPe26/eLUep+04kKGTqgP0uuIiXgtU/7VENLKmCn8UZD7eI
         ztV58ObtXFeE5eB5Xit6+fZsKspbyNFz224wFpLcbjGsOZIx6BguAV1ETyq9KPP2dtN/
         gmpxyRT9idkLLkCBHwpGHF52KNbq/2IXHt08M2V1CP2h8Ppz/rSYHNF+fT25YyyCwIyA
         x+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAvPFgIjXZbzM9xLx2gC5mQozXKWd9KuaE6WNqLrfNMP3tg1FbcCiVa1jchcg8PvmcA7vviJt1DluH6aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpaLLtky714+a2DpNGVb4eYTf+W1NvP+MzWZPy9azOUZgmrbB
	Ftd5c8VPsLaCxWrBg5AXevDVubejSWWIuR3LkUuS5hYtUVZgN/95+11qXqLVktQ/1tA+T30vyzw
	8Pg6F9gh9GXMoi9NcYTVGDx6wH1CzeDXa6Ura6urNFg==
X-Gm-Gg: ASbGncvVOWWWuLLYEbXveqeanTJiQtRl06pqBGl4RL4VzRDmyu1NKAyngB/TI6NOnLN
	UPWEAgyf+3tNA7krT0TLIQMlDaSf8s91uJEsuK1cXZSzLdG8pnhl7tNoGQnFWlVKIUKer1o8136
	uDHMEXf8OX+F8V9mcQ0QWeQKOspuqeVTAQJdb78pvjQz2AjD08wgZHkUHhGOVIMYd6iNFTon2N0
	TUEYDVT7YtxBASelxGh+a+e9xv+bvDkNnfUj2k3k215lgjpUou5RAPxbSIctg==
X-Google-Smtp-Source: AGHT+IGTqwA2P7XvjyYF/Izos2lVy+T5to2mL8X2E6WlWDzOEu9Bmz8GxKORg8EJlnHJ5cxaDH8TQQoU0UmnunUk7JI=
X-Received: by 2002:a17:907:94d2:b0:b72:6d68:6663 with SMTP id
 a640c23a62f3a-b728964dea0mr251219566b.31.1762415449844; Wed, 05 Nov 2025
 23:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
 <20251106000531.GA1930429@bhelgaas> <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
In-Reply-To: <vrgjkulv22hzbx65olh3zpyqxq6dr7d5mepngjwgc3gudjoxwo@ll7xc2teya2s>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Nov 2025 08:50:37 +0100
X-Gm-Features: AWmQ_bkYpQyZF7OktEjeeIhdfj_KOUOxVV3OYB8DSDbc8qdV2MpPBlN_Lqu--DE
Message-ID: <CAKfTPtB=oMPsfjRFcQrAKM1m97B1LL9RJYVix+ea9Vb0FqDk3A@mail.gmail.com>
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Minghuan Lian <minghuan.Lian@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 at 07:24, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Wed, Nov 05, 2025 at 06:05:31PM -0600, Bjorn Helgaas wrote:
> > [+cc imx6, layerscape, stm32 maintainers for possible suspend bug]
> >
> > On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > > On Wed, Oct 22, 2025 at 07:43:08PM +0200, Vincent Guittot wrote:
> > > > > Add initial support of the PCIe controller for S32G Soc family. O=
nly
> > > > > host mode is supported.
> >
> > > > > +static void s32g_init_pcie_controller(struct s32g_pcie *s32g_pp)
> > > > > +{
> > > > > ...
> > > > > +     /*
> > > > > +      * Make sure we use the coherency defaults (just in case th=
e settings
> > > > > +      * have been changed from their reset values)
> > > > > +      */
> > > > > +     s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
> > > >
> > > > This seems sketchy and no other driver uses memblock_start_of_DRAM(=
).
> > > > Shouldn't a physical memory address like this come from devicetree
> > > > somehow?
> > >
> > > I was using DT but has been asked to not use it and was proposed to
> > > use memblock_start_of_DRAM() instead
> >
> > Can you point me to that conversation?
> >
> > > > > +     s32g_pp->ctrl_base =3D devm_platform_ioremap_resource_bynam=
e(pdev, "ctrl");
> > > > > +     if (IS_ERR(s32g_pp->ctrl_base))
> > > > > +             return PTR_ERR(s32g_pp->ctrl_base);
> > > >
> > > > This looks like the first DWC driver that uses a "ctrl" resource.  =
Is
> > > > this something unique to s32g, or do other drivers have something
> > > > similar but use a different name?
> > >
> > > AFAICT this seems to be s32g specific in the RM
> >
> > It does look like there's very little consistency in reg-names across
> > drivers, so I guess it's fine.
> >
> > > > > +static int s32g_pcie_suspend_noirq(struct device *dev)
> > > > > +{
> > > > > +     struct s32g_pcie *s32g_pp =3D dev_get_drvdata(dev);
> > > > > +     struct dw_pcie *pci =3D &s32g_pp->pci;
> > > > > +
> > > > > +     if (!dw_pcie_link_up(pci))
> > > > > +             return 0;
> > > >
> > > > Does something bad happen if you omit the link up check and the lin=
k
> > > > is not up when we get here?  The check is racy (the link could go d=
own
> > > > between dw_pcie_link_up() and dw_pcie_suspend_noirq()), so it's not
> > > > completely reliable.
> > > >
> > > > If you have to check, please add a comment about why this driver ne=
eds
> > > > it when no other driver does.
> > >
> > > dw_pcie_suspend_noirq returns an error and the suspend fails
> >
> > The implication is that *every* user of dw_pcie_suspend_noirq() would
> > have to check for the link being up.  There are only three existing
> > callers:
> >
> >   imx_pcie_suspend_noirq()
> >   ls_pcie_suspend_noirq()
> >   stm32_pcie_suspend_noirq()
> >
> > but none of them checks for the link being up.
> >
>
> If no devices are attached to the bus, then there is no need to broadcast
> PME_Turn_Off and wait for L2/L3. I've just sent out a series that fixes i=
t [1].
> Hopefully, this will allow Vincent to use dw_pcie_{suspend/resume}_noirq(=
) APIs.

I'm going to test it

Thanks

>
> - Mani
>
> [1] https://lore.kernel.org/linux-pci/20251106061326.8241-1-manivannan.sa=
dhasivam@oss.qualcomm.com/
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

