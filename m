Return-Path: <linux-kernel+bounces-890919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D4C41635
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9AF189A0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAFE2D6638;
	Fri,  7 Nov 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBOoZTIl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5623FBA7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542485; cv=none; b=DhfZ4T6H+9xas8U7ii++Ct2YC1Fnm5sRbdHhMGW17ZYdvf3dIg1p7KAhnD8I97u7cpvSux9vSzQJRXyHyGC5CQ+mxTvOnyTpkNTUNRPU0iOoAp2AXCKWXpBVypsumpYcH4Lr9XGr3mUqf25/Tmm7zfzBlti/SGfoZx5jV5vBVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542485; c=relaxed/simple;
	bh=MuBZP8MilDi4Gj2oBSNAsYRQG+qSraPH+CQlzY8+SX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExFzdTWXz39XIeHLl+oXBFKZbMpFadLBADGJkDKrxlMK3X6blorivN0j/aqbMwA5CRNaWH2673LIfBgnU4aAuzpv+zx+zO54pIACCH5EXfQWjkz8sM37YRSjK6Xmtk10xReDOh1IZ6fwcxysPu9AdDdTBFirmKpNPH/cxpd9pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBOoZTIl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso802544f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762542482; x=1763147282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98zvSpFCtfYwCinbIUvtgjWS4ALtY9Ez5M7RcM4hjuI=;
        b=KBOoZTIlt0sBXlcrgIFcBW3T/mCeiIHTuomyYB9F66PALpzgNoSilVBG7HHnkyDbNi
         w/n9ow+WBQFNV/lqJEgfqVM1uFSvkFLD5V2KWN4b7Cm/ah0IMmsCxboeEk1V/T1/uP7I
         O98+4ZjWnjkB7ky9mXO9E4YLaGpP6e79IShrYplD/UDnu9nsdZ3hXEEh3/cqhTMxBQXw
         zobx96IImIypPTH94H0hG4QCwxngxNw4XJ7BNTG2LyCYvZES17l4yNtgFLEymFXQiyer
         hXZlurfClMkqixTaU0T4wKrFlkQXteeMWB0kiIZlDgLQ/UwBiqBUAQeA1VNmUtrNJaC3
         p8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542482; x=1763147282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98zvSpFCtfYwCinbIUvtgjWS4ALtY9Ez5M7RcM4hjuI=;
        b=oRhYZdmTTWw3aWM9PHYLRK60b8pzbz3hHJ64S+el2AZ1es8wdTuozDNg8cPa4042zr
         Wk/wsnOAC1C9vGapQfDaaAMsNPTi11SMziIXWojIHMBJh8+BJIGW45xYhzB0m5vQRKbw
         tOM6PSa4J8uDpVsyauVJYwv6neMKAbOr+tKKZWkVEGsqwJOLyOZYGpLo1hWoX2NSKCVz
         ahdVaIJy5ktbdoJaauzeJOVw2eipCcK0fQSzQito5u/AXW2N6OePQ3HC57EOl8chhf2V
         s9XUIvChtg0D5yzQrZ0CsEV6oM0HtwhERiakbFstz8mJanNcAEIY+ndaWGD4wQckYdPU
         qg0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUlxoc1O00YagZg019/AqhWcanLJfqWGG7fN7O5UmlOIJ/PZm6Fy59f8iFb5KNBFq+noEQ8d5M3wv044g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45sHb7kOJH5XyemWrLiiQc6IfmRple9E08b7vTy2dPpHaKUAS
	AHvX+7g4M4crKUYmU+Hy+NGQAcJuyzRlRtwDeR5avzOpcO4W4O4urPeHx17TI8nC6nZN9FblPu5
	+P91IEtrXiMqAUgd/BL3RvbhurApwHq4=
X-Gm-Gg: ASbGnctArHWoxiLsAeRnMa4xB5WVXu0cv1nanEHlPopPTmyf8tUCGMasEB21sjV7Zhl
	/m3iU2R7tbuphuQmH/5bJZSSeeADYexa4c17PgEaDROsN4lqe8VOYa8SuinErkJA42NXdu5VdyU
	AWothQTONcj1rWo9J0vArKEzoIaXQs24KqVr/fe0Q6JtJzXXmqtXhxBvpwlAoNaUtrb/qvuHjRM
	14uHIll+Lsnay6rBhimS0gt/gum9aIPRnLfWdSOOaV1QbYHaZCYGrzUd548Mp0u4nbeg2A=
X-Google-Smtp-Source: AGHT+IGeu/C5nKxUEoqKP5CHhmYruwz+Zclh/0ohVNpebUeE+OB52cvd+J6tlYQsRrJkRSHRmix1kjqDzuIObLwa6pU=
X-Received: by 2002:a5d:598b:0:b0:429:ca7f:8d5b with SMTP id
 ffacd0b85a97d-42b2c6722a4mr481943f8f.14.1762542481691; Fri, 07 Nov 2025
 11:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106200309.1096131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ee6a79ae-4857-44e4-b8e9-29cdd80d828f@lunn.ch> <CA+V-a8vFEHr+3yR7=JAki3YDe==dAUv3m4PrD-nWhVg8hXgJcQ@mail.gmail.com>
 <2dabb0d5-f28f-4fdc-abeb-54119ab1f2cf@lunn.ch> <CA+V-a8uk-9pUrpXF3GDjwuDJBxpASpW8g5pHNBkd44JhF8AEew@mail.gmail.com>
 <caef6e6e-b81e-45d7-ac92-ed6adc652aa2@lunn.ch>
In-Reply-To: <caef6e6e-b81e-45d7-ac92-ed6adc652aa2@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 7 Nov 2025 19:07:34 +0000
X-Gm-Features: AWmQ_bk5YqHCcSmLZVSPz9ezwcQ4t-xeg_QDOZGrptN0Qnu8s-fuKHyuOslw6UI
Message-ID: <CA+V-a8vj7d1wsTVYMrh2KpAoOjvF+1-WPNijsOLQ--DwPQG-og@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: mscc: Add support for PHY LEDs on VSC8541
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

On Fri, Nov 7, 2025 at 7:01=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Certainly the probes can be simplified into a single function. I'll
> > create a patch for this.
>
> Please do make sure of each device having its own .probe
> pointer. Don't have one probe function with lots of if/else
> clauses. Put what is device specific into a device specific probe, and
> what is common into helpers.
>
I was thinking of having a cfg struct  for common probe, something
like below and each phy would populate its config and pass it to
vsc85xx_probe_common().

struct vsc85xx_probe_config {
    const struct vsc85xx_hw_stat *hw_stats;
    u8 nleds;
    u16 supp_led_modes;
    size_t nstats;
    bool use_package;
    size_t shared_size;
    bool has_ptp;
    bool check_rate_magic;
};

static int vsc85xx_probe_common(struct phy_device *phydev,
                const struct vsc85xx_probe_config *cfg,
                const u32 *default_led_mode)
{
    struct vsc8531_private *vsc8531;
    int ret;

    /* Check rate magic if needed (only for non-package PHYs) */
    if (cfg->check_rate_magic) {
        ret =3D vsc85xx_edge_rate_magic_get(phydev);
        if (ret < 0)
            return ret;
    }

    vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNE=
L);
    if (!vsc8531)
        return -ENOMEM;

    phydev->priv =3D vsc8531;

    /* Store rate magic if it was checked */
    if (cfg->check_rate_magic)
        vsc8531->rate_magic =3D ret;

    /* Set up package if needed */
    if (cfg->use_package) {
        vsc8584_get_base_addr(phydev);
        devm_phy_package_join(&phydev->mdio.dev, phydev,
                      vsc8531->base_addr, cfg->shared_size);
    }

    /* Configure LED settings */
    vsc8531->nleds =3D cfg->nleds;
    vsc8531->supp_led_modes =3D cfg->supp_led_modes;

    /* Configure hardware stats */
    vsc8531->hw_stats =3D cfg->hw_stats;
    vsc8531->nstats =3D cfg->nstats;
    vsc8531->stats =3D devm_kcalloc(&phydev->mdio.dev, vsc8531->nstats,
                      sizeof(u64), GFP_KERNEL);
    if (!vsc8531->stats)
        return -ENOMEM;

    /* PTP setup for VSC8584 */
    if (cfg->has_ptp) {
        if (phy_package_probe_once(phydev)) {
            ret =3D vsc8584_ptp_probe_once(phydev);
            if (ret)
                return ret;
        }

        ret =3D vsc8584_ptp_probe(phydev);
        if (ret)
            return ret;
    }

    /* Parse LED modes from device tree */
    return vsc85xx_dt_led_modes_get(phydev, default_led_mode);
}

> > > Also, is the LED handling you are adding here specific to the 8541? I=
f
> > > you look at the datasheets for the other devices, are any the same?
> > >
> > Looking at the below datasheets the LED handlings seem to be the same.
>
> That is common. So yes, please add it to them all. It does not matter
> if you can only test one device.
>
Ok, thanks.

Cheers,
Prabhakar

