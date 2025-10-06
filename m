Return-Path: <linux-kernel+bounces-843408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2211BBF1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAC4F18FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5622D7DFF;
	Mon,  6 Oct 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2iW0tgg"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F01D90AD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780011; cv=none; b=lCkJDrFsugZGCt2IP85M6D9SrGrMxHx/vh7Ce+UvZ7qK/A7tHUC8/OHm7m0UeLLzYZ2BqkhR3AF8EJp4p9sBoqIyLAh+lklt8y9KmLsBoy1erit+akJ9qBKVAbA9y6nbGEwPQF5a4SLA6I2xtWYenoWSehZDyOZpCzwK40Gi4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780011; c=relaxed/simple;
	bh=aS4MO8IjzWvM8mE1fxr5NA7nXRg4ypb+1qO62EsAqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCuzc+AnA9apz6G2X3xVTYYxTgUMDHEvNLvKBRle6r7aS6bgufrDbwbLhLju4ix6Ckk7eOvvU3YdPPnkx9BRRINkIi9cIJzWCELjcIWYCtIjJmbbzE4CSGAVooQDdCr3XjrqvQ1xbMVvmhx4qWdyvldsMZKgMQie6gzwvBlnVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2iW0tgg; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Oct 2025 12:46:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759780006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b31nQZbUtdfeVLlEZHqw9h4YVK7okzSxH+R1dV5PTzE=;
	b=v2iW0tggbKQ2lCfDdpP3xPnahzcSNKqU7w3v0cFm6YxjzG+dpClpo46GY/MqByHzP0U2gl
	hX1wAXqeOpGX0j7hJ17kMv/IH4vUMkLPhRsSQ1LiBkYLcuimyitmDE232Nauw5YF6a4cHl
	FRhRNfGe0TADEKlju9vRRQCwtDrDDMc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: Remove redundant __GFP_NOWARN
Message-ID: <yb2fxxr5fglwgl3i7zmwjze2a2w4bhrdwnu2dbchxh54xzthpe@lfxvhat67ws7>
References: <20251006014948.44695-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006014948.44695-1-wangfushuai@baidu.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 06, 2025 at 09:49:48AM +0800, Fushuai Wang wrote:
> The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
> 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
> remove the redundant __GFP_NOWARN flag.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

