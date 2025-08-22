Return-Path: <linux-kernel+bounces-782741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4FB324A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03C61D26A49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D3B25C802;
	Fri, 22 Aug 2025 21:39:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871821A9FA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898798; cv=none; b=bv6V18m59F/wO/bI3vikPSnrS0zIAg1vjRXTO6xmcr1mOp5VsKYw+A0lNghOPZyTT/Mgbh/Jlvdw+ziBWkswJALEphemMdUZ6Bss6F1azKwrfEL3MX8Di9ESUNGmlMsXXJ3nFbCjVnQAOyVYjKkn+yEzVbnsHw6xYVVfdUp0nws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898798; c=relaxed/simple;
	bh=adRzEDoWjL9iXjOyshvGLiWhLGDQ2jTJftb8fjQyvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPDvtSdACEkHJe3xusroQeuIq1P7lYKFTar0RBNBEt/MJ8U0RFF3ov+k4J3UOKaki38bO9c13uYz7mHIKHxgl5inVKj/SJFdtKnm3bdl7LUZOvmLaGiJaHzp59eaZnq1NU5lWmtRsrJCsA4jDI3CRivUDYLUA+PZQU+olpEK6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 952FFC036C;
	Fri, 22 Aug 2025 21:39:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id F12956000F;
	Fri, 22 Aug 2025 21:39:51 +0000 (UTC)
Date: Fri, 22 Aug 2025 17:39:59 -0400
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
Message-ID: <20250822173959.72e636c4@gandalf.local.home>
In-Reply-To: <20250822212311.GA1629566@ax162>
References: <20250822124933.74965607@gandalf.local.home>
	<20250822192437.GA458494@ax162>
	<20250822170808.5ce49cc3@gandalf.local.home>
	<20250822171637.7ee1cf7e@gandalf.local.home>
	<20250822212311.GA1629566@ax162>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F12956000F
X-Stat-Signature: 14s4f7imiafaa5i8f44enrtuhbj5j6bn
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AxkqOVL02jTNCdHWfePNbOOSmzAhG+2Y=
X-HE-Tag: 1755898791-203665
X-HE-Meta: U2FsdGVkX1+98YzwJve4V504oIvX9Iy5AT94jK2ZsG3QXWApGYmYVWPOs1k3cegx0L8U8SzL9r8gYNHQi0iE3I7CJFiPJZLqte9SsoEaSRahCmT+rj+zCOiDfEdX6NijPV8otXHiVjBn9e/jl/6l+c8hNfanSJuqNjivlnQ5uAHn3NG3dz2FYCFx5jpVic1E088O8zIWKZfNPOzXMb5J4pRTUpIxE3E2tKlC/VJs3vbl/knmgU9xCk23tuMjGqTqtPsu/VenIsCfdOV17jTrFmSG+8lwYSpr/RHmsPevoAkead7WH39eveediOX9RsqctUypQoE+hTKi4F5eYazhEzoQnMHwkT4K

On Fri, 22 Aug 2025 14:23:11 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> > Actually, can you see if this fixes the bug you are seeing?  
> 
> Yes, it does.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Ah, that patch isn't good, as iter->hash must be non NULL going forward,
otherwise it thinks it failed to allocated.

Could you test this one instead?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f992a5eb878e..a69067367c29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4662,7 +4662,10 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
 	} else {
-		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
 	}
 
 	if (!iter->hash) {


Thanks,

-- Steve

