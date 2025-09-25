Return-Path: <linux-kernel+bounces-831927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD4B9DEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E1C382C98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3308275AFD;
	Thu, 25 Sep 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pItA3ruZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8gtftuP"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9B265620;
	Thu, 25 Sep 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786636; cv=none; b=pSBtkpZ6TogscOcx8u87Nd+77paUDHXyP2UK2X4xIsN9ibyfft36ylk8pzQZPpqJSPgAfreLre6eZpxgVkb3cY2rb8lIlMfwlOEuaJTgVkSjfETs8qim+NpeewhuWXa/e69590n9Hj42jL0WAjaU/a444q2E2JsoGMHD/+/j7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786636; c=relaxed/simple;
	bh=dvpW+SV86ILwcenupEPH+XphYWSpYuS+phA6XOqPzy4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mbhwTlz5gOlwfzsSIgUg8EroCWGQbr83WwKLRrNlrSntlICs9eW909awzN8RNfgyEgdQjrC791eXNXaC+EzkcdtzZAgPIphm9K8v4BaPUPDXFb/SaDu67thJqNLxPCazuvBLhMl6iyB5vcRA1a95oYTjOw0bt+8M+caGipTy3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pItA3ruZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8gtftuP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 501437A0179;
	Thu, 25 Sep 2025 03:50:33 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 03:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758786633;
	 x=1758873033; bh=83Nn5b4JSEuoWgZrR/ay70JX8WRfWcMJ9A+FdwfFYxo=; b=
	pItA3ruZW5T9+PNMdSyjosQHJWW2SIzFRB1T+1RzR7XetYb5u8pq+kAbshCqp/hb
	CFNDPCk/hLBLyz+H2ZWs8UcaNdg2+zOCRg4++29TjH3JlmivlncDIp3x2zeX+vBG
	D7QG5D+gm9SgVgUgjgBJ+FMTmm+DsPGr9bUhzqdyqqoNL8fi52jH8/JaQRCTGDw6
	FHaKU+6MtiCOQ9tjMdscENdigKG4iD1fTydgYzyoz42edBo442pHGC79hqjyPTeM
	KLrbZIPCADoFDoWyI3qavcmg70ybpiHfptnQAZhImMoeIsR9wzwiEjJn+rQ3CVuD
	s19XNKOjyD2KuoK1LpTONw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758786633; x=1758873033; bh=8
	3Nn5b4JSEuoWgZrR/ay70JX8WRfWcMJ9A+FdwfFYxo=; b=F8gtftuPlBTRVn1pa
	p6m3cdU9OIig8dVcgg67TXV+KxF/F5/oqQuQtWoojwNQFfeWb9lh60R1TFw5At2k
	ucwafUPANpmkWItrpNtP6w/ecFxZY6orzb8rLkFMPHCaxGenNmbGRjn8cw47yjC3
	CEM8OQgKbtdagWJTFDLLyttBR68IenIRaa/R5DjkQ4+jtNlvJbpX4YQiVGF9w03f
	gFhednbXnVH92My128e7yjsMVQWIHnXvGi9sOe62bgP2AXIe49x1Vpxtb1PmgupE
	G4Qf8kwq1rkfBS7XpfjGFyttT9FbzheIlA1iIJhMEG8AUoi8h7OoslJwdsuXo5Ep
	4k7iA==
X-ME-Sender: <xms:R_TUaHKqyXCy2u6drtgXYPqbK830VmCmZRElz_DxuwtMju8m69zJgA>
    <xme:R_TUaF_Spg3m16H2kIU2QNq19M-W6m_bYrAS-PE379QzEhamyqoaJemZmQQCgCESV
    qQxXHQ6hkXbx7M93XBEbT1Ud93NJp7l_uBkLfCJI1hbt5dyFRJTNRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epfeeilefguedtueetjeekkeegkedtudfhvdetuddtleeihffhuddvhfeufeevlefhnecu
    ffhomhgrihhnpegrshhpvggvughtvggthhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepvdelpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthht
    oheprhihrghnpggthhgvnhesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohepph
    hrrggshhgrkhgrrhdrmhgrhhgruggvvhdqlhgrugdrrhhjsegsphdrrhgvnhgvshgrshdr
    tghomhdprhgtphhtthhopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomh
    drrghupdhrtghpthhtohepnhhfrhgrphhrrgguohestgholhhlrggsohhrrgdrtghomhdp
    rhgtphhtthhopegvsghighhgvghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvg
    hlsggrughrhihmsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrohhmlhgvmhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepfigrkhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:R_TUaCQNWYf7xcnmutE64H55YDv-wG_GnNWltdQu47-XLEWqRqLfSg>
    <xmx:R_TUaIOGhz3Vc68QV44f-9EIYj5iy7WDrZlaTmUb0lEw2sqnov865w>
    <xmx:R_TUaGs6JGuiXFJq0DvGWqw7-yzX8QP7i5v3zM4zrDjbepspj5BVdg>
    <xmx:R_TUaERxoCYP_AJ0GAgc8B-gPD7Mo9NYBnBevlzOuDiBbh8IvNkT2w>
    <xmx:SfTUaArooyr620KNVFTum50IpoHqBjBTm12tNgGDbf1of-N0qVf46SKF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 508FA700069; Thu, 25 Sep 2025 03:50:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApQpqsW9_EUk
Date: Thu, 25 Sep 2025 09:50:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Nishanth Menon" <nm@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Taniya Das" <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Eric Biggers" <ebiggers@google.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, soc@lists.linux.dev,
 "Mo Elbadry" <elbadrym@google.com>, "Rom Lemarchand" <romlem@google.com>,
 "William Kennington" <wak@google.com>,
 "Yuxiao Zhang" <yuxiaozhang@google.com>, wthai@nvidia.com,
 leohu@nvidia.com, dkodihalli@nvidia.com, spuranik@nvidia.com
Message-Id: <41705e13-c61d-4249-9492-b83f1371d3f9@app.fastmail.com>
In-Reply-To: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 1, 2025, at 05:13, Ryan Chen wrote:
> This introduces initial support for the Aspeed AST2700 SoC and the AST2700
> Evaluation Board (EVB) to the Linux kernel. The AST27XX is the 8th
> generation Baseboard Management Controller (BMC) SoC from Aspeed,
> featuring improved performance, enhanced security, and expanded I/O
> capabilities compared to previous generations.
>
> AST27XX SOC Family
>  - https://www.aspeedtech.com/server_ast2700/
>  - https://www.aspeedtech.com/server_ast2720/
>  - https://www.aspeedtech.com/server_ast2750/

Hi Ryan,

Thanks for you submission earlier. I see that you had sent the
series to several lists including soc@lists.linux.dev, which is
what I use to keep track of patches that have been successfully
reviewed and that are ready to be merged through the soc tree.

Unless you have been told to send it here by Joel and Andrew,
I assume that they will pick up the series through the "bmc"
tree once they are happy with it like they do with the 32-bit
Aspeed SoC (ast24xx/25xx/26xx) patches, and I have dropped
the series from https://patchwork.kernel.org/project/linux-soc
now.

For future submission, please send the patches only "to"
them, with the other people in the "cc" field to avoid this
confusion, and leave out the "soc@lists.linux.dev"
recipient. You can add me as arnd@arndb.de to the Cc list
for reviews though.

Please also add a patch that changes the MAINTAINERS entry
to reflect the added arch/arm64 contents.

     Arnd

