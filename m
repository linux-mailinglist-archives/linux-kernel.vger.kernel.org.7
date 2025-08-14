Return-Path: <linux-kernel+bounces-768055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E4B25C60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09D9B6068A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E212505CB;
	Thu, 14 Aug 2025 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0gV6tl8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64452257440
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154709; cv=none; b=tmwggoYdjR4iSnAoXe0ZOZvsaYEqPAzJyMouW44KxPOUH22H51fzqhL6SYRnPd8l2iJVBIzZ6TfRrVRm3gF6jjEPtdBIvQ4ylZncQUR72DzzdbbHWkDZLkMqRVI7ij2pIq8JovvRsw0nKSZJTq7uvX8h624eUvoZQpkNi+0meAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154709; c=relaxed/simple;
	bh=I1AzA/c9kzigMvAV/MMG1ZBstAUp01OaJAs1srlY+DQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qJu0eBieJExavDD/GDWZ7DqugglTXaifUbFeBcSF0IsbLAjFjlBteLvfWEuW8/JIbh+TZnSan1MTNM1HV8Mpp5qsMiay6rxJ7ok/Qbnyhl4iBJJrTlY9xKtM77WOnjb0c4FFkL4e+Tt1Q/bDr8AXoB7s72+luJqaGDkfyYhhjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0gV6tl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF1C4CEEF;
	Thu, 14 Aug 2025 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755154708;
	bh=I1AzA/c9kzigMvAV/MMG1ZBstAUp01OaJAs1srlY+DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0gV6tl8DOH9TU2r4LJ6UWIha17jveb+QEu/VEA6qwEmnsysm+iEkzG+dewX3pS6I
	 weYTUcTJJwSot6ZnyqzLpHuRcELlmaTZqCWKyH+sA0LYZ4PoczauR1zIo5R/cEbVD4
	 TYzkBugXikA12wllIQxT7UqZeWFksLaP6dov9qwFzuicM6UtIkjeg7VGZHFBP9iMwU
	 lduLXCDgL4RJxmgP0r5CcgQK1Mwv07mfykv8kc+mNsEnpNO5iPFvbuOzpdISHuW8Wt
	 NpY4wxcEf5BUvqIBC3xLdheBMG2r+HhqShHF3BMYYoyXxK8QxfKPe8Zw4O99gto+w8
	 iwl7XKx3RRE4w==
Date: Thu, 14 Aug 2025 15:58:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Nanji Parmar (he/him)" <nparmar@purestorage.com>, lance.yang@linux.dev,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hung_task: Skip hung task detection during core dump
 operations
Message-Id: <20250814155825.851f99458a7be18069fc49aa@kernel.org>
In-Reply-To: <20250813150155.81680178704c4652fd454a80@linux-foundation.org>
References: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
	<20250813150155.81680178704c4652fd454a80@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 15:01:55 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 13 Aug 2025 11:30:36 -0700 "Nanji Parmar (he/him)" <nparmar@purestorage.com> wrote:
> 
> > Tasks involved in core dump operations can legitimately block for
> > extended periods, especially for large memory processes. The hung
> > task detector should skip tasks with PF_DUMPCORE (main dumping
> > thread) or PF_POSTCOREDUMP (other threads in the group) flags to
> > avoid false positive warnings.
> > 
> > This prevents incorrect hung task reports during legitimate core
> > dump generation that can take xx minutes for large processes.
> 
> It isn't pleasing to be putting coredump special cases into the core of
> the hung-task detector.  Perhaps the hung task detector should get an
> equivalent to touch_softlockup_watchdog().  I'm surprised it doesn't
> already have such a thing.  Maybe it does and I've forgotten where it is.

Hmm, maybe we can increase nvcsw/nivcsw to reset the hung task checker.
But usually this means the task does context switch while core-dump.

> 
> Please provide a full description of the problem, mainly the relevant
> dmesg output.  Please always provide this full description when
> addressing kernel issues, thanks.

+1, dmesg will show where (in kernel) we hit the hung_task during core dump.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

