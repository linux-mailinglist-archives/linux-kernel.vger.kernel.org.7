Return-Path: <linux-kernel+bounces-720818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81EAFC0B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B6A4A2216
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1D21B184;
	Tue,  8 Jul 2025 02:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IJYoMmte"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65D1DA5F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940840; cv=none; b=m89MpUQWRKN4Dnzj3uUf97GXSlvz4pWvNs1mLJ9WVUaDuSJGuu5pMvAPpqA3hATrLJDE3k3gNBwk7lSUiYdFdp5iOCFAOouCqGYOoq7oOdi9i0UclIzMTxqlANeQQrMS4iNWRSpBgBVS70XCrQP0IkHFmw46T1+pf8d2fLam/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940840; c=relaxed/simple;
	bh=J55cKjqJdB/s54ySt3a9A6aU/rgkpjBjIATa2spYydU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXY/UWz27y2PovJaTR8gc44u/VHdTJ2sRoSFBp9Rjs4CQJwtAgOJdHeNQkrGoAEXHwt3VnuE68STn0kUkCjb3QGFU3EN/fTRI+qDSimk9JLdmQ0vhkzjOkVhdVeywPJ47Ri5/PnW6hORJmlKBbPrSRLFqZZPF2cmHUTG1N6X/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IJYoMmte; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751940402;
	bh=J55cKjqJdB/s54ySt3a9A6aU/rgkpjBjIATa2spYydU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IJYoMmteYdZnYL0OquHwmK0NgiaYNAHFy7ZXSITie3Aff57LFZ10+VjFGYJo5pgh6
	 +2wZlmQU026XtnxYbNM7ivS4pQN6FE6/BEw12mwgCSeyAtxs8F+w2dEQCp85J1J+Gs
	 Kzfn64K3crWXikXXqxFvqxbS1gjLzh+W5ujytZ4weU3fiuJQQE0EXxWVkNK7qfqxj0
	 ijvNj5Vw1L2hDpWPRT7kPn/lt258fmy8dHx/YfWrn7KHZLGg2njfsM9G4S6e0kfMoO
	 DvEu1YrP2ovT4C+zLLvrR+2vEjQwJRzC9WNMNQfPbBmQqd5Nez6vEvaYXMRHJoNOoe
	 zph9f7ARVn9OQ==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 25621640B5;
	Tue,  8 Jul 2025 10:06:40 +0800 (AWST)
Message-ID: <f66b8b80d057a095dad3b41f224fb633565313ce.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 04/10] soc: aspeed: lpc-snoop: Constrain parameters
 in channel paths
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>,  Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 11:36:39 +0930
In-Reply-To: <20250704184408.32227305@endymion>
References: 
	<20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	 <20250616-aspeed-lpc-snoop-fixes-v2-4-3cdd59c934d3@codeconstruct.com.au>
	 <20250704184408.32227305@endymion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jean,

On Fri, 2025-07-04 at 18:44 +0200, Jean Delvare wrote:
> On Mon, 16 Jun 2025 22:43:41 +0930, Andrew Jeffery wrote:
> > Ensure pointers and the channel index are valid before use.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 25 ++++++++++++++++------=
---
> > =C2=A01 file changed, 16 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed=
/aspeed-lpc-snoop.c
> > index ca7536213e0986f737606a52996ffea620df2a7a..804c6ed9c4c671da73a6c66=
c1de41c59922c82dc 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -25,7 +25,6 @@
> > =C2=A0
> > =C2=A0#define DEVICE_NAME=C2=A0=C2=A0=C2=A0=C2=A0"aspeed-lpc-snoop"
> > =C2=A0
> > -#define NUM_SNOOP_CHANNELS 2
> > =C2=A0#define SNOOP_FIFO_SIZE 2048
> > =C2=A0
> > =C2=A0#define HICR5=C2=A0=C2=A00x80
> > @@ -57,6 +56,12 @@ struct aspeed_lpc_snoop_model_data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int has_hicrb_=
ensnp;
> > =C2=A0};
> > =C2=A0
> > +enum aspeed_lpc_snoop_index {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASPEED_LPC_SNOOP_INDEX_0 =3D=
 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASPEED_LPC_SNOOP_INDEX_1 =3D=
 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ASPEED_LPC_SNOOP_INDEX_MAX =
=3D ASPEED_LPC_SNOOP_INDEX_1,
> > +};
>=20
> I don't have a strong opinion on this (again, I'm neither the driver
> maintainer nor the subsystem maintainer so my opinion has little
> value), but IMHO the main value of introducing an enum here was to make
> it possible to get rid of the default statement in the switch
> constructs. With switch constructs being gone in patch 10/10 (soc:
> aspeed: lpc-snoop: Lift channel config to const structs), the value of
> this enum seems pretty low now. You could use NUM_SNOOP_CHANNELS
> instead of ASPEED_LPC_SNOOP_INDEX_MAX + 1 and 0 and 1 instead of
> ASPEED_LPC_SNOOP_INDEX_0 and ASPEED_LPC_SNOOP_INDEX_1, respectively,
> and the code would work just the same, while being more simple, with no
> downside that I can see.
>=20

Yeah, I agonised over it a bit before posting. However, I'm on leave,
and I'd like to draw a line under this series. This patch is in the
middle of it, and I'd rather not disrupt it too much and go around
again with a v3. I'm going to keep the enum for now, but if I need to
tidy up the driver down again the track I'll reconsider its worth.

Andrew


