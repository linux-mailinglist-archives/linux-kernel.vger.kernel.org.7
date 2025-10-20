Return-Path: <linux-kernel+bounces-863421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FFFBF7D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49C8135463E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830E3451DE;
	Tue, 21 Oct 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="spbq5gZ3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EC15A86D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067136; cv=none; b=KaUD+ieHzFqhBqNq7/q7EkuofNMAbKerWjLZt5FEF9vxDD44AToDweWOZIPskzHrGFBXU9s3xDVCBQk9CjKYsnBASGVMx+iz/r/LalCekOBCXJa8Z9eDvRrDHY0Dicf8XOY7IaqM5EaUIKLCFfdkfM8gULGn9KHdd8kn0K8idDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067136; c=relaxed/simple;
	bh=gGTXaUXhCcA4rciTM6g38wYsnCXr2IYstPj3xzyErz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeshNw1YadkoNdOXEEBK8qzY7ccGeYj7+j+XlsQW+XDGBYH4xunuzkE1QfXYcAiO0L4CzA1DG2D4biVNVtiFjlaEsE9LaTJWcYsnCFhyXsWYvgvhUebmcfGJlKlfIRjDFifohuoTqym0/qXvZVqIEu65GD6MmkBa/32N2Ocb5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=spbq5gZ3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xflYSDF/o0chUCbN9VJU8QdpjXxvqz+4v9TFzvXkdls=; b=spbq5gZ3RdOs+wv91cN/Dt2x1v
	9LqjL/kXP+uXtnEt/oUdVWby8aYlDhNIOSWuhWLONCkzbKWBvoZmyOoqnwD+uJdiFGpbH1oJBkFC3
	FDgKREp94b3DLxIUfMjOg5a+Zr8nF0SWQSWJwZMX15zniDBye8UdsWHpZGI6YRmKJ+1GWuO/8sarl
	RwzYHh3LwAnIcylwIg+crJyzn8GKDgx5Dj3po+BCLpR0fM0DxoE/ZOeJff9lmaGsXHB6HyetAqjvv
	GGAlTzYdDvN0IcE9GL2gvpwJ0hjo5IQR9uooIHykPf0st7G2yK3b2KRO/7Z5DhadwYSCZsM8j6m2F
	YBgYVldw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0X-0000000DsJt-0Nw6;
	Tue, 21 Oct 2025 17:18:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A00E3030BB; Mon, 20 Oct 2025 12:20:12 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:20:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] unwind: Make unwind_task_info::unwind_mask
 consistent
Message-ID: <20251020102012.GM3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.384384486@infradead.org>
 <20251001114702.06e2b1d8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001114702.06e2b1d8@gandalf.local.home>

On Wed, Oct 01, 2025 at 11:47:02AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 09:59:57 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > @@ -324,7 +324,8 @@ void unwind_deferred_cancel(struct unwin
> >  	guard(rcu)();
> >  	/* Clear this bit from all threads */
> >  	for_each_process_thread(g, t) {
> > -		clear_bit(bit, &t->unwind_info.unwind_mask);
> > +		atomic_long_andnot(UNWIND_USED,
> > +				   &t->unwind_info.unwind_mask);
> 
> Shouldn't this be:
> 
> 		atomic_long_andnot(BIT(bit), &t->unwind_info.unwind_mask);
> 
>  ?
> 

Yeah, copy-pasta failure there. Thanks!

