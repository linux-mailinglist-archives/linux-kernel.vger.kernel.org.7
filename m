Return-Path: <linux-kernel+bounces-808817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968FB50518
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A921C65135
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F10352FF1;
	Tue,  9 Sep 2025 18:18:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74062EFD86;
	Tue,  9 Sep 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441929; cv=none; b=Zxx8gO9pE8EVJnpHyOFkhYX+Ip2FrgjKiFkuIg/whC0eC58zJ29aD+bfYBfc+fw1dJvzgzvwwY9OESkGFHbL5OSU3FEmmmeWH6Xa25l3CTo6uyUmCpH+k2zq2QJjg5hAO0xVgeomImXSwtfRpMO8FR9H0+GMrF9tmIdDtEp9jeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441929; c=relaxed/simple;
	bh=c+UjXcPyXKjM7+Tb+xcH0eAP8Rhl0lUQ67XY7B3xHL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9KPFdOw9QQnWtdfcvKAGo01ZE18e5CUntcQEK0oNahblnl9lel7j0vdukPVv4xGsjg4TAT56VKrAPoN1Uc3bZ5ouayKOuWXm3BShMNr7BMWj8RKGk0eymPPSM6XEYRKijzo+Yl2IJu9s0xst88Q9EAHIUFb7oV4VSoxM1X7NEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1A429C06B6;
	Tue,  9 Sep 2025 18:18:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B1F662F;
	Tue,  9 Sep 2025 18:18:36 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:19:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <20250909141924.2f17f1a5@gandalf.local.home>
In-Reply-To: <aMBRaPzjR4OJVIWn@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-4-vdonnefort@google.com>
	<20250908193606.47143d09@gandalf.local.home>
	<aMAYvA9LSvfxvt_C@google.com>
	<20250909093848.402674b7@gandalf.local.home>
	<aMBRaPzjR4OJVIWn@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: eqc7w7y8zn6us7jyigopqwf3nc7ynjtf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B1F662F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+42t01sKe6NN3Yv3aPETwZq7DQof3HuwQ=
X-HE-Tag: 1757441916-886505
X-HE-Meta: U2FsdGVkX1/FkbATY5c/bszCpTxcE2Cn42lYpIlf0+M2DnBLkDpeiDnFpxC7EnRVRWD7bBFR2LjqPKnXdu1P9EKDSXtR8hvE7QrEkuS23WAKU0+q8dSKFLWS6N09CoZuqDFBzUC6JBO9+ehpwvzhwv+MRRoJKAOqD2hA/RvOMNI9mPvrU7rSjtczYd0M1o8dnaq3smAVl3E7hIw6B9IvF8IaP8iFSh5u5E8Q6yYK9zKMSBT2wxyFEpcqxQl9a5pBntG8IUIljfZxm8tIcO54NkMEyojXNkhab20elYHd/QR1soOKOMhADArVAJrmA2hitNlYDnbzyXFuq6lpHdLW75t+Br0U3Akn

On Tue, 9 Sep 2025 17:10:16 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:


> > I'm more worried about the allocation not being big enough for the rb_desc
> > being filled. I just noticed that the trace_remote_register() function is
> > missing a kerneldoc header. Please add one and specify what the parameters
> > are for as well as their requirements.
> > 
> > It's fine to state that the allocation of desc must match what the cpumask
> > is. But the lack of comments about what the function does and what is
> > expected of the parameters makes it hard to know if it is performing
> > properly.  
> 
> Ok, will do!
> 
> I could also add a desc_size parameter to make sure we won't overflow the given
> desc?

I wonder if we should just to make sure things are checked. Having a
bitmask determine the size is kinda strange.

-- Steve


