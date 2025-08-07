Return-Path: <linux-kernel+bounces-758490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602AB1CFD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85BF6230B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CC78C9C;
	Thu,  7 Aug 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="br7YcBeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B054437A;
	Thu,  7 Aug 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526987; cv=none; b=SM18DylyT2GYM/xBtwFLK0sucf77ZSi7G/4+mIQJ+6PH3EujEZjxhS2gXEHuwjx+lDs1QX5KEdwZ2EAxBlU2L+b67uA58i/YbauwxkLO7jOT5VEIFtzmYN8lI6qWzRNqrWTct0Efz4jQQ/Ub9X7n5S9mbeq/L+xkM6ZaNDiEdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526987; c=relaxed/simple;
	bh=8gZJwOibU7z3sXqO72OMz4Bxm9hzb2fPObNKfNZFRfM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qqRvpnx7GNnO/s+LmBC5TV7A4Z/4DIbTv0v4uLHH3Oa9h92cqCtNlFvl7nfeh3EbIOd+KQWdH+qrEWVyffmnEymk+hoKqSKnX70sugXI84L9EHAbQafYNaloXlp3BZd0XOqaPXR46sKmAI3/3/1uvj3v7UyOmqi+m0+6K7j3raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=br7YcBeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522C1C4CEE7;
	Thu,  7 Aug 2025 00:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754526986;
	bh=8gZJwOibU7z3sXqO72OMz4Bxm9hzb2fPObNKfNZFRfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=br7YcBeqyTRFvDRu8jQ2I3S9WEKQvmRNxp4skfY9xPxM765lNpBfBQ6I9VbFc+mGP
	 OWKHx3uxAdSo5Mkti1sPco1ByJBxf58e4enS4o+hvzk1duNH8zCmLhK/2YzH3jvicE
	 GJv1SCAIiFYG0ThDMSN8DXUdHLJC9xOXG3wXJ8/4=
Date: Wed, 6 Aug 2025 17:36:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Elver <elver@google.com>
Cc: Soham Bagchi <soham.bagchi@utah.edu>, andreyknvl@gmail.com,
 arnd@arndb.de, corbet@lwn.net, dvyukov@google.com, glider@google.com,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sohambagchi@outlook.com, tglx@linutronix.de,
 workflows@vger.kernel.org
Subject: Re: [PATCH v2] kcov: load acquire coverage count in user-space code
Message-Id: <20250806173625.f83a6fc9da16099e8ae12c85@linux-foundation.org>
In-Reply-To: <CANpmjNNvsJ_u7ky+d1tiXtwc-T3z6VB4SiMqpo6aKWBBFO3ERA@mail.gmail.com>
References: <CANpmjNPWzJZrAFT3-013GJhksK0jkB6n0HmF+h0hdoQUwGuxfA@mail.gmail.com>
	<20250803180558.2967962-1-soham.bagchi@utah.edu>
	<CANpmjNNvsJ_u7ky+d1tiXtwc-T3z6VB4SiMqpo6aKWBBFO3ERA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 08:00:00 +0200 Marco Elver <elver@google.com> wrote:

> > The load-acquire pairs with the write memory barrier
> > used in kcov_move_area()
> >
> > Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> > ---
> >
> > Changes in v2:
> 
> Btw, it is customary to send out the whole patch series on a version
> bump, even if only one of the patches changed.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers

Yes please, try to keep everything together.  We look at a lot of
patches!

I queued this as a -fix against the original
https://lkml.kernel.org/r/20250728184318.1839137-2-soham.bagchi@utah.edu

--- a/Documentation/dev-tools/kcov.rst~kcov-load-acquire-coverage-count-in-user-space-code-v2
+++ a/Documentation/dev-tools/kcov.rst
@@ -287,11 +287,6 @@ handle instance id.
 The following program demonstrates using KCOV to collect coverage from both
 local tasks spawned by the process and the global task that handles USB bus #1:
 
-The user-space code for KCOV should also use an acquire to fetch the count
-of coverage entries in the shared buffer. This acquire pairs with the
-corresponding write memory barrier (smp_wmb()) on the kernel-side in
-kcov_move_area().
-
 .. code-block:: c
 
     /* Same includes and defines as above. */
@@ -366,6 +361,11 @@ kcov_move_area().
 	 */
 	sleep(2);
 
+        /*
+         * The load to the coverage count should be an acquire to pair with
+         * pair with the corresponding write memory barrier (smp_wmb()) on
+         * the kernel-side in kcov_move_area().
+         */
 	n = __atomic_load_n(&cover[0], __ATOMIC_ACQUIRE);
 	for (i = 0; i < n; i++)
 		printf("0x%lx\n", cover[i + 1]);
_


