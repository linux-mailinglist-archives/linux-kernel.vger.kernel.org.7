Return-Path: <linux-kernel+bounces-883758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13935C2E50F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28503B8C7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AEB2EE5F5;
	Mon,  3 Nov 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFNcKhK5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eADYVZ6Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4241A9F82
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210195; cv=none; b=WBcm48Dp71lkx9EgwrLhOPRVjq8rq0FDpi1UfbtoSiuBm0v6kl7DOgkCfVFNUzSGNG+cBoYe04dsXcRmHBuR2c1BUX1pSiBWlUft9SLznAbfjQ3RifCuzoqbvf9/TWELFfLN83QqA6GYX+YH7PGigADMuXbX1lVIk2PwpTv+sdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210195; c=relaxed/simple;
	bh=5kYaIOs/gj36O9vsI2zajISfrtXwQDb/E6iF9t7uoXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohQ86otFQmvEYTQ4cHqnp6tx0wVJv0j8t6xWAxvT+EQ2ocODOhHF2Gwvts3CmM8XP67yD/CabXujXpgJHdsqcglWZexxL+d2hDkZKil7r66Gk7IaPsKUTKvg5HBCdinOOu4xg4gGmwTI72GSmMSKVB39p9E0iar6B1Y0KZF1qcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFNcKhK5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eADYVZ6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762210192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NS9ophB+2gsn6r3puiXvB9tNNXIblEqHHdimliWUDuY=;
	b=SFNcKhK5GSnLmVBOdKLeczhqh2X9uQBAERr2o8v+tTfEaj/NNAbYRxeZR2r7js2RpCK+w3
	DmeeOhxxRL219rPuZP7r4fxxV1k0kUUHg0KQqLHgg+ZzxauPhLTtlf35q8gVC81IQcTwpu
	IUCd7V5CEhi9fnD7J5dzaW+gB916St4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-XP2M3SL1OviVTDbV8vh1Sw-1; Mon, 03 Nov 2025 17:49:51 -0500
X-MC-Unique: XP2M3SL1OviVTDbV8vh1Sw-1
X-Mimecast-MFC-AGG-ID: XP2M3SL1OviVTDbV8vh1Sw_1762210191
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf8faf8bdso140356451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 14:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762210191; x=1762814991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS9ophB+2gsn6r3puiXvB9tNNXIblEqHHdimliWUDuY=;
        b=eADYVZ6Yti+zoT0T0BVB/Z16zK7ApMPQtMR8tz4eN6KBa2xGflDInN8P7u2YEL5PV6
         uF/q+9CTChK1uhvcWcUOMu+TlTpFEdtII50BkF5kCRJq+G8vcOVwQY0gmAb1xGyxSOdi
         D9eMZZuchzsXKnP+RlmEq8n4VgdOIjkMUDeY3707ulUF/y8wkucPk9434FYwq3E/MXPA
         UNtGlk9aWDeNw3N8hV1mgpgYmSzKNo04EEfuTQ2TT2w7it1OTH+35DMurYvu4Uq4//w3
         l7JWApcTDkx3nNQVtWZge/hHOLeDVpjshoDuK4pZfwUDf86hW0n09uBLLTlmVydHcfyx
         fe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762210191; x=1762814991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9ophB+2gsn6r3puiXvB9tNNXIblEqHHdimliWUDuY=;
        b=dY1smG73mNe+wUHrbxV4FL2Ui8uDnxJK3770pl7M9FZGtSl/W/Dd6ag8oaGm3yMPFj
         twkk1Tjjf8W3fOJqvGHR5QbfzbCiis9qbOITSpYx3FuVO4ErXsuFG2BWsUe3Fduy/icB
         k4x+u/SvvF3D7hzU8vEiAQdLh+hqVPO0e4xdSIY7TImuFAaRopEG0T6VGrqTHnagSOLl
         TUZ4nK3OpB448spRBi0D49bUs4rQ9xy/SdHe71Q5NhDJEtR+ZX5Sw5ZHRHb/vduOm9UN
         O3SAHZ3dyjYVsKZ1SIcRQ5/zrN/ztO++2gsMIDoS7OIgzTlLaRWR/JWmBeY+mkJ5JZrL
         PF/g==
X-Forwarded-Encrypted: i=1; AJvYcCWp8CwKZtjUTM0yNj26LyveayJL8vqr5Yxf+7eKy6pv2JFEiJign2zrySaHEGdKn8dp9m5upu4IwxyqVOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOp23NIYfhtrRMfopbGXuk9TPKoeR4igJp9G3PQeQf+yr/QqZ
	gH34F6/MeSmV/l6zOgM/DO09d9+7vMABugBkihSWrqiX+TADe5LMDxJ2WDQb34wZ9CImLf0qmCf
	1FPxYn4apwfUTalr9D7crPFvLsZfERGizoU1POmXjmMO3NqwYu9o3KBlJ9o/u7UCoUQ==
X-Gm-Gg: ASbGnctvKjtz6TfovcGsJOO8gNI1KOspuSoigpAJ5D1uxHLrklGgt89x7jFz7d+BI4Q
	bRbSYyLhRgo0A8tWv7TlQl3kxhZllgcR2fHJlNfUJn7h9hR5aEK4IRX6VNVbgsyKXI7lofYBi78
	TTlmDNQlUbcjx8qC6U+1ed/2eob6XPG1WAjx8NeLf1hxwG0GdPmCYBEF1i/Ca0dBbcua7iFkRX5
	FkCp34OAZkpWu/gaaW29J57KMoboR7D5eKSIwLZyRTuUsiRH6GFG8BlsZbyPdH50zozDphP6E2T
	Qom4Zq2F/g69rxsrQcW2Cgu4YwqYfEhXOUQu2goUJdbHf5O/JE2jo++ZivCpdlxAie0=
X-Received: by 2002:a05:622a:1650:b0:4ec:f402:8268 with SMTP id d75a77b69052e-4ed30dcaa0dmr191640501cf.26.1762210190424;
        Mon, 03 Nov 2025 14:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAsLPvmBUHB2Z3FfK6yOGs/GMWLA9GrZV7ryn8pAKwOM/qFXw5EREel6ThWDgZtJuk9VQrHA==
X-Received: by 2002:a05:622a:1650:b0:4ec:f402:8268 with SMTP id d75a77b69052e-4ed30dcaa0dmr191640121cf.26.1762210189822;
        Mon, 03 Nov 2025 14:49:49 -0800 (PST)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f847ef28sm71286485a.54.2025.11.03.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 14:49:49 -0800 (PST)
Date: Mon, 3 Nov 2025 17:49:46 -0500
From: Peter Xu <peterx@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, conduct@kernel.org
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aQkxioBXJtPbuJJ-@x1.local>
References: <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
 <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
 <aQkUwbx7Z4q1qcSB@x1.local>
 <5f128cbf-7210-42d9-aca1-0a5ed20928c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f128cbf-7210-42d9-aca1-0a5ed20928c2@kernel.org>

On Mon, Nov 03, 2025 at 10:27:05PM +0100, David Hildenbrand (Red Hat) wrote:
> On 03.11.25 21:46, Peter Xu wrote:
> > On Mon, Nov 03, 2025 at 09:01:02PM +0100, David Hildenbrand (Red Hat) wrote:
> > > > > I have an extremely heavy workload at the moment anyway, but honestly
> > > > > interactions like this have seriously put me off being involved in this review
> > > > > personally.
> > > > > 
> > > > > Do we really want this to be how review in mm or the kernel is?
> > > > > 
> > > > > Is that really the culture we want to have here?
> > > > 
> > > > Gosh.. Seriously?
> > > > 
> > > > I'm ok if this needs to be audited.  I have all the previous discussions in
> > > > the cover letter as links.
> > > 
> > > I'm late to the party (or whatever this here is called. ah right, drama),
> > > and I haven't yet dug through all the emails and certainly not through all
> > > the of involved code changes.
> > > 
> > > Peter, I was a bit surprised by your messages here indeed, not what I
> > > expected.
> > > 
> > > The "Your code allows to operate on pmd* in a module??? That's too risky and
> > > mm can explode!  Isn't it?" definitely was absolutely unnecessary ... or
> > > telling Liam that "he want almost mad".
> > 
> > It was a joke!
> > 
> > uffd_copy() API was NACKed because of this.  Now the new proposal
> > introduced it.  I made a joke saying Liam allows that to happen in his
> > branch, but forbid mine.
> > 
> > I thought it was super clear to identify.
> 
> Text is a very bad medium for that, especially given the previous
> discussions that were rather heated.
> 
> So it's good that you clarify that -- I am not sure how many people got that
> it was a joke TBH.
> 
> I understood the reference to previous discussions but to me it sounded
> rather dismissive in the context of this discussion.
> 
> > 
> > > 
> > > Again, not what I would have expected from you, and I would assume that you
> > > had a bad day and would at least apologize now that some time passed.
> > 
> > Sorry, no.  I won't apologize for that.  I was not fair treated, and now I
> > think it's fair I at least make a joke.
> 
> Peter, if you would tell me that I am going mad I would not be able to
> understand that as a joke -- unless maybe if you add plenty of :) . :)

If it's a problematic use of the word "mad", it could be my English not my
attitude.  I can easily say I'm mad at something when I'm not satisfied.
I admit I'm not a native speaker.

But then, if you think "mad" is a bad word, how about:

https://lore.kernel.org/all/6odeeo7bgxgq4v6y3jercrriqyreynuelofrw6k6roh7ws5vy2@wyvx7uiztb5y/

        I'm happy to address changes, but I'm not happy to accept more
        middleware and "it's not part of the patch set" to address any
        problem as you push more trash into an already horrible code base.

I didn't raise CoC report for that.  I was still trying to be technical on
the whole discussion as much as I can do best.  Hence, my reply was:

        > I'm happy to address changes, but I'm not happy to accept more
        > middleware and "it's not part of the patch set" to address any problem
        > as you push more trash into an already horrible code base.
        > 
        > We need to fix things too.
        > 
        > So I'm fixing it.

        Let's wait for a 2nd opinion on the approaches.

        As I said, I'm OK if everyone likes your solution and if I'm the only one
        NACKing it.  If we can support guest-memfd finally whoever adds that, it's
        not so bad.

Is "trash" a better word than "mad"?

> 
> > 
> > David, you're leaving, and I'm totally dissappointed that at this point of
> > time, you ask me to apologize instead.
> 
> I'll be right here, working for the community as I always do. So please read
> my message as if nothing in that regard happened.
> 
> I don't want you to feel bad here, I want us to find a solution without more
> of this drama.
> 
> Because that's what we have here, unfortunately :(
> 
> > 
> > I thought it was obvious a joke, because I never thought having pmd* in a
> > function in a module is not OK.
> 
> Unfortunately it was not clear.
> 
> > 
> > I always thought it was fine, Linux is not a micro kernel.  It's just fine.
> > It is what happening in Linux right now.  It is so obvious.  In case it was
> > not clear, I hope I make it clear now.  If I'm going to formally NACK
> > Liam's series, I won't use this as one of the real reasons.  I just hide it
> > in some of others that are real reasons.  However if to be fair, when this
> > reason is removed, this series should also remove the "highlight" that it
> > removed shmem.h header, because my v1 also did that when with uffd_copy().
> > 
> > > 
> > > I understand that you were upset by the previous feedback on the earlier
> > > series.
> > > 
> > > There were some heated arguments in the last discussions, but most of them
> > > were based on misunderstandings. I would have thought that once they were
> > > resolved that we could continue focusing on discussing the technical details
> > > again.
> > > 
> > >  From what I can see you asked for actual code and when Liam came back with
> > > some code that looks like *a lot of work* to me.
> > 
> > It's Liam who stood out strongly pushing back what he at least used to be
> > not familiar with.  This was, IMHO, rude.  It's ok to keep silent on some
> > patchset that one isn't familiar.  It's ok to ask questions.  It's not ok
> > to strongly push back without being extremely familiar with the code.
> 
> /me am I a rude person? :( ;)

Frankly, I would trust that if you strongly NACK a series, then you should
have good knowledge of the code base and the series you disagree.

If you didn't have enough knowledge and NACK some patchset without really
knowing much better than the author, yes, IMHO I think it's rude too.

If I did it, it's the same.  I will be the one to be rude.  It has nothing
to do with who's doing it.

Like if I strongly push back whatever change in maple tree, I'll be rude.
I never did, and I'll never do that.

> 
> The previous discussions on this were not ideal, because there were
> misunderstandings, yes. Liam has a lot of background on VMA handling, so I
> think getting is input is actually pretty valuable.

There is a line.  I can't tell how to draw a line, but there is.

> 
> > 
> > He might be more familiar now, I wish he is. But it's Liam's decision to
> > work on the code.
> 
> Right, Liam took the time to actually implement what he envisionsed. I
> assume it was a great learning experience for him.
> 
> Shame that this drama here seems to make him want to stop using that
> experience in the future.
> 
> > 
> > We're adults, we do what we should do, not what we asked to do.  If we do
> > what we asked to do, we should have our reasons.
> > 
> > My ask was trying to make Liam see that what he proposed is over
> > engineering the whole thing.  I was pretty sure of that, he wasn't.  I
> > explained to him multiple times on why it was an overkill, he doesn't
> > agree. It's fine for him to disagree, it's Liam's right.  Then it's also
> > fine for me to ask him code it up to notice himself, if I can't persuade
> > him.  That's the only way for him to persuade me instead.
> 
> Well, he noticed that we can apparently cleanup userfaultfd quite heavily.
> :)
> 
> And maybe that's the main problem here: Liam talks about general uffd
> cleanups while you are focused on supporting guest_memfd minor mode "as
> simple as possible" (as you write below).
> 
> I acked your series for a reason: I think it is good enough to implement
> that (as simple as possible), but I also have the feeling that we can do
> much better in general.

"feeling" is not a good reason to block a series from landing.  If you, or
Liam, or anyone, has good proposal already, we can always consider it.

The thing is I don't easily see a good proposal so far, it's non-trivial.

Meanwhile, the current v1-v4 I posted should be simply enough that even if
one day someone wants to clean it up we can revert relevant changes and
apply the cleanup idea on top, because the changeset needed to do the
cleanup on top of v1-v4 of mine will be trivial.  It doesn't need to be
blocked.

I mentioned too that I think userfaultfd code isn't the cleanest, for
example, here:

https://lore.kernel.org/all/aQPX859LbBg5FmE8@x1.local/

        On Thu, Oct 30, 2025 at 04:24:46PM -0400, Liam R. Howlett wrote:
        > Right, so the existing code a huge mess today and you won't fix
        > anything, ever.

        IMHO fix is the wrong word.  Cleanup it is.  I agree the current
        userfaultfd code isn't extremely easy to follow.

So I agree cleanups might help.

Liam explained his "vision" on how to cleanup.  I explained why it won't
work, starting from:

https://lore.kernel.org/all/20250926211650.525109-1-peterx@redhat.com

At that time, the proposal was still:

        struct vm_uffd_ops hugetlb_uffd_ops = {
                .missing = hugetlb_handle_userfault,
                .write_protect = mwriteprotect_range,
                .minor = hugetlb_handle_userfault_minor,

                .mfill_atomic = hugetlb_mfill_atomic_pte,
                .mfill_atomic_continue = ...
                .mfill_zeropage = ...
                .mfill_poison = ...
                .mfill_copy = NULL, /* For example */
        };

Obviously, whoever proposed above hasn't looked at handle_userfaultfd() at
all. That's also why I stopped commenting at that time, because it means
who proposed it actually doesn't know the code well yet, and I don't
necessarily need to comment on each line.  I explained from high level on
why it's an overkill at that time.

It's fine to propose something being familiar or not with it, but again
it's not fine to strongly pushback one series with such a proposal, and
without the familiarity of the code base.

> 
> > 
> > I sincerely wished that works out.  As I said, then I'll properly review
> > it, and then we build whatever we need on top.  I'm totally fine.  However
> > it didn't go like that, the API is exactly what I pictured.  I prefer my
> > proposal.  That's what I did: showing the difference when there're two
> > proposals, and ask for a second opinion.
> > 
> > It's not fair to put that on top of me to blame.  He's trying to justify
> > he's correct.  It has nothing to do with me.  He can stop pushing back
> > anytime.  He can keep proposing what he works on.  It's his decision, not
> > mine.
> 
> I would prefer if we can come to a conclusion instead of having people stop
> pushing back and walking away.

Obviously people can walk away from either side.  It's not always that who
push back things can walk away.

I'm nobody.  I don't mean I'll be walking away and I'm comparing that to
Liam's walking away.  Liam is doing very well on maple trees (I didn't
follow at all, but I'd trust that), while I'm pretty sure Linux will run as
smooth if I walked away.  However IMHO this is not a reason at all to allow
anyone randomly NACK on anything without good reasons, and without good
knowledge base of what the patchset is touching.

Not to mention this is also not the 1st time it got strong NACK.  v2 was
almost NACKed because I introduced a function that returns a folio*.

> 
> I assume positive intend here from both sides.
> 
> > 
> > > 
> > > He really seems to care (which I highly appreciate) and went the extra mile
> > > to show us how the uffd code could evolve.
> > > 
> > > We've all (well okay, some of us) been crying for some proper userfaultfd
> > > cleanups for years.
> > > 
> > > So is there a way we can move forward with this without thinking in binary?
> > > Is there some middle-ground to be had? Can some reworks come on top of your
> > > series? Can so reworks be integrated in this series?
> > > 
> > > I agree that what Liam proposes here is on the larger side, and probably
> > > does a lot of things in a single rework. That doesn't mean that we couldn't
> > > move into that direction in smaller steps.
> > > 
> > > (I really don't think we should be thinking in terms of a CoC war like: show
> > > them what I did and I will show them what they did. We are all working on
> > > the same bigger goal here after all ...)
> > 
> > We've got some second opinion from Mike, please read it first.
> 
> I read it, and I will have to look into some more details. But what I could
> read from Mikes reply is that there could be a discussion continuing where
> we would find a middle ground.
> 
> Well, if I can motivate Liam to keep working on userfaultfd at all.
> 
>  David,
> > you're co-maintaining mm with Andrew.  I think it's fair indeed you provide
> > how things should go together with Andrew.  It's fair you and Andrew
> > whoever would like to make a decision on how to move forward.  I'm fine on
> > whatever decision you want to make.
> 
> Unfortuantely (or fortunately?) I am not officially maintaining userfaultfd.
> And Andrew is not involved enough I am afraid to make a decision.
> 
> Of course, I *could* make a decision, but that would likely involve that we
> continue the discussion without this drama. But do people want that?

If you get my whole point, I was sincerely trying to collect 2nd opinions.

I can paste my reply once more here, for my attitude:

https://lore.kernel.org/all/aQPX859LbBg5FmE8@x1.local/

If you are talking about drama, just to mention I didn't raise a CoC report
even if my code was evaluated as "trash".  IMHO, whoever reads these
discussions likely wasted some part of one's time.  I don't want to waste
time for whoever is going to audit this whole thing.

I left my opinion in maybe 1 hour after Liam shared his branch, that
included having lunch.  I can glimpse ~1000 LOC as fast almost because what
Liam proposed matched almost like what I can imagine.

Mike shared his opinion today.

You can definitely share yours after taking time to read about it.

We stuck here for months. So many things happened.  It's definitely not a
problem if we take this slow.

Thanks,

-- 
Peter Xu


