Return-Path: <linux-kernel+bounces-872608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4362C11916
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48FBF4E6BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC42F12C8;
	Mon, 27 Oct 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzKO70oS"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6120B212
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600790; cv=none; b=uWgn+DzXyItJY+LjrDbt3ILk/KgoOjiawGtyhoRfDi0Y/dFFpHCXkHQA58uM7WKvv30QbLuB5f0LiaXA4M3AR2MyHfsG5JXUDRtdhdwpi+4K8/BgxaxY5mgzy7FfTqPkcKs7hwJxZrt8TmpErbRUrtcmhrQoqr3B3ltmc6xzHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600790; c=relaxed/simple;
	bh=sBbQTbQPKSUanAmQ9tdI8BR2s7aPePlsLLOyIDmJWn0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ju0lvjgxv0ry7CpUeKlFLU0szbp2tKcvp2YfCLyvrW+EuQ570O3BrCqyldiGO5ap5yY+dxtGHcSH3ZVB4gtEIwGGjDSZFUQK9MLeRy6MQnXwNLd3OYyAxPaAx3lkYZfE6hWQstpSW/1MH/bnjfnhWY7YC9YfCdff/kJ6DIfWwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzKO70oS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761600784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0uDiWR2dsTw63vTiRjdPwLp/5E7dHkXKJ8w7mcTm7E=;
	b=uzKO70oSD/OqLsKGJ/dogaQXFGllCUFBARw+06fJbmoQ/c6+U+ZNz+bo26QmHL7lmwyXSe
	S6sk13JOaJTWvxOFinMowPkaHMqs02ZcPAgSENG3dqjcBiMTyEggLrny2ztUvMMQ7Q6HNY
	B7wPcRIz5WSnaa1Fb0mvUMXoa6CFpGM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] objtool: Re-add resume_play_dead() to noreturn list
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <rpvygldy2s2ybabzsoylbitpn5o7w6vustbox4jd22pwznydwe@6v36xs6vxo64>
Date: Mon, 27 Oct 2025 22:33:01 +0100
Cc: Peter Zijlstra <peterz@infradead.org>,
 Miroslav Benes <mbenes@suse.cz>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CF8E694D-D8ED-417F-967F-E83E34E6CBB7@linux.dev>
References: <20251027163907.184681-1-thorsten.blum@linux.dev>
 <rpvygldy2s2ybabzsoylbitpn5o7w6vustbox4jd22pwznydwe@6v36xs6vxo64>
To: Josh Poimboeuf <jpoimboe@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 27. Oct 2025, at 21:37, Josh Poimboeuf wrote:
> Hm?  There's no "resume_play_dead" in the diff for 6245ce4ab670.
> 
> That was actually done intentionally with a different commit:
> 
> 34245659debd ("objtool: Remove superfluous global_noreturns entries")

Sorry, I must have missed this. Please drop this patch then.

It's a bit unfortunate that this is neither documented in
objtool/noreturns.h, where it rather misleadingly says "all functions":

/*
* This is a (sorted!) list of all known __noreturn functions in the kernel.
* ...
*/

nor in objtool/Documentation/objtool.txt:

"A noreturn function must be marked __noreturn in both its declaration
and its definition, and must have a NORETURN() annotation in
tools/objtool/noreturns.h."

Only the __dead_end_function() function comment in objtool/check.c and
the implementation itself make this clear.

Thanks,
Thorsten


