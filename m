Return-Path: <linux-kernel+bounces-777424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE74B2D90D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E66B61C80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4A2E5B2F;
	Wed, 20 Aug 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JbA/3gsh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AA277CB3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683060; cv=none; b=VdDIVO1qLoZWSHWg0ajrFx/XUg0LGYxNyJ742OTrWddFj8Kuq10qcN1uB5ZeFtl8zAp2wXm9ah4FnggiT3NqDIJnVY3gQF2p/XSAalysweub9xhrgs11FjC5t25JjEytJ8q3W6BGRVzsPnahhhOFehJ1deVX/N5zeuJ830jcQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683060; c=relaxed/simple;
	bh=w0XzjwzN+hIjwDrnxFXYewhN6SFaSHA7U3LGez7HgzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McilmyXlaRjmKI6S1azCr8YtzckDvZ6V1xB7E3NK9PXVub+mk5SAySgGiltHIe+RBN+7gDWx/Ok8c25URIbRQ+wlHa99m0UmIkI19FF50mmUTgJ8YjsCYMHBuMpRlFopq7jDkU6TxoiRELJC3dyDBoLpRvH8x5/zqttdG/ERumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JbA/3gsh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D231840E0163;
	Wed, 20 Aug 2025 09:44:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jc1d5X_p2HZV; Wed, 20 Aug 2025 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755683051; bh=vdDp2/GhA4nDWk/y456D8KF7bprQJXBqsLRSdlsOv/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbA/3gshgB3ZWkdGMEauZ7Dr+Ygvlikb0g7w9rtKc8amJGb3tnM173mmTbWVZeSm1
	 jZsFsIfdO5XoxjhQETPvokZGj1K5oTJabqE+ot6YgzrJWDknBiDB849RqZW7Ioe1+w
	 49KIT63JgX52X6yfK5GqWH8C6vH3H2dvBvh/Mi21LUhH1nBHiaJ59Tbqd5X5DALk5v
	 AIgNHirWcUarS+cNo+2pQogNXe86ppMHKKN/hUhrC3CWXRLeCnOndVPvhfkCuS8Fxb
	 ZGsuJB7sAhM22OC9DzipQ++LF7upi04X2Ajva09e2pwJhS0SUSqgjyZ3ZJxv8igHLD
	 pvSt4lCb23ReOjfziNUN+KtIzPx/S/qLg3dqwD2uRaLRILUWkBBpNxQ1KJJiyZifAP
	 voxhViOb5abVJBhJoJJuidb8qqhjSm6gkDWNub0zqtXjSDr5sO99HYd9IYC0YYDuDd
	 V6n6vqziYZzA4onVJQCxXFywSVIDSgK9KaxGjS0CiBU01t12Y/K/kY3qQat9bGzj+l
	 E2S4r/PfjtM5PNVccupUrVuwYhURAkH7mpqViq4FhhqMrlWYSAKfSdiQlKkwsNq9LC
	 zk3LXTunhmgXr9FiPoQKBZAbdKozRwG9tTgZ427I1EHsSh98lpriNMn7GcEWF3115z
	 QvuA0WRBZKZSOJUuDk5OwulU=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 904FA40E0232;
	Wed, 20 Aug 2025 09:43:53 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:43:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Oleg Nesterov <oleg@redhat.com>, "Xin Li (Intel)" <xin@zytor.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH] x86: add hintable NOPs emulation
Message-ID: <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
 <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>

On Wed, Aug 20, 2025 at 11:33:05AM +0200, Marcos Del Sol Vives wrote:
> But I think the kernel should let the user know the binaries they're
> running are having some performance penalty due to this emulation, in case
> they want to recompile without the offending flags.

Sure, once perhaps.

Do you want to let the user know for each binary?

And how many users do you really think will look at dmesg and recompile their
binaries?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

