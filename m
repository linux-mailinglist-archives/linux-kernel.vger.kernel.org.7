Return-Path: <linux-kernel+bounces-764564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF40B2248C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865C93A1EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF42EA749;
	Tue, 12 Aug 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d5xzev2N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E711ADC93
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994417; cv=none; b=s3bAQm7udhkvHwjLUPrtcb8Gs866r5y9fA0a80GOWJRtopfGaL3GsDm8YkVc+5nupC6cEmRV0YvVsTT8dnDIEiZNqtXVsd0RFu3LfHZsM22opEpge/G0Ab+vTFi/PhSEbXB3jKvgd/SdHTt1OHhtJylJThfciLL7Jp/ib7nxm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994417; c=relaxed/simple;
	bh=248i/TQaydB4tK/sAEETY/Wx5/9SrZMtxrH7cd4BHaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfbMHGVWUPgmG0Y9wejjbU8ML+T4j/SZFVceYlEHujQ06GRHPiJUXnCh+I9o+TNkDIHd4Sz+fx9fTh6SNLPY+cRl93osFhfvzJv+rJ7ge92ks1GzznM9lz7GZuz1rMlOKSfI8znJL8j+hYVVTIwea8EvlULu3W5khmPVcLez5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d5xzev2N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3186140E0289;
	Tue, 12 Aug 2025 10:26:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P2IKCEk1bFn5; Tue, 12 Aug 2025 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1754994410; bh=CDFYRj2vGV62w/NRIz9FwWWfV8/QbLMY3IONIbub/OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5xzev2NHz2Z0YVsufkmAocKzuQ2RTAI9rnqeMrQXcKxLj1V/GtdUJsHZDYFdGuPN
	 fWXl8ePQgB46p5tcBOzHM2J919ECQsHin22E73Orrz9/yLihExB+jZw+H6euksGRZU
	 OJCS3PEYLwM9v3pMWmRq7o6QanRuea3Y47hz62RdbwfAxupCFxo/ymKU4GqHBjQI10
	 fPDpW60ZTS0WTHp3w55OL6UFAwLeTpHSmfgVn8Kn1cE2QwDiqehNGNWbqD/bc0nb1Z
	 A7yiU7TqqdGInIosVnS5qBzplIkrPST/mj08u5938rOs+eEyT7bzRZhVfqlpMdCEtF
	 m/w1aBHeKAoMTXvFzfRizA23nUinIto6//0LhcnssJqyUwS9jREw4x+JaeUiX+lWFx
	 r5xc4+6oi7L7d3n6FfSf4rHjc1Zr0SyeP4FuYZVxJ2zG+yld5446+/qsDFdsLWcI6h
	 b6aqo+/EfPRn0q1/zY+UWq+By1QaBIyxJ2/45PAUy7dckFCrVvUGkk5VOmnlicGAqm
	 vtUhjuNdcQYx+kGQ/fZi/VrMiVTS5q5wiggwTt03Cf8lS5pR8Tu58Pn48Pq1nVP3U0
	 I5naHC6Tub4z2el0knjnx38e9HLkxv9nKPPRm+XrS3wYUlYWKSUUCeM2pnbzR5ySNf
	 RJcJKJIG6OXv74sLlyDZPR5s=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A78EF40E023D;
	Tue, 12 Aug 2025 10:26:46 +0000 (UTC)
Date: Tue, 12 Aug 2025 12:26:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add microcode loader debugging
 functionality
Message-ID: <20250812102645.GBaJsW5cJLYc90Fhhg@fat_crate.local>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-3-bp@kernel.org>
 <82cdc358-3551-4c8b-a387-0e9da4668b44@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82cdc358-3551-4c8b-a387-0e9da4668b44@intel.com>

On Mon, Aug 11, 2025 at 08:04:58PM -0700, Sohil Mehta wrote:
> Since this is all new code, would it be better to use the expanded form
> of dbg everywhere?
> 
> s/dbg/debug/
> s/MICROCODE_DBG/MICROCODE_DEBUG
> s/ucode_dbg/ucode_debug

No, because I don't want to type unnecessarily and "dbg" is very clear as it
is.

> Also, I didn't understand the "Format: <bool>".

I think force_minrev was supposed to take a bool but then we changed it. And
that remained here. Whacked.

> Isn't default n redundant? I am fine with keeping it to make it obvious.

Yes, we're making it obvious.

> Should we also include a dependency on DEBUG_KERNEL?

Because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

