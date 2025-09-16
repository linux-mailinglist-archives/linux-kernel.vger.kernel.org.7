Return-Path: <linux-kernel+bounces-819042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE0B59A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA23467822
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19732ED36;
	Tue, 16 Sep 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN1ct+08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07808327A1C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033448; cv=none; b=MAHDV9ikAtleXwgW/ZuZ5E6ovl+JjUomqzY6brtRJoP58OG7ycCH23Vqz7UYtCCrG0iE3dEMKDGdNkNvfFfJalZIgpd5ofVjb7VlYm8PdfUL8+vwow1LIunvHW/puzPgjmMyI/h98hNVF6OP3U2+T5JltETnzlofCu5+CMxefYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033448; c=relaxed/simple;
	bh=LgO5/yIM681jTrDMpq8xGFhrw1pnS2TvOssqGdcDUCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLIsliaWS8pRYAy20k1eYmr1q0biouMfwtYMekeOKWdz8LgZZ9QfyQbbKHqrkqGWVjBPwqnPbEpc0loXnQjsIU6QEUlTuOqzF90s9IFZYWA/lX9mUY5mgKwuj0IxwKqda9NddtYUURVg1/dzLkg6j/Lf+SnJ5M0JjNxFlbDZPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN1ct+08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74623C4CEEB;
	Tue, 16 Sep 2025 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033447;
	bh=LgO5/yIM681jTrDMpq8xGFhrw1pnS2TvOssqGdcDUCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN1ct+08J2HGLhNlNLuFWoe5C1alwpgQhtMeSmLSwH9dlwRSe6s3/oXgwOLOzbBlQ
	 PXzXEd86PJ9ccKF0e8Qpla8hYUK4grbeGFjGSOb9K8AXPMkJLiDDIvnraAWyyYlZaA
	 3yMAqc6xK3vhvitPcAQ247EwtzG/RPw8JG3N7cbBJm57zZ3CBZ9lOulbeA1Px/h2s+
	 RXuYmEWymSRiUoLadgIGLtH40Jj6EH/zUUkJIw1tqvgnPAghpo+5BW2ZySzqHEAKRL
	 B+bEFypAX1aQFvcNUbgVJC88obupLOi9uZCERwx4xTeog6t+8o7/+21q5bc5zMdfTK
	 LwJLKBnL+qljg==
Date: Tue, 16 Sep 2025 17:37:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <aMl2H3BLpH3xFCOw@kernel.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153443.95049-1-pratyush@kernel.org>

On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
> When restoring a folio using kho_restore_folio(), no sanity checks are
> done to make sure the folio actually came from a kexec handover. The
> caller is trusted to pass in the right address. If the caller has a bug
> and passes in a wrong address, an in-use folio might be "restored" and
> returned, causing all sorts of memory corruption.
> 
> Harden the folio restore logic by stashing in a magic number in
> page->private along with the folio order. If the magic number does not
> match, the folio won't be touched. page->private is an unsigned long.
> The union kho_page_info splits it into two parts, with one holding the
> order and the other holding the magic number.

I think the sanity checks belongs to the core kho_restore_page() function
and kho_restore_folio() should be a thin wrapper for that, at least until
we'd need to allocate struct folio there.
 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  kernel/kexec_handover.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

-- 
Sincerely yours,
Mike.

