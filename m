Return-Path: <linux-kernel+bounces-833620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E2BA274A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775E11C0474C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296F277C98;
	Fri, 26 Sep 2025 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPBMwcqE"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8C91FCFEF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865103; cv=none; b=gVXl+oSGgYB2/6kjG10O5LVtmJC3vVvAX7z+Qvz1Ygrke7enkE+4Uv3UBc+sXoN1qyJwaHt4xtjO7QDqkDmWo08ImXbKeTKGQKSkWHUFKkuhzUwgmS9JADeFO/U/BWFmP8M1aYVzl1++NKEycO0X2FBDyH7mRhymNMTwpYzWo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865103; c=relaxed/simple;
	bh=KkD9rL7YGHlVwvQ0Osh0V5e+ZCSLwP1ZFtxpHOBoGdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHtgPvB4chu5jyqpsVP7Wi0ETOzn7fkHwNvoCLef+O4PG4wAzDk1YCZxWrcjohwfHT17HZFRsleSLCujGsQ4M8DAyFsJ8bOKeSRPqgM5gkH++jM/ZN3y0Ege3tX7Hm5t60Dr54SHZnj1rHophSSlHjEI+tyFQOySoLmFYuwO0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPBMwcqE; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae2db4c3-3769-4945-97bc-2407a260886b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758865095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkD9rL7YGHlVwvQ0Osh0V5e+ZCSLwP1ZFtxpHOBoGdE=;
	b=rPBMwcqE0ZoiuFdUzLDekJ6XZGa1QzTbhtw7WQI+f6DsBkq5Jxsbk2kF+pxjbMN6RcXAES
	xksuCplfb+zpTtmaG4g2rGQRuwPrgG0HO1jbNZG2kXqTQBA7VwIw0ZALQhwgbqvv0UkE1s
	qoh/Dp9VdcT9Y/SLmLftiUvDs4PoBTQ=
Date: Fri, 26 Sep 2025 13:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] gfs2: Move i_nlink checks from gfs2_{link,rename,mkdir}
 to VFS layer
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926025604.500713-1-youling.tang@linux.dev>
 <20250926044854.GD39973@ZenIV>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20250926044854.GD39973@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/26/25 12:48, Al Viro wrote:

> On Fri, Sep 26, 2025 at 10:56:04AM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> vfs_{link, rename, mkdir} will check i_nlink. When sb->s_max_links is set,
>> set sb->s_max_links in gfs2 to simplify the code.
> For gfs2 you are going to run into a problem - link count is not stable until
> you take gfs2 locks; checks in vfs_link() et.al. will be inevitably racy for
> cluster filesystems.

Thank you for pointing out this important issue. Let's discard this patch.

Thanks,
Youling.

