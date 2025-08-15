Return-Path: <linux-kernel+bounces-770615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA813B27D25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F058E18932AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73642E54D8;
	Fri, 15 Aug 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wsu9AKkJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fR93p2+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289312E093E;
	Fri, 15 Aug 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250129; cv=none; b=Trh446Rd+K/1odtcjjE6pDcnmZG4T5+7mzzMUuxvBxevljl5hhCZBLnjGr1YROAUBhBHFLf5jK2kJHmZHp7cNkLA6YrEdI7v1RyXOclpxuRxikLRb4wcvJyXFAE6b73qzszuZPvWByA9yjJ+iY/IBV4H6cwoc2LVg5hpdE4NIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250129; c=relaxed/simple;
	bh=fqnRwEKoXQHzJh+GvJmDxmm7EqSV8NVoIoaslP2t7Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY16W6mIBDf80SSpq2H9lVbC1hEv+5IFYpCK4Cld4XpXawwgZhwVUL4SIpVMTVFqMqwYVRBIXn4NBHT+2kKTpkJf+7gZpwGTuOKNHPhwlZIC/g/bP7vzxIplD1uSBbs+5vXKFPLe/F+8eIvt/ybYlyjRtpaxmo5rzacMHq1cYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wsu9AKkJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fR93p2+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 11:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755250121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YalIRsoUC1DTFJK+3FntY2b/yYqzpDaZbsdnNMEr0ts=;
	b=wsu9AKkJazNUu47bH4AhMklHBrRJFqnLqMo1PssTAo544QnwXGLVZ4x3dnWH6BeBjGPqAj
	M49JcgRqBXY4bpQ0ukXRgWHPe3ap9J2NnZovlS0y72f7isBR0PqEn9FwWkz4ycbG2fqZRX
	T8GqKGf0u8YWWIAJX91TQ8M/O4G42rxqzIB6hwoAnK8JKqs699J/SEB9TNhTYzouCyWsWr
	PQzmCHthwaiKBip3DWakQZeYnKcn2GHWmhOFk8lWD3rUu02uI6uLCPFdVUlI4a6b02Lgc5
	Ij/NN8k6HOQw+a8AQpHxJFYD4ta0SEHrTMU7GZy3miSXXUal0lgRrXg4rQoAtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755250121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YalIRsoUC1DTFJK+3FntY2b/yYqzpDaZbsdnNMEr0ts=;
	b=2fR93p2+MPyJm5as6KqXkHLR+RZ4e61OpOR1Rgaimq7KFv+Mz/Bfe8yhEl7tn6h0I1cIPD
	kgEKZJTLfkWYmSCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Yi Lai <yi1.lai@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, wad@chromium.org, luto@amacapital.net, kees@kernel.org, 
	usama.anjum@collabora.com
Subject: Re: [PATCH] selftests/kselftest_harness: Add
 harness-selftest.expected to TEST_FILES
Message-ID: <20250815112711-473df6c4-d0d4-452f-9411-b72491adf2af@linutronix.de>
References: <20250815091032.802171-1-yi1.lai@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815091032.802171-1-yi1.lai@intel.com>

On Fri, Aug 15, 2025 at 05:10:32PM +0800, Yi Lai wrote:
> The harness-selftest.expected is not installed in INSTALL_PATH.
> Attempting to execute harness-selftest.sh shows warning:
> 
> diff: ./kselftest_harness/harness-selftest.expected: No such file or
> directory
> 
> Add harness-selftest.expected to TEST_FILES.
> 
> Signed-off-by: Yi Lai <yi1.lai@intel.com>

Fixes: df82ffc5a3c1 ("selftests: harness: Add kselftest harness selftest")
Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Thanks!

> ---
>  tools/testing/selftests/kselftest_harness/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
> index 0617535a6ce4..d2369c01701a 100644
> --- a/tools/testing/selftests/kselftest_harness/Makefile
> +++ b/tools/testing/selftests/kselftest_harness/Makefile
> @@ -2,6 +2,7 @@
>  
>  TEST_GEN_PROGS_EXTENDED := harness-selftest
>  TEST_PROGS := harness-selftest.sh
> +TEST_FILES := harness-selftest.expected
>  EXTRA_CLEAN := harness-selftest.seen
>  
>  include ../lib.mk
> -- 
> 2.43.0
> 

