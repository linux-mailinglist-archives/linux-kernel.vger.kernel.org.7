Return-Path: <linux-kernel+bounces-721684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F854AFCC6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC473B99D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E52DEA85;
	Tue,  8 Jul 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlYn5svN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SB0H73oF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27C2DD5F0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982433; cv=none; b=WlSPzgEn9loNsC48IoQ6oWSu8sTqMIGvetSsc+Qaocoz/R20TiKRMBJxpnyY7dQhUg+LKzFTttrLfP3N1x3BN//tWTNAsMKY+itptXyEI9CH0WA34mwhevs2gTJPkhCUXu7cPJBtMZ4SbmIU02yZYXdkGjBuT8P1WFMcjYChiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982433; c=relaxed/simple;
	bh=v8Q5sU1x3wVPTZkMVJL00HFO0kAhP4pkLnkuLchsbRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkltofldrn+3NI9libEECf1X8+2+0CHgA36jnlEuhM4Kn5nbFYm0EX0y/ArmyQgjiXZP4Pbu6EZZCVQ6baat3q+bdFWidmQkhC5QO/92bwbpl3SW/RT7q48v+vqS1dDZOTdTAWi6IY5tXjH+jRKeN2BIFl5zU3ANRxWvtO843No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlYn5svN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SB0H73oF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 15:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751982429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZ4JT8+FPSqGZ8N4VFSYgL3uD7c3OJEImJChsHwxaM=;
	b=KlYn5svNabWyIjCcxL7qV7rK36rjNEm9KYrkFX7XJr3/yOP13IsQxzqFL64K4l7wMh0rHq
	Lq+E5b0jD1AdUKv62VA0hsk/i5MlW9I/DDZjpx+fFkDbU1Seq+eifYFA9iOsd1e4i+Nba8
	OzA7xw3drYarfYsNsAiyPOwDdEJofetfm8rMjyu2VTBzYPJq4SL94vzK1iQTE9Rvm3iBNp
	wqva8SxsV9Yp+brNK2Vk++dgFCEM1hUHu5ocRQWAA41EwarJhtybbGKHxY8cxiIkF+sLHB
	fAL2pyMOcyQBLj/zpz3XlKJIPU7GoXKaPJVoz1Yx5unUNuIdNGduDyk0y5Q5Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751982429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMZ4JT8+FPSqGZ8N4VFSYgL3uD7c3OJEImJChsHwxaM=;
	b=SB0H73oFjGxozQKqG2FsuObCwYBaq8LyXQhs+qDpKXL1vAHucoxZS7KKfPFVSndh83r5vv
	VyKcqnLF8EDRBVCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708134708.Rgh8nHcx@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
 <2f0fc991-0e70-4bb3-bdcc-f87293cb6471@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f0fc991-0e70-4bb3-bdcc-f87293cb6471@redhat.com>

On 2025-07-08 09:43:44 [-0400], Waiman Long wrote:
> This looks somewhat like what the percpu refcount does (see
> lib/percpu-refcount.c). Could this be used instead of reinventing the wheel
> again?

From the comment:

  * futex-ref
  *
  * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of that
  * code because it just doesn't fit right.
  *
  * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
  * re-initializes the state automatically, such that the fph swizzle is also a
  * transition back to per-cpu.

but I leave it up to Peter if he considers merging that.

> Cheers,
> Longman

Sebastian

