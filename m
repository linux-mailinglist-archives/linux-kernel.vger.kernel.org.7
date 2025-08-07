Return-Path: <linux-kernel+bounces-759381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B2B1DCD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE52117565D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AA221F20;
	Thu,  7 Aug 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B0uOnuW9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4172636
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589814; cv=none; b=fuoQ1G6dfijnnsYd3mZV3/x3o6W8tg6R0PWYiD69sGb8KLBkRtk1kVu17jctwCqyMBrLjENTwMq/aDEoQvJAzQ9utUSqlxP9EkSAhSEu4gOpqfCek4cjSy95LeiHsr6YMpf9wzXIaT10xTvG2l4e5El8eGqNqH1VlRCXwK/4yqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589814; c=relaxed/simple;
	bh=8xp1KnlDEk2U9CDh5P5T5g+1LdqC3Zs9Cl713SqU2tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+6LED8hYhT0AQa0jGZ+6wUwH5oxUhMFgaSuOWoeSBRaEd1ciBjiv3fzPWkBVA7cO3C+cULpkCkKFeIj4lb0yedusn1j9CcstCzcrpP/ieRKYI1vN0uOduBDsDJlhLj4OIEVe1xb7brjWxdpbZQyQvxu7dEJdXYwBQxrA8eU6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B0uOnuW9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b797ad392so1476325e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754589811; x=1755194611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tsCe5N2gySc6VwbPeAR1x0jE7zYqA5OJNfAjcrseA14=;
        b=B0uOnuW9Lek3pVlLShoP0xrfZsTxpdPhr4RiOdahUkdCnC2BQgx0F4m2myKm/kxE76
         JqnO8LrIZSmrlG9MjC9530OSRoLr42Jp5gRnvDBFGeLu8rSmbZYd+CGViZxMNbD7rI/P
         ozv8n0taf8jTCzuIeeysbnNR906xxY7WzEcWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754589811; x=1755194611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsCe5N2gySc6VwbPeAR1x0jE7zYqA5OJNfAjcrseA14=;
        b=hxKP4Bgkp9BWPJtLz8ZlMoMJa/Rw1Su7K13cOexMMOgWU5S6LOrL1WKpoDXEEIxOzZ
         cre0kJBoYuPhWQKkMMjJ+ybj8D7yMb4Ubk+nhXcvx9OAkGU/RQQneO5pp+umXGeCia0H
         SQEpcXCE/MUvKvQyE9MglRPKr5Q52FSTttfCQe+g9KSI89e+P3HPLkMMX6QFolKWIvRQ
         6zMeowngxXyxOpXbNHAfLETZLQYyUxRkZidhklbeU9kMRKA9ultIMrtjkjeWlBxX26v0
         ogFVJmbQSN9jJAvNYOMAHLKFRRKjcYNf6Qa1uZBUTufO9YwNp1VimMo7oiBDLEJcU7fq
         N+OA==
X-Forwarded-Encrypted: i=1; AJvYcCXDhgAuMKYlO75wT8FekSOFpVGcWoh0fi9s0kI3NOJ+16DNC6/BmXHR3BrAwUelPq64M4qlW5DT79hexRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIWP5wYK2zewAB7av6hKlXhDSfX+gYzXXgAFF+4bpKZqfpx6U
	ID30LpFZwgfOO0nQjrBbaqKvFE2JAUW7krrFFD0SBbzP7sLtpCKrbD23M78yYgcNdIxv+q/whDl
	rKt3e/DMwu+peV3OKunhBi3W4XsNdPzbwbK8K6y+8
X-Gm-Gg: ASbGncuhhj9o2tcEIcgn64xoP8Wieilkozl1IJAN95ZsCcyaDMztoroWSoSYahBnsu/
	iRtYfEIkvCVofPWEaqBX2cAcQjyjeUoAX7X97Wal+VKc9ttpY4l+HbTJI9tJpV/uNOUb0iIraCe
	H29MbgixNKrQQr+r8TC8qDs01/68B5+9sAQHEBAuKSjhsMvPc+GEZLpdgXv6/rqYLawHfWaKPcK
	c8BCsI5
X-Google-Smtp-Source: AGHT+IGxtV1LWhrRdo3JC0zmjO/3qahbZxj88Vi4n0XQrjfEYquPT8WHMQimEMtyURA/sbB2cafcxr/JmX92fyxW0XI=
X-Received: by 2002:a05:6512:689:b0:55b:9647:8e75 with SMTP id
 2adb3069b0e04-55caf57bc22mr2577573e87.15.1754589810606; Thu, 07 Aug 2025
 11:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613220843.698227-2-james.quinlan@broadcom.com> <20250806191448.GA8432@bhelgaas>
In-Reply-To: <20250806191448.GA8432@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 7 Aug 2025 14:03:18 -0400
X-Gm-Features: Ac12FXyuvX7HlpoSndQL62wtvS59Rdx6QOQSiDT816IH2WZzhrhSN71QgjKybgk
Message-ID: <CA+-6iNxsnj7-Nsy4Q6wFbiF-a6BwfYeTnCqdg1sAUXPCpyaMzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: brcmstb: Add a way to indicate if PCIe bridge is active
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006b7d8c063bca468d"

--0000000000006b7d8c063bca468d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 3:14=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, Jun 13, 2025 at 06:08:42PM -0400, Jim Quinlan wrote:
> > In a future commit, a new handler will be introduced that in part does
> > reads and writes to some of the PCIe registers.  When this handler is
> > invoked, it is paramount that it does not do these register accesses wh=
en
> > the PCIe bridge is inactive, as this will cause CPU abort errors.
> >
> > To solve this we keep a spinlock that guards a variable which indicates
> > whether the bridge is on or off.  When the bridge is on, access of the =
PCIe
> > HW registers may proceed.
> >
> > Since there are multiple ways to reset the bridge, we introduce a gener=
al
> > function to obtain the spinlock, call the specific function that is use=
d
> > for the specific SoC, sets the bridge active indicator variable, and
> > releases the spinlock.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 40 +++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 92887b394eb4..400854c893d8 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/reset.h>
> >  #include <linux/sizes.h>
> >  #include <linux/slab.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >
> > @@ -254,6 +255,7 @@ struct pcie_cfg_data {
> >       int (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >       int (*post_setup)(struct brcm_pcie *pcie);
> > +     bool has_err_report;
>
> It doesn't look worth it to me to add this.  It only avoids locking in
> a non-performance path.
>
> >  };
> >
> >  struct subdev_regulators {
> > @@ -299,6 +301,8 @@ struct brcm_pcie {
> >       struct subdev_regulators *sr;
> >       bool                    ep_wakeup_capable;
> >       const struct pcie_cfg_data      *cfg;
> > +     bool                    bridge_on;
> > +     spinlock_t              bridge_lock;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -306,6 +310,24 @@ static inline bool is_bmips(const struct brcm_pcie=
 *pcie)
> >       return pcie->cfg->soc_base =3D=3D BCM7435 || pcie->cfg->soc_base =
=3D=3D BCM7425;
> >  }
> >
> > +static inline int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie,=
 u32 val)
> > +{
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     if (pcie->cfg->has_err_report)
> > +             spin_lock_irqsave(&pcie->bridge_lock, flags);
> > +
> > +     ret =3D pcie->cfg->bridge_sw_init_set(pcie, val);
> > +     if (ret)
> > +             pcie->bridge_on =3D !val;
>
> AFAICT, .bridge_sw_init_set(1) asserts reset, .bridge_sw_init_set(0)
> deasserts reset, and it returns 0 for success, so I'm confused about
> this.  If either assert or deassert failed (ret !=3D 0), I guess we
> don't know the state of the bridge and can't assume it's active, so I
> would have expected something like:
>
>   ret =3D pcie->cfg->bridge_sw_init_set(pcie, val);
>   if (ret)
>     pcie->bridge_on =3D false;
>   else
>     pcie->bridge_on =3D !val;
Ack

>
> Tangent: the last "return ret" in brcm_pcie_bridge_sw_init_set_generic()
> should be "return 0" and drop the unnecessary initialization of "ret".
Ack
>
> And the code there would be vastly improved by using FIELD_PREP() or
> u32p_replace_bits() and getting rid of the shifting.
Ack

>
> > +     if (pcie->cfg->has_err_report)
> > +             spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * This is to convert the size of the inbound "BAR" region to the
> >   * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
> > @@ -1078,7 +1100,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       int memc, ret;
> >
> >       /* Reset the bridge */
> > -     ret =3D pcie->cfg->bridge_sw_init_set(pcie, 1);
> > +     ret =3D brcm_pcie_bridge_sw_init_set(pcie, 1);
> >       if (ret)
> >               return ret;
> >
> > @@ -1094,7 +1116,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       usleep_range(100, 200);
> >
> >       /* Take the bridge out of reset */
> > -     ret =3D pcie->cfg->bridge_sw_init_set(pcie, 0);
> > +     ret =3D brcm_pcie_bridge_sw_init_set(pcie, 0);
> >       if (ret)
> >               return ret;
> >
> > @@ -1545,7 +1567,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *p=
cie)
> >
> >       if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
> >               /* Shutdown PCIe bridge */
> > -             ret =3D pcie->cfg->bridge_sw_init_set(pcie, 1);
> > +             ret =3D brcm_pcie_bridge_sw_init_set(pcie, 1);
> >
> >       return ret;
> >  }
> > @@ -1633,7 +1655,9 @@ static int brcm_pcie_resume_noirq(struct device *=
dev)
> >               goto err_reset;
> >
> >       /* Take bridge out of reset so we can access the SERDES reg */
> > -     pcie->cfg->bridge_sw_init_set(pcie, 0);
> > +     ret =3D brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +     if (ret)
> > +             goto err_reset;
> >
> >       /* SERDES_IDDQ =3D 0 */
> >       tmp =3D readl(base + HARD_DEBUG(pcie));
> > @@ -1901,7 +1925,10 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >       if (ret)
> >               return dev_err_probe(&pdev->dev, ret, "could not enable c=
lock\n");
> >
> > -     pcie->cfg->bridge_sw_init_set(pcie, 0);
> > +     ret =3D brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "could not un-reset the bridge\n");
>
> "un-reset" doesn't mean anything to me.  Is this the same as "could
> not take the bridge out of reset"?  Or maybe "could not deassert
> bridge reset"?
Ack

Thanks,
Jim Quinlan
Broadcom STB/CM

>
> >       if (pcie->swinit_reset) {
> >               ret =3D reset_control_assert(pcie->swinit_reset);
> > @@ -1976,6 +2003,9 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >               return ret;
> >       }
> >
> > +     if (pcie->cfg->has_err_report)
> > +             spin_lock_init(&pcie->bridge_lock);
> > +
> >       return 0;
> >
> >  fail:
> > --
> > 2.34.1
> >

--0000000000006b7d8c063bca468d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB47OOV0a6P5KfBZyQARHO6Hb1Ic1sB
CtXnXRF2W0+h8zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4
MDcxODAzMzFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQBy0YTB2Gg6ynrSyjUP4abbwTBs+0MzSETb+W8OwlkBgUqRinLtWyGi1GF6B94KjxXj
Ke3v23ttYBeW8zh9fHbFYYYblpdhFBRljfJ6Zc2GI1QaifFDYmXVOtke+aQs56h/rlvG3QbmDQ/v
9F+gkEU8w9rJc5DEQPiaS1mnFCagaJ5OoD1fPQf8h33adJAmzVUsMHX311n5aRWxMFcIn9pi5Nhm
kLc6bJWVKNhXhaLFcGlCL1XM5pvsoOHzfEjSjFa7S5+prmdEDRziMQG/Zl3tRvGS8dof4EQdoSM6
0n1grxmjGOj2+XTaeuia2r7icN8uI5D8pwnIK77RqnUsdyTS
--0000000000006b7d8c063bca468d--

