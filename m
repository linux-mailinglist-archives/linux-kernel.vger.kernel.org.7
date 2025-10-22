Return-Path: <linux-kernel+bounces-864887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584FBFBC67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640BE3BC1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB2341644;
	Wed, 22 Oct 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="KZ9Mx9H4"
Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95890336EF3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134782; cv=none; b=Su+qy3bKkPg6zvRuhWgHcC20Rn/gMu9uyOxDgb0BEqixRihm6fmaeOFIryjoAxlZYUBmI0dwlsWVVkyOXH2V8uORuj3Isf4Sah9fQxDjjjty8lGcSoy3yBf8DSVVXeP4ernWEJ8jcxsdVgxQchaVTIBgAucr5pOS/XWZcGbzlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134782; c=relaxed/simple;
	bh=ryMcoNjzkllLGMyMhIVFVtghlzDN8OpjUOnHkZWXEE0=;
	h=Cc:Subject:Date:To:Message-Id:References:Content-Type:
	 Content-Disposition:From:In-Reply-To:Mime-Version; b=GjkO2VyVtQu/kG6e0YDt4X1p2dXjhEiiNrDQfL34LX7YMHkU2VYXqL4H+kMJ10OXSNdjO7kcSEMCNUWmOsrz6WFwaDcheugd0kZe4V+KBzcXEhxijUm+VP+C8JibovHACe6DwIAdIqBUfWX7tPuE/XMOCIIi1B3nZEMbbc09tC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=KZ9Mx9H4; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761134770;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/o0aO0yqKTuoFU4YqefdnlXdzHilQhO1Wy7kIh7Yipc=;
 b=KZ9Mx9H4Q/3LgJ9YL5qyrFH+eAScGFXXBQVtr81yK/NOOeVK7vYc7A5z5kwbQxGIYxIull
 98exi26HiUTfJhM7fen5WA5MT5Kw219Dg4hcioANbo3MF7nOppvNDpopu6l4nfhAgj2+f4
 fx7wtryi6dpqT1mHic0ATuQG3nETED3dTMqAhrzoAsz1Qogr1uPccReCHWlOA42eJh3+5j
 eVE9qEwZfVptoLX1W+PZ7QzLDEiQDcGn4oqxQTsQ4y0vQDZxfYrrrOXcJdtiIyOZrfnCYT
 vVYcJNMTUpz1+/wg+AkK0u3ebYKSvn77sCk6GvhoIwD4c+PInMfsrDUDYZdjIg==
Cc: <kent.overstreet@linux.dev>, <john.g.garry@oracle.com>, 
	<linux-kernel@vger.kernel.org>, <linux-bcache@vger.kernel.org>
Subject: Re: [PATCH v1] bcache: Use vmalloc_array() to improve code
Date: Wed, 22 Oct 2025 20:06:06 +0800
Received: from studio.lan ([120.245.65.31]) by smtp.feishu.cn with ESMTPS; Wed, 22 Oct 2025 20:06:07 +0800
Content-Transfer-Encoding: 7bit
To: "tanze" <tanze@kylinos.cn>
Message-Id: <lw5v5sdv2qdgi2kyrbohw6avp4ieyor4glijtwyovvl2lk2t7v@aithwxnmumbl>
References: <20251017111306.239064-1-tanze@kylinos.cn> <20251017112739.244021-1-tanze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Coly Li <colyli@fnnas.com>
Content-Disposition: inline
From: "Coly Li" <colyli@fnnas.com>
In-Reply-To: <20251017112739.244021-1-tanze@kylinos.cn>
X-Lms-Return-Path: <lba+268f8c8b0+a662a9+vger.kernel.org+colyli@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On Fri, Oct 17, 2025 at 07:27:39PM +0800, tanze wrote:
> Remove array_size() calls and replace vmalloc(), Due to vmalloc_array() is optimized better,
> uses fewer instructions, and handles overflow more concisely[1].
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
> Please ignore the previous email, a simple formatting error 
> has been corrected in this one.
> 
> Thanks
> ---
>  drivers/md/bcache/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 826b14cae4e5..7bb5605ad7fb 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -1061,8 +1061,7 @@ SHOW(__bch_cache)
>  		uint16_t q[31], *p, *cached;
>  		ssize_t ret;
>  
> -		cached = p = vmalloc(array_size(sizeof(uint16_t),
> -						ca->sb.nbuckets));
> +		cached = p = vmalloc_array(ca->sb.nbuckets, sizeof(uint16_t));
>  		if (!p)
>  			return -ENOMEM;

Yes, this version is better.
It will be cool if you may refine the name format in your Signed-off-by.

Thanks.

Coly Li

