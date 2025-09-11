Return-Path: <linux-kernel+bounces-812861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B05BB53DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B82F1C24D73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7DF26981E;
	Thu, 11 Sep 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tFh5AqH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243327462
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626293; cv=none; b=hm3wv2+gUHXCFS0PNWaQtNGYBYr1kzj9+U7IEtsXYhzoCru/D8zF4Z4Gx5HLvLlNE9aF5lmGA1ZuvSlCXomTS2vaCc+HeK9hZj5052gSy/WHA42NtONghwxzKVoLcyB3EfKBWwK/nugJd4BwKHkWfAhhkMXJgk7ZuARtmHG3qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626293; c=relaxed/simple;
	bh=9x2Wu5/QlMnDtDHROyBHPWM0ROyv8HlbmYz0WmyG3Mw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BdquYoej0EZ1poV9IIN9OAuXaVEy9mQ5pyF5kQk4MxevpFmjA6am58LLmQVLPNUp1iuy4zaq7UIpgBYSRk7Nv+13XwyfAzS1/CfNrcWbNv0vCjAR1UP9Ce5Pjq6RpuGLcRtNF4v27KJ/JbeXNH9kXKvNCpx+sfQ1qKGCQsEGcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tFh5AqH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA22AC4CEF0;
	Thu, 11 Sep 2025 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757626293;
	bh=9x2Wu5/QlMnDtDHROyBHPWM0ROyv8HlbmYz0WmyG3Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFh5AqH+gi6m/CLMpP7QXYgwkYHzcXMB7mZp2v+6RCpabU7ltDnI2vft5P5GybKjV
	 1RI9Og7EAf86WmewFeV9tfagYcVEXCjNB5Jw9HAOJHoKenxGlDmu3Cm2oc3rVNBNtM
	 7UIZ2y2u5VliwKQZ8V2TxKcXP4mi+uupY+CN02Eg=
Date: Thu, 11 Sep 2025 14:31:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, David Wang <00107082@163.com>, Suren
 Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev,
 vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
 roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev,
 pasha.tatashin@soleen.com, souravpanda@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-Id: <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
In-Reply-To: <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
References: <20250909234942.1104356-1-surenb@google.com>
	<20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
	<aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com>
	<902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com> wrote:

> > I think simply adding * to the end of function name or filename is sufficient 
> > as they are already str.
> > 
> 
> Instead of:
> 
> 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
> 
> Could we do something like:
> 
> 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create(inaccurate)

Can we add another row, saying "the previous row was inaccurate"?  I
guess that would break parsers also.



I don't know if this was by design, but the present format does provide
extensibility.  It is basically

	NNNN NNN name:value name:value

one could arguably append a third name:value and hope that authors of
existing parsers figured this out.


Whatev.  I'll drop this version from mm.git.

