Return-Path: <linux-kernel+bounces-761376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A3CB1F945
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDFC18979D8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2422A4E5;
	Sun, 10 Aug 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X//UV3gC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9eDelKj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652421C19D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754813005; cv=none; b=M+JlcbN/PldAbJWx92bD5OYziLfLN5V2Vdo0Ges49lu6NdBjd02glo6qkk/+wm4iZo9n33VrefeNFTUszf9+v6x3a5HkVWb2qN7fHTOcunMPCxjjz6BWJ1vizxtRflxdUMUNKFGASnNpVFlLc/uoD4oxniKn+Hcu6aMsKri8MZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754813005; c=relaxed/simple;
	bh=nXK2mSgGPp6/C5xxgucCzCbZ02BX7q/V84JRyhwTOew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkg2Kbvo7uRQKNklCxMhIHQZaUrZOxBfWoSOaJFhedxODsNhnsG6KyFOU3dG0rrhHiFMHBiQuN/4YtllnD0D9BjHm4jecklv3D1LUJspavu+OgR6CvW+bArnxtLmM+QG4qYvkrx394Xjnb0fL8lyYBymneB+5Y5mpA4wiEooYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X//UV3gC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9eDelKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754813001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KupjT+G+qGfBWouHMcG68F1zSg7ZodVvjKNcni2DPuQ=;
	b=X//UV3gCeoascmIhxWzxTL4gp4on0EOZk426avxUZNZ8FZ55Tf31Sh06eHW+b55i0Wqs3D
	H5Od4H0ZRPIl/JwjYduF9Y4KGUL923UDFxDho9LcNtM1UW1d8P5LREDBf0wzv1WkRY3eo2
	YIF4K4oalau+JtXwNP4j5rWu2SSUXRqaT1THf2PQ//rFNRxOqmJDhRnhgmE8/M3jI0lYDO
	jt+RRnpQt51scQQwBr5nYyabnV7IgAdjEHHs43OaH/lpE9/kZMYBRNhNT0FwfRjpAfFUiI
	Fm0oAgkqakyEMcScxHt9Wb7UxytQnpdt36+pBp+kBXH+TJYicuGJq+TYZK0blg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754813001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KupjT+G+qGfBWouHMcG68F1zSg7ZodVvjKNcni2DPuQ=;
	b=F9eDelKj8+RGvzE+BgIpJEsQoIeFhXUSi9KCqtTKuAtyW310RO/VnHbRzyZMBvxn1KWD+0
	4CIrFTEcplPjs3Bw==
To: Wake Liu <wakel@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdso: Define NSEC_PER_SEC as 64-bit to prevent overflow
In-Reply-To: <CAOcRiAFzN61FE=By1ANB3aK4PKVTBQAzrCcfoHfHwMX7Qn8wYA@mail.gmail.com>
References: <20250805162153.952693-1-wakel@google.com> <87ikj0esnv.ffs@tglx>
 <CAOcRiAFzN61FE=By1ANB3aK4PKVTBQAzrCcfoHfHwMX7Qn8wYA@mail.gmail.com>
Date: Sun, 10 Aug 2025 10:03:19 +0200
Message-ID: <87wm7bbo3c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 09 2025 at 17:49, Wake Liu wrote:

Please do not top post and trim your replies.

> CLOCK_REALTIME         ABSTIME PERIODIC timer fired early:       1 : [FAILED]
> Looks like there is some integer overflow on 32 bit builds in the
> timespec_sub function:
>
> long long timespec_sub(struct timespec a, struct timespec b)

That's in selftests and not in the kernel VDSO code.

Can you please be precise with your subject and changelog? You claimed:

 "This can lead to incorrect time calculations within the VDSO"

No, it can't not because the VDSO does not use it that way.

> {
> long long ret = NSEC_PER_SEC * b.tv_sec + b.tv_nsec;
>
> ret -= NSEC_PER_SEC * a.tv_sec + a.tv_nsec;
> return ret;
> }
>
> on 32 bit builds NSEC_PER_SEC and b.tv_sec are only 32 bit values
> which I'm guessing is causing the overflow.

Guessing is not a valid technical problem solving approach.

> NSEC_PER_SEC is defined as 1000000000L but if we change this to
> 1000000000LL then the test starts passing.

Yes, that function bogus on 32bit.

There are at least ten different ways to implement this function 32-bit
safe, but you picked the worst option of all, which breaks the kernel
build as you got told by 0-day.

I'm sure you can figure out how to ensure that the multiplication is
actually expanding to 64-bit or use some other approach to calculate
that delta.

And please make that an inline function and put it into a header file in
the timer selftest directory, and replace _all_ copies of it in the
various timer tests.

Thanks,

        tglx

