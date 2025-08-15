Return-Path: <linux-kernel+bounces-770771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD8B27EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5794605314
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741802FFDDC;
	Fri, 15 Aug 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fiuzuayc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E481A314E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255554; cv=none; b=h8VL3ol/qA2HZrqZZ1wFX2ZzwFkTwFb6wjStRgc2zDJfmdz9wrefdezLZnS2+J0sPt3EUSb2DllBIK0G9uAgrcyCJdpS0HlHUmPxMnZSof8ruFFFgLWNC8FjAjEiygIhE4EG47VgGxt6ri2GSa/t8jYTplg4E6yXZQ6SHcXq1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255554; c=relaxed/simple;
	bh=g0/O1iYV+SZ8B/ewpSUxw+zPzI1yvyyAsucYOb1skZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+fXJKIufU2BMorLdN/pc9JFvYhSKjQemDUY76+PMZ2fLZmAMDewoP0eDNtJfRn5QkL+L2oqNMZ3AEV2vpwLQHki0S3qEnAmdFob64qLJjTHZTmtdq0Bq9MpOhVKxeF3/EEE4HZM4ea1J7gzC6AqCKAyNLonMn53cij4c91C37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fiuzuayc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xEYKs+AWtTrvQAx9SeWmZ/00cM/6CAdp0sRjPofAC/k=; b=fiuzuayczJS+Z/C7Bci5K50RMb
	3rElw6OaiWacdOq8bIbE+8JNAJYsggKicDjDv2DkZ5sSLvtNbEl5g4/QwpVcpj16FRsZYseRNQoAL
	PjkoCz8HqyX+2oV8C1expR59hta+WwAsqDWBoRNkZic4y3LugPJunwMIrkhFWEKvFtAU5wunqVxhG
	ezIJs11PAD7l05j0heHWPDXwVEjq8/Zg51vpLBsK4LL7Fz7sv8DfPb3C3KFXgK/D+l7UQaBJMNvDB
	Ua6owOzZeqydVKNoNtvHyyMiLlflMjdGOc1CCplPn9wnhuKq4DkYkSR9NgqSFCVv2AgSxjOinMsed
	QF4KHcHg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ums9N-0000000Ggds-3Esk;
	Fri, 15 Aug 2025 10:59:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 125DE3002ED; Fri, 15 Aug 2025 12:59:09 +0200 (CEST)
Date: Fri, 15 Aug 2025 12:59:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kees@kernel.org,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, samitolvanen@google.com, nathan@kernel.org,
	alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250815105908.GB3245006@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
 <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
 <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>

On Fri, Aug 15, 2025 at 11:43:11AM +0100, Andrew Cooper wrote:

> >> I've had to use cs prefixed jcc.d32, because our older toolchains don't
> >> like the ,pn notation.
> > And then I forgot to move that cs prefix around in the bhi1 case...
> > fixed that.
> 
> Dare I ask what ,pn notation is?  It's not only the older toolchains
> that don't know it :)

Some fancy notation for the CS/DS branch hints.

CS Jcc, decodes to Jcc,pn for non-taken
DS Jcc, decodes to Jcc,pt for taken

