Return-Path: <linux-kernel+bounces-757966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55891B1C91D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271C756693C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68029616A;
	Wed,  6 Aug 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IRHh2zqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="euB77sI5"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F13293C45
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494917; cv=none; b=cYE2mR+WvUhWXPf7UN1csSdYFK5uHVTcRA/GQBL67N4/cKRIDs8BeNg7gQbEL2tttlJHZVxRuOrieQb4TCKpoTXgx8CCezu8xNQ2Me5QAsD7y9FxiEGxI/86L427qn6RdgULZvbyM/elY1xT531SFDqdLi+mOMLfeOtAHRXgU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494917; c=relaxed/simple;
	bh=lelOgTU9HHxUWn76YpmuMRtET3Ukt3sPsFFgD7YPzVY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oCso09Z1Fx6Hxj/ujsF217lMRRQYLEtTSZmcFSNjZKoBi/bMoRRw1YLyVhAoReBloVSv+lpfeNaWXvPOYw0uVXd8hj0EvdKvMjvbraIDnJOuaAVOqTu6n08LiV+3QhOzZr4tiJ8uluzk86hr/Mhq/beyWWMbdNvVg3Je8DRUp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IRHh2zqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=euB77sI5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02A977A00A9;
	Wed,  6 Aug 2025 11:41:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 11:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754494913;
	 x=1754581313; bh=QWr4d7FdEbOlGE3vrG07XOxnFjq0nNHsAsokSmwJO1M=; b=
	IRHh2zqojx8PoMn8cGUFKso+3zgg/P3V2+tsP0G7wfSrK0raZ+sBj1ppVbU6B2Gt
	yK67/J2hnOt6nSSP09sgiTpfg96QFkJfmLMwhpZpBA6DtH/Z1XzNLO4XR+Z1ict/
	KtFnWhMwmkI0Rxn2V1Gtn6+mCelPuyp22wF0LrgMWpZcMvx3BPIe5mPIZpsSyitw
	993VNiWaZ3KS5IqF8QTEXJI6uTd5FM/Tjxuz+wqXnEBvoiqIwK4WAfJsAwTZAkEr
	EPRMYpGajcmzjbGwx15ZUreGaqncUXz1FqSp5gIha72M3qrZHVEyjekc7HL9KLh5
	4H36vHQGgKY8mMPKe5PjtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754494913; x=
	1754581313; bh=QWr4d7FdEbOlGE3vrG07XOxnFjq0nNHsAsokSmwJO1M=; b=e
	uB77sI5ewUzYFfNNaPiYWZzRkcWvJa5+sof97mQc369i8G7xoYvjx8zaGmkLI1T9
	Ytg/jqVKMk46Eg7UiPR/hSPhi006ES8IwBxoKSD4jwbD8pDHnrDlyXoJkBOpZvAf
	e7wzrsvKo8mDAe3u+7wlCBNy0/flSiiTkzD0tyrgZNJXb5GhgvB0CB55ziL38hWW
	xCwdN9BZsrfLVt9tnsfXgAPm4YIj8riu0n/fdE1qRTP0YRVsnF9ve+UPG+xxoogP
	oJhXhIp8S+SeY76C3zG39s4GZsm+zw8qKf//2u7Js+nN3Un5uqyL16yEY08yj1gL
	dBRvvc3BeRz0TQKulJQlw==
X-ME-Sender: <xms:wXeTaFP5k2z0ayqg1PpMRsU5qEbPmqpy8Jj75Ih3i82MxnR3TJ_2ag>
    <xme:wXeTaH_We0fjQKaCOB8xZJ44MZiTkJkwDnQN-eLbgL3z79S5o3Yuw4HgD_E7s90kI
    dX5EUF5qjz7kttZnG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprg
    hfugesthhirdgtohhmpdhrtghpthhtohepsgdqphgrughhihesthhirdgtohhmpdhrtghp
    thhtohepphhrrghnvggvthhhsehtihdrtghomhdprhgtphhtthhopehuqdhkuhhmrghrud
    esthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wXeTaEuDqAuHDDLpPonCoUv8hyo8xHw0fUKCaWbKxDksU6jjI-RgEQ>
    <xmx:wXeTaOUd9_Zpc4js60U_kgvcED3bCa9kuQhff0M4kUY6H6LMoM7tMg>
    <xmx:wXeTaPgtvF6S0lIEPw-hYGOfTjarLD6UVgJdcLRxxmzOsm0aGihQcw>
    <xmx:wXeTaGqSjFnBd2kKjLtUqwsvs2_w8UYC9hk1kLPp2c-G726Vww-cng>
    <xmx:wXeTaHaZy5UgXD-fRQfipAyOXEe8R6IApNQLFTi_kRRpKFnbz85FGLlh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 61F57700068; Wed,  6 Aug 2025 11:41:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tab3d7ddbd4694d8e
Date: Wed, 06 Aug 2025 17:41:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Beleswar Padhi" <b-padhi@ti.com>, "Russell King" <linux@armlinux.org.uk>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Andrew Davis" <afd@ti.com>,
 "Udit Kumar" <u-kumar1@ti.com>, "Praneeth Bajjuri" <praneeth@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <133a5da2-d161-411c-9cc9-0bad46ab981d@app.fastmail.com>
In-Reply-To: <20250806141808.4013462-1-b-padhi@ti.com>
References: <20250806141808.4013462-1-b-padhi@ti.com>
Subject: Re: [PATCH] arm: multi_v7_defconfig: Enable more OMAP related configs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 6, 2025, at 16:18, Beleswar Padhi wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
>
> This allows us to enable various peripherals in the TI OMAP family
> platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
> AM57XX-EVM using the multi_v7_defconfig, instead of only with the
> OMAP specific defconfigs.

Hi Beleswar,

It's fine to enable drivers that are only used on a specific
platform, but those should generally be loadable modules, not
built-in.

For the generic (platform-independent) options, I would
suggest splitting them out into a separate patch, so you
can describe better what the purpose is, since this is
clearly not just for OMAP.

> IKCONFIG*:
> Allows reading the current kernel configuration through /proc/config.gz

This one seems particularly unnecessary in a "defconfig" build
since the configuration is already known based on the version.

> THERMAL_EMULATION:
> Adds emul_temp sysfs node under thermal zones to allow emulating
> temperature changes.

The documentation for this option suggests that we probably
don't want it enabled.

> FANOTIFY:
> Allows sending open file descriptors to userspace listeners along with
> file access events.
>
> USER_NS:
> NAMESPACES:
> Enable user NS to provide user info of different users for different
> process.
>
> POSIX_MQUEUE:
> Supports POSIX message queues for priority-based IPC.
>
> BSD_PROCESS_ACCT:
> Enables BSD process accounting to allow user space program to write
> process accounting information to a file.

I assume these are all in order to run a particular userspace
distro?

      Arnd

