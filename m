Return-Path: <linux-kernel+bounces-865721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E436BFDDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35083A362D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A158A2EC097;
	Wed, 22 Oct 2025 18:31:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF628725B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157887; cv=none; b=tneLRiVgdsVsZBojanmKVKC/kvYBZsG5q91sk1dByr1zkC5bTckrpoG7LfJV6DSbpIVIj23+S8iCZS9UDw5gvmLdJ8eIUWyx6wVSQM17UvRQZ8LhbZn+hbcT/ixnuAILAzn4/TED4KP+SJdlFVgfbIJYrfTrr2Gi6O029hSGLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157887; c=relaxed/simple;
	bh=x37hQM0glsEym36hdAyUrea47c7S+PYbJPzSYEznyfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2oggzhtmEcWjo6tDyUyEHoG+OiQ1HKgQlPrBSfr4Dy2E+D3H6xH6fJqaMBUOWgymIX2XTJM0g8T3ug6HgkSEKsgtpFIFaWE3DJxft0OXV53jNzfSkSZ69YNhW7tqF3YUjRnC0P3MuVNfuPbDcbOpcX0XDmzT+Y18DhuP1tAToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6E4D313BF03;
	Wed, 22 Oct 2025 18:31:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id BE33020025;
	Wed, 22 Oct 2025 18:31:15 +0000 (UTC)
Date: Wed, 22 Oct 2025 14:31:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251022143140.2ed517e1@gandalf.local.home>
In-Reply-To: <20250924080119.613695709@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.613695709@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n4qi5j9oc3fwy3dxzjutufuoj643efiw
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BE33020025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/v9EpACikv/TkAVugvJ65OWgEg4eVBslQ=
X-HE-Tag: 1761157875-477647
X-HE-Meta: U2FsdGVkX18nMJW1l5VJbWBtR03s+Yle+NLa/bdSu/eWhULh87aCkrKsbJjS9CLx1hsW03kcnkttWsfvBo/flGAVB6XX83BESXSu8z9V3yv7CyDk0hJBy2zVLwx0yemUqunNXeGipM9PtubFB4Evw/bQIQBFlt20UwCmTZiHqkSNyfDd4QRLDdAWl0gmXhJlqZmPa8PnYG5EzIdixDvfSrKnlytITCHKKp4lGbLP0I38w2BCWuaOnpv7g1yTLpWV9ikYh3O4FewLaIBJurQHDfcrJbm807BMCdmTgU0fi/Au9qa0LacF1lcNZUkwUaLijIq1H8xaAFKMecj2oVVqtJgts6WZ/x8JQkM0Vq6wBUGJgCdBiF6yaszCwT2tSV09

On Wed, 24 Sep 2025 09:59:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> @@ -100,6 +115,7 @@ static int unwind_user_start(struct unwi
>  	state->ip = instruction_pointer(regs);
>  	state->sp = user_stack_pointer(regs);
>  	state->fp = frame_pointer(regs);
> +	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);

compat_user_mode() is an architecture function (only defined in arm64 and now x86).

s390 doesn't implement it and regs can't be used to tell if it's compat or
not (although Jens tells me the task_struct can).

To do this properly in generic code, we should add a a:

	unwind_compat_mode(struct pt_regs *regs);

call in include/linux/unwind_user.h:

#ifndef unwind_compat_mode
static inline bool unwind_compat_mode(struct pt_regs *regs)
{
	return false;
}
#endif

And then in the x86 and arm64 asm/unwind_user.h:

static inline bool unwind_compat_mode(struct pt_regs *regs)
{
	return compat_user_mode(regs);
}
#define unwind_compat_mode unwind_compat_mode

-- Steve


>  
>  	return 0;
>  }
> 


