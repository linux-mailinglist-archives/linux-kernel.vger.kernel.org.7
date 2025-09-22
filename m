Return-Path: <linux-kernel+bounces-827965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787BB938A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C5F1902B22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D130171C;
	Mon, 22 Sep 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D/360iHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA128B415
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582518; cv=none; b=R5ueVK2HrjJhPgE5bdvnzTv/tjBS6vsO7j9fHY0k9uJzgzcnNRN/XpYFhRx31B0WnLVCcicj1yj7mea6KCnq4IxTOgRwiT7gy0ssf2ynM6V/od+BSR5AX3Zs7RFokbmR0pWoeIRu/creYgeyXoJgTv1h0uD0XF5N0fZ3kYbM29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582518; c=relaxed/simple;
	bh=QmCUwDfXfg4W2Dr+QVycDtLbh1Xl7d+GJAEjUK5WNlY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RmF3inoC47PxOSuEAIAx9CihowmBMrV9CVUvsMnJltjS7nF/JlB7MeGtv1b8n12raA7XlHCGbXl1JmzTF+htJeoRwdyUiPobBU/c+hhIjiW8Dg3ljMb0uiv/1L5fXSHYpA2+zM/EtFu7qkwMh8E4Go0/ZPNbzEnfKBMn4Hxewig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D/360iHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E45C4CEF0;
	Mon, 22 Sep 2025 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758582518;
	bh=QmCUwDfXfg4W2Dr+QVycDtLbh1Xl7d+GJAEjUK5WNlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/360iHNLVYROtKeN/fgEBdD6WzJbXBsP73BrcZHpBpzMiIiaUC0Hk6OtLYrHKxkR
	 g0KelA+qBAZXcUXf20lJgWNGk3lxjQzWxbfHU4DooTmBJABrOB53zHebZwUdQgP6mJ
	 Z7XS8B7HCEcpCgWbA971c0C/FER1G6pMwW4fHT9I=
Date: Mon, 22 Sep 2025 16:08:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, Chris
 Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250922160836.8d0dc984ff0986b3809c9ab0@linux-foundation.org>
In-Reply-To: <8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<8f893019-bd87-4f54-8238-acd8fdeed051@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 15:31:42 -0700 "yanjun.zhu" <yanjun.zhu@linux.dev> wrote:

> > +int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> > +{
> > +	struct kho_vmalloc_chunk *chunk;
> > +	struct vm_struct *vm = find_vm_area(ptr);
> > +	unsigned int order, flags, nr_contig_pages;
> > +	unsigned int idx = 0;
> > +	int err;
> 
> This is a trivial issue. I’m not sure whether RCT (Reverse Christmas 
> Trees) is used in the Linux MM mailing list.

Not as far as I know.  Some like it.

If I was to have a preference I'd suggest that things be laid out in a
logical order rather than by column count.  Group like things together,
avoid use of unintialized storage in initializers(!).


