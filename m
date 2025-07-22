Return-Path: <linux-kernel+bounces-740673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC7B0D790
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C926C69E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3F2E267D;
	Tue, 22 Jul 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C6VqZ2f7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llkC/Qoz"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0392E1C7A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181576; cv=none; b=QvpWcwdL5Uf3H5X0GdxgvKJELOTkod7/4fnsQqtCo7OH9Z+Y5xFW1iWngA1m7rofCAdi0mpQrjjt5vL6uCgrR/9B5zcbgD3+Q4++lvr/h4MhbLCRKb1kIuz4W2NFTohpIjnMp7Cy4MlqSiWVN7y5HHVeIL8qFxMkDczwYNd2o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181576; c=relaxed/simple;
	bh=eqx2RFxEriT8N6NnmhlDLwSTL263s3INhZJi6o4bqHA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ndv5yfBUC3C75zBaI7EOLDNMxbaVTWNk36eZR3uEP5AmSHLcVAbLUcURhKtuddl6mwEYYzm9Qc3iy67Hp9/8c2mMjpmr5klSQ/S6zrmjW6JFM6X9S7sJ/jtJXp+cw+Wl7aVclsbx0tY5TKtiv3BZnE6Fz5oD1cBLE7Ee1HsanVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C6VqZ2f7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llkC/Qoz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5515A7A0201;
	Tue, 22 Jul 2025 06:52:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753181573;
	 x=1753267973; bh=FnLOLSv8agUNvtWwXJcvjWEfYF/cxzIbWP6/PqOEwAk=; b=
	C6VqZ2f7S9mIRYUELpXpnO+t69T3rnNMXuzWdaK0skJw3mX2rjnMo99gBMZIEkdm
	GRmQRG21g5icCitmkKspFhO3+WgV1e7jDG4im8gm6Ju/jfgt0nFLoSEYgRPIPoWf
	UDQSFpOU8XzMP+AhmX7rdHlyxiXm9K20mH8lRJamCxesQweQ42ZuTnWPQE1s+cUy
	cHwzpLF0+ORRQ5fhoHoaZ7B8iCNEyHc1rgSSSe6846A547d43qJKU8HMLf5xw5Q0
	fG9YLbYiZy3OLqaHYrcTuJjhtxH9K0JcoZRt6cyTDc1mMeJYu+SOn4IRsRuitnPV
	7Om/9IUL2rn7WgC2LZlyhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753181573; x=
	1753267973; bh=FnLOLSv8agUNvtWwXJcvjWEfYF/cxzIbWP6/PqOEwAk=; b=l
	lkC/QozRAylQgy6u7kRCxvUIEG1Ke6z8TeCFBvPSD/8OI9YBM6Kc4ugdxIuVXlJp
	LS83fZACrI1wNVRqSpigtbmyAV2V607Sj+fzSoASGR/wf3Yqfzbb0CwLw9vm6umz
	U8Tf2op9kh6rVlPyJSUOVoL7dgcco8E9yzmzzuwF/1mdGwLWsChWUsDy8DKZ8tL4
	HUzM0oAZ1Kfbqcus0CwA5RlEhcdY2juyD9UhDR/Fq2ml/b8QYhwezjU9WQe9Eyn9
	gqWrQKiVKWUuzsL2SsopqtZzumjyL/IQ9EBjghO6dhtPKkGGKHHrcrcvfhr/Sl5h
	Y+ymbYN5mkyaeN/KA5y4Q==
X-ME-Sender: <xms:hG1_aBEK_DWPSzEhKYWqA8yKDJ1izCEv6xSL3zTRRayHtxRijVhhxQ>
    <xme:hG1_aGWr_brqeEpSRKL7TCLl_A9YyH7zaBPkZL6KGyE0dsrqpnNC6LHZaI0cEZ0J1
    gybBhfWeLPLBmvMIfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejgeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlh
    hivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrsggrihhnsghrihgu
    ghgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrthgrughruhesghhmrghilhdrtg
    homhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughr
    ihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtth
    hopehnohhuvhgvrghusehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghp
    thhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopegsshhkvghgghhssehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:hG1_aAO57fs7HK76j4t-6D10Og1axam1vQQiYg7sR_mkTbZnz1devA>
    <xmx:hG1_aO2C3xsktnCVcqaaED66usVapgUe6HiFXuodCIBJbFKPSAAITQ>
    <xmx:hG1_aGoM-5k1pDzf6gT6A5zWJoUz6J-8js2brOIBKnVjweJxOT7f8Q>
    <xmx:hG1_aAcNFY8wF6rYWJ5EgpxGwj_2HUtujs7x6_77x9AKuF9OyQ4AMA>
    <xmx:hW1_aDOZEwNtzPLa3pup_ixPAFisLyKZONmEX3Az98dsOdbYdDlZwBbH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D45E8700065; Tue, 22 Jul 2025 06:52:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0fa10d1000c4a2fe
Date: Tue, 22 Jul 2025 12:52:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Chris Bainbridge" <chris.bainbridge@gmail.com>,
 "Satadru Pramanik" <satadru@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Dave Airlie" <airlied@redhat.com>, "Ben Skeggs" <bskeggs@nvidia.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list" <linux-kernel@vger.kernel.org>, "Lyude Paul" <lyude@redhat.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Timur Tabi" <ttabi@nvidia.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, regressions@lists.linux.dev
Message-Id: <d5010230-b718-4770-b731-f62225f1f808@app.fastmail.com>
In-Reply-To: <aH9n_QGMFx2ZbKlw@debian.local>
References: 
 <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
 <aH9n_QGMFx2ZbKlw@debian.local>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 22, 2025, at 12:29, Chris Bainbridge wrote:
> On Mon, Jul 21, 2025 at 08:22:48AM -0400, Satadru Pramanik wrote:
>> Hello all,
>> 
>> I suspect this commit in 6.16-rc7 has broken acceleration with Mesa's
>> nouveau drivers on my machine.
>> 
>> glxinfo -B reports that I'm using llvmpipe.
>> 
>> Reverting this in 6.16-rc7 restores nouveau acceleration, and glxinfo
>> then reports: "OpenGL renderer string: NVE7"
>
> I also bisected an issue to this commit. On my laptop, this commit
> results in an intermittent desktop crash (Xorg segfault) when changing
> display scale, which can be more reliably reproduced with:
>
> for x in {1..100}; do
>   xrandr --output eDP-1 --mode 2560x1600 --scale 0.5 --filter nearest
>   xrandr --output eDP-1 --mode 2560x1600 --scale 1 --filter nearest
> done
>

I won't have time to work on fixing my patch before the merge window,
let's just revert it.

      Arnd

