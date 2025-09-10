Return-Path: <linux-kernel+bounces-809403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08BDB50D48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99F64474F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DBB247299;
	Wed, 10 Sep 2025 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vn9+cnkp"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8211C84AE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482312; cv=none; b=Yvf/CtS/zCu4vM3FajSN1QGw/aj6jUAAPsDvg20PKDLUfF1D2eJlPqABhVJYso0tqFNEsHh9voXXUw5dpezXO0V14MsCGX1Fa5FTI8Dkja+tmlIXNQbCeZr5YRXf9CkwmMJINiKju+cVd/VOH49CeAC/w8m/wLyJVFLbH08H1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482312; c=relaxed/simple;
	bh=8xAaWP0GM3YKChbOyELuOIR+EVnOYBIeP6iwbJ3kpyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8owcVg5QBnQYBDJurnn+RpWr1mgR47Q0WkqtxWDjAQKGRJL5TSod6uQG4jF6P9yuJgLObYhT3Px1KfHkQmZ7VZqg0mjZUN0TC6if3OyWQbnBY+UGsilazKCQkV80NWnH4CeAZL88CMf4P1sUB7Z2vXDhiuD6f+SEkXNtuzUMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vn9+cnkp; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 22:31:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757482307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqRaYitKdT9DARnP1lto9syW0RNlfsvHQXasmHs9Yus=;
	b=vn9+cnkpi1SaJG1Ii5WaFFsQIFKaGfugmVAxpGa3C8DD4EuNK8K+TUpI3cBDhuZI+kmBVG
	hyixA+eQY+LIFIxHbB/5RbKMOtBQr5SNjhKNyksoUmFpLwV248x8966FxWhCCTnUJ7Y1NX
	yKYbGCs7MFeuaildI0pCTTG7zHhBr48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] alloc_tag: use release_pages() in the cleanup path
Message-ID: <qr6flxcm5t3ctb2plabwgfyf5izcqoshl2dzhm6usp2uo5jtbm@u4zv5q7mjio4>
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909233409.1013367-2-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:34:07PM -0700, Suren Baghdasaryan wrote:
> When bulk-freeing an array of pages use release_pages() instead of freeing
> them page-by-page:
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

