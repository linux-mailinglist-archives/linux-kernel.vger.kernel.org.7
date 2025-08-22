Return-Path: <linux-kernel+bounces-781736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97269B31611
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8511CE8529
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C02BEFFD;
	Fri, 22 Aug 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="odUmb+Dh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KU95G1jF"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236320330
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860677; cv=none; b=Zor2ljNzadGJLjI2BltC2Bro/zK3YKajtPoY2Jx5Aflfnm5B38uvYKHNJk1WzFDfrjBIZ2ouoZDBvP5yDSeni6Kme0TvGvELbU268MzZPO0pMRFa7+QB4EfD+ejzTxIzc6AdmkD0pyrLa9Q9cb8CfIxNIbK1OFFFGUqdbDO6qDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860677; c=relaxed/simple;
	bh=4MwyKnzsOOpRmGCODYZ++C3D7ihjQA9juNODtrWjJbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kpd9+XcBoddiEpq5NvwdP5LdysKFmG9L1d09xDjPS2/AGwzdVpBaVyrTdDvy0nIOsIlxk1W5lO8w5IiHgmc0ZoKRcM8U+SI+dndj6fbyQ3rJRArphqX19DVRwZtM1yvSdEm0/mYk0m81h0JB0+K6AorPkSUwJenXbygCCSjuX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=odUmb+Dh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KU95G1jF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B610EC094A;
	Fri, 22 Aug 2025 07:04:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 22 Aug 2025 07:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755860672;
	 x=1755947072; bh=EmIUXF86YcQrT/8Hjt3QbuzJX9flVj+2OUQWxZuGrsA=; b=
	odUmb+Dhs2VS+C0GwK2Ch9U8/U+xpZXk1XEC70+Pntyibd0lIeB3x/gd8oJvPXwG
	YgevcwC9PI508ReOCtMEICnlU4SXrEhUnjnXKk3+z4bcAmQruNw1OgQh4p4CAS3S
	4Xb1TzLfmsJalz9uLwr7mW0nOaThYwVP71wk35FFZoKp2xJ0qC0tH61vH82IxgeU
	ZOLoRPaYu2rxK7EXSqZqL+fD/ShYJgmH5HHfVuuVJPAxoBAutW1qccZauYzy5K1F
	OJYFdy2XIvXbwwHuWBSIXzmjfct07GWObWngqXE1J4cvUlIjZUIXKMUK/wZivDmA
	e45M3OXji1uFq2EjDiCT6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755860672; x=
	1755947072; bh=EmIUXF86YcQrT/8Hjt3QbuzJX9flVj+2OUQWxZuGrsA=; b=K
	U95G1jFCCKMtIbaULGb03C3x0nNYBZLl0OKd5hGWgty9sCojBaXVdHCY4zjAAzu+
	Qk96cUJD9qC5NMl/vmVtmjwo/eVIKotjlQz1ojto2zHrFjR+Wv8pw2frgi+N3CNT
	xU5alI15wx5w6snF8O1Hri+KycM+mpeMbzpS87Ry2XkGgA2eUxlRcSQ1XCUzsrBx
	GdhbmM83vHx67ni5xSfARaWVgMRVUQAo5ca4vGVW2JcTHX89tfxaPson4e7BZtR2
	wTbld3+yrZAARJPLsyFAC6RxwEb0uOJBuDmbi9twMA5aWCY2jF1JniKggZLJ+KuD
	ERPfn9HHKUzkHNlpjOW5w==
X-ME-Sender: <xms:v06oaFnNY0cUdO21P-9Ma-qjweXgKLB1f11vK-G-5Ntc_Ex8ubiFkg>
    <xme:v06oaA2B_tMUHaiSYJQWnmGgLvoZoqfNiSC_gGssewMw5d-gdxRTWgwQ8k5RKcPcT
    FO2jXE9aBT28NsXIbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprh
    gtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepsghs
    vghgrghllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhurhgvnhgssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguih
    hnghhuhigvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:v06oaNv2vkg4FQGapO3c_YHhofNvxfTuo2zOGcxqE8zhNZZ5hUhLMA>
    <xmx:v06oaOFVs_4iy7m3Hm_AH6WQFEniE3zbrPKmWXN-rnPMqYcQK84n5Q>
    <xmx:v06oaA--uPBA6Mm7vI9kW8ii1lE_kAUxJZfMwjbVIxXelxhZLXRtoQ>
    <xmx:v06oaMNLABhtZ6b6BCWK356wtaSiXa9MyR_NbR8VWIJAcNyvbz8HTQ>
    <xmx:wE6oaNXuCP0_6qmIwJ5SSu4OWGFSmgyfWKLLtMXkQCYYsBHfyGfofuT9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 385FB700069; Fri, 22 Aug 2025 07:04:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVsTuni0f5VB
Date: Fri, 22 Aug 2025 13:03:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "David Hildenbrand" <david@redhat.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>, "Kees Cook" <kees@kernel.org>
Message-Id: <1e9f9975-7be0-4abf-87c6-a8f54cd9d059@app.fastmail.com>
In-Reply-To: 
 <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
References: 
 <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
 <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
 <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
 <FR2P281MB15445D806CF865A0E1CD8FFCB53DA@FR2P281MB1544.DEUP281.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/2] copy_process: Handle architectures where sizeof(unsigned long)
 < sizeof(u64)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 22, 2025, at 10:52, schuster.simon@siemens-energy.com wrote:
> On Thu, Aug 21, 2025 at 11:14:00PM +0200, David Hildenbrand wrote:
>> Sounds reasonable.
>>
>> But is this actually something that is already exposed before patch#2
>> on other architectures?
>
> I'm not sure, but I would assume so, as e.g., arch/arm seems to have
> support for clone3, but also seems to use 32bit unsigned longs as far as
> I can tell and, thus, should also be affected:

Correct. 'unsigned long' is always the native word size for an ISA
on architectures that Linux runs on, and the same size as a pointer,
so the bug affects all 32-bit architectures that have clone3:

arc, arm, csky, m68k, microblaze, mips32, openrisc, parisc32,
powerpc32, riscv32, x86-32 and xtensa.

However, since the ABI itself is fine and 64-bit kernels pass the
value as native words internally, the 'compat' mode support on
arm/mips/ parisc/powerpc/riscv/s390/x86 does not have the same
problem, and running the same 32-bit executable on a 64-bit kernel
should work fine. This may explain why nobody caught this so far,
even when they were testing the new flags with x86-32 or arm32
userland, but using 64-bit machines.

>> (I assume above output is with patch #2 but without patch #1)
>
> Yes, sorry, that one is on me; I've naturally first implemented support
> for clone3 on nios2 and then investigated the test failures, but somehow
> deemed it wise for whatever reason to switch the commit order in the
> patch submission...

The order you picked is fine: we generally want bug fixes before
new features to allow backporting them more easily. Please add

Fixes: b612e5df4587 ("clone3: add CLONE_CLEAR_SIGHAND")
Cc: stable@vger.kernel.org # linux-5.5+

above your Signed-off-by for this patch, to ensure the fix gets
picked up. I would also suggest changing the text to not mention
nios2 specifically but just say that it affects "all 32-bit kernels".

    Arnd

