Return-Path: <linux-kernel+bounces-773856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E72B2AB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F8C9E06CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428F2472BA;
	Mon, 18 Aug 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FmBdDsJJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682D24A05B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527509; cv=none; b=SIQWulqVhB/eXFeiu4O1yDVQq3H4NPZ2s7EOl6zFqRMWEtcEzMABPsXh0uFDJ0iPM6fQGSDKiPI764xaR1iz6BJJ7XdhromScJBBX+6xKIII/VW2GdaZwSAGYrf+Vw09EE5BNrD4nbo6VRz9p/eLl8bYnrtQE3lFCEKZdB6MQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527509; c=relaxed/simple;
	bh=H35AqFhE9vf8q6g0jToXYzEkYxqZTkp/ncpC7ZptQqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDBpH3k00ynzGTB+pqsQIHLnsutFA/65Qfl/xmUDMhmyi1ZQ+Hc7Pcr7AVCwP2d4xZQoH4VpufTdhhNvSeZj5RtQuPlemwtrkZL8AP1Jo+ftbJlDd9p7gBKXrFFFTsa8QBkqnAUzt3LgzeS9f+nTi5LuLPXnT4hRyvh3s000zMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FmBdDsJJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 368F440E023B;
	Mon, 18 Aug 2025 14:31:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2uyVxojAeshl; Mon, 18 Aug 2025 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755527498; bh=edxOOclTXrjoLplZzYIso8JyrxanTdeyvf0v0A9i2yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmBdDsJJEOm+9WAf5xQ9QfyVFfsbs+i52/hplurvwopZIobWwCjis+XbiohDPgpMj
	 IpPcYKITwrtYRJ0KzLwXUe5+LgwSCaaWJXphN7gqy/d8jy2HlpP+GcvNuzyJGran+5
	 KsuqYjAcZ92v+StOnqj5hzSIYZOn1130/RFQcEiOXnpSckkKQS+qs+AneRdn9/v4/y
	 15440p3k2JuLg/lVxiCcnjGtLmfZa9zVGFYj1QMDB+l71yC2GlUMBz4MEN3qOfM/7B
	 JEqb14reeN7UXLeH3h/aYtJxIromQamwYTLgLib8wm6jCUanIfkHL8rbfX7/FdFx/h
	 rWtoQ/h95VupkGrxinhVRT0pUIn23WJwA9xvuSPfTTNmcye5EHKFtC5Yox1EFlXszf
	 ezFsaXEEAq6Wt9uTm5n3D/pBKUWJUhnJ7b8YSvPvcz+K2Zr1jnbq77lc+KN6rRHHzB
	 FTixN/Ma7zxr+rtCRxVWrUP3O7elU3xFwkVT5VswZAqL+XnZXCUnOK4QaHMAujXylZ
	 +h5pTv2qOHOopHL1SNOwp/2ylorO/bpVjTpSDjX8Y84zODVW8nwtdCzUwbm/mPuJ1N
	 ulwy1U8TaE6DCcKEDXW1YzgUCseG0DYyhWQ6E9fK6URc4+KmH01y6FxGSdFAKpoMKs
	 Qei40JXVlOvcfHd0l73xLedw=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B63A140E0217;
	Mon, 18 Aug 2025 14:31:31 +0000 (UTC)
Date: Mon, 18 Aug 2025 16:31:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
	David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250818143126.GHaKM5PsVZPXwr5sPi@fat_crate.local>
References: <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com>
 <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com>
 <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
 <aJ-pJvrPyHyPI0qS@google.com>
 <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
 <aJ-5XDXp1CxKB_7J@google.com>
 <20250816084218.GAaKBEaukeGa6b5UBj@fat_crate.local>
 <aKM3moQgdlqr6qIy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKM3moQgdlqr6qIy@google.com>

On Mon, Aug 18, 2025 at 07:24:26AM -0700, Sean Christopherson wrote:
> Most definitely not if the guest owner and host owner are not one and the same.
> The example use case is where the platform owner is running one of _their_ kernels
> in a VM, in which case that kernel probably does want to know why the platform
> reboot.

Except that can you control who uses that feature? If it ends up being used by
a VM stack where the guest owner should not know the reboot reason, you've
lost.

> The same thing that guarantees hardware vendors adhere to specs: the desire to
> get paid.

So you're basically saying all HV vendors return -1 for an unimplemented
register and we should be fine there?

> And QEMU did return an error value, 0xffffffff, a.k.a. PCI Master Abort / PCIe
> Unsupported Request.  I would be amazed if any real world, general purpose VMM
> did anything else for an MMIO access to an unknown/unsupported range.

Ok, I guess we will know soon enough. :-)

> Huh?  Handle a read of all 0xffs as proposed in this patch, and this is unnecessary.

I don't trust that all HVs will DTRT. But ok, I'll take your word for it. We
can run with this and we'll know soon enough whether fishing out -1 is good
enough. And then we'll have more fun.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

