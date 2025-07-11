Return-Path: <linux-kernel+bounces-727845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19BB02092
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71C1761980
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823042EA495;
	Fri, 11 Jul 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KHkJZu4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0lHAQ2s"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC32BAF4;
	Fri, 11 Jul 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248225; cv=none; b=up5m1mQndbbwAMsunhsi57qMkixUm0CpNnS1+k4He4rzkv/47gnDisMJhdhbiydpWV4JoJkGreWxtygFttzjSylcrhBEVUjG3OMV0G2MSrXthsc9MvKQ6pKSVKVRBU0GDTXe7djzcAwMX8FiwWaWpSpNiul2o+j9poqK2sm7OAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248225; c=relaxed/simple;
	bh=fpWVXr/dZgI5zKMUuLYxtAo5ZnRqSqNa6Kjnysl9aTY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kvw0WTAQIhLOJKVWdeWFnFiBuLdi4BwPsWGhVOOTXRU4Rhsrxjj3JOgs6aLME1JyTqH7xqhvj2pSyysRZ1S29hRVLeT4yYNluy3vyApR9QPRnmOoaxun8ZZ6yY2FP3MonJxhS6paVitcmbH8+h3s7C/yhJdReT7pltt/N7QM4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KHkJZu4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0lHAQ2s; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE8CF7A01DF;
	Fri, 11 Jul 2025 11:37:02 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 11:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752248222;
	 x=1752334622; bh=RjeYRg1RON0Z6P8SpPi8zDMOS6hH6xY8E4OI83ncSM4=; b=
	KHkJZu4zHyCUCUG9i69KN215Z1CapklgQ1neIS3OfT4u55udrsCBTUNJoS4I5glk
	KNrdwJrY+XBmr9a7RzgeNTlLiCh/MG3P07B2j1j7XBwtMGL9iZBekFBzp0SEzPfH
	zOKNCABpfYxHO9XBg9jQfA4+Qn2PLoWYHaY7FAn3E562HL137PiVyHBdV9okRLud
	rgASgoz9E4zLGqBJdMUUXaufW0/kcoPGE1w+B1TEdDnPIVNWHZolPiri/f34lRVs
	U+Ah6UP6QT82fYVNLPqxl1Ag6/Gyw4v7Aa6zvY2kmHf70Mh/F+HgWqEjORAJuBpL
	mNGN2tUZ49DNiDMbWNTnHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752248222; x=
	1752334622; bh=RjeYRg1RON0Z6P8SpPi8zDMOS6hH6xY8E4OI83ncSM4=; b=V
	0lHAQ2sxBG6SnHFfd55fvwq1xG/RcLEASLGtUziLDS1stGiST/5tDepnF2Xc7fvo
	kJG7AjN4HUKGdHbQJZ5Q44HEWD3hVgP1cZC8nC4zy2HCweqiZAd+c/7zlw8WY8i+
	Yd/zbn7THaqtCdV65e2teKImf1VuWG+XucZwETotC6Qu+joQfZaf7aB7Sl9dXpFx
	D8DDBS0leL6jsBrRIk05d5ywvYBaULb0ZAzK/r5T1qk8G/VW4swpj1QD2GZ9c0Sg
	sRJZKCm9L0UgheOacokEfj9U1fFZ8CJx0aD838fCFa1ZgzPc6g/sfJ2uImwQEq1a
	VvbKGk9n6N8sNuTh4EqqA==
X-ME-Sender: <xms:ni9xaFAv0pZ9g3UNosTqEBKwfE1B2tboFBpdDtNcbiiCfY18fM1Qnw>
    <xme:ni9xaDghtlOzcQCucGEYCoAHn_DcoCzdZNsilKQCQRIlkvgdxbN6e5lbnWbI-jIF4
    dXGDBsgaUVDCrIbdI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprh
    gtphhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepfigprghrmhhinhesghhmgidruggvpdhrtghpthhtoheprghrnhgusehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlohhkrdgrrdhtihifrghrihesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepjhhvrghnuggvrhifrggrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmphgvrg
    hrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:ni9xaOCdpxe3bgfz_yQl8-pCkDq5Bl018U_ib8W9vsMI6-Xckeme6w>
    <xmx:ni9xaKG1Y6ehGtN7ov5UD0mL_BDsxz_4MCWdzztpM3HVYhULEoQWiA>
    <xmx:ni9xaA2SmS9IiDjuZqx-LJcnQh56u29SHbO7YydfEMQWvfgxOR52gA>
    <xmx:ni9xaDOvlVIk4HlSjN6tV5U6GaOzt26eD_MkKm4LKIttUM2afe_wZA>
    <xmx:ni9xaGfdkmum6sVoN0BWutqAImtIlVMplTPjy4puBre9lFqVdHBBq-FG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C1CD700068; Fri, 11 Jul 2025 11:37:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ae3921a54d7a46d
Date: Fri, 11 Jul 2025 17:36:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 "Hans de Goede" <hansg@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>,
 "ALOK TIWARI" <alok.a.tiwari@oracle.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Jelle van der Waa" <jvanderwaa@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-Id: <50756008-cd04-4e73-9552-52b80677b8b4@app.fastmail.com>
In-Reply-To: <ffd00f91-6569-714d-29dc-65c14b64d914@linux.intel.com>
References: <20250709151734.1268435-1-arnd@kernel.org>
 <dd727ab6-a754-77fd-5876-fec076c8905a@linux.intel.com>
 <fd1f6732-e091-48e8-90c9-4bc18aface58@app.fastmail.com>
 <ffd00f91-6569-714d-29dc-65c14b64d914@linux.intel.com>
Subject: Re: [PATCH] platform/x86: lenovo: gamezone needs "other mode"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, at 17:34, Ilpo J=C3=A4rvinen wrote:
> On Fri, 11 Jul 2025, Arnd Bergmann wrote:

> I think I'll take this patch but change it to still keep the other sel=
ects=20
> as wmi-gamezone.c is directly using those too anyway.

Sounds good to me, thanks!

   Arnd

