Return-Path: <linux-kernel+bounces-826715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1FFB8F2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85898160BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394C2ECEA7;
	Mon, 22 Sep 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ube5lV/e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HWkKCQAB"
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108B242925
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523079; cv=none; b=SJEvAXH4l/SWSB5Bk5seFmVViQSWn4fQEEJ3uTB4rxVCie/xN3EoaBMNSRh7lYGd1D+7FoU4DbOn0bLxf001LmwsUm0FTaE6c66shmDlWFdAljR8jHa3IV+s/eYw6cbhA7Iy4uF2dMMJ0M563agGxkb4vLcU+SVrlyGC5mc6bZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523079; c=relaxed/simple;
	bh=l7bqYUoqZC0MmhtPMTv8hntqz1K1j77W79Xkc4ZGCWU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TGG221VHENEixho3bTVHNSe807mhXINAvptnd6RSWDk+kUMGKY43BNCTQV9f0rurvG3sDxrGrhOH3Aap1duuGGxwLWVm8aD2vbuq844TDqNuRjcVg6UFP7hdtOOFq/vDKHcvuP8aRZ/qi3qns0/l8QQDy4Nn0vf7+jmmRIUXxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ube5lV/e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HWkKCQAB; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id CCFAA1300076;
	Mon, 22 Sep 2025 02:37:51 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 02:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758523071;
	 x=1758530271; bh=oRTsv9FG3U4ybrglnAgKP4GtX39SQERoznL6ypXbkIM=; b=
	ube5lV/e9Fiat19JzRP/DHcXurPxbkdd8gTPAEUq6Ffs1FJXVENctoAeO7N2TPFH
	a7vzVB4q3bJuTW5bXvD3vEpXjY0wn88R2Vj+8DMppvdSoK0H31eVa7+EV7Bq7NlN
	voXhivc8lqXXbTJlAi7PNyEb9Gj++SNGdJrP4uQegscFH1ww+cmvFLG97VP5/7S7
	lhCm8rbmXrqiVaF/dK+M+75/8lQiJpfAX3S2YJPedCtSmfsS4yXz9DknVRtriD5b
	4hLC7UkdD8neLAAwwA+N61yoloBXch39dSs6RXBFlVU53H2wDbhp9+u/+uwCIFp6
	D6/Nkbkz1gzAfNKS6mEaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758523071; x=
	1758530271; bh=oRTsv9FG3U4ybrglnAgKP4GtX39SQERoznL6ypXbkIM=; b=H
	WkKCQABcikKJJwPFToeLddMVwzFfr5YjTeBWD0KOhkBpbdDLCYa26hETGIpVWeU9
	lTrJ52EBR71niW7a5TVY8xGLAP2purRmJQn/EWMJsxVW2zUlU8VcwSQNUefunoAH
	4/Q3NWQ8Bkwu42fsqjwkEg28a+lkOuWoYQn2Wk1/xxz9bEKDgOgc9V7gbJxetKsf
	lBTDFWaeGXry604w7kZdsAJ2sR6ZoHjAIfROQ4e12WawP6guIvhbN1JsepvQr7jo
	XOBtE3jLR8yXWmifeLSK39NHzMAZZihunXeRKqpW1VWYz8pbtTKT8YodIzuewwXw
	IWxqaNgEJsJ3D6LuKC8jQ==
X-ME-Sender: <xms:ve7QaLXgBdFM6Y1TtCJBlITrjLFVzeXnRS4obxmx0q8GChHn_YLLxQ>
    <xme:ve7QaDlnNax_QJ4BhqfKLe8ENI29gzRizviDFzOgEj0JOW0BeK5cIRgBsBn-ygKsQ
    YtoUajvAv7ZkMUJ2BM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehnrghordhhohhrihhguhgthhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosh
    htvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheplhhirghohhhurgegsehhuhgrfigvihdrtghomhdprh
    gtphhtthhopehlihhlihhnjhhivgeksehhuhgrfigvihdrtghomhdprhgtphhtthhopehl
    ihhnmhhirghohhgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopeigihgvhihurghnsg
    hinhdusehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:ve7QaJu1tJyg9opP58GfgasJD9sSXHsTqnju42GwxkMOIF_P6AK17w>
    <xmx:ve7QaKRQTwey9OWjnR3DcYzNr2pVQCP5-vQiomV_czkcIwLTgEJOUg>
    <xmx:ve7QaIJGrVhMtb1fhwJg9TgSuBwX5gcW-2hgQ-2vtyXaur0VR8yrtA>
    <xmx:ve7QaKApvFUTjcYv8LxTffxsGW0ep-tayNt8fr6F6TNe1rZdcBaXjQ>
    <xmx:v-7QaGQodd7zGczHNjLut5G5XMvTRVF9QOaKyyfnP7xgZ6JApudok0O7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD408700069; Mon, 22 Sep 2025 02:37:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFFCV0QGVXfF
Date: Mon, 22 Sep 2025 08:37:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xie Yuanbin" <xieyuanbin1@huawei.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand" <david@redhat.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Kees Cook" <kees@kernel.org>, "Dave Vasilevsky" <dave@vasilevsky.ca>,
 "Peter Zijlstra" <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
Message-Id: <727caa4f-5be5-4b59-a10e-8dc9bbc384bf@app.fastmail.com>
In-Reply-To: <20250922021453.3939-1-xieyuanbin1@huawei.com>
References: <20250922021453.3939-1-xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 22, 2025, at 04:14, Xie Yuanbin wrote:
> Memory failure provides the ability of soft offline pages,
> which is very useful to handle the memory errors such as CE in ECC.
>
> Although ARM does not have a user interface like
> `/sys/devices/system/memory/soft_offline_page`, memory-failure still
> provides some exported func that can be used by some module ko driver.

It would be helpful to be more specific about what you
want to do with this.

Are you working on a driver that would actually make use of
the exported interface? I see only a very small number of
drivers that call memory_failure(), and none of them are
usable on Arm.

     Arnd

