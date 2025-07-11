Return-Path: <linux-kernel+bounces-727815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2175B02015
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650301C455D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9E2EA473;
	Fri, 11 Jul 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="czGel3h9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY5YfeOS"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7322EA14A;
	Fri, 11 Jul 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246596; cv=none; b=L3eI7WlhcyRY43r819bVjj01zdynqJuAsocMOFZ7Jdt9NTaZt1B14JUthOuOCS/DwsnpzfNprl65F7Hfbz8TiCmFihV26OxfLpyhtaaOUextssAgr1KwKrws1EIwEeLzl0pVdaPGd8f64VaCquBiNH3gC82B4y8qtXKLWGuLMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246596; c=relaxed/simple;
	bh=MxY5wb1Wm7B8Y9ml5x3ht5huqYB4JZeNQxI4DeCUQ4o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jeVVxO+0UJlnNG7RYIwCiUzVTNrdZUfQNlsMeT1XILj6uiNih5GGljWZXivLYV9t19Np3JKIB3sS1TX8Ti4nTo70/JVzNEyDaxxsSvTdtfIfhjTpC/RErhGs9RpJd3ywo6dQAj3YJiTTAS2JGQua+kTfqtaXCbWq5yHTkZ/rj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=czGel3h9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iY5YfeOS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B4B261D0024F;
	Fri, 11 Jul 2025 11:09:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 11 Jul 2025 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752246593;
	 x=1752332993; bh=rPs3KS1c1SkLmgd4C4FTnITK9LKw7AKveLxOo7cHuug=; b=
	czGel3h9TjO63wlYOPNfEJddTvcv78oj9ivJVf9umjHeg7Zm8r511SxvpsKfXyyP
	Af3ZnEJyTO5UiATGMdGi7VuzfKbBWQHTPwL6TUSCxi0SG8GMcx5lopevGqda+XoG
	sVJE7JZd5pZQ8hhd5yKjgX3KtvidPNprWur45WdcoYaHmKP98VZKdEBHMsSgwXdS
	ezipV692gVH/ybQQR7eVVXT6zlRJDLcRi63t1rJ6Tb6vCT9MXWngZs4a/vj4fvj+
	+kCNj3QukTJs2WqthSUxawbB1aMnfZYyb23omV6Fwe2FK4TPr4BuBcnWngrhuWvj
	2gbtU2P1/G6Ar8EdCPaTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752246593; x=
	1752332993; bh=rPs3KS1c1SkLmgd4C4FTnITK9LKw7AKveLxOo7cHuug=; b=i
	Y5YfeOS2YT/DhNlcPgKz1/LRB2F2Uc/Ld+MKrtgt92LO77XHiHTZlI6Zk+cF7ZKM
	kDGh9MKAEpE7AmJ31xUnSnJ+yOx2xhOpQQ9gbp36HHZjVmOdorQ2fj/N7M7cei0R
	hPe7nxBXYYZARp4qf/43FP+4cF2iQh84CLwYYp2rtOchX6lnvFQvk3jTTtC34Vcq
	jC7OfeGWeaRaqXQbtD5cEbxy4DJzBjr38L7qFAzo83MF7bI2BUwD4HynDKLgBzpk
	vTAZ9MfZJulWh9WW0Lel2AUZUAae7TFeN4nKxxBeaIpd3pN5jXI9Wisq9TBkDjhR
	oKwUWvQ8na4mAQYhkyglQ==
X-ME-Sender: <xms:QSlxaKGOfc_An9ooQ0PfKMWP7ENJi78fqCMbPrUlCLJ_LtJQeFmdYA>
    <xme:QSlxaLV8_IhnNFK0-IO8zJ2P2i1pOcsPNqBxag0E-iKr8vjlY_FRu96LjamVtC9dw
    dA3ye1GtEC3gT3jYL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeigecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:QSlxaFOIfJxzrBIakvzZ74n7THn7ZfBfzpSlGPzhieSVz8Xbi22FJA>
    <xmx:QSlxaMXWVfILa5PdP5K6P1rX5KNzR5t_cNicHkQiK9BGVWJm7fFaSQ>
    <xmx:QSlxaCKty1OP5NB6gd2TUjB0S684IMFc1-1D9axS2A6h2i2srddASQ>
    <xmx:QSlxaPrZJwn5_3zlKLQ0Ky_hcTkL67ce7mdHGx5ekhU19Us-NXtytw>
    <xmx:QSlxaNPlcwjmDLC7HgtaFf5Aw9luUvB35KOAHsyCznkmsE6TG1ABBS6t>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 270D0700068; Fri, 11 Jul 2025 11:09:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T3ae3921a54d7a46d
Date: Fri, 11 Jul 2025 17:09:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: "Mark Pearson" <mpearson-lenovo@squebb.ca>,
 "Hans de Goede" <hansg@kernel.org>, "Armin Wolf" <W_Armin@gmx.de>,
 "ALOK TIWARI" <alok.a.tiwari@oracle.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Jelle van der Waa" <jvanderwaa@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-Id: <fd1f6732-e091-48e8-90c9-4bc18aface58@app.fastmail.com>
In-Reply-To: <dd727ab6-a754-77fd-5876-fec076c8905a@linux.intel.com>
References: <20250709151734.1268435-1-arnd@kernel.org>
 <dd727ab6-a754-77fd-5876-fec076c8905a@linux.intel.com>
Subject: Re: [PATCH] platform/x86: lenovo: gamezone needs "other mode"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, at 16:55, Ilpo J=C3=A4rvinen wrote:
> On Wed, 9 Jul 2025, Arnd Bergmann wrote:
>> index b76157b35296..e9e1c3268373 100644
>> --- a/drivers/platform/x86/lenovo/Kconfig
>> +++ b/drivers/platform/x86/lenovo/Kconfig
>> @@ -250,8 +250,7 @@ config LENOVO_WMI_GAMEZONE
>>  	depends on ACPI_WMI
>>  	depends on DMI
>>  	select ACPI_PLATFORM_PROFILE
>> -	select LENOVO_WMI_EVENTS
>> -	select LENOVO_WMI_HELPERS
>> +	select LENOVO_WMI_TUNING
>
> Why did you remove the other two?
>
> Do select propagate properly these days across another select?

Yes, as far as I know it has always done this, with the one
exception that it does not propagate when trying to select
another symbol that has missing dependencies

> I was under impression they don't which is one of the reasons
> use of select is discouraged.

I have seen that mentioned before in commit logs, but I
think this was a misunderstanding. Using 'select' is still
discouraged, but for other reasons:

- complexity quickly gets out of hand when selecting something
  that has other dependencies, as the driver selecting them
  must duplicate all those dependencies and keep them in sync

- mixing 'depends on' and 'select' for the same dependency
  in different drivers tends to cause dependency loops

- selecting user-visible symbols has side-effects if another
  symbol depends on that, e.g. the "select I2C" in some subsystems
  causes the I2C submenu to appear.

    Arnd

