Return-Path: <linux-kernel+bounces-752044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B5B170C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A4318835ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8DA2BE05F;
	Thu, 31 Jul 2025 11:55:17 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C649E22D9E7
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962917; cv=none; b=fuRb+bbnQZw4bmyhewUpZyoXER36hxTBnfs+gW4j1xdxwTMB5QmodxJolxHxJjxEOGVm53KrsZK9uOMkGtzKGUrjPu+mitV3d+eLRBfHAc710cU+pl3BRJTuE6L3/S63Bvqc9Sw/e4QCrfbVG/7EukNL6Dj1j/6AT5KTEXPWhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962917; c=relaxed/simple;
	bh=ZNNytvm3IUkbMZTm5Gfc0WFAH/PEON11wT/9Z9Vlt+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URbn+0YFZEY49CneBKhM0Ar7e44GJx0TXW/fl9rrEQCThXRAmIbupqnzic9kKAquKUXqUmZlPets3jgZLcsTi4+cSJGSQ81WFjmx2SwdnIn2aaAUUpH7ExCQVNNjPEcn+iNLpzUxceJJgB9OZTq/O7luzr2ritPU4zvqFVq0A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 48419BB0E1;
	Thu, 31 Jul 2025 11:55:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 845462000E;
	Thu, 31 Jul 2025 11:55:07 +0000 (UTC)
Date: Thu, 31 Jul 2025 07:55:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Artem Sadovnikov
 <a.sadovnikov@ispras.ru>
Subject: Re: [GIT PULL] ftrace: Changes for v6.17
Message-ID: <20250731075525.54cd76e9@gandalf.local.home>
In-Reply-To: <20250731075318.45a2f84d@gandalf.local.home>
References: <20250729144226.6b72dca7@batman.local.home>
	<CAHk-=wh+h2WR6f2g+3HyLD1Zjg-fXC8yOE5bQmetrPvWHCU-2w@mail.gmail.com>
	<20250731075318.45a2f84d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nd9d4n8zq4noj5qzygib9djoqoabbf34
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 845462000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PtJ47nI+czr05uciN6hXp3C9Tzhmn04c=
X-HE-Tag: 1753962907-479812
X-HE-Meta: U2FsdGVkX197ghiRMMO7S+yaH9ohEWPvuaLTSceBIT5XsDNfndLqPJi+FQ0gllb40WtovsCt9ka/SaLbmhVjNZO0+JFTStegcKcp9xCRc4XdJE+8NeetwWDJPeyGeGVyEr/LhOv1vkuvUuESbqgerZwZQvdywvuUtLUoZ6aUATL12fB4sRmfLtFM1XnOP+8hznFmj4nUKkjFAmES1EyRmzdqq6w/bwgrkYQHaIwAoyGyQq7wWO8U5r3YvfSxq23MveHAUzgXFcBeElbHRU8eGy/Dxu/7bhkwK7l7NNy/i3TaJo8ocfNITX/hnsUk4oWKi91KKP/ousXOiUMgNO0u0yqKiNelBSYjC33ZZ8IyE5hHyjyaBM3cvg2tV+PNSWuY

On Thu, 31 Jul 2025 07:53:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Because "sign + log10(MAX_INT) + '\0'" really is just 11 - if you
> > round or truncate.  
> 
> I'm confused, sizeof("-2147483648") is equal to 12.

Never mind, I just realized you meant rounding or truncating the "log10(MAX_INT)".


-- Steve

