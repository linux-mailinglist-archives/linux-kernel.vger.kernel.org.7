Return-Path: <linux-kernel+bounces-808529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E1B500EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0C45E1A44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B05350D7B;
	Tue,  9 Sep 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JW/PtQM9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C72BB17;
	Tue,  9 Sep 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431299; cv=none; b=nqjuSik95raGNqJKSt/j4JqxOFKRKaA/aZvongooJi/w1w4hYwH5LuEO27WywTMR6QRRSpG0TXF2akyhq5AwpfTWpX2eFRXVt0q9RTAU6Fl0p5O7r6BM7gWnnzXpQsF5eX/dX4hVlq/AYWtqiCPBp4QXUU/8Peth+FsB3bBEWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431299; c=relaxed/simple;
	bh=2nt142bLJTgkqjdfJ9NULREaoD8bZ+1URKqRdi+U2NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hhvc63doK8lfGPMg4lvKZGU0LjklwzCm1aBp1nwBzqF5iyu04At3oXF+fnrwQRFWagyGZlt4MivVSYysVW4STXCL9IMl2gvBfkVdKro1iXiAUaimt+mqYjBHVr4eBMQOaPm+etWE4CiD0YN2Rmx/4EsoCQ0q+iOnz0C1SKFt9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JW/PtQM9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C41DC40AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757431296; bh=RVJ4hAAVw9glAoYB1ielozFqGi7Z9Ay+EFfKqdtlLGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JW/PtQM9629XOUyrOYaQcgIVAJ+gVf/jruuhQ10qyXUu3HIq6kL2SPYCOv98oUIIO
	 MEMAtfp20nXb+BORzWHtQ8Bv2/e7+ZRnToKeH+4oSkBZ6bU6tPG9F6QHgMq1FGKxCT
	 SM2JiUt7w22Q+d95V8aHTZgBujqyMIhSFdegiu1rcJKN5FKvqKtnuPookw5m4AZFh7
	 OXsfP/bSlXIczZYV5n24P/c3P/kWi0LGaGxfSyxlSlV2Day7RKsUicxLdZRG/XhkHi
	 qqoJfOoOWEhYdFARutS6kfU+Y8kBZnHtXp/ZPwX1b3F/FAwAvEYgzMpXiLzH0U/0F5
	 juE5Tc5XRVm4w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C41DC40AFD;
	Tue,  9 Sep 2025 15:21:36 +0000 (UTC)
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
Date: Tue, 09 Sep 2025 09:21:35 -0600
Message-ID: <87ldmnwt1c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Another nit:

>         # sphinxdirs can be a list or a whitespace-separated string
>         #
>         sphinxdirs_list = []
>         for sphinxdir in sphinxdirs:
>             if isinstance(sphinxdir, list):
>                 sphinxdirs_list += sphinxdir
>             else:
>                 for name in sphinxdir.split(" "):
>                     sphinxdirs_list.append(name)

That inner loop just seems like a complicated way of saying:

	sphinxdirs_list += sphinxdir.split()

?

Thanks,

jon

