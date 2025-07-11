Return-Path: <linux-kernel+bounces-728090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F2B02395
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173CA1894806
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FB2F273D;
	Fri, 11 Jul 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OeejoXNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AB2F3651
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258282; cv=none; b=oBzvuw0EkPGNJUoLcRm4s2t2gYlMNG4cJX/t/qSZooS0zWvttdSVYah+UUG11LfIBDnFBEMuByHqzHkbob1OXVjmN194jXQsN3eUozGgGrXs0cyEfb+21CAssR10CX0fZBujPvg3wJcCOXhCQK4Wg/BqQzzMjA6F6p5fDktMFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258282; c=relaxed/simple;
	bh=l6MitHX7dsL3E19/H/X35EuFSaxCO3Hf46keafOAWWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc/a1B0x08gwc9g+RD+xn2BS59kCOCTkrBITw216Wif+kitH+nbWP1N9HofU3p0Kty/sxp1AmdsbCs+M5FHJnrDlZEdWWBzOfQxWc9t4wYnG8FRdomHF0dq3Ukaftl3bfLTMJfw1GLRPpgxzJoOnXa/IU/N0REl2BNfKw7VjGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OeejoXNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154BFC4CEED;
	Fri, 11 Jul 2025 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752258281;
	bh=l6MitHX7dsL3E19/H/X35EuFSaxCO3Hf46keafOAWWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeejoXNllaZHOLTbGwmgS24gZqz+qlP/bna85GRMGhV4xxMjzKGkivcuYuckPFdJR
	 e0G30uHlvIEFp3VsCCIdJ6+6wQIolz1+ooyKfEq+SKDfgljelQNTNqb7GqvNcXw/Yq
	 8ihvTn5ftEw7ZRjlQaCRY3bMJgxq6Z4xWBcYiIDs=
Date: Fri, 11 Jul 2025 20:24:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <2025071104-amnesty-flashback-b883@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <2025071124-cola-slouching-9dd2@gregkh>
 <20250711091734.5632dcf7@gandalf.local.home>
 <2025071127-reunion-residence-c0f2@gregkh>
 <20250711133240.0d5b6de8@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711133240.0d5b6de8@batman.local.home>

On Fri, Jul 11, 2025 at 01:32:40PM -0400, Steven Rostedt wrote:
> > So get the lttng code merged into the tree please, it seems that you are
> > the one objecting to the merge, not me :)
> 
> It was actually others, and it was years ago. Perhaps we could just
> accept the LTTng kernel module as is, as a module, and leave it at that?

That's up to the maintainers of the subsystem where it would be, not me.

And that would solve this problem, so I do recommend it :)

thanks,

greg k-h

