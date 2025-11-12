Return-Path: <linux-kernel+bounces-898000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52791C54177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1944E0602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37154255F2D;
	Wed, 12 Nov 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j5xcXX0I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD91C695
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975082; cv=none; b=dFrOlNloP/cC8vxOvV+hqjPlmplQrKt6aFK2LVy50IHZV5FdH9SKPYTi9uJQhIAVdHyQ6rADjxETMkqOr/cdOw5NNC2vXVYIK62vkqjyNnTwB7sHWCS/U+CyPTPz79YgQNeIturLMkSv/ojBXhQRQpMm0QYKt/cGKTaVnupMu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975082; c=relaxed/simple;
	bh=At2w1BvFfJxs4Lnx2OlzNnW8xVgqqnkkljKAA2Ep92Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItkRiU41rkdE0QKe+9BLmXnLE5Mu3EpZ8G6n0ELcUAiyeEIrPD4GkeucaPNX83wcLYKJVkW55JQicLgEYTqRKaClBg7tgChOobfOIrAaT25ZztkgMyrTMMppHV17oIOSYSgJo+jwWumdf0XjZReZVdOUxvlQwvZMbLrcbRNhwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j5xcXX0I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6871240E01CD;
	Wed, 12 Nov 2025 19:17:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id klkdvVL2hZKw; Wed, 12 Nov 2025 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762975073; bh=2Jg1hOXEWK1VzJ+VCCqxa/hcTGWMrIbIwKA2HWtpAVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5xcXX0I00iuMuIlmSikVDwJdgJBe5YjKUYVTSTveN+X+qWHaXGUwiYM9JDaS1bAL
	 D2QFFdkwpUmcgbwtcJ6ss/hJ40AJvpcLC2lNYZp5tLGilpKCNNVfo6njzhwhygXAfe
	 DIVAns1T/ruNlZels69XYmR4o0GrvV8sRW/dVXG78le735VaBrd6PyUfVnyTg/PV5H
	 SQlXuA42AarXXKqLMM/iBovnok1gBE/40c28tDVJcKvx9lJFgms2YupJ1AXllgk7nu
	 08XgsI5fn59ZIqCz6WeEyoh4lbL7TVyOAFfHROcEJ7URNNjpuT8HqmB6uRdRyA5REH
	 GflOaTRZ3qyxI3mNJ9P0K9B6sYx4Giws12H9/fEE0G/ZTTZI0+E+U3ue/t3KvsPBZS
	 TGfG5SQ2CXZOVLuiYN0kL29tQJBwjYErIP3qESxDz5VRMKcZM2wotk4Flz1T/JNq5X
	 fIikcULgsgdGee/mjOBKhEyWmKim5colUQVjcTReZjxfM7dbBBFX57aTyAbbv6uKNw
	 uwdI1vx7MwWLum34Jn0Scqgcj7eahOSoSTNdGP9UHzQkw78xvzdDUuFeWwS17Cia2P
	 92DrHiSyLCgQLTet0o0c8x9oNEyIYxpB+9KtO2cmLw1n7fIVtrUkgVss7TYuCVg4hx
	 W9lZEAcoy5kCWvlIx+IQnBDQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E428640E00DA;
	Wed, 12 Nov 2025 19:17:46 +0000 (UTC)
Date: Wed, 12 Nov 2025 20:17:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Eric DeVolder <eric.devolder@oracle.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
Message-ID: <20251112191740.GGaRTdVGCKm06z0EnZ@fat_crate.local>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112190518.2056dab3.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112190518.2056dab3.michal.pecio@gmail.com>

On Wed, Nov 12, 2025 at 07:05:18PM +0100, Michal Pecio wrote:
> Nitpick: IMO logic would be easier to follow if written this way:
> 
> 	if (lapic_flags & ACPI_MADT_ENABLED)
> 		return true;
> 
> 	if (acpi_support_online_capable)
> 		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
> 
> 	/* we should say 'no' at this point, but VMs are crazy */
> 	return !hypervisor_is_type(X86_HYPER_NATIVE);

Sure, except I'd like to keep the original comment as that leaves more
breadcrumbs about why we're doing this insanity.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

