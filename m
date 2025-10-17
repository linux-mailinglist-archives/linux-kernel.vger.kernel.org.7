Return-Path: <linux-kernel+bounces-858287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D8BE9E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9406583F99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1573328FE;
	Fri, 17 Oct 2025 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9qwkbfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2372745E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714159; cv=none; b=i99Sw6T8aPLjULdSp2l+KTh1gqNKGajN/y4NMH2jXy07McDKMPfChjqp7dH7LzIuv48mHnTGXhNCBixtzhxYZaRgBek+2yNTUTPq/YnnlaElbUYLJNwV/YfiGsv9JXAztgdLtFhRWZJzwlM5eIQ4J8Z6/QdWISCFa0UaO/8rfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714159; c=relaxed/simple;
	bh=UIxW1vFVtzd9bAUc7p/fon9fI27HLZ62ACxMzr9oDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1P+qCzu7yQ5CsMWE/RL/0+aLxXpcOqwSqI7gkOXO5EdQJRgORbqkvcAi1XoJHBgRJtvkrKDgTWSrn4mu0Dt+2KGRnMpmTCUKo1pPglz8ZKlokN6mE5DkuIq8MLWQY5Bq6YGiMhRdN3+dCZSOm2qAWZuFHLyLojbSg43ZA0AlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9qwkbfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C80C4CEF9;
	Fri, 17 Oct 2025 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760714159;
	bh=UIxW1vFVtzd9bAUc7p/fon9fI27HLZ62ACxMzr9oDsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9qwkbfJmxbSiaSMQscNr/cax7NoF3vQH0CaoskkhT6FC/aThtV8hDb3GD7pyT1r3
	 fxpUsGodPrHlz/d6k9tNpQDUq00KeIIGsmDyPUk89WeeCOv5hPj0ghX9syVDlYRqnw
	 ELI2JI+Vuf/Hctu0wgf5GkkD53o60mfNx3JIHSVKGDzZACbh7+jZ6ozVXAJfCVQjmZ
	 fqfkk1T+nGc15MN0bxFE4P04xWgpECU+8ZKEQtzl6ejUU/lvqEhZhwqS+7+mPCT5ac
	 5mBQGI6QdDxxjstn9bKmgs4NnjBPkrr4DcQHWvi+czM9QCTQFLA0FyDWztFcIT1T/z
	 XHYimIrZIhX6g==
Date: Fri, 17 Oct 2025 05:15:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Message-ID: <aPJdrqSiuijOcaPE@slm.duckdns.org>
References: <aPEQAqGOWOzzZl4Y@slm.duckdns.org>
 <20251017091041.3026848-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017091041.3026848-1-jackzxcui1989@163.com>

Hello, Xin.

On Fri, Oct 17, 2025 at 05:10:41PM +0800, Xin Zhao wrote:
> Thank you for your suggestion. We can indeed replace some simple work usage
> scenarios with kthread_work. However, it is not a panacea, especially in
> cases where work processing requires concurrency.
> If we cannot use the RT workqueue implementation, we need to create another
> kthread to improve concurrency performance? In addition, we may need to
> incorporate logic to split works that are originally of the same type?
> This splitting modification can be quite time-consuming and is likely to
> encounter various strange errors during the split.
> Given that the workqueue mechanism is so excellent and effectively matches
> the needs for concurrent and ordered work while also managing work thread
> resources efficiently, perhaps we should consider adding the RT workqueue
> feature to the kernel. After all, the changes are too simple to carry any
> minimal risk, yet the benefits could be substantial in handling concurrent
> demands and preventing thread resource wastage.
> If we do not pursue this, continue relying on kthread_work to handle RT-prio
> work concurrency, it would be equivalent to re-implementing the logic of
> pwq and worker_pool.

There are a couple reasons why I don't think we don't want to go this way:

- Maybe RT is enough for your specific use case but others may want to use
  e.g. deadline, pinning to specific CPUs, persistent kthread-tied
  accounting and prioritization (note that kworkers carries arbitrary
  scheduling history across work item boundaries).

- Running anything RT presents a signficant cost to the system overall.
  There's significant loss in terms of the scheduler's ability to manage the
  system. Once you have too many things running in RT, you just don't have a
  working scheduler on the system. So, I think it makes sense to keep the
  decision to allow / use RT a clearly deliberate choice, something which
  has to be a lot more intentional than picking a different workqueue.

This will be a pretty hard no from me. Of course, I can be wrong and you can
argue your case, but it'd probably be most effective if the arguments are
based on concrete and specific use cases.

Thanks.

-- 
tejun

