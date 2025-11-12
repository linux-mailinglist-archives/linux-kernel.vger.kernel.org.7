Return-Path: <linux-kernel+bounces-897666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0473DC5364B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB21D50347C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF1311951;
	Wed, 12 Nov 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+vRT8US"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CE23909F;
	Wed, 12 Nov 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963400; cv=none; b=E8gLNZbGETb+KCRtEDBABQNXOPODSzPuv4VFI6B69YwegnW5zDBA6U/4q6ZD7wdb8PvX1JAL/qy9WprhV5vbkh0sh3t8eCgAiAJ9bePf13nFSUZZ0GWjXoC91uizio87viaKi6p2TpfQU4q/njLFZKXKVE7W8kXMYq24cstPQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963400; c=relaxed/simple;
	bh=invabEOCxnqHWrYsO9g/wY8/hXtDzV09Uq3YHCe94vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwIVeJezpBdw6UkWXnvBL3rvUwuaAFezTCjmTh/PhvTRzbBFHunsDxpJVOIT8w7Vkyvd2H9RmpLK6RotfzP6pKxP0RLoNTam6H9XI9SAjBrch5e+dBvexhwFpVbGOkmcKG+WXrZkBKqnPUbByMVydbNDOAKpZKgv09ysRDR/LEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+vRT8US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31137C113D0;
	Wed, 12 Nov 2025 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762963400;
	bh=invabEOCxnqHWrYsO9g/wY8/hXtDzV09Uq3YHCe94vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+vRT8USnysWtcDtgpiiASZB0B+SwmQw3d+O1GVoPasEL+9767FlkN6R9XY5r2SvR
	 uetu+d2lVZhwZ/A07UH9AByLdI19lQXj/1ZUXxf4Ic+Zbtee4kMRkvUAbUOjbm8qnM
	 K4MC8omhVUl/6IbWpKugTnZ++3UZ/xDQz+Uy26b0zD8eBr+I1dLAGz9TA+xs1haFqb
	 nNOdhyS/IDogACheWDvOHD+0/5DvqW8C7e2mYjihNBmbWoFW3PF/GIxpZrHnZ1GlUZ
	 3sf7SfxuauZozQllB0ZfM/erRW3Regk8RzSHlUMkMVnJCfSvtErX2RaULIizVEfYAX
	 IFO5XCYT3QWGA==
Date: Wed, 12 Nov 2025 06:03:19 -1000
From: Tejun Heo <tj@kernel.org>
To: ying chen <yc1082463@gmail.com>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
Message-ID: <aRSvxyoWiqzcBj-N@slm.duckdns.org>
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aROfRBGmglPgcPVf@slm.duckdns.org>
 <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>

Hello,

On Wed, Nov 12, 2025 at 10:01:10AM +0800, ying chen wrote:
> Works that have already been scheduled will be executed sequentially
> within the rescuer thread.
> static int rescuer_thread(void *__rescuer)
> {
>                 ......
>                 /*
>                  * Slurp in all works issued via this workqueue and
>                  * process'em.
>                  */
>                 WARN_ON_ONCE(!list_empty(scheduled));
>                 list_for_each_entry_safe(work, n, &pool->worklist, entry) {
>                         if (get_work_pwq(work) == pwq) {
>                                 if (first)
>                                         pool->watchdog_ts = jiffies;
>                                 move_linked_works(work, scheduled, &n);
>                         }
>                         first = false;
>                 }
> 
>                 if (!list_empty(scheduled)) {
>                         process_scheduled_works(rescuer);
>                         ......
>                 }

Ah, I see what you mean. The slurping is to avoid potentially O(N^2)
scanning but that probably the wrong trade-off to make here. I think the
right solution is making it break out after finding the first matching work
item and loop outside so that it processes work item one by one.

Thanks.

-- 
tejun

