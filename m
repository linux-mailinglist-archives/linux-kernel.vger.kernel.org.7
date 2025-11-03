Return-Path: <linux-kernel+bounces-883680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2502C2E0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E11885598
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7023EAB8;
	Mon,  3 Nov 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD7umLum";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXuI+to+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EB42AA6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202827; cv=none; b=KU/gWi7IEzM3W3betNR8OJ7Eg6foMbOrVE9sSE2q7mU7C3hAX31UVhwHIP49QFZmsl16d5rD09pD3rCz1NGh7ZCxGfHChYa598v8C9w0wC/h0NteaRC3Tge7+NnehUYb8FdIyU680BYRILmtVPrBsKZjeNPcdcsavI4RJAEEySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202827; c=relaxed/simple;
	bh=H+9kO5f8FrA5y1DhJYYKBh/OTpYkMGYW83uGngfbvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkbvnSg9d12m0eNgBXXMAC4G3J857lukAj1Y+uhezQ+zMnez5yTan7bKhZAoUb0C88fpQbuZGYBEoKTTsvZYBCj2KR+w/5247fJ2czwuL8u5mO6bq4uX++RXim5qeb29o+Ja8ZQdgby2N1rDlI7MW1Ybs8SLqn+wKJezz/7gMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jD7umLum; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXuI+to+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762202824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vghBKiSvOSdxfV0lhypHIAUMncAsgcwHnYxmY/VnkRM=;
	b=jD7umLum/BiXFO45KJnBt0zoOk4yN8SGpgzBanP+Ft7r9CsCCYaTa5RIPGQxTvv80Z7P7W
	7bsOcmjzhsfl9z53/2RPV+AQtKC5rYih52oxLC1fCiKiJZJneHRUMvCfOVvCzqsSRDuxNX
	MAgzz8msM+hDw7slMxS/b7B4PYYsuIU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-7Fvy63PBNCu-93ehY0rdgQ-1; Mon, 03 Nov 2025 15:47:03 -0500
X-MC-Unique: 7Fvy63PBNCu-93ehY0rdgQ-1
X-Mimecast-MFC-AGG-ID: 7Fvy63PBNCu-93ehY0rdgQ_1762202822
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8805c2acd64so22707426d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762202822; x=1762807622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vghBKiSvOSdxfV0lhypHIAUMncAsgcwHnYxmY/VnkRM=;
        b=AXuI+to+akWYvXiC9AN5xvS6pIm3basqMbjpeQJ4aNGgiHjXGIcGk6JU2c18LpKrI2
         QL0fCw86a0RTdcURbZIS+Ul0/jLSJWP1eGCyeBy8kEax81oF5cD7NY6tmJ77xB7UZLpe
         SfYSRstpmw6nb1ufrM1A8Ir7IYdDdrkk9AWAQRX+athgE2zCxS+i9peKTCls1V2rPEtZ
         csajzyIflMOe4yMilKanzJg2+J2WONlY4EnxJ2l6HSkjCsQMt8qjI9gQmS1tRo987HoQ
         KHnSxDZEDuZyHmBMyZ/kBC6SvgzRwIqu0jeulUwKs7F6OX73/eeGylcpw28awkY60lkH
         V1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762202822; x=1762807622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vghBKiSvOSdxfV0lhypHIAUMncAsgcwHnYxmY/VnkRM=;
        b=MstOzxdMc5UBhGEfCPgfaWCG4P+gUz2snh8sELvAeVTzBSukUt1e33te6fCEaO3/kl
         GbP8F0Q9V+ZnWiBWiR40ld/qY2nHCS1eOp3nZsg7ZP+fb48kJz/eWFzcKZatY8R4fA2l
         f30jtgkoXhMfHZwK56rPhLcLxGDL8XvDIK/giQwsQBQ4CoIVzFZP3llFy2rr8IDWq4z5
         QM+86oS4r6Nt+ImvzNg3kgCosDmrgsaZm7JX27n6E7Yq3HB0xNRj1UKJGiUmf4EbgW7o
         +LkHcbd5Yspt7KhfvIA5AoICRCvv7FT1GRNBWIIXnVjnfyYj+J3Fib4DoRLQO9DHkJxy
         r+9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcsZruH5pKhtwpiaMiIlaMbrtKKpCiaOpAloW0AhsnP+YNJ8x6IfBFdulhRu0NzoRSfJHF8nisR3aIcQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRFNmYaBlZo9PmN4e3eMXVd6rW0VGnNmeHcwnezr11ztV6GCf
	7K8DhkiV/2uVZQaZh9BW4QXC/CS3UVKz9AAqk273kws2WZcAlZk2UqCe1YfIOhoozPYyFdf6bnj
	0GM9iak4D7N21WNQEYfjfN26RG1+CbLhwuFn9Okw732ZWta3OXjd8nLb8AWFVOxwCew==
X-Gm-Gg: ASbGnctjcAdtuqN2cpLdQtwNeY2v3Hciaxrfr2U5/WmKrH/orDKJCS2ERoZlWFQJSag
	IIisYYam+EobsI/7h2hR69OtvAh8UL6mJyPhji866jRbOVp+tlSxe/+KMNZN2B8oZ0yepHWpcNj
	rv8fyfsEPkIrOpdElOaWXiQ1917HvysamMkGM2/44kUHEfanX9ywDg6hbZD7J3mcgXxq/NgKG4/
	pfEUZwnFCL2DTkkXRlCSHEuEDzOS9ktVqxRu7lpCKrZr1uBiJD0iNj91HGSzJWOBHgwvK1VbqC2
	343cVdktv701RoY5tIL45F1Jdf3giIj/r+Mr8zuv4eiPXJwX30ld5krL8zLkfoPYzlk=
X-Received: by 2002:ad4:5d43:0:b0:880:4c73:9e44 with SMTP id 6a1803df08f44-8804c73a24emr33040616d6.15.1762202822191;
        Mon, 03 Nov 2025 12:47:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFki4qB2bWfAdvpnwwEKDZVQ/jgwqxyK8R5E1a/l8fmyEI99KRQ9GoapziPmE3jrH2Z1ZbnIQ==
X-Received: by 2002:ad4:5d43:0:b0:880:4c73:9e44 with SMTP id 6a1803df08f44-8804c73a24emr33040296d6.15.1762202821640;
        Mon, 03 Nov 2025 12:47:01 -0800 (PST)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060e9566dsm9124636d6.47.2025.11.03.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:47:00 -0800 (PST)
Date: Mon, 3 Nov 2025 15:46:57 -0500
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
Message-ID: <aQkUwbx7Z4q1qcSB@x1.local>
References: <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
 <aQO3Zko6Qrk7O96u@x1.local>
 <aQPCwFZqNd_ZlZ0S@x1.local>
 <d0b037a6-11b9-483b-aa67-b2a8984e56e0@lucifer.local>
 <aQPU-tyo_w68cnKK@x1.local>
 <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7768bbb5-f060-45f7-b584-95bd73c47146@kernel.org>

On Mon, Nov 03, 2025 at 09:01:02PM +0100, David Hildenbrand (Red Hat) wrote:
> > > I have an extremely heavy workload at the moment anyway, but honestly
> > > interactions like this have seriously put me off being involved in this review
> > > personally.
> > > 
> > > Do we really want this to be how review in mm or the kernel is?
> > > 
> > > Is that really the culture we want to have here?
> > 
> > Gosh.. Seriously?
> > 
> > I'm ok if this needs to be audited.  I have all the previous discussions in
> > the cover letter as links.
> 
> I'm late to the party (or whatever this here is called. ah right, drama),
> and I haven't yet dug through all the emails and certainly not through all
> the of involved code changes.
> 
> Peter, I was a bit surprised by your messages here indeed, not what I
> expected.
> 
> The "Your code allows to operate on pmd* in a module??? That's too risky and
> mm can explode!  Isn't it?" definitely was absolutely unnecessary ... or
> telling Liam that "he want almost mad".

It was a joke!

uffd_copy() API was NACKed because of this.  Now the new proposal
introduced it.  I made a joke saying Liam allows that to happen in his
branch, but forbid mine.

I thought it was super clear to identify.

> 
> Again, not what I would have expected from you, and I would assume that you
> had a bad day and would at least apologize now that some time passed.

Sorry, no.  I won't apologize for that.  I was not fair treated, and now I
think it's fair I at least make a joke.  

David, you're leaving, and I'm totally dissappointed that at this point of
time, you ask me to apologize instead.

I thought it was obvious a joke, because I never thought having pmd* in a
function in a module is not OK.

I always thought it was fine, Linux is not a micro kernel.  It's just fine.
It is what happening in Linux right now.  It is so obvious.  In case it was
not clear, I hope I make it clear now.  If I'm going to formally NACK
Liam's series, I won't use this as one of the real reasons.  I just hide it
in some of others that are real reasons.  However if to be fair, when this
reason is removed, this series should also remove the "highlight" that it
removed shmem.h header, because my v1 also did that when with uffd_copy().

> 
> I understand that you were upset by the previous feedback on the earlier
> series.
> 
> There were some heated arguments in the last discussions, but most of them
> were based on misunderstandings. I would have thought that once they were
> resolved that we could continue focusing on discussing the technical details
> again.
> 
> From what I can see you asked for actual code and when Liam came back with
> some code that looks like *a lot of work* to me.

It's Liam who stood out strongly pushing back what he at least used to be
not familiar with.  This was, IMHO, rude.  It's ok to keep silent on some
patchset that one isn't familiar.  It's ok to ask questions.  It's not ok
to strongly push back without being extremely familiar with the code.

He might be more familiar now, I wish he is. But it's Liam's decision to
work on the code.

We're adults, we do what we should do, not what we asked to do.  If we do
what we asked to do, we should have our reasons.

My ask was trying to make Liam see that what he proposed is over
engineering the whole thing.  I was pretty sure of that, he wasn't.  I
explained to him multiple times on why it was an overkill, he doesn't
agree. It's fine for him to disagree, it's Liam's right.  Then it's also
fine for me to ask him code it up to notice himself, if I can't persuade
him.  That's the only way for him to persuade me instead.

I sincerely wished that works out.  As I said, then I'll properly review
it, and then we build whatever we need on top.  I'm totally fine.  However
it didn't go like that, the API is exactly what I pictured.  I prefer my
proposal.  That's what I did: showing the difference when there're two
proposals, and ask for a second opinion.

It's not fair to put that on top of me to blame.  He's trying to justify
he's correct.  It has nothing to do with me.  He can stop pushing back
anytime.  He can keep proposing what he works on.  It's his decision, not
mine.

> 
> He really seems to care (which I highly appreciate) and went the extra mile
> to show us how the uffd code could evolve.
> 
> We've all (well okay, some of us) been crying for some proper userfaultfd
> cleanups for years.
> 
> So is there a way we can move forward with this without thinking in binary?
> Is there some middle-ground to be had? Can some reworks come on top of your
> series? Can so reworks be integrated in this series?
> 
> I agree that what Liam proposes here is on the larger side, and probably
> does a lot of things in a single rework. That doesn't mean that we couldn't
> move into that direction in smaller steps.
> 
> (I really don't think we should be thinking in terms of a CoC war like: show
> them what I did and I will show them what they did. We are all working on
> the same bigger goal here after all ...)

We've got some second opinion from Mike, please read it first.  David,
you're co-maintaining mm with Andrew.  I think it's fair indeed you provide
how things should go together with Andrew.  It's fair you and Andrew
whoever would like to make a decision on how to move forward.  I'm fine on
whatever decision you want to make.

I think I tried my best trying to make gmem work as simple as possible.

For the CoC report, I wish someone from CoC would also review it.

Thanks,

-- 
Peter Xu


