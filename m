Return-Path: <linux-kernel+bounces-801240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB006B44288
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007FF5A4201
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C2225A23;
	Thu,  4 Sep 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXVfUWC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1527713
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002735; cv=none; b=ewXr5KmudPiFcvzNOghKxWtFD8dkkJuqyiTF1P6mxQZfv1rodE19B22XwWfaLnsjlD1u79Hk7hY4CEKy4jKPdp/NjY2zcMTVv8NuU6TerGddpsA1Gak6hwRVsDno9xhXjBrVbWz7s6beB1yLBt/eAhgyIwdB/Lm46K2qEqqxMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002735; c=relaxed/simple;
	bh=hG7uQKDoWlUHAsIbTCZ4LKMxHqUhqz9DfjcL59BAytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE0WwmmC+x8F4U1YPWBGTBbuwi3qUAQx4JSfMxWeZ6m52vJTtrzojKR6wRBhp/v40K6QfPd9chT1UQ1V7XrPM9tfYI4Vljhy9FZQKGQDTaT9nyUvn6X5qOL1asuljcn1PTVbk5EN7P6P3isPJysM/g6lliJPXu6uns1UdiGaOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXVfUWC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F34C4CEF1;
	Thu,  4 Sep 2025 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002733;
	bh=hG7uQKDoWlUHAsIbTCZ4LKMxHqUhqz9DfjcL59BAytI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXVfUWC2FKpLx1+Te3QiKry3+braYHv9sZLp5LwapGdej8iN/rEWt/HsBgXSOdlYi
	 ZDOpUJJkGJj9DxBQoH9X3FLOcZlQ9mybcODYW1wF1PPaU3Xo8zOvuhKdL3fs9WX3MH
	 RXwSrhWHC+sVJoih3WUBFVqUvafNXiM5Q8ZqnXIMAPn+WgGI+W9UI9Wrdir5LAOPfo
	 c8+wjxqfreBsGIZ/y+EnFdZ+/NCXymvyz1kg+0x2z8Dd7tsfSFoGqR+s1u1GvPazTq
	 qt1+BaXU+Oe4bhK3Iteh6guyscPcCoE2aunm3oBZpqeBU4CvL+Qgoswb9tQ4KIuIZN
	 YVneryTLw0jyg==
Date: Thu, 4 Sep 2025 06:18:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Remove rcu_read_lock/unlock() in
 wq_watchdog_timer_fn()
Message-ID: <aLm77Net5zl4WyMc@slm.duckdns.org>
References: <20250904113133.24487-1-qiang.zhang@linux.dev>
 <20250904113133.24487-2-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904113133.24487-2-qiang.zhang@linux.dev>

On Thu, Sep 04, 2025 at 07:31:33PM +0800, Zqiang wrote:
> The wq_watchdog_timer_fn() is executed in the softirq context, this
> is already in the RCU read critical section, this commit therefore
> remove rcu_read_lock/unlock() in wq_watchdog_timer_fn().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Applied to wq/for-6.18.

Thanks.

-- 
tejun

