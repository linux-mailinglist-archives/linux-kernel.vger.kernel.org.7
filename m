Return-Path: <linux-kernel+bounces-866257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F99BFF4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A574EA7B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163C27A465;
	Thu, 23 Oct 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="yLIcTdH6"
Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B7279324
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200082; cv=none; b=a8YA4lqwfopK3TSdFgyJqeHVyGXn4OX7M0UtgzOPvSY/nS/CIk0D7WP2qnkVnzb/Fk0voUOb06rxol36i52LJ9HuyEH1Pt1AUuJLOQcCL64W9H1TTSNwIk96AwBshZLOX8HxQ+Jrrvnw1IzOTagzeq8Bl0s/8jtpqUprvO0O1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200082; c=relaxed/simple;
	bh=ZL5TWyyHbxmT4xy0Sv8uektcWHxntirjX+FvT7x5qeM=;
	h=Message-Id:In-Reply-To:From:Subject:Date:To:Cc:References:
	 Mime-Version:Content-Type:Content-Disposition; b=Dbvz8X0uIUDPctucAkS0Nhs80rSWAqn6T5rj+0nFeD3Ek31cwujHaOtQux090M7balFuxYMpC2WDP8Rpil1quWZBhWenXJsRzVVIm0qds3FfFwrm0NyNLvgNkFSib5RkEQDWNoh7KUW07vZ7gxX0zovZ7YAS7UUOdBAEROKuvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=yLIcTdH6; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1761200066;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=I0DeQvV/YRBGnIAotey1VEst0KMw5VbVrMVkBCLAcS0=;
 b=yLIcTdH6+z79XscLsh99AbyejGWdjkoO75Mq/1190Z6owoTGlApT5mA0oMqCmNGNUecdVj
 oY9P/lIQLO53BhC/BU++aEkXXfd1f8HnOmaCdr+zOa37aL+YAEaAEeOOrH+KrMjFg5ttwS
 FRAoyebEIMAnmT+1wNZl9R9fpoHnxmXF4RCHVDneHqxk2hbDGR5t0UhJ1wHwVHJkVsTXwH
 1EpoYDvsWL7I7fwmg5BlceLHQKQSelZx56+dZb+KZPIBPgs52umsZEaIl7rl7KzrKJf5KH
 QEPW1VlyTjP9UPqF3/U8zUk4EO4rXZmiGcS1WFvvVcpkdntmPie3NNTG2dJuWg==
Message-Id: <vwzui4ahytskgcffiei2grbypf5jgebwku5qevdyxja463t4fv@w6kycwc47qwf>
X-Original-From: Coly Li <colyli@fnnas.com>
In-Reply-To: <20251023060629.801792-1-tanze@kylinos.cn>
Received: from studio.lan ([120.245.65.31]) by smtp.feishu.cn with ESMTPS; Thu, 23 Oct 2025 14:14:23 +0800
From: "Coly Li" <colyli@fnnas.com>
Subject: Re: [PATCH v3] bcache: Use vmalloc_array() to improve code
Date: Thu, 23 Oct 2025 14:14:22 +0800
To: "tanze" <tanze@kylinos.cn>
Cc: <john.g.garry@oracle.com>, <kent.overstreet@linux.dev>, 
	<linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Lms-Return-Path: <lba+268f9c7c0+bcc63c+vger.kernel.org+colyli@fnnas.com>
References: <20251023060629.801792-1-tanze@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, Oct 23, 2025 at 02:06:29PM +0800, tanze wrote:
> Remove array_size() calls and replace vmalloc(),
> due to vmalloc_array() being optimized better,
> using fewer instructions, and handling overflow more concisely.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> 
> ---
> Hi, Coly Li.
> 
> Thank you for your prompt reply. 
> I have resubmitted the v3 version of the patch, 
> with revisions made as per your requirements.
> 
> Best regards,
> Ze Tan
> ---
> Changes in v3:
> - The empty line has been deleted.
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
> 

It looks good to me. I take it into my for-next. Thanks.

Coly Li

