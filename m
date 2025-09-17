Return-Path: <linux-kernel+bounces-819809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3DB7E571
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E77148250A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B41EA7EC;
	Wed, 17 Sep 2025 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OVmESGHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB033C38
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070601; cv=none; b=l9FPBnBWb4g67d/JUht8BMM4MpRb90TDQKHMwUwCyGAN3t0MWWfnkL3bgelqmbigr0zEIj7ypPBbUr9NzXcIAOlmKPxbJPuWOYyGK9UPNFP6qb6k3WzcbSDgqTmceCQIc6By1HvLLJowCqd2hjNPjOrhWDY5XF5m1mEnX9dytV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070601; c=relaxed/simple;
	bh=kN+NGCVBMUoWfbiflAXY+vstv5YMeUL20qWoyAdAJDQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L7x69g5bG14wa+xBbfnLp3yrKJwOu5ryAzzydqWixtSCZN41cxI0sNwBC+2w3CSzc0o2PHcUISy2wRs3YlVWdUeww9Hng8DQTjzkxnezeMYYTcxfdm0N9jZaMSMDqn87bpWNVbXBBh0PtT2RuaMPaiJMxDkCST1dxijfQ80+O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OVmESGHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DAEC4CEEB;
	Wed, 17 Sep 2025 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758070600;
	bh=kN+NGCVBMUoWfbiflAXY+vstv5YMeUL20qWoyAdAJDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVmESGHIIFGkkDubiKZqf7FYfPatb/hvLIU9LdRirkf41miv4FzHSnGOra9NqM0+L
	 Gxbh8ztusglpGX8N3oGu87lUBFyWDFQVOBaW14lhJZki8VnxG+f0HpJRC2uFEHu3SV
	 hmNEq84s6lErCVuE0Ih2XI963DoP3n0vuIJUzzfU=
Date: Tue, 16 Sep 2025 17:56:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev,
 vbabka@suse.cz, hannes@cmpxchg.org, rientjes@google.com,
 roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev,
 00107082@163.com, pyyjason@gmail.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation
 counters in /proc/allocinfo output
Message-Id: <20250916175639.2368772636d5e543faa5b13b@linux-foundation.org>
In-Reply-To: <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
References: <20250916160110.266190-1-surenb@google.com>
	<4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 21:50:51 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 16/09/2025 17:01, Suren Baghdasaryan wrote:
> > Document new "accurate:no" marker.
> > 
> > Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Based on mm-new
> > 
> >  Documentation/filesystems/proc.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 1776a06571c2..17668f82ff1c 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each line may contain additional
> >  For example if the counters are not accurate, the line will be appended with
> >  "accurate:no" pair.
> >  
> > +Supported markers in v2:
> > +accurate:no
> > +              Absolute values of the counters in this line are not
> 
> s/values/value/ maybe? :)

That's OK as-is.

> +              accurate because of the failure to allocate storage required
> 
> s/storage required/memory/

Sure.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: alloc_tag-mark-inaccurate-allocation-counters-in-proc-allocinfo-output-fix-fix
Date: Tue Sep 16 05:53:33 PM PDT 2025

simplification per Usama, reflow text

Cc: David Rientjes <rientjes@google.com>
Cc: David Wang <00107082@163.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Sourav Panda <souravpanda@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/filesystems/proc.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/Documentation/filesystems/proc.rst~alloc_tag-mark-inaccurate-allocation-counters-in-proc-allocinfo-output-fix-fix
+++ a/Documentation/filesystems/proc.rst
@@ -1016,11 +1016,11 @@ For example if the counters are not accu
 
 Supported markers in v2:
 accurate:no
-              Absolute values of the counters in this line are not
-              accurate because of the failure to allocate storage required
-              to track some of the allocations made at this location.
-              Deltas in these counters are accurate, therefore counters
-              can be used to track allocation size and count changes.
+              Absolute values of the counters in this line are not accurate
+              because of the failure to allocate memory to track some of the
+              allocations made at this location.  Deltas in these counters are
+              accurate, therefore counters can be used to track allocation size
+              and count changes.
 
 Example output.
 
_


