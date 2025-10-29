Return-Path: <linux-kernel+bounces-877038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8CC1D0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 517FB4E1798
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF5359FB2;
	Wed, 29 Oct 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JDX03KMC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJNT36Q5"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E922231A21;
	Wed, 29 Oct 2025 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767051; cv=none; b=JTXSNOYywEXqd8GhjYzhLWUa8mBIqz5Rt+fMmUojmlGGt189BJaU8ioQquba3FmwXPBXGaoQWWJOeCIu/68suz2N75Ac7z9tGmfHAF0FOA+g+UIod1zYXnCI4gaDnEnUETatlNuoEiFxieTje9AIRK7IidZqLBmQfRKHuh9CgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767051; c=relaxed/simple;
	bh=aNDdmYw2elfYdy4M78GQ5YNtZ3s9q3s66tvcmf1yMiw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dOB+NG5gUnCEpYlGlKL3YQTjV5EhdAw8JzBor+x+FzH76DnhtasMRVjU2Cvh1LePVxPwGqxvYu+95IcKGdxPld8TFCZ1qw4nmCf8XCOuuzfn0G8o5Knr1JGEJVP9oMhUS2gDFinRlKlAmJWmbadmIyaW68MfaYsfJA/U2YK1tgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JDX03KMC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tJNT36Q5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B2BF1400126;
	Wed, 29 Oct 2025 15:44:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 15:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761767045;
	 x=1761853445; bh=QRy1TWnz9b3IslGsVJisdAEmqAzlqSPRloIKecHxR6g=; b=
	JDX03KMCRYwJu1Rejr/b3osU8xRpbi7kp9U2QH/al3iTS+e0AK/Den1RS3iDcTJx
	Xb0klpvE5XXLi3RG7tKJulu9TJ4HsDFDuv5d4lAItmBkTcy/VPP1by327JD0qAcH
	YPBcn1RwtbEiTo6jK8qDeu1fKjZ+z2eNCtlBANNJvP5iNIoP0lZ7GPNqY4O47qoV
	D92Z6f8hu0rM49pemFP81zRTTTg0vWFOyyh8+Sdx9u4UmWz2jMpyqYbRsKbdmL+0
	bt8qY4CgQqMdcT96ehgyQNtEWYrpa806WlxYKANJsmvj03VnDdCntx3pUfds0FHW
	cPQ0pMPS+Ig+2OX1xqZFPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761767045; x=
	1761853445; bh=QRy1TWnz9b3IslGsVJisdAEmqAzlqSPRloIKecHxR6g=; b=t
	JNT36Q59TJDqXUdwjZ5o8FY9VMNU+SSWU4so7g6kB5eEsJ84+TPrtN5rytDtaiw9
	iN+JSEuKsbn4beZ8qNdQwwdUpghRM6MpDG019qwatAxP5/l94l3NdYjwL4gBgRDK
	NIqbUduX7ulKfiW+LVvtMLz2QE6QK+adTSMBwcjm3j7Ms4uxX0ame6NZlMO2gdJV
	11XvZh7h+XlJM3/6a53Mk+5+1dmrgLtB5bBGvCUYiy4SHTEAKLXxisSLELuLYdx3
	bXaOxzA9KX8E6JrpKuvgMGa/A8biyQWhE3f1ipGs1DRFtcbOUDVgl6+C8sZsBkXq
	fGqzibP1TxQZ+xGgmnVlg==
X-ME-Sender: <xms:hG4CafhBIN059Bb4YXgMvLhhWQk---7pfppC2JRqJN8QTj1MJ3nxjw>
    <xme:hG4CaW26L96d5vv_8d6ygs2gu6dSx-ZjE6P8OeBQfECBZg0NVmeSNlxLbvMHdoojY
    tzhvD4KVWkz-cdhtQu_NUXum-vwbFCoGWObbQry9SdlFBRhjsv2T8x_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnughrvgdrughrrghsiihikheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggr
    nhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphgvthgvrh
    drghhrihhffhhinheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggvvhhitggvthhr
    vggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hG4CaYwxXws7WQrWyVYaUz9TOxKyvinFgQbtKQ0uZ9C3o3Wr_OKybQ>
    <xmx:hG4CacuWvYTwiJ1wxxwltMU6rHrGKbd4rw4BUhxWlhcT3kbpcXBB5Q>
    <xmx:hG4CabCSXrC1CHOthgdhP46aQa4ig2FV1AbEXML6VlKCDzky6T2SfA>
    <xmx:hG4CaeF7GmJQFPnhIOnWjC7yDoBCarvjfN3rPi35x4b9g8HQZG-tOg>
    <xmx:hW4CaQ_AjigXjvmq14Dkm0DVt6wDKJB8voJv13ZBb7nhWBNp5pNTiflb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C9E1B700054; Wed, 29 Oct 2025 15:44:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK9Cqudmt2dw
Date: Wed, 29 Oct 2025 20:43:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>, "Lee Jones" <lee@kernel.org>
Cc: "Conor Dooley" <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>
Message-Id: <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
In-Reply-To: <cover.1761753288.git.dan.carpenter@linaro.org>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 18:27, Dan Carpenter wrote:
> Most syscons are accessed via MMMIO and created automatically.  But one
> example of a syscon that isn't is in drivers/soc/samsung/exynos-pmu.c
> where the syscon can only be accessed via the secure partition.  We are
> looking at upstreaming a different driver where the syscon will be
> accessed via SCMI.
>
> Normally, syscons are accessed by doing something like
> syscon_regmap_lookup_by_phandle_args() but that function will
> automatically create an MMIO syscon if one hasn't been registered.  So
> the ordering becomes a problem.  The exynos-pmu.c driver solves this
> but it's a bit awkward and it would be even trickier if there were
> several drivers accessing the same syscon.

What would happen on the current exynos platform if we just take away
the 'regs' property? I would hope that we can avoid encoding what
is essentially operating system policy in that driver and instead
just describe it as a device that expects to be implemented by
firmware and doesn't need registers?

In new syscon devices that need both cases, we can then start
doing it that way at the beginning.

    Arnd

