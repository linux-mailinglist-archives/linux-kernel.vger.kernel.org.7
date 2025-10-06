Return-Path: <linux-kernel+bounces-842515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B25ABBBCE86
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8833A4E32A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518919ADBA;
	Mon,  6 Oct 2025 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CshzjVQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CE4A33
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759711812; cv=none; b=FutJFn+ExxTpZ+fBgiq7JcRnlZqHONHxukMf8Ue3AE/W6pQmiZF9c2zyeUowlYr4pgpEWt0D9CtFSVzgZaFXPolQPJ7lzDtpOwOH7V3yZAsu7E0tAIU4NTRTP2zlafjrYc8kz88Sr7pCSl3aQZh+W+f+V5rft5wbo9KCfhfEUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759711812; c=relaxed/simple;
	bh=816yCCyZKA4HZjRNvghGdF1sVU/ntYWZfSNbftmcjm8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=neu/FFyB4ALF8Uzsnv7Y6HU656qKrH9AsU223IqI9ycJfz+m9xZBkZJSDb11fBxn6pttryGq3h3MQelNcqEiuLQbk2mc3c0DUMtaeIQTJ7xnY2dRH+MfNabUfPnqy7CxtRNnz4LzCt8MJ///vjtcqQkjYY4LoZuBnvUOewj1mDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CshzjVQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C1EC4CEF4;
	Mon,  6 Oct 2025 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759711811;
	bh=816yCCyZKA4HZjRNvghGdF1sVU/ntYWZfSNbftmcjm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CshzjVQgoET/RUZU5Q6KUG2yg62woPSPLgzBaGiNBAKvVEwiw1QXNe9gIi8AlSX+a
	 JKF4bxKmNZTCFoGMOaZPfEX4WXw8tGqw3w+kHPnhREtChf61r6SGztIWFu+SLgX5wE
	 dg4sZ4pladLYCYZlraNcPJkaPYls+tFKXMCSDXCciMdW74ek+ShSpKD4PRwQ5DXVPa
	 yFqxwpOKPifpEf7/oA6k031yRf+cuRgjDaGmt05CzmKfpmcHhIMoqP8GwriV3WXdba
	 UO9TfYC9HXY7VLjVEMTZzA+8uAlg+pLkgUs1GwxN7z60OhG0vvHvxVh4vk08K18bDM
	 d5ybbl2w9SkwQ==
Date: Mon, 6 Oct 2025 09:50:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, Steven
 Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Update for v6.18
Message-Id: <20251006095007.8369a785f0c10a0fdb00b31e@kernel.org>
In-Reply-To: <20251006092743.295205e486acf1b69ca61b89@kernel.org>
References: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
	<CAHk-=wg6=DwTD7xT3=Zya-ytYrtS2969KtnTWRPskq5fx2Ev+g@mail.gmail.com>
	<20251006092743.295205e486acf1b69ca61b89@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 09:27:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sun, 5 Oct 2025 09:20:29 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > 
> > I wondered why this hadn't been reported in linux-next, and the reason
> > appears simple: none of this has BEEN in linux-next.
> > 
> > So no. I'm not pulling this. This violates all the regular rules for
> > sending me new development, and then it doesn't even compile.

I apologize for breaking the rules due to my impatience.
I will never again submit a PR on linux-next that hasn't been tested.
I'm very sorry for the trouble.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

