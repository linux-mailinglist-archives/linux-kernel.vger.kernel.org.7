Return-Path: <linux-kernel+bounces-734338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E02B0805C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EC8188CEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED502620DE;
	Wed, 16 Jul 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XvmUlgCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E5249EB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704145; cv=none; b=YJHMRMiBln62Wk7KhxXXxTzLsBUURAKh7DURGgE9TIDXyUcMMhqntz5Q3lCrrUua4mI5kC6WGnZ+1WUT2SLbYudFSZS55s7gX855pnmTQKihGq3l7qGpZidlElbVI+ahG4oXZoCqspk8pQVZ4+XEZRjxQUJJjEgbXbdYkRyezOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704145; c=relaxed/simple;
	bh=Z+deqNO2fe6wZ794K6K4A3kX9whxvVPUtNuFEqUlAb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CAAD6F4yHAouF9nrzACbVT1yPvuaTKzzffT3Ln1x0hoC4uBFi1kICZbB0jUc8Lm/61ScPevXCXLE3FkhJSQbKKHWsCObGNSBB41+LKgNax8D+G713aGP4MBCNOMH+luKw80QI8IN05czOUWLHxyHp89GdEXPNxYQ9gcEh5vhki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XvmUlgCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B6C4CEEB;
	Wed, 16 Jul 2025 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752704145;
	bh=Z+deqNO2fe6wZ794K6K4A3kX9whxvVPUtNuFEqUlAb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XvmUlgCeoCPflDec486GmACayjS9XAXdVi4jQ5IGEwCB7UpM1DdwzIDwrOBUViHzI
	 97NKK4HSiiPZrhyqy8P7jPQKyxOkz6xrPrftOcT313kroGAY3uZSo538yAqnpKPCOq
	 yVvmyiWKONxCUbWAhcPwg8zCIzeb9dW9eYwjp2vs=
Date: Wed, 16 Jul 2025 15:15:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wang lian <lianux.mm@gmail.com>
Cc: broonie@kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 sj@kernel.org, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, jannh@google.com,
 Liam.Howlett@oracle.com, shuah@kernel.org, vbabka@suse.cz,
 ludovico.zy.wu@gmail.com, gkwang@linx-info.com, p1ucky0923@gmail.com,
 ryncsn@gmail.com, zijing.zhang@proton.me
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace
 "asm volatile("" : "+r" (XXX));"
Message-Id: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
In-Reply-To: <20250716123126.3851-1-lianux.mm@gmail.com>
References: <20250716123126.3851-1-lianux.mm@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:

> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> construct to force a read of a variable, preventing the compiler from
> optimizing away the memory access. This idiom is cryptic and duplicated
> across multiple test files.
> 
> Following a suggestion from David[1], this patch refactors this
> common pattern into a FORCE_READ() macro
> 
>  tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
>  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
>  tools/testing/selftests/mm/migration.c        | 13 ++++----
>  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
>  .../selftests/mm/split_huge_page_test.c       |  4 +--
>  5 files changed, 24 insertions(+), 32 deletions(-)

The patch forgot to move the FORCE_READ definition into a header?


