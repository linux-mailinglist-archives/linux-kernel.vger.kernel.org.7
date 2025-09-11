Return-Path: <linux-kernel+bounces-812778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D312DB53C80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB61BC43A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72DD261B71;
	Thu, 11 Sep 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CACiR/2O"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310FA2DC780;
	Thu, 11 Sep 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620080; cv=none; b=HnHmBVNQOMC4LUY0wk6qtDoOyZDVn/tuAygpI9u77/ofbIh6NMdMHlGzMTc6mirVpq5w1Tu+Ch5+i4JG7M/CAOpgJNtfGyQ2Y6+fK7HvFXF0nwzI6gv7BZPzbobsSREugo0WhPPhzh3xPyVB+ZgHvahZzyHf0CuzrIxs4wJ9DiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620080; c=relaxed/simple;
	bh=eep2ZyyHKwsadbfskNNkjdITDV953pA8vh5UGir4adY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XYGUjImYowqXpNHjVFyz5Ntp1Ba09hio6n/H1JAIX0/2n3xbuo/BrQGfmr5vS3SM4vlb7lzQw3NpDWMzNdeqxI8MVmlQXJCl1niIjjbraV4VET+akMf2ohNrvm/h2yH+SN/oIkm+5ZWZrPSK+4Nas+9dFnERnTpktbFBXWSw8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CACiR/2O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3654140B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757620075; bh=VLix0HeEfh5QxyT/kSxDA1EzDXRWZ8h9TgrVv6Ps8Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CACiR/2O1sqIa1d88W0ILwv97CJNrUHGohbq7Iv445VJrxvm6fkMfeVjVO4Hlu1YK
	 hs1Gs5odos9/HegcPALWZCjpZT4XIje1O0tYKHSVZccO8rTRGUQgWnnxvbUabXW+qK
	 VOSI6rMCb2oq2yfcI+WO1zNadsI9DQx5QFbIe5MqkZ1Q5/aLcuB61R7zLk7KA0sAMe
	 QMxVnO2qzu9c8kwf141lnL8xoVbaR6HgRuuw38Mms6X3F4W6U1eVZb89MeavZTrJ1y
	 ZVQAGn9v0/j/cUdVm++ucR64JJOkJyaL0+KD55Bj3FbeX+7pe97EkH0uIaVlXYJUu+
	 dZhcQfHEndJVA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3654140B01;
	Thu, 11 Sep 2025 19:47:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
In-Reply-To: <a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
 <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
 <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
 <87zfb1p0r3.fsf@trenco.lwn.net>
 <a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
Date: Thu, 11 Sep 2025 13:47:54 -0600
Message-ID: <87ldmkojo5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Thu, 11 Sep 2025, Jonathan Corbet <corbet@lwn.net> wrote:
>> A couple of times I have looked into using intersphinx, making each book
>> into an actually separate book.  The thing I always run into is that
>> doing a complete docs build, with working references, would require
>> building everything twice.  This is probably worth another attempt one
>> of these years...
>
> I think the main factor in that should be whether it makes sense from
> overall documentation standpoint, not the technical details.
>
> Having several books might make sense. It might even be helpful in
> organizing the documentation by audiences. But having the granularity of
> SPHINXDIRS with that would be overkill. And there needs to be a book to
> bring them together, and link to the other books, acting as the landing
> page.

Well, I think that the number of existing directories needs to be
reduced rather further.  I made progress in that direction by coalescing
all the arch docs under Documentation/arch/.  I would like to do
something similar with all the device-specific docs, creating
Documentation/devices/.  Then we start to get to a reasonable number of
books.

> I believe it should be possible to generate the intersphinx inventory
> without generating the full html or pdf documentation. So I don't think
> it's actually two complete docs builds. It might speed things up to have
> a number of independent documentation builds.

That's a good point, I hadn't looked into that part.  The builder phase
takes a lot of the time, if that could be cut out things would go
faster. 

> As to the working references, IIUC partial builds with SPHINXDIRS
> doesn't get that part right if there are references outside of the
> designated dirs, leading to warnings.

That is true.  My point though is that, to get the references right with
a *full* build, a two-pass approach is needed though, as you suggest,
perhaps the first pass could be faster.

Thanks,

jon

