Return-Path: <linux-kernel+bounces-862307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B1BF4F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D151899524
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D627FB2F;
	Tue, 21 Oct 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQfWzCU1"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DD26E716
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031858; cv=none; b=SEsf2W2eAZAR80DfNg8EscAi8eMYrjARtupdkiE9AS2lRVXHGrcjTV8opsg6UWs7zrAjIHlcnejhNyfkENn+h7toiAzGVy/cW19ZPxRNY5cMHCQJz93H1YcNc9bjZkri6LDhEBCMpwu8+hmvxl42EbpHtHwn26U+tfHw7xStS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031858; c=relaxed/simple;
	bh=C8XVNi81mQNmodpigCUip9wr2dzMQanyPKYqCm0rROE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvF4pUu67IAm+Z792CMpwcPFz5ygWZP+8nCdRintIDOSxdwn4NsHWgNNqS6jGWg+l+P0zHE0jvPinnhQC6A0YfDgtxE8xYBqckmidIZrM3pLqIthYzVKqgBLITvAYx13I6qzS2wJCg2zmlVtpNuUyl2WKe7wz3HOdxpyjgzTfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQfWzCU1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7848f763982so35121337b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761031855; x=1761636655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbPxFvUCCg4jmFcZFZj7j0Tcz4pvz/ZN3cQUOFkRlHU=;
        b=SQfWzCU1cO0IfsEBD4zTbRTqsTCSv1qbBFoXaAWs/OS+K9u9h9xGR3KmxSAHEN5WLU
         3/AY3UtHJ86y94i4JRyVuMSZdYzVRguGVALzb43P+0EZY2A4IJ2dUonin1yBbjW9VJ0W
         GbZBn16AlMzk7/K6U1hH8qwvzLmQnVLDDjLIkalzNMrv1Ks1I47zwWmZrgI+Kbknp/j0
         2736PfTHJOsQMatWKC58fUgQmFxfw0Kj7nBWKZqP829MCVc3bOGu84qaErSqL9Abi/NB
         cihJfEnIvhqLwKsZwv+J8la6CVHUUVbAkZNhRWtlyJ35cjn8azVaYaR+m7W6dzP5lpbD
         q2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031855; x=1761636655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbPxFvUCCg4jmFcZFZj7j0Tcz4pvz/ZN3cQUOFkRlHU=;
        b=L3Dtg0DbP8yJv/zOKJnfhmcaUaRPckJQe4wsHNnfhXEA/zS/UnlPOa9no2sOivwyFB
         3e/iEvGhXy+V53akQgnURzx90i2L9FNurgN/y+Lq2T5qELeWFlA/vNVXeS/lTJbqMzpM
         gvdo99Skn+vtYpLHUgBJF8ueJgiggcQnh414ClZ+aEMpO/7GCAnoka746gXrphEv5cxj
         DoYfh5omIFlgver62z7gaHfrJoe+6pWs2n2O5tRRgRsQUOIb7un1U6SkwmecjKt/hs7r
         wJdNc3hi7um1BEzL+L/axjEQV2NC3uwDmoOLj+chFhzAB6e+KZrkx0G+mXU2BGZjrqUV
         3uVg==
X-Forwarded-Encrypted: i=1; AJvYcCX7d18yUE5liJeEI1fGmIM65flAVb2RZSky5H6lbnI2EYddhVrqOH/eszF7qnvT46r1YITI0sO2nTUxjdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZM28Ld1MMHOK6kZd1LFpPE6ic+HkwPY87Gb6JY3V1i7Hl8dzo
	n6On1b3wZOgWR0r14o3RiyYkBeB82D3R8wo8tK9heZ5M5/57/IGKHnkOcwQ5+R3kfvb+PVH1VF3
	1q8CjXLY+J2NVpvp4zRWWl7NA21XXoY8=
X-Gm-Gg: ASbGncuXhiMaCmT7BC6otmDuuHnUyW6POb/rgoap2CVmHka1EFhQMk3SAZ7zZ7Np3S7
	LaCAUI4dzJ7o0NFJHK/ibZzwNj65i6cROQXLqaZ0jWSep9sloDWFSDzEODSbKF9jZUn+otPZvPd
	ghNkthQtUS4ZWA9SjO8gICeo9iI6ZxWD2rOY+y2FPQAEYaP1wVf9kd7sw7qiwzOQwLCRMs7YGZW
	E9yLaQ6UMfmzvUHvAAqgtZ0dPIOksXE/KFi/ccxUY8QjF488dLEIUklvk9jnizC3bo+TQ==
X-Google-Smtp-Source: AGHT+IGzlrMBYLAYCCqhquuvoJhBcsKXndbOYaVlNX01Smr67T6hmkO2TRG9qxIJI/zeECHf8/X7yw/0zn/rtO8VP0k=
X-Received: by 2002:a05:690e:168b:b0:63e:1113:bde2 with SMTP id
 956f58d0204a3-63e1113c469mr12624865d50.20.1761031855348; Tue, 21 Oct 2025
 00:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
 <20251016102725.x5gqyehuyu44ejj3@skbuf> <CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com>
 <b0bc747b-82ee-4d7b-90f9-3ea299d1249c@redhat.com>
In-Reply-To: <b0bc747b-82ee-4d7b-90f9-3ea299d1249c@redhat.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 21 Oct 2025 09:30:44 +0200
X-Gm-Features: AS18NWC1Mf8lnFCtKgGd5UYG_oNVrVCkSUbN5C3c0oo10ERDN6XxPU3UCmTVL2Q
Message-ID: <CAOiHx=kU_UnAMECgwW3RODkVvojkcPsiy66pS_afF4jSm4HsAg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/16/25 1:50 PM, Jonas Gorski wrote:
> > On Thu, Oct 16, 2025 at 12:27=E2=80=AFPM Vladimir Oltean <olteanv@gmail=
.com> wrote:
> >> On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> >>> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q V=
LAN
> >>> tags on egress to CPU when 802.1Q mode is enabled. We do this
> >>> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> >>> VLANs while not filtering").
> >>>
> >>> This is fine for VLAN aware bridges, but for standalone ports and vla=
n
> >>> unaware bridges this means all packets are tagged with the default VI=
D,
> >>> which is 0.
> >>>
> >>> While the kernel will treat that like untagged, this can break usersp=
ace
> >>> applications processing raw packets, expecting untagged traffic, like
> >>> STP daemons.
> >>>
> >>> This also breaks several bridge tests, where the tcpdump output then
> >>> does not match the expected output anymore.
> >>>
> >>> Since 0 isn't a valid VID, just strip out the VLAN tag if we encounte=
r
> >>> it, unless the priority field is set, since that would be a valid tag
> >>> again.
> >>>
> >>> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags=
")
> >>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> >>> ---
> >>>  net/dsa/tag_brcm.c | 12 ++++++++++--
> >>>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
> >>> index 26bb657ceac3..32879d1b908b 100644
> >>> --- a/net/dsa/tag_brcm.c
> >>> +++ b/net/dsa/tag_brcm.c
> >>> @@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct =
sk_buff *skb,
> >>>  {
> >>>       int len =3D BRCM_LEG_TAG_LEN;
> >>>       int source_port;
> >>> +     __be16 *proto;
> >>>       u8 *brcm_tag;
> >>>
> >>>       if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN))=
)
> >>>               return NULL;
> >>>
> >>>       brcm_tag =3D dsa_etype_header_pos_rx(skb);
> >>> +     proto =3D (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
> >>>
> >>>       source_port =3D brcm_tag[5] & BRCM_LEG_PORT_ID;
> >>>
> >>> @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct s=
k_buff *skb,
> >>>       if (!skb->dev)
> >>>               return NULL;
> >>>
> >>> -     /* VLAN tag is added by BCM63xx internal switch */
> >>> -     if (netdev_uses_dsa(skb->dev))
> >>> +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN t=
ag on
> >>> +      * egress to the CPU port for all packets, regardless of the un=
tag bit
> >>> +      * in the VLAN table.  VID 0 is used for untagged traffic on un=
bridged
> >>> +      * ports and vlan unaware bridges. If we encounter a VID 0 tagg=
ed
> >>> +      * packet, we know it is supposed to be untagged, so strip the =
VLAN
> >>> +      * tag as well in that case.
> >>> +      */
> >>> +     if (proto[0] =3D=3D htons(ETH_P_8021Q) && proto[1] =3D=3D 0)
> >>>               len +=3D VLAN_HLEN;
> >>>
> >>>       /* Remove Broadcom tag and update checksum */
> >>>
> >>> base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Do I understand correctly the following:
> >>
> >> - b53_default_pvid() returns 0 for this switch
> >> - dsa_software_untag_vlan_unaware_bridge() does not remove it, because=
,
> >>   as the FIXME says, 0 is not the PVID of the VLAN-unaware bridge (and
> >>   even if it were, the same problem exists for standalone ports and is
> >>   not tackled by that logic)?
> >
> > In general yes. And it happens to work for vlan aware bridges because
> > br_get_pvid() returns 0 if a port has no PVID configured.
> >
> > Also b53 doesn't set untag_bridge_pvid except in very weird edge
> > cases, so dsa_software_untag_vlan_unaware_bridge() isn't even called
> > ;-)
> >
> >> I'm trying to gauge the responsibility split between taggers and
> >> dsa_software_vlan_untag(). We could consider implementing the missing
> >> bits in that function and letting the generic untagging logic do it.
> >
> > If there are more devices that need this, it might make sense. Not
> > sure if this has any negative performance impact compared to directly
> > stripping it along the proprietary tag.
>
> I think this patch makes sense for 'net' and reaching stable trees,
> where most b53 users sits (I think/guess).
>
> The DSA-core base solution could be a follow-up IMHO.
>
> @Jonas, please still clarify a bit the comment, as per Simon's request.

That was my plan until my internet connection at home went down
yesterday, and hasn't been fixed since. Once the ISP fixed it I will
send out a V2 (+/- me being back home from work)

Best regards,
Jonas

