Return-Path: <linux-kernel+bounces-854868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC5ABDFA34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692431A21328
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB9337687;
	Wed, 15 Oct 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAOl7XQD"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDB3375A5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545488; cv=none; b=i1ZhHDbSoHiV2d5x/dCzp5y7JhDDdfl6/ubd95BzIOlD+GakHHq9zJQyi48pIeOdrhEeMEc88bMu+5ou+WT1MjNYT6TmrdVGr/zV78to8J/gKtOXlZqhvOqsEzuF1e0MZCYue90BSfU7ZSXiA4If7A8VyE69pBeK3+oXNCYFLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545488; c=relaxed/simple;
	bh=5dmSHYaCSlL5DE484eUuB+gCCkzOeT/39M3pRYLgteA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAH3xEMLV/9AoHL7IFBfcisMAWPTo1LufjQVD6IrMT8PYMv+QurFBg1Vj/Jvx9B2+4rJE5dp74ihcoso6aBXJV0P083QXh1Gd4o+jHZz6XzDFizs5awPbzHE61HGVarwSgmXzi5aReIw7QQe3/7p6D4W79ljuNTh55wr5jcPLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAOl7XQD; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63d97bcb898so878710d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760545485; x=1761150285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oca03mfHwwbupYnaH4z5NUyICPNpnwdM0yH9k7Bfwcg=;
        b=MAOl7XQDi3AWkwANc8dyL7U63h+UtqUWw8xFTDn7nJByDOsiDC4vQrxN5yA3wpRwsp
         JMvLV5Dr4aZ2EA854j0X5ESnKYySJOFknY+t7frXKP6Emyc45N20Vk5azF2OPjLSfFHS
         q0bWJmyr2WcACk3aKQWXsj4+pZCNAJuxpod1b79XP+EgmrX0i+Md8vRWYGk3xdHDWAmY
         0hRp9fN2dbtNBXj8r2bWksC7Utm6DbSZ1DIeXE0fNV5oHIph5LIn7I6AK7tveXN7pPWC
         kioGNGVe6ChXPg38lnMUw8GpSobvYFa6HRuN3Vf0xkYxMxLoMxrZjSOmOr+4SKhG7SZa
         bf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545485; x=1761150285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oca03mfHwwbupYnaH4z5NUyICPNpnwdM0yH9k7Bfwcg=;
        b=P60JPRUcbNyxyDZdiI/SNg6W738R/WGDnVfCP2CWBJFido6HI+8YAQlDY74gY8oj99
         JdPWG2aZugAoY4kqTf/pi2sv3b4pQSlg3p4V4FlwtSzlZHfvZlua2jKrv3VqIb91fiWT
         Zl/mTJEt/oDnaqRDjXT2CoeuLtUjjrPNxe3Oufe6N6WOuEyKGI38CRqE5mYUMn0YjDEO
         OdH9OvPDZWpNk3m1fe95xLzoT+iLVEQ/ZHqBIztrV7phuIoLC0/5V7fbPrGXsSDQ2BJX
         GLn4HlrQ7gahSRvsOIgZU1dvvbGCAP0uLBcZNiClJtChcAkkN33FsQD/x5hS6hGK8ZVH
         DvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUbtFGtTayZ+zBP1rNdNUKmYDvBo40Fkf7MN1/UyRRlemcDzE3CZdBmqfgnitnV21k/QM4k60PiuOxts78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0AMkY76Zu0IIJgAUWUdx4KQvPwGJbkHjR+oZ62vQSm3B3Dco
	Z4N00ouwBVFWQj7PA1CQlybMZ5Z3ltHPIqfXsEjis0xIOR/DGKZtElJ2CRiP6rFQSzT9Liovy5n
	GiEzbIzF2IYKK6IrXllI4F1e2J0d3zU8=
X-Gm-Gg: ASbGncseo/2TCuFSxDXX8MJ8z5odybqnDYYXGAiFI0KYQEix/ygtModSz+nHkkPErgP
	jmF1Bux0P9S+HGfND5syOwtTlR8fHcWmOp5TCS0BK9uvSRUJIoPerOtK/2QWXCy+1qm+Sp/GT00
	Bu883dmk8gH46GGzgW+HTaX/FRLcOu5h5zl+gQt1BsovbR5t7bXiegU1p8U5KTEGTjh3DG83T4A
	SakMnqsmca4tOtXnha41aSv
X-Google-Smtp-Source: AGHT+IFfqn8fLPcF2mb1gVi+G41RV2YT7DE1gzY6TrJFfSruChGkTvfZPHEqftOuvKHznTZtaSaFI1V7ACaXcJIiywE=
X-Received: by 2002:a05:690e:108e:b0:5f3:317e:40af with SMTP id
 956f58d0204a3-63e08fd5e43mr308137d50.19.1760545484844; Wed, 15 Oct 2025
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015070854.36281-1-jonas.gorski@gmail.com> <aO_H6187Oahh24IX@horms.kernel.org>
In-Reply-To: <aO_H6187Oahh24IX@horms.kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 15 Oct 2025 18:24:33 +0200
X-Gm-Features: AS18NWB5lthoC5h8fYZc_CEg6WuMBx-FRcGPGIiwRRyZzUYMwsRaOF117HRUBPs
Message-ID: <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>
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

On Wed, Oct 15, 2025 at 6:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
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
>
> ...
>
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
>
> Maybe it isn't important, but here it is a TCI 0 that is being checked:
> VID 0, PCP 0, and DEI 0.

Right, that is intentional (I tried to convey it in the commit
message, though should probably also extend it here).

If any of the fields is non-zero, then the tag is meaningful, and we
don't want to strip it (e.g. 802.1p tagged packets).

Best regards,
Jonas

