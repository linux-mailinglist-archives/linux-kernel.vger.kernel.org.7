Return-Path: <linux-kernel+bounces-780525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A971DB3030C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4765C82EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2334DCCF;
	Thu, 21 Aug 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fj06HT0d"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC92DF71C;
	Thu, 21 Aug 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804987; cv=none; b=sIU9jWFUrhV1p+0QYd/wtcRo2XOuARITI/cI8QdXp2BnsRsoNH9BKkrdyWgiNtzYfRlbrxnMrj7n1cEwTau6ZDTTDny/a/0ddLPLLZmAEG5ZAosa2AAawna8MZX8fcy27rKE9kSBDGwmEeyDVA7N7y8Y2iHYM3C9l5oM53WxUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804987; c=relaxed/simple;
	bh=uHcy2AviljsxLllJ3OPGmlhzgQEqdyQntMpt5D8c29U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUySWPo1uBnKbs5CqjidSRiWLcB+5o3aIInQ8tlhNfaNIV53KXSJ35Wl6w+Nj/M2+HrMnu8EMgv8MOExlaumUmi2v+u3aZcgPksHzKfDAhrCsbwDV+1eDEcdNPcj7qNgiikv2loJdIlkgoDAaNBp5oUbDjUCziL7kxOIdAHzs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fj06HT0d; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E418940AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755804985; bh=pmY6KG+wTzJ4LEBx4m1XWQJtkWHMxxgvsD7nwMl8SYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fj06HT0d89qImOAXo2ani3JiR3pwXraPM90AW8x5eBBe06pZLslh/l+Dy/mosefIZ
	 KUNfFJuD85Srygk0zFJFWEUF0aLMZv5Dc3lE+ygdvu/qLQQ+L/ezSqndfEs2QIzMMO
	 JnS5r+qmyqe0vjCcKpytc3hBr/q49ZSVLfSN6qIJAzCoEuS9AgbPwJiR40UWbzfUrR
	 2gZ8jieG/K2QGowQSYwZIwpkylpTZ3cQkRDizGd6mGSCKRjgggxghAhiA4bJ2PgUJb
	 1B50cqbzdWrtEZ5swW7IH2dio9/CcRlVSfncaKFcgsJrNxPWxIjb/Hhp2lU9N8VOC9
	 C8y1dNTHIWmqw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E418940AD5;
	Thu, 21 Aug 2025 19:36:24 +0000 (UTC)
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
Date: Thu, 21 Aug 2025 13:36:24 -0600
Message-ID: <87v7mg5ux3.fsf@trenco.lwn.net>
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

So I am just now looking at the script and seeking to understand it, but
one thing has jumped at me that I wanted to toss out there...

> +# Minimal supported Python version needed by Sphinx and its extensions
> +MIN_PYTHON_VERSION = parse_version("3.7")
> +
> +# Default value for --venv parameter
> +VENV_DEFAULT = "sphinx_latest"
> +
> +# List of make targets and its corresponding builder and output directory
> +TARGETS = {

We don't at this point have a formal coding standard for Python code,
but I do think that we should, to the extent possible, stick to the
rules that have been established for C code.  One thing I would really
like to see is in the comment style; our rules want:

    /*
     * ...C comments spread out with the markers on separate lines
     * like this...
     */

so can we do something similar for Python?

    #
    # Markers above and below
    #

I will confess that this matches my personal subject preference, but it
also brings us closer to what our C code looks like.

(I don't know that I would push to redo everything to match that style,
but instead to move that way going forward).

Thanks,

jon

