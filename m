Return-Path: <linux-kernel+bounces-801238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4585B44286
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE1EA00F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A82222D2;
	Thu,  4 Sep 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5F3/9XN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBF1DE3DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002718; cv=none; b=BE3DUbkd2L7k2EOpH6q+WjihZtn8JHVLvXV3NFxpHsgR9p/GH7i50w27oczU+otpUEvAsqgLaV4epKk7uwjUIYWbH77Va+aDjlxN7MK1EeBYIKTEXv3yv8St+fazEX18BF8q7QQIVN5qgQax8+cEKwCZbChW5PCl/f0d3/DL02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002718; c=relaxed/simple;
	bh=yf3bhSnhmq8lZCFybEB9mcuAPC6weCguSY+YasAstnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wf1TBhtXW6nCgDYRIt/xZ6RaYjm85ep9Owna/NhJGWDLhhAMJg2bRNTwvA0xk0+zVYD2aG16FtLleveGhC1wSLYQBAqmda0JTHJuKjOJ2wmXq7BSN7h+RxfA5VZvYOunEkllSlT/pyhxX9yIYfjnW+edYH7L4o6feOodgNrdmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5F3/9XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63380C4CEF0;
	Thu,  4 Sep 2025 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002718;
	bh=yf3bhSnhmq8lZCFybEB9mcuAPC6weCguSY+YasAstnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5F3/9XNrzQz3gHTj2CybbDdfaZj2Mqgw+xG9SpxiwLS4hj/qwFhV0C2C3HQUSR+0
	 3IvQf0MaCRO8o3cDEx8Azg9a3Uj/W6mwK4P9LnUKEQQVaTb7PWkdhgjG31ROXoki46
	 d192wOkzy2174rTCMBmFu6AfC4L/9qKdK1VxfY7WO5c2Uzttt1VZlcud7lLNt9inrt
	 BxsRrlgg1Vhtm8NsP0ghfj+s0AEGrHxLf1q7AkS26ElJ7WXu3VUiZSwLXAVKznpuqk
	 tJFjBlaRDe+EgxtteXeV5CW2/HrF40oNXw75QNOQlLNth9/jWCExKZ0pXUWlq+SqCD
	 gqci/g+NOPKBg==
Date: Thu, 4 Sep 2025 06:18:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Remove redundant rcu_read_lock/unlock() in
 workqueue_congested()
Message-ID: <aLm73V4A23OgahmO@slm.duckdns.org>
References: <20250904113133.24487-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904113133.24487-1-qiang.zhang@linux.dev>

On Thu, Sep 04, 2025 at 07:31:32PM +0800, Zqiang wrote:
> The preempt_disable/enable() has already formed RCU read crtical
> section, this commit therefore remove rcu_read_lock/unlock() in
> workqueue_congested().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Applied to wq/for-6.18.

Thanks.

-- 
tejun

