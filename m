Return-Path: <linux-kernel+bounces-801839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF9B44A93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C4954717F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112C2EBDC4;
	Thu,  4 Sep 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lr5mwcDc"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C721A76BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030012; cv=none; b=tSN3Z803UeipJ/BGfHXvdknIphCR1UPFXI0e/cMTCm/sYLk98B9ASsbSNn2VsleeCmSywfHzg2E4zeY/WFV1Q7J1Ao9lrgangUenYq3KHQSIenyMPqLXVw9tGDX7oeiJGH5V+qN9cxzrSOo6UY0Lvt/SxZFDp8sx9m+dpaOXkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030012; c=relaxed/simple;
	bh=ARjshwFHraYNzT52NQIi496JSATEGl22eDhyWbgT7iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyDMON+4mtVErlnCkkep9q1h3xCz9EUaV6Km5/UP60pflalLqdcAz9H7yRraFcPnlLTL4VVFA6eNJw8eDR6Pi8AaOZBmEF8W/QQsbOHDrVrkzkbkY8CyB3gMQhWKiJ3qqiNfOJGuNX0DllaCxxdEFycQY1m7wdiUrFzwe4aLVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lr5mwcDc; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757029991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2RtdVXkTODsXddtzD5LID5X8DGXKOHDe70pXEgZ9X8=;
	b=lr5mwcDcyNFZleBt/+LopcJ4pLfJXlGwW5bnE8uS1XZKSmmuBC4G07KILcJn20ZL7g4cOP
	ZR4Exm0UGHKG0GsaUOHJRMlkkd3X1e1sCQCp0u2MJAo8lvFUlBJVRtQSuwh0EH8zBIGM3E
	nzKPyB1gUIHwtEwilh7Cq5YJPr34iAY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling  before printing
Message-ID: <6bbrnimtosca457kn3hatu2tqvhx6mfrswgxwes6jo2w54cuxa@kq3nem4jtlis>
References: <cover.1756897825.git.pyyjason@gmail.com>
 <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 03, 2025 at 04:16:13AM -0700, Yueyang Pan wrote:
> This patch prints the status of the memory allocation profiling
> before __show_mem actually prints the detailed allocation info.
> This way will let us know the `0B` we saw in allocation info is
> because the profiling is disabled or the allocation is actually
> 0B.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

