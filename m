Return-Path: <linux-kernel+bounces-781636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713AB314D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DD1894681
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F22D0606;
	Fri, 22 Aug 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HJFmvke4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156A2C0260
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857425; cv=none; b=OANsRZ+sm6wwsrWCcHp6lOKXPRkbQKH/YzmDH9J/CJg1k48EF9EjyZdSpWnPD5sS9XG45d8M0eom0Ypq62+rXke0WBWtfGOzuIE6p2nBZR9XqDTFDRdMcNil+kbqRbu/8TuT45PzdM1AJ61Y//Yqb69Rju9W6JrFQWZnhPYeMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857425; c=relaxed/simple;
	bh=2NDL0g4VYJR8pO6ElBBS7KJwyhMOrzLqNF+7oR5P4AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o65SSzshvUduudzEalubTccs2OAuRkHLP+TVKV/BR0meBr2ncNO6x0of95lJIKDcpdUu7dhyMPR8csUcSFl/OWL2+u+gtLBU7HQke4CIwDkBlgC5m7wpAJI4X5xHCEkQu2f1M2OEZlq/pNjdfhuNBmt5ozXOwDgx1J3uvHLUTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HJFmvke4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E506B40E0163;
	Fri, 22 Aug 2025 10:10:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xxKP9z2PcPga; Fri, 22 Aug 2025 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755857410; bh=nQ3jTNpFABgzfutzhXjagBmySm6lNf3+A7dyqfRJgI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJFmvke4DQwIGbHwmtDDdtEdthOW/+0c35ryMhbTOJxrv1JOQ3gOjh6a9hg+39SBP
	 wYVlzsMs2CQTRfs4iw83KyrZ+LgWhIoVBUg47DuFCzheG7m+8hThx5uqjWt/85NXX/
	 f1jbhXJ/Qd5l8cCsxOfEBWjvxicspk+fXcJ3YTC/7XDNCJpAkSVoTMh2IUS9BgYRCB
	 M0pzfGwuU/ZYSfFAYKURlHpbDkt1F57z1jikK5i+JhOQjxVVcQ4vBP3pn0F2cR09oL
	 b0ALozZnq2JF6WKggs+1cb1KgI7SupVp4kXs3gDVfup3VeC9B9RHfn9wnNYpRxt4bc
	 UAxsYU+P8d7b1Vf85GpEpLl3qALhXSbfoLRjdfezvjFkLBUDjZkBGyNlOARtzh03M3
	 kfDMtUKvAu2PDbnF7N2u5bY0uAAqS9Zb0Y5YUKExLUpjS+ToDnNAWD9Dr/H7nhzUjs
	 cr/5mMDuVrdDBHQ2mQSmp00m6GtTHdkQ0OdD+tQTcdnzEfxFQiYtqYsRQKoysEyaZJ
	 nT420gLbc3AuJOufsU3h2yW1HNiqWkHnQNWNBWu/Dh4O4HOzbV3J/bUdfq4SdEFQBd
	 fiflZjctZHssV+rvmKyccfz0ENY1/Sta3HY/wyhlt7ixx39PxOQ9aU6GBiQKcm+iRS
	 HALXBScjlvg8eokrTUkHLsNI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22B1F40E025A;
	Fri, 22 Aug 2025 10:09:57 +0000 (UTC)
Date: Fri, 22 Aug 2025 12:09:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
Message-ID: <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822004422.2908427-1-sohil.mehta@intel.com>

On Thu, Aug 21, 2025 at 05:44:22PM -0700, Sohil Mehta wrote:
> The kernel maintains a table of minimum expected microcode revisions for
> Intel CPUs in intel-ucode-defs.h. Systems with microcode older than
> these revisions are flagged with X86_BUG_OLD_MICROCODE. For more
> details, refer to Documentation/admin-guide/hw-vuln/old_microcode.rst.
> 
> Add a simple script to keep the header file up-to-date based on released
> microcode updates.

I can see the "what" - you don't have to explain it. What I don't see in this
commit message is the "why". Why should this be in the kernel?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

