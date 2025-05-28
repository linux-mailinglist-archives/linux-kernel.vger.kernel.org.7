Return-Path: <linux-kernel+bounces-665804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E3AC6DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 18:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C697A492D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400728C86A;
	Wed, 28 May 2025 16:23:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EC7FBA2;
	Wed, 28 May 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449393; cv=none; b=c/Cqf4d+t9/GvMVYp0MRFHn+XwOMQHpvRBuKHyzyE0xeornDQVHFwX5Idgytqp+U7FIcBNV0xTVrqrBhKpo3UGHaQ2u4rape5GJuhMUapmFpueoYA7xNFnaFfbAB2UMAZlg79g2REMIRtJZ4L1e80IWlab7qVm6ZtTArU0GZELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449393; c=relaxed/simple;
	bh=Ek5rSG5BO1yvKO7gJ/jMRzcJwVl+VmLvPQj0+E6hlJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgZC2y4MCVus/G/Rouxc+dcruLziTKjuXb6C0A00gHj4aJEqSFOwUrEA93cJRvziGWdFRCGDf7qSXRY/MnA3K30+Z9D3AkxAclZkZrsn6a4PV43bMQBYtjBOno4AGYx8LGFezpCRNh/GbAmbR367aL4IyQkIj89QI1US4V0eo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9547C4CEE3;
	Wed, 28 May 2025 16:23:11 +0000 (UTC)
Date: Wed, 28 May 2025 12:24:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <20250528122411.16a551b1@gandalf.local.home>
In-Reply-To: <b694c72b-0873-4123-869c-134709341e19@lucifer.local>
References: <20250411161746.1043239-1-csander@purestorage.com>
	<3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
	<CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
	<20250528114549.4d8a5e03@gandalf.local.home>
	<b694c72b-0873-4123-869c-134709341e19@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 16:48:10 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Maybe reasonably straightforward with a clangd/ctags/etc. backend or
> something to track usage?
> 
> In fact could do a quick-an'-dirty script to grep invocations and have a
> person run down the results to double-check or sth?

Yeah, I have a patch that shows how many static key instances exist and I
test that. But I probably could also add an option to the macro that
creates the trace function to also add something to a section when used,
and report when it isn't. Shouldn't be too hard.

-- Steve

