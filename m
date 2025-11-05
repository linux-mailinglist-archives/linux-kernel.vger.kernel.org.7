Return-Path: <linux-kernel+bounces-886340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BDAC35487
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCC274E47F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4430F551;
	Wed,  5 Nov 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k4ccTEkd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9330DD3F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340632; cv=none; b=t+jStSDtxh0dNp0WDOJDfAMmVPREQkF8CpudgUZop3tvGulM+rpidBOg6CdqjIFICNwAmcjLg1lnOkWBjGQqSm8NrJ9jRJIbn8cdxmAMBgInvbo8jtHPJ8hDI26JXck0T48RSGD6sRNHb3b1T1rP7mtIYqFSXE8qoDmzjX1XIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340632; c=relaxed/simple;
	bh=teqL1uzYT7uj6M8PXrR8Zlw3MxjrqM+dypqt1w97/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX6vG5YD9irIyaAS89tblXuZjDhBq5V5S+AdY9nk3RdQso5qbkgiSPKujFJkrh5QIovUrXzwoqtD57RLe7asliIHWxKt0FQb7vqRjitZT5kerSYcxwry94282iSBYOfsZ+GTu6JhYf4sP9pubs//zYCujy9WRQC1O7FQnQOQZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k4ccTEkd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5BDE640E021A;
	Wed,  5 Nov 2025 11:03:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PYoB4pUWr2FL; Wed,  5 Nov 2025 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762340616; bh=P8btXnFOvmB9NyMVjX0AuCogSfaHoWEL/IUyy9Nx6dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4ccTEkdkQS5vIS44CeNmMQcE9o6RokZvMUPyuQtzJvnTV6/ZtHbw+3lwUOCfJDwf
	 TmyJWtyqHvxxv2uKWMrLV6jT/a5u3OtMXK5/VpwhLbc//suQyb7tIYJ6afZmeirDJL
	 aEt3MNYTvKWGxVMyYsrgGFMhJsW2iuVOYurrpPsRgpr1+MfkH8u9seL+M0qjSjNi9r
	 WvRCiGd1WbrTBs5B1eaFVwxTGqJ7sx7lMAVldGe7uQnRbQJSpiXOXkjHSe8WzjNWZw
	 SkTXr9aNiQM+QBYDqeKA/vawRc2uwAW11W4JereWSfOpWiwbMs7+oQYgoQDxH8wbeu
	 KZRFl0TRUXbIaHrQudhGQCGAn1dQSBSm84h/ekz8mZYJ1KGnIYqBZyEZ7mBdwLc3DK
	 llpT5h/Nc8nWhVmRju/JRsMGPmPxLHFygP8ek9SCEOwVYwkrhd8tEg9EVUeLNMaxJa
	 you70SiEW8snJ+nVSUIE/ZwMaSc6GtgiShQZzPfx6w2IM0jZbZl9dXrV8ZE0XjV8ok
	 Vy15XbhH5H9lObBkD6lLaeiZm+MwJMcgoHGy2p1CzgZDQ28dWhzkS8MXhTiNjbclSv
	 CUkdcNgC3keRrUcqTmkr6QZ+NeJnvj7da7//yPmgJ3POYsEuEEA72boz9P/EKObxnQ
	 kJgccEk87rStzlzpUEmr7jt8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6FD4940E01CD;
	Wed,  5 Nov 2025 11:03:24 +0000 (UTC)
Date: Wed, 5 Nov 2025 12:03:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <20251105110318.GAaQsu9vGkzSxGbzzx@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
 <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
 <LV3PR12MB92655CEB1AF94875901E700C94C7A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251103202811.GMaQkQW54Gml6i1jQy@fat_crate.local>
 <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <j2mds5vdblnhpha6oyejqcj2fgmveylgaudzzljvfwwl3fgvnw@xgmsl4f7jzv4>

On Tue, Nov 04, 2025 at 06:29:20PM -0800, Josh Poimboeuf wrote:
> Separate functions allows each reset function to stay close to its
> select/update/apply counterparts.  That makes it easier to tell that
> it's undoing all the right things.  Plus it preserves the existing
> logical code layout/separation between mitigations.

... with a forward declaration for each one? Because we don't have enough
functions in this file already? And even if the code structure is begging for
us to turn it a OOO design, we're not doing it?

Sorry, but one big function with comments is at least keeping it saner. And
I'm sure your favourite editor can help you jump back'n'forth easily. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

