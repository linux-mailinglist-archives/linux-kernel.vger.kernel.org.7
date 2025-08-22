Return-Path: <linux-kernel+bounces-782707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59CB323EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EBB5684CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9F2EBB81;
	Fri, 22 Aug 2025 21:08:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD1235355
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896888; cv=none; b=CjemCBZvKnppb1lS5HUiYx+/wxDVLvReKlrnf33epgMXqXX9eK6043WuPVu0HO3W0yEzj31tcYRIW+GlO6nV2EXWRHTLS0vupXbzZ+5cmqvMOnxUQSlIaYJPrYKvCT7QVdPCeyWPEIrhW0Es92Kcw8niPb0E8ql/Rtbda9Gv/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896888; c=relaxed/simple;
	bh=MN2DMr8LKhn7b/PFBhgp0TI/iKOTgoOGkngk7pYLzoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADHpicx9iBtvRpH1LBfeSxV+sa+HWGzbN6ts2WMW8C69qGIQPiL5os/O3IJLkoenREi976OTLXd2KsOCy7EG0rAlHGLYU/J5b+BbfQ7MyNIzpkWQdYZGOt+oImFfAnu6m7jx2nl1XfGYfDDQtT+d09KkNC6dWlgE2Qz6wmY4+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4C61B160360;
	Fri, 22 Aug 2025 21:08:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id DBA1017;
	Fri, 22 Aug 2025 21:08:01 +0000 (UTC)
Date: Fri, 22 Aug 2025 17:08:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Liao
 Yuanhong <liaoyuanhong@vivo.com>, Pu Lehui <pulehui@huawei.com>, Tao Chen
 <chen.dylane@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, Ye Weihua
 <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822170808.5ce49cc3@gandalf.local.home>
In-Reply-To: <20250822192437.GA458494@ax162>
References: <20250822124933.74965607@gandalf.local.home>
	<20250822192437.GA458494@ax162>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rur6kjurok75pxwiq3qqx7qisrk45gzc
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DBA1017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lHkUqAT+huSRGxRczBMMHAz/iJUTzqBc=
X-HE-Tag: 1755896881-722925
X-HE-Meta: U2FsdGVkX19NtwEt/TmrN3FxN123ST9+qCwUo3JqHcdvI49YGxVtogLOIlQOPsqQ1civwZVZzhPF9DSP2uNUz+q0kdpFCszSVgVPCdd9XNqnPELhLMwvSzckYOuRsN6erzjuXpYCbWfwJYab9mcyrJnWIrjGb9GFLEp9/UZBL2k2q6s0D6nTbUH7FXV9YBEWP413p9Sj3tNgZBoQC/S5DuTK5HomalWNdjUoZdt1vg68WpCg9b+RKZ7KZhQ5L7MKtlC0y8c1z3ko8Z6REifQxk/OsaH77A2+V5d6zITG80lYUCva80m6BChdFUkMh3yT5OGE926m2r/dMtUWDeuikP6WBAXZpUYcY7qpwuS1LL87mQqVEDg0vA==


Linus,

Hold off on this pull request.

On Fri, 22 Aug 2025 12:24:37 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

     ftrace: Also allocate and copy hash for reading of filter files  
> 
> I just bisected a crash that I see when running LTP's read_all test
> (which I have statically compiled at [1]) on /sys:

Thanks for the report. Hmm, this passed all my internal tests, but I don't
run LTP (too much setup).

> $ dmesg
> [   62.221518] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   62.222457] #PF: supervisor read access in kernel mode
> [   62.223068] #PF: error_code(0x0000) - not-present page
> [   62.223720] PGD 1076a2067 P4D 10fe33067 PUD 112688067 PMD 0
> [   62.224436] Oops: Oops: 0000 [#1] SMP NOPTI
> [   62.224939] CPU: 4 UID: 0 PID: 1145 Comm: read_all Not tainted 6.17.0-rc2-00006-g48d06e78b7cb #1 PREEMPT(full)  ab6dff6fe4772c3d341055188b1594d9637c1b0d
> [   62.226579] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [   62.227561] RIP: 0010:ftrace_regex_open+0x153/0x280

This is a big hint.

> [   62.228177] Code: 48 89 04 24 e8 4e af ff ff 48 8b 04 24 48 89 c7 48 8b 00 49 39 fe 75 e8 48 c7 c7 80 b6 55 ba e8 93 7e 10 01 48 8b 45 50 eb 0b <8b> 3e e8 d6 bc ff ff 48 89 45 50 48 85 c0 0f 84 fd 00 00 00 41 f6
> [   62.230434] RSP: 0018:ff4bded7c4e5bba0 EFLAGS: 00010246
> [   62.231052] RAX: 0000000000000000 RBX: ffffffffba728660 RCX: 0000000000000000
> [   62.231983] RDX: ff172e52cc1b2180 RSI: 0000000000000000 RDI: ffffffffba728698
> [   62.232852] RBP: ff172e52c44f3500 R08: ff172e52c3db6c00 R09: ff172e52c3db6c00
> [   62.233725] R10: ff4bded7c4e5bb88 R11: 00000000ffffffff R12: 0000000000000000
> [   62.234594] R13: 0000000000000000 R14: 0000000000000000 R15: ff172e52d45d1240
> [   62.235465] FS:  0000000000449778(0000) GS:ff172e5674a92000(0000) knlGS:0000000000000000
> [   62.236433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.237110] CR2: 0000000000000000 CR3: 00000001144fd006 CR4: 0000000000771ef0
> [   62.237968] PKRU: 55555554

> [1]: https://github.com/nathanchance/env/raw/a98b8aa3a7017f6b1d94ee26dd217a968da81dd1/bin/x86_64/read_all

I'll try this out.

> 
> If there is any other information I can provide or patches I can test, I
> am happy to do so.

Can you send me your .config file?

Thanks,

-- Steve

