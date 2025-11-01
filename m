Return-Path: <linux-kernel+bounces-881079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD305C275CD
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 03:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 646D44E1BD1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B400246764;
	Sat,  1 Nov 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LmtlPny/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EC22D9F7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963162; cv=none; b=YQtncx6BUGZr5uv3scwof5Mslf6x8Zkc7RMri93fOmTplKYDMKtf71XUn0nHxtaCDblTvIIaczUIGeqdDJYmogRc092l7baY7cDwlqdGevTZ2et9/wFvTxYLh+5xxwPrYV2UjDTyvuKW6eDzmyaruEP+tpKHyro54MgEBhNHJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963162; c=relaxed/simple;
	bh=Qst1R5LzdYJcHzYXn017ZyXdrjjln8r8RVjOmd53+Ow=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bBmq6iDvEcuYedZGl9etpo2gZ9Z5qOV7afpZIMsvu4sH2EvKF44LSJwd/DFA6VTk9CsU73qgxzHXuVFovtz53BaHxE/PekoTCjiV0YCIZjaxo7O55T14VfMJGXg0hF+aM+oxyqn7o7ulekBvL5vr6ojt5mvAYaCJ281UX4fIDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LmtlPny/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E8CC4CEE7;
	Sat,  1 Nov 2025 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761963162;
	bh=Qst1R5LzdYJcHzYXn017ZyXdrjjln8r8RVjOmd53+Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmtlPny/JGo5vFV8kNf2renOPBjUk6hMtft5aykSyxLQ3sWlYhXq0wKMQDoy16b4L
	 VZ4Gp47v3DRqqxxWilHYNgPheu5mp8QRD+/1cIGVPDUYMnvqm7uD1rUA8iXp2JVt4w
	 NwZ5vXJhAJygLs98qbKVqbg5UGsMg/1Bd1ZZA/Tc=
Date: Fri, 31 Oct 2025 19:12:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@baylibre.com, Nicolas
 Pitre <npitre@baylibre.com>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>, Yu Kuai
 <yukuai3@huawei.com>, Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe
 <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 4/9] lib: Add mul_u64_add_u64_div_u64() and
 mul_u64_u64_div_u64_roundup()
Message-Id: <20251031191241.c3d0fa93219cab2a1157fe1e@linux-foundation.org>
In-Reply-To: <20251031205917.56763269@pumpkin>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
	<20251029173828.3682-5-david.laight.linux@gmail.com>
	<20251031205917.56763269@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 20:59:17 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> > -static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > +static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u64 div)
> >  {
> > -	u64 q;
> > +	u64 rdx;
> >  
> > -	asm ("mulq %2; divq %3" : "=a" (q)
> > -				: "a" (a), "rm" (mul), "rm" (div)
> > -				: "rdx");
> > +	asm ("mulq %[mul]" : "+a" (rax), "=d" (rdx) : [mul] "rm" (mul));
> >  
> > -	return q;
> > +	if (statically_true(add))
> 
> This needs to be:
> 	if (!statically_true(!add))
> 
> Do you need me to resend the full series?

I queued a fix, thanks.

--- a/arch/x86/include/asm/div64.h~lib-add-mul_u64_add_u64_div_u64-and-mul_u64_u64_div_u64_roundup-fix
+++ a/arch/x86/include/asm/div64.h
@@ -90,7 +90,7 @@ static inline u64 mul_u64_add_u64_div_u6
 
 	asm ("mulq %[mul]" : "+a" (rax), "=d" (rdx) : [mul] "rm" (mul));
 
-	if (statically_true(add))
+	if (!statically_true(add))
 		asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
 			[lo] "+r" (rax), [hi] "+r" (rdx) : [add] "irm" (add));
 
_


