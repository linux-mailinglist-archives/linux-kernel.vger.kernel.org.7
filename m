Return-Path: <linux-kernel+bounces-832132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996BB9E6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA8E323741
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38C2EB867;
	Thu, 25 Sep 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tmFP1VyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KeVlOMsR"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E462EB5CE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793013; cv=none; b=F4pwSDB24pQXyhYMa2kGs71ylJCMLxVa2Q4226/BBzDln4WtmUFzC5eGC1EEKtFNiqAlL3gKaMNVhgMOIJSnziolGjBCWxLhTha6e5WhbLKN75PH5MZ8imEVGGWoxlt7Jm87J5XtgTtHNlytZoERasLTQ1orjhAFXBOGqzuqzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793013; c=relaxed/simple;
	bh=vNAYBxnr1rtfWxNEyWcNOUT/gJce9aNoyWsOizz/73M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BqHtsh8yjpejeNsRa6ZSo4/qHSv2IgV1kVmWWuQqVo9lgnHm+UeTshBwwOwU/0fjlD+vYsyUnjKV8UCIUwJIe/jTT8EhOYzjCMFJLKRTkGF7XL5aqxD70Rh5XZuFhE7mWVafd/YSuISJvTosXcoC2/low1xaMRsxnM/GQvd1DA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tmFP1VyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KeVlOMsR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A79637A00EE;
	Thu, 25 Sep 2025 05:36:50 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 05:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758793010;
	 x=1758879410; bh=DQI2mZ/kp5vlo48ZxiYX2pfbIeGq8uKbBkUOlhPmIM8=; b=
	tmFP1VyJ4W+hvcoCWm/Cre7Ygpmi66Bts8vg1frdkBETO/inExVTuZPxq9keBfdc
	tFbS+2933OzcLZp/yt+1QfX1zas5KYAZylPdOz7nrFauYxbrkVx1p6WYDTi4LshA
	T92TgdgBZdR/kdZL9Is0D8MRUatejwtZpduAJClA3tiK+lVQIwqhVi6U17TcmSTC
	tDcCeMldka02wl6bFYT3l9XTcxhaHqKtObBl0erK8yobEZHGezXGuMk1brxw1baj
	WIateM5v9RCSUHxiNl9Doa4DHyvXyGSiIfKqA7o2Mc3Q5IOKXt6xR62AxtNU7iXj
	NvDsMW/rhQcF+nMrpit3Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758793010; x=
	1758879410; bh=DQI2mZ/kp5vlo48ZxiYX2pfbIeGq8uKbBkUOlhPmIM8=; b=K
	eVlOMsR7NPBr/dP/wzFF1S7fSL0ASH1+cD9Zgz/ZSCPAYc4lU2l+CrnQPomQCqAc
	rg3sol/DW89emiBJl1xfg3mh5X0ku6ZajuZ4Ek+hTdimY4L77hdqD5Yhxedqw16J
	6Y0FiQ85c60v8D0ydqvzZOF38upwUx1phNB+n+JZUWTXMSSAfzAWqVEQ8cJ5BYLd
	uYokMd2nzMEuEkImS/rt6aWx3rFtIAQhB5ccLa/r4nqj1sjpZYqdASmnvkEUNygR
	wo3IBEh7SW6X/UV8pdeKVVypuzP1oruO49gVa/diqo09F+4ZbWUsIT0SC53VX6so
	z8nI4Cqx0SfYedrYfMSeg==
X-ME-Sender: <xms:Mg3VaBgrN5xkPVagTu-YQdlrWeEwITVJLTOzt7I849DKol8_Y5QVGA>
    <xme:Mg3VaA2943kXYbxt-E_eVbkrnwS5EAwDDga876p6DcocW3fttOXJnVW2TF8HJ0vBf
    -V0fSoRIBDhwHF0Gwssg94H8EhlTF7VLnpsBC6K52DMiLMDbiIIyGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiiedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesrghmugdrtghomhdprhgtphhtthhopehmrghnihhkrghnth
    grrdhguhhnthhuphgrlhhlihesrghmugdrtghomhdprhgtphhtthhopehmihgthhgrlhdr
    shhimhgvkhesrghmugdrtghomhdprhgtphhtthhopehjohhrghgvrdhmrghrqhhuvghsse
    grnhgrlhhoghdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgsvghllhhonhhi
    segsohhothhlihhnrdgtohhmpdhrtghpthhtohepghgrshhtmhgrihgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehnohhnrghmvgdrnhhunhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:Mg3VaDZB9Z2WxWH5VYaeZpDNlNoqYUHgw0luW3L3F4RToJciWasHAg>
    <xmx:Mg3VaKgZyrbS_mtdfwSpyRUD_Mugt8vI7zXl_UuxyWvimUBiresUVw>
    <xmx:Mg3VaFfqkocqinYdHaRHWgjQ60W6nzWsOL1nkWJMONU5VxLIq2cZkw>
    <xmx:Mg3VaJlvtoSWK7gAzde6zyrnPvo9hU9NytsryfyjhKjo549ptWm73w>
    <xmx:Mg3VaA6SmQUc3wgQFg1VnV_VX2DgMepLmkBRfIYyW23LAS4jHpC3wtZ1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18B48700065; Thu, 25 Sep 2025 05:36:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnQDLTKpvobg
Date: Thu, 25 Sep 2025 11:35:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>,
 "Jorge Marques" <gastmaier@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Jorge Marques" <jorge.marques@analog.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Frank Li" <Frank.Li@nxp.com>,
 "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>, "Michal Simek" <michal.simek@amd.com>
Message-Id: <91e73a29-96e3-4a52-addb-0cb954f46c04@app.fastmail.com>
In-Reply-To: <e5a6789230840b31ef0f60ca0a770a4fb266da2a.camel@gmail.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
 <DM4PR12MB61093CEE50990ECC403D3FB98C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <e5a6789230840b31ef0f60ca0a770a4fb266da2a.camel@gmail.com>
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025, at 10:58, Nuno S=C3=A1 wrote:
> On Thu, 2025-09-25 at 08:47 +0000, Guntupalli, Manikanta wrote:
>> > (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>
>> > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
>> > On Thu, 2025-09-25 at 07:37 +0000, Guntupalli, Manikanta wrote:
>> > > > i3c@lists.infradead.org; linux-kernel@vger.kernel.org
>> > > > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
>> > > > On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
>> >=20
>> > I would argue that's something for callers of these functions to ca=
re about.
>> If each I3C driver has to handle FIFO endianness individually, it int=
roduces
>> unnecessary duplication and overhead across drivers. Centralizing thi=
s in the
>> FIFO access helpers keeps the logic consistent, avoids repeated boile=
rplate,
>> and reduces the chance of subtle bugs.
>
> I mean, that's what spi and i2c drivers do already.=C2=A0With enum i3c=
_fifo_endian
> you're already forcing users to care (or know) about endianism so they=
 might as
> well just pass the data in the proper order already (not sure if it's =
such a big
> 'burden').

Can you give an example of an spi or i2c driver handles a similar
situation to the new i3c driver? As far as I can tell, swapping
the bytes in a FIFO register is very unusual for a hardware design
and probably a mistake rather than an intentional decision.

On the other hand, I can find drivers that are obviously wrong
on big-endian kernels, such as Tegra's i2c_writesl_vi() function
being unintentionally swapped from i2c_writesl() on big-endian.

For the i3c helper, I think Jorge's current version with my
fix should work for every normal driver, and I would not
want to make it more complicated for an obscure case. The
version for the AMD driver can just be in that driver, or
it could be a separate function name in the common header
if there is a chance we'll need it again.

      Arnd

