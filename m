Return-Path: <linux-kernel+bounces-815213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2BB5614A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8AD7B7A68
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C42EBB81;
	Sat, 13 Sep 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AkuxGq7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="loUPyhto"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9D3D81
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771603; cv=none; b=qLqYGbTD7aFNRDotLgV1KYKl6fDqgeffBYSury4di2FHcr9WS7laWNqfuw6unE7BZnj0VaOCO+s02NipJm9eZoUtohZicJeGL1V1nx/PL4kIPynUNL2URJY+knHsdQH7buKp2NCA+Yla4l+Lu6l64VXZsrvHVywCLGPmrWclsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771603; c=relaxed/simple;
	bh=+h3xkYAwkb6oyWgSwdpststNjCpd5puIo86iwh0OWg8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dC5iM4Y66IEK+Gu+ILjQur42CkbQ9eGuPqPsVXArVv2GWcJlyj8A1C8tWIy8hDQbhKWNRhPPrs25GtpV7lgjBeB1iYlVAY57a3BNLlDVHTkxJ6SFJ2bA/D3DqhSsQ5H/gCRUmAVG9vfpIIXjgfO2B0SIDo2VcNTfiKIwb9nlLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AkuxGq7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=loUPyhto; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A6807A0096;
	Sat, 13 Sep 2025 09:53:19 -0400 (EDT)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-05.internal (MEProxy); Sat, 13 Sep 2025 09:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757771599;
	 x=1757857999; bh=d5lllfBWpkvhbNBBFkWW6ZTCvRDM182jtFLya47zQwQ=; b=
	AkuxGq7AmrBftIoxxIej8BUeyCAcJG1Ymi9BYw7QKl5ttox4BOV65pbqJ9if+E1w
	NUCJlc66mqTN5ToFVlKzlQ+jqZwvUluixJDuocP8B7RsOmuQCIAx6ugTX/jdjxMs
	qcdigYpWpZ7CYM5WpAA/oX4qU0BEd57m7cGL+Ejp3uxnmFPSf30VvoTJXv+p/I4i
	BAia8xzyYO2kQKUg0Y/KloaRtK6yNQF1mrVk62hMsonvauj2v81sKv3GvXMO4J4K
	T73/GPZAyceH+HLAYUikLZJG8qJkKQ5qKRAXrGV99M7ZeQ5YuQ5GhgtcCBk3+t6t
	BsOxhsu93obeMGRjVA5gkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757771599; x=
	1757857999; bh=d5lllfBWpkvhbNBBFkWW6ZTCvRDM182jtFLya47zQwQ=; b=l
	oUPyhtomykpWaNzTOdArnwQLEKmzKcw+tg7OxeJ1cV0wZtzzbKa0+YCd8xzVW2/+
	wNeoNZCVBKHbuWLCVzrzjq39hpI+s2CvjhVfUg6Mx7EqgnmEbW2LGlb/ItnGHRGd
	b7yKNcwvvZysyeO5Q6fqVZ3+799e+uuHjqktyhvaJpB+gDi/yBDs/MdyrDJoZkgJ
	Mh6AEdM2GH5ecP3m7RFWZsocS97aBFNytu2IMxL2gn3uK4KiBh6YmBoeyQZ5KPK+
	trZY2d9ky23sUQpX0FmgVDUrLzOE1B4VSuaZYs8e89DqSjCrQbrqLT1ZGivk2sUC
	RN/UaQI1qhWFDJaJiNRMQ==
X-ME-Sender: <xms:TnfFaCrtr16oqbECbxj_4ca4M90MxSd3_ZcdfXuNTbkW1hRzb05eCw>
    <xme:TnfFaArTqbaQfx7GoOHJwMWVNNdXdC04gpmo8vT0cbbn-t1DHAqb1EtK_V727rP02
    YGoA8ZLRHxvZsAcCfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupd
    hrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepohhf
    fhhitghirghlthgvtghhfhhlrghshhihthesghhmrghilhdrtghomhdprhgtphhtthhope
    grshhhsehhvgihqhhurghrkhdrtghomhdprhgtphhtthhopehlihhnuhigphhptgdquggv
    vheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgifihhltghogies
    fihilhgtohigqdhtvggthhdrtghomh
X-ME-Proxy: <xmx:TnfFaMO5aQej02tLae0TqDFyjE0Fo2G3lNTEmNXdfq3VRmvHeW5jUA>
    <xmx:TnfFaP4HOhIFMqSmh3Bd8_agKhw57LbwAcivjXW6IJqexvVE3oLJhw>
    <xmx:TnfFaO649Pzb3ncpbNCaB0YaFXMGBlfcl6ox12PMceC85AeX2-vFJw>
    <xmx:TnfFaNEf_5mogRldKoP-IeY-z61E1RdEQcAo5WZr-V5hE-NTB547hg>
    <xmx:T3fFaLMeigsrZbMYxBbjKm405RmxLMYlK-2Nl69pCWSdRc5uqqPZEqNz>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4216CC40071; Sat, 13 Sep 2025 09:53:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADclxERWIs8s
Date: Sat, 13 Sep 2025 15:52:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ash Logan" <ash@heyquark.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 officialTechflashYT@gmail.com, "A. Wilcox" <AWilcox@wilcox-tech.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>
Message-Id: <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
In-Reply-To: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 13, 2025, at 12:53, Ash Logan wrote:

Hi Ash,

> All of these are flatmem devices, as that's all the 32-bit PowerPC arch 
> supports, with the Wii U additionally enabling highmem for its 2GB of 
> RAM. Both devices have a small memory area (MEM1) with the "bulk" of RAM 
> starting at 256MiB. The Wii U in particular sounds like a candidate 
> system for densemem - I would like to read up more about this if I can, 
> I was only able to find seemingly unrelated information about CXL when 
> searching online.

I would not expect densemem to make a difference, at least if we go
with 256MB chunks (the size has not been decided, and not much code
exists in the first place).

Like most other machines, this one is probably fine with a combination
of a custom LOWMEM_SIZE setting and using zram-highmem, even if we
end up removing support for highmem page cache.

The smaller devices are probable getting problematic sooner, 96MB
in the Wii is already really tight and this only gets worse over
time.

> I know I'm talking about hobbyist use - and mostly downstream use at 
> that - and I do suspect that in the event of a wider 32-bit deprecation 
> we'd be fine on the final LTS, whatever that ends up being. Still, I 
> think the Wii and Wii U represent a decent number of 32-bit users, so I 
> wanted to add to the conversation here.

Just to be clear: there is no general 32-bit deprecation going on. When
I talked about phasing out 32-bit platforms over time, that is purely
going to be those that have no users left, or the few ones that are
causing more work than they are worth. E.g. The ppc405 ones got
removed recently (after many years of discussion) because they were
making ppc440 maintenance harder and had no known users.

Highmem does get in the way, but unless more -mm folks make a strong
argument in favor of removing it all, it's more likely that we'll
go with Willy's suggestion of keeping highmem on page cache (anon
and file mappings) than just keeling zram, and even that would
still work.

     Arnd

