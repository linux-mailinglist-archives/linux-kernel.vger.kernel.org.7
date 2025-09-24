Return-Path: <linux-kernel+bounces-830360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D6B9978F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EBA325B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172B2E03FD;
	Wed, 24 Sep 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZdVUEBnV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BD2DA775
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710667; cv=none; b=JMvN0hNTDN8azZIc9LqXEFYZwG2Tz8IJOTjxQjig/nEAe4iDEZ8pq6jhkYdILdGUTtltgTdXiNrpsHX8yU05b+rYoqBrp6Lliqz4dcqZVZ/FXxWdw7t3IeS38HbuVn8TleLQd1YVeHsQ6liIszE0Uu+MZ7f2hksQk6rGOY5O6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710667; c=relaxed/simple;
	bh=wjxtcLqkggqlpZtAEiP32IXoGz9ksumtGL+ib7V03Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsHdpwwxftJhHFpsUwW6Rd1sqCfO8oHmnQmk2y9PmzBIhdrHGa1cPWmAEHn2g8XL881JZq4/L0nMNQxGnmhaf0pUp5icw/2LMWSp7F0n9wYQ9Uc46hRHO8XyMGu2+EwNvQO0sIYFv9Xzj4ViCg6c5YncRFoOfA+COQIWfo5PvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZdVUEBnV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T6gD5Zhet6ps9VzKfUks1YYByvPoKk+GPTXPQngFIMo=; b=ZdVUEBnV8gnO1kGO9SLDGJm1U9
	3zYt6NWSyWFsZp9nlrqyd16qpr2gCWAXBiaVv51BXKp5cXcyvmuYF+o2dTiWKk55NPmDZHod+s4qc
	SEugE0AhmE15HBp0LhRRJOGdF4tlEOiLu0/VaAcwqKFqBUPjcxX2nXiHpXhy17Uk29+ZXUPUV7Cys
	ZocHj7S4Yqs1RYVHolRNjW88msysjeWTl8SKXgBvhO3yp8kIRT3kBXdS7sVZI+wyz1FWguztkgETw
	mSF2LxFkCKFp8Ayhdrt8LWLKdhwJ2e6LsyoL6mbbZUtLexTWhD/clV98nx75y2QpqJkYnA26CasO+
	ONATtAFQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1MQZ-0000000DJIF-2Tc5;
	Wed, 24 Sep 2025 10:08:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B6EC30033D; Wed, 24 Sep 2025 12:08:47 +0200 (CEST)
Date: Wed, 24 Sep 2025 12:08:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
Message-ID: <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074206.GW4068168@noisy.programming.kicks-ass.net>

On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:

> > >   d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax                                          

That libopcode is 'funny', isn't that typically spelled "nop" ?

