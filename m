Return-Path: <linux-kernel+bounces-857982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A05BE8730
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F53AF15F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060BD25FA1D;
	Fri, 17 Oct 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tkumv47u"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536B332EAE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701761; cv=none; b=PL+I0SWjlaNuAhFgwwDQyQBPdNWKJJ6PH8n8t9ipTTPkVd47f/p4FXTU9m5KfQ+wYi++9aMBi6ly1bps+HJFpZmZGhhcL3TGUwaXrO9SRx6ECzNFRORC4oW2a9c+rvTPV5wSGipuhGTlCSrc9Ov61Y0ZGpmm7Qp01opAjAa6M2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701761; c=relaxed/simple;
	bh=44S46y+nWpOLfu6O0H2bwXFK4yVhFuRHLGVYBzHWRdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA/B0OIW7u5IFO1rVgUWoqnHAlCU0+VSfKRsAEg4g0FecadAGI93l8LaERUynRkkUPyrEDgoKlKaOHDBoKVwgjTdaAiZcpZMPlVvI2ivntKfiuoS4kqdGcEduARpNRWOJw72gDPof2RlWFwQ+Z4XqD6SorqMR0Rub9fiDCckzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Tkumv47u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE9BC40E01F9;
	Fri, 17 Oct 2025 11:49:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lD-1nPFIjA6V; Fri, 17 Oct 2025 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760701749; bh=mZQ8jQbe+LzMYj7Qz3tVp/6j8HTVnhmjlj8KepPo12g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkumv47uvdD6BVenbuM8RY4GKaFdxLd/6pOqxp2Ccz66EPKyrwM8chjFPBGp7iiXZ
	 Ax/DXePLaWxvVbVJQTsIeeZvtm0wH/9/SMBTwT1oxu/2E5LLOQdu6xF2kHMC6aMgW9
	 E4/6fKv8Ol3hNXqI84xi7YuHEyJCoPtd90wtUaQFDqYId0o11xB9ISj8sSpKi3TPJA
	 ZEt8qhAUNgRMao9yo1CI9B1DRFHNKmGIyNEkOiN4Z+5hmVr715mkOSL1CLs9ZDM1QQ
	 oto2F3fk7qt6ujGC2xQibxsFiNWmCZ5OQvAxmT7iy7Tu7xR6eKsaqTNM6JkGhv+0xC
	 1u+9SIJUd//Y1xUriVzI3JDc/q0by4tqaBGy94NdKzeE4YR2SgH63ojyBRkQEO3rOp
	 8rmk832lsi+YoNZy1Qk0WqoLZllk5qFdAyZaJ0PI/3LRLDkDxzaFzGg/aQCiDAAoP0
	 lSKa/0cvoYOn5aP4EVas2LqixCtWyjeQfSXl+4Cyv9ip6XajMdxyp2ldXTYPcQriZ/
	 WWyZSww1zPXLOhtlUENrANRnwH3LTeZ6dnDJFChqJDOLnpAFbIfViUJZzJH/NmhHCe
	 4XYGZmAScT+Ixn7v6noenPqKtJs2Ts+JmqC0FiGH+MhLZHTg3to0jcpmw9wT5LbFWC
	 4RsyfZjLiUL6DAWWkmtvp8bw=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8383440E019F;
	Fri, 17 Oct 2025 11:48:53 +0000 (UTC)
Date: Fri, 17 Oct 2025 13:48:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@kernel.org
Subject: Re: [PATCH] x86/amd: Disable RDSEED on AMD Zen5 Turin because of an
 error.
Message-ID: <20251017114844.GAaPItHGKgL0yAPscH@fat_crate.local>
References: <20251016182107.3496116-1-gourry@gourry.net>
 <aPFDn-4Cm6n0_3_e@gourry-fedora-PF4VCD3F>
 <94BA6EDC-5C44-490D-B6F5-0E38C8822F7C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94BA6EDC-5C44-490D-B6F5-0E38C8822F7C@zytor.com>

On Thu, Oct 16, 2025 at 12:39:43PM -0700, H. Peter Anvin wrote:
> The vendor (in this case AMD) can then root-cause the failure and provide
> a narrower blacklist when the true extent is known.

Yap, we're looking into this, ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

