Return-Path: <linux-kernel+bounces-729828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E802B03C24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2936D3BE191
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57308246760;
	Mon, 14 Jul 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D71aWyM6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0224503E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489883; cv=none; b=E6A0FhxvaeoouRg0eXK6e0T5uKidxezbPHHBZ9IRm1AfwKkC1CllJOVaumAhHQLG0UVbvoQlGs+mlgCYDVWRoz0FuUr8ZUfBk7ymip4gA++6VwAMTW99f0QN/tBItqQnBB2RczI7eyKY1d5JRnJsaZLHFq818JSFAXUPzpd7f4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489883; c=relaxed/simple;
	bh=Y/UIXpojczFRmh2g82Q4vnNcPc5Dz9j9+14qFEVv4gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8rUmlpW6FMck1bYqDUdBS3RQwALa35iylBhX3+9+/xDTQOolQ4liXBrNrL58KNsZdv9/r4nSnHfJDwPrT/iuzepSkqPQInYcKciOQ+Uoa5wapdCw1RLaaGUZHJbE5CGDEvZidMd3zO9ebXCPQBAdqC/tVkTA/i794XL2unB/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D71aWyM6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C772340E0213;
	Mon, 14 Jul 2025 10:44:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0Z-gg2XIb-Es; Mon, 14 Jul 2025 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752489874; bh=0MsNweeGgkbvFTwXAexlbZgcbEYfq0g3OGAnbnE9kBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D71aWyM6KwmiFk6zJh1vdovfgeUY5cOrNVo9RvMNSFdqew7yvu7jgI3azfd3JD7P2
	 I/jSm9q3IxHp1SpY99e3/u5gHpbARWGyXd9i4R0QYLtksGQF2mQZaJ4MgNe0nQos3N
	 aX1MXh9Z4rkMnY/vNkATQdZk5WlMKZRUW+B4EZS8u5hRKuuiv1rLWqwEUO8j7jvuZp
	 GKvWGyoKvY4vLLTjyg19TLfxDM8rSNv+/1WvuQC0m91V6AJAdkZe7uzXP+kcIniyid
	 Hj+t2Zfl05HpOOWJ8NDcg1j/H4FBLymUeKYeep3hD+//agJcS894WO+2MwWrpsg6Rn
	 ZLFUSsMyBFjOb4MNGbmi9e2LI8xSZqd11qRbGIciQ309soCfYXCfAPtyTirlVq2JBy
	 lzk/gNVErOEHFsWKWLDgQL8GNEfkRN4RPnyTKu5/KHe/xKNoHjbjqzh2MdSyO/zolI
	 7W568xGahpiBgtQCeYhGQGs6g25+mI+g+USvI4c2zEzJ5JB8KZkHz6oseODmVjgx9c
	 DU1Y4xJ6ZyxdX88Ftb0JzoAuYEgrIfDKYIb1/g8JmgnxCbTs1lDI+2LvBK56EIYUd3
	 cQt9rzAYYcEClsCTMzZcFAziJGx1TGJpNDWvcs9+XfomzsmsL4ObguNgPaWdKDkPU5
	 xbnNBSzqCBV1JtG+D4qq8QVU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85C3340E01FD;
	Mon, 14 Jul 2025 10:44:25 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:44:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, seanjc@google.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	thomas.lendacky@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Message-ID: <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711041200.87892-1-nikunj@amd.com>

On Fri, Jul 11, 2025 at 09:42:00AM +0530, Nikunj A Dadhania wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> For Secure TSC enabled guests, don't panic when a guest writes to
> intercepted GUEST_TSC_FREQ MSR. Instead, ignore writes to GUEST_TSC_FREQ,
> similar to MSR_IA32_TSC, and log a warning instead.

Why?

Nothing should poke at the TSC MSR and those who do, deserve what they get.

> Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
> with Secure TSC enabled, as this indicates an unexpected hypervisor
> configuration.

Huh, this sounds weird.

What are we "fixing" here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

