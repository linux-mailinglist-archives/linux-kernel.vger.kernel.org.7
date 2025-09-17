Return-Path: <linux-kernel+bounces-821692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057DB81F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766357B037F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B9309EF1;
	Wed, 17 Sep 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yLg4GU7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D595302159;
	Wed, 17 Sep 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144541; cv=none; b=iQkbP/zO0AIu/FyP8vZ+WLWTzGnPKpfAthvgiqLQ+3ikgQneLmgKYB16RT2z4eC+uGcdRNfkkkOieD60VTrtBPQ24wUUzJUYGEhPB9YGKQhrR4R++5A7+o7kpQkEk5pxlrjdZsuGlogwImPX8A+X9PV5IgtT9lVa8nGafnMwoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144541; c=relaxed/simple;
	bh=EobuVCZcornWTzPk32AobToyuSJ570AVb66uPA37Js8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TTgaN5SXuBgl9Z18Uj8UQ8LQzWpsm3ZwghEH4h44aVki6ecw8cWrtLTkm6lQrbf0+Zge+YRbBeHWEVam2BvgbIHnMj/t16ny11dofRbMgsJvQKlxr4tIKo4EbqtwcuCRqjV0b7op7AKhr+2Uj1j2L78ieyMs3E+EpZefR3BFhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yLg4GU7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCCBC4CEE7;
	Wed, 17 Sep 2025 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758144541;
	bh=EobuVCZcornWTzPk32AobToyuSJ570AVb66uPA37Js8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yLg4GU7F7QyOOAObovX6UP+sC3Bq/L2Hbo91QRW6t0ygkshD9EF53mfq9VFVXOWXF
	 4iOJJA3mdi1lMYid/Eofx4moGwOTnqub3vHqNxHLAd/BEhwbgyuHkF2++6tK6oEVE0
	 DE3H4Td7LpCtfz0hUght3wWSsVBorI2LdglCbR20=
Date: Wed, 17 Sep 2025 14:29:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 wangkefeng.wang@huawei.com, zuoze1@huawei.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v3 11/11] mm/damon: add damon_ctx->min_sz_region
Message-Id: <20250917142900.e2915812cd94d9a2b0da3987@linux-foundation.org>
In-Reply-To: <20250917160041.53187-1-sj@kernel.org>
References: <20250828171242.59810-12-sj@kernel.org>
	<20250917160041.53187-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 09:00:41 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 28 Aug 2025 10:12:42 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > From: Quanmin Yan <yanquanmin1@huawei.com>
> > 
> > Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> > bytes and cause data alignment issues[1].
> > 
> > Add damon_ctx->min_sz_region to change DAMON_MIN_REGION from a global
> > macro value to per-context variable.
> > 
> > [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
> 
> I think I found an issue of this patch.  Please refer to the attaching patch
> for details.
> 
> This patch is in the mm tree and not yet merged into the mainline.  Andrew,
> could you please add the attached patch as a fixup of this one?

The flawed patch is actually in mm.git's mm-stable branch, which is
supposedly non-rebasing.  So I queued this patch as separate commit, with

Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")


