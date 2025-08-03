Return-Path: <linux-kernel+bounces-754503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31DB19502
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196F07A5DE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9C1DE8AD;
	Sun,  3 Aug 2025 19:35:54 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5968C2C9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249754; cv=none; b=rt6g7SbTYuijS2cjbwoEzEc3OiaugC0OubC2fVzTmCzLdW+c4U5aRKf2nKaauuX1yMIJa3DBQTGoB/Sj7Jw3iNZiPusrV1/TRmYXi8i5uWofoxOpeHM5EjFfUHWW1faVFjSQai30Nz4wO6EpOOfptTZa1LcPAynKTzFgR4Pu0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249754; c=relaxed/simple;
	bh=O5bGdlyKzq7PEHXAHNamM4nQF1j1XjnCQYWGGYYsKaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvozN/AW1CBmGnzwref3JpMbpU5NNTup5h2Wdu9y3FMAAZgjDpev9u8IWjj3fL7jTxkyJwqOn320hqXRPoAYy0lgSvIW1mqCDWz6A+xe6rg4GTd+z7YE23TPS6qjAcsjW3KGd+bYlS2QIKMNimct9hYhKGKpMtNNwbp/HEgDbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0CA2BBB6C9;
	Sun,  3 Aug 2025 19:35:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 9818E20029;
	Sun,  3 Aug 2025 19:35:41 +0000 (UTC)
Date: Sun, 3 Aug 2025 15:36:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
Message-ID: <20250803153607.2bf1b32e@gandalf.local.home>
In-Reply-To: <20250803152411.7fd91614@gandalf.local.home>
References: <aIcdTI3e04W_RdM_@gmail.com>
	<CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
	<CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
	<20250802154645.52712449@gandalf.local.home>
	<CAHk-=wi26+UnKf59XjPbGssqS+quapnED1QGNW1mVDtEiuakdQ@mail.gmail.com>
	<20250803152411.7fd91614@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9818E20029
X-Stat-Signature: k4ktc6r9knr3juhfo5xry8mkeb5imaik
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ohwmz62V5GLJefXU187ulryQ/W/a2EOk=
X-HE-Tag: 1754249741-623381
X-HE-Meta: U2FsdGVkX19jgCD0z+0rUCVQ20NyooQfLUdla1DxrLfeiMx9ShA7wp6/jQHzaIZ6bnpmLGN7MI2ZQy9B0fw7oaLR6LhKnXAWhLQCjaLVnTKKDEQ92UfC9SoDaXhdZXiYkB2WCA2stZavc6zxf7QWtkystfQn/fhMEmqwmgQI2UmEPOS24SgCwHQ5DWO6CLmQxhFaKvnCsZdBj5xd5KHBx5+vSUC7KQMlyE7vXwLnzYZLbXS2H7OCu1rviNue1+qATZzWMbt/VhcH5JL8ti+Brzil4Myi7m9ciqSU05Cfk2Lrh/5lxwKvDHudGfcHMIoQ8SDdbNQy2W3eeGOpNNm++jcOAvzOsk+d2bWMMi1VAYZBiHNYA+g9QPBrmYwFh9QW

On Sun, 3 Aug 2025 15:24:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If your machine doesn't clear the memory on reboot, you could use the
> persistent ring buffer too:
> 
> Adding to the kernel command line:
> 
>   reserve_mem=20M:12M:trace trace_instance=boot_mapped@trace

You can know if this works by adding the above to the kernel command line
then boot once. Do a reboot, and if the second boot dmesg has something
like:

  Ring buffer meta [0] is from previous boot!

You're good to go. But if it has:

  Ring buffer boot meta[0] mismatch of magic or struct size

Then it likely will not work.

-- Steve

