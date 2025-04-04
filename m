Return-Path: <linux-kernel+bounces-588829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ED1A7BE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AB1B608C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618C1F12F2;
	Fri,  4 Apr 2025 13:37:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0861F0E48;
	Fri,  4 Apr 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773851; cv=none; b=DMbdlQRMYVVWvUDKMkuCgMW/C5oAnPhwPRiTsWwbhTBH2v4XKS0BuzAQNl4JLIr6pP+9/Xo6RRRIzlz9esDBVIwvizjVAjvjsKeqssXNvdX6gYxRhB1VFk3N98SimmN9UO3hjkUxdX5rs6MaiX0onaFzGA+nFtJihgPTskIMTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773851; c=relaxed/simple;
	bh=0crlg9CVa208L3y+THC+49CvF+wOGo5V0hcKmYV1HSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgkS/91C1sGXzVKafxgcMrCvAi8lYMQsTVYudlelFQKg+RFASkZTkYLbYDcfu5L22SKEgXfzGwQ4c9NSd33etzDq8/JIS9w6RDzeBE/UtQspSrkZ8jpSQgRak9OZnrlfBGZZHMnkhi1icFtba/a5vtFVO19V2t/W1XYPeoK77tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8416CC4CEE8;
	Fri,  4 Apr 2025 13:37:30 +0000 (UTC)
Date: Fri, 4 Apr 2025 09:38:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Devaansh Kumar <devaanshk840@gmail.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for
 stack_trace_filter_buf
Message-ID: <20250404093837.154d1239@gandalf.local.home>
In-Reply-To: <2e5aae65-316a-48c1-b293-041bfbd1ed80@efficios.com>
References: <20250403191342.1244863-1-devaanshk840@gmail.com>
	<20250403153651.1188135b@gandalf.local.home>
	<CA+RTe_gHo3U-tWM9MA4CMgxM13=biqkqnAbuS5Yuidrono1bvw@mail.gmail.com>
	<2e5aae65-316a-48c1-b293-041bfbd1ed80@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 08:54:33 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >>> -     if ((len = str_has_prefix(str, "_filter=")))
> >>> -             strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> >>> +     len = str_has_prefix(str, "_filter=");
> >>> +
> >>> +     if (len)
> >>> +             memcpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));  
> >>
> >> Hmm, this location looks like it can just use strscpy().  
> > 
> > Yes strscpy() also works. But since stack_trace_filter_buf is length
> > bounded, shouldn't memcpy be the right choice?  
> 
> It's not only about the destination, but also about the source length.

Correct.

> 
> AFAIU, turning a strncpy into a memcpy here will overflow reading the
> input @str if the input string is smaller than
> sizeof(stack_trace_filter_buf) + len.

The old code just read str + len and what was after it until it hit a '\0'
or the COMMAND_LINE_SIZE limit.

memcpy() always reads COMMAND_LINE_SIZE (which is sizeof(stack_trace_filter_buf))
and will read more of the source "str" than may exist. Which as Mathieu
pointed out, is a bug.

-- Steve


