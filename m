Return-Path: <linux-kernel+bounces-759011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36807B1D70E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EB0189F20B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911932356D9;
	Thu,  7 Aug 2025 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KDkampQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMZTLgdo"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D202F71
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567731; cv=none; b=D5xrsacUz1b6QVthrRu9lnqGzae8O/iIHYYLlxH4rVi14CeYTvoS+J2Nh4UDEa99Sm4bQWJFVITAx3kJuur4KejhtqLWJbvXJ5MzIKbRRUut3U6YSr0JPQDQWK6QRPhBmuGa5M/2fY0PjJnM07a+s1dlFQO0j3zrllLvygfHccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567731; c=relaxed/simple;
	bh=KWU97gHIROBrSOH+bqHHhw4OYHrEW7Sk+TRJp7OHcCc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wt8VjIy/YwW/+8saAbOPT5fs1q4xB0o1oB29ry5aLgVZXAoF01Nh3yqQ1SwuwOmW9H8jX3D21bobkt0bhB2+nKSI078gnck88uRMmCGnHBWBFDJc6rgRbXgvdFruvntm7MbYiTq45VkPXBGk+8PgezJFPS+O8q1X7Y8mPoAKdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KDkampQA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMZTLgdo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A58D914001BD;
	Thu,  7 Aug 2025 07:55:29 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 07:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754567729;
	 x=1754654129; bh=lvSVZIYjeywNLTrX0KHghBfKGGzoIVIlXjF7KGCgCM4=; b=
	KDkampQAZpTEYb+NF94hFFs3Ia5T050xGnMocRGZbaOsFb3o56S7c0OiEY5YIBFo
	I6NXGrzzjsg1lpjPY9mgjNQb3tpMdaMnprG+uD7pLFJ4BB1gbtgbAMpVPrDJeIeZ
	C+Kon2y+FoOSlAJbewji4j37cb0IFsY/GYacnxVe4yxvMbp9PsnF6pIvTWHeOBhE
	1elR20BjhBAIjmQr2bpc4+jY8uMbi1DiwazSvG4oJPvAr0bthZ3/TBfcYF5jOSSS
	tZJAom492pEbKNMLzSW8RMSYVW2bF83xsQAuukspxwEL8c1wIBoCQh9/Yi0TMeUG
	QDY4H0PWrbAj/BljEv1lCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754567729; x=
	1754654129; bh=lvSVZIYjeywNLTrX0KHghBfKGGzoIVIlXjF7KGCgCM4=; b=h
	MZTLgdo1hq/Vs4qpAh7hIeAs2TnwQEhQDwrbjEYbSt5aeJ7vkVWdRT3j5TBIKj0K
	ftjK9BrUalncWmGeciF3dtHXR057p2hkG1J4jOVyI7FxQtUcaWUZjcDUPSs6lnky
	9Y1MKYUbNMI0QiZTb6cwtukQmavzbCug/P9D+gSXZoieHeTxCAxBEUXkfI4grqVf
	3llKvl2hcSULHP3ioiQxJxpkiNKBeD5kiwS253CXeVhXb222V39Xtbq7vZtihl6s
	xfiS8+isuHMc+NPiZRrK10GmfyZH9QsitNZqIudYz8EfOqZgdGuJ48U7OjRZ26XX
	0sBV7bhQBmKZUGrcx1tpA==
X-ME-Sender: <xms:MZSUaFNGgyu401V88-P81oSXMrlTZl0DLbrOynFjoK5K5bovbipejw>
    <xme:MZSUaH-fjY6fLgZXF6Fz1mnUK2Q37UGWrfBYrB0a-tyF8tCUHL7MxPiqRYsS5VBrM
    CPgz9E-avSrhJeNiEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpd
    hrtghpthhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdr
    tghomhdprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomhdprhgtphhtthhopegufihmfidv
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehllhhvmheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:MZSUaF8MnoSvOVnXsnH1iow5cFhSS313ILWiKBw_ToN9fWIEhmmadw>
    <xmx:MZSUaPq_7LyanMLime-xYz1qPm06ifAVh0xo4Sf585qAmXWhEZjr6Q>
    <xmx:MZSUaAL5LVEj4ocHvTDNm_ulxjOMOsyNiqov8Wd1k8hrK9euGCIJ0A>
    <xmx:MZSUaKPcDMHjOY29YKsCPaOkM9RBbNHAUjNk8RQ_dhHCuHncijYCqA>
    <xmx:MZSUaDmhMpOmsZZB29qd88KzyiKS_yEuYVciVN1NgPnBFYUibzaFM1rM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EF241700065; Thu,  7 Aug 2025 07:55:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T52d1d27938ca8a40
Date: Thu, 07 Aug 2025 13:55:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <bb5c1c40-874a-4b30-b606-1785f00e9be9@app.fastmail.com>
In-Reply-To: <87o6srd0sh.fsf@bootlin.com>
References: <20250807072044.4146480-1-arnd@kernel.org>
 <87o6srd0sh.fsf@bootlin.com>
Subject: Re: [PATCH] mtd: dc21285: fix bytewise memcpy()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 7, 2025, at 09:54, Miquel Raynal wrote:
>
> On 07/08/2025 at 09:20:34 +02, Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The commit that split up the 8/16/32-bit operations in 2004 seems to have
>> broken the 8-bit case, as clang-21 now points out:
>>
>> drivers/mtd/maps/dc21285.c:129:97: error: parameter 'len' set but not used [-Werror,-Wunused-but-set-parameter]
>>   129 | static void dc21285_copy_to_8(struct map_info *map, unsigned long to, const void *from, ssize_t len)
>>
>> Put back the loop that was in linux-2.6.8 and earlier for this case.
>>
>> Fixes: 67d4878e4e61 ("NOR flash drivers update")
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the patch, I'll take it, but that probably means few to no
> people still use it, if broken for more than 20 years...

Yes, certainly. I also have a patch to mark the mach-footbridge
platform as deprecated and schedule it for removal, I need to
resend that patch.

What I suspect happened here is that the bug was harmless
because the few boards that use this driver all have
16-bit or 32-bit flashes, while the 8-bit codepath was indeed
unused.

    Arnd

