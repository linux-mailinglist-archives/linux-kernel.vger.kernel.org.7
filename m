Return-Path: <linux-kernel+bounces-875054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6DC18170
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1431C28757
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610B2D73B0;
	Wed, 29 Oct 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXtujlG2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DA1F461A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706064; cv=none; b=C2LPvwUcmxrsBcd8IfEuMwYMem4yeNb2lS/JN3SOMa1/zsa0TcI10bbrUjzjz51Q2at+FzCbVw4chDFfYJlJAVlfL33dMra7YwB9N/jwo5lGHOYW1UzWUDTRHDajaEee9hL1tpqVcHJMKQsEcTqlChmaPiJheFWuPQm9KRIM/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706064; c=relaxed/simple;
	bh=nnbgmPh/uLz3q7+IDGETfyAFzFN1BDtNr4aU236yptY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtWc4xrXyQnFUgO/fTDSilK7QuOAr0fiD02nGwf1dHaewPaMMPpORSc0PYWKf/jntIGxgWQrmg+Gsge+gLXcEhHvP1FSqqPpa8g966kDlrdQOJEQeyibCrVbcZLkLXPWs5qB3EtFIbc3ijwvnvP9yH+TngB78QaC3jpWnJXrobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXtujlG2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761706061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV6geqkUC9yszulriWkMA/zBhhS+rMg3DhyWlFe+W7k=;
	b=KXtujlG2hWlQ+HCw3xDDABfIVJ9yCiEtImQfjLLo1bMoWVvm/Ia5OBbP/3YlONAeDmOcCA
	4lFa1hGnq0HrG5g3Al7fxSlDtv6AbsR4LBfUhNgNHcJsWFWtJOXh6AGf3D+R1xkuHX+Rg2
	nas8sADJtvFcrkHnQwqVfi34UbS9ksU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-hwtM3kCKM2KXcL7ucz_bIw-1; Tue, 28 Oct 2025 22:47:40 -0400
X-MC-Unique: hwtM3kCKM2KXcL7ucz_bIw-1
X-Mimecast-MFC-AGG-ID: hwtM3kCKM2KXcL7ucz_bIw_1761706060
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78495d5ab26so11444137b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761706059; x=1762310859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV6geqkUC9yszulriWkMA/zBhhS+rMg3DhyWlFe+W7k=;
        b=BCQBY7d16sTn4ipmNSXFTgLY9xFagX4rhTlWZR7aqhWEDV2XL1ub99xmgybMd+EH0m
         FiEUfrim+cP2tGx21p+0SH//fOObl8uS8qITf1H5iB75/PM/TN0RU80GLB3dusWU/MIU
         KKTUegzdt1/YSVEZYCsVJGedE+CFz3xjVT6JgfA1V4yK1G0UxXb8FesHymdNAJzkWR2L
         2soplF8Edy2dtX9h9rny+NTlH/G6ZiPU8F+dx0bTC9RaSu3/G/zkoX7E1dO7O46tXz6X
         piGE5rpJyodx4g89BtDq5vHJeaZMwTkoeJtP1O00/lfqkxU+Cu4RN93ntnxwT33K45PW
         5I8A==
X-Forwarded-Encrypted: i=1; AJvYcCX5iedXfiQRCAUEkcv1GPZMbO6WKDkURet2rgUmy5HpWAxWEQ6IeHp2yM7LIrX/fhESgmh6Oh3a9rKILps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMLBUQ2YanKG5F5tTnSLYxh8qEMrwy8v3iXiM/3HSswGg+jrO
	W1l7hiYiZ5UM1pd9uwyljGZQO/+UA2DLujBUVyHh3gmppITdFUCHtrFWTM3Aowd7NWvCh9V8suk
	dEmbLZJz3fHAKnN8Zyt5DmSO4bV8WPSE5VQvzCA1lcuMgj4Vc14aWgoonHcRP3XN3jBwGj7U4I0
	3p8rurHn65hAKXn2kAEA43BPzFtjYU2N5bXM87DmUN
X-Gm-Gg: ASbGncsPS3POHbBCAQjpQPtGJw02o3px5zJKlY8AODbxzoinhnLKe2dEFVCvx1C4bDp
	FnHn20c6+i/qhWe6yr/VY31eUTxFVcjW0fTdH4/0hUNNUj+gZ48Gp+CW4SsLLpb1oZ10Vp87/6t
	Cx8eSGYLLvOiPcXZrXocQchH0xJHLkzV88WS4ydGMzwwZl4WIzLGy4MUXAWqPMKSEwx9P63w==
X-Received: by 2002:a05:690e:1405:b0:63c:f5a6:f308 with SMTP id 956f58d0204a3-63f6c6be3edmr4184095d50.31.1761706059373;
        Tue, 28 Oct 2025 19:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVsJq5W8R7sT70TPYovDlqz+rtyyBJ9vZ8itjbDB85MOT0ZftJAHwTGtjUh24PfkoVwi9hTpXPs7aXJ7Jzq6g=
X-Received: by 2002:a05:690e:1405:b0:63c:f5a6:f308 with SMTP id
 956f58d0204a3-63f6c6be3edmr4184060d50.31.1761706058849; Tue, 28 Oct 2025
 19:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local> <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com> <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com> <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
In-Reply-To: <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Tue, 28 Oct 2025 20:47:12 -0600
X-Gm-Features: AWmQ_bnjuph0S2IHnCzLzLvJQtkBH9xEZPK558u1lNAN1P5WHxCGuxiWYNQMh8o
Message-ID: <CAA1CXcD1YDAbYzdYfchOWbmUasa3tN55AYroOLJb2EqoQfibvw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:00=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Oct 28, 2025 at 07:08:38PM +0100, David Hildenbrand wrote:
> >
> > > > > Hey Lorenzo,
> > > > >
> > > > > > I mean not to beat a dead horse re: v11 commentary, but I thoug=
ht we were going
> > > > > > to implement David's idea re: the new 'eagerness' tunable, and =
again we're now just
> > > > > > implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> > > > >
> > > > > I spoke to David and he said to continue forward with this series=
; the
> > > > > "eagerness" tunable will take some time, and may require further
> > > > > considerations/discussion.
> > > >
> > > > Right, after talking to Johannes it got clearer that what we envisi=
oned with
> > >
> > > I'm not sure that you meant to say go ahead with the series as-is wit=
h this
> > > silent capping?
> >
> > No, "go ahead" as in "let's find some way forward that works for all an=
d is
> > not too crazy".
>
> Right we clearly needed to discuss that further at the time but that's mo=
ot now,
> we're figuring it out now :)
>
> >
> > [...]
> >
> > > > "eagerness" would not be like swappiness, and we will really have t=
o be
> > > > careful here. I don't know yet when I will have time to look into t=
hat.
> > >
> > > I guess I missed this part of the converastion, what do you mean?
> >
> > Johannes raised issues with that on the list and afterwards we had an
> > offline discussion about some of the details and why something unpredic=
table
> > is not good.
>
> Could we get these details on-list so we can discuss them? This doesn't h=
ave to
> be urgent, but I would like to have a say in this or at least be part of =
the
> converastion please.
>
> >
> > >
> > > The whole concept is that we have a paramaeter whose value is _abstra=
cted_ and
> > > which we control what it means.
> > >
> > > I'm not sure exactly why that would now be problematic? The fundament=
al concept
> > > seems sound no? Last I remember of the conversation this was the case=
.
> >
> > The basic idea was to do something abstracted as swappiness. Turns out
> > "swappiness" is really something predictable, not something we can rand=
omly
> > change how it behaves under the hood.
> >
> > So we'd have to find something similar for "eagerness", and that's wher=
e it
> > stops being easy.
>
> I think we shouldn't be too stuck on
>
> >
> > >
> > > >
> > > > If we want to avoid the implicit capping, I think there are the fol=
lowing
> > > > possible approaches
> > > >
> > > > (1) Tolerate creep for now, maybe warning if the user configures it=
.
> > >
> > > I mean this seems a viable option if there is pressure to land this s=
eries
> > > before we have a viable uAPI for configuring this.
> > >
> > > A part of me thinks we shouldn't rush series in for that reason thoug=
h and
> > > should require that we have a proper control here.
> > >
> > > But I guess this approach is the least-worst as it leaves us with the=
 most
> > > options moving forwards.
> >
> > Yes. There is also the alternative of respecting only 0 / 511 for mTHP
> > collapse for now as discussed in the other thread.
>
> Yes I guess let's carry that on over there.
>
> I mean this is why I said it's better to try to keep things in one thread=
 :) but
> anyway, we've forked and can't be helped now.
>
> To be clear that was a criticism of - email development - not you.
>
> It's _extremely easy_ to have this happen because one thread naturally le=
ads to
> a broader discussion of a given topic, whereas another has questions from
> somebody else about the same topic, to which people reply and then... you=
 have a
> fork and it can't be helped.
>
> I guess I'm saying it'd be good if we could say 'ok let's move this to X'=
.
>
> But that's also broken in its own way, you can't stop people from replyin=
g in
> the other thread still and yeah. It's a limitation of this model :)
>
> >
> > >
> > > > (2) Avoid creep by counting zero-filled pages towards none_or_zero.
> > >
> > > Would this really make all that much difference?
> >
> > It solves the creep problem I think, but it's a bit nasty IMHO.
>
> Ah because you'd end up wtih a bunch of zeroed pages from the prior mTHP
> collapses, interesting...
>
> Scanning for that does seem a bit nasty though yes...
>
> >
> > >
> > > > (3) Have separate toggles for each THP size. Doesn't quite solve th=
e
> > > >      problem, only shifts it.
> > >
> > > Yeah I did wonder about this as an alternative solution. But of cours=
e it then
> > > makes it vague what the parent values means in respect of the individ=
ual levels,
> > > unless we have an 'inherit' mode there too (possible).
> > >
> > > It's going to be confusing though as max_ptes_none sits at the root k=
hugepaged/
> > > level and I don't think any other parameter from khugepaged/ is expos=
ed at
> > > individual page size levels.
> > >
> > > And of course doing this means we
> > >
> > > >
> > > > Anything else?
> > >
> > > Err... I mean I'm not sure if you missed it but I suggested an approa=
ch in the
> > > sub-thread - exposing mthp_max_ptes_none as a _READ-ONLY_ field at:
> > >
> > > /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
> > >
> > > Then we allow the capping, but simply document that we specify what t=
he capped
> > > value will be here for mTHP.
> >
> > I did not have time to read the details on that so far.
>
> OK. It is a bit nasty, yes. The idea is to find something that allows the
> capping to work.
>
> >
> > It would be one solution forward. I dislike it because I think the whol=
e
> > capping is an intermediate thing that can be (and likely must be, when
> > considering mTHP underused shrinking I think) solved in the future
> > differently. That's why I would prefer adding this only if there is no
> > other, simpler, way forward.
>
> Yes I agree that if we could avoid it it'd be great.
>
> Really I proposed this solution on the basis that we were somehow ok with=
 the
> capping.
>
> If we can avoid that'd be ideal as it reduces complexity and 'unexpected'
> behaviour.
>
> We'll clarify on the other thread, but the 511/0 was compelling to me bef=
ore as
> a simplification, and if we can have a straightforward model of how mTHP
> collapse across none/zero page PTEs behaves this is ideal.
>
> The only question is w.r.t. warnings etc. but we can handle details there=
.
>
> >
> > >
> > > That struck me as the simplest way of getting this series landed with=
out
> > > necessarily violating any future eagerness which:
> > >
> > > a. Must still support khugepaged/max_ptes_none - we aren't getting aw=
ay from
> > >     this, it's uAPI.
> > >
> > > b. Surely must want to do different things for mTHP in eagerness, so =
if we're
> > >     exposing some PTE value in max_ptes_none doing so in
> > >     khugepaged/mthp_max_ptes_none wouldn't be problematic (note again=
 - it's
> > >     readonly so unlike max_ptes_none we don't have to worry about the=
 other
> > >     direction).
> > >
> > > HOWEVER, eagerness might want want to change this behaviour per-mTHP =
size, in
> > > which case perhaps mthp_max_ptes_none would be problematic in that it=
 is some
> > > kind of average.
> > >
> > > Then again we could always revert to putting this parameter as in (3)=
 in that
> > > case, ugly but kinda viable.
> > >
> > > >
> > > > IIUC, creep is less of a problem when we have the underused shrinke=
r
> > > > enabled: whatever we over-allocated can (unless longterm-pinned etc=
) get
> > > > reclaimed again.
> > > >
> > > > So maybe having underused-shrinker support for mTHP as well would b=
e a
> > > > solution to tackle (1) later?
> > >
> > > How viable is this in the short term?
> >
> > I once started looking into it, but it will require quite some work, be=
cause
> > the lists will essentially include each and every (m)THP in the system =
...
> > so i think we will need some redesign.
>
> Ack.
>
> This aligns with non-0/511 settings being non-functional for mTHP atm any=
way.
>
> >
> > >
> > > Another possible solution:
> > >
> > > If mthp_max_ptes_none is not workable, we could have a toggle at, e.g=
.:
> > >
> > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_cap_collapse_none
> > >
> > > As a simple boolean. If switched on then we document that it caps mTH=
P as
> > > per Nico's suggestion.
> > >
> > > That way we avoid the 'silent' issue I have with all this and it's an
> > > explicit setting.
> >
> > Right, but it's another toggle I wish we wouldn't need. We could of cou=
rse
> > also make it some compile-time option, but not sure if that's really an=
y
> > better.
> >
> > I'd hope we find an easy way forward that doesn't require new toggles, =
at
> > least for now ...
>
> Right, well I agree if we can make this 0/511 thing work, let's do that.

Ok, great, some consensus! I will go ahead with that solution.

Just to make sure we are all on the same page,

the max_ptes_none value will be treated as 0 for anything other than
PMD collapse, or in the case of 511. Or will the max_ptes_none only
work for mTHP collapse when it is 0.

static unsigned int collapse_max_ptes_none(unsigned int order, bool full_sc=
an)
{
unsigned int max_ptes_none;

/* ignore max_ptes_none limits */
if (full_scan)
return HPAGE_PMD_NR - 1;

if (order =3D=3D HPAGE_PMD_ORDER)
return khugepaged_max_ptes_none;

if (khugepaged_max_ptes_none !=3D HPAGE_PMD_NR - 1)
return 0;

return max_ptes_none >> (HPAGE_PMD_ORDER - order);
}

Here's the implementation for the first approach, looks like Baolin
was able to catch up and beat me to the other solution while I was
mulling over the thread lol

Cheers,
-- Nico


>
> Toggle are just 'least worst' workarounds on assumption of the need for c=
apping.
>
> >
> > --
> > Cheers
> >
> > David / dhildenb
> >
>
> Thanks, Lorenzo
>


