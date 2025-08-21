Return-Path: <linux-kernel+bounces-780588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA4B3057F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C2D188DC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184352C0287;
	Thu, 21 Aug 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UOr11Y00"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A31A5BBA;
	Thu, 21 Aug 2025 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807069; cv=none; b=F6ibk/jYRQo9yW0Yvh8sI7nxWtu5NY4lxpgKrC1pUmZjwMP3jMzLOYD4tlDT5ujBnuaIqKPsWYi7tfkXLtCxfkISIjZ5pCudoQOzUyuIXndZT9uuXYG2ch8+dDz9OxjB+madqXY5WSnUhViHVmCihmjVv+bgrFngm8Ui6mBpXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807069; c=relaxed/simple;
	bh=BW9M6QtRAnKMxrAdqHnhS/5ceZZdiYkdOJf9jymxcWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gU3sFMvZ5lHUm+GtdjxdcoArEsGHQmut96/VLa0H6UGmRSTB0RkY85kiQ7LSF/o75r2KTOA/kpLWVPiGchE65K+88sCiwJvsTNYNcod112m2WnOVhgbC2ILiK8tpX1658CYQS5eX4si7FEYntjIBrqq232aAHhgzxFVwf0cE4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UOr11Y00; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E40D440AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755807067; bh=zHY28aIE5Hj5uxH18e1m7ctBV4BADozo7+hcXs3760I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UOr11Y00fL2g7/x4VTDhE3aMiuf4f0xaWV9Fx80YREoEuMSIJmWJZ7a4kRKmNH6O5
	 4xPr1aFKrG8NF05w2JpcClMjXs8+L0y+WCD90nsE+yq1fihC745uPeEiUo0PNIQIFG
	 SKR/keZWkfVJZnU5CR8keZiKP9ru1R1mlgRvhUR7wlqYTlGbFADsu4Aw+ucoSphDGK
	 Mum/DQ28j9HSm/C/2tcOJYVQUCP54Edc1RJjiDP1oDndBVG3EuNljvEZywfvE0fVmK
	 xXbB4x1PW+YKw3AKreGCO6SdsOi00zhnPN2KZDbmUmuQu79S8Hy5r2DhYSQM3+kiBG
	 rIs9cNDqwxlBg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E40D440AD5;
	Thu, 21 Aug 2025 20:11:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Andreas Hindborg <mchehab+huawei@kernel.org>,
 Benno Lossin <mchehab+huawei@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Danilo Krummrich <mchehab+huawei@kernel.org>, Gary
 Guo <gary@garyguo.net>, Miguel Ojeda <mchehab+huawei@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
In-Reply-To: <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
 <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
Date: Thu, 21 Aug 2025 14:11:06 -0600
Message-ID: <87plco5tb9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> There are too much magic inside docs Makefile to properly run
> sphinx-build. Create an ancillary script that contains all
> kernel-related sphinx-build call logic currently at Makefile.
>
> Such script is designed to work both as an standalone command
> and as part of a Makefile. As such, it properly handles POSIX
> jobserver used by GNU make.
>
> It should be noticed that, when running the script alone,
> it will only take care of sphinx-build and cleandocs target.
> As such:
>
> - it won't run "make rustdoc";
> - no extra checks.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .pylintrc                    |   2 +-
>  scripts/sphinx-build-wrapper | 627 +++++++++++++++++++++++++++++++++++
>  2 files changed, 628 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/sphinx-build-wrapper

As a whole I like the idea of this - I would rather be reading code in
Python than in makefilese.  But I have some overall notes...

I am a bit dismayed by the size of it; this is many times the amount of
code it allows us to remove from the makefile.  Perhaps there's nothing
to be done for that, but ...

Is there value in the SphinxBuilder class?  Just because you can create
classes in Python doesn't mean that you have to; I'm not sure why you
would create one here rather than just doing it all at the module level.

Is the "search for a newer Python" code really going to be useful for
anybody?  It seems like a lot of work (and code) to try to quietly patch
things up for somebody who has some sort of a strange setup.

Please, no "except Exception:"  (or the equivalent bare "except:").
That bit of locale tweaking shows up in enough places that it should
maybe go into a little helper module rather than being repeatedly
open-coded?

Thanks,

jon

