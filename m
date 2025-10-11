Return-Path: <linux-kernel+bounces-849332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F09BCFDDE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015CB3B8B24
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386124DCE6;
	Sat, 11 Oct 2025 23:37:49 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04F193077
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760225869; cv=none; b=Pr1EDeevnUPF9QJHvgv4rlOEUc6w42ODkYTIGU1fAsuyOP18snMP2wdJ+DA9aLhgw/PTj5dImrDZkoaGuV5gpnsQLgbM6Yrwr5ezt7zr1+L9NMvKGoCAbqydJiIPHoz9NEczV+HUPHaIKiOycDEJbRE1FDocdd2yuBZs/49851U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760225869; c=relaxed/simple;
	bh=/yt9wz/bKCgC/MdzNv4boGLac0GxXQHyqJ8nBB901BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eolJhjP2VHPvnh8Ud1E2GqdVOHpx1Q238nvElu1BHy+1UekHHts8sNlNsMGQe6OpRMSnVzyfewyqWKswZu21/iaYmLdAVxAaw/tio1fnrH3466GUc7rc80B8G6rKUiRMIjUFADGnuWeg1AhD6r8Ya0bhI5Qvo5Aih94z/L1RAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 931F0882C8;
	Sat, 11 Oct 2025 23:37:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id BC65C2002A;
	Sat, 11 Oct 2025 23:37:42 +0000 (UTC)
Date: Sat, 11 Oct 2025 19:37:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: A couple more fixes to v6.18
Message-ID: <20251011193742.410cea9d@gandalf.local.home>
In-Reply-To: <CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com>
References: <20251011155240.59f0ff07@gandalf.local.home>
	<CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BC65C2002A
X-Stat-Signature: y18ofbi18bamomnszzgqni3j5zx3zpw8
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NN+VDvmlpiKs9XTZJB4MUCxquDF2APPg=
X-HE-Tag: 1760225862-563824
X-HE-Meta: U2FsdGVkX18rTPQUdi6vfbFKfu5er9MXON0rFTFZ9M6c7Onvc22w56s5WgkWH0VLYDd+4oeWm1K+uqzxm9nSE7QAHXjX+Eg5+Sl0S4UO9CgL6J6/1+3VUlACypIWHmjXPyLf4ko7WQ/JZNTDyPCPtqMr672b1FGv4+lKhQS94cDN7wtxdRQUdpQV9ycOHX9RiBdpSqh2uDmCCJ6kyw+GdOkQY4T/Lp1rj5/own5/uOY+oS4vv1qX09p/0HPaSehgyl4njNyFgvENGFu+OGqXsRj28G+rzC41lTuR7/vTgUwGvVTI7SsiIaRMcdV3o3nAgersH9A8gfmOzv56vFEWJ5qCA6Kdzcdnoq7J+gyI+OiKRHBPuPkCqIhi3GSKd24Hr17O30+cTKdjqeyOdM+CvKHA9JveAIhUtussv+C3nbL+PgetRFirw96yWOS0z5/u

On Sat, 11 Oct 2025 16:09:18 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 11 Oct 2025 at 12:52, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > +       /* cnt includes both the entry->id and the data behind it. */
> > +       size = struct_size(entry, buf, cnt - sizeof(entry->id));  
> 
> This seems very non-intuitive.
> 
> Why isn't it just saying
> 
>     size = cnt + offsetof(struct raw_data_entry, id);
> 
> which would seem to be much more straightforward than saying "go to
> the end, and then subtract out the size of this entry" - which then
> relies on the entry being the last thing in the struct.
> 
> And if somebody wants to have a helper like
> 
>    #define struct_offset(s,memb) (offsetof(typeof(*(s)), memb))
> 
> in order to get some kind of "typesafe offsetof", to go with 'struct
> size' then by all means.. That would make it be just
> 
>     size = cnt + struct_offset(entry, id);
> 
> which looks fairly legible and logical, and would go with the comment
> (and would pair fairly well with our other "struct_xyz()" helpers, I
> think).
> 
> I've pulled this, I just reacted to how odd that calculation looked.
> It makes very little sense  to me, since the calculation really has
> _nothing_ do with the size of the struct, and you explicitly have to
> play tricks to get the offset that way.

I could make this change for the next merge window.

I originally was going to change it to:

	size = sizeof(*entry) + cnt - sizeof(entry->id);

But figured using a macro would be better.

Honestly, I didn't like either solution. But having a:

	size = struct_offset(entry, id) + cnt

Would probably look better.

But again, it can probably wait till 6.19.

-- Steve

