Return-Path: <linux-kernel+bounces-863426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227EBF7D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B3A18C8633
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3B34C12A;
	Tue, 21 Oct 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUk32OED"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E634B681
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067141; cv=none; b=STaZhqK09X6QHzaGKAX+CjV8hKUvaRXU1pbigEn4F9iqNKxpwzl9lhlCGZl6WMtMzpPIXJ/uE3gQfMLZKrWtmKOuRFm9d4E7Mh8vGyyiAgHNm/dT42xTpCXq5tzKaKaRTZAooB0qstoS58F3EpXJc9H7RF2DVmYTW2tdU//udFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067141; c=relaxed/simple;
	bh=hKFTNt2WYF5lClgPeowGyL6JH/q7f2NilKmKdBlQD8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh8MfQ6LPuU3TUk0j+W5CTHaSKULN2CWoSr/3jPSp7PhMwJj664wAdUfcX19ZdYIcS7o4O52N4eUMKH9d4VqCr/COWUM48AzNJG96GP6EbidprC8SQrqROvR1RX9b/vkiwyB9FZ99DRo1EXmjgUgJx4jN70urLMaT0WAw+4JNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pUk32OED; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l4qh635JwtraH9+156UkCtjfpNcMPfZvE9SSt+2WcXk=; b=pUk32OEDfuLKAVrr1q8dOnJ9a8
	PwSCurTdykUHHfA+NCXYfQlN/70nN+hfHl+vySZUOlA2vmVHTuqDK+c21nSMOzQh9Jo8/OrzCe3KF
	Qmt4w1Ke/lARvwRCNuEo9Qt2NyJEW0Sp8D+zRQD3eyv8h4jM6MH4PU6130JLVosbRNXqHVYMW84Ov
	U59Stcn2jmnYqsfpC3nJ5Pomt4w66ggczGhPXI4+Ix2osX1dl0fX8rfRnvS7wBkHycKvoY7uObtIs
	GBjFnEuLbZHCDQgoT/UwSg2RZ0ktSLD2AoDjdNqIZIcqbV6jpCyXi2gEejmkinAo5ZA55s0PCZtOf
	xvzpugXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0d-0000000DsXg-1PF1;
	Tue, 21 Oct 2025 17:18:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7915F3030BC; Mon, 20 Oct 2025 12:28:14 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:28:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] unwind: Simplify unwind_user_next_fp() alignment
 check
Message-ID: <20251020102814.GN3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.497867836@infradead.org>
 <20251001115524.24542fd8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001115524.24542fd8@gandalf.local.home>

On Wed, Oct 01, 2025 at 11:55:24AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 09:59:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> I would add a change log. Something like:
> 
>   sizeof(long) is 4 or 8. Where 4 = 1 << 2 and 8 = 1 << 3.
>   Calculating shift to be 2 or 3 and then passing that variable into
>   (1 << shift) is the same as just using sizeof(long).

I've made it: "2^log_2(n) == n". I find it very hard to spend that many
words on something this trivial :-)

