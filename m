Return-Path: <linux-kernel+bounces-838745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F90BB00F2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71783A758F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BF2C0264;
	Wed,  1 Oct 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UBJUsa6Q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122F2882D0;
	Wed,  1 Oct 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759315868; cv=none; b=HUWavTw1TACmM5MDan+/MAdVhLXYRvzomPuLSfwvt6tMQCrc4FNIUonLReXuCfpET0ark+ahyblfUhX5SDa+UMnRQ0+QB+X0U6Ftw0ZJDXzW6bSvrSq/WSzZudsXJtGiLTQmbpjG9BdVsk/w4fO3wN4HK+t/k4D2V33swKxXgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759315868; c=relaxed/simple;
	bh=7d1TeNea7S49qLQyujGBn5BCTJqyxTNSV5DhIggSMt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkLEJD7cg/LspYEZtemfdS/bE6lpUiXpS1+B6XzDLey7R1lCkbDAI1m8imEzQYNycbiAes9oydcjE10ZRbB7GY5m1o8rGXAp6nhl1JC8bSyWP870E7XSctYIdKZP9o28ca6BqN+DuuyZums+zQt1anb2u6jOzfd0OqxbTzbjCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UBJUsa6Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7d1TeNea7S49qLQyujGBn5BCTJqyxTNSV5DhIggSMt8=; b=UBJUsa6QCfYotDZmcOY5GbdOEi
	ZwsBD0brmBo8bH5T88CyeKJC0fRjs0ym6f75uCWKWjN5UrinRG959Mds4ZJEWJQHVB5wdgOI8NXWr
	rFK/O/ZQfkjseOHJQrgN/oCixepYXX1/GgwncG+3M/hY4u5Fy5/5NbLtJNuBtZu1KPXirCsvHJL9y
	GQaherlvkyQVq6sQuGmrE3j94n73MaG3vW5JwsEbbf8TwugbbhIvGnjN8oMAYihx7ktU2EYxPlMBZ
	Bh+KMVz1Rf9UsSnYg97C7royMdX8Bl89N/BF+uGjJcSPx4E4c4Lhpxbwb4vzh2bCnFzluD4i1B9Im
	PmTecqFg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3uQE-0000000FJaJ-1lBV;
	Wed, 01 Oct 2025 10:50:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D810300328; Wed, 01 Oct 2025 12:50:58 +0200 (CEST)
Date: Wed, 1 Oct 2025 12:50:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for
 WRMSR
Message-ID: <20251001105058.GP3419281@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-10-jgross@suse.com>
 <20250930083137.GH3245006@noisy.programming.kicks-ass.net>
 <2df26cc0-53bc-499c-8c78-bc24fd8bf882@suse.com>
 <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b2e07601-80d9-4a6e-a60a-6667d679494c@suse.com>

On Wed, Oct 01, 2025 at 10:49:31AM +0200, Juergen Gross wrote:

> Thinking more about that I believe there are additional problems:
>=20
> Having overlapping alternatives not starting at the same address will res=
ult
> in problems with length padding of the outer alternative in case the inner
> one starting later is extending past the end of the outer one. This might=
 be
> possible to handle, but it will be tedious.

Yes, this must not happen.

> Using your idea with pv_ops could result in the inner alternative not bei=
ng
> at the start of the outer alternative AND being not the initial code. This
> would result in patching in the .altinstructions area instead of the norm=
al
> .text site, resulting in possible loss of a patching action if the patched
> area would have been used as a replacement before.

Not quite, the nested alternative was in the orig_insn part. So it would
result in patching the orig text twice, once from the inner (which comes
first in the patch list) and then once again from the outer (which comes
later).

> So in my opinion allowing alternatives to nest without all inner levels
> starting at the same location as the outermost level would be a receipt f=
or
> failure.

Certainly tricky, no argument there.

> I think I'll write another patch to BUG() in case such a situation is bei=
ng
> detected.

Fair enough; we should not currently have any such cases. And going by
my attempt to make it work, its going to be really tricky in any case.

But please put on a comment on why, which explains the constraints.

