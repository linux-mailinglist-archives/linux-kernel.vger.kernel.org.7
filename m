Return-Path: <linux-kernel+bounces-856130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B3BE32F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A833E3E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF42741AB;
	Thu, 16 Oct 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDEAvMnN"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E51306495
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615469; cv=none; b=bxVEr7VR1C6ELAVOU+TnL3OY5fvU4LdG16qoPW6KjH+PKfxcW9Dp4rJDQKehhVAzOBujobYRYG8AU5VS/GHPtwQ2RGIOKkLPEtdBZFoESc9VSzw5Z+8+pYDsjbkIo/tTPVF+Ja9+VEFv+JuYqqeTqUhVPexvhndnWZKnoyHkr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615469; c=relaxed/simple;
	bh=UjFDUFfWb4BrE0aBrcl3Q23mAE8x8QbHtFnNsR7vchM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx9ABHLNKXh5P6byWjvboovBDyo8mGvj5sdTajApTTC2ayxRq2Y46Z3qOyIAQYAJN4/m9iRHF8LkheSbCHG608Oph3KPAHjExCKbossiakUxjkBfTyXLq0MDS1AZjwRzgtBxPJYIR6Ky3opy/ioW7wehqIrJD2xaIS3P7lvsm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDEAvMnN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-73b4e3d0756so7782897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760615466; x=1761220266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=451OX9zUvEcr1dtyG1h5x4Z6TDG2E6icMA9NKx9eWIQ=;
        b=aDEAvMnNeTMOqNf0bNe7lKpNaoAQRKWQFewulXa8yTj2Zre6Q9eQS3HnRFMLFTXb+D
         bXdbEjeGtkrvVYGhesm+SJVXUvTddXepn4HkqKHlvgwbBs1UdW2pOPrZEyrh4CE5ZUSW
         lkAduS/ESpw7om5gJGjgX1YLcOJmydkxOih06B2A102ZetnDOUjIGbHxNIRD5w7+D3n+
         N+iGINhT1diJEekdrsiMWIxOGFT8rMJZ6/G71a0QZG11UFEASQkeYP6NRMQnyEVQsPYJ
         LAU4/lA+xSFjOhoMFJ31Hba/PB6XND77eWCi/G+uAfzlaXubVYupl96P/4lTg6/PZTLw
         ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615466; x=1761220266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=451OX9zUvEcr1dtyG1h5x4Z6TDG2E6icMA9NKx9eWIQ=;
        b=QTehFmscRGHupCs6F1RTeIWp8xcaDYiPwi5LvEHQAPBWsEjvxMZO1keVZm5uhStFXh
         8OzT5x5vFvZ+rxhrDXbyMV3dy8d855orEfreXtQQ+IWLjjJXW7YIQlD4tquxaHOkKrlz
         w1yfEuMJZ5xBJydplEeQXnjYV8fREPw0+jovmVTtu+s62bHmPrWGxNzEGjzkUwXymO09
         5wwcQAArOG7gpSuk5rIn0ljvA7RR+UWcs7UnrtT9zqtqLRLmhTWPKRUzCnF2y88IHCIq
         J5fxvPHcIrz0IFs9ZvHtMVjeww5DiaKEnPXUk8zQnhRya7qfWK0oFLhh4BsSJtQoe2Cz
         mfoA==
X-Forwarded-Encrypted: i=1; AJvYcCWH50z1hgRUDrSr+C7kX5iyRLMnl+srRY2D8Q69RWC/SADfFnKvqkrszZBv19O0BuAeXYHP6JP8GN4wS/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIhmQt8Lp1vxDo3DHV5Yxhsx+VDxjZoCgbsDIizUgxSOmyNl9
	dtk/zvPhs4pdFLaj+voTQve4yZjNKL07SXuRcQNtz+TruqVq+C8V4MwXqiueZDEqOhOsXOi+Imy
	K4fOP8zt2//A8eeST4dImcK7gXMN2c0Y=
X-Gm-Gg: ASbGncs2t+31tZOYUD8UqTrHqFTRV09fm1ekrSpU53XNn8mgYC1NknpbXwdLwZhHEZz
	LewvHs2+Bxrfp9bt8ezfZGskQsyJWxrHyEoql+VeVfOw+tKd6cThrnt8R83ptKghl5AksG73Y95
	ZDec2BhLLiGLr7nJ1T4tOuVLQqgMxBUgIzJtO1UK5FkKEufpY4eD1f7B7YPgCK9jcxtnaKJjntf
	HhTcD08eAyn8yr0Xr7TNpjRsluooJuaG7n0IZ7KzQ/fLoWujMi1WA2rt0ba6qCQjrJtNw==
X-Google-Smtp-Source: AGHT+IEUwONjtEC+hcIJYf+zFQwFN81n7z2SFpqHPiAjBQYf37yvJAU9HF/KSPelQRrKYLSi1CCQ0bc7t460g+hETVo=
X-Received: by 2002:a53:da04:0:b0:63a:f5:84f2 with SMTP id 956f58d0204a3-63ccb8920f6mr20874644d50.16.1760615465500;
 Thu, 16 Oct 2025 04:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com> <20251016102725.x5gqyehuyu44ejj3@skbuf>
In-Reply-To: <20251016102725.x5gqyehuyu44ejj3@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 16 Oct 2025 13:50:53 +0200
X-Gm-Features: AS18NWD9uFhGMHriuQEAn7Ro6IFrI8lnEOt7F-wVmLcPJEb4m3xNuSqdYRXgSio
Message-ID: <CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 16, 2025 at 12:27=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> Hi Jonas,
>
> On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLA=
N
> > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> > VLANs while not filtering").
> >
> > This is fine for VLAN aware bridges, but for standalone ports and vlan
> > unaware bridges this means all packets are tagged with the default VID,
> > which is 0.
> >
> > While the kernel will treat that like untagged, this can break userspac=
e
> > applications processing raw packets, expecting untagged traffic, like
> > STP daemons.
> >
> > This also breaks several bridge tests, where the tcpdump output then
> > does not match the expected output anymore.
> >
> > Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> > it, unless the priority field is set, since that would be a valid tag
> > again.
> >
> > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  net/dsa/tag_brcm.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
> > index 26bb657ceac3..32879d1b908b 100644
> > --- a/net/dsa/tag_brcm.c
> > +++ b/net/dsa/tag_brcm.c
> > @@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk=
_buff *skb,
> >  {
> >       int len =3D BRCM_LEG_TAG_LEN;
> >       int source_port;
> > +     __be16 *proto;
> >       u8 *brcm_tag;
> >
> >       if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
> >               return NULL;
> >
> >       brcm_tag =3D dsa_etype_header_pos_rx(skb);
> > +     proto =3D (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
> >
> >       source_port =3D brcm_tag[5] & BRCM_LEG_PORT_ID;
> >
> > @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_=
buff *skb,
> >       if (!skb->dev)
> >               return NULL;
> >
> > -     /* VLAN tag is added by BCM63xx internal switch */
> > -     if (netdev_uses_dsa(skb->dev))
> > +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag=
 on
> > +      * egress to the CPU port for all packets, regardless of the unta=
g bit
> > +      * in the VLAN table.  VID 0 is used for untagged traffic on unbr=
idged
> > +      * ports and vlan unaware bridges. If we encounter a VID 0 tagged
> > +      * packet, we know it is supposed to be untagged, so strip the VL=
AN
> > +      * tag as well in that case.
> > +      */
> > +     if (proto[0] =3D=3D htons(ETH_P_8021Q) && proto[1] =3D=3D 0)
> >               len +=3D VLAN_HLEN;
> >
> >       /* Remove Broadcom tag and update checksum */
> >
> > base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
> > --
> > 2.43.0
> >
>
> Do I understand correctly the following:
>
> - b53_default_pvid() returns 0 for this switch
> - dsa_software_untag_vlan_unaware_bridge() does not remove it, because,
>   as the FIXME says, 0 is not the PVID of the VLAN-unaware bridge (and
>   even if it were, the same problem exists for standalone ports and is
>   not tackled by that logic)?

In general yes. And it happens to work for vlan aware bridges because
br_get_pvid() returns 0 if a port has no PVID configured.

Also b53 doesn't set untag_bridge_pvid except in very weird edge
cases, so dsa_software_untag_vlan_unaware_bridge() isn't even called
;-)

> I'm trying to gauge the responsibility split between taggers and
> dsa_software_vlan_untag(). We could consider implementing the missing
> bits in that function and letting the generic untagging logic do it.

If there are more devices that need this, it might make sense. Not
sure if this has any negative performance impact compared to directly
stripping it along the proprietary tag.

And to sidetrack the discussion a bit, I wonder if calling
__vlan_hwaccel_clear_tag() in
dsa_software_untag_vlan_(un)aware_bridge() without checking the
vlan_tci field strips 802.1p information from packets that have it. I
fail to find if this is already parsed and stored somewhere at a first
glance.

Best regards,
Jonas

