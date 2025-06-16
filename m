Return-Path: <linux-kernel+bounces-689169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67434ADBD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640C33A3FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0C1A8F84;
	Mon, 16 Jun 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EycuO+aD"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFFE2264C5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750114178; cv=none; b=D8qZinaE1vFqK7SsuROnGa0MczSCXNhsR58uVw4oWHmZk4BJasH4jea55/Dmkyuhsy5rpsfnv2YT2uwuWkTlFI9TMjzn60t/n3h13U7iiSz/fDMR0M8gfZOwPIV6ggbdf5VOt8+CAaoab8lDSPL0qPrdtN4K3y5tbQ70X6BkG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750114178; c=relaxed/simple;
	bh=lTS3Pnfv0iaTosJp4gCmprmQ0aY4ReOYv0ZtcRgan6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHDoP2s8T1nHxhkncX5MLKO6JFBhcX1PmlC2RsKXNC+qmGvm8VUFaFGBu9E8HOz8yMj07PT9BZjGaLoWHsUIVH+/KWSbsWjL1HnWivM+f5naZ0tc2n7HtsTTpt/sK2YSJDpD5HmLP7l0ujRI7348t1rZUNG1YN1Ky/D4xtPqWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EycuO+aD; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 15:49:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750114174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VropUSnbvQmn64gm4FH0BxWayZecvxCPJ3ZBNn28ww4=;
	b=EycuO+aDiU7mwSWlapesN1rOHqKQ64cJMzbE31NDDBScZxzFn/kyYfYf+WCYZeV/rEzr3+
	qAJt2rKsv/psBgNml/N0XoIFIP6QfkGDUb/JgUOB0zFa2UeiX3eOQqjN1rkp4qvYV8uEaQ
	wL5nXhYeGUE7LlyGQj5yGA9OnBcq+PA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add missing mm/workingset.c file to mm
 reclaim section
Message-ID: <ikxvv3z3phykk2hu3n3lyqzayjppg2uxmbsoon2g64wghp2cfv@swxgqgkqetso>
References: <20250616201643.561626-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616201643.561626-1-lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 16, 2025 at 09:16:43PM +0100, Lorenzo Stoakes wrote:
> The working set logic belongs very much to the reclaim section and is
> otherwise not assigned to any other MAINTAINERS section so add it here.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

