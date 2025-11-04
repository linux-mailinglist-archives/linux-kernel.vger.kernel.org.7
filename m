Return-Path: <linux-kernel+bounces-884092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0FC2F569
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748E83BD6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99432BE04D;
	Tue,  4 Nov 2025 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oSGjtgER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfn1So5a"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28061188596
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232935; cv=none; b=iEV7Q9JGhVt7ik1sKDqheAKfFzkyC5npeKv61Q1E2vBzF1XCiD+JaD6FFXdUcQJkFUgKRFNj9+cD9utJSbrlf1lT1/JORxKGu3tlTGTFjnVYOJazMJu7f9rxvIwFm+QFyFpuw5nNTyoEQmCLvjHZrQnV0MgoUnwSrDtOL16V2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232935; c=relaxed/simple;
	bh=YbLeGdsyFUT7OOMTO1Bya2H1KH3p9zoKns6Bpjel48c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l27TZN49a4twzNtCXy1QDUKkjAx3lpq6UPUdvMPM8WdzcOs4Qq782VT3gXl39m6ZRPuRq6np8m+SYsS5v2DQ0/c4pTzouHR1ILpwmW+FHQkW0osqjb024r2OPpEK3pLP06OIwRccbRxXg5duNHuCWKHgzqn518+AS1CZREp8/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oSGjtgER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfn1So5a; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCC827A0413;
	Tue,  4 Nov 2025 00:08:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 04 Nov 2025 00:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762232931;
	 x=1762319331; bh=LG9LhhmAdhRt4kpI1l4GWvyXAACukFsT4L51xylVFYo=; b=
	oSGjtgEREkk81lRNHXg9OdNFxtRHK8+88bjh6axlMYciHhWYVqfsiAFTmgBVtBXQ
	jy4J90q40oJhWf8rWFr+AYYUDz5BPTlW4/7Lh4ZKjMh3zMiXk67ICpUk94P0bvJ2
	Qr6usQXdyNp61LB2qzMc5jS28DR7hCWwPRNECGcdSYMn+sR+q9hsi05wsejRoxCE
	Vy8e+qJGVBdD0xCdU+6D1SG+gtN84QfqcIyxAITWBCYtG2pACgvLo8yusiHpQkvy
	0+suuxy6o7LVSW+XFFnb8yIUQlBjs8bh2IugWUAPtIVFc1N4chTyT9D6BoqrUTOC
	DcQ2TObulAyoXFeeYf4rYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762232931; x=
	1762319331; bh=LG9LhhmAdhRt4kpI1l4GWvyXAACukFsT4L51xylVFYo=; b=d
	fn1So5adKD0Y8pPNRieBX/2uJtUKLUk5J0DiOgiFmPXuFWUk4+nC33U2cT/tVXmN
	0QlFu5B/9/SmHOGth5AxXykCoNeD7IlQHbUBKeqLeZk68pX437KG5zEWqRWfu9jy
	9ZuP9bDVyA2CfAH9i8yGkBmkR6NUL5z9fh6HofcL9uNCInU032IJqjCyTMnWovPh
	H+vlOf68MG6Vn2zC2nRjBjdnwwHvnZAMkOcNTSE64cLIW2xDw3+KYjWSmFQv3jMv
	0gBnPJdUGo25sOOUARb6dbXUzYltZr+hG5OwUj9EtLEdZs9W1mZLPenrTxqdgHGD
	fmnau+RRRKc6kzMeRqWXw==
X-ME-Sender: <xms:Y4oJad7XZ3wQp0GPHyW9STEv38PTMExFq_p2TlQJB0zANeQYpYVusQ>
    <xme:Y4oJad9eRfl3nZDQ41YUaGkif5ReNT7WJgChIMIAvVjUp3qr7kVqpeZjGG7cRTqRO
    JzMuuTlIl-CXHLFV5256_trXQ1O2m_2IdEvHjYbMP9GzsnPDw>
X-ME-Received: <xmr:Y4oJafGWd6nin1mfLBgV0brZonoJRXAdM_dqfI4sosy7xSMEEZ3MKr4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgkeffie
    efieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpihhnthhurdhpihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehsrghngh
    grnhgrkhgrsehsihguughhrdhmvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdrug
    gvpdhrtghpthhtohepkhgvrhhnvghlnhgvfigsihgvsheskhgvrhhnvghlnhgvfigsihgv
    shdrohhrgh
X-ME-Proxy: <xmx:Y4oJaSVCtpYpHkp4Hr1BBwJ9VwkEKB53OT7k-OFIWkaAGl1JHS8xfw>
    <xmx:Y4oJab_Q445RiuuPlhqG57yzttxFYgaMMwZxwr1_umWj57jmRlpqKA>
    <xmx:Y4oJaf6LEVng2JKgi2SZp5Md0OoiocewomeLG9bvk7hIaMt67R5g_A>
    <xmx:Y4oJaUmR4YtDq4fwCdBWMSEbqO-G4ODfBUnuMjoJAbFFJFQ28Iw2dg>
    <xmx:Y4oJaesgNDOj2MTuYOXI5bmtpHmidx5pbGxtBTNR33pfeHL1iqqfLorl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 00:08:50 -0500 (EST)
Date: Tue, 4 Nov 2025 14:08:48 +0900
From: Greg KH <greg@kroah.com>
To: Pintu Kumar Agarwal <pintu.ping@gmail.com>
Cc: Siddh Raman Pant <sanganaka@siddh.me>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: =?iso-8859-1?Q?=A0Query?= =?iso-8859-1?Q?=3A?= Y2038 patch
 series for 3.18 Kernel
Message-ID: <2025110403-backward-skeleton-305e@gregkh>
References: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
 <19a481a7843.53422ba121754.4867625372707455852@siddh.me>
 <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>

On Tue, Nov 04, 2025 at 10:32:28AM +0530, Pintu Kumar Agarwal wrote:
> On Mon, 3 Nov 2025 at 10:35, Siddh Raman Pant <sanganaka@siddh.me> wrote:
> >
> > Mon, 03 Nov 2025 09:57:18 +0530 को Pintu Kumar Agarwal ने लिखा :
> > > We have an arm32 based embedded product which is based on the 3.18
> > > kernel and a simple busybox.
> > > We wanted to support the Y2038 issue on this older kernel.
> > > Is this feasible
> > > Do we have the Y2038 separate patches available for both kernel and userspace
> > > ?
> > > Or upgrading the kernel is the only option ?
> >
> > Upgrading is a much much better option.
> >
> Yes, I understand, but upgrading the kernel on this older SoC brings
> more complexities, challenges and time taking.
> Customers also do not agree for the upgrade at this stage and they are
> looking for alternatives.
> So, we are exploring both the options right now.
> 
> Are there any patchset maintained separately for this Y2038 issue for
> each kernel version to have a look ?

Nope, sorry.  Please just update to a newer kernel version, that is the
only way forward (and as a bonus, you actually will have tens of
thousands of bugs fixed on your system.)

good luck!

greg k-h

