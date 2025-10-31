Return-Path: <linux-kernel+bounces-879397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA35C23050
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707C21899221
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838E2EC081;
	Fri, 31 Oct 2025 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yCu1hRkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB992271459
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877931; cv=none; b=ehQhR+s0oN/OXodvpnirfJXZLP+QwKEgeermNJCwTKBptNlTGp67ZJg/bUO8vi8BP3Phqhrizm0hQNeYvGL1xqwAorlDw0MnNOPue3n9mxy58ixL9L0GDH2wzt6PS0qXJQN5NA4mAN1Y66UyJFbNDIKls488QvjfPVebprvahkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877931; c=relaxed/simple;
	bh=knTtuIJ12DWZ+DPvQSS+x8bkA+2vUEOhQGD7Z/ID6oY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z3n/pfu8gu4BzSj4KH4TaD3fgrYD33os6X1vc9QXPcIvciqbeTmdTv20Hvb1kaIinJrX81V6hUo2RxfNmOXJ0yx8NRcxuWTNg6ZGypyCdFjVydeQSwRNNX0gXMJtgFKhijCQzWSz+yQvV1ckjl9CMOZL8xS4peQaqLcNW1ieDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yCu1hRkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6300C4CEF1;
	Fri, 31 Oct 2025 02:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761877927;
	bh=knTtuIJ12DWZ+DPvQSS+x8bkA+2vUEOhQGD7Z/ID6oY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yCu1hRkP3JtWkPgt2scPlN2ZhLjGgcfcAutGpiOSiR9xd4P1N5JqgFRbE9lkpoxDX
	 VinSziniIAeVnXZYm/Jok02aeziTi0SZIU7LZ5YRT/bOCWBhFvH35gyn0zdVOq4jUY
	 0dWRAAH2wtWhTRTy0iyuSCdzgJn1OcfGxYXp9P7U=
Date: Thu, 30 Oct 2025 19:32:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix tracepoint string pointers
Message-Id: <20251030193206.22bb773e697b6cc385d5aa67@linux-foundation.org>
In-Reply-To: <20251030155537.87972-1-martin@kaiser.cx>
References: <20251030155537.87972-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 16:55:05 +0100 Martin Kaiser <martin@kaiser.cx> wrote:

> maple_tree tracepoints contain pointers to function names. Such a pointer
> is saved when a tracepoint logs an event. There's no guarantee that it's
> still valid when the event is parsed later and the pointer is dereferenced.

Oh.

> The kernel warns about these unsafe pointers.
> 
> 	event 'ma_read' has unsafe pointer field 'fn'
> 	WARNING: kernel/trace/trace.c:3779 at ignore_event+0x1da/0x1e4
> 
> Mark the function names as tracepoint_string() to fix the events.
> 
> ...
>  
> -	trace_ma_op(__func__, mas);
> +	trace_ma_op(TP_FCT, mas);
>

What could cause the storage for __func__ to disappear as you suggest?


