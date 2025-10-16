Return-Path: <linux-kernel+bounces-856075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA5BE3033
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3612354361
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409730648C;
	Thu, 16 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b581nttR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212A3054EB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612954; cv=none; b=Xwo4jNpelOIAge6NWA+tm7lrKblCpKt+mJUnJfcK+hl3MLJ2v9iXvm/i9gfvZa+R0kQSSWLf6I3vlhuWKM4JcLP9Prd34u3W51ZSot60wQWZrdP7J94E1/NMncxNe1nzZDQkE07yuv6FZpcRaSIHEaiwm9gxxvjRAjpjzi4oCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612954; c=relaxed/simple;
	bh=DyFXdKIJtSaZzIHhc8DAQo4k9g45sC+S6NNEFpDq338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhFYrI1971SDReuMXScpi7Dmf8U09zyeXJVzNO2qdTljayI2yoxIMhaIWVAzDaCeUel0DJSmfzScEZBOxBB7qU3MTrBpVPCMrMowog5CtZH+H4fGdNpVrJAlTqryXZI3I/eNTQp02dXh+LPsJ6Xv3QSiiGYRNBAuvGU1yHKMfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b581nttR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DyFXdKIJtSaZzIHhc8DAQo4k9g45sC+S6NNEFpDq338=; b=b581nttR4lqlXL3PXUD/qoKwAp
	mOwW52sp8Qf5IjjeZAS5XI2fZrO4IR5iRvYyfLNjTwPFbWhKIqjjLD7mAEfCMbXAn2yJwB0dHjD/m
	VV7XCDAgmrWevcT3VmJNDM2CD+cf4V07pR4PZEeOQwe7wihDXVaznGNDOZF7XMQI3bmqW/Oi6heR5
	nYKLtsCTLRnnUXyue97rPXHv4sn90ftlMSuj8j42VePAe0PCuDM8QflJhwyeIbwIkgVvSeE4j7CcT
	/tzpGQD/w1Y5VXvyBlr6ZnpkgWLl225KWUTIBfiyJDKKDqR8jSQumNGVnEr2x0Zvw45gad2TIvK/d
	Iv1QS2EQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Lqq-00000006hJy-19jJ;
	Thu, 16 Oct 2025 11:08:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 808BD30023C; Thu, 16 Oct 2025 13:08:55 +0200 (CEST)
Date: Thu, 16 Oct 2025 13:08:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Message-ID: <20251016110855.GO1386988@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016103233.GC3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016103233.GC3289052@noisy.programming.kicks-ass.net>

On Thu, Oct 16, 2025 at 12:32:33PM +0200, Peter Zijlstra wrote:

> Alas, some micro-archs have significant decode penalties for >3
> prefixes, and filling 6 bytes will need 4 prefixes :-(

N/m this, because if it has 6 bytes, then the indirect call will need 3
bytes and we're back to needing 3 prefixes.

