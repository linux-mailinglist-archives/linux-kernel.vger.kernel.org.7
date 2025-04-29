Return-Path: <linux-kernel+bounces-625754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E17AA1C39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D054A57FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC084265628;
	Tue, 29 Apr 2025 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJTtreEY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBDF219E93
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958800; cv=none; b=Dpj+E2sMMeb/parrhDMOjYh2nbPnmIaUT2iexUG6U2dGoqX35UAyGPh/eq6Qf29H06K9O21cdemC5YD4P0L09hBxdkXcH4MId0figQZ/23dnm8xfhaIsA+hUC65+wPdeS9JKf5ElvN7PCJKPTxOALExFe6NK5ti79jn1c5pScgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958800; c=relaxed/simple;
	bh=3/CUJIs+JRvVspffRj6ZGRTR6X6h0zQfLy2IiLb4+yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjnLvqMvrQo+QxHO8h6M4CfGAOPsxOk306nBgy7vWCEQbCZz0apFBOqdoSFKt92nYl1Lh3UcGuvvUQyhZMozJP1k30C1LxFE0xxNBqZxxStoM8v83Xpk+7yMfUO02OoNartKUnkc6K4JoAoeDjxt8Fw6s3ildF+ERs7zkY4l6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJTtreEY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774611d40bso347561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745958798; x=1746563598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RuHqTNBtcvgW69uG+veZI2+mQpj/OYd2zcCul6gKi8=;
        b=gJTtreEYX5hxAOQxn80wiy0lcl9Kx+CmTbcBk174vwcjgaYX7CPOW3y7jv97l91Zxj
         X6105lsErg1wWKPHkd65nkKMIRS51su1NGnvJOp8142t5yX2IQl9+/CZQrvUWg05B8KK
         8IOEcCYv8dL4JE7dSg3llRcrNAfcsxnA+K/jejqUfXjNNDk3oD58xgY4gtUcvrjxY7xT
         7iyw4APg4YzPHSZd/rJGQEo8kKoAKbBgwmQJk+kOg4Rk7QoD48jwpNavoowpakrH3YeO
         Nakw3hG2+tKUry+p787R5s7bC2La/92bQGX2NLaQ09EOaZeMdBCwe+BHSfraGxg32WOz
         84gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745958798; x=1746563598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RuHqTNBtcvgW69uG+veZI2+mQpj/OYd2zcCul6gKi8=;
        b=arku8Nql38GiHfJyy8ENd/6PmvbgfDuhgOj1NfeRnD5GtI49+hygpQMgi9R0K++M/t
         y330RxbC7TDcP56VBHzuuZyt+aDXxh4x+dO+uy7VyvbsCxMWIQ1ZB9e0lU+6B1US8iNI
         blzR3q6Lj1XpVr1u+mpcIxhNXjoD8eCN8/5yvnP1K2YhpedOTO+TcVfbnsSCknQiXswA
         clLm/Va+FunkoxtKfv/BesGgmKGYBMbyrv4enjL+xrtg1iRfBcNw6L5W/rXKsM8tjbqq
         W9giEyH0Q/oYvErMww+Ljyz8BdBit3K4Uu8rs1ARGB+sdYB7qYWVjJi8FWX58xgk2baF
         kcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVKlvjZquuStQons2Lai0trWDxUPHXotsk5nI9eJvunS/31YxltB+ffglDLJfx11j4WSSq5yOwXLR7xSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvb9Wht/eVnqAQ6ER5MjfWjbo48WuISNtFoGY7yvZoeZwb/pxp
	5gT5lWLmWb/Qu3DAMZxpeVPbJdF5Tr9/kyrcWJVyjRZfZ4TF/p2QMnuN0NfEnPcPLNMbFpa51CF
	YU2kDSbBvtgxv2MR+IPsxvU31jwJf75rgpi23
X-Gm-Gg: ASbGnct6Mo3Z+eDB8Dq+Zm8nvezTHskTJip2vYfvbrHsqlmr2pQUDyDPwrnhJNAbdby
	aAQWcZJR/W2natUGFN1RiP7HTkOUxRrE3gQ/uR2yehWK2il3XZ818dsn09/hBTe9OE13uhfngeg
	dBwj5QF6OEViomwSDUXzzqNP3PVxmAB+FfkRzw50s79rd5oSsaeSD09MCJU0OeAW0=
X-Google-Smtp-Source: AGHT+IFfAqUaqm8TlmxiDs/TpA8pVnnKtFrG+o0jmeCwd2WChU9Uegcp05S3xNJHn3OsPIEFvPnGKyo2zqt4PAryZbg=
X-Received: by 2002:ac8:578b:0:b0:489:7ea9:4263 with SMTP id
 d75a77b69052e-489b9838a60mr982441cf.10.1745958797430; Tue, 29 Apr 2025
 13:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
 <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
 <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com> <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com>
In-Reply-To: <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 13:33:05 -0700
X-Gm-Features: ATxdqUEe002VsMDCR8tZV7bMaBYZb2LRjVYTvWo45vIOB09sAK6-nvvtt3xxSRU
Message-ID: <CAJuCfpFA0Kqt_KOceq6bxbJG80z-RaxcFbC+-59F_sPOXAorQA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:55=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Tue, Apr 29, 2025 at 8:04=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Tue, Apr 29, 2025 at 10:21=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> > >
> > > Hi!
> > >
> > > (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> > > (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow I
> > > forgot all about that...)
> >
> > Does this fact affect your previous comments? Just want to make sure
> > I'm not missing something...
>
> When I suggested using "WRITE_ONCE(vma->vm_file, NULL)" when tearing
> down a VMA, and using get_file_rcu() for the lockless lookup, I did
> not realize that you could actually also race with all the other
> places that set ->vm_file, like __mmap_new_file_vma() and so on; and I
> did not think about whether any of those code paths might leave a VMA
> with a dangling ->vm_file pointer.

So, let me summarize my understanding and see if it's correct.

If we copy the original vma, ensure that it hasn't changed while we
were copying (with mmap_lock_speculate_retry()) and then use
get_file_rcu(&copy->vm_file) I think we are guaranteed no UAF because
we are in RCU read section. At this point the only issue is that
copy->vm_file might have lost its last refcount and get_file_rcu()
would enter an infinite loop. So, to avoid that we have to use the
original vma when calling get_file_rcu() but then we should also
ensure that vma itself does not change from under us due to
SLAB_TYPESAFE_BY_RCU used for vm_area_struct cache. If it does change
from under us we might end up accessing an invalid address if
vma->vm_file is being modified concurrently.

>
> I guess maybe that means you really do need to do the lookup from the
> copied data, as you did in your patch; and that might require calling
> get_file_active() on the copied ->vm_file pointer (instead of
> get_file_rcu()), even though I think that is not really how
> get_file_active() is supposed to be used (it's supposed to be used
> when you know the original file hasn't been freed yet). Really what
> you'd want for that is basically a raw __get_file_rcu(), but that is
> static and I think Christian wouldn't want to expose more of these
> internals outside VFS...
> (In that case, all the stuff below about get_file_rcu() would be moot.)
>
> Or you could pepper WRITE_ONCE() over all the places that write
> ->vm_file, and ensure that ->vm_file is always NULLed before its
> reference is dropped... but that seems a bit more ugly to me.

Ugh, yes. We either ensure no vma->vm_file tearing or use
__get_file_rcu() on a copy of the vma. Or we have to stabilize the vma
by locking it... Let me think about all these options. Thanks!

>
> > > On Tue, Apr 29, 2025 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > > On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.com=
> wrote:
> > > > > On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > > With maple_tree supporting vma tree traversal under RCU and vma=
 and
> > > > > > its important members being RCU-safe, /proc/pid/maps can be rea=
d under
> > > > > > RCU and without the need to read-lock mmap_lock. However vma co=
ntent
> > > > > > can change from under us, therefore we make a copy of the vma a=
nd we
> > > > > > pin pointer fields used when generating the output (currently o=
nly
> > > > > > vm_file and anon_name). Afterwards we check for concurrent addr=
ess
> > > > > > space modifications, wait for them to end and retry. While we t=
ake
> > > > > > the mmap_lock for reading during such contention, we do that mo=
mentarily
> > > > > > only to record new mm_wr_seq counter. This change is designed t=
o reduce
> > > > > > mmap_lock contention and prevent a process reading /proc/pid/ma=
ps files
> > > > > > (often a low priority task, such as monitoring/data collection =
services)
> > > > > > from blocking address space updates.
> > > > > [...]
> > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > > > > --- a/fs/proc/task_mmu.c
> > > > > > +++ b/fs/proc/task_mmu.c
> > > > > [...]
> > > > > > +/*
> > > > > > + * Take VMA snapshot and pin vm_file and anon_name as they are=
 used by
> > > > > > + * show_map_vma.
> > > > > > + */
> > > > > > +static int get_vma_snapshot(struct proc_maps_private *priv, st=
ruct vm_area_struct *vma)
> > > > > > +{
> > > > > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > > > > +       int ret =3D -EAGAIN;
> > > > > > +
> > > > > > +       memcpy(copy, vma, sizeof(*vma));
> > > > > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > > > > +               goto out;
> > > > >
> > > > > I think this uses get_file_rcu() in a different way than intended=
.
> > > > >
> > > > > As I understand it, get_file_rcu() is supposed to be called on a
> > > > > pointer which always points to a file with a non-zero refcount (e=
xcept
> > > > > when it is NULL). That's why it takes a file** instead of a file*=
 - if
> > > > > it observes a zero refcount, it assumes that the pointer must hav=
e
> > > > > been updated in the meantime, and retries. Calling get_file_rcu()=
 on a
> > > > > pointer that points to a file with zero refcount, which I think c=
an
> > > > > happen with this patch, will cause an endless loop.
> > > > > (Just as background: For other usecases, get_file_rcu() is suppos=
ed to
> > > > > still behave nicely and not spuriously return NULL when the file*=
 is
> > > > > concurrently updated to point to another file*; that's what that =
loop
> > > > > is for.)
> > > >
> > > > Ah, I see. I wasn't aware of this subtlety. I think this is fixable=
 by
> > > > checking the return value of get_file_rcu() and retrying speculatio=
n
> > > > if it changed.
> > >
> > > I think you could probably still end up looping endlessly in get_file=
_rcu().
>
> (Just to be clear: What I meant here is that get_file_rcu() loops
> *internally*; get_file_rcu() is not guaranteed to ever return if the
> pointed-to file has a zero refcount.)
>
> > By "retrying speculation" I meant it in the sense of
> > get_vma_snapshot() retry when it takes the mmap_read_lock and then
> > does mmap_lock_speculate_try_begin to restart speculation. I'm also
> > thinking about Liam's concern of guaranteeing forward progress for the
> > reader. Thinking maybe I should not drop mmap_read_lock immediately on
> > contention but generate some output (one vma or one page worth of
> > vmas) before dropping mmap_read_lock and proceeding with speculation.
>
> Hm, yeah, I guess you need that for forward progress...
>
> > > > > (If my understanding is correct, maybe we should document that mo=
re
> > > > > explicitly...)
> > > >
> > > > Good point. I'll add comments for get_file_rcu() as a separate patc=
h.
> > > >
> > > > >
> > > > > Also, I think you are introducing an implicit assumption that
> > > > > remove_vma() does not NULL out the ->vm_file pointer (because tha=
t
> > > > > could cause tearing and could theoretically lead to a torn pointe=
r
> > > > > being accessed here).
> > > > >
> > > > > One alternative might be to change the paths that drop references=
 to
> > > > > vma->vm_file (search for vma_close to find them) such that they f=
irst
> > > > > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after th=
at,
> > > > > maybe with a new helper like this:
> > > > >
> > > > > static void vma_fput(struct vm_area_struct *vma)
> > > > > {
> > > > >   struct file *file =3D vma->vm_file;
> > > > >
> > > > >   if (file) {
> > > > >     WRITE_ONCE(vma->vm_file, NULL);
> > > > >     fput(file);
> > > > >   }
> > > > > }
> > > > >
> > > > > Then on the lockless lookup path you could use get_file_rcu() on =
the
> > > > > ->vm_file pointer _of the original VMA_, and store the returned f=
ile*
> > > > > into copy->vm_file.
> > > >
> > > > Ack. Except for storing the return value of get_file_rcu(). I think
> > > > once we detect that  get_file_rcu() returns a different file we sho=
uld
> > > > bail out and retry. The change in file is an indication that the vm=
a
> > > > got changed from under us, so whatever we have is stale.
> > >
> > > What does "different file" mean here - what file* would you compare
> > > the returned one against?
> >
> > Inside get_vma_snapshot() I would pass the original vma->vm_file to
> > get_file_rcu() and check if it returns the same value. If the value
> > got changed we jump to  /* Address space got modified, vma might be
> > stale. Re-lock and retry. */ section. That should work, right?
>
> Where do you get an "original vma->vm_file" from?
>
> To be clear, get_file_rcu(p) returns one of the values that *p had
> while get_file_rcu(p) is running.

``````

