Return-Path: <linux-kernel+bounces-789391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E731B394CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F433ACC07
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD02D23B9;
	Thu, 28 Aug 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hHAJgBPc"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AE2222AA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365259; cv=none; b=nhynnn230kcG5gDkrNID+5/mO0MvahZEy1ElemFhXzaPxsBLqW1BO7TaYv7kowhBn8GNt/ZaZT5I88Lo/QZEpio6gGUyEaaJ2kaTJB30uQcv6xnC9vQiMt1kHu7VtNgvThL6JPq3JzrpA/OBArP7TKMzrCNt/11h2JTT2lvWwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365259; c=relaxed/simple;
	bh=xntUmqSE0vgOYnYD4xbrPVt9wYRIgbA4/JuaNv57464=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COssrOwNgyFEJex6hcG3X1EQeT1vFM1RwAIc+tWgZ+hl7VaRpbE7lFxDa4t6JNK48th/fG5Th43G4vX1wa3CTiVOoQZk8WR8lKI8Q6X/c2aoEOpNwPm4zgVJD269U8+hI58YDRODVolNt3K0STh8o+j5F4F0AFm6S25W6iFg9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hHAJgBPc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1756365256;
	bh=xntUmqSE0vgOYnYD4xbrPVt9wYRIgbA4/JuaNv57464=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hHAJgBPcgf2FtBUw/C4I/D8qF17LSRvyZeFYztTriRAKvrs6yPiYlv/X8gBrw6aZ/
	 luVL1DXDPKb5fHIfAGuZoAaMaB+ZOFPAvbrah+FoWmcZ4g0cLDT5Kb9hEzdBI54Q89
	 yZDp0p+AR3pYEJIDkz3C0TOtwvC2xsmuYSN7l4RA=
Received: from [IPv6:110::b] (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BCD6066F00;
	Thu, 28 Aug 2025 03:14:13 -0400 (EDT)
Message-ID: <1145a7c66dde1157f8c8dd6fd073164edfce744c.camel@xry111.site>
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS
 no-bultin-memcpy
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Wentao Guan
 <guanwentao@uniontech.com>
Cc: WANG Xuerui <kernel@xen0n.name>, linux-kernel
 <linux-kernel@vger.kernel.org>,  loongarch <loongarch@lists.linux.dev>,
 =?gb2312?Q?=D5=BC=BF=A1?= <zhanjun@uniontech.com>
Date: Thu, 28 Aug 2025 15:14:06 +0800
In-Reply-To: <601863349f71b54087bc7ffa382955ad6bbf5511.camel@xry111.site>
References: <20250826113225.406238-1-guanwentao@uniontech.com>
		 <20d3df642aaff2a771e74452b81463709f7c16d1.camel@xry111.site>
		 <tencent_6579F3317CCF94D00EC3C7DD@qq.com>
		 <CAAhV-H68Tzewu3x+8=Psb-8Hqg58o4v-8QyvFew+Wuo=Ne-iAA@mail.gmail.com>
	 <601863349f71b54087bc7ffa382955ad6bbf5511.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 15:11 +0800, Xi Ruoyao wrote:
> On Thu, 2025-08-28 at 15:09 +0800, Huacai Chen wrote:
> > On Thu, Aug 28, 2025 at 3:06=E2=80=AFPM Wentao Guan
> > <guanwentao@uniontech.com>
> > wrote:
> > >=20
> > > Hello Ruoyao,
> > >=20
> > > Thanks for your review.
> > > I will test and send test results later.
> > > (use different gcc verions and remove the three flags.)
> > I think kernel's memcpy is still needed for CPUs without UAL.
>=20
> GCC memcpy expansion correctly understands no-UAL case.=C2=A0 It won't
> generate unaligned access unless -mno-strict-align.

P.S. kernel's memcpy is indeed still needed because when GCC deduces
it's not beneficial to expand the __builtin_memcpy into ld/st sequeces,
it'll just call memcpy.

--=20
Xi Ruoyao <xry111@xry111.site>

