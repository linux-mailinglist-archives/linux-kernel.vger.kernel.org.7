Return-Path: <linux-kernel+bounces-884521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89497C30568
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80514E5940
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52373115A6;
	Tue,  4 Nov 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GzoT4Eev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2K8E+iA"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15672C326F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249692; cv=none; b=cHnA1B/TXtySYHGo8RI+hp5tP9yIi+N9525MZo/VXtV3zzcNNEm5zxjP1mmkxNFYz/Jn1fDUHOVq98hjUHEnh6QWSonS98/noT4fC00rC/VyoOTl29985jWxyge7rg+dfzpLlQTVjKSR77eB67JVhAjIwhYwiox/7Tij5urRULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249692; c=relaxed/simple;
	bh=Ty7lZhpJuxhxUFjysDUxoPTqaw/nPN4m6M8eu+eJmNs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CxUbMcXREDJmIzXEvFs0u9yO18pAA5QmnX1gOlinOHt8Uu8N3fXbhsmFWvGMWFf31RxasoguT2MWjSr4E7vVisQNHTWY8P8oDGjByLKu82DR9MDq4+Evixe+eefS4XBI1O4GPz2xGIsfihTehVwMjL/oM+o+hbtIToOvXZT2l2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GzoT4Eev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2K8E+iA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C51D51D002B0;
	Tue,  4 Nov 2025 04:48:06 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 04:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762249686;
	 x=1762336086; bh=n1BAXzAX9RPHcdaqshdVhbypQiBs9UBoWuGQhhPWcHQ=; b=
	GzoT4EevArUIg/kIBP7edkKPCfPkCI4L3DL+JarfZ345doHB4zDH8g9wM2m3w7HY
	pOfJS/ETV+55jsaYL8PA20DmpctKCRSEsxaTkqrPKMMADnj1qCa5683/zzZdOwOd
	j+P8wn6Wh9M83YvI57SzUwLqbYAOdEjHxKdM5oKcH+kspVrCMcvorZyw8Qkp0LXk
	rC0LLA7NPnr3eaSKFEhcarZmY6mZzr4hbD2gZwlUsyimjb/wFzowiDd1lO0ihmVN
	KBODlFui1bVJzX4sdMWBJx65mAUwkDunSLTU7nSlnyeC2ifjkRrL0R1oVHmT1ofd
	+Pd+8ZYEICGsmxFjd7D+1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762249686; x=
	1762336086; bh=n1BAXzAX9RPHcdaqshdVhbypQiBs9UBoWuGQhhPWcHQ=; b=h
	2K8E+iAnthB9WMnRa9K/1i58P6C1d4Of+dbspxBTMis5XP1L7O8kbvJUcI5l/TLd
	zaom+fpuTYVr0HG3b3wTK629Sdzda9feP5dUDGmiSHqy0z2o8OuKgyuCt9nrB4pA
	A+wZX1I9xSKj2ojndPdDjPB+0TfP5qxVOoCQYKvazf5BvizKDJ9pbfc1qhKGmVcL
	dGajp8+60YxicC25aaptm2ZEALAJRFds8f73mgWy/lv6zU/VUSP8EW2iukbB5Dpf
	nS+O20GXT0wtdkkMiDKway5607IHijRjzjZy1hgHXNpRFhZdAJyCwbXvETvFDF4U
	/UENrrdhFokO4+19bnblw==
X-ME-Sender: <xms:1ssJafPn7xlafEgJPZ0In7gfoiNFJ2ZD8BK0dySYq4RvtiTRtzHiLg>
    <xme:1ssJaUzoHP_RBSIL9aXeyVW5Dv-XC1JtgPbhk9Eo9VgJ3TJ1gQbAMJgOzgrz1X1BS
    WjYcukVFNXiIdO451UdiwodIynUmt23aVt-NfpiekoMrQ6WvVVYkvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpihhnthhurdhpihhnghes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhhnvgifsghivghssehkvghrnh
    gvlhhnvgifsghivghsrdhorhhgpdhrtghpthhtohepshgrnhhgrghnrghkrgesshhiuggu
    hhdrmhgvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:1ssJae0RydBe5BaWWbGh_-HZB1z_2ubJR0F6518AOllMUgky4Ks4_A>
    <xmx:1ssJae6dU3EDDF4M_8K_Y94wUr11q-42OfExbMJByWXkWC8JLdJF0Q>
    <xmx:1ssJaRVIJwkUgdOq6Nd_IzGSGydbbMgga898c09rtgZznAfFUbEMkg>
    <xmx:1ssJadDcbigbodIWJMZEdDcgJXzdiAnk6ispoh1tXsz1Hdae6lvCug>
    <xmx:1ssJaQ7KofsVKsHwB5zQZ5864NbJh9FoKsvFo3EaEni0aoE9L8VvzoVP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 03D7A700054; Tue,  4 Nov 2025 04:48:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADbfFBy_oOaZ
Date: Tue, 04 Nov 2025 10:47:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pintu Kumar Agarwal" <pintu.ping@gmail.com>,
 "Siddh Raman Pant" <sanganaka@siddh.me>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-Id: <c40a0a35-ac43-4079-80ca-361bc8c9ae8a@app.fastmail.com>
In-Reply-To: 
 <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
References: 
 <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
 <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
 <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
Subject: =?UTF-8?Q?Re:_=C2=A0Query:_Y2038_patch_series_for_3.18_Kernel?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025, at 06:02, Pintu Kumar Agarwal wrote:
> On Mon, 3 Nov 2025 at 10:35, Siddh Raman Pant <sanganaka@siddh.me> wro=
te:
>>
>> Mon, 03 Nov 2025 09:57:18 +0530 =E0=A4=95=E0=A5=8B Pintu Kumar Agarwa=
l =E0=A4=A8=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=96=E0=A4=BE :
>> > We have an arm32 based embedded product which is based on the 3.18
>> > kernel and a simple busybox.
>> > We wanted to support the Y2038 issue on this older kernel.
>> > Is this feasible
>> > Do we have the Y2038 separate patches available for both kernel and=
 userspace
>> > ?
>> > Or upgrading the kernel is the only option ?
>>
>> Upgrading is a much much better option.
>>
> Yes, I understand, but upgrading the kernel on this older SoC brings
> more complexities, challenges and time taking.
> Customers also do not agree for the upgrade at this stage and they are
> looking for alternatives.
> So, we are exploring both the options right now.
>
> Are there any patchset maintained separately for this Y2038 issue for
> each kernel version to have a look ?

I used to maintain a 5.4 kernel with backports from the 5.6 patches,
but I would not recommend using that. Anything earlier than 5.4
is completely hopeless for 2038 because one would have to essentially
redo the changes from scratch.

Which chip exactly are you using?

     Arnd

