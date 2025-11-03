Return-Path: <linux-kernel+bounces-882589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C52EC2AD33
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594623A299A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9502F3C09;
	Mon,  3 Nov 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MfNDXgll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1elUl8o"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A92F39D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162944; cv=none; b=u7AJoLytxgf2XtNbRWvyahNNNLdNzAmF6xB1mcWZ7XWkmEH89PTx7SDrwqfSqFLbSaa2S8PMKoaBJlZckO10FaOC3n9tMySULO/6USWtnYyaLAwMOlMn5Kti7uldW8lVii4L2gHrjviEeEzeNldzxahi1kiW1h0MolD9dj9+n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162944; c=relaxed/simple;
	bh=8aRlSrjcsiou218Cd3G7swzIr9i6Rv2CkcQU8BtocvE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mr9RM6fbLVwVl1IO4u2b8XcawS+py1mQdSxwEAub06Q2ROM3VlzQwZZaQCmAaJwgccGNImkwd/80vEpItZbWQrxMA07EWqkrTFzaRenTK9+aBFsbho31vq/NNXZ5bML2ZaFGTUpZMbxPDrhaDEjF8RkKtxIMTnhfOVsVtCGUDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MfNDXgll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1elUl8o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ACD5C1D00123;
	Mon,  3 Nov 2025 04:42:18 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 04:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762162938;
	 x=1762249338; bh=3soi5gkrEvhyDl8VcaSq7F20jBZDryhHBE5Pc3oBcmw=; b=
	MfNDXgllAfNShHpKUN9McDERJ0QRAPjv3rRK4HqL3a8lpLQUikde6HPdq9v1jc2o
	VVpSFqEqhH7uJzs/LwdFctGebJqoN3AVAHawWZtftjIfQFluLkQ7lh1HLCZmG2+B
	npKZR2top3ADQp1KEyV6zG9YLDEwY0KyC1Y4YFQxlojyD7UYHO5Pzbv4ZyrjtLVK
	UG5wRQc33Vy0YSgXOzm4/qzBz+Dc7yblGbWhgb/WYdL8vsRNq2o2cxeG2tY+ulTd
	4LhyZe3kRgPdHLzMHJqYt32X5+1lkUWmvPIW9lNnCDLrQwB7+hqUJJhIX5GBeUJF
	GcMPBIf9LWV6mk21X9TAaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762162938; x=
	1762249338; bh=3soi5gkrEvhyDl8VcaSq7F20jBZDryhHBE5Pc3oBcmw=; b=I
	1elUl8oJ5G8nmOep6z6AJKyyDRitG8YU4DkfiP5XbYJjS1SMLSbCTW8O/RmZfs/0
	jWpEiyxrvag5VQFyolKl+k1EVyRqJN7cajMoS+zzfmxxG133alF4hKVDoWfHSIoz
	rwWnlwpxuTRF84TewHIczP12PpflFo61Alguj7eCrWDL9B6yon3gwiVcO1pT+GUZ
	JmD2oooqmBOWlO8Ch+1inApLB3IWGxnSb2kBiCdtuDDmzVL4ywBbL/61uSp6lDyq
	wRy002cQYypBeYBD8pfCigh/RvnEThewUkkPQzRGxaHuA5sRMMhxFdSrFEgpawQm
	AETqvTEmnrxF81QMZoyEw==
X-ME-Sender: <xms:-XgIaVXBNuRgXkfLUB__WZngiqc9KLF3eXxw3zF2F-zESL-ptPTzdg>
    <xme:-XgIaQaD7Sioc6ZJNFYji3p8hAs2zMjZmG02cbC5VT73WEdTgyIDpDeXwCwF6SV4B
    egfGdDAp2if51h_G07EI2C05HA6GQKT7ME7D1KFmpZEsPEaJ5z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtph
    htthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhho
    ohhnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigseifvghishhsshgthhhuhhdrnhgvthdprhgtphhtthhopehkvghrnhgvlhesgigvnh
    dtnhdrnhgrmhgv
X-ME-Proxy: <xmx:-XgIaV2uCHUxrXPs5i2IX6o3mwwchwfoyHXNm8R6CHuebO5ixbdVIA>
    <xmx:-XgIaXDqRZS9Vrlv84vqNxPa8-FeGw3zlPaosr2Z8aM7V-KN21YAwA>
    <xmx:-XgIaU7orT-gL5i4x5P525XWBaJIB2RrQTVfy9uXH-071ShDdxZ3lQ>
    <xmx:-XgIaYIBeCYPWc2FUjToKRHPdtJflfrwcOVRgInz4M-NlweXcbSJYQ>
    <xmx:-ngIaSBiTD2VV4dtSwfedO0welJlpwgjBHeqBDFAsdmCNacRIGYqjEvv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5388D700054; Mon,  3 Nov 2025 04:42:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Nov 2025 10:41:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "WANG Xuerui" <kernel@xen0n.name>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <67802ad7-c41d-47ac-a231-abec1e5aae2e@app.fastmail.com>
In-Reply-To: 
 <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>
References: 
 <20251029-loongarch-uapi-ptrace-types-v1-1-5c84855a348d@weissschuh.net>
 <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: ptrace: Use UAPI types in UAPI header
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025, at 10:12, Huacai Chen wrote:
> Hi, Thomas,
>
> On Wed, Oct 29, 2025 at 11:20=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@=
weissschuh.net> wrote:
>>
>> The kernel UAPI headers already contain fixed-width integer types,
>> there is no need to rely on libc types. There may not be a libc
>> available or it may not provide <stdint.h>, like for example on nolib=
c.
>>
>> This also aligns the header with the rest of the LoongArch UAPI heade=
rs.

Thanks! I ran into the same issue for a different series, so this is mos=
t welcome.

> Thank you for your patch, but could you please tell me some history
> and user guide about the three styles: u64, __u64 and unint64_t?

The kernel uapi headers use __u64 etc so they can be included in user
applications without clashing with any types they might define themselves
auch as u64.

The uint64_t style types are problematic because they are provided
by toolchain in userspace, so build-testing the uapi headers would depend
on a working (userspace) cross-compiler rather than just a minimal
(nolibc) toolchain, and because the standard headers are meant to
only be included if specified explicitly by application source code
rather than indirectly from another header.

This was more problematic in the past when it was more common for
applications to be built with pre-c99 compilers that were missing
stdint.h altogether.

    Arnd

