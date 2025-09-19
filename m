Return-Path: <linux-kernel+bounces-824684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F69CB89DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EEF3A2B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987D263C69;
	Fri, 19 Sep 2025 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcWM4oBw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308E258ED5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291427; cv=none; b=uBhiMScZZvavzBLW29TkIYVVvxsJkJgYhelLZSEoXl84gDVBgAi0ZX4VzTU0misGejvaCXEe3rl1RaQuAUEFQXWEAan3xpWP/UEeUfkk5taTQIp+tAkfzyxX2kxufSKHUu3SYk8VJHcnWeFRVRYZoC1njzGA1U456I7thlZmgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291427; c=relaxed/simple;
	bh=hqbFRkcAwgWhnZtP+r9gQWMBXt4JXtwvzFHyj6GR238=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3b3bWkMG/49mNsRA2Cj3rwrzHU9B+zdIJ52qcf3xJ1y1fAh9KI+E2S1ctehYC8xDhQ18mniAjNz2tMHlfwk8bIHxa9NPL7Y76hKgY+HRjwlGmsGeZTmHTrB47W6D2Tl7j/UQVb2hW4mYZ77XASapQKH3DNL/RjgBbQarXzt9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcWM4oBw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ticqe5qWO2L3qCYZDyiYvfuA1uJgYJW+p6eRr/13AO8=;
	b=CcWM4oBw8lJesvGlsbxmtZI/QJq1Ng04zshkN5UPx2cQGUk5ISkHM3ORljPbn8ZQ9r3T2R
	slb4H3QTgZ8jbcNSVEVL7lkVOx7UTAJzWWeRaf1ry0v7Zl58x+dkssBio4U3A22HWfvRUC
	9MEnP4duQbq5QNlhe4nWVIqAhjPz8e8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-yWwKiRdENz-Uafwv07tTKQ-1; Fri, 19 Sep 2025 10:17:01 -0400
X-MC-Unique: yWwKiRdENz-Uafwv07tTKQ-1
X-Mimecast-MFC-AGG-ID: yWwKiRdENz-Uafwv07tTKQ_1758291421
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-82e5940eeefso470929785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291420; x=1758896220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ticqe5qWO2L3qCYZDyiYvfuA1uJgYJW+p6eRr/13AO8=;
        b=up2wUdiXohgIibxLLFHZ/zB3vilFNDYOiXJ4GetDm3fPhcsIGUGoOeV3JUP5RC5IL1
         7xfsRjHBhzLwvdvB3T0bkNYe5MJNqjAuD8Z9KvxeptZtUxk/hDUvkQjPTnSjpM7m0Qhu
         9KR+AZVRK5ZlgWq0BiVVkvOHtMr4FQGikxFFNzuqJGbzdnVz4E/ZOKZ9ZADfj/i8/7zR
         O9cgG6TUEyhI+VrLMEh9Hqh2IXyYqzwEg/rfTiaXIx2evhFSK4BkTA5z7F7WzjpUsBYu
         ivXRgFUmgR1p+62GAzO/N76W55aTzw9UkmeOnuVyOnYoDdDP4sPsOg1HIIsx+em7uk/4
         Sziw==
X-Forwarded-Encrypted: i=1; AJvYcCURTSHIQVMR1tB3HaswgE9WJrww+Hv9PdocGD8/GzAGsrpwW0foz0bxdpd/Digd4n/BEemFs8PUjmiKA7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67b1fabKYYHeWX7KXIQdCI1V/NaDZfJX5/xnTR0drWeftfXr+
	zl7fmhNaTGP32IudsISEz1papU1AzC+srZLbNgz9UeSRrNZ6AEtKVzG9BWfpPEj4KBGR9mLqvau
	1lBL98cG8/KSpMNQpqPr4ukhkfiEHSYxKhDKPbN+mqHXlDeDAon2LPMvW5XpxbHvgU1J+5IBBqg
	==
X-Gm-Gg: ASbGncvL2s4vJabl5mZCNyekB3AQ3vBV6SUCntCfynFhzBcXzghb/2bo6PwhIp5xPed
	lZQyWentyE08UqRn888BlP0nA0urzZxIc/b+6HhbmFvpwJOBSrn0d8gQUeL8+KPRm1tpqPmi4fj
	ISPcU3lL3K8cENzoV6NiccefPvfFzvygzI7Uh5narv36uVRzar5j+S/oPSisosahkvnvx5T528i
	oqwyXEtfHw2csW7NWHhFWz9QM5OUvjXktaRHWUuMNLuV4rffdL0YCqAgT9d6Kw1DEG3RN66rdH/
	CDl25qDhxpnjz1o8buzkQwenlu+rY3AA
X-Received: by 2002:a05:620a:2552:b0:829:d0e9:bc1b with SMTP id af79cd13be357-83b83bf98cfmr374573585a.7.1758291420048;
        Fri, 19 Sep 2025 07:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmwp6NIoXqiqR/kixIJFbO80y7cuU3Ya0UiZpIOCrLcj+9fy9PCkWSa9mP1YicitttrWDVOw==
X-Received: by 2002:a05:620a:2552:b0:829:d0e9:bc1b with SMTP id af79cd13be357-83b83bf98cfmr374569185a.7.1758291419395;
        Fri, 19 Sep 2025 07:16:59 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836262b559dsm352820585a.1.2025.09.19.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:16:58 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:16:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aM1l2YMmvBgiXJ8a@x1.local>
References: <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
 <aMx0oGwRpSTcfdnf@x1.local>
 <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <swfs7qpgrezamnijhheiggwdfklfqdc6ahp5g7nvprr64m7wz5@msf2mqajzbuz>

On Thu, Sep 18, 2025 at 09:50:49PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [250918 17:07]:
> > On Thu, Sep 18, 2025 at 03:43:34PM -0400, Liam R. Howlett wrote:
> > > * Peter Xu <peterx@redhat.com> [250918 14:21]:
> > > > On Thu, Sep 18, 2025 at 07:53:46PM +0200, David Hildenbrand wrote:
> > > > > Re Nikita: If we could just reuse fault() for userfaultfd purposes, that
> > > > > might actually be pretty nice.
> > > > 
> > > > I commented on that.
> > > > 
> > > > https://lore.kernel.org/all/aEiwHjl4tsUt98sh@x1.local/
> > 
> > [1]
> > 
> > > > 
> > > > That'll need to leak FAULT_FLAG_USERFAULT_CONTINUE which isn't necessary,
> > > > make it extremely hard to know when to set the flag, and comlicates the
> > > > fault path which isn't necessary.
> > > > 
> > > > I think Mike's comment was spot on, that the new API is literally
> > > > do_fault() for shmem, but only used in userfaultfd context so it's even an
> > > > oneliner.
> > > > 
> > > > I do not maintain mm, so above is only my two cents, so I don't make
> > > > decisions.  Personally I still prefer the current approach of keep the mm
> > > > main fault path clean.
> > > 
> > > What we are trying to say is you can have a fault path that takes a type
> > > enum that calls into a function that does whatever you want.  It can
> > > even live in mm/userfaultfd.c.  It can then jump off to mm/guest-memfd.c
> > > which can contain super unique copying of memory if that's needed.
> > 
> > Per mentioning of mm/guest-memfd.c, are you suggesting to take guest-memfd
> > library approach?
> 
> > We have in total of at least three proposals:
> > 
> > (a) https://lore.kernel.org/all/20250404154352.23078-1-kalyazin@amazon.com/
> > (b) this one
> > (c) https://lore.kernel.org/all/20250915161815.40729-1-kalyazin@amazon.com/
> > 
> > I reviewd (a) and (c) and I provided my comments.  If you prefer the
> > library approach, feel free to reply directly to (c) thread against my
> > email.
> > 
> > I chose (b), from when it was posted.
> 
> Honestly, I don't know what I'd vote for because I don't like any of
> them.  I'd chose (d) the do nothing option.
> 
> > 
> > 
> > > 
> > > That way driver/i_know_better_that_everyone.c or fs/stature.c don't
> > > decide they can register their uffd and do cool stuff that totally won't
> > > tank the system in random strange ways.
> > 
> > What is the difference if they are allowed to register ->fault() and tank
> > the system?
> 
> One less problem.
> 
> More people with mm experience looking at the handling of folios.
> 
> The common code not being cloned and kept up to date when an issue in
> the original is discovered.
> 
> Having to only update a few fault handlers when there is a folio or
> other mm change.
> 
> Hopefully better testing?
> 
> > > 
> > > Seriously, how many fault handlers are you expecting to have here?
> > 
> > First of all, it's not about "how many".  We can assume one user as of now.
> > Talking about any future user doesn't really help.  The choice I made above
> > on (b) is the best solution I think, with any known possible users.  The
> > plan might change, when more use cases pops up.  However we can only try to
> > make a fair decision with the current status quo.
> 
> Planning to handle one, five, or two billion makes a difference in what
> you do.  Your plan right now enables everyone to do whatever they want,
> where they want.  I don't think we need this sort of flexibility with
> the limited number of users?
> 
> > 
> > OTOH, the vm_uffd_ops also provides other fields (besides uffd_*() hooks).
> > I wouldn't be surprised if a driver wants to opt-in with some of the fields
> > with zero hooks attached at all, when an userfaultfd feature is
> > automatically friendly to all kinds of memory types.
> > 
> > Consider one VMA that sets UFFDIO_WRITEPROTECT but without most of the
> > rest.
> > 
> > As I discussed, IMHO (b) is the clean way to describe userfaultfd demand
> > for any memory type.
> > 
> > > 
> > > I'd be surprised if a lot of the code in these memory types isn't
> > > shared, but I guess if they are all over the kernel they'll just clone
> > > the code and bugs (like the arch code does, but with less of a reason).
> > > 
> > > > Besides, this series also cleans up other places all over the places, the
> > > > vm_uffd_ops is a most simplified version of description for a memory type.
> > > 
> > > 6 files changed, 207 insertions(+), 76 deletions(-)
> > > 
> > > Can you please point me to which patch has clean up?
> > 
> > Patch 4.  If you want me to explain every change I touched that is a
> > cleanup, I can go into details.  Maybe it's faster if you read them, it's
> > not a huge patch.
> 
> I responded here [1].  I actually put a lot of effort into that response
> and took a lot of time to dig into some of this to figure out if it was
> possible, and suggested some ideas.
> 
> That was back in July, so the details aren't that fresh anymore.  Maybe
> you missed my reply?

AFAICT, we made it the other way round.  My reply is here:

https://lore.kernel.org/all/aMnAscxj_h42wOAC@x1.local/

> 
> I was hoping that, if the code was cleaned up, a solution may be more
> clear.
> 
> I think the ops idea has a lot of positives.  I also think you don't
> need to return a folio pointer to make it work.
> 
> > > 
> > > How is a generic callback that splits out into, probably 4?, functions
> > > the deal breaker here?
> > > 
> > > How is leaking a flag the line that we won't cross?
> > > 
> > > > So IMHO it's beneficial in other aspects as well.  If uffd_copy() is a
> > > > concern, fine, we drop it.  We don't plan to have more use of UFFDIO_COPY
> > > > outside of the known three memory types after all.
> > > 
> > > EXACTLY!  There are three memory types and we're going to the most
> > > flexible interface possible, with the most danger.  With guest_memfd
> > > we're up to four functions we'd need.  Why not keep the mm code in the
> > > mm and have four functions to choose from?  If you want 5 we can always
> > > add another.
> > 
> > I assume for most of the rest comments, you're suggesting the library
> > approach.  If so, again, I suggest we discuss explicitly in that thread.
> > 
> > The library code may (or may not) be useful for other purposes.  For the
> > support of userfaultfd, it definitely doesn't need to be a dependency.
> > OTOH, we may still want some abstraction like this one with/without the
> > library.  If so, I don't really see why we need to pushback on this.
> > 
> > AFAIU, the only concern (after drop uffd_copy) is we'll expose
> > uffd_get_folio().
> 
> If you read my response [1], then you can see that I find the ops
> underutilized and lacks code simplification.

I tried to explain to you on why what you mentioned is completely
orthogonal to this change, in above my reply.

> 
> > Please help explain why ->fault() isn't worse.
> 
> I'm not sure it is worse, but I don't think it's necessary to return a
> folio for 4 users.  And I think it could be better if we handled the
> operations on the folio internally, if at all possible.
> 
> > 
> > If we accepted ->fault() for all these years, I don't see a reason we
> > should reject ->uffd_get_folio(), especially one of the goals is to keep
> > the core mm path clean, per my comment to proposal (a).
> 
> I see this argument as saying "there's a hole in our boat so why can't I
> make another?"  It's not the direction we have to go to get what we need
> right now, so why are we doing it?  Like you said, it can be evaluated
> later if things change..

You described ->fault() as "a hole in our boat"?  I'm astonished and do not
know what to say on this.

There was a great comment saying one may want to make Linux an unikernel.
I thought it was a good one, but only when it was a joke. Is it not?

> 
> My thoughts were around an idea that we only really need to do a limited
> number of operations on that pointer you are returning.  Those
> operations may share code, and could be internal to mm.  I don't see
> this as (a), (b), or (c), but maybe an addition to (b)?  Maybe we need
> more ops to cover the uses?

That's exactly what this proposal is about, isn't it?  Userfaultfd minor
fault shares almost all the code except the one hook fetching a folio from
a page cache from the memory type.

"could be internal to mm" is (c) at least.  No one can do what you
mentioned without moving guest-memfd into mm/ first.

Nikita and I drafted these changes, so likely we may likely have better
idea what is happening.

Would you perhaps implement your idea, if that's better?  Either you're
right, we're happy to use it.  Or you found what you're missing.

It's not required, but now I think it might be a good idea if you are so
strongly pushing back this userfaultfd feature.  I hope it's fair we
request for a better solution from you when you rejected almost every
solution.

> 
> So, I think I do want the vm_uffd_ops idea, but not as it is written
> right now.
> 
> Thanks,
> Liam
> 
> [1]. https://lore.kernel.org/all/e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh/
> 

-- 
Peter Xu


