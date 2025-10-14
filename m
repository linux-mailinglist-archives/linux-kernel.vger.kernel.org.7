Return-Path: <linux-kernel+bounces-852093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB4BD824D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF64F85CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D030F93A;
	Tue, 14 Oct 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccO+i3rs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1C2DF6F9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430138; cv=none; b=sYGk9Z+yh4ccQ+oXM94mxF17XXLhzUGcCSGIbZqbL/KFgPg8hJLIxL0xyp+F5srdGKrgc/qy8M9tXu/5fKa7OHxgWfh64CYJz67afbjVZU0ZIly0eKQsbNlK8OpTc/+BnU6Dox91l6DTLcm7NykHRzqQKZOdJ6FaoHQ46S4CAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430138; c=relaxed/simple;
	bh=Spkjo3C5fEKztwgAVnODaBE9rlq/SBhyiTBYtnq2HSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwqyRQCLwGiT4kS0Jci18018sbBJHk9gRvR8E74kpF7SM5OaJgRMqp1emQA8UmJUwqdV9cSRfrnw+gUkpNdLYC5t6TACHjU4t07gFwLYSStylcGXiCHnj3S26R0f3I4zUdRrIAFmxGPXGJzEoQPIBXIJwHYXcRc5jPB+6pSYXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ccO+i3rs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=05i6rH8J2oLuwV/rA7IKRW9HHCCjCwweewhrFbHXQnk=; b=ccO+i3rs/wykBkUNsclWihZt3d
	JI+rYBbSeLXr8buXHaIq5TL+kueballsGIWm8FvVtMmHwEO+5RVXtGzlC7L0LYzOQn0Sqqwyym6lT
	xwcN/+2VAOQmi4ErEqVyJPFv+swC/s7cc2nlrL4Ghvfh7/IhpVc2GYKkjiMGzcQDP5Q7+vMkAh6d2
	z9Mm4mso1H5IL7MZk4j5/5OhoHhwURdRaJJvfIOyJi2NxFcE7o1j7Z9pgn90/OH0WaPbw/c0HkpO9
	vk5H4qICKegEjQ4yOIToWZctXWRU592kaE5IzepjnSSKRyUJg8NvmmuEnjxpTv06MpXi+yvp6ekMf
	Gxo/vvYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aIL-000000052K6-3eOl;
	Tue, 14 Oct 2025 08:22:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3BDBF300212; Tue, 14 Oct 2025 10:22:06 +0200 (CEST)
Date: Tue, 14 Oct 2025 10:22:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aditya Gollamudi <adigollamudi@gmail.com>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com, kees@kernel.org,
	mingo@kernel.org, ubizjak@gmail.com
Subject: Re: [PATCH] include/linux/atomic: fix typos in atomic-arch-fallback.h
Message-ID: <20251014082206.GN3245006@noisy.programming.kicks-ass.net>
References: <20251014011351.88032-1-adigollamudi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014011351.88032-1-adigollamudi@gmail.com>

On Mon, Oct 13, 2025 at 06:13:51PM -0700, Aditya Gollamudi wrote:
> From: Adi Gollamudi <adigollamudi@gmail.com>
> 
> Fix typos in comments throughout the file, change "occured" to "occurred" in
> include/linux/atomic/atomic-arch-fallback.h

What does the comment on top of that file say?

