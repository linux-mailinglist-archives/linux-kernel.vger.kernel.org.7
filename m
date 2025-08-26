Return-Path: <linux-kernel+bounces-786137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692DB3558D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E203AA878
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05CE2F83D2;
	Tue, 26 Aug 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JjmObyhP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922DF2F7478;
	Tue, 26 Aug 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192934; cv=none; b=G9OG2Xk2Jxa2QCkf9+KWb+UaNaXbU6ycvfOMtcL6xa1IwC5IqmoBDEsOeMi9pwJovqul20jCwHHwjoH+fAbjQKRVWAwsSYtDcJPjlFsWvyqU+DgV0v891RiwnSUyMoUnR6nspUAaxnK/+mHtqTBcwZCHn1nfJfZOmDad/b3K83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192934; c=relaxed/simple;
	bh=035sg1JtopQw1nmCxgJoz8BJyIihNeTPDW18p66Maew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9I2hhRjvX0mEjm0Gh0jNoeadgcLDv2ZN/opeQD5oFrberEfUnc8TxD9OGLzcYt9+gQ1Tm8tlMi8zGsR5vyKevX5hKOtZxW9Zv8vCo8eikxk58GmhFpiTOi0L2hx2D/aGYew4Orwn2PJyuDkFbL1Zp5TcK9Vfii6/MdY4svDUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JjmObyhP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0709740AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756192926; bh=veJtPEJ9bn56lBUtIQcGh3y1q+MNYjksl24KT7dK3Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JjmObyhP4Lb0+RL6pxoFBnUSA535OOZOcSswlP+P2+Rlxcur4RwDbbgMTKcp/LObl
	 h/T6FbF0rz0iMWlpqxFycxdJzlP2FCUU+Z82Skqjco6nM2mZCHX2E3yC/+V0nL4K+n
	 UDEV/oN1wql6lL5kXt3afkJ0+gQfl1Qp4/e4jvJ5e+1hPIj1jb7wjoLczbO+HwRzgg
	 iOeS6VkMOnbjT+/c6EtSuOBdtwaY4OYMdp5SNrkML1YMyrkgWBLeJgTvEOw3wvm18B
	 kldGgFK9IyTFep3dQES83dx0+nWDIVf/xDzl4niA34sgF6tTxkf8WRbYcv5l3ca0OV
	 6bA3r989KEGow==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0709740AE7;
	Tue, 26 Aug 2025 07:22:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, "Liam
 R . Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, Kees
 Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Rik van Riel
 <riel@surriel.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
Subject: Re: [PATCH V1 1/2] docs/mm: explain when and why rmap locks need to
 be taken during mremap()
In-Reply-To: <20250826065848.346066-1-harry.yoo@oracle.com>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
Date: Tue, 26 Aug 2025 01:22:03 -0600
Message-ID: <87v7mabl9g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harry Yoo <harry.yoo@oracle.com> writes:

> While move_ptes() has a comment explaining why rmap locks are needed,
> Documentation/mm/process_addrs.rst does not. Without being aware of that
> comment, I spent hours figuring out how things could go wrong and why,
> in some cases, rmap locks can be safely skipped.
>
> Add a more comprehensive explanation to the documentation to save time
> for others.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  Documentation/mm/process_addrs.rst | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> index be49e2a269e4..ee7c0dba339e 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -744,6 +744,38 @@ You can observe this in the :c:func:`!mremap` implementation in the functions
>  :c:func:`!take_rmap_locks` and :c:func:`!drop_rmap_locks` which perform the rmap
>  side of lock acquisition, invoked ultimately by :c:func:`!move_page_tables`.
>  
> +.. note:: If :c:func:`!mremap()` -> :c:func:`!move_ptes()` does not take rmap
> +          locks, :c:func:`!rmap_walk()` may miss a pte for the folio.
> +
> +          The problematic sequence is as follows:

Please don't use :c:func: - just write function() and all the right
things will happen.  (For extra credit, fix the existing usages :)

Thanks,

jon

