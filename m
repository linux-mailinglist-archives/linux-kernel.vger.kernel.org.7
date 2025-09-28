Return-Path: <linux-kernel+bounces-835448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF263BA71C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EA51899AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A896220F3F;
	Sun, 28 Sep 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvPXqnCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141A3FE7;
	Sun, 28 Sep 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070867; cv=none; b=swdLSX3CmAGifklRrdi8cqWiLeIAphps+wlNpmuWTTtm7zsHUlBCCyRamjpcFNntB4M4uEtsn9gWIlanmY99rVQf96JUqmIcxlHLYF09TlbQm+Jroey3gLAPaDD3Jij543q89UCtqVo7gxcxUrBKzdlu5GF+E4xA19dxg9ADwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070867; c=relaxed/simple;
	bh=vvNwfQ/2Efdxogg3wf2Xq+cs+e22mGauJxHdeTezgIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HwsTGhJpnfuGxx4RF93FKUIeR17hLkU1Cxa/zX8611raVotYwHrn//IAz0/NRlirKGj/q8d49JVNujG7ir0rqTAiNqqXcJ7byc3aBtcif5yytKkzBXZ4LR7SsIxWCWKlkUmzznqIDe1xvkiKA1ebfXIWHhz/AVpS2LJTzF4BOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvPXqnCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93ADC4CEF0;
	Sun, 28 Sep 2025 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070867;
	bh=vvNwfQ/2Efdxogg3wf2Xq+cs+e22mGauJxHdeTezgIo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CvPXqnCrkzZPSVVaZJKnQZOCfXZvPQAiWaz7udbp3rkaHKddCoEDBU5xg6BP9g9sS
	 NEZ8+LLM6bS4O57MhmCgoMguvqYfPXcb3iVLE/LQ0F2T2ESOVD4CIvZYeqah6aNoFm
	 acZdXEQCH5F5SPtOKSxUPXwJ54Xq9m2rZG5gUhwIpg4xADsqrvuNBUQaGpwj08V9Fr
	 1y/4J1PYCL/aCunNd0CmYa0odmBx/ThHY8IBSZKVwSaa33W81hfzZlOXjwn9Z2987C
	 CMAyiKgmFJqbbjmKEkMjX/z3ChWec6QnGiFL61d8LinWqtsT4rYIujULfvBxrm8t1f
	 WHM1yv80HwxYA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Sep 2025 16:47:42 +0200
Message-Id: <DD4IKU7O94WN.2VALE9M80XGQ7@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <linux-mm@kvack.org>
To: "Elijah Wright" <git@elijahs.space>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
In-Reply-To: <DD1SGLU4180C.361W5XLH76XNC@kernel.org>

On Thu Sep 25, 2025 at 11:54 AM CEST, Danilo Krummrich wrote:
>   (3) Implement a macro to generate a custom KmemCache Allocator trait
>       implementation for every KmemCache instance with a static lifetime.

Thinking about it a bit more, I think we should go with option (3) for now.

With its only limitation being that it always binds the lifetime of a kmemc=
ache
to the module lifetime, it still seems to be the best option, considering t=
hat
the alternatives require additional synchronization in hot paths, may *sile=
ntly*
leak the kmemcache, cause significant code duplication or break dynamic
dispatch.

Tieing the kmemcache to the module lifetime should cover the vast majority =
of
use-cases; should we ever really need something else we can still revisit t=
he
options.

Thanks,
Danilo

