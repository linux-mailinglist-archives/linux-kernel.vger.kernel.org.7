Return-Path: <linux-kernel+bounces-862533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0072EBF58C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91904EEAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B472EA729;
	Tue, 21 Oct 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDn0G5Am"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9317D07D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039526; cv=none; b=iR92cymSzeY7PdXABJFMyq2wAIUG8qx7oEUw0/gML1Wqy2HvuW94Zl5XJ1p38cB+XTxG+ByK58648XojlG3fFL+8CWhTTnhJYZ/vURZNpkysA6KBHHY15aLnZkjxC1BNkP5vt54KADgMA/PiExfngvoDi1zrMe94AOw2rfiVG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039526; c=relaxed/simple;
	bh=1jhsxDcrPTMn33f/fW0m2ck1tM2NNjIPKUg0Wc5mgUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXRBN5timpaW0JUDx7dn3F7sFxV8Uh9uApAqNz2ac4Ja/0lXxtaPY9IaDWqFJVCeEGVTHz941pkxm/shL33gzuIgJD0Z5uowfJ1g6xvAdHcIxgfaiFHVXJsBhhjsrQ/yqn9FiA1RJCioQYU67eDEn3M6AwNhg8nG+OxKkdKopKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDn0G5Am; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d71bcab69so52344867b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761039523; x=1761644323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1eeVQ9VeQ+8eDNx7wVtovhJZK8MyMI+d0uyJgtez2M=;
        b=bDn0G5AmodAsFCIPLJOzOUAm8duN7xSajTOAiZG9ToeUmZS32BBx8P9J3kd60qvj5H
         rflAmsfZVNlySGQ3VZQ10AU8GjpNdstpNkXoe+prXndYi/mxSwyIi6oUmQ5dzO2zkb1j
         7Bi2wFf5xkgMhsVQw+vsa8v/b+9wyAv/pfBrNrFmKTHZB8h6wc2zocizQrBhIQkw0ZdB
         S8KqEItn6tH7rGY2h4DTJqwe0Wk3CaFfay5ZR4IIb6fPMy7ZYwVyXdwqU/K4td2fJugF
         XunM+FpJZ6HSVzZfAzTL01YbgD2hrmoGnCZu0d+ENc0JNu4bk9JBfLOUsZyWZrDbXJJy
         gwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039523; x=1761644323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1eeVQ9VeQ+8eDNx7wVtovhJZK8MyMI+d0uyJgtez2M=;
        b=d1LbKAsoEr2wVcDOK1YmQz6k4dLR4Q/u9IJ4BawQ8rkLpDfj+Orxi9AkKupOsHNrT8
         2RweGQkgJ89GMryt4H2K0X9g10uso/BozfirQI95CWEFauexA/KB0KIE1O5Aa0vnPjRA
         5IWm2krb9CyyL/S8Sn1pyjRwqbF6d5i0VrRfpYU/WF5D67rAd+ml7aqhEXuALaYI3cm1
         i6jDhysedREYlFPK0PqeYLL+GhNN/H7ViHdQddXvmqIPd7Y2BLE5EkPNInmlbWAOAqYx
         Wytx+IY0+tA447LtPBS25FRVoNNoAlr2ZXXfvTYRqlEavD/pNByLjaZ6e1XneDEPzqRg
         tGnA==
X-Forwarded-Encrypted: i=1; AJvYcCV8h0aLbzUd9THB13ff2FVglDF0iF2WoWXdRccTSGycABgIDjdUdiHjUtsVmQ16OoH7fjwsmmitv+NxKpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9HEERAkmxzurTHHzO1SZc5A/ndU7rGOnq/z4Wmu/N8x0NyNd
	a/PqTCPGzxHNFk4/U0FKPkMGfbUjUv2/PaAsEw/9O4gzxN/B/Ep/2opdM4FjoWbqS2wHuuReMAO
	tf8zWvCNz6n5f34BOXFKHVSoHAb/yYHY=
X-Gm-Gg: ASbGncuyeXk9kMGAWWg7b7gEeGXKrENI8Xm35t/tTIq+l8WtzZLKKK9gHAQb57IUCWE
	POltX3Ju+93J1F18g5bUDt8UXKiTbITx9cfGwOvq0E1T00WAHowDJPuxNi0rJ6Ad4kLm2M5jPS4
	o3lx16vpdZFWWrs9VB2mzdiwsoV6/SRIIwBqZ64WsCnfPt1JNBDEoa8H1ApCMbABz5/alxTSWi0
	gupLR3uxvg5q+KQaBhW/uxjzL8mziJGRL+DkK3oBJQWVWA9Up0zkPQq2ONijVYLfFuJlw==
X-Google-Smtp-Source: AGHT+IFz8xZwydVmNj/TCSyMRnVEbcbJWu9Ym6Id+aYRdcCUbHyds3ytSGmbdU0cQBCvOCLLDzUcDsEaxAdV8+G4B18=
X-Received: by 2002:a05:690e:1406:b0:63e:4927:72ff with SMTP id
 956f58d0204a3-63e492777b9mr2222613d50.17.1761039522747; Tue, 21 Oct 2025
 02:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
 <aO_H6187Oahh24IX@horms.kernel.org> <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>
 <aO_PMWQlv0DhHukm@horms.kernel.org>
In-Reply-To: <aO_PMWQlv0DhHukm@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 21 Oct 2025 11:38:31 +0200
X-Gm-Features: AS18NWAt-sNEZKvoBVjhcEcyf8gYc14VQDS_M46xD0Xr09bsTyEc-j3O-PJtf70
Message-ID: <CAOiHx=mbd-JND4XR9FkARa0b6gGS0BXJwuAKSP_gVO48m00ZWg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Oct 15, 2025 at 06:24:33PM +0200, Jonas Gorski wrote:
> > On Wed, Oct 15, 2025 at 6:12=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> > > > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q=
 VLAN
> > > > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > > > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configur=
e
> > > > VLANs while not filtering").
> > > >
> > > > This is fine for VLAN aware bridges, but for standalone ports and v=
lan
> > > > unaware bridges this means all packets are tagged with the default =
VID,
> > > > which is 0.
> > > >
> > > > While the kernel will treat that like untagged, this can break user=
space
> > > > applications processing raw packets, expecting untagged traffic, li=
ke
> > > > STP daemons.
> > > >
> > > > This also breaks several bridge tests, where the tcpdump output the=
n
> > > > does not match the expected output anymore.
> > > >
> > > > Since 0 isn't a valid VID, just strip out the VLAN tag if we encoun=
ter
> > > > it, unless the priority field is set, since that would be a valid t=
ag
> > > > again.
> > > >
> > > > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy ta=
gs")
> > > > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > >
> > > ...
> > >
> > > > @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct=
 sk_buff *skb,
> > > >       if (!skb->dev)
> > > >               return NULL;
> > > >
> > > > -     /* VLAN tag is added by BCM63xx internal switch */
> > > > -     if (netdev_uses_dsa(skb->dev))
> > > > +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN=
 tag on
> > > > +      * egress to the CPU port for all packets, regardless of the =
untag bit
> > > > +      * in the VLAN table.  VID 0 is used for untagged traffic on =
unbridged
> > > > +      * ports and vlan unaware bridges. If we encounter a VID 0 ta=
gged
> > > > +      * packet, we know it is supposed to be untagged, so strip th=
e VLAN
> > > > +      * tag as well in that case.
> > >
> > > Maybe it isn't important, but here it is a TCI 0 that is being checke=
d:
> > > VID 0, PCP 0, and DEI 0.
> >
> > Right, that is intentional (I tried to convey it in the commit
> > message, though should probably also extend it here).
>
> Thanks, I see that more clearly now.
>
> > If any of the fields is non-zero, then the tag is meaningful, and we
> > don't want to strip it (e.g. 802.1p tagged packets).
>
> I guess there are already a lot of words there. But, FWIIW, I would lean
> to wards tightening up the comment a bit.

While I can't send patches, I can at least send emails at work:

How about:

"The internal switch in BCM63XX SoCs ignores the CPU port's egress
untag bit. We use VID 0 internally for untagged traffic, so it becomes
tagged with VID 0. Fix this up by removing the tag if the TCI field is
all 0, and keep it otherwise."

Best regards,
Jonas

