Return-Path: <linux-kernel+bounces-780465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77DB30232
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC251CE66C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F8343D66;
	Thu, 21 Aug 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7Ere37+"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9192E3391
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801330; cv=none; b=rGXv4uBaqMAul6NrU17D0XN6m2ge0gbIDSkz7jKFCydh9K8jtOceHKmcKgRvFlxbH7WzEY3xnNHu7OBFaqOL1IDCYRuBYVzKn/tZDPsLn0ZXmC96BSL9ZwEhFrtl6QxWPQ598TqPrPDDDQTxH5doPnzpEZRa/MhfeYtoyhm4pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801330; c=relaxed/simple;
	bh=X4LYnbsXxXRpIYijpfEn4XZynuNNbOv74G8LAopQf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsabyNsmlatZwjf6zDxMxWV5+3lhkbU3NgyKEzU5U5SXFXSQcasEN5ayoIPVGIH77p036N+hehEDL6S6nzuq3v/SI279jKD3Z9wI8nVEkLfLiQJFtN6RAcOQa3KvSqSF4HNXhQzBmp78z1lJOrIJaUssLFLABcRgtJayvQgoyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u7Ere37+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 11:35:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755801325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lYKvb2dH0bTbVOPzrM44BfmX5KXCxGsEa01RWtRNfdw=;
	b=u7Ere37+9zchNOCm3RVOb4Y4tTbmmqMZwwRwzwD8nVr+Ux4rter4+q9m/8C9/kcuNGwegc
	9HEuDvjL2v+gNwk/aJEpKtXjS+Hf6MAcAO1dPhmdry5Uu4bhLth+b6FjeyzhMwmqFgudF5
	25yO/1kH8+xsZn1lqgEktk9bbFdloE8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
References: <cover.1755190013.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755190013.git.pyyjason@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> Right now in the oom_kill_process if the oom is because of the cgroup 
> limit, we won't get memory allocation infomation. In some cases, we 
> can have a large cgroup workload running which dominates the machine. 
> The reason using cgroup is to leave some resource for system. When this 
> cgroup is killed, we would also like to have some memory allocation 
> information for the whole server as well. This is reason behind this 
> mini change. Is it an acceptable thing to do? Will it be too much 
> information for people? I am happy with any suggestions!

For a single patch, it is better to have all the context in the patch
and there is no need for cover letter.

What exact information you want on the memcg oom that will be helpful
for the users in general? You mentioned memory allocation information,
can you please elaborate a bit more.


