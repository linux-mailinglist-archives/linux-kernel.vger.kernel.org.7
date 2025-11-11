Return-Path: <linux-kernel+bounces-894927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD7C4C765
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380EC1887420
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE442EBDC0;
	Tue, 11 Nov 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjSEX8+B"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D42561AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851060; cv=none; b=kQNJEN71fa/wjIlCG7mTpY5lvU97JzT7Ygxb2SiEcBqtSp8nsZdk+c8I1eEyHvIa/Tyd9a935OHwyzeS+/uGRVxG9csY3pwFVg9iBpA+KAODtlHZowXWpRQyktLKccpg2cuYcde9v89fFgAPsaB4g67bLRHEethns6u3wjaQPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851060; c=relaxed/simple;
	bh=0YRsrI6lk/jpE/TQxXFHe1uone6HcJRymeuTM22KPDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRzxh5t/Vq2l+bJkrguM8lPW0HLuxX75JxqojuazTIeT0BIhObD4/HuD21Jnvcc/3fjKxCIWCNzvDZHX4HCNDT8lZTdH6ia7I1ZVc90DhZXuAPG/RZfo5uxsIfIjfE0leqq4ujtF9piYYueXR0lAKX7Zbf6CGzXNUtrIs+qlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjSEX8+B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1952105f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762851057; x=1763455857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AFOtj9BBWikbvrk76I+BOfuLhZBC12T4UuFnubfgtU=;
        b=VjSEX8+Bau2Yqc5otfkaZpmWy+ce/jsNVbJnZj6sY4wpQ/xq83Q5Iu3wDuoUGxbCWX
         rHKBgVT08CtErkBqV+fIvf4d/JYvj3pDyAbltVr+STZ/HgWF6u4LTHx9yfg+HXE2ig+x
         c+fTJA3eFrZpUgphQWqa6o3FwpKKMlGmwKliaKi15QzlC7jiitUSXwRy13x5druPLLrs
         nGlBETdxjtdcBUUrxewtKAFdignBI+oz2B00rBTSpJ1kV4WSIDPWCbYl5ZfpDLYrFvVw
         NgEJ6HfeAEF9kiTAkYuYkSwsK19FogYlgdbNMVyV/Z34ZQRyiOCsl1KTRHmsovFi7mT1
         vFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851057; x=1763455857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AFOtj9BBWikbvrk76I+BOfuLhZBC12T4UuFnubfgtU=;
        b=o+tUJ3BeXtTzkIuff8JhsT8gADtniEuIRYlAku+lWbX/cIV3HxC566ccBbukEOndBx
         ZERIPke5RtLTcsLV+ej/EBGx1MWnAYiEmuBCoklOodi/bqjeLSIqo1RNCZdHIK1e0rW/
         2FcCap8ngzqW7kckTxycMuBftjyRt/lCLaxBZSP9HeL07IZriSTIaqW/TWW/jTvScldG
         2+PIOqUaXmtvFSm47THkwqdJ1v3UquYsCVg+RcoOgLItUM3NjtNWCGCJGz+s/qn6SuZ0
         aEwKX3y/g7pn6tbG+nJJvWsDHmGMGWEMJXxr5Udq9tJysbD5+bWkDIyBH/gVgbMDme8x
         ZD/A==
X-Forwarded-Encrypted: i=1; AJvYcCW98Tq6taOdLsaG50dV3zQ1gvYAr+SPzOw7AvscKR02YVr8u2/Xd2YYCRmtucd0UZ1DKqpU/OwQUgRAZuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFsHF4r1ACy7pIaaIfYcP9nY+nU0+hY5YpCE4P7zmj/iiU32d
	LekcN/LkqJtdqYSf5PBQ0+fA3I/0g8nzpX6O9RyB8KfQ7/e+yHjIPaidhLS11v/3QQ/4cVdz8Ln
	L+ZYri35VEDIfGeHvTxlNuR6B+nHqPQA=
X-Gm-Gg: ASbGnctaN65xDWAUadLIa+15MFK+ptpX493ObQt57eVbNULJRwcfJtlvClk9/V0ZHdB
	29QVAgDAOAdLa3k6YridwKj13FmuR4Z8zqqvOphAjHfYjxhqP0Y1HvcLqeGiQfneQq+xAisw5L8
	ox/vyyvRROLQD8LcAqD7zNDqHEU5nt5Gzwh/LR9NbRZPFg99jQa3gxVcDZNd+hfGrhKNeH54Qs0
	qqVe2LaJT2r4LBhOSpSNNhTyzj2BO/fneZrHujxsjf0xgNfA7BfB200YdQbBA==
X-Google-Smtp-Source: AGHT+IE+da+1r+jgi0DXyIDNB8MGdp+Nzp4Lqz4ylhf8uYWKyvAt57QPmxdapcBrV4Tm8KD8ARq3BHLCSjO12/WC1Hc=
X-Received: by 2002:adf:9d83:0:b0:42b:3083:55a2 with SMTP id
 ffacd0b85a97d-42b308356e2mr6996138f8f.63.1762851057106; Tue, 11 Nov 2025
 00:50:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251107201232.282152-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <ec28d950-f7ef-4708-88aa-58c2b9b0b92a@lunn.ch>
In-Reply-To: <ec28d950-f7ef-4708-88aa-58c2b9b0b92a@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 08:50:31 +0000
X-Gm-Features: AWmQ_blqCCNNMwhN5TO78-IZrSmoQkRYNb4dIksXog2xpI2Up-_qLjDEx3kShQY
Message-ID: <CA+V-a8uLC5OJ7g1MbJVcJeCS9wPVYDoCDUW7i8keUftQLkmmLg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you for the review.


On Tue, Nov 11, 2025 at 2:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> diff(1) has not made this easy...
>
I agree, --diff-algorithm=3Dpatience option for format-patch gives a
better result. I'll send a v3 with this option.

> > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > +                             const struct vsc85xx_probe_config *cfg,
> > +                             const u32 *default_led_mode)
> > +     int ret;
>
> > +     /* Check rate magic if needed (only for non-package PHYs) */
> > +     if (cfg->check_rate_magic) {
> > +             ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> >
> >       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP=
_KERNEL);
> >       if (!vsc8531)
> >               return -ENOMEM;
>
> > +     /* Store rate magic if it was checked */
> > +     if (cfg->check_rate_magic)
> > +             vsc8531->rate_magic =3D ret;
>
>
> I think we end up with something like the above?
>
> I would move the vsc85xx_edge_rate_magic_get() after kzalloc() just to
> keep it all together.
>
Ok, I will group that under single if.

Cheers,
Prabhakar

