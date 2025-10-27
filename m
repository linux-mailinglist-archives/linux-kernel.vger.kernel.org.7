Return-Path: <linux-kernel+bounces-871597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDAC0DB01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4EA1897276
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D424C07A;
	Mon, 27 Oct 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGjxZx3/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69223C505
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569461; cv=none; b=LG/FVWjtQm+nwgwnwhovyti1mN5atCErzezIewcxgR5e31VjkgXShIL8mGxwZF7Bv699zYsxDwi324idGGZ+zOsfFppojqvoA4Efkz6lwFAUavM8WpLygidebMFMuTpOia9mGJrLb7E23/aTtaQst+xqbtkesiuBahk5ukT5s4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569461; c=relaxed/simple;
	bh=DOut9GYBE3T0yz0hxdBuqR2nWWUwsfkplM3kyjCBsN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Ikese+bpNUP2ZEoR7vwl3Lg1bsCWS1L8vaqL9BhsNzyDByEuzaPeF6aeaHxKv1yWyDA7P3pxB4659nrPFREUFrFPSKDluNLCO79mzYcXQRJ7J+452/j30HNOfto9kc06Gg9kN/jdsyG7PdsrygzpVWRD+fLmBsGxOHE01/YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CGjxZx3/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hl4xvErgX9hTNcEBxBhZNslwe7rtmVmXGGWWtRm0hN8=; b=CGjxZx3/ErP8ynBi6he1xuXTzR
	zJeLDN2lo65KNG65FM3wKfI6T/eBFmH5pbR91Am2uodncuvJNJm31rlMVQ+5etWX4T3DfZurLYmVA
	D3XsxxM0d/LCSRBkxzYf9ocCP02PggWXOwxgAcQng76vdnBcIz2gCBh+5jbHLVJ4WdU21Ej0DNIEd
	SNC/zeKBfXWb8/DYR7gMotEN05voWD9ccRAzPv29TV19gTsAmeYYnnFe3FxEUk4RF+zm6dLC2xvpl
	hmLGXuMSSEASsF7uk7yWbYO58/xUW4keMHpsVz952ZlocVc/Y7K9TaeHElJ3LBgvbAMkBDAy77vHS
	iR3ZCDgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLog-000000026E3-2dC7;
	Mon, 27 Oct 2025 11:55:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7943E300323; Mon, 27 Oct 2025 13:50:45 +0100 (CET)
Date: Mon, 27 Oct 2025 13:50:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: x86/smpboot: Question regarding native_play_dead() __noreturn
 warning
Message-ID: <20251027125045.GX4067720@noisy.programming.kicks-ass.net>
References: <47A8B84B-2685-4DA2-B39B-E55812374426@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A8B84B-2685-4DA2-B39B-E55812374426@linux.dev>

On Mon, Oct 27, 2025 at 01:23:02PM +0100, Thorsten Blum wrote:
> Hi,
> 
> I just came across this comment in arch/x86/kernel/smpboot.c:
> 
> /*
> * native_play_dead() is essentially a __noreturn function, but it can't
> * be marked as such as the compiler may complain about it.
> */
> void native_play_dead(void) {
> 	...
> }
> 
> and when I mark native_play_dead() as __noreturn, neither gcc nor clang
> complain about it.
> 
> The commit message 2743fe89d4d4 ("x86/idle: Disable IBRS when CPU is
> offline to improve single-threaded performance") says:
> 
> "Add a comment to say that native_play_dead() is a __noreturn function,
> but it can't be marked as such to avoid confusion about the missing
> MSR restoration code."
> 
> Unfortunately, that doesn't really help me either. Can someone explain
> what the issue was and if the comment is still valid? Otherwise, I'd
> like to submit a patch adding __noreturn and removing the comment.

I'm not sure either, it wasn't there in v2 but appeared in v3.

v2: 20230620140625.1001886-3-longman@redhat.com
v3: 20230622003603.1188364-2-longman@redhat.com

The difference is that v2 tried to restore the msr after 'play_dead'
which is silly, since it would never reach that code. v3 removed that
dead restore code and added the confusing comment.

There is a clue here though:

  20230622054053.uy577qezu5a65buc@treble

Josh suggests play_dead() should be marked noreturn (which it is in
current kernels).

Waiman then replies:

  921e1b98-af36-1f51-5abe-dea36425b706@redhat.com

which is utterly confused again.

