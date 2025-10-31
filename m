Return-Path: <linux-kernel+bounces-879497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C6C233F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5FB3BB2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F22BEFF6;
	Fri, 31 Oct 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M1XwUlIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC6299928
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761884966; cv=none; b=fqvMOwcnbGlxWo3Nq/h5dbMOSFGlmkdiBweTWWy7h6yK2BDn9um95amQSer3p3inCnfnAzRW1Vk7jX+BnOwkmCA7SVPSMiKC6eTCj36ZRiDc3rdJmZFevd5Z6/vEwqeuNeiEvd1Ic99s2jF8gYbZVhNFnmwAOJlWDWxdfyYCGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761884966; c=relaxed/simple;
	bh=Y89UM5pl5thDsdpF7GW/2uds8tHOEWMh5JpCL0hCk7s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UEev6HQSDDZJHsWpBkiammuCASatdcaPkfcYL5nUYXlSOkYeZZtiwUmHIwSTKc572wFkFSaIF6P+Suvisv+OVfnd/k2b+XN7duExEGgjR+MsfbhcutMs3pt9YjeGfnQOTsQ18Fpaqsc0dXq7YlzVg2JVCGQV4ZQdvUkGfvoqVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M1XwUlIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10762C4CEE7;
	Fri, 31 Oct 2025 04:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761884965;
	bh=Y89UM5pl5thDsdpF7GW/2uds8tHOEWMh5JpCL0hCk7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1XwUlIs7NuXjYn/TiyJlXB9iLR8mvX3Rc41+9jO3G9MpkH3U62Qe1UDnTNZC/Smy
	 wOPq7529ElSBZVodzwjChisNJzZuJzEinPhRH5EA1RM83/XSziSYnJG+c2iYzH3aAT
	 DnU7C0vC7s85bOLwGKUoQcdMY4zK7yh2klCDdMsk=
Date: Thu, 30 Oct 2025 21:29:24 -0700
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
Subject: Re: [PATCH v4 next 0/9] Implement mul_u64_u64_div_u64_roundup()
Message-Id: <20251030212924.35d15008efe63256762a294b@linux-foundation.org>
In-Reply-To: <20251029173828.3682-1-david.laight.linux@gmail.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 17:38:19 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> The pwm-stm32.c code wants a 'rounding up' version of mul_u64_u64_div_u64().
> This can be done simply by adding 'divisor - 1' to the 128bit product.
> Implement mul_u64_add_u64_div_u64(a, b, c, d) = (a * b + c)/d based on the
> existing code.
> Define mul_u64_u64_div_u64(a, b, d) as mul_u64_add_u64_div_u64(a, b, 0, d) and
> mul_u64_u64_div_u64_roundup(a, b, d) as mul_u64_add_u64_div_u64(a, b, d-1, d).
> 
> Only x86-64 has an optimsed (asm) version of the function.
> That is optimised to avoid the 'add c' when c is known to be zero.
> In all other cases the extra code will be noise compared to the software
> divide code.
> 
> The test module has been updated to test mul_u64_u64_div_u64_roundup() and
> also enhanced it to verify the C division code on x86-64 and the 32bit
> division code on 64bit.

Thanks, I added this to mm.git's mm-nonmm-unstable branch for some
linux-next exposure.  I have a note that [3/9] may be updated in
response to Nicolas's comment.



