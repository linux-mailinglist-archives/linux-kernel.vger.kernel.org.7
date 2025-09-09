Return-Path: <linux-kernel+bounces-808478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A121B5004E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D618C4E69C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFB352FE7;
	Tue,  9 Sep 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SJnDSx0T"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFF350842;
	Tue,  9 Sep 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429636; cv=none; b=dRUnun4TQLqHGlHFWOvCUJrcOBRXJDJss8YJk2J9nQEpsIwAk9L8t0DF0JHU25ou0uKQT5x0W2To+g+ngrN++EvxAFQvRVUdw5uArzPi1RkVGnJAs8IfuFYdQij3ETdabK5iBDlzmm1iHpxGkdQpq4rIUvXngmeJpYIMND1ccYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429636; c=relaxed/simple;
	bh=Z4dUX4NAPHy8+DdtzCgQc899JlEpvZ9mBKtxvCyfKzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BeDZdTwyBgA7ruYxXy4x1oRy+AJl5J7LHdnc65XU61eye11JJE5Ne4pKUi8uEo6nTraDEw6WuTvRdSfy3XlUj3bARCMwqF4KCSm902Tini3Z5Oli7khK/XYb9CVqEMWlJXdsE+/vLYNWTO2Wk4LWtjzefw5+/ktawNRJMcaczo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SJnDSx0T; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8697240AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757429631; bh=GXehrINYxVp7gN/lP4m0WOVKrE9xFwHSx43tXHxuhmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SJnDSx0TwfwwMsPAv50xXQiGS9khjSezgu32+2YnyAjzIueIBSQCUXKTn9o57tE8I
	 7sZtyi1x0zBjwKdcFI7dJr44E/71y+sp0ZOWmvzgVwBQFrPU7ZWxwEre5SiBSjCn/9
	 y1QTt96UMBfapXcM0GvAslImdj3pU4Wieb3PZ0is3VyRM2X0zYrnPf4sXXJzobYHhc
	 FeJKhjaPE9iza26A8Wp1BEkG0DT8AftMD+lCigWk56ks/ngaMUU8arZ3i9MDMhvJ9q
	 NYSeJtqt/hZrx60/EMSmh16onwTjKaF+t0W0sKfAXe4VTTidyMSUbIdk1p+l/PsgzM
	 hkrH5DSHBC7hQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8697240AFD;
	Tue,  9 Sep 2025 14:53:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Andreas Hindborg <mchehab+huawei@kernel.org>,
 Benno Lossin <mchehab+huawei@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Danilo Krummrich <mchehab+huawei@kernel.org>, Gary
 Guo <gary@garyguo.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Miguel Ojeda <mchehab+huawei@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
Date: Tue, 09 Sep 2025 08:53:50 -0600
Message-ID: <87plbzwubl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Finally beginning to look at this.  I'm working from the pulled version,
rather than the commentless patch (please don't do that again :).  A nit
from SphinxBuilder::__init__():

> #
>         # As we handle number of jobs and quiet in separate, we need to pick
>         # both the same way as sphinx-build would pick, optionally accepts
>         # whitespaces or not. So let's use argparse to handle argument expansion
>         #
>         parser = argparse.ArgumentParser()
>         parser.add_argument('-j', '--jobs', type=int)
>         parser.add_argument('-q', '--quiet', type=int)
> 
>         #
>         # Other sphinx-build arguments go as-is, so place them
>         # at self.sphinxopts, using shell parser
>         #
>         sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", "))
> 
>         #
>         # Build a list of sphinx args
>         #
>         sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
>         if sphinx_args.quiet is True:
>             self.verbose = False
> 
>         if sphinx_args.jobs:
>             self.n_jobs = sphinx_args.jobs
> 
>         #
>         # If the command line argument "-j" is used override SPHINXOPTS
>         #
> 
>         self.n_jobs = n_jobs

First of all, I do wish you would isolate this sort of concern into its
own function.  But, beyond that, you go to all that effort to parse the
--jobs flag, but that last line just throws it all away.  What was the
real purpose here?

Thanks,

jon


