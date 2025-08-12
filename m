Return-Path: <linux-kernel+bounces-765604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FEFB23AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6C16FBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916963D987;
	Tue, 12 Aug 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UrHwknPC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0312F067A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034113; cv=none; b=DIQXLV3pQ9EN75Wtfv/VP8Im1Y/XkPQgrxCz1BYWgshEf0m4+Ug1xHZagVopOhsmxaS8b4ekedsnnM91Nqf86WV5jsPEaHeIDV/0uSCh17FtiwFIqPSfzDICNtuvo7YBdVk9WGdHSl9E1iPS1dQrSEIsxqQbyi3YS5Cwsixxp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034113; c=relaxed/simple;
	bh=bWpLl8JcfMBDUjHpTaO+a2K06yTMRhLkFXKa0IqnP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSZ0vec8P2c89ijQ31ksf08umYfOCJPi+s0t+YuoUUQfVJO5U1lVAElAUm+99BW4EEr45OsuvuPIt4Xr9GHLMVH33SkeAKhzP+ouwZy36iO52NxkempvOh/290WEO/mZusShUXk5cU4PJoDTdqTupNX2ytT/6IOPKqh9QJpBbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UrHwknPC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 63EE440E023D;
	Tue, 12 Aug 2025 21:28:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zom92M2YPU9J; Tue, 12 Aug 2025 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755034100; bh=t+l+i2HcKoTSJllu2RucYPzM6HsCD034+o5Ss/w0WHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrHwknPCYH/p4FDJ/2zdu4H0zGpXvaItBBWBTLTtWrIorj1P1gJikg40Nh6rzuqbi
	 m88f5KBNbcyMf5wpOyLDHfkq15NBXQbYwiVHN2xQ8bUvyyBL+jBzqvfgT5nRSClcX2
	 za/zTSsVd0Sy5GoDDMsBXztlRvi29cYu10b+lTO5bypS8zSSY5bqCf6MM2U3rYwvsd
	 c1BCKrA5RLtSgO7mDqr3or2zW38ix3vmko5UBpuHIrgv5HRTl1YJXEv+eSEnDrEspy
	 zy1+5keoDFLWNusnH+f60UED+CQqCAID7RHL5/Juo3lzqdnFsv5GOGFjsrQ9+gh8fY
	 SEo758RReTQf5sG6IvvJEvscgKv1QDkDWus/pDclYxjOUYdCDe4OtGlE1NQCe3o/wm
	 1mxkzDLPSx4B69vYlvkG36bbAWXrXiys8XLiVmziMUSPBoW/XkTPlovaxeAYPx1oXb
	 KJncWTvcxuwMLiQsMmn6T2TZZ/uymdh8zvuOeKNuw9AoY9DQhNZRHh2Ph2LLnt2JRM
	 JbIOvhBTvrLxlggZ215nJyrEa5OQafyi8M/3E4Ya8BjSDYI2c8CfLiO+LPhotgL7Yk
	 rfTOThgc7PGC5W5DgJZkdF94xhYQ4rTY6GHKmB7OiPD+EHodB04IHAcnFjyyOxEqzB
	 xYi9gY56s5x5kYEdkwHm5DZ0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D7BE640E00DC;
	Tue, 12 Aug 2025 21:28:15 +0000 (UTC)
Date: Tue, 12 Aug 2025 23:28:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/microcode: Add microcode= cmdline parsing
Message-ID: <20250812212809.GHaJux6TFpbHecBTwW@fat_crate.local>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-2-bp@kernel.org>
 <f641cc0f-e542-45ef-bdb9-d8364860688e@intel.com>
 <20250812102345.GAaJsWMTNvC2ULKtep@fat_crate.local>
 <2952979d-3275-4a33-aadb-c946e1ce0100@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2952979d-3275-4a33-aadb-c946e1ce0100@intel.com>

On Tue, Aug 12, 2025 at 12:14:51PM -0700, Sohil Mehta wrote:
> But, this patch introduces code to support microcode=dis_ucode_ldr which
> would then become ABI.

... and supports the old cmdline argument as well.

> Sure, a separate patch directly adding support for microcode=off works
> as well.

I don't see the need for an alias atm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

