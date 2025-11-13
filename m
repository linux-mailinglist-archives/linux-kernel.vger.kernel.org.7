Return-Path: <linux-kernel+bounces-899515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A3C57FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF17B4EC428
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABD248F51;
	Thu, 13 Nov 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fy34iuQ6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9C22173F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044465; cv=none; b=U9OCSV28AegejokdcZ/1n9jGrjKsjGM4nJYt090i3mWQDtRB7Vm2A2NrQ+tVly0qAkDsvOULaCgMFBgIHPO/RoJW+Fa/WExIsIrn9vT3EGVNtrzcqchOUr6UNwGMSEICD3wuwIpk2xkr84x2aoVgU8AtRXogN1itR9KUn69lYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044465; c=relaxed/simple;
	bh=N2jL9Ky5Bc+rw8IOvoFUiVkYhC/V+idDIWXQSlBLKs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrX/SEyvpFjBEK3ognd/+zpPkAy0fx6tp6shfyciQh9CYFKd1jAWRVxmF25242Zv1J6sQ9oVpiIlFsonUO+aqMRkOXI+yjYuLc4BWENMxLGVmRQbEYBxUp9eK+qxGWPKGH+xQN4DGHPZUw7/0pYLKZ/4AnC+FtUciCHcAbM145M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Fy34iuQ6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22BD740E0216;
	Thu, 13 Nov 2025 14:34:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hEIej2Dq6aEj; Thu, 13 Nov 2025 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763044455; bh=dw5ww5yquA+G0rr26SzoOKTL7paU3SOfBrTPLnQVic8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fy34iuQ6jUpGat8dCYffZeQ2gRDfl50WNaTkl5YRV+ecShKUtxSLs7w6RxYsgMrdL
	 XlgngQNf4IHCXvORlARjODpKqdX/Z0IkRlNTFRi6AZXclt7vHRCLxXzAgBpYIHbdle
	 SrtQrqR3qokb6jjtFLe6QTvKmdJoELzkKeop8tL3ppKNJa4iD6a3u7jX2ElXE7oFOz
	 WoNuCGThMyGcwH6r5kv2KSIFnxJ7iWgQ479qwVluN7ogGTH06ANsoabryrNeM/rI/p
	 9r4Ud1FYOqL62/S3fs/EZXOFMePRItO7M0e1cdkACSFtEWC18t3zbu15rc6+4m9kFl
	 8+EjAAOlblV7CH4GlC4yK/euznhhfoYMtupZgAy2WcPnQZr6l4a+dvKsw/GChrHn+d
	 v1vCFWVbN/kAGH+kWno2nWBYJ8xDV8oDzvFhuetBXzHWk4HA27EWavnNn6nlU4Dup3
	 qSbFQ9XTScF41r+hrJkw/gR8LdJUhkmAiSt1lDhvl4+LrHMSC7xT53VxhUvUE/Qbj+
	 brhemzebNJvvfsXZuLAQYzUYDs++f31A2dPXHgncquHp8rRxSZT59DjOuWWBaTJcNI
	 pyiSCk23Z2/u8w1JhhMA0sDC9oXE6B1CRhpwndB551KdcEqYSfkv3xI6y6znN19ICM
	 iT1azdoLAY1uSfYTE33I9XsQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A91A240E016E;
	Thu, 13 Nov 2025 14:34:09 +0000 (UTC)
Date: Thu, 13 Nov 2025 15:34:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	Eric DeVolder <eric.devolder@oracle.com>
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
Message-ID: <20251113143408.GCaRXsYM8aVHLN3zSj@fat_crate.local>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
 <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
 <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>
 <20251113142713.GBaRXqweHEuZw1bjD1@fat_crate.local>
 <e89951cf-3a1a-4ce5-92d0-2ba63e2fd94b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e89951cf-3a1a-4ce5-92d0-2ba63e2fd94b@amd.com>

On Thu, Nov 13, 2025 at 08:30:27AM -0600, Mario Limonciello wrote:
> > +	/*
> > +	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
> > +	 * in order to support CPU hotplug in guests.
> > +	 */
> 
> I think it would be good to amend this comment to indicate that the behavior
> of the "enabled bit" changed and that QEMU follows the newer behavior but
> advertises the older version.

This is just there to hint why we're doing this fix to the kernel - i.e.,
try to salvage an already shit situation. Any other deviation from the spec is
not the kernel's problem.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

