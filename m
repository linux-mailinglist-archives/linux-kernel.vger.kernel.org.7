Return-Path: <linux-kernel+bounces-671944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5CACC8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E101888B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5B239E7B;
	Tue,  3 Jun 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIXKQ/4s"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CC2397AA;
	Tue,  3 Jun 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959698; cv=none; b=nggnS2AVodFZyWRcErY2BCyPB7RdvnV1mZOaaqceGSlZ9nnNSRwIinKhCgWTQi7rdVJMgybo7hfRSiHX5STz27F5CTSCV/rezkAipH8SZLNGENATFiI+vvlqYWDvhLAQjUOrZoOLtcwAKRvl1b9/Iou3JakxdqsvyWD9A8o8arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959698; c=relaxed/simple;
	bh=vKjEAyP0kSUTIcZ9WL/wEbzkTJ/uFuSQG+yDthfzi/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK1ZN9bQzaY8iSkBmIWNFJWI7dMh0jMRVeKZcg/3xN+f1BJ2obnkRAdN/h9HQ+3BWAFHVOKPUaF9D20ozqDJNnOkd+seOPqxFrIvBM75uR/YS5JJttpQugWpS6QTf3bHnFveyLd78Ak8efi2ZJVSIGfh9WGuipXAhhmTlIyNQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WIXKQ/4s; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q7bZXGcw4slM3udOX0z5ZZ8JDJ02+CgD8trddLc2VoE=; b=WIXKQ/4sPt6JW6axOwckhObOTT
	zoxlHuYQEvBRplH6Km3NjZyhjwy8M37BNDSN/ue2VXswzCuIGpbQzfrRNxv0JnCSJHT2EkNhahQu2
	6uoPA60eJ5yN99w5RP/FE/rLhZLgwHbXwBzyMrpQ/GTsBYF30tV0XjrKwwHuP7IB0GZ6yra+hHlVI
	A1XX8Yd8qPkCUN5umcYqjVmSEIHlIzA3UDNgNu4wqkLIGILhkxTirQq4WIWm9Km3KMpCUqc9LKBJU
	L62FvlH9K2uIptUVj6bBjXvweaLdzo9RJcdvXjbDM+RkzVW17Nn9btRmxJIzdpSVJU0B+a4ED1mVM
	VWUC63wg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSJG-00000000mH8-0Wys;
	Tue, 03 Jun 2025 14:08:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 10DA1300780; Tue,  3 Jun 2025 16:08:09 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:08:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: David Wang <00107082@163.com>, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mingo@kernel.org, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: restore __perf_remove_from_context when
 DETACH_EXIT not set
Message-ID: <20250603140808.GB38114@noisy.programming.kicks-ass.net>
References: <20250603032651.3988-1-00107082@163.com>
 <20250603083304.34132-1-00107082@163.com>
 <20250603091352.GJ21197@noisy.programming.kicks-ass.net>
 <2633d43d.ae30.1973564f5e5.Coremail.00107082@163.com>
 <20250603125056.GI39944@noisy.programming.kicks-ass.net>
 <20250603125440.GA35970@noisy.programming.kicks-ass.net>
 <aD73Hf6Q7rjfCFAC@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD73Hf6Q7rjfCFAC@e129823.arm.com>

On Tue, Jun 03, 2025 at 02:22:37PM +0100, Yeoreum Yun wrote:

> I think it would break if event->state is "PERF_EVENT_STATE_ERROR".

Indeed.

> TBH, there is the patch to solve this problem:
>   https://lore.kernel.org/all/20250602184049.4010919-1-yeoreum.yun@arm.com/
> 
> Does it have a problem?

It does mean we can remove that pending_disable thing from DETACH_DEAD I
think.

Also let me edit the Changelog, the actual splat doesn't really have
much useful information.

