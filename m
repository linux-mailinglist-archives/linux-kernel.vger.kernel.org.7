Return-Path: <linux-kernel+bounces-753171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A3B17F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4122F7B96A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8822A4DA;
	Fri,  1 Aug 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgmTsZgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6W3tCG1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787B1F4181
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041099; cv=none; b=Dp+rQ6dlNt/f2DgrAEnHm4KAjk+J0WaOcuOyBmDe5A7GuRGZZHWe+ANpwVB2WCHTF4oJTuKh3dH9wsJbgBXmxvmsVq05dbOP4n1iCpyPlTBNiT+q67MTWNtMMoGKeXVFNtkMa1C/FJnrw+Nn3mBsnc5eiy//YxILVK8vyFWn09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041099; c=relaxed/simple;
	bh=VXvkjUjBbAUUsZs16kS8CUsfuOcNrZNgUsJvNQqa0r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUvylQhHpTiQyXBcIChOY+SaYEujwUb2Q381fS1nTNFAZoIkNZi4gcmZmwVhKcV/2Yag2XhCleBzyRXB9Ublc6KOlCkhqmO8xGo8eqmR86USnli/imbjZnRsCDjaFIKL+omdRic8j1cNkvT4Jolbh/gAemzQ57XAkFuBcx23cU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgmTsZgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x6W3tCG1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 1 Aug 2025 11:38:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754041096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tGSv6RdaV6X5lnOcQToZWXgwKNlnA4P6z1e4N4UFCfU=;
	b=hgmTsZgPXSrteeoFmNEkplfEl6qJJxsVIWk9IpsP/fyxbExCMaXOmcssOy83GdjGNauUJx
	JiREhtCbsaGWRec/gmxI0KB3Q+4Mugbn+uZYZHJPGaPw3MOGmnLrLR+zO5i1iP7uAym6oh
	ElQiPJBGm46Mw63gvFqtTOVSYkGtvu7OAfUWg3LBstz/Yicry3RM7fuW2a2OpM9n5qKedU
	EifrCwrLAgny0gQO8hvCA11cgsg6u8AQVzp2Er4DeumqMjwqd7QQEWZUT+xDn1zffZSQEi
	TVJ+dmZaGP4KO5Gg5NzaodOJf9FMa38aGKu40DGMrqCUDJA8PEmFw1nGOUYESQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754041096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tGSv6RdaV6X5lnOcQToZWXgwKNlnA4P6z1e4N4UFCfU=;
	b=x6W3tCG1WSZ31fZLQIPnCK6FNhiBj41QTW8K6f2PAoc7On8q9t8P0NBJHL9ps7hIybF2+e
	pHN/7/wk5EIQz1BQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: disable kasan_strings() kunit test when
 CONFIG_FORTIFY_SOURCE enabled
Message-ID: <20250801113228-5a2487e0-0d90-4828-88c7-be2e3c23ad3b@linutronix.de>
References: <20250801092805.2602490-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801092805.2602490-1-yeoreum.yun@arm.com>

On Fri, Aug 01, 2025 at 10:28:05AM +0100, Yeoreum Yun wrote:
> When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
> triggers __fortify_panic() which kills running task.
> 
> This makes failured of kasan_strings() kunit testcase since the
> kunit-try-cacth kthread running kasan_string() dies before checking the
> fault.

"makes failured" sounds wrong. Maybe this?

"This interferes with kasan_strings(), as CONFIG_FORTIFY_SOURCE will trigger
and kill the test before KASAN can react."

> To address this, add define for __NO_FORTIFY for kasan kunit test.

"To address this" is superfluous. Maybe this?
"Disable CONFIG_FORTIFY_SOURCE through __NO_FORTIFY for the kasan kunit test to
remove the interference."

> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

Missing link and changelog to v1.

>  mm/kasan/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index dd93ae8a6beb..b70d76c167ca 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -44,6 +44,10 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>  CFLAGS_KASAN_TEST += -fno-builtin
>  endif
> 
> +ifdef CONFIG_FORTIFY_SOURCE
> +CFLAGS_KASAN_TEST += -D__NO_FORTIFY
> +endif

The ifdef is unnecessary. If CONFIG_FORITY_SOURCE is not enabled, the define
will be a no-op. This also matches other uses of __NO_FORTIFY.

> +
>  CFLAGS_REMOVE_kasan_test_c.o += $(call cc-option, -Wvla-larger-than=1)
>  CFLAGS_kasan_test_c.o := $(CFLAGS_KASAN_TEST)
>  RUSTFLAGS_kasan_test_rust.o := $(RUSTFLAGS_KASAN)
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

