Return-Path: <linux-kernel+bounces-875056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC299C1817C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411C31C61F87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624882EAB72;
	Wed, 29 Oct 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2H7cPYP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3772DE200
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706174; cv=none; b=t8JPpBHM7R5ObotDZrwo0sdWfThLqZ3+5XTRmYcTvZ7vAvtEfyOsVojo7EU9nEXvQcQkiOrZu8ypv92r6Kw6ghNitLmjaMGpWovRM7hVsyZrL2i5Wn5U2gKZ6uRAwbECT2RdNwHAI13aEAM00MUHg8v5gIYAWKn1+qseRYT1Cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706174; c=relaxed/simple;
	bh=bsuAOXJfrfQ3c1AbhH018UrQ4JBjxT7ulNSTbg021M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCpdyOLjyjLCLK3+IlHkteOmNTCbDBVxq6cSZe9EPOwHT2T2sjT2Y/FhXTngBxrun08ZL8jZZcoJuyj2Ki7Izg5jEIHRqOwRYSZSjMiZcy2aL8+JMO+hFAk4o+kftNC8E2Tj99hh34liZNfRAQEq+zHjjrNXLXcDb0V5m7RyaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2H7cPYP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761706171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h92Y7rYw8/HzWuXYRorO2diu575VdZCbMCBzaGVpQUo=;
	b=Q2H7cPYPi4c3XNgFOq3HSNzC+OIgAbk1892PzWaH85wqA0j8qPvig1DaSg4I4K7nZeH1vx
	4pmTGNuUWL38kyP96qYM+lc7cW4qSyxR/J1E82kVvNcfBQFrbG+6Q0nHdMkawnt54XWdAS
	sX+pLv2EOkfXA0LGpIwcL3/4MPZTx+s=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-KE41FwRaPAmYZT4B-z0pUA-1; Tue, 28 Oct 2025 22:49:29 -0400
X-MC-Unique: KE41FwRaPAmYZT4B-z0pUA-1
X-Mimecast-MFC-AGG-ID: KE41FwRaPAmYZT4B-z0pUA_1761706168
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e0b6258bbso7675352d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761706168; x=1762310968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h92Y7rYw8/HzWuXYRorO2diu575VdZCbMCBzaGVpQUo=;
        b=IjmjT4YRrIDaTRG5r71d03vtUMm3SrjBGrG7MN417ogEZTcBty6/EMAqGjCM1D3fuq
         rC6xLUO2hgfVePeYZaUEN9TzwN/JjFV0XuiOs5x4n03uEQsF+zcxtU7IGhyg02SmwDKU
         xbvqQO4cXNn+Vxy0mGK1Skcgb0IoyUbY2jZqPH3JY+66aEWwM907vmxjbbpuqK3mkrr6
         yXaJhRx6l1gfWtwE0ikann26oxN6jrYr5aLO0acDWSPY0mQYhjVf4EfnSW6CX52ETazx
         y5Ws+NfHIloB0PGBebkv2XjiEYayIS9oJAviZXq2Nf9fv7u7IC0fZHv7sOyyKHGE41YU
         KZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWG1cCSNIk4N3xFZoZDj5kXB+l/m2Rh6Pw7xst9weqfIldr4Cx9hEUMthq4jYsOHEV+MT4/OTG6olJ4tws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrSJZxgodEdSyoCnp6HTmWjl7FK4p3xR2OBxm7m1LyG90ai7x
	U+b9QrPS5V09Q6iZngfaNBP0miDLcr+rvt+UtTjc1pzMkmAXSvGR7Ok9aVQylXMENxm1f+A60XA
	WHq3bX+ZBPT/ugJyFpAh205LWEQ6ciR5bugr9C9eWkLK3UWAvZ1PGuzd/XXyvLJybmvOqufhpw/
	KhvyecfkFGT+LSbDewLu/XIifLGqzm/gxPftv/OAB0
X-Gm-Gg: ASbGncstQiKhNi0pLNdaL8ZhblkjyU4pHCfZHDGn6TEbFEvPZ4ReaXbdg59M/acSqMa
	zMDeyjv7QjReINUI+V/x+nR2puj5xfOnDkVUOn9Z5yZyJ1OAbizIKP83jxNPGvD3QawekFt0fU3
	BcRnAIkdkZwRlqc2EdWetre1i564uccJB1xB79jJQRDCQKuHRdtstw6fDiEZFjwkDUjGjbCg==
X-Received: by 2002:a05:690e:250f:20b0:636:1fd9:1bc with SMTP id 956f58d0204a3-63f76cf06f3mr1198949d50.8.1761706168442;
        Tue, 28 Oct 2025 19:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2+S+SqyFRMMqZ9BBcbxZaKLM353wYfwsnFYvTcCq0eXDyRqvVmPjvLYl+RF0WlG3mbRYFqAF0GqQcXTMDS+k=
X-Received: by 2002:a05:690e:250f:20b0:636:1fd9:1bc with SMTP id
 956f58d0204a3-63f76cf06f3mr1198906d50.8.1761706167985; Tue, 28 Oct 2025
 19:49:27 -0700 (PDT)
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
 <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com>
In-Reply-To: <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 28 Oct 2025 20:49:02 -0600
X-Gm-Features: AWmQ_blp9IluDmjAtMCdM5r156SzdEbYsEIrditchlutrZSTUbtfV3Xp8PTzX2E
Message-ID: <CAA1CXcDZoJEFi2_aDbOa19=zHZstV-v+i2z3bDxB8bin=6m3Dw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com, 
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

On Tue, Oct 28, 2025 at 8:10=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/10/29 02:59, Lorenzo Stoakes wrote:
> > On Tue, Oct 28, 2025 at 07:08:38PM +0100, David Hildenbrand wrote:
> >>
> >>>>> Hey Lorenzo,
> >>>>>
> >>>>>> I mean not to beat a dead horse re: v11 commentary, but I thought =
we were going
> >>>>>> to implement David's idea re: the new 'eagerness' tunable, and aga=
in we're now just
> >>>>>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> >>>>>
> >>>>> I spoke to David and he said to continue forward with this series; =
the
> >>>>> "eagerness" tunable will take some time, and may require further
> >>>>> considerations/discussion.
> >>>>
> >>>> Right, after talking to Johannes it got clearer that what we envisio=
ned with
> >>>
> >>> I'm not sure that you meant to say go ahead with the series as-is wit=
h this
> >>> silent capping?
> >>
> >> No, "go ahead" as in "let's find some way forward that works for all a=
nd is
> >> not too crazy".
> >
> > Right we clearly needed to discuss that further at the time but that's =
moot now,
> > we're figuring it out now :)
> >
> >>
> >> [...]
> >>
> >>>> "eagerness" would not be like swappiness, and we will really have to=
 be
> >>>> careful here. I don't know yet when I will have time to look into th=
at.
> >>>
> >>> I guess I missed this part of the converastion, what do you mean?
> >>
> >> Johannes raised issues with that on the list and afterwards we had an
> >> offline discussion about some of the details and why something unpredi=
ctable
> >> is not good.
> >
> > Could we get these details on-list so we can discuss them? This doesn't=
 have to
> > be urgent, but I would like to have a say in this or at least be part o=
f the
> > converastion please.
> >
> >>
> >>>
> >>> The whole concept is that we have a paramaeter whose value is _abstra=
cted_ and
> >>> which we control what it means.
> >>>
> >>> I'm not sure exactly why that would now be problematic? The fundament=
al concept
> >>> seems sound no? Last I remember of the conversation this was the case=
.
> >>
> >> The basic idea was to do something abstracted as swappiness. Turns out
> >> "swappiness" is really something predictable, not something we can ran=
domly
> >> change how it behaves under the hood.
> >>
> >> So we'd have to find something similar for "eagerness", and that's whe=
re it
> >> stops being easy.
> >
> > I think we shouldn't be too stuck on
> >
> >>
> >>>
> >>>>
> >>>> If we want to avoid the implicit capping, I think there are the foll=
owing
> >>>> possible approaches
> >>>>
> >>>> (1) Tolerate creep for now, maybe warning if the user configures it.
> >>>
> >>> I mean this seems a viable option if there is pressure to land this s=
eries
> >>> before we have a viable uAPI for configuring this.
> >>>
> >>> A part of me thinks we shouldn't rush series in for that reason thoug=
h and
> >>> should require that we have a proper control here.
> >>>
> >>> But I guess this approach is the least-worst as it leaves us with the=
 most
> >>> options moving forwards.
> >>
> >> Yes. There is also the alternative of respecting only 0 / 511 for mTHP
> >> collapse for now as discussed in the other thread.
> >
> > Yes I guess let's carry that on over there.
> >
> > I mean this is why I said it's better to try to keep things in one thre=
ad :) but
> > anyway, we've forked and can't be helped now.
> >
> > To be clear that was a criticism of - email development - not you.
> >
> > It's _extremely easy_ to have this happen because one thread naturally =
leads to
> > a broader discussion of a given topic, whereas another has questions fr=
om
> > somebody else about the same topic, to which people reply and then... y=
ou have a
> > fork and it can't be helped.
> >
> > I guess I'm saying it'd be good if we could say 'ok let's move this to =
X'.
> >
> > But that's also broken in its own way, you can't stop people from reply=
ing in
> > the other thread still and yeah. It's a limitation of this model :)
> >
> >>
> >>>
> >>>> (2) Avoid creep by counting zero-filled pages towards none_or_zero.
> >>>
> >>> Would this really make all that much difference?
> >>
> >> It solves the creep problem I think, but it's a bit nasty IMHO.
> >
> > Ah because you'd end up wtih a bunch of zeroed pages from the prior mTH=
P
> > collapses, interesting...
> >
> > Scanning for that does seem a bit nasty though yes...
> >
> >>
> >>>
> >>>> (3) Have separate toggles for each THP size. Doesn't quite solve the
> >>>>       problem, only shifts it.
> >>>
> >>> Yeah I did wonder about this as an alternative solution. But of cours=
e it then
> >>> makes it vague what the parent values means in respect of the individ=
ual levels,
> >>> unless we have an 'inherit' mode there too (possible).
> >>>
> >>> It's going to be confusing though as max_ptes_none sits at the root k=
hugepaged/
> >>> level and I don't think any other parameter from khugepaged/ is expos=
ed at
> >>> individual page size levels.
> >>>
> >>> And of course doing this means we
> >>>
> >>>>
> >>>> Anything else?
> >>>
> >>> Err... I mean I'm not sure if you missed it but I suggested an approa=
ch in the
> >>> sub-thread - exposing mthp_max_ptes_none as a _READ-ONLY_ field at:
> >>>
> >>> /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
> >>>
> >>> Then we allow the capping, but simply document that we specify what t=
he capped
> >>> value will be here for mTHP.
> >>
> >> I did not have time to read the details on that so far.
> >
> > OK. It is a bit nasty, yes. The idea is to find something that allows t=
he
> > capping to work.
> >
> >>
> >> It would be one solution forward. I dislike it because I think the who=
le
> >> capping is an intermediate thing that can be (and likely must be, when
> >> considering mTHP underused shrinking I think) solved in the future
> >> differently. That's why I would prefer adding this only if there is no
> >> other, simpler, way forward.
> >
> > Yes I agree that if we could avoid it it'd be great.
> >
> > Really I proposed this solution on the basis that we were somehow ok wi=
th the
> > capping.
> >
> > If we can avoid that'd be ideal as it reduces complexity and 'unexpecte=
d'
> > behaviour.
> >
> > We'll clarify on the other thread, but the 511/0 was compelling to me b=
efore as
> > a simplification, and if we can have a straightforward model of how mTH=
P
> > collapse across none/zero page PTEs behaves this is ideal.
> >
> > The only question is w.r.t. warnings etc. but we can handle details the=
re.
> >
> >>
> >>>
> >>> That struck me as the simplest way of getting this series landed with=
out
> >>> necessarily violating any future eagerness which:
> >>>
> >>> a. Must still support khugepaged/max_ptes_none - we aren't getting aw=
ay from
> >>>      this, it's uAPI.
> >>>
> >>> b. Surely must want to do different things for mTHP in eagerness, so =
if we're
> >>>      exposing some PTE value in max_ptes_none doing so in
> >>>      khugepaged/mthp_max_ptes_none wouldn't be problematic (note agai=
n - it's
> >>>      readonly so unlike max_ptes_none we don't have to worry about th=
e other
> >>>      direction).
> >>>
> >>> HOWEVER, eagerness might want want to change this behaviour per-mTHP =
size, in
> >>> which case perhaps mthp_max_ptes_none would be problematic in that it=
 is some
> >>> kind of average.
> >>>
> >>> Then again we could always revert to putting this parameter as in (3)=
 in that
> >>> case, ugly but kinda viable.
> >>>
> >>>>
> >>>> IIUC, creep is less of a problem when we have the underused shrinker
> >>>> enabled: whatever we over-allocated can (unless longterm-pinned etc)=
 get
> >>>> reclaimed again.
> >>>>
> >>>> So maybe having underused-shrinker support for mTHP as well would be=
 a
> >>>> solution to tackle (1) later?
> >>>
> >>> How viable is this in the short term?
> >>
> >> I once started looking into it, but it will require quite some work, b=
ecause
> >> the lists will essentially include each and every (m)THP in the system=
 ...
> >> so i think we will need some redesign.
> >
> > Ack.
> >
> > This aligns with non-0/511 settings being non-functional for mTHP atm a=
nyway.
> >
> >>
> >>>
> >>> Another possible solution:
> >>>
> >>> If mthp_max_ptes_none is not workable, we could have a toggle at, e.g=
.:
> >>>
> >>> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_cap_collapse_none
> >>>
> >>> As a simple boolean. If switched on then we document that it caps mTH=
P as
> >>> per Nico's suggestion.
> >>>
> >>> That way we avoid the 'silent' issue I have with all this and it's an
> >>> explicit setting.
> >>
> >> Right, but it's another toggle I wish we wouldn't need. We could of co=
urse
> >> also make it some compile-time option, but not sure if that's really a=
ny
> >> better.
> >>
> >> I'd hope we find an easy way forward that doesn't require new toggles,=
 at
> >> least for now ...
> >
> > Right, well I agree if we can make this 0/511 thing work, let's do that=
.
> >
> > Toggle are just 'least worst' workarounds on assumption of the need for=
 capping.
>
> I finally finished reading through the discussions across multiple
> threads:), and it looks like we've reached a preliminary consensus (make
> 0/511 work). Great and thanks!
>
> IIUC, the strategy is, configuring it to 511 means always enabling mTHP
> collapse, configuring it to 0 means collapsing mTHP only if all PTEs are
> non-none/zero, and for other values, we issue a warning and prohibit
> mTHP collapse (avoid Lorenzo's concern about silently changing
> max_ptes_none). Then the implementation for collapse_max_ptes_none()
> should be as follows:
>
> static int collapse_max_ptes_none(unsigned int order, bool full_scan)
> {
>          /* ignore max_ptes_none limits */
>          if (full_scan)
>                  return HPAGE_PMD_NR - 1;
>
>          if (order =3D=3D HPAGE_PMD_ORDER)
>                  return khugepaged_max_ptes_none;
>
>          /*
>           * To prevent creeping towards larger order collapses for mTHP
> collapse,
>           * we restrict khugepaged_max_ptes_none to only 511 or 0,
> simplifying the
>           * logic. This means:
>           * max_ptes_none =3D=3D 511 -> collapse mTHP always
>           * max_ptes_none =3D=3D 0 -> collapse mTHP only if we all PTEs a=
re
> non-none/zero
>           */
>          if (!khugepaged_max_ptes_none || khugepaged_max_ptes_none =3D=3D
> HPAGE_PMD_NR - 1)
>                  return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER -
> order);
>
>          pr_warn_once("mTHP collapse only supports
> khugepaged_max_ptes_none configured as 0 or %d\n", HPAGE_PMD_NR - 1);
>          return -EINVAL;
> }
>
> So what do you think?

Yes i'm glad we finally came to some consensus, despite it being a
less than ideal solution.

Hopefully the eagerness patchset re-introduces all the lost
functionality in the future.

Cheers
-- Nico

>


