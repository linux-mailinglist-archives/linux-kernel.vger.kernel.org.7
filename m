Return-Path: <linux-kernel+bounces-783345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B0B32BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879C617D2B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28882EA463;
	Sat, 23 Aug 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tW/QUY+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLwgjZTy"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7872EA166
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755981508; cv=none; b=MsFHCT/mCVZo+KUkWCNw+VHKtg6gkLDZOwGpNCrBVSEC8KXO4XeCtohRKupFmQJ4j+yizR/SOHd28RZzKFtMYyBcxrfWS7fq5N+rgsq7ehBYzmhKByL+71oR4/E5aPoORCRcLv0gPTBhjU6DLlW3166egQMdUBFNd68w5fTTEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755981508; c=relaxed/simple;
	bh=5wsejkLHKFxRG8WE8YufagqnxC5MsGVE83BwNdNzxzE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WXQzD8KdyjFvWQ1yO3YZrhcioM97yseQFWaOJIT9IpJuYTecnzmJFY6MxUP2iLWda/cSjqAVTvMu1Zjs6FC4fo6f8n8sgsf8RHx4k78ru5R91oGnKvH5zXSjYsb2m/9tQhra1haH3KzvkbD69BNm0EejjUnioK+EGG9pXB6bAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tW/QUY+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLwgjZTy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 12CCAEC00A3;
	Sat, 23 Aug 2025 16:38:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Sat, 23 Aug 2025 16:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755981505;
	 x=1756067905; bh=5wsejkLHKFxRG8WE8YufagqnxC5MsGVE83BwNdNzxzE=; b=
	tW/QUY+tlhyfCXJ4OMfhSCM3J23mVKvlmuDdWApskvIGRzQgQ5ptE6yvzmk0sO08
	uRApHHgX529echVUXinnev5x/mZ8qA8IHgy1wqb6cmjiG5Fe7zHmb0qjgrLSh4ia
	cfyzVBos1+9EzNf6hg80+CZhJgh4q6be9Fp8sW5Bwsr/kbnIQKzVYw3PPDDZPV0G
	8TxbJw/Q0I7YgtAtbV0vw+D+a/41LLjokitzfoHXnGcLk0t77NvtVr0SbqVwf169
	DVgaGvHg9dahQS+wS5r/r5Ob8KYUK+Wk1R/+0ZU7yXNVbUFyH9XdvkXV5esUooVo
	oYIapa57RJOqQBYvevK73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755981505; x=
	1756067905; bh=5wsejkLHKFxRG8WE8YufagqnxC5MsGVE83BwNdNzxzE=; b=V
	LwgjZTy8OAk0wSRskO/XXNrdRt7TNTuwC9qaM2GJ5G6p+0/rKyabjWyXOskQo662
	tEQxUPuE3dqaQsm0aOo8KO/gjFcybPzHE5x39iU0+pvu+l4NLHVf2Nq3SfwNZgIO
	iPtHhD3Gx3Un/dPs59RonGrGRuw2PvEZs5l1jflWRzVwNZoUhFijbdh/9ngxdrHn
	YiJknhRHklWj5ZDpzECOKoEaoIq+m9lpIRoTMPy4Vf8ttQF5CffvF2UOJIfOzKh5
	MZvntVHf7BMFzB84BcDX3a+6NyI2Gdatk7+CAl1ePT9/Wwn3iN+er1/ziC36McCE
	0MDsRAgf7VNH5e/t3goDQ==
X-ME-Sender: <xms:vyaqaMoaPuGPA4SsKZ40-SH6lQGHcveSOj3kkMBq10_LEzR3Zjxi2g>
    <xme:vyaqaCoAsdms5nTE1ZKBcI2Gn4m277TFFwVu-dZXB4k-ZEFLND6kEAvstOnUpd6-J
    8kfjpM6iy91EHI5WEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhope
    hmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphht
    thhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehsvggrnh
    hjtgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtth
    hopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhl
    mhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrlhhiuheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:vyaqaBy1x8OrM8aQs09ZE8Q3rgnGuGFEadI7z8PsEgmlSOvOv8YP0g>
    <xmx:vyaqaFMERqJ1GlXpFlil6DyDqQtGoM3cDl5lJwdiFF9PTeDH2o_ZPg>
    <xmx:vyaqaP4fLfrc59P2Ry5r639DO2dBM_TGKkv_T7AGiLYS9qc__dN4qA>
    <xmx:vyaqaLfcwucqU5uaFMuDwA1Q6adwHj5fDm2X7st4rnRXa0usReKk3A>
    <xmx:wSaqaNYTH8r36XMJsNZg4kEB0Ji7xLD54IZbey5FPXyHWiMiNa_azccH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA953700065; Sat, 23 Aug 2025 16:38:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdWbVQT9FCf7
Date: Sat, 23 Aug 2025 22:37:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Sean Christopherson" <seanjc@google.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, x86@kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>
Message-Id: <1ab8b2fa-1959-46c5-ad98-e2f549a35969@app.fastmail.com>
In-Reply-To: <20250823161655.256689417@linutronix.de>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.256689417@linutronix.de>
Subject: Re: [patch V2 31/37] asm-generic: Provide generic TIF infrastructure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 23, 2025, at 18:40, Thomas Gleixner wrote:
> Common TIF bits do not have to be defined by every architecture. They can
> be defined in a generic header.
>
> That allows adding generic TIF bits without chasing a gazillion of
> architecture headers, which is again a unjustified burden on anyone who
> works on generic infrastructure as it always needs a boat load of work to
> keep existing architecture code working when adding new stuff.
>
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

