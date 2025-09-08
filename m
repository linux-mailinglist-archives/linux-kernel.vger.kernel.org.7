Return-Path: <linux-kernel+bounces-806473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638EAB49783
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146772079C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2330ACF0;
	Mon,  8 Sep 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yu6J7XTP"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D943AA4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353640; cv=none; b=fDxBAMQcUOArpwuNAxTd0FIt55c+i2on3yGkMl/9QDzUJOCdOysr8VFQFZE+1xD7XO4jDS7XaannOfRQqITjLEVhLefHvZO+b48MMJAgQfKbfze0IOWTASxwjo9QVlhhNZH4+/avzyfr913o1i53jrgo4cevtbg3iHzG+d6oCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353640; c=relaxed/simple;
	bh=siEsv2pirHTuHZt6M2d3vtcT7Pnt/qFkT+meHrSYc7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3HuuZZec/MPF6u1pZ4pSlVU8Uc3LEHa7OULBJjQvucqYFfhEvmfWh3rFy+Bjy5x5V2vsuA1Bix7CZQz8BHG6oL5RNiWT9D8U06b+7GTOlnf7hGFGQU7MNSA8LV4fa3ET7GWP2R20XKAXJca+qMygeTtflJJ4jSglryOEquC+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yu6J7XTP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b48fc1d998so566101cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757353638; x=1757958438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siEsv2pirHTuHZt6M2d3vtcT7Pnt/qFkT+meHrSYc7I=;
        b=Yu6J7XTPPxqRIt0VsMOmpJxex4NSuQGiKezOXf2j7Xul0wWoDwcR2gFuqi3gIhjYRI
         kzY+K06E68FnaQ5w7FA/8FcTPKXbQT5zfyydCiNT7vUxQCgR0PBSghGRFS8aHLEExfJU
         xAkvzSLgsGIRiQ9CFMzgcwN5QEsFeGbu1ZXrl6qwIKf3eDTcmHsVHeLN5Dg8E3AnBiXo
         FXH6HSoEBHQQoMfj3pL3lL9zTX1O8vX+HELQ/dvN82OYqR1qT/M+PsITswJ8EajpUr8J
         LHcCGrX0Mi6g3prEXFr8mDuneqky1nwwCIhkkIYTPsF52uiEL4psTj9WNuPrxSRIzica
         SIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757353638; x=1757958438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siEsv2pirHTuHZt6M2d3vtcT7Pnt/qFkT+meHrSYc7I=;
        b=mar+D5IQVAOh2qLfNViXqyiBJetkyUX8gkpxktn2p+aO/4SYHCV5Xp6ltgCI2wIdu6
         gSKWeD/8F6RsYro0r9fk2RVCEzbeCzWkr+N69UZ2yScS2hlwm7IM3FSvLfFmQq2nmJme
         dYAvLkyaM14XDObHFqSKsBDJJfNdKukLMtxOgXoLNEjwuJakxgqxzumSBQOffWPuNkFH
         UEAifz5hBmeko7u8a81f0YBy5yJnU91+giI78Mm2OD8N6GOBHoHds8mgeOHIG/RPFaRK
         G9CrhhOl8yBgIwIuXxQMTIZp7qbufcHIIUVI31qt9IW3iVtVvtBjqFjj0g/c6Y0AKBTN
         lOsA==
X-Forwarded-Encrypted: i=1; AJvYcCV8QnGwICujsl854zswBWrwZHE3bR4qFZMIGGxGzQtYgUIru7X3aqBIWH94gle2asDwkm6qMa2/UczAHBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7/OOz7WcP5HUWE407mhaeqCR/wqN1gAhFd9b0UnBHcz5GAwB
	xnQVeU2TfcjwBUL5TjIh20WSr0MWoz1AjPVd3H4PxfXP3GrPHaSIlWNd4mH1J1KBiVrEd0+Odl6
	g4Ny3XzfMSNHJghBn94XsuTLVlUkjV0LqCAbciB4r
X-Gm-Gg: ASbGnctALLAUURoLSkRNNGrn8eSfsJKin0NzZ5e9nbgLWp50jwU1qJoykYknPFx8ij5
	Kt1hMZao628OlpeUOmxmJLG80Al7zQRTmIKrz44fbMw09s+bIUpXVH9pPqMuUXuomN/jW1HoNr5
	S0HNhBgdZ5SSlIsxRPfdl/BLT7tofFK10sIwHSk6jTBE1ZyTT+XBIBw78nNOZFemuxVTrjxEYJW
	6ShkI3/AQm/
X-Google-Smtp-Source: AGHT+IHBpoBHctX0ggJPD9Xzmyyd8HgpBtBxge974et/uW/ujee4+Lwr6N52wAFhOd568mp126yqL4bB50l9eB9dkl4=
X-Received: by 2002:a05:622a:1a9b:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4b5f83a34bcmr11651441cf.7.1757353637363; Mon, 08 Sep 2025
 10:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com> <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka> <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
In-Reply-To: <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Sep 2025 10:47:06 -0700
X-Gm-Features: AS18NWBVRSHhKmkbky6crK-2Tia3zeDy6qS8rf1MalWs3LSVJvFAqHjRkt7WLkg
Message-ID: <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Yueyang Pan <pyyjason@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sourav Panda <souravpanda@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Aug 29, 2025 at 08:35:08AM +0200, Michal Hocko wrote:
> > On Tue 26-08-25 19:38:03, Suren Baghdasaryan wrote:
> > > On Tue, Aug 26, 2025 at 7:06=E2=80=AFAM Yueyang Pan <pyyjason@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Aug 21, 2025 at 12:53:03PM -0700, Shakeel Butt wrote:
> > > > > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > > > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > > > > Right now in the oom_kill_process if the oom is because of =
the cgroup
> > > > > > > > limit, we won't get memory allocation infomation. In some c=
ases, we
> > > > > > > > can have a large cgroup workload running which dominates th=
e machine.
> > > > > > > > The reason using cgroup is to leave some resource for syste=
m. When this
> > > > > > > > cgroup is killed, we would also like to have some memory al=
location
> > > > > > > > information for the whole server as well. This is reason be=
hind this
> > > > > > > > mini change. Is it an acceptable thing to do? Will it be to=
o much
> > > > > > > > information for people? I am happy with any suggestions!
> > > > > > >
> > > > > > > For a single patch, it is better to have all the context in t=
he patch
> > > > > > > and there is no need for cover letter.
> > > > > >
> > > > > > Thanks for your suggestion Shakeel! I will change this in the n=
ext version.
> > > > > >
> > > > > > >
> > > > > > > What exact information you want on the memcg oom that will be=
 helpful
> > > > > > > for the users in general? You mentioned memory allocation inf=
ormation,
> > > > > > > can you please elaborate a bit more.
> > > > > > >
> > > > > >
> > > > > > As in my reply to Suren, I was thinking the system-wide memory =
usage info
> > > > > > provided by show_free_pages and memory allocation profiling inf=
o can help
> > > > > > us debug cgoom by comparing them with historical data. What is =
your take on
> > > > > > this?
> > > > > >
> > > > >
> > > > > I am not really sure about show_free_areas(). More specifically h=
ow the
> > > > > historical data diff will be useful for a memcg oom. If you have =
a
> > > > > concrete example, please give one. For memory allocation profilin=
g, is
> > > >
> > > > Sorry for my late reply. I have been trying hard to think about a u=
se case.
> > > > One specific case I can think about is when there is no workload st=
acking,
> > > > when one job is running solely on the machine. For example, memory =
allocation
> > > > profiling can tell the memory usage of the network driver, which ca=
n make
> > > > cg allocates memory harder and eventually leads to cgoom. Without t=
his
> > > > information, it would be hard to reason about what is happening in =
the kernel
> > > > given increased oom number.
> > > >
> > > > show_free_areas() will give a summary of different types of memory =
which
> > > > can possibably lead to increased cgoom in my previous case. Then on=
e looks
> > > > deeper via the memory allocation profiling as an entrypoint to debu=
g.
> > > >
> > > > Does this make sense to you?
> > >
> > > I think if we had per-memcg memory profiling that would make sense.
> > > Counters would reflect only allocations made by the processes from
> > > that memcg and you could easily identify the allocation that caused
> > > memcg to oom. But dumping system-wide profiling information at
> > > memcg-oom time I think would not help you with this task. It will be
> > > polluted with allocations from other memcgs, so likely won't help muc=
h
> > > (unless there is some obvious leak or you know that a specific
> > > allocation is done only by a process from your memcg and no other
> > > process).
> >
> > I agree with Suren. It makes very little sense and in many cases it
> > could be actively misleading to print global memory state on memcg OOMs=
.
> > Not to mention that those events, unlike global OOMs, could happen much
> > more often.
> > If you are interested in a more information on memcg oom occurance you
> > can detext OOM events and print whatever information you need.
>
> "Misleading" is a concern; the show_mem report would want to print very
> explicitly which information is specifically for the memcg and which is
> global, and we don't do that now.
>
> I don't think that means we shouldn't print it at all though, because it
> can happen that we're in an OOM because one specific codepath is
> allocating way more memory than we should be; even if the memory
> allocation profiling info isn't correct for the memcg it'll be useful
> information in a situation like that, it just needs to very clearly
> state what it's reporting on.
>
> I'm not sure we do that very well at all now, I'm looking at
> __show_mem() ad it's not even passed a memcg. !?
>
> Also, if anyone's thinking about "what if memory allocation profiling
> was memcg aware" - the thing we saw when doing performance testing is
> that memcg accounting was much higher overhead than memory allocation
> profiling - hence, most kernel memory allocations don't even get memcg
> accounting.
>
> I think that got the memcg people looking at ways to make the accounting
> cheaper, but I'm not sure if anything landed from that.

Yes, Roman landed a series of changes reducing the memcg accounting overhea=
d.

