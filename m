Return-Path: <linux-kernel+bounces-761537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C33B1FB84
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C9D18928DF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BF271443;
	Sun, 10 Aug 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx5H9vs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8AD26CE0F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848780; cv=none; b=JcrZBdmyM0VuW29D1vD0/NMwnHvhS3q62rm7Q/Xhpi/TwCa2pIRsNLG9RgkF2v9jiVjZ9mRMdozjnE3l70+Amn6WNvQMld44O0mC+2IahQZjnM8Vbu3XZg6EEZ/6gCQiog7pLwTGoEglr9++ZDSuMxoZb3rswDp7POmuMwTq2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848780; c=relaxed/simple;
	bh=HRUwz2fq1JP1GMsMe11ZelKRNKkapWYljIw4KOn0mHg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ldQrUgpIm3J2s8hJSi5+giKIrs4jK+HIdsOCl9J67ltB7tuBUP4i2chI4dvUw0kX8iDpqasTSCxL0cEqz97NiF0RHQNMeBNYwGLizG+Vy1/Aj32wp5I/7MzHOKGMQ1iM+YbWlELGmjCGqkJD23cmPoHFi7GYcmIcqnc8p42MEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx5H9vs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF2C4CEEB;
	Sun, 10 Aug 2025 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754848776;
	bh=HRUwz2fq1JP1GMsMe11ZelKRNKkapWYljIw4KOn0mHg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lx5H9vs6vrbgHptM9+HhKsU62R0SrZDySXhhribT5ghSYyoLEwnAVbY/wxlKFe/VS
	 vRuIDIvUkMuKL6STahHy5UdBy/eSQL/vvD45AnPH4/rQ8AOGARMtVM+H/6CF05kX8v
	 1ll4ToGkjrD5zIkUQiaTWRJwM/HqfyNCBupPgz+qsETF/cddzOLO4MBJ4oZqEaWhkx
	 bsXahkp0cLbDuDkszWfmDd3xv61MIPpARI03njshXOID6C0S7dVXgqnFaSQOtH9Cxd
	 cfTCplM2gakLhsQ3slLDnFMwUwnkPhFWl+40OeTVCebLyb2bCFal87E4wIe7vZiqjb
	 FWVrF88XHrTMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 10 Aug 2025 19:59:32 +0200
Message-Id: <DBYXZ0RQ58Z7.2UBHDTZ2LCT2B@kernel.org>
Subject: Re: [PATCH] mm/vmscan: fix inverted polarity in lru_gen_seq_show()
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Matthew Wilcox" <willy@infradead.org>
To: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <david@redhat.com>,
 <mhocko@kernel.org>, <zhengqi.arch@bytedance.com>,
 <shakeel.butt@linux.dev>, <lorenzo.stoakes@oracle.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250727105937.7480-1-dakr@kernel.org>
In-Reply-To: <20250727105937.7480-1-dakr@kernel.org>

On Sun Jul 27, 2025 at 12:59 PM CEST, Danilo Krummrich wrote:
> Commit a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> started using debugfs_get_aux_num() to distinguish between the RW
> "lru_gen" and the RO "lru_gen_full" file [1].
>
> Willy reported the inverted polarity [2] and Al fixed it up in [3].
>
> However, the patch in [1] was applied. Hence, fix this up accordingly.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [1]
> Link: https://lore.kernel.org/all/aGZu3Z730FQtqxsE@casper.infradead.org/ =
[2]
> Link: https://lore.kernel.org/all/20250704040720.GP1880847@ZenIV/ [3]
> Fixes: a7694ff11aa9 ("vmscan: don't bother with debugfs_real_fops()")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-linus, thanks!

