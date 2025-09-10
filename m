Return-Path: <linux-kernel+bounces-809269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE5B50AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7011C3AB934
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3F2367C1;
	Wed, 10 Sep 2025 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="iBR5npDu"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD52356C6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470351; cv=none; b=JdpeCwpq9eZFu0ZwQEcbTOUOHPmyW0l/VVy0LQaMNYRf97wxKYvbRh7bt0aTo0Yb0IF7oKsXJqfI+yM7CprQ3WI69Kupp9WjyIr/nT14rY8LNG457RZu5A6j6fH09jA/WMt7zsR8KsKrXsUEJk78jwNeXs30H9TivJtoeGXu3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470351; c=relaxed/simple;
	bh=i/ZrTEb1zaDJxW36CE3QTF6qXM0oKKYNei/9YnXXPso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kllifz67jf0xJXI6CPUuAggedI2SxNWMncqdduGiDRDup8HYnnfqSdCAiNC8MVLOeHjt4n5bgnQ+7xwZtSOzmbMt4DeIfJRs8dYztYcvOEj7RvqMCX0L0APZ62aUVWuEtJ6JJUHmlrsELCM8SYBf6XveutMhGnCRRamwEe1eztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=iBR5npDu; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-62190d14a96so1094205eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1757470349; x=1758075149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/ZrTEb1zaDJxW36CE3QTF6qXM0oKKYNei/9YnXXPso=;
        b=iBR5npDubxUgiKe+sGUNbhfwKTlOrDkxy4a1g5c3tY7EQkpMv9O9iWqVVBEScaDVze
         jH16y4FFQ4LgWfql5K+chfKZbajPwqNF0U3jMRbJb3TVuFE+UgFgMN8JVcuHLIx43pV2
         c1Bkg4ga9Vz1ee/JW2i8aky3zseLOvTbLk5GaPncA9FhykpOZMMQ1fSGDg7G9eUkKdMj
         mH3opWo7W6+hKIo45qmbWMqqmiy52nHT1qZPBZ10oW1GwLmvKTqoSlHxfAz/ttTsALVn
         QqbjkkJf9JOnVCP0mFyPIrFNhod7VEKf2sMoRmzlAzRyhAXWnfZMcCJn/GBLhdBOkkgc
         ZybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470349; x=1758075149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/ZrTEb1zaDJxW36CE3QTF6qXM0oKKYNei/9YnXXPso=;
        b=jFOhRrDfpRmRKwlEN+v1vs+llxfQmbD/fT32/zQQbBWtJimukPTzUEJCgfJI33E2x7
         zt7NOveAh6mVnB4hMplvau/XTDVczB95gRngceQaSCn10iavHHpx57Z0IRkMdZkv4QKS
         Ri+7ds4y6aLAl7N0NNqSdcbKWTblZJtJtc0CbXxaymUBXMwsAwoAiHLt82vvzWhz3acR
         9nSEPeVqmNCzGXR5n4k/9wIV6Tf0kwxXaTl+WIq6FARiUsxee92Lmh6UYuG4UJC3yIpQ
         IxDWbaBCcfPtI5PKLgXmiKHZIKJqeWH8U1eFd2epmslpNPAu0i7F25LfLZLxBd1H+0Ug
         RDdw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkViprfxlRvIFyjVXBtZYo829tE/LQ+zb0h6LXlRxkuEmd0/iIWojSPukeI+lLy6pl86LYabkuafDXg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1Ki8wqV2MDfoFCPXzr0+nw6R5i37C1mAJ6c8uSZG7CzDBBSS
	PCLCGxFGzYNdwEMhtB4NvJ09pDwLEEZM/aEZ9W+7vE2kJLh7z4KnEmB1M3SQdsnXArAaAH8VFj6
	oYNtmi3EFChS8L3M53R/PkDwonm8RzeQhSbbxpMxrIg0yeQcpVb/p
X-Gm-Gg: ASbGnctWD4RHlYva8hEdtSOSvhRuriKafilExqUMIoU7rypEGO0kSfO6F9jkcn45Ik3
	Qjxrm09aJnKhm8W8+TVQV8rinFbDqZxgPO3/U9d8LcDw7T9oC2t7/Ha4z3LMdTRReWYmQUm8FY8
	RSBjcHzTFP8Y4DQ7osOFJn2MW3fnWznDcySY/BsLvlR4gt8fWftOJs1KD3KsTiE3fdA0TCD/tBm
	ejHQSg=
X-Google-Smtp-Source: AGHT+IGYzcv+KGeo8D/B/3mzm8u727rEyHjHkqpXMnOV+fGyUvGB1T/ymTmP3km0I0jXSqieUCPPm6rwERicf/XL/fc=
X-Received: by 2002:a05:6820:624:b0:621:72dc:3dee with SMTP id
 006d021491bc7-62178987debmr5886756eaf.0.1757470349286; Tue, 09 Sep 2025
 19:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com> <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
 <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com> <20250909043327.GD20475@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250909043327.GD20475@nxa18884-linux.ap.freescale.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 9 Sep 2025 19:12:18 -0700
X-Gm-Features: Ac12FXzv-yx0rHpHYzRFsf11y5WuQG_up-EtuFq-TzQXC2JvCVAePG_zRuL6PxU
Message-ID: <CAJ+vNU3=mwZFBqQRNz4i28EjWXX6=Nf7iAsYPEBgpqkQw4wgtA@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for netc
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:22=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wrot=
e:
>
> Hi Tim,
>
> On Mon, Sep 08, 2025 at 04:43:25PM -0700, Tim Harvey wrote:
> >On Fri, Aug 15, 2025 at 4:50=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrot=
e:
> >>
> >> Add phy supply for netc emdio on board.
> >>
> >>
> >
> >Hi Peng,
> >
> >I'm not sure where you are with regards to this patch but it indicates
> >to me that you may have the enetc_port2 10G port with the AQR113 PHY
> >working on the imx95-19x19-evk with upstream Linux. If so I would be
> >interested in knowing what other patches you have for that. I'm seeing
> >the interface fail to register with:
> >nxp_enetc4 0002:00:10.0 eth2: PHY has no common interfaces
> >
> >I'm wondering if there is some support missing from enetc or the
> >aquantia phy required to work with 10gbase-r.
>
> Thanks for raising this.
>
> This is just to add the missing pieces of device tree.
>

Hi Peng,

Ok, but phy-supply is not currently valid for netc_emdio

> For 10g port, it is still not ready for upstream.
>

For 10G it looks like at least the XPCS support is missing. Do you
know if anyone at NXP is working on this or if and when it is
scheduled?

Best Regards,

Tim


> For 10g port, it is still not ready for upstream.
>
> You could only use the rgmii-id port. This change itself does not break
> the rgmii-id port.
>
> Thanks,
> Peng
>
> >
> >Best Regards,
> >
> >Tim

