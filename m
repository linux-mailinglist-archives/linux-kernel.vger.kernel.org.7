Return-Path: <linux-kernel+bounces-739274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02903B0C436
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE7E3B82C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3F2D3EF3;
	Mon, 21 Jul 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BfCZgb+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NabAMEtn"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603029C352
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101492; cv=none; b=LvmFoa9eKBSztmG8jTmkLVkQc1iPDToGiEgRKJIfyethxsAXyfyAalItL//1T84WvO3jHht6z2rxJTVW77M3VuVu7Uql1P+WEPaM5TwLv9J1Wo9izLwlzyroHO5g6Vv5Vm5rRHYKV7UYfABHNTLkCvvAVtFwrGhMvcFk4W9LGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101492; c=relaxed/simple;
	bh=nvIcINjsNuAZOLKf1He1SJCeIF4PFADWsBUQyIR324c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l2vGPvTgR7zYCdFiUdB5NvRjRWqNkdtuohWMti5zC6cnjmbBtd/WcpFbIEQtCCbfc0FwmOQDWMmYMzv1HhuPhpiLlaTR3lcaCPxS8IO9hnFnWoVx/RyD95n9BmSx8/bzeZZGtbsnPmFjbi96et+4b7nAgxUKfRAnkNlYtkmen4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BfCZgb+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NabAMEtn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7396D7A026D;
	Mon, 21 Jul 2025 08:38:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 08:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753101488;
	 x=1753187888; bh=uhrRzy+iePLdd1xy19cjDPimBozdlhjYyOfYRcsgTf4=; b=
	BfCZgb+7YEIueLEPbSU9ymc7AcLw18hz1kBQP0dQ/mjVDMD6B+P/TcuBX8hdauuD
	ToKg0jZ03S09Qkx0TVLSf5j39ThS7pwjl2IPJTF5++EneQWxGA05QMU+KsoE9vx7
	Jgw/99OO1GDCzy9yryf2no8K/HT43jcGQ6Cx/z7dUQdYFZoMxw7HzaJ+yGnCBP4y
	POpDpmpYxJDbZHN2rNhTUWS0znbbYGsMil7HSbhcSHz1nFwNDfd9qCE+1BwUx34s
	tZ27rk/6Wr0Naq0IMBAxWnY3pE6hCuuLwba8adICbndum60ReCZzrAsz17rpMFmv
	TWNC2UowVFTAv8OGlc2FKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753101488; x=
	1753187888; bh=uhrRzy+iePLdd1xy19cjDPimBozdlhjYyOfYRcsgTf4=; b=N
	abAMEtnjkUlEqDe6uKqSgr71BZGPvwjSjInYXKxP65GTajjPsZx2UuV1rfolKOuw
	EWY8EvJyERmdSyexixNjt9YNlnMbVcu4OjpDCVWbnMmeFJ2yGzg2fU0AoaPMF8+m
	SDMYG7yYk5NEM6mEfZoTc7fFJ36nmOPDghxlJ7swkrFm2vNLDF/kLjJbjEvViCI5
	X002hjbKuff6Z7+oL0VFSSWF60PT9HpDqfM3TywttwTck93SJaXvBxZZV2cOx8ne
	9PEoRtwdflTbI1pQAJPMeM+pYpKGLh9SJIeWJNZrI22xhkCy6VNnL8k95QDtVisM
	rCHrLx0mSW0hu5rhW1QrQ==
X-ME-Sender: <xms:rzR-aBaF_rvfgdjdDwGmePX0o0bsVzGSOnEjt4_RwaaK8Y3cQz89Qg>
    <xme:rzR-aIaKLsNSFGls_tOQ8gj-Wx7WObhviitQcNPsc2VZTmBLELsj_KRVgwK7abwR9
    2A-e7blhjzOiluvEh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlh
    hivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrthgrughruhesghhmrghilhdr
    tghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    hrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphht
    thhopehnohhuvhgvrghusehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtg
    hpthhtohepsghskhgvghhgshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthhtrggs
    ihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:rzR-aLiuzSvMsKj7O5_2letYTW8aoEvpiSuH133H7ShzkDLGEOe7OQ>
    <xmx:rzR-aPQBpNr6Idk_c7g4wY8A9umXp6VI2vagx0uV6gPF-0FXVvXrYQ>
    <xmx:rzR-aF9UBgdXUhkeb0tGozRlO5I4k1d0nj93aahF63Q8tIlU8nI0OA>
    <xmx:rzR-aIPOffZGm9Brvzz_CUTXBMxIwbQOj8wiWpOYDTvz9LEVc3GxEg>
    <xmx:sDR-aJ_IPMld6rXO9HGowjncV4p4ztf_COLjlG4DLrGlaVgyhLy-KS5Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1DE970006A; Mon, 21 Jul 2025 08:38:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0fa10d1000c4a2fe
Date: Mon, 21 Jul 2025 14:37:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Satadru Pramanik" <satadru@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Dave Airlie" <airlied@gmail.com>, "Dave Airlie" <airlied@redhat.com>,
 "Ben Skeggs" <bskeggs@nvidia.com>, "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list" <linux-kernel@vger.kernel.org>, "Lyude Paul" <lyude@redhat.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Timur Tabi" <ttabi@nvidia.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Message-Id: <c32114e7-a61a-4c2b-ab4b-b103d028d05f@app.fastmail.com>
In-Reply-To: 
 <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
References: 
 <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 21, 2025, at 14:22, Satadru Pramanik wrote:
> Hello all,
>
> I suspect this commit in 6.16-rc7 has broken acceleration with Mesa's
> nouveau drivers on my machine.
>
> glxinfo -B reports that I'm using llvmpipe.

Thanks for the report!  Can you run the failing command with
'strace -f -o logfile.txt -e trace=ioctl ...' to see which command
it tries?

Either I made a stupid mistake in my patch and don't catch the
intended command any more, or the command that gets sent is actually
different from the one that the kernel expects.

      Arnd

