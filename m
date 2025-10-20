Return-Path: <linux-kernel+bounces-863434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED6BF7DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B15B64FCB42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362B34E747;
	Tue, 21 Oct 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIBf3JPe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CB34D4C1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067146; cv=none; b=N+J4zNk1YXHoQi7AsHsYz7L5kuYLa07Mg4JKKZ8dP/yMkCMfKXmo6C6JIP3OvuGDDTIfE8LFK/DxgiivPYn4ZKnya9TkIVQ/REgpw6TD29OsQncNme9zGuotY3eM/PKIyl2QC1d9S3L/Og1cDH2mp39OqBiaDgBhR9Jyzj0Wbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067146; c=relaxed/simple;
	bh=m6+dUiE3DWrPraUSUsHn+kFhGCSHnUx/KmGVWp4mBBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VICD5cJdopPVi2Eh6PFDp/aEjnRXnAA0LWq+kLQk/5XxUEnmPvPHMEy4p8OPN9rOBoU6Fvx4JjAz3N4g9aF+1ei6rA/KffzeT/F8+NflP7d14VfcYA/siELnbV+kzbdRASmcKElyRBTgZ+B2+72O9MAvR3f68cLnLyzV/qDSbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aIBf3JPe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+uDXLRGQLn16oeo8u5bcjI8nddmygEmszrhTfMMKEuk=; b=aIBf3JPemxsVzmCwUn/B/+pzow
	AtLAUgVJw6lwEbIBejeix166yqD1ZeZX0ydX0zgaLypHCmKCOyl8aSRNgzsdGNLd+Kx4ji1hicMdc
	5gC4yfITI7bitmpD+5c3mH1+zO7NouWogQfW4n11+tVhTIgR0GGuMY/Z0CSZOE/t7vtYWtXCRfz48
	yYhOzOHgOCu6wxqpyYxj+1oHc56GPbHfTfDjV0922DDcmkkL0ZI5Q31IUQ6yldUBMyzSVM1MyVvOT
	ikET1rA7PMIbUtzxi7SxFYQkhRSiTgJ4Xwg6xottyqCX1zfg6hRMb379Yb0Wp5MVMRON9cKpfD5S+
	P4Z/m4Lg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8z-00000000tCO-48zp;
	Tue, 21 Oct 2025 16:23:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3E64E303031; Mon, 20 Oct 2025 12:48:07 +0200 (CEST)
Date: Mon, 20 Oct 2025 12:48:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: jpoimboe@kernel.org, rostedt@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251020104807.GS1386988@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
 <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
 <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020103940.GP3419281@noisy.programming.kicks-ass.net>

On Mon, Oct 20, 2025 at 12:39:40PM +0200, Peter Zijlstra wrote:

> Yes, this should do nicely. I've made the changes, I'll do a test build
> and then push out to the robots.

Ok, this now lives here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git unwind/cleanup

Suppose this all comes back clean from the robots, where shall I merge
it? tip/perf/core, tip/x86/core ?

