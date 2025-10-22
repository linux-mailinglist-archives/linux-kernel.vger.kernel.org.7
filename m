Return-Path: <linux-kernel+bounces-864884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12DBFBC49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B86435496E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6130506E;
	Wed, 22 Oct 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="f9z5XYmo"
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81132D42B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134641; cv=none; b=VUcCTNVZa8QfsX/XXkPJc37UMLDsRBN5Yww4KznXewc4HHVWYw7Fy8II93sNlZppL8XCLdjZnHj7BVuyokpBDqmsVj4CcrJzSnxNtDmI8UwRUfjMy1DiMWHAoCavNx0g+j/QMDYdee07YPGqxExGbNDzBiMbx141E7SopE+tXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134641; c=relaxed/simple;
	bh=i6dcns4rfVr5VbGGPnenj2tbF84Z/fVXCBxxl9IrQ1g=;
	h=Subject:Message-Id:In-Reply-To:From:To:Cc:Date:Mime-Version:
	 Content-Type:Content-Disposition:References; b=XzTmopHUTpTGiPLhUDHxt+g49HQ8J6a5cOjIOvrQ1CEY5wS/ZoapngKkRww6AOo3U1bTvaGeJtSbpDp44js9hGOfwSigU9j0D8HJ37Nzu6E8bn1BIhkKO7uE5JDfEJO7yIfSy1/IKh4uQpy4XnnTVEvPwKQTM5dH7LjMWKQtyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=f9z5XYmo; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761134626;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uWVXxPUe4aOEyytuKBvG8xN7BzM5nAQ8VOqRB60qzJc=;
 b=f9z5XYmonRP+AKZyiCcnnchsDw4yG9XtadOCKbUw4OQMPwNk+01dp/yNC8lL7kUUABbHpA
 Dr9MitEs+0mcPscidocboI5b6Q46arScRge1n9Klahu6H7zmN7ZD9C8pPTsPLT2QL4jV0X
 u4Nv/AYCrsyntVaTN7nMNLQ0nyLsztGh8StSObppyRtBQvGs3ZvKxNDctk/oWqImM56Fw/
 RCGcVIg0K9IwekBpNC2yq+06DTArc7BFQ5z+fYMxUEplUZ2YstCJV0GbQeFN+kNG6L5kI2
 izGrBt21HgJxyT31DfUMAETb/dsCBn451qGbhVAMtmBN8Ap0y72dNVmr0sKGOA==
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] bcache: Use vmalloc_array() to improve code
Message-Id: <bb26wdvihppk6wjpy3ysijfxaj6kofw7zbich4b72bwwnl7fec@cpkvrdhpkj3e>
X-Lms-Return-Path: <lba+268f8c820+af4560+vger.kernel.org+colyli@fnnas.com>
In-Reply-To: <20251017111306.239064-1-tanze@kylinos.cn>
From: "Coly Li" <colyli@fnnas.com>
Received: from studio.lan ([120.245.65.31]) by smtp.feishu.cn with ESMTPS; Wed, 22 Oct 2025 20:03:43 +0800
X-Original-From: Coly Li <colyli@fnnas.com>
To: "tanze" <tanze@kylinos.cn>
Cc: <kent.overstreet@linux.dev>, <john.g.garry@oracle.com>, 
	<linux-kernel@vger.kernel.org>, <linux-bcache@vger.kernel.org>
Date: Wed, 22 Oct 2025 20:03:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
References: <20251017111306.239064-1-tanze@kylinos.cn>

On Fri, Oct 17, 2025 at 07:13:06PM +0800, tanze wrote:
> Remove array_size() calls and replace vmalloc(), Due to vmalloc_array() is optimized better,
> uses fewer instructions, and handles overflow more concisely[1].
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
>  drivers/md/bcache/sysfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 826b14cae4e5..dc568e8eb6eb 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -1061,8 +1061,7 @@ SHOW(__bch_cache)
>  		uint16_t q[31], *p, *cached;
>  		ssize_t ret;
>  
> -		cached = p = vmalloc(array_size(sizeof(uint16_t),
> -						ca->sb.nbuckets));
> +		cached = p = vmalloc_array(ca->sb.nbuckets,sizeof(uint16_t));
                                                          ^^^-> a blank missing?
>  		if (!p)
>  			return -ENOMEM;

Except for the missing blank, overall the patch is fine.

BTW, IMHO tanze is not a formal method to spell the name, could you please
use a formal format? It will be helpful to identify your contribution in
future.


Thanks.

Coly Li

