Return-Path: <linux-kernel+bounces-784452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC41B33C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC951188DE24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FC2D7D2E;
	Mon, 25 Aug 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSTQ7HfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tizW5M0L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F627EFFF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116353; cv=none; b=kQyCxAQ2nplKy7uy0IxTWnV1UTd29eMD9X4myF3Or+hgx59hTuuxzAWacMYY9CwFugPAWPqQgag+BUblsFR0d7P3LoJvbfKPfXTnrkc8mOYntXzGz4+oJkj+wNP2Q26JQ7axkA9PFuBC08aZ64XB6tz2bWHK5IhNTDjPCuBKiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116353; c=relaxed/simple;
	bh=5k3V1N+pl3pbetKTwBrIGG1X5xNg0R52QUqBtiU6sYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUVAWdzie0eDYMHhI6Xl/ESuqiaQZMW8Nvsh2h+K5+ehWRh5g9DOKURMVU4oNu1Xqz/SPBHSsTlY5FZNW0UUoQpfiZ1khTaIBK3r6mmeURk2gFGiZL7n7DOxxa5D9GXHPJ4/TjgYNvbM8xQnp1gLnCylSMtdJRelbPT9MAqXc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eSTQ7HfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tizW5M0L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756116350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k3V1N+pl3pbetKTwBrIGG1X5xNg0R52QUqBtiU6sYw=;
	b=eSTQ7HfLdnkH9ty/GEkyVDMiSzL/fTRDaTV2otoO6vCrrj9qf14JI+4qyv+ehdgrNISg+F
	sPk8nf0s4WgeqsU3WvRlZkssfROnR1xtKZiB/79aUPafWYCTwxz8/o2HkAzW3gOAyAquKS
	ityJqRPCgqd5C+dCoZtBesKsE3mR5u82kmc5wc8HBvlfXmvTnKa4BUQ47AlHCOqAPx7PDS
	d5aU8d3Mp3kXyDb/CWxzoQrwc+pOL3Sw2aEnrOcqOFG5B0HOhizTXNYk+nFjCWwmTuGRhC
	CJQtmcDYXdOKnH30TcN4oilR6s9wR6ojj0YplhVTYTm+69QoR5Osduy8ihPfmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756116350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k3V1N+pl3pbetKTwBrIGG1X5xNg0R52QUqBtiU6sYw=;
	b=tizW5M0Lo9TC8FmfeC+N64FrcoCS9Q+xdT/xedOX6AFDvcnSLfIV6vBS6n3qsP9N7HdgLH
	3mssBh5mV3YodbAQ==
To: Jinchao Wang <wangjinchao600@gmail.com>, pmladek@suse.com,
 akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, wangjinchao600@gmail.com, namcao@linutronix.de,
 sravankumarlpu@gmail.com
Subject: Re: [PATCH 8/9] panic/printk: replace other_cpu_in_panic() with
 panic_on_other_cpu()
In-Reply-To: <20250820091702.512524-9-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <20250820091702.512524-8-wangjinchao600@gmail.com>
 <20250820091702.512524-9-wangjinchao600@gmail.com>
Date: Mon, 25 Aug 2025 12:11:49 +0206
Message-ID: <84tt1vbts2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-20, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> The helper other_cpu_in_panic() duplicated
> logic already provided by panic_on_other_cpu().
>
> Remove other_cpu_in_panic() and update all
> users to call panic_on_other_cpu() instead.
>
> This removes redundant code and makes panic
> handling consistent.
>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

