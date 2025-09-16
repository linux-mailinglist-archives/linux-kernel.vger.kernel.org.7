Return-Path: <linux-kernel+bounces-818961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D2B598E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E870463757
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AC3191B0;
	Tue, 16 Sep 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GENY26aQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1321E082
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031371; cv=none; b=ts5vjO1HVFCdrd9aPdoL/N5VjB1lX5eGXdwCDAvucSFTOqH1W4VYixltLZasWmQstrBoWVyH/yPRE4craIbs2YMoFhJ1RDOlB40ivyou6w+QGoqoKtMiHoSHuahgNpVPt1Fe7R8qLCiCWFsyhHhYNItLA2DcDsxZQNQLsDS8zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031371; c=relaxed/simple;
	bh=PrHDny6ZQpavYbWJP0mNeOkQflu1sgY9Zft6N5PA2Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNjWmD3ELFYaeE9se0dXu4h5N62UuYhjIuPKEGetiXdXVf1Ws5E6fskycx8DgZOHsaSiSFhRISR4uclW7/r+nwgN0KNLLznaUF0saasJmgIf88y0FYBmVci80kfmJUx93nhG0rQhU8EiHH/ejRcIAFtGy/tC63xgGw4YGSx6Ams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GENY26aQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0055A40E01AC;
	Tue, 16 Sep 2025 14:02:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kkzBIUseLwba; Tue, 16 Sep 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758031362; bh=6ARRZU+FBKxugU9+m/3ITFGtt9dlM7LwJqnpK0WQ02w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GENY26aQlofBSdSGwsfyoOyti2ffis540uc4wmK2no7mA9lCU8dvLOTcc1Zlf0XZG
	 1Kl8jxb/7wtK8lp9GCFMf6LGgI1vYCBit6/YF+6EoMaJXNMGDj7SIQ2kce4iZyqv5O
	 PAWosbBKyY0meAqz3uC7xKpIIK4tdE82djTba+1H35dmnLpZgVGxUUxZhat5+4YNwJ
	 MUZSCqTNnctBpFNetCAs7f+JuHwQUCthSnqn0hbn2t9FsG8F9HP8f0oFlmIriTq1aH
	 9j6LF9QMsobWXTpUq9rGD6v6vzDXgk8hB/tjwZkVCyvwZKfqBlAAV8yW1jtmk4av23
	 WSW1BCk87SicM1WtDnq07lwl0wDc+m9JchDHIpsD/cH/Mux8j7MIzk1uqB/zTVIHxZ
	 i3m8+T/rFudM9569+HYTcdpbC9lpbk3e9wQ2MV44JgCluoKNXwFxPEpcpK+xfsIfnp
	 nYYBZAnhraxxJD07so3oXFHCDK3FduffCI8KcRVNXJNb5w+Swy2scLR/gtjLvH8Vfr
	 PdRgq5RG4UVNROdaFfAi6mJCr9VUMxeoMbduW2Td47jv8H+B6Nqmz0uYi8XC4TKtJN
	 kbA9rsTcQwNNUeHNHd06rzj91OIqx5dFS+uO9xd8KIDl/4IDAz8bshF5KvBmh1U5eH
	 pIymq6tW06YN2k2NEFF6QQDk=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6843940E01A3;
	Tue, 16 Sep 2025 14:02:33 +0000 (UTC)
Date: Tue, 16 Sep 2025 16:02:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rong Zhang <i@rong.moe>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
Message-ID: <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
References: <20250913144245.23237-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913144245.23237-1-i@rong.moe>

On Sat, Sep 13, 2025 at 10:42:45PM +0800, Rong Zhang wrote:
> The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
> However, this could sometimes be misleading and lead to users wasting a
> lot of time on meaningless debugging for two reasons:
> 
> * Some bits are never cleared by hardware. It's the software's
> responsibility to clear them as per the Processor Programming Reference
> (see Link:).
> 
> * Some rare hardware-initiated platform resets do not update the
> register at all.
> 
> In both cases, a previous reboot could leave its trace in the register,
> resulting in users seeing unrelated reboot reasons while debugging
> random reboots afterward.

Just a heads-up: we're figuring out internally what the right thing to do here
would be.

Stay tuned.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

