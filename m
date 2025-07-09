Return-Path: <linux-kernel+bounces-724310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C266AFF124
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4127E542024
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C223C4FE;
	Wed,  9 Jul 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a4AsucSX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423923B637
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086901; cv=none; b=raRxnVNqKVIBDvb+mN8VB9/11fzAWG6JZ7jr1xwvCkF2sGrc5gssp520UCMZrKpM5kYyKl5Bzl2BvzsGO+dWfl5TISI/hL/oL4fJzPZWPeIpsczyx81tAox9nKUWJaYxsY9ZNG0n/niqgkijvxr4V59/PwGRz/hGXL1mHf5CuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086901; c=relaxed/simple;
	bh=kRXni/mEFqTdjnWBv9cZRrFX+Hyv2PS35ww1V8CjtVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohzNk8wEhCwxFdi9sg3gRvBpfWavnq7Lq4L3V5HcsqJegKd30ROXmExIPu4RIEUs7oFW7W3s65hd0ZrKmaJqTb1U5lPc2e4kdcU35i14BC2A5vd4apVmoXm/VbpcFKmkLu2RFwEIEP2pb7iJLW5MmW0eOLkci+HMKO0jF4j9WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a4AsucSX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17B3040E020E;
	Wed,  9 Jul 2025 18:48:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxSYseGqL1_f; Wed,  9 Jul 2025 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752086881; bh=DtPAa2qCwF3BfMNm9Tw5QmcobxR2g3B+RTBEpBvgF6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4AsucSX8fIm38F+Y5vC+vLwlir1B21smVW5ApBVcwG1dh406H3S2ee2P+sGJGbwf
	 VzH7mnAAnFsLTFanURgf7zfFzrBBnBp43nOSHD/WhsVPu2igtU7OiBBWZIcbopqjyc
	 x4d27mGmAKWrTNpy/QcbA/itiqB91ub9WYv6J7IuRt6mzU+PQ4++lPM/SsqyTKyLm5
	 AJNdDwEol6DOUilKg7CSWHlPSaVmjBkwM2GUkDvolz4bX0Vt9bDPBE7rOHGlR9LidM
	 BMb1B9DGSVYL9FMWEoUYPhpsTL7JBT3escPDt+jvzvSvZVWVqb8TwXF+TtkMO5RvPs
	 aFSqQ2XUxOwKpXBetjpeP9J+pTCIqDiUhHkc5J9uWCuN1Kc89G7AUYmamkYbXrIUbd
	 jAz5yaZx8iBk4iFzNss+A+nibWdOs4SpjK8hKIkOQHAM7YBxLdzXsQyJsRvqanGIjT
	 xov0khX7OJx7NndjABboABo036Lgs5XrGq+Cg+tGiE2v/XpfWmzDWNVvfPZSpJN55N
	 IlyVDlJGQIS8F44fr1qFWMBBbqlxo4oDbo2QSTTCJIKluHsBOdmUsndXtUXs21rvQJ
	 7F7k/gGY7yjGPfqOJM/N8n6IWEluu2XBcJQvfGZ9MneQn7pw1gscBf3z+GmIXyI41t
	 xHDrYYDVdmX5jjCtuBRqicRQ=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB1E740E01FD;
	Wed,  9 Jul 2025 18:47:50 +0000 (UTC)
Date: Wed, 9 Jul 2025 20:47:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/21] cpu: Show attack vectors in sysfs
Message-ID: <20250709184744.GAaG65UAiz8L57MefB@fat_crate.local>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
 <20250707183316.1349127-22-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707183316.1349127-22-david.kaplan@amd.com>

On Mon, Jul 07, 2025 at 01:33:16PM -0500, David Kaplan wrote:
> Show the status of currently mitigated attack vectors in
> /sys/devices/system/cpu/vector_mitigations/.

Right, as discussed offlist, let's delay that one for now.

The question is: should this rather be inside
/sys/devices/system/cpu/vulnerabilities/, as it belongs there conceptually?

I wanted to have a subdir:

/sys/devices/system/cpu/vulnerabilities/vectors/

but that needs a bit more glue to create the struct device, etc. Not sure if
we need all that.

And the sysfs stuff needs documentation in Documentation/ABI/...

So, let's discuss this properly first as it is user-visible and then do it
when everyone agrees. It can go in later as it is only informational anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

