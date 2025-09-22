Return-Path: <linux-kernel+bounces-827198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9DB91215
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BF92A2A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B916302748;
	Mon, 22 Sep 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O8BvViww"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62391B808
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544163; cv=none; b=mmscLD5ZeD5mF6Zgq3vXiA2u0yL2E3rid+HCUpwgfJq8S2Mf08Qp7gA5eIkp7ph4QC1blXKa9TyyLe4C8orNvfwji67XRv+9CFhGocu4ahg+f6u1kYpSkXIADkSOLfkMb4V80S11ttumon8rzv1CBl5XkjKUNYmbbMiul6TMRxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544163; c=relaxed/simple;
	bh=V9ReO8fxLQ9RBM0Dpak52sqpprpYlk6LhY8mTX0QKB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raj9WMBxEXszC8s4kMWdEIYjufvMulEzkDzMWhYOH4kLtPK2oNVh4xfBt8iAxvoMLthkvvYztydzh81pD+W6y6X76+WePoHLv0K49mMwnlJQQw4GKWayzg25KqurYEksHuG77cNqQyhMqgBFbaW3L/5lWK9irBaI6IfY5uTzuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O8BvViww; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9027E40E016A;
	Mon, 22 Sep 2025 12:29:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pVXU5qRYz-1h; Mon, 22 Sep 2025 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758544152; bh=R9ClS1wdWOZvaeiH6gopLh9n6J1FJjLo1VFv5d2qtRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8BvViwwLk78shsb8sda9zTtcwIWxLkM6yuOg7H4hY9MB4ftITdkwQ3gvXVUW23TT
	 iRDM/b+/mzAdAqJ5fnQ9sVqcWYIlhM9jJBHSR6jMliEBSbqBgR38kR0V1pn1AbdBQZ
	 nhTQlmC8MTLzv0zP6WUO17+mYM0B0g3P93RhG69Qto57DSxOXPRDDZdISO1Sn3YgxR
	 cJYiaasnxJdFz0wYSDmVqIOv4sG79x2QwpYjdEYteddOMGekZZX2RfBSzmWucexuZS
	 U4A9Mv4wQeQOM1URVJiJIIlBsIeqaCKuNG41ajZgFGbV4SjS1tmJFdZYSd4A6tyzpP
	 wGPcNy1bGQjMmBWY7Km64gQ+IPaMamRPgQFklNyMFV/VNc2G7iIr/rcUuNB/u2JV5W
	 iSSiVbDlDxT6W/9QT1BV/RwR/KZt8kUrnydhPU440PTOmFhPqcse5g32Ly1zK9Y8Gj
	 bW2hrJ4AEDXHSU280Gsp5S0pBi7cPrh9Wfg1jpLOz6t+3emQPTQJTmoU/+kHk28muk
	 /76OBHidKmgc0oZjTgayv782qOph3ptXdL8H8H+i/nfm9+UCpmyfLYDolDqv+z/0dg
	 juhb/cJcVckjocg/oNxjJvhoGP2s5cnulrRQEEEYXAtyP6FLfdLdkpKQ/ZSpVoSdDM
	 J2SdK7bIxkY6jrYriOZkvCeg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AEEBC40E015C;
	Mon, 22 Sep 2025 12:29:01 +0000 (UTC)
Date: Mon, 22 Sep 2025 14:28:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: x86@kernel.org, jpoimboe@kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
Message-ID: <20250922122855.GBaNFBB1GeS9ao4RmU@fat_crate.local>
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
 <20250922094404.GAaNEaZIj-Hdilh_9H@fat_crate.local>
 <697be899-8501-405f-b4f6-eff306ae05e8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <697be899-8501-405f-b4f6-eff306ae05e8@huaweicloud.com>

On Mon, Sep 22, 2025 at 08:14:50PM +0800, Tengda Wu wrote:
> Running 'echo t > /proc/sysrq-trigger' will trigger this type of asynchronous
> stack walk, as demonstrated in the use case provided below.

So lead with that please.

> >> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
> >> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
> >> [332706.552562]
> >> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
						^^^^^^^^^^^^^^

This doesn't help - it is some random script. Trigger this with the echo 't'
... thing.

> However, the main challenge with stopping the task first is that it fundamentally
> alters the state we're trying to inspect. The primary use case for an asynchronous
> stack walk is to diagnose a task that is already misbehaving (e.g., spinning in a
> hard lockup, not responding to stops). If we need to stop a task to get its stack,
> we might not be able to stop it at all, or the act of stopping it could change the
> call stack, hiding the root cause of the issue.
> 
> This is why my implementation selectively disables KASAN precisely for the async
> walk scenario.

Add this to the commit message too. You need to explain it in such a way so
that someone can use your instructions and reproduce it herself, without
asking more questions. IOW, it needs to be perfectly clear what the issue is
and what this is fixing.

Also, you don't have to rush your next version - we have a merge window coming
up so this'll wait for the next round.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

