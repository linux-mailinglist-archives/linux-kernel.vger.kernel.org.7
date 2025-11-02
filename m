Return-Path: <linux-kernel+bounces-881759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BAC28DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E063AACF2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D53258CDF;
	Sun,  2 Nov 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lDcfCm0g"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B152E403
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081811; cv=none; b=DOWijv+b6ppIFKg2mBEH1XvOKXkOT2TFogkj9Q6GiIvcBhpDnDV3R/U9tzqfwfs1hzt0Y4L/NUlzXGqHQ/m1mkhLdVy1LXqDi6VybW0PeUx0NZPclvVFO6iYsG6qP7/i5UkUhfwyNTfIDV6mOr7vZe6cI22sBjRvmjrM/ejmHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081811; c=relaxed/simple;
	bh=AmLTb3utMTncO5y+ye5xJUFQ+a3tZsp5XiaO+kvTUh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjCTnBB6L0GREdt1S656FUGHUkfLNMJIENA78owGC9x/okKD2JGhUFrxD/Bpt7jTMJCtKhOFSdr8V57jPgBG5N56isHgllxtmjea771/QbwQVD9Ipxv+jKnsjvU1/xKOy4fAht6bbgNtHHF1KGK+mFSdZQmFw5aFkQZQWVRITjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lDcfCm0g; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762081807;
	bh=AmLTb3utMTncO5y+ye5xJUFQ+a3tZsp5XiaO+kvTUh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDcfCm0g3kX+jA+RHZEPQJNOWwfCmNxu+uPcHiBEIyYKwhQHiChBXzOYpjd4GyqZO
	 4oY4s0liSw0lIrIDCk9KOqqnJ6gIbgENrSWaPH1E6EzyOfxWe1jXgwZ5vbPYLrGeCg
	 BXQmA/uMXfO6Vqm/cmtS7ZszUYpUp9XAwxE9p5Fc=
Date: Sun, 2 Nov 2025 12:10:06 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tools/nolibc: add missing memchr() to string.h
Message-ID: <f30441ce-66ba-4de8-94ac-98f4b17b5ef4@t-8ch.de>
References: <20251102104611.24454-1-w@1wt.eu>
 <20251102104611.24454-4-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102104611.24454-4-w@1wt.eu>

On 2025-11-02 11:46:10+0100, Willy Tarreau wrote:
> Surprisingly we forgot to add this common one. It was added with a
> per-arch guard allowing to later implement it in arch-specific asm
> code like was done for a few other ones.
> 
> The test verifies that we don't search past the indicated length.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/include/nolibc/string.h                | 15 +++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
>  2 files changed, 17 insertions(+)

Applied.

