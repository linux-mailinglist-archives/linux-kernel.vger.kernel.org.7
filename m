Return-Path: <linux-kernel+bounces-784910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E708CB34374
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB01884B22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889573002D2;
	Mon, 25 Aug 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KwL9n18l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806D3002AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131511; cv=none; b=IbGnnhxXd3zswdxTAbh036fdl0zl7eHi+tXO5NmIRXBI/1zMxuG+NuP2BZWpwuAfv1EVIfJ7K7CyAT0YFv6YoxL/KINzdEuoM8XCXSlqpy9ghvw8kzcmL0/iZ/Em6wmeB3Zul5+JMHRYhDXGeI8Z8Sor4KFzRM7kmW4pW7b6sNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131511; c=relaxed/simple;
	bh=ItsVxMcWxDYHVWBaWDDZhd2R5FcKHvQsQp7/GQCZDWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2vpNdycwoJGXq81iOhyKUrLkKrJ1afjpO8JWIAL8PE/rX43myKt8mABB118cXmBznDTiwetktB/gkvdCFj2/SjfPy7NVX1mEvGBITuc+pbmpmF+jy3HeuQdGnP9/3rfpX4sISujE6WLAB+D722P4c2UwMk0GDLS0tFht7+lxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KwL9n18l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1673040E0217;
	Mon, 25 Aug 2025 14:18:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tKpbBpDqu4bX; Mon, 25 Aug 2025 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756131503; bh=bqdY0WhAtvp8cHP6dvUMlzIPIRxwctMFGQtIjBRr3tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwL9n18lowcfxL+hq0zpvEiRvyns+GLJ2fVosu7qUKagAwdDxr722tgM+wkwtV7WK
	 2SFOwUaChmHZDGMP2xFlZFzXWBErO4V18BKW86xt6q8bHMvUmt9/egxS6Vk4MCU+Ro
	 emQ/G3ZQvUoRNvFrtrB0Ypm3D3RmXSIZuLgnAw7ZBOtjVz4ltgXP9JIwPdsQ8b/a4T
	 hMQbtiTpwN7XLSQoIQv0rcbztDwvBP8jv8PyEwaO8NE+2PX2hyw0O+jpLJd0ROT7BN
	 W2CTpQmTvcJ47zb7oU1x3rFFTC0a4rNxYDxs1+8VRLYS136z9kIgnIi8AYQNqc1Yog
	 +5DeAxmscx9e/9qN9UglMzWw3OpX1hQeRR8HEBR5dlhp3pnD1EwQq/kycYQBSkp++b
	 CFPKmLqhkDthq0WA7MC1vWNkci9qHMpZx1dnJMMOHIfpoh7SM8JVgF6edi5nzgh+lf
	 pOs7BVKbTLzc4C7u6g8T9rZeC+0R/1tHjRxDnsNxkEdsUuXlHsCdSAHcvMz/iV4tVz
	 zjzh7AdmYdWEdv2flWY6Dk31yzjGkQ5KEnQkFj8cs4REK92PuZesTHZLsufd77l9z1
	 9kGvl1vdr1YMsSipmwlx2u53qRVEQAkK0wcvVm6JC0D/32e5938aqImXe8DPKDAmHA
	 5iB7/7e43xMKOQfoFSYyj4LM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 903D140E0202;
	Mon, 25 Aug 2025 14:18:09 +0000 (UTC)
Date: Mon, 25 Aug 2025 16:18:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/34] x86/cpuid: Introduce <asm/cpuid/leaf_types.h>
Message-ID: <20250825141803.GUaKxwm1lAAugFJHVQ@fat_crate.local>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815070227.19981-7-darwi@linutronix.de>

On Fri, Aug 15, 2025 at 09:01:59AM +0200, Ahmed S. Darwish wrote:
> +struct leaf_0x1_0 {
> +	// eax
> +	u32	stepping			:  4, // Stepping ID

All those bit names in all those leafs: are they taken from the official
documentation?

They should be.

...

> +/*
> + * Leaf 0x5
> + * MONITOR/MWAIT instructions enumeration
				 ^^^^^^^^^^^

Let's drop all those tautologies - it is absolutely clear that it is an
enumeration so no need for it. Just keep the minimum text that is needed to
describe the bit. People can always use that to find the official
documentation of they need more info.

...

> +/*
> + * Leaf 0x18
> + * Intel determenestic address translation (TLB) parameters

+ * Intel determenestic address translation (TLB) parameters
Unknown word [determenestic] in comment.
Suggestions: ['deterministic',...

spellchecker please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

