Return-Path: <linux-kernel+bounces-681813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E744BAD57B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D9118964FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3828C2D3;
	Wed, 11 Jun 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k8pw4dnN"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72738280CC8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650218; cv=none; b=hxjlkUzQAgqy5Ezk7jLBU452ix9IjEZfdM2jIxfBT5QEgcyfhxjtfDOgzsIUh1H9rcGYgBBehbl/ia/UhZjCIC+v8mFpShFqROoBUWbK4zpvO79beX1SX+HDI8cmYDDBIQpisYlXkUbL5R4csnb34G3PDuOpF+ziZWyv1qdx3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650218; c=relaxed/simple;
	bh=yInjroIeI8Sa9JOO0hECKK5K6nrt0bkmlUE485gavCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiLDPRjkkAOL3o/+lX0jDo02QlSKpNaRJ0+WTs8qHc6LTPE8Kpa8ap++NaRBpy5ZBE9CX2fK8g1lTioHtv6Cj74p/3nlH8OseYOI0QT8fN2sMm4GAjt/pXHhHdRH+WaAnEI6mCllPzDyfKNw4PUUA9Jz2OKzSRms9z/OlOu3bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k8pw4dnN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Jun 2025 06:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749650214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIVwLACmuPirU7lqZbvkjyNoqDHmBaKqfMhlz/98tZA=;
	b=k8pw4dnNxNVuHrhFFGMZnRS5GfDoGVVUvW+UfGCmJPzPoKCyviuuiIT172m0o72rfOf11v
	qgH4nU9EOhtwbqZxWX8iSoxuZ7gopv55HkwYwZnt4sIsqtGMN+mXkKfcjinwG3lG4fk5HI
	gZYobU41OM/CurV8mkMx9ayrD81d+ho=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <oiwsbn4bo566rzxgcjkelufp657iog2hxiqthxow663cqh44dk@lev4vkh2emjb>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <9cf00007-f068-4ced-8977-f39a792eef6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf00007-f068-4ced-8977-f39a792eef6a@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 10:23:51PM -0700, JP Kobryn wrote:
> 
> The subsystem per-cpu locks were used to synchronize updater and flusher
> on a given cpu. Since you no longer use them on the updater side, it
> seems these locks can be removed altogether.

Indeed you are right, thanks for the suggestion.

