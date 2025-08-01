Return-Path: <linux-kernel+bounces-753713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07095B186CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8B67A3ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2828CF7C;
	Fri,  1 Aug 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HjlgcaAP"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27ED28C85C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069923; cv=none; b=czP5tuBtwlvKXlD/bEzldG9UFoMoeDzDfX8xaC1JtRNXRr4a6pfMzdZS2zXhMJsnZn9oTSH4CgsR0tWL/iu60v3guTNHd4PCiYocB/kJecFFW1FNa1KPlu3bJa/6sp8lCYksYGXyIThJwLDgOQoCbfpel6p/rjw547BaP76fJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069923; c=relaxed/simple;
	bh=pB2h6W9jjN3lS0Lnw2q5+ojF9n8TuLwzAW1RiNHG6fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuEXZfCqqYjAn7gEZoXptH52kmAw6+WNaoam7EcTbrgl+SyqLL4Dv61js9wexAmTtjnSVjEJBGnUWZAJEkMJJvBZPDr7myWQQGQ4y5TCiIgJUFi+krO0Nbb0AVNYwmVxT57e+QBXM8eh9nKw90XQRAYrtiLQ0h4z3maY5J8pl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HjlgcaAP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Aug 2025 10:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754069909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zc0x0gXzPBHKcSYwLojfQapfzxMTdF83o2k5UBSYZKg=;
	b=HjlgcaAPrv1gPNeYErWfYC0WMqVKVMa1i2fVoGvIEwIdUm25xU2Pa4L31Cz592zEBDrXo0
	9YYz4wek2jgS/mdeuQaijylvYaW6jjIi8/dqiZtuxP63rial6SK29AbgXc11foT0I03Y2s
	ypW6pSNC2OyG4Pv7wQ/5ISyTGW8pZDI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.16-fixes] cgroup: avoid null de-ref in
 css_rstat_exit()
Message-ID: <ginu64khh7im4bc7k6xnqf6pqv2pcjreutluwf3mrwrqgyoet6@7u2xbtejr6gi>
References: <20250731192734.106214-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731192734.106214-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 31, 2025 at 12:27:34PM -0700, JP Kobryn wrote:
> This function

Name the function i.e. css_rstat_exit()

> may be called asynchronously in scenarios where preceding
> calls to css_rstat_init() have not completed.

Explain some (or just one) of these scenarios in the commit.

> Return early in this case.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

With the updated commit message, please include:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


