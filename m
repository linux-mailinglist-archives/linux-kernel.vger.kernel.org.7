Return-Path: <linux-kernel+bounces-645972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B959BAB561A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2059417BE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24528E5E7;
	Tue, 13 May 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xGDTNX0z"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B8128CF42
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143134; cv=none; b=adOrboqgseEXIizK3+FB3eWV86hrEwllwNv2adV+dqMfG51KQtFwDoau7Weff69g0xug/0poCczEhGF/rKEtQyn0tLUrW/IY5SwwiHRSpyGJWxbZSUxq7RgnaoLNzw/w0U37YOXGduYQuixXEWuoEshxBfCKXmp5bJUHihfkKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143134; c=relaxed/simple;
	bh=z2haIjDqNrb4s1Ft9q/VKPrJ20SNCg8ofCGnU1k9Lx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M52uAYRzEYqnCz2Xa9jN+p8+p5UeVCXNGQsKJiezk/+rRCLdOuG9YLf2HImlllKjiX7il5GIzhyuq/teIG0Me8Bop/cPSxYyzPEqrwyUTC1wWOdzOvF6gCWnHw5qeIiH/gZzRtvEJBff6RvuJHSpI0yKjvOUIwTcWrIRAYbdaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xGDTNX0z; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58e21463-6db8-4e26-b212-590453b1ddbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747143120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNQdCCb9ecdF4xZ/wYPQwhqLJYrt76SqeLQABihcuco=;
	b=xGDTNX0zEv/pkFboH2sxbJy9Q80jSSlkWjLPbV/qzlBrA8dX+b+bIMWIRN08ks0Xmi4Qxd
	b59Tctqr7VnnFottq9Hyi975AZGVaTx0z1q4A7Gzedd2rxBf7mZED6WVOeLBZ+TnD9B3CK
	Axb+0J1sBs6KOJLkjPu4kfBV2oJgLOc=
Date: Tue, 13 May 2025 16:31:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] driver/infiniband/efa: Fix possible null pointer
 dereference in `efa_alloc_pd()`
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Michael Margolin <mrgolin@amazon.com>, Yossi Leybovich
 <sleybo@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 Steve Wise <larrystevenwise@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250513132252.980614-1-fourier.thomas@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20250513132252.980614-1-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/05/2025 16:22, Thomas Fourier wrote:
> `efa_alloc_pd()` assumes that `udata` is not null but it seems like
> `__ib_alloc_pd()` in drivers/infiniband/core/verbs.c:279 can call it
> through the `ib_device` interface.  This checks if `udata` is null
> before dereferencing it.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

udata will never be NULL since EFA does not support kverbs, and
userspace will always pass udata.

Look at ib_device_check_mandatory().

