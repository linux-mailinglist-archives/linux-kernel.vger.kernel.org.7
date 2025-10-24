Return-Path: <linux-kernel+bounces-868185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC3C049AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5464EB8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94A266581;
	Fri, 24 Oct 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z5mXZSF3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zAbPRISG"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543015E8B;
	Fri, 24 Oct 2025 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289382; cv=none; b=lv5GhU0UTT5/cpN/zMM+HOhS752Sop1PEqHDbkYlbGmULkY5hJU6Wu4l+nYzCDU0JcNn/A0hiCAiZ4UPMdzdXfH+wH7Vs7mjYT5RRJXag8R0CNlmZQNryqaPK7etH3FsCLfwKEdZYTNht69iUHH6TH0yvIkugRiNB2SO8H3df1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289382; c=relaxed/simple;
	bh=Zc0WUF7othcaVHi7fGyfnH8q+HarWOJjAgEQJVdcEy8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BRwtjV1crLsbsQ2iqrTEGTd0kDKUPk01YgFECWxNOiX/eDvwgC728RyYyFQnG0KszJE89ysjdnAnH5vmIGLE1JZmZuntfR2i/hqYHRCG6RbXnrI/zd5UFM0FGNWyiVUggx2LIR+l6hMxuvqj9FDWk/5xBaDqgruPEzFUNs2T/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z5mXZSF3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zAbPRISG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D0BBF1D0016C;
	Fri, 24 Oct 2025 03:02:57 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 03:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289377;
	 x=1761375777; bh=mac9tPA7fjXsKMTZ5o0W5XcYjwuuhxgWlzIaSPBWgTk=; b=
	Z5mXZSF3chz/arWSZEIPGf+rfgYMBabszFcm0EoBuebIAyZgnuldhbmd3wVyJBT4
	7fjVGgOtJu8xCJXD3Isa+gWn4TFjblgFvbs5HwBrDz0A99uSdzb2k0z7hBuK07ec
	QIrDGu/I+S/eSsfSF9wAAl6k2mjp+7XgqfaRWISfmdsM20xXY9dMVBsU9dMId+r0
	ZMD4UU3NRyugd4T7i2bffrUbtXONDtNtGWoyI6OSD1s5I53cfgIBKtTowoaB0ye9
	RTSUEDkMPZHTI5tPiQdYTCwNVhB8nq+uXzaONeutekDvZ5fVX7mbepaB2lTg7+E9
	YxH2QoA7fu/kTR7wo0wqXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761289377; x=1761375777; bh=m
	ac9tPA7fjXsKMTZ5o0W5XcYjwuuhxgWlzIaSPBWgTk=; b=zAbPRISGYs04ZgTVZ
	els+9gdDIme18GEHUlNsuJztgHJetc999YVCvrq/PNrn7PVL1mvytGyLWFn5uIDB
	vJzlEjFLBGAzAyrbRUQY2EQbroq9iVU78quJoKch7O38TlJaOymjhpcNr6DWX/7x
	sME9HpPhb3oILSHGMeA1tEy/MVyh3AdI8SygN4AQmH1e+z3XUF5obXqC8UOKAll+
	D/T/HOfp4fayovs4vfsAKzvfNW5vsi+H3LTDAMNYhDaBdI9+4gxJIS6HWR44sFMn
	orrD7O+m3+uwBCuZOr+aptyTSeauXNdo4f+4c+bAfu+SYMZ2efySZLXTDkkM4d/6
	/whyw==
X-ME-Sender: <xms:niT7aNORl5OLs4fICcMOsJBHp8xqXwmEEd3y7gWTnmBrfeQCgYsvvQ>
    <xme:niT7aKx8n0jC-0EeZgnAMNBykaU7uZwvkdPQn9ds6p_3UuA_hW1youPJTHqmmcTfp
    3f8gXcJylAENNlmnIFQz2YupLFTvpnBSRWpR4ZGvU_XgaSXMWmzgZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeehiefgudefheffieetudeikeehueeffedtheelteeuhffggfeihfelheettdevffen
    ucffohhmrghinhepohiilhgrsghsrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopegs
    mhgtqdhsfiesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtoheprhihrghnpggthh
    gvnhesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohepphhrrggshhgrkhgrrhdr
    mhgrhhgruggvvhdqlhgrugdrrhhjsegsphdrrhgvnhgvshgrshdrtghomhdprhgtphhtth
    hopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthht
    ohepjhhksegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehnfh
    hrrghprhgrughosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhhovghlsehj
    mhhsrdhiugdrrghupdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:niT7aCHoTkH26y4HM0ap__KxzaoaaM1csgLdSkGRihkbg2o24M8xuA>
    <xmx:niT7aPeqNKheIO1FTDxgLABGSHquDcvscBghb1Hggsy528lGU-uoYA>
    <xmx:niT7aH8BBeY3n72QZvz7wQUQpC5otuUkz-xGTbthO0GpJJ9rP4-NnA>
    <xmx:niT7aFZY6oU1lW4ltrcsZ62bMXuDjj---pt4fvPunstPkitM2p7lAg>
    <xmx:oST7aFyotp38mE_UVArEvtRzxSdLeT9WZZ-t8kzbfLTzojk62SAN2Wwv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2295700054; Fri, 24 Oct 2025 03:02:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMptcG-LwCSF
Date: Fri, 24 Oct 2025 09:02:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Jeremy Kerr" <jk@codeconstruct.com.au>, "Lee Jones" <lee@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Nishanth Menon" <nm@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Taniya Das" <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <66d0dc8f-553a-41b0-a9af-e058bc39dd94@app.fastmail.com>
In-Reply-To: 
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 24, 2025, at 05:54, Ryan Chen wrote:
>> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
>> tree
>> On Thu, Oct 23, 2025, at 09:37, Ryan Chen wrote:
>> >> > +	soc1: soc@14000000 {
>> >> > +		compatible = "simple-bus";
>> >> > +		#address-cells = <2>;
>> >> > +		#size-cells = <2>;
>> >> > +		ranges = <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;
>> >>
>> >> This probably needs some explanation: why are there two 'soc@...'
>> >> devices? Is this literally two chips in the system, or are you
>> >> describing two buses inside of the same SoC?
>> >
>> > The AST2700 is two soc connection with a property bus.
>> > Sharing some decode registers. Each have it own ahb bus.
>> 
>> I don't understand your explanation,
>
> Let me clarify more clearly:
> The AST2700 is a dual-SoC architecture, consisting of two interconnected SoCs,
> referred to as SoC0 and SoC1. Each SoC has its own clock/reset domains. 
> They are connected through an internal "property bus", 
> which is Aspeed's internal interconnect providing shared
> address decoding and communication between the two SoCs.

Makes sense. Since this is a fairly unusual design, I would suggest
you add that explanation into the patch description for this
patch as well, so readers have a chance to find it when they look
at the file in the git history at a later point.

>> Since there is no corresponding driver change, I would keep the binding change
>> as a patch in this series.
>
> Sorry, I am wondering, I will follow Andrew advice. 
> Submit ast2700-mdio to net-next go out another thread.
> And put submit link in cover-letter in next version.
> Is it ok?

Yes

>> The version of the driver you are linking does not appear to use syscon, maybe
>> this is an artifact from a previous version?
>> 
>> If so, you can drop it. On the other hand, this does seem to be a classic syscon
>> device and keeping it marked that way is not harmful, just redundant if you
>> actually use the more specific compatible string.
>
> Sorry, I may not point right link
> https://patchwork.ozlabs.org/project/linux-aspeed/patch/20250829073030.2749482-4-billy_tsai@aspeedtech.com/
> aspeed_g7_soc0_pinctrl_probe -> aspeed_pinctrl_probe
> https://github.com/torvalds/linux/blob/master/drivers/pinctrl/aspeed/pinctrl-aspeed.c#L456
>
> That will use syscon to regmap.

Right, if that is the documented binding, I think keeping syscon in
the compatible list makes sense.

      Arnd

