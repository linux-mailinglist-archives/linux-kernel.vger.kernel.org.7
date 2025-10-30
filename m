Return-Path: <linux-kernel+bounces-878972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E1C21E27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F2422816
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7136CE0D;
	Thu, 30 Oct 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h+PBpZ6u"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C9354710;
	Thu, 30 Oct 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851495; cv=none; b=BYAND2e27mnl+4K7U0YwduC84/GSVqgytF+5nn9tyIWrRngza8pGhAQKEApX1Srtm8HPWD8bu0aSABjuIMOtaWld43fA/bLaQXcnIiOq+QDLkGVpUZwMvdNi50OmbiQ9Brk+Z5FxcjxO+aCnoQiTMJUL03v4NjkiUviVkznFjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851495; c=relaxed/simple;
	bh=qfeTTk7/TR99l/94qyEHZDp+hNO6DYE5PXmmWZKEwbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAJK5iZd78dv6uPt98Rlcs/TcNrAmOQjmNoRxIiSpUNP1AQ+CN4HLZBOJ4v6fNzt3j3uER6hk6iPQ0HXWPrupn3m00e14QzG4qEFgE50yniXMujcYvJl0OCvvISui53/hdrzVxE5KeQU1WeO3FXtHofN4Aq9SyLrsqf/BpYibvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h+PBpZ6u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 37B4540E016E;
	Thu, 30 Oct 2025 19:11:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cGgbTPGaS5x5; Thu, 30 Oct 2025 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761851479; bh=8MFOnuSPsAMXRSVQXBva5fNQkul1fYm0Kt2r5nN3Ckw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+PBpZ6uaSjfapcKGzeE1LrFNn69xOfPxeFIpFOtKOypflPqDjHYCxNXdbwsn6IL0
	 FumzoqajiIrJzvmPmuuFZ9qjmrH8VZZZw40+IeD1U8vVBmT+ZG+6qXFY9l5pxHrvff
	 kRFrx3/OZhFEqJcJhOwT6/HX7STNInRIpgBNI2KzlVLh7RFP+WyZftv5jSiBAkIScP
	 iC9dA4azI6fzU5wfYb874Nd1Qe74hAe/8nEYtnwZWOY68gGqnxkSPPkU93/pZUfKpW
	 CQEHZcTbaTeZxXRzFJlrVgOBg0dqA6jsCZQHyfsWT5GyASAjTce/0lDDe+Fo8G7KXV
	 xL4aRrP2GjD2dxmT/8n6y977CiJLGpX7soabWEm99F/T0Co77ZEN6WMVcJEoS+JLlQ
	 qmTJeDoehukSqap64Ks+TnGCljqvxs5mxkB0KM6hKZH9VwFK24c6BnhKgc/YA1apV5
	 n4vPwfJjBwGypuuQyI/l/FWYmfnKVy7iC3Ri3v5BfQ5aHd63L/1EACLGLwQfupNYrC
	 7VoIwwlIrX2id77k1DsYgw1vfBoc+kXumqFLRiik0G1bE2F92NK8FP7LAnqnqDd1k9
	 nEh8+AmPOdXy8cXPig6vo/eMdRGCtkAOZ8r3fmiktYW1N4Xg7efaA6DExkgRNTbCDA
	 MXUskIvmU42V2jcd0ux2fjXo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CF94040E021A;
	Thu, 30 Oct 2025 19:11:03 +0000 (UTC)
Date: Thu, 30 Oct 2025 20:10:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	gpiccoli@igalia.com, peterz@infradead.org,
	davydov-max@yandex-team.ru, martin.petersen@oracle.com,
	jani.nikula@intel.com, joel.granados@kernel.org, xin@zytor.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/split_lock: Make split lock mitigation sleep
 duration configurable
Message-ID: <20251030191057.GDaQO4QYoZytxdQW_c@fat_crate.local>
References: <20251028094333.49841-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028094333.49841-1-wangfushuai@baidu.com>

On Tue, Oct 28, 2025 at 05:43:33PM +0800, Fushuai Wang wrote:
> Commit 727209376f49 ("x86/split_lock: Add sysctl to control the misery
> mode") introduce a sysctl 'sysctl_sld_mitigate' to control the misery
> mode for split lock detection (0 to disable, 1 to enable). However,
> when enabled, the sleep duration for split lockers was fixed at 10 ms.
> 
> This patch extands 'sysctl_sld_mitigate' to allow configuring the sleep
> duration in milliseconds. Now, when 'sysctl_sld_mitigate' is set to
> N (N > 0), split lockers will sleep for N milliseconds.

I'm reading this and the only question that pops up in my mind is "why".

Why does the upstream kernel need this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

