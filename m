Return-Path: <linux-kernel+bounces-864858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE68BFBB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 191655082CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD11343D7F;
	Wed, 22 Oct 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BAhSnTry"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129B33EB09
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133430; cv=none; b=R3JgadqonccT3fLA/+URKRCmQ8hMz3TmMBwVOb/Yan8aoCYSITcg+PosWg5ie/8W9n/QmcIJJkcae7sChskQysxw/8LuLm0t0vbtl0rA9gmT6V7VwI+BxfZh73XuZJCP+Zz4OsYB4D5A4OwQWJ/1LiKSRGQl+NpQAjxX7D6ESy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133430; c=relaxed/simple;
	bh=BMeHdpCa+288/3EGr470fvb3rdcSMNT+/o+mobDYNxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2U2DgctNhLNkYY3ZnSfDVa1kdN4O1zWupX0AlMuQ12PEeygTijK9QqsdIGebf4j4wd3PJNGG4xenPPVslTmh+t7A3Y/jjYkaljbsZpQ07W119XoXvFcOc5jpRNOUUM2OidWbmKtZJ5TZHYFCAr2zpF1tZGv2G2dojudCnKlM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BAhSnTry; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 559B140E01CD;
	Wed, 22 Oct 2025 11:43:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jF8Ivx4SZ2Oy; Wed, 22 Oct 2025 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761133419; bh=/fvfaOU9LSgrOfryAyt6sWKYeHaNZPKvlhcaPhR8y8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAhSnTryMbQyVYPBSocjDGp+iK4B20nSvI99y8atOKlTj2AUldmRjAm6U3xR14S1l
	 lNDn07W+gzRM7q6wAMJyKRBs06FCivPLS1W23y165MIdMQeEewx28dQKJOzljlUkIj
	 15P+8TR7u9rJ8iOVwsSk3cVIaI/3gGKkNthAEh9I4zoP5KyJWUnHTM/x6lMAll0V91
	 J2DxUQ67+uzeNf3iWQavXoKSQmKK37xH3aJ8J8yEdx1odOsaakR7FIxKJ7F2vDiMeg
	 RnUaoeoWED2wAt+V/MkBVhkKF9fw6cHPvYabxrrfZ3w8uOc8Daa7DQ10VFUDbM77pW
	 agyCkU2rCO7OPQn1zMUwXiJZLNGpHoE1e+nevrk4KCu5LsPUWcsfhTqinGaJqNL7PN
	 h99WyXcL+sC33b5W1rFyGGlFKmEI1+AWNBXwVCPQPU+6ccwexZ13UFTTVuqgHBWa89
	 zeRg3trGMW7mv4FkvI53FRSX0weklL/umXfRI/5hYqdxeKwe/52rBgzyNtnIEgJWo6
	 z14ZSLSWwqiYOCgTmI7HQbur2yzJDKIGXp9zKzs4+Y/nko5RGgBW7t59PmIJC5Vuk1
	 gAkRr+ITsvGJeK0M+rlTxXb0Oe0uBEn/m0nu2Kkl62NA5ypaCUqJfGdj0Glm8CUBqH
	 0OHRDb565ImTJuI5e87H/dOc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C408940E01A5;
	Wed, 22 Oct 2025 11:43:26 +0000 (UTC)
Date: Wed, 22 Oct 2025 13:43:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Message-ID: <20251022114317.GOaPjDVZoJYnkqEVQc@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-2-david.kaplan@amd.com>
 <20251018133913.GHaPOYgR0YNlz-KexS@fat_crate.local>
 <LV3PR12MB9265578BE201F1D5E1D7488194F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265578BE201F1D5E1D7488194F5A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Oct 20, 2025 at 01:53:11PM +0000, Kaplan, David wrote:
> Ack.  Although to be clear, all it can do is select a different mitigation.
> For instance, if there was a bug in safe-RET, it can't fix that bug.  But it
> could allow selecting a different SRSO mitigation.

Yeah, let's spell it out as this would be read by users too, I hope.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

