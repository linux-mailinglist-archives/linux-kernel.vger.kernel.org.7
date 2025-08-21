Return-Path: <linux-kernel+bounces-780391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F00B30127
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458BC1CC15AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC35338F32;
	Thu, 21 Aug 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="abHDYrrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXvpxP7s"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C32E0403
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797648; cv=none; b=Ui1abOiCH4kNTrFE89+NOoIq+xo5kGesv4jCdV3uaoD3JuB7zcx3jr/5HxDzoo539+kSZA3+d3e+seM21LfVxq9asWALNNGRT/keyyn9cy8LW/aLmiKzt/e2ZhpIZ62MoV61HgtwWdT+PgPijFkx0VOtac16W7FgigA/JBTu9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797648; c=relaxed/simple;
	bh=0CUP4VNukSdHxiJKNwlE2m3BWKPD1A03vxlY0Ing36w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tkQDGufU0FvmJhmlqR1DpMODfotf2rVWuRM24Pg3VzP4jXNrxm9cooHyXjinyvt0+cBqBTOdpTpBCIJUNyUoPr87SgiZS4/DH+rLcQJUlh1sGGiTkaC4EZc6PKMxQu0WXL3j6tfEhFnm1Oe4VTSt60gjzqzF6W/3l/9b12J0UfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=abHDYrrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXvpxP7s; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CA347A0118;
	Thu, 21 Aug 2025 13:34:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 13:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755797645;
	 x=1755884045; bh=EsToxIhs3qij5k0TlvhYAZ6ZeEs2xGKM/ioIEqWZzi0=; b=
	abHDYrrA/vmmbFsqKaWsekyFjqAQenTF53Q4QMvPFjsVbkp1+Nw2b49jaggY3rPS
	fVGfmin6KpS7A4zUDqkdvuXC6l/lvAmmNbaRzXD5wiDQmuWN6qSm7fEEJBHhBNSn
	hYzX8SH0gYiqg74oSH/w7JnRlkWtemnUcC6UjZPtxAuTNLYEn/n3tuRPuf10pvJV
	DqhBk7N+Bpwyttk13jAx1AGBO9NFrg+RHFlEa3ufXu+ZwiS8Ra810ndDetbLtZra
	PptpXllnirUJcm4h73jxY94zm+4dMI16L2TnYoup5k3lfpnDbkSf4WiaSSNUfR1+
	DrKWBDneywXdOCnxiNPRjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755797645; x=
	1755884045; bh=EsToxIhs3qij5k0TlvhYAZ6ZeEs2xGKM/ioIEqWZzi0=; b=D
	XvpxP7s61Tk2DhKAMJ7igPM6PTTHbsNykDIqzSiD97OJu2IehIjrnMG4v7oNodzQ
	0evzIvcLGai2qyT4Lh9giL5OxlqWHHbp3TbtpS5flAwQ/ujygtj+nSi1v0C3T6DM
	XEjPN1HLMztypf10XzF5z9j5h+BFe90Lj+AdZwMIkxTt59X7YClCH8+b55npyxru
	/O66eJadms/0qROA7BqKqjwkiX41Uu+1mVH98rxT123TdnaXltKkp4fox9RvgwUG
	Vv8Rb3K7tcjsZSOPO8XHg0mJetGn2CdSsEohGg8w3+iNwQrI1X7c2Quxxw1XJjqx
	em276y44T8SEtJus7BbnQ==
X-ME-Sender: <xms:jVinaG8bqCOpLQI3bpwxqGge9bNpEQb9bXBczVj8z8qDXDtEotP30g>
    <xme:jVinaGuEgwsJgPkENPrXdCs87CJ-I1T-SRSbEm86jwhlBKdJsM9j6yb9Mp17Y38P0
    V81DHsKv4C1QoG8Y1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrd
    hmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgr
    shgtihhnohesrghrmhdrtghomhdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvg
    drtghomhdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    fihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhn
    uhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jVinaK1915WI_Khi3OEhczruA7TAKWAB1bnxcikbU_ZTj2ds3zIjgA>
    <xmx:jVinaOrsLBKftU2e5p6s5_G0Y2gzLwH20MI3TIQe26r9CsrkQO9PFA>
    <xmx:jVinaJMCf-UKUaYgJMHwdLJQ9daLWh0_Rw2JlGuv5dAPTA-Lom-Dnw>
    <xmx:jVinaHpjjiC6S53VBrHRZ2nuiw6B_Etq2cVQmiLVe2ljgnETfscq3g>
    <xmx:jVinaA8KpTCkerWWNO0Q22sHlynbYhiWvnxV71zCih9jDoBrOaJpl0VC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EDD80700069; Thu, 21 Aug 2025 13:34:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARsIESC0lKmw
Date: Thu, 21 Aug 2025 19:33:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Cc: "John Stultz" <jstultz@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <8eac39c8-9db6-4dd8-92bb-3dbaee9d80ea@app.fastmail.com>
In-Reply-To: 
 <20250821-vdso-arm64-compat-bitsperlong-v1-1-700bcabe7732@linutronix.de>
References: 
 <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
 <20250821-vdso-arm64-compat-bitsperlong-v1-1-700bcabe7732@linutronix.de>
Subject: Re: [PATCH 1/3] arm64: uapi: Provide correct __BITS_PER_LONG for the compat
 vDSO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025, at 09:56, Thomas Wei=C3=9Fschuh wrote:
> The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LO=
NG is
> always '64' even when used from the compat vDSO. In that case __GENMAS=
K()
> does an illegal bitshift, invoking undefined behaviour.
>
> Change __BITS_PER_LONG to also work when used from the comapt vDSO.
> To not confuse real userspace, only do this when building the kernel.
>
> Reported-by: John Stultz <jstultz@google.com>
> Closes:=20
> https://lore.kernel.org/lkml/CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU=
0fpurrJFDg@mail.gmail.com/
> Fixes: cd3557a7618b ("vdso/gettimeofday: Add support for auxiliary=20
> clocks")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +#if defined(__KERNEL__) && !defined(__aarch64__)
> +/* Used by the compat vDSO */
> +#define __BITS_PER_LONG 32
> +#else
>  #define __BITS_PER_LONG 64
> +#endif

This should be fine as a hotfix, but I'm worried about this
coming back since there is not enough isolation between
uapi/asm/ headers and the vdso. We've had problems here
before, and arm64 more likely to be affected here than others
because the asm/ headers are not meant to be included from
32-bit compilation units.

A better approach might be either to build the arm64 compat vdso
against the arm32 headers, or to change the vdso code enough
that it only needs headers from the vdso namespace and not
include the uapi/asm/ namespace at all.

Unfortunately both of those require a substantial amount of
work, and are not an option for the current release.

     Arnd

