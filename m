Return-Path: <linux-kernel+bounces-884388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7404C3014E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E5B4F3DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2A295516;
	Tue,  4 Nov 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Fz2xhV4G"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589D19CCF5;
	Tue,  4 Nov 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246115; cv=none; b=DkdoRCGwnWuwQypvmj7QiqaihkK/xYMAJpTZlAC+dJ5j7u6cOvkSDCDloWRVWuGJJl16ObifW82zy9OcNCyKRx4+rTLO4UnuzKW4mxR5gVywsENH6tpk3MM85uL8mQg6l3ahitVGyAdp5mI7YwPIxL9t0KGXxuZhcEEG/D0PgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246115; c=relaxed/simple;
	bh=KHpdCYL1P1c5pPmSGKmaOsmNyV3IWF2XLafTKv9g6hU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5nvxVbRJPA/y89rqRvskLzgzrtVPSS5ansercezEzcKCmoIVBuzZhuBEyVipDvrC1d/dbDum69kqud8P8PCQGfxpwXMfa9Rq2QRB+Sulx+rz8V9Um65KoZBwBmRr0ePgUKLsnoyPDa/nRcxbJ1/JXONEaxG1OmGpGwgxvBceaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Fz2xhV4G; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=LDMxSBdMWQSX4Hz7DIi6vXyes6twxoeEz9SIi1KmtHU=; t=1762246112;
	x=1762850912; b=Fz2xhV4G0i0V6fss5K5AFLQNBNp5sxgQOQ0rk4yZgFexxS97S88z/9j9/ZeYp
	6LSuaS911i6XsdAqTkHTlAlR5Fc/te+aNL/ikjV6Fj4AvKl+MwJAe3ZhfAMvhP+oQn6Yx4VPQWlsy
	y1tEIrf87jN6P32AmZPpGC68M93U9/SZMaar0QGCuAttvt4f2KOIRNiOvG2lbWDpOiK6TLSxoFkjH
	9uPy1GxclaB90LOoP4arXydlM6rnY18Vo7hy7Y0NxoCdpPMvjo1RG9l5893eBVe76huabwuuC/e1C
	IeU8s4ZU+XujgY4rpZx63Ip7JCvKp1zvdB4q98pun5K5k3VmuQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vGCiM-00000001CGm-0a1S; Tue, 04 Nov 2025 09:48:30 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vGCiL-00000002mbz-418W; Tue, 04 Nov 2025 09:48:30 +0100
Message-ID: <69590ab694891d84acd2b4a4317c2fa8d1a98344.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Alpha: MAINTAINERS
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Nov 2025 09:48:29 +0100
In-Reply-To: <CA+=Fv5Sdf732mc2c_xGDsJqq2pS-EQU5d0XLBR7v-0GdgFC5EQ@mail.gmail.com>
References: <20251103213656.25912-1-linmag7@gmail.com>
	 <0ba150517e0fd331f1227e068fd37e6e6ea42228.camel@physik.fu-berlin.de>
	 <CA+=Fv5Sdf732mc2c_xGDsJqq2pS-EQU5d0XLBR7v-0GdgFC5EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Tue, 2025-11-04 at 09:37 +0100, Magnus Lindholm wrote:
> On Tue, Nov 4, 2025 at 8:23=E2=80=AFAM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >=20
> > Hi Magnus,
> >=20
> > On Mon, 2025-11-03 at 22:23 +0100, Magnus Lindholm wrote:
> > > Add Magnus Lindholm to MAINTAINERS (Alpha port)
> >=20
> > I think this message should be in the subject of your patch mail.
> >=20
> > Did you use git-send-email to send this patch? If not, you should set i=
t up.
> >=20
> Hi,
>=20
> Thanks for the feedback, yes, I used git-send-email. I can put out a v1 o=
f this
> and update the messages subject accordingly.

That would be the v2, you already posted the v1 ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

