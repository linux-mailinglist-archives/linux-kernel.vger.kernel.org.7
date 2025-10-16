Return-Path: <linux-kernel+bounces-856971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76969BE5901
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE704545541
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E712DF6E3;
	Thu, 16 Oct 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyZAHhw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFA2D9EC9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649617; cv=none; b=s1l3vGsPM6sQ/3Bk17jmP1iQ6fAEe0ktVPNruNq2S06Iq5Jkq5N0fTozn7c5OhEGKXowiWEHB5fVwDPABaSS2GRTabebf/W7CkE0VE/QRVlmzQ1qzO+93cBJN5J7eZwCMG+uqlnlHY3jLuroiXUcdwV8EwezhmbFgQArUYUWlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649617; c=relaxed/simple;
	bh=Vx6NLALznOEVqnsjRjzx55X+1uGSLm9ujHHkgqLpNDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyALXZhzLeLKCrIzH7NszucY+6WGbKFKA9u2Tof/Ir1uOFItBbvnL7O+hBta3Hwg7nY7piBYHgIhtwn269bLT1pYmeLaK9sQ7IGciA/BwWGF/v1CqHPT4svsG4aEh1PK3mOOeuoL4L29CyXV4D/gsCfjhuk9QeK4ZrqT3jFdLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyZAHhw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E9FC4CEF1;
	Thu, 16 Oct 2025 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649617;
	bh=Vx6NLALznOEVqnsjRjzx55X+1uGSLm9ujHHkgqLpNDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyZAHhw29qpe3C3tBP+aj2fNy67kMRYa8yLtj0ANHscMOURcrP3rN+ve3a6tUVIZD
	 8m/wyy0SwlDBntXO2fedPQoS9dyjhzTxWZ3pm6gZRFljd5D2wB6fW+lQApqdHAKiFF
	 4zkHEYEdCaNICY2jZ028OmNfBj4kcwiUkMrUAKIKVVWqaF7Ky4XWQAQCz07RKN+pf9
	 ybitZBsJQI6SW21KoZziyiUKwmkRQdFoBFstlqVfquiLvbLijxZgMNbsoNKBhZjXZw
	 fe/YP2QFX9oTzd1+tBxRmHCZ2GUp/WWQDSgUCi3mibUx2WlzpwvKuH+aDbfvC3qloA
	 aADqKoMhqnxkg==
Date: Thu, 16 Oct 2025 14:20:15 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/56] x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
Message-ID: <mor3gytqfo236eiwrdmpghwn5lfobc4ebseea54zsewrtyj45s@7b5xnm3vdult>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-3-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:50AM -0500, David Kaplan wrote:
> CONFIG_DYNAMIC_MITIGATIONS enables support for runtime re-patching of the
> kernel when mitigation selections are changed.  It depends on
> CONFIG_LIVEPATCH because it needs modules to preserve all their ELF
> information for later re-patching.  It also depends on CONFIG_FREEZER
> because re-patching must be done while all tasks are in the freezer to
> avoid race conditions.

The LIVEPATCH dependency seems a bit arbitrary, can we have an
underlying CONFIG_MODULE_PRESERVE_ELF, which LIVEPATCH and
DYNAMIC_MITIGATIONS both select?

-- 
Josh

