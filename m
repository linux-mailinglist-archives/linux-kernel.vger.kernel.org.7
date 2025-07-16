Return-Path: <linux-kernel+bounces-733013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8772B06ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4796C3AEF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4D289355;
	Wed, 16 Jul 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eiLuMd7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9nxkfR2"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA027146F;
	Wed, 16 Jul 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650420; cv=none; b=j9jmMc94Cv5pq9wt53pLAhLpgE4MBeZstPOrHkTBRFIfEyeuZAGD+3S+786bp92Kq9td1+488lfOjkqTXEe3V3aAfQrBNhI5mztQEbcivqrD8AvhfdbUANr85RxY3moByKSKHXrLooABOL69/gIjf9G9QGjEJYuqK6+L4hqZgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650420; c=relaxed/simple;
	bh=bCqm1JQ8BzHWO/19xnRKH+MHKhEeGYtPhPvPJ6ysZXk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V1Vm5tlNlk03NMz8ENWuhj8qXJPijylHJ2wDcFQqplTq7G+7j48rDt3mKyfK0Vq005qyzjlEx99EJ8muFGGZm9I/+UJCwZZQwUHPU/addh0x8GPOzxtabTJc7Shztvf7xRcLp3eWn7+UwLakIvRkZe+ICiaJC0/FhwcoFWMf4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eiLuMd7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9nxkfR2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67E6B7A0104;
	Wed, 16 Jul 2025 03:20:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 16 Jul 2025 03:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752650416;
	 x=1752736816; bh=xDPOTNSSMo7Pg2u9+65PzrX1Xg4eEK8/iy5Y0t9SCjE=; b=
	eiLuMd7S7yw/TMDahWZt3fOI9Unhj4OJ8lAm6OOOxkPkpnuZ+LR/t4S6BGmU3bk5
	FkVxDVjxLsLRAtSGHH5P6TcuBEn8ZHhbv5bmVuG0LafprulBVCJCCf1lbluKo/VN
	VuapCe0KPfCMHVfjkO83e9x5W7LtHzmCdIrlUMtVRXGuPvz2ZGhASXiexzOw0bV2
	0lne09ZpMsZXTyN3PhbqQv0qULz37svLLCL1N8FI7kQysBldshIAXfnleRlqyE0D
	417qF3IdfflHvC1fRTx6b5bLc4Or6PUf3ONNkjDy55cdcguLCzf0AXdkEZes2mjO
	SF0j6OBOIza42hKaaYAtHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752650416; x=
	1752736816; bh=xDPOTNSSMo7Pg2u9+65PzrX1Xg4eEK8/iy5Y0t9SCjE=; b=i
	9nxkfR2mTlKZA4I92n7lU9nzoibkybWS2vekJ9T2s8tjIVoTskjLsi6kjwlGSOmb
	933Z1NFqZK391vm+jtbSAmXXYdXe6eACrPzyTXeTaJNlxEZaJtiykgGwf5Jp+Q7N
	c48iZbdvnrpJtA9m3OUOCeW+pXkUNvIqZDm7+3YexoFlym3shqrf1VAW7Ck12oJb
	ea6Si3CadVMf5tF7Og2fx4nxhawE7q2I+BJzov3R2IOaGiEQv+VGtu9gDEFGIgtm
	42ppn5PFfn7W/RgAkGgWUr5k/sQm7PSfQWLQta5zfxxFnnGQrLqzhkM7UCYTSBAi
	ZNNiu8aKbFIaznDFgdzEQ==
X-ME-Sender: <xms:r1J3aG4eE6rKCu5zLBvI81Z42dTpixfTGHg08UERtRcZb3BTf9sX3g>
    <xme:r1J3aP7k2FC1nQfgm0wNee6h34hiR90m03-dIqwY_kSCI9p7LQnQfAgtnsAISJJT-
    8k4P-yKZ6SAvAhVplQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedutdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:r1J3aJKay1d4U4uptBXNC1n3DgEVZnhN1VUQ35AKLV3DabJE_dFbVA>
    <xmx:r1J3aKobx7OhfTVleQNYjtTWoh1h6_oJHmHNdWQfLyX2rh-eXYOCcg>
    <xmx:r1J3aKAadL3cGudVfWBPJDCXPkDGQIEhhLGaZsq8FI7IORkhPiVcsw>
    <xmx:r1J3aIfVkeFfwa-yKoZE2B5zcQOhMNpi9ZZkAhcV2sOuMyRYn2d0lQ>
    <xmx:sFJ3aOYhWM6pIzV2MhB9FJ5oGBpTbzRz7csmuaBDjexYbgYytsscoRaF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CC53700065; Wed, 16 Jul 2025 03:20:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7a47ae1d7bea40f2
Date: Wed, 16 Jul 2025 09:19:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guomin Chen" <guomin.chen@cixtech.com>,
 "Jassi Brar" <jassisinghbrar@gmail.com>
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
Message-Id: <8365b672-49d4-4ed3-a3e0-53a11c20fe7c@app.fastmail.com>
In-Reply-To: <aHcOaas459jctIB2@gchen>
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com>
 <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen>
 <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
 <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com>
 <CABb+yY26R_DHQUhpg-xUR_Z7EnjdR_4LPai0M-vfFTAOZy=vvQ@mail.gmail.com>
 <aHcOaas459jctIB2@gchen>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025, at 04:28, Guomin chen wrote:
> On Tue, Jul 15, 2025 at 05:11:01PM -0500, Jassi Brar wrote:
>> On Mon, Jul 14, 2025 at 10:40=E2=80=AFAM Arnd Bergmann <arnd@arndb.de=
> wrote:
>> > My main worry here is that the types are all quite different: while
>> > the doorbell and fast mailboxes are what a lot of other drivers hav=
e,
>> > the FIFO mode does not seem to be a good fit for the mailbox subsys=
tem
>> > but instead looks like a more generic firmware interface with varia=
ble
>> > length messages.
>> >
>> > For those, I think a higher-level driver with fixed data structures
>> > passed through the hardware interface seems more appropriate.
>> >
>> Yes. But sometimes when the data structures of a protocol are not
>> bigger than FIFO depth, the platform may choose to use the FIFO mode.
>> I see it as platform dependent.
>>=20
>> > Are there any other mailbox drivers that just use the mailbox to
>> > tunnel variable-length messages?
>> >
>> From a quick look, Armada 37xx and Hi6220 have fifo though they fill
>> them up fully for each transfer.
>>
> Yes, both Armada 37xx and Hi6220 support FIFO functionality, and they
> fill the FIFO with each transfer.=20
>
> Since the cix mailbox hardware supports messages with a maximum length
> of 128 bytes, different clients transmit messages of varying lengths,
> such as the cix DSP using 8 bytes, the cix sensorhub using 12 bytes, e=
tc.=20
>
> Therefore, the cix mailbox driver has been modified to support variabl=
e-
> length messages of up to 128 bytes. This allows for more compact and=20
> flexible support of various clients.

Thanks, this makes sense to me, and I have no other objections if
this is an established way to use the subsystem. I wonder if there
is a way to abstract it further though, since it would appear that
the same thing should be possible on any device that has a FIFO
to buffer more than a single fixed-length message.

Jassi, are there any remaining issues on your side that need to
be fixed before merging the initial driver? It would be nice if I
could merge all nine patches through the soc tree for 6.17 if the
current version, or a feature-reduced variant of the mailbox
driver is ok.

     Arnd

