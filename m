Return-Path: <linux-kernel+bounces-740776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE9B0D903
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69D33BA0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C82E8E14;
	Tue, 22 Jul 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XqvM2+Cj"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A412D9ED2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186204; cv=none; b=Wow9mGvc00N2EGFfCfjBQK3seCd2T9nHynlv4V38w33hz0fKyyMyhkGY8ygyug2gK8b+n+7LbpwSKOnPyk2ph5S5nuKjrHRzl5avSFvZYuYDUwhGWPv6m27DqBL9otGYiIYToaT507qXpJrShlZYvSzqpD193bfHyr/MGmPCaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186204; c=relaxed/simple;
	bh=BQ0YRnL4OQmW4O/DxpwfHQNlL4K2zkSAxW1sKEYeUIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoU31Fp2CxwyX3yIUlY+EJHO394Ns+3723R3jqiia0StsW5qCn9Qyw9y9nnK7anZ52whUwS2CxDVHp3mAfPji+s+TGFPrulGJuXrrU0aQ09IaUiLZKiVnDgoR53wwEZrAKSwIPQKJQvjR+D4otS7EjBpppoiDL5tkOYck4sI3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XqvM2+Cj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-231.bstnma.fios.verizon.net [173.48.112.231])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56MC9kB4001549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753186188; bh=tazB6FjPPd0Hn7xkenwIUTdi/ehimKmOLxRTpfgGUfU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XqvM2+CjWD8zHa7KfZ0TTlke/VkTJLQB3vjwsKcICKTaMuEef768KcRa40ZNE8I8Q
	 fLiQuMia+BhAUeCHr/DglDu9e41Rbi/BzyWQkVogNrPt7zSPyU2ZOQINJgcJHXIdCd
	 DLauoBZCJF+zH0YD6HYwmUqzLHekTpTiHuUHtUzDwPcfffS6clsfVYBdjW8wYPBz2N
	 ew/gNDxc0pnBwGyaWOD4iZzGhhKl/4tXwkSixRWK8Qga4S3v+ZuE00M5jAd+hPap3J
	 N6oIFjDrCKdnktE9txRwl7ZR/nmifkdIa75d44v+8RLQUsqWn8S6P0LmNHeLxx1sw3
	 foUrosdvMGP9w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9E2DA2E00D5; Tue, 22 Jul 2025 08:09:46 -0400 (EDT)
Date: Tue, 22 Jul 2025 08:09:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Various trees,shell files missing the shebang line
Message-ID: <20250722120946.GC1415603@mit.edu>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>

On Tue, Jul 22, 2025 at 04:46:56PM +0530, Bhaskar Chowdhury wrote:
> This is a human being with flesh and blood.
> 
> Shell script files were missing the "shebang" line aka shell interpreter.
> 
> Note to Randy,
> 
> This is for your spare time Eagle Eye stuff, if you could...please.
> 
> Oh, I might have inadvertantly added some harmless blank lines too.
> 
> Bhaskar Chowdhury (11):
>   Shebang line was missing,fixed

There's also a missing space before ",fixed" in all of the commit
descriptions.  Perhaps you could fix this when you send a v2?

	       	       	   	     	  - Ted

