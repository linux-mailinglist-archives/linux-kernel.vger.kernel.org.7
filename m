Return-Path: <linux-kernel+bounces-896170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC45C4FCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA1A189EBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33257326940;
	Tue, 11 Nov 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bXvXz3Jl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670A326935
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895001; cv=none; b=BTaV528qN/w1UQm4X9OekvPyO2ophnwl9J+C1FaMdPTygtd5RmO7Thp5dWSIjH6xZ4JdSqGWuHxw945zcqpxT6U4W/itq4OvuaK9/X6+SnzAPVLeER/6+7/xEuazK3hAApsX+/8wx++DwuT/LzoBR1AAGtp7TlIccH0GaRmWpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895001; c=relaxed/simple;
	bh=0Gri1Uktw4ue+faTiyay27rNA4xF2vqxS3yWyt/1K6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3kpC5npVKr0oTrAuLnfQRz2TVrsI6mJUW5pqwx3vImM1yT9KV1zZ36Zk0RPyThDtYNND9ehaj61BSp+KIw+cWAT9lgxtu82wN+cTwQT+mzwykRcd1tG2+0eu1M8oHFJOz3rVbMZVvfNzWgE53o7Xbu7zGLqLRKTZZ59obUwXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bXvXz3Jl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 294DD40E01A8;
	Tue, 11 Nov 2025 21:03:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TAZToRNXbOg1; Tue, 11 Nov 2025 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762894978; bh=KgkHJOtKIepAScX0bEMUfY86toUrrHBXDDlRVihLwog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXvXz3Jl07Nk2PW5dwUkhV9E/DTkuhaVb5G1/G049ot2BvkHNCWV8JIqVU7CEmSAF
	 nfX/3DESmZTaAIjWTi9TW9olbCg7vjnGmJEWxMuhsE49ESAsiCslhajyJeTFrEsI91
	 aLCPJn/Wk1vOOhFdphrdnpzjaCY0bTYMmZR2bur2V0YaggYcfJkVFzeC2tFZy9z32D
	 HRdv8G6KKCWJeQPyWR99bqattgYQ77MkLBI1EN+REJtwl2ygOwALk0t9hmUDM5vJkg
	 yYB2McDByULojL3JvIE2PzxQ20FZcblTzNQLSu/jbrROBiifkL9VLHOq/+Kap+jQwo
	 0lmVD7sgqygFSU0eSRAipEIWvWugo13arWTMVBZ9VN93BqR054cWzWZcMkx9xGXKUp
	 jp5CtACRGBbDv9+8SUJSXErsT+OlCItUQOudvW+GpRDfRxLijqha+A+I3fEA3n2XXb
	 NQo8PcbIXdKrW7yZ1udDi5SwQl+MvHxFsEkdbkQ8EYgHCRT4vOwBf9TY22gqCkx/+k
	 ShBWo+cOFGPT5pvBu6jwl4ybvQrPhB33KzU4R1s2/JGNfmuBuOB9A68+8hDD1pePJW
	 AhOuvkBT2sKLvKZikA+JIc4LSqbFBiPuULsvgXX2S4afdrSf0p7VPfnzr8R+bYJH/m
	 /i5myLfGW08NW2q5sWyLlI/U=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A8E7840E016E;
	Tue, 11 Nov 2025 21:02:51 +0000 (UTC)
Date: Tue, 11 Nov 2025 22:02:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kees@kernel.org,
	Michal Clapinski <mclapinski@google.com>,
	Chris Li <chrisl@kernel.org>
Subject: Re: [RFC PATCH] x86/boot/compressed: Disable physical KASLR when
 memmap= appears
Message-ID: <20251111210241.GAaROkcWui7kjsF2WS@fat_crate.local>
References: <20251106173019.1224443-2-ardb+git@google.com>
 <20251107205020.GEaQ5bjLIU1Y7ePsJY@fat_crate.local>
 <CAMj1kXG+R0_yShENKqQj4tfDmUqm6OPEoMTdWADnjLb+2QOOZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG+R0_yShENKqQj4tfDmUqm6OPEoMTdWADnjLb+2QOOZQ@mail.gmail.com>

On Tue, Nov 11, 2025 at 05:52:58PM +0100, Ard Biesheuvel wrote:
> Yes, better, although we should still clarify that only physical
> randomization is affected.

Right.

I'm thinking we could take this fix for a spin next cycle to see who would cry
out and why - ala "hey, you broke my super important memmap= use case with
KASLR..." and then see what we'd end up committing...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

