Return-Path: <linux-kernel+bounces-772162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5612B28F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02761AE2DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E62EA469;
	Sat, 16 Aug 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HMOGqysT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DC33086
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361433; cv=none; b=GPdF5IWjS7r+An3+XM9h6ahgEEddrKeubacLe2G5TLhc/A3IwIUMU+Ovq4CWCf4Y+C3kTSbolooSb1KRCxUyKGZImE/UPLjpyiVSzLfUaf+Owdu7bcb1RWNzFXptVALaK9m/TQh9gLiIjQ9mRXU0ZJWzWhmJEI5D4FDQ+lyo3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361433; c=relaxed/simple;
	bh=6a/D8SiGcnfWLy2DG5tXjfRQrHV6mtr3pBUI4gUmhnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU3VFnpuZn/4bQXnGMH7mxTRN/TK07iJ7bFTI558E2o42vKuOQfxwdn+RIHvQeZs5mQzIkYo83Sph2+GZuJAUMQ1UgEDJEyNpTXnhFun2H5HCI4p2QNxYSmoPbEmJthR21f51DK2Zaiayyta5dazcjPPGkZ8IETRkRPBEwoEQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HMOGqysT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+HWoCRfW0ZS3On5syAjsKZlW7if0MwQudqfkU82yqG0=; b=HMOGqysTT3F9ZUtoBjslEpxSXf
	2fnpQ0k82dLplCoE0BwdsVAy4ZlphT/D5Gc2+VmttgWr2TF7flKJVz7VU7F5Xcf8IURFcUzF8w+Zc
	e0wWfuHrOU16HN7/npGnZAJvEZj6876pZIgdYwET0gutT27dTQ/yt97hGM/iE3jV/bBChcf+vwKQY
	6zRwV8Sc5aYb5LYPr5n0JE1UQJ+O1u1JmuW1n59ptIqeyuLgkFeANS9EJPKmYUqiG3LaY1AY1M4aV
	usd2JntfNIbuqZWe1cqbtCvNCZ3LTeqAboQzHrRCwLzm/QGY4qAHdk/AaG1b29z6ZxLMddcqMMse5
	gim6anmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unJgy-0000000BceU-1n72;
	Sat, 16 Aug 2025 16:23:40 +0000
Date: Sat, 16 Aug 2025 17:23:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
Message-ID: <aKCwjCJTEhX4Q6wW@casper.infradead.org>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
 <a20d605c-79a0-4d89-985b-9512a990b492@redhat.com>
 <CAAhV-H470h2HDEN_NY2qNBxUqQrSRQhLzwqZe9PB8GjnNsZVFQ@mail.gmail.com>
 <66ebc632-6704-4637-b62d-1cb11e5a4782@redhat.com>
 <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db98f7f-b90f-464b-ae7f-e94ac523bc28@redhat.com>

On Sat, Aug 16, 2025 at 12:54:52PM +0200, David Hildenbrand wrote:
> +++ b/mm/balloon_compaction.c
> @@ -256,8 +256,10 @@ const struct movable_operations balloon_mops = {
>  static int __init balloon_init(void)
>  {
> -	movable_ops[MOVABLE_BALLOON] = &balloon_mops;
> -	return 0;
> +	int rc;
> +
> +	rc = register_movable_ops(&balloon_mops, PGTY_offline);
> +	return rc;

Using 'rc' as the name of this variable is an anti-pattern.  All it
tells you is "this is the return value".  Calling it 'err' is far
better because now we know it's an error number (or zero for success,
of course).

It seems to be a particularly IBM derived antipattern ;-)
Some internal style guide, perhaps?

> +void unregister_movable_ops(const struct movable_operations *ops, enum pagetype type)
> +{
> +	switch (type) {
> +	case PGTY_offline:
> +		WARN_ON_ONCE(offline_movable_ops != ops);
> +		offline_movable_ops = NULL;
> +		break;
> +	case PGTY_zsmalloc:
> +		WARN_ON_ONCE(zsmalloc_movable_ops != ops);
> +		zsmalloc_movable_ops = NULL;
> +		break;

This might be a bit excessive ... just passing the pagetype and not
having the sanity checks should be enough for the tiny number of users
this interface will have.


