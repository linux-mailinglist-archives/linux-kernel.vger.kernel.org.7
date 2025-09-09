Return-Path: <linux-kernel+bounces-808709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC45B503D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373121C80AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C136CC81;
	Tue,  9 Sep 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTOqOLWg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173435E4DB;
	Tue,  9 Sep 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437174; cv=none; b=PFs99hx3X/QWw8KBz39TzeYP/DliqJQ10pgsituufP39w1mWARUKYq2kXU72J6sbrqLnia+Ax8lA8tIYcgNCwJi7wp35jXI0Pg07L/kE25ycNXwu1KVen3A2ST/Bw/tXRVN4AZwVYQ6IVMMHsxSIdSAlgB+Jdlv5gCSewVldLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437174; c=relaxed/simple;
	bh=QrbsiZnOVWmIb4893vFrJVD1qCnZigbwaqoU5U1DMIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjTw7gx4buw5hd8Zsnf7J342jOKzxE2YR50h9LuD5hl3lIzSj9pq49YuhKCNTWzJ398EO0qE1WFU2/w5DPaz6YTCXC4XBD8Cdv0emokqbEa7E96JILBG6tWyGrtdwnRAyJYQVl7xOkN/CEjV8/bryaDUhxTShUL6k/KkuJo+450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTOqOLWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEECC4CEF4;
	Tue,  9 Sep 2025 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437174;
	bh=QrbsiZnOVWmIb4893vFrJVD1qCnZigbwaqoU5U1DMIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTOqOLWg2G41thqvjW5Xizmvv6ESr+Yn9ocMqGF6+K+EvlSaVVvnj3D+M4O/nX/Wo
	 PLJvqBvbkKqDFgNEBqiHuRZiZlAWC9L8njCXTI/MtDdth1afZPxL+616kEToPb8PJk
	 na70/OHwsyJz5c1igW7+Rzqt4h78zxV71LveHH65QDclMqzGwIFPM7hQpGMx82b77b
	 fmY0VFqtFj0pOz0mt0kAEx1No5jWalUc2005cE54jyRoUXKr20FLoMQ2+ZWReslS+r
	 rM8xsF4dIsyEteBoAc49cbg4clarZgdXCZCvWP2q+49zj8NtoA234cjtofa3F+Ur8q
	 QCHAiiC4NJBMg==
Date: Tue, 9 Sep 2025 06:59:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] cgroup: retry find task if threadgroup leader
 changed
Message-ID: <aMBc9XRGDp6ipbOK@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757403652.git.escape@linux.alibaba.com>
 <42b7b9b12a65e7b1a8e58ce055240ad63f93bf6b.1757403652.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b7b9b12a65e7b1a8e58ce055240ad63f93bf6b.1757403652.git.escape@linux.alibaba.com>

On Tue, Sep 09, 2025 at 03:55:29PM +0800, Yi Tao wrote:
> Between obtaining the threadgroup leader via PID and acquiring the
> cgroup attach lock, the threadgroup leader may change, which could lead
> to incorrect cgroup migration. Therefore, after acquiring the cgroup
> attach lock, we check whether the threadgroup leader has changed, and if
> so, retry the operation.
> 
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>

This and thread group lock relocation should come before the patch which
requires it, not after.

Thanks.

-- 
tejun

