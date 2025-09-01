Return-Path: <linux-kernel+bounces-793617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F4B3D625
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F9E3B7495
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BD86329;
	Mon,  1 Sep 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qaZJL/hL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B22EB11
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756687115; cv=none; b=Pg7cScMuWZra9v+JhthsXTeIIRRAjT5O3c0NPpdgX1khOOGrk22ql4U4sdS8SUPkH09ZMPV8tAUZj8XpcVGi5hdhbMAry32Q81zlMzGzjqEZq+9GaoSUiP4EQU5xObFfoqOlKvVOSrXXAnhwVKeTtFXlkOY9d9zQvPczETElB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756687115; c=relaxed/simple;
	bh=XRO+XjDyU4EVcFcZ+zqDm4gju2coIyBRANj36Mgvlf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixra5405EtR1dchA7hAyD/zEwKjL5veA1FiqNkGEx8dweDGplyl0u+TqBQYtnyAsjq+2+PVLe1EdxLOFgiDQrGtYyuqUiwZFRjZWFaTcGjZSJ0BNOpeq/4qYVM+ya63h/JjME7AEa/uUhoBHPkW2y3FzQ5ITlxlfgx0pP7TFhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qaZJL/hL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=54NWpDdgI0k7Pd6QCJD9fzpk2rKp8UKAoch5Z/bQ3A0=; b=qaZJL/hLYzhNP4XSwFN0LdlU8E
	5EPSboinnDKVo6dCDpb0Eh5pDSln8a8ghBb4AX30Z6HxGvpXY/drYwUe0zbg835P4RtmjS8axMRaK
	NZhoamFpSyNkrMVPLtejI6ttQ6jIZW7QElhZi5HBBLkgDrGw3PkryXSEg44xYzvAjlT81MMR7IFsF
	Tn7sdYhbgVLJwYKOtM/Mv2ZooX+KwF3BUEmmRzZS+e/F/jmi6+4gsV74z+C6rn73Y6ifAYBUARVjr
	hk8FmPBA8zWeG/t1c6XS9a9C2FlIwyVplDyJxuA81+mb/sAS95KKKrrPzgk3wqYGo2HAHJ3W+nxl5
	l/84cX1A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ussZ1-000000004KI-1TrI;
	Mon, 01 Sep 2025 00:38:27 +0000
Date: Mon, 1 Sep 2025 01:38:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, hughd@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Subject: Re: [PATCH v2 07/12] parisc/sys_parisc.c: add `const` to
 mmap_upper_limit() parameter
Message-ID: <aLTrAwhfHne_iuVS@casper.infradead.org>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-8-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831093918.2815332-8-max.kellermann@ionos.com>

On Sun, Aug 31, 2025 at 11:39:13AM +0200, Max Kellermann wrote:
> For improved const-correctness.  This piece is necessary to make the
> `rlim_stack` parameter to mmap_base() const.

Since you're going to respin this series anyway, your tags are a
disaster.  Tags are not filenames.  They're just to indicate to people
that they should pay attention because it touches their area of
interest.  So this one should just be labelled "parisc:", not
"parisc/sys_parisc.c:"

