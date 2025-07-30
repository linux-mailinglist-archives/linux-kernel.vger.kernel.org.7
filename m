Return-Path: <linux-kernel+bounces-750586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B731EB15E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D275A2A10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB428750A;
	Wed, 30 Jul 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJZp2d1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EN1B9K51"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1A224FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872282; cv=none; b=ZtvfQzEdaz2IV+4X/ETyARYnCM0h4vha2vNhFff1BdMM6oCXUhwwX5VpGpiG3QJ5brpBrA2MB84KY7mcjk2T3fvLcfef5g/fLgz74hX2oTzKWL2HfsY0zxbzBzukPT0VRBu8AnOnVsZlPztAY9Tf9/zEsMWISsJ06fWejXSSzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872282; c=relaxed/simple;
	bh=yRMiDmkysd4n8rAvtQH+xNNG2Jp7rPDHsGcJ8tFACAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYa7toggXhTKa6XVTUm7RZ44L+vGtZzbbUCTupMRNrNn26n7ynrZsRs2QR6VzcEWaYWMmEuHcNtgf/LC8ZGsoRcZ01Q3ASpf/sHlCjNJO/3ZglpV12NvW9nfp9XbGwbH+PO0VQ3UBVgw3y4zvkmXLZ+FYY9Dy9v+mTLENmcwy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJZp2d1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EN1B9K51; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753872275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5SwZrMWjMmbTsp+xtI6eRvizUSGLwjEkSr7w5zK5cc=;
	b=mJZp2d1CxYIH8GLi0FAqNc5hHL/+kkcSIG/u2IZB1H59Q4Vs3Pr18RwCLoVJnRhSNoM/tG
	jKXmDaY0W9DvPWOM9Gh9tY20EQO3R3Qpv+L/Tosfol0biyQ3BEbk9MYuTvqiY8Y8EK55/7
	QyjfCq+1dWzN0Fcz0fRodEHMBOIK6kokNCX8CvLuK3uhYK+Gbzvv/c68STs/eTdsnf6xcF
	FEJo2drnopXFG0c9TgBFJKtM86MUvcSrHR1HrHRrE2vTbD0zfaXS46JRMo6SCT3jUWlNnO
	06FymX/LZ0GkTsE2J4pUIEn3GGumhEloNjnd8pr3bFhlatMV4URhOY6Z4Tx7Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753872275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5SwZrMWjMmbTsp+xtI6eRvizUSGLwjEkSr7w5zK5cc=;
	b=EN1B9K51EF6Yho9Uwiy0fPifahULvO3zl3V9+Rncou6aMsTChJO24aayMqsbjg/Ym6eY2J
	IM8k1oTnZdtlIpCg==
To: Kees Cook <kees@kernel.org>
Cc: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, Linus Torvalds
 <torvalds@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [syzbot] upstream build error (23)
In-Reply-To: <202507291506.1DF23781A2@keescook>
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
 <87cy9ikcwh.ffs@tglx> <874iuuk87e.ffs@tglx>
 <202507291506.1DF23781A2@keescook>
Date: Wed, 30 Jul 2025 12:44:33 +0200
Message-ID: <871ppyj6um.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 15:12, Kees Cook wrote:
> On Tue, Jul 29, 2025 at 11:17:41PM +0200, Thomas Gleixner wrote:
>> > The kernel is full of such inline (not __always_inline) stub
>> > conditionals which evaluate to a constant....
>> 
>> And chasing all those stubs and convert them to __always_inline seems to
>> be a whack-a-mole game.
>> 
>> Can we just stop pretending that GCC12 is KCOV capable?
>
> That's fine by me, but I do think something weirder is happening here.
> Those efi linkages should be entirely DCE'ed?

Of course.

Though it un-inlines the stub function and slaps the sanitizer call into
it, which seems to prevent DCE to drop it:

	.type   efi_enabled.constprop.0, @function
efi_enabled.constprop.0:
.LASANPC6082:
.LFB6082:
        .file 5 "/home/tglx/work/kernel/linus/linux/include/linux/efi.h"
        .loc 5 891 20 is_stmt 1 view -0
        .cfi_startproc
.LVL13:
        .loc 5 893 2 view .LVU43
        .loc 5 893 9 is_stmt 0 view .LVU44
        call    __sanitizer_cov_trace_pc
.LVL14:
	.loc 5 894 1 view .LVU45
	xorl    %eax, %eax
	jmp     __x86_return_thunk
	.cfi_endproc

We had similar issues with function tracing in the past where different
GCC versions decided un-inlining at random places, so we ended up adding
notrace to the inline define.

Adding __no_sanitize_coverage as well is curing it for good.

Thanks,

        tglx
---
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..46f7722039c3 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -233,7 +233,7 @@ struct ftrace_likely_data {
  * of extern inline functions at link time.
  * A lot of inline functions can cause havoc with function tracing.
  */
-#define inline inline __gnu_inline __inline_maybe_unused notrace
+#define inline inline __gnu_inline __inline_maybe_unused notrace __no_sanitize_coverage
 
 /*
  * gcc provides both __inline__ and __inline as alternate spellings of

