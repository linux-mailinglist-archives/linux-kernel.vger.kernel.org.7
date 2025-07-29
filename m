Return-Path: <linux-kernel+bounces-748843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBBB1469C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8437AEDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D1218AC1;
	Tue, 29 Jul 2025 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUoJmJPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9E286A9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758474; cv=none; b=lpUZ/u29jSbKAvwxonV0qwTYCeCUR/Bjt3rvB8JUTG6LJ8CcjnGhqq/jZ2ueb4aRwmuMWzXzv7+yGqdC53pMPI4NKns+9wuAS9OPSSTrxkM+61o5TMmpZ1qK1QiJCg9Ri1IW8pqmVsx0CXRpbWmUQQZnqvIermCoH+5Y5tfCIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758474; c=relaxed/simple;
	bh=xcALEbgUz/7qIDmcQiH+whC1AnTY3y4+NqQZh7ygwpU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRQVCWLplOqwAH4fMLmxYEd16tnVHY3KhQFI15fqZhUIkmK+J/xOCVtpStPr7bhkn6xCe6NjqY7bjZeqvR27/bFStrEVAnNN+qItfuQf+tH/MFhU72lwYONbVD5dhmFIUcmLJ79Z5S+Sj4cuivfHmML1BMXvmAwrBKeb/NIIuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUoJmJPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A7FC4CEE7;
	Tue, 29 Jul 2025 03:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753758473;
	bh=xcALEbgUz/7qIDmcQiH+whC1AnTY3y4+NqQZh7ygwpU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XUoJmJPCfxyfq6qh/SeuQbJ8fMqWcKlUwrZ8D+V1VaIGTI6W3z9T8EeX+GNtF7fUg
	 vuWyZ5S7ZPJ5zhRjt1If5zbmNj/97rONZsvdwX7PfYJ9LiTzboh1T1BEbJOz6TC6BX
	 9qdl0UMb53/0bDvgQBDBE3/oqrLILiTTr/LYfDELyGqTAOYA/DkVclMasV6kDznE84
	 q3LN9kKz6oMXUc+Eu7fQu1gweLAC/SvH41os2g3YFWN8/rKx6GM5jNPRoKiDKebzPm
	 EGZfZ8U38asGgQZjHLhXm0ryH1TSiJPqfYuEw8iHWFiffx84wjo+G0V9meIvzj+pIw
	 R68ILSH7pt6dA==
Message-ID: <10a7334c-29be-4f04-8e4f-746491959ef1@kernel.org>
Date: Tue, 29 Jul 2025 11:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add gc_boost_gc_greedy sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250728170430.1060976-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250728170430.1060976-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 01:04, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add this to control GC algorithm for boost GC.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

