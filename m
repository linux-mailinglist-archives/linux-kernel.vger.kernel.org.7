Return-Path: <linux-kernel+bounces-744811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF84B11134
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B57BA765
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792422ED856;
	Thu, 24 Jul 2025 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G4npzWaC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE3260578
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383183; cv=none; b=Jr/b2n1dOnYGpEMoQ5tziE7/+F1KH9Lr8cL8PkIFdMWQlUetJRkC/VC4N4pUKuFmJSUzXwkKgCYvdf0n+XEOBI8hwDCZ8bVZQkgTCZW+WAES1RlWHZGxpJaraFrfwPfk4juDgPOxxdCxGRpzEFkppluSEGve8NrzQ52iOP5EITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383183; c=relaxed/simple;
	bh=7HcvjCCgvYT0Xx9xvilMRJ8H5x4WbjELKlsLdq7oVJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dejjeC+9/WKgsYM1fDr8RFmvs5LQBIF1yvtNw0MlJPoS6MPZAtET9xvrLeGE4jWIfpd6vbaPtEKMWjF46XGaTYW15dMGbHzyLhzcaXClD9F7JmivzJT9W4l/qAnHZjfVNKy6clPOWy70/su2XxMITLibo0+EVCGf3UbR4zd1fSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G4npzWaC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3EF3440AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753383181; bh=u0Xf0b8DinK01imbKK6i64vZs39pYDGJTQ5VYvwvFoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G4npzWaCRHx/kHnsrMIeGN5Ihq3TLvct0YEtFNcm0vllmisIQvSuDqpIJsBg9Snxs
	 DwkzjBwBhwcoHED4WgxCJab3d/+3Q0N7M/ZSIQ7Q0DCBtPYlGiicJYpEekhU9v8N7T
	 1kIbJDCapnNj6g61YNDaqn1bE4cpIiAbCpZ651+ZseHG/gpNhobMHxbWWKopdM2oVI
	 TrCzMFN0VAQmWCL6Qjpm1xJr7AcWtwokqkggYQhuTa8aOIPKctK/qNr0EJquNO9fbp
	 z22+COmDXDHFilHiBn/1MosmHguYzXr/9mQlf2+z8//depVNZIOn8CaYdQThHNkeL/
	 q4n2bsrri1Jow==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3EF3440AA9;
	Thu, 24 Jul 2025 18:53:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, David Hildenbrand
 <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove io-mapping
In-Reply-To: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
References: <20250724145313.65920-1-lorenzo.stoakes@oracle.com>
Date: Thu, 24 Jul 2025 12:53:00 -0600
Message-ID: <87y0sd8lpv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> This is dead code, which was used from commit b739f125e4eb ("i915: use
> io_mapping_map_user") but reverted a month later by commit
> 0e4fe0c9f2f9 ("Revert "i915: use io_mapping_map_user"") back in 2021.
>
> Since then nobody has used it, so remove it.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/io-mapping.h | 231 -------------------------------------
>  mm/Kconfig                 |   4 -
>  mm/Makefile                |   1 -
>  mm/io-mapping.c            |  30 -----
>  4 files changed, 266 deletions(-)
>  delete mode 100644 include/linux/io-mapping.h
>  delete mode 100644 mm/io-mapping.c

[...]

> -/*
> - * The io_mapping mechanism provides an abstraction for mapping
> - * individual pages from an io device to the CPU in an efficient fashion.
> - *
> - * See Documentation/driver-api/io-mapping.rst
> - */
				      ^
				      |
You'll want to get rid of that file --+ too

jon

