Return-Path: <linux-kernel+bounces-888411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3557C3AC04
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C441AA378E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D33318146;
	Thu,  6 Nov 2025 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1Ajto9R"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC743101DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429861; cv=none; b=h9P1nZJ7aJOcr4jcSE2P7jKZmMar/vsec8ELd64kt0d7LJcEcPR+Oip4alJbBkD2vR9rU6pU+VIFxsLRxfLjLK3ibUTQq4LEwC9Utn6MKekdD1cekI3Dpitzlv/PNbulVsCvkcRCI3lYy5WWTAyrOK3T73169OxvN4YoIT07WrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429861; c=relaxed/simple;
	bh=3NISYrab/MBXdbWKNAmUFFIUSebju6G5kH2bghjCBXs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gIMSv2+fiTH+ADtS/uMBfhGN2OQZx3FwTzjWRZl5VpuhMTHh+dvdr5OcUKo8bxsEky7mgZrkgn5H82U/NRjOWUpma3B1v2+evhx1JjTT/0uiYXWVSMbVurfG+/WPuydrXe1EsXvctoNRNyBZ2oVvkk0fwSCRm8C6gqnh/ribdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1Ajto9R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 290F214001D6;
	Thu,  6 Nov 2025 06:50:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 06:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762429857; x=1762516257; bh=hhpk6fTlqp/j4PTFIYbnE1NZ1PyPGfcYM9f
	GDcyzk+0=; b=G1Ajto9RwBMqq/SUC0v5M94XTt0Avvr01b38aA+oTKroecQZU+2
	2Bq3HBlQl0WocCr9e2PQht2XIxPJ7PYKeBrhdJBYOw9By3mIG/wgYEWimqNGjt+I
	BEe0H6o0iyY33HD+0i0gNuFkBSLFHi4Xt7X/q/notCEPWyQ2DldLhTL890lch2qm
	3A/MTraUzYF6yPTOPpcDnN9LIN8/NL4eRoP5dSxj6tbmRwJTxWksLVM6RFPrVLkZ
	yHxDPZ15UnDRpEdds2e71+NMM90TfkhMbCK7YU7rNeAxMvT3AVQ71XJHcgeFlDuL
	Z5xCp35TAXqGryXJR/LGeXHC6gVRMgo22KQ==
X-ME-Sender: <xms:nosMabhEHUf6c3cJ-3fHyG6uAMNkZRVf-kLwPMBG1B04edU4h6TThg>
    <xme:nosMaegxQeL6DiEPkNTX8LVKGomFHk-jGSf5rBVdYhW1DkmbzXw7KoY5GyfBRDRtr
    lMqam3gMVvOK0YTPzde7Mz4U7XONX55wlmNt1My0fHJZ9wyPwnXn-k>
X-ME-Received: <xmr:nosMaZG6YrPzPdnUC3d55Dsy4x-UONLE8uHoat7CIDloousscl37a6NLDbbSsiGuYN4Jxoaq5ggg72Ydjn7zZHwDP4R8ltH9EU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelfeeklefggfetkedukeevfffgvdeuheetffekledtfeejteelieejteehgeel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihse
    gtshhgrhhouhhprdgvuhdprhgtphhtthhopehushgvrhhmheejseihrghhohhordgtohhm
    pdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehmph
    gvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshgrmhesrhgrvhhnsghorhhgrdhorhhgpdhrtghpth
    htohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhinhhgrdhorhhgpdhrtghpthhtohep
    lhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nosMabAB_t1bGxV6bAdxgJoOu0LW9zq53SYSFQ85o1YR6z4NQsL-Bg>
    <xmx:nosMafC62GKoaSwwqCagyjnw9AGjwdDHdXeMNKgE_F36sf-MpBGqPg>
    <xmx:nosMaZMrQeFXP0hvzam01KuUy6esyWIiGhy2yUhhEvlVOKC63d4H6w>
    <xmx:nosMaTPt4OJ7QQ3yobIYFvpbIOPzxaVaUMf4WTmzQ7U3JOR2B-ndOA>
    <xmx:oYsMaUiEX6bcvaWKiRi9b79AUyiP0wavSNvldCxbrtqhA8MF4Pz5iYwQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:50:51 -0500 (EST)
Date: Thu, 6 Nov 2025 22:50:27 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: Stan Johnson <userm57@yahoo.com>, 
    "Dr. David Alan Gilbert" <linux@treblig.org>, mpe@ellerman.id.au, 
    npiggin@gmail.com, sam@ravnborg.org, benh@kernel.crashing.org, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    rdunlap@infradead.org, Cedar Maxwell <cedarmaxwell@mac.com>, 
    "maddy@linux.ibm.com" <maddy@linux.ibm.com>
Subject: Re: [PATCH v4] powerpc: Use shared font data
In-Reply-To: <994bea8c-7b28-4aae-a6b3-e4f33731cb29@csgroup.eu>
Message-ID: <b4737133-a33c-f4d1-cc4b-0c0b70c45635@linux-m68k.org>
References: <20230825142754.1487900-1-linux@treblig.org> <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey> <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org> <aQgJ95Y3pA-8GdbP@gallifrey> <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
 <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org> <994bea8c-7b28-4aae-a6b3-e4f33731cb29@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-146381177450487057176242982735

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---146381177450487057176242982735
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Thu, 6 Nov 2025, Christophe Leroy wrote:

> Le 06/11/2025 =C3=A0 05:11, Finn Thain a =C3=A9crit=C2=A0:
> >=20
> > On Wed, 5 Nov 2025, Christophe Leroy wrote:
> >=20
> >> 1/ Either build font_sun8x16.o with -fPIC
> >> ...
> >>
> >> 2/ Or add a PTRRELOC:
> >> ...
> >=20
> > Thanks for your help with this, Christophe.
> >=20
> > I fixed up the whitespace problems and forwarded those patches to Stan,
> > along with instructions for applying them. He tells me that patch 2 fix=
ed
> > the hang. Patch 1 did not.
>=20
> Fine. Then let's use PTRRELOC.
>=20
> Will you or David submit the patch ?
>=20

OK, I'll submit the patch.
---146381177450487057176242982735--

