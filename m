Return-Path: <linux-kernel+bounces-856073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C03BE302A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E6C4845C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A0330505E;
	Thu, 16 Oct 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QAGxUqGe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EB2E5D32
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612869; cv=none; b=iF0dFUEizgE8oQV3XkPZeaPMl/+OclEfqUvsE3L4FcigvijxROTR8edWVqP/Fe6GjUqNE3UUGcw44xFGuT/oYgfvv8jzaO5bb+hwr7mQQZ2tdvONrRG3Wacm5umzd2eBjL3UVJ8Y9gM6Ilm+0BMYYzWX0MEpUb3P+7nfW31zAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612869; c=relaxed/simple;
	bh=7dj8O24uLX4g6md7oIfAo407Uft0qwTqJcIQGnksRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwQvR3sZPg4Jjh8372K842iPmfX2YyFsw2srerh9wpRGATgn9CeC0CvTfZrbTqHI77q5W96N+S+TTqUpdbVQfBA16J75cO/by3nog+Nw0pk27pLj88jzuuOZSutujVY/TiBmZhJEEGCock8+9y0et6/4Qyl3k2ObJAWzVC+NR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QAGxUqGe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7P0ynkD0cfX8TUGu7t9Y5vN05xKvUUmz128A4RQuaB4=; b=QAGxUqGeUsvPDdIbGZYqBjMnEI
	zT6Sqz06oY/oFCYm46SGCXGk9g+5iMEhZz8NgsUOAuGu4p4jZ8ls6JLp4QfUJuynKr7pQGfcaE2pz
	R4CDGJa0/E2gzD4gOKBaIGE9leMbi1MPecNjMzLqaiCngnovqM2mjk42XQx74wxgBjlZ375nZ4fH9
	S7vjYSagYRG3kMhKqq8U2gIj08IuNdyI9gsgbueuSGx3NNtYngpEbFHtGxCGB3kO0qP5h6FTf1yy/
	facbzJHmMJR9E1r/XT/mTadxBfWV2DMr8KJXT+JtB9atd3OjtwR0/Lx2YSAU9IBZY7A3ThPTzspza
	Dbfn6edQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LpG-00000006hG3-3VXr;
	Thu, 16 Oct 2025 11:07:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D63A530023C; Thu, 16 Oct 2025 13:07:17 +0200 (CEST)
Date: Thu, 16 Oct 2025 13:07:17 +0200
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
Message-ID: <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-32-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:34:19AM -0500, David Kaplan wrote:
> When patching retpolines, nops may be required for padding such as when
> turning a 5-byte direct call into a 2-byte indirect call.  Previously,
> these were appended at the end so the code becomes "call *reg;nop;nop;nop"
> for example.  This was fine because it's always going from a larger
> instruction to a smaller one.
> 
> But this is a problem if the sequence is transformed from a 2-byte indirect
> to the 5-byte direct call version at runtime because when the called
> function returns, it will be in the middle of the 5-byte call instruction.
> 
> To fix this, prepend the nops instead of appending them.  Consequently, the
> return site of the called function is always the same.
> 

So this results in:

NOP3; call *%r11

And you're saying a task can be on the other side of that call and then
return lines up. But what if the task is preempted right after that
NOP3?

Same for all the alternative patching; what ensures no task is currently
having a register state that is in the middle of things?

