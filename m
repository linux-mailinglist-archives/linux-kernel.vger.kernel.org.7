Return-Path: <linux-kernel+bounces-863687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CCBF8D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A150419C18C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94214283CB5;
	Tue, 21 Oct 2025 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VSgs2JzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AF350A33
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080156; cv=none; b=c+U+MLGViEoYrSuxw9GMd1An0GW2/U31RcZeBIwSfiFSUr6D6G/W+vesgmuyWD8p9YiawWtACfh+Zb3iIGC7iTiWl/qUjZxPTsILZY4m2iAESIW/KNpgGUCtISWAzYpYfADEl+kQL06AzEJSvgAkcOT0SCk2FmwG5KkHPV8uy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080156; c=relaxed/simple;
	bh=vVgTfD/p1RGBzx6BybmkHd+Rqhr/VPoAr46sn9HGhdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M5L7GS6L7DRN5tOFaoBtiX2+lTsbvL1c1OHFj76DGH5PPumnFnJLScyKL0B5ge1Qg9CE2IMaBW4V7mmT5mJfNqyz2CyG3AtesEEKK3Sbia7FTtwlHNyRQDfAj5jeaJvNTRqaM5/P19ts1btAmuFOPblPXJ6n0vekkT9Fs3zFCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VSgs2JzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53602C4CEF7;
	Tue, 21 Oct 2025 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761080155;
	bh=vVgTfD/p1RGBzx6BybmkHd+Rqhr/VPoAr46sn9HGhdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSgs2JzPcxjeE5GLUOdsgNXRTFW3JyMO8Ngg87lJM2mG6NrabjdY1KQxoVlNcf9Cp
	 2paONoZ7GrbSyR/ewiTK4v9t2p/HmAZYLIsQQgACO0USyrPtTx6gx9Y9S/EbIwmESD
	 rzmevsxCqIb7eVTcszLPHtRXitC00gEmzOZ5IXw0=
Date: Tue, 21 Oct 2025 13:55:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst
 <brgerst@gmail.com>, Christian Brauner <brauner@kernel.org>, Francesco
 Valla <francesco@valla.it>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu
 <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
Message-Id: <20251021135553.811b77539d2d41fff3c3b992@linux-foundation.org>
In-Reply-To: <CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
	<20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
	<CAD=FV=Uzp_Pi_q5YRbRi3FgdiCy1HR3g6P72d92dbqAdLyWuRQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 13:00:22 -0700 Doug Anderson <dianders@chromium.org> wrote:

> > And the code would presumably be much simpler if we simply chunked up
> > the printing and spat out one really long line.
> 
> I'm not quite sure what you're suggesting. Before my changes we _do_
> try to spit out one really long line, but then printk() silently
> truncates it for us at 1021 characters. Re-reading your suggestion,
> I'm not sure if you're suggesting that we improve printk() to handle
> lines longer than 1021 characters by chunking them up, or if you're
> suggesting that this code could use "pr_cont()" to chunk things up.
> ...or something totally different. ;-) Can you clarify?

I was suggsting the latter - emit these really long lines via repeated
calls to printk().

