Return-Path: <linux-kernel+bounces-730438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD7B04489
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60261AA1C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4E25C70C;
	Mon, 14 Jul 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OF5XC57g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mrZeo//K"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031A258CED;
	Mon, 14 Jul 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507618; cv=none; b=SPCU2bnkmyfb/cnpf4+t+jvdyD10F7vN7KrVbEvcAeu/TeX61uXf/r4wIEzIx1pBEVFHlx7sg3gYKkHuLtDtX8xPSOql8gRxXT9Uq85Er0xoqJ8tGSbHuApU4yyCuB36XNaZQaBufA5EYx2F14HSe24rKTz6t8kDAcKYYefIMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507618; c=relaxed/simple;
	bh=Huej0xIdlMdw4KGCDq428Bx1DZB2HN0IfmvOrp4uF3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEISKdlq89Z0KUwK7ILFO8zCt1FrX2bVDbHArVPKoHMg4bdF3FVrv5OsT6RoEZY403SZc8Ild68VddAXM7VGWZZSGqy1cmE8fbkkwIasSQl6nYIB8JC4XrgA+M/5zg4lynu1l5lAGrYg4adwTJ5fgAFND71/b/Oj5o/Lnnzlg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OF5XC57g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mrZeo//K; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC0C21D002FD;
	Mon, 14 Jul 2025 11:40:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 11:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752507615;
	 x=1752594015; bh=0njB26qrHgHgqgJhixVMK11C5AVnOvF5avutan6EoGo=; b=
	OF5XC57glEJXYXFhmhLebcZ3wXlVdszeqaxgdQOjNlpcPyeeNZVSaAiWws1IyU63
	BSgL6SZMVBmNZk6Tr8619klxaRXS/Dyl0cMCqfTHokmmaQ2P21Lb7GUM7lnBGq1t
	1D5WgbFpfV1QMg/ZlK1a/q5LDXozabWKAilDOLwnwYZx9ZnZWORc2hqiKW23Lgd/
	I8h1qkpiTSmtjGepf5ulVeVLoGsLLpsUJvT7gj7FXxwlydswepAjNKkfiqJgtl3t
	NB+p/5jcwIXrEKq+0hV9EvHu/WiK5ZXSKLezZlYsZ1U+VXFZ5zOM5XPao5mYxprh
	w9p1ByZOqkD0tQMWdSMJwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752507615; x=
	1752594015; bh=0njB26qrHgHgqgJhixVMK11C5AVnOvF5avutan6EoGo=; b=m
	rZeo//KtPwVCOwy3s8kprUGhEkNgPVD4OBA3/UpzJx+Gw6obGDPZPeYmgbq92m+G
	C3iXV4T1D5g8cTwQkw6YuX22l6GNF9KVwFH8FA/w7xeHESy3JIt0L9znkgaZBtw+
	uRwowS6wJ3ckaOmwXVlt1JTGinvwqhboyzUDmYSX55HTyARgwxOlyRCxM22+Grz0
	8SN/VLrZ7VvJJHvXQTZ+w3ZlQwfFU/2LQRo5wkTwzoOAumMQUR4vrJXsa38ycnF/
	5c23/DftYRKbZ6tkArDMOe7oqgk+/g4PsyRUl9uhC7p++QhXLFfkPxvNcrDNf8nU
	1oNB3QARdYhmF+AZR8L7g==
X-ME-Sender: <xms:3iR1aJ7l36q__p0rLR44gcyBWQWywAlXplWWcLI677KMQfKwE4iw5w>
    <xme:3iR1aG7UPuNcgM10Iu05vD-OuMqCxLBJleYTJ4bfEUHkdV5Es3AdpzD3rgFuvhz6E
    PKTtQO4nHu-mtV9CTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehkrghjvghtrghnrdhpuhgthhgrlhhskhhisegrrhhmrdgtohhmpdhrtghpthht
    ohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhihhhurg
    drlhhiuhestghigihtvggthhdrtghomhdprhgtphhtthhopegtihigqdhkvghrnhgvlhdq
    uhhpshhtrhgvrghmsegtihigthgvtghhrdgtohhmpdhrtghpthhtohepghgrrhihrdihrg
    hnghestghigihtvggthhdrtghomhdprhgtphhtthhopehguhhomhhinhdrtghhvghnsegt
    ihigthgvtghhrdgtohhmpdhrtghpthhtohepphgvthgvrhdrtghhvghnsegtihigthgvtg
    hhrdgtohhmpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghrrghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:3iR1aMIYv3JQe4Szc-JpjSetEI22ercdeg7Rg3WKmQi8TSg82drXKg>
    <xmx:3iR1aBr2EuXj6BHAWrP9-ZMTPoOPz7FEMmxuxlnAtu_IvQzJASdyPQ>
    <xmx:3iR1aFC8QGCi3Q93WpKOe0BkAyHpwoodEcEK6VsoJUh_oSdpMIbLoQ>
    <xmx:3iR1aHfNNrrwQ8XGsJX9FqbViaqkJI87ZuEYy2zexTesDSDCMhshJg>
    <xmx:3yR1aFZPDnM9fRspzybccfJdxEECJbb7EC_ExvL3vIH0x88d7sGGVA2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BDFED700068; Mon, 14 Jul 2025 11:40:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7a47ae1d7bea40f2
Date: Mon, 14 Jul 2025 17:39:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Guomin Chen" <guomin.chen@cixtech.com>
Cc: "Rob Herring" <robh@kernel.org>, krzk+dt@kernel.org,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Peter Chen" <peter.chen@cixtech.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, "Marc Zyngier" <maz@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Kajetan Puchalski" <kajetan.puchalski@arm.com>,
 "Enric Balletbo" <eballetb@redhat.com>, "Gary Yang" <gary.yang@cixtech.com>,
 "Lihua Liu" <Lihua.Liu@cixtech.com>
Message-Id: <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com>
In-Reply-To: 
 <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com>
 <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen>
 <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025, at 19:00, Jassi Brar wrote:
> On Tue, Jul 8, 2025 at 8:54=E2=80=AFAM Guomin chen <guomin.chen@cixtec=
h.com> wrote:
> ....
>> > > +/* [0~7] Fast channel
>> > > + * [8] doorbell base channel
>> > > + * [9]fifo base channel
>> > > + * [10] register base channel
>> > > + */
>> > > +#define MBOX_FAST_IDX          7
>> > > +#define MBOX_DB_IDX            8
>> > > +#define MBOX_FIFO_IDX          9
>> > > +#define MBOX_REG_IDX           10
>> > > +#define CIX_MBOX_CHANS         11
>> > > +
>> > if it is not really a single controller owning different channels,
>> > maybe implement only what you currently use.
>> >
>> As mentioned in the previous email, a single controller can support
>> multiple different channels.
>>
> OK. I am not too worried about having all variants in one driver esp
> when it is manageable and share the code.
> Unless I am overlooking something. Arnd?

My main worry here is that the types are all quite different: while
the doorbell and fast mailboxes are what a lot of other drivers have,
the FIFO mode does not seem to be a good fit for the mailbox subsystem
but instead looks like a more generic firmware interface with variable
length messages.

For those, I think a higher-level driver with fixed data structures
passed through the hardware interface seems more appropriate.

Are there any other mailbox drivers that just use the mailbox to
tunnel variable-length messages?

     Arnd=20

