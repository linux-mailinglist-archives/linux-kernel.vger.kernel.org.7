Return-Path: <linux-kernel+bounces-748424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A612BB14112
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9942F1663A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40132275865;
	Mon, 28 Jul 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="px+KPdas"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1F1F4606
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722888; cv=none; b=RKx6z2yV458j+Mrjaq5qaWupz8kspvubkpj+wWJGuJF7IEMxhHLNnQ0wqqhhveVfdWXFucSgex6jRj8rZC+kKkTTOSEI0AlAhQ2cxbAfThAuA//W0RoeuNgaiI2PnACdk4Ia8RjvOJxayo9yfl6mIZH6Nu03fLcPlYD1+uinvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722888; c=relaxed/simple;
	bh=YePw+ur+BCoo8sm0kyxEpDL6zMyyNBj7pMYmP8fOofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRR2c9knNf6HS2fauwX1ENoHsnO028UpQDstlEE/BWHTT1h4xXyQjtsaw0fCHnUkOr142//VHLw0k7C+n/6XNA5BSjSa2VhAkDXzGIaEkX5TiuDY+q3y5An4uW8w8lph61Y/sGJ5vAPoSJ76vn4kJbb6n/b0jPRW9oWKCsyX/VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=px+KPdas; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab86a29c98so17121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753722886; x=1754327686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YePw+ur+BCoo8sm0kyxEpDL6zMyyNBj7pMYmP8fOofo=;
        b=px+KPdasmWAnuowy2MarTuLX/mzmxBld61DhhvpFnk509qCePUZRSvtYxuMmvWMQ/V
         wjf1LYGqUPOA3n+TTF5AIdQZjAgdDNGwKmFgpmquARwsNBYHv+4PIiQ+sjlTowIGIC/M
         u9O2s6d0uyImI/5ZtDpUmBPO9tCXb70h5CjbuqxHjcmnuqfvHIVU0eJ/SJLv8Soo0c3E
         K9UGhqYmOmuLFhQwSOVuTcuFeyQ9S9+jrcIWqR3P5QuzI6QbRzoxqLba6zBIL1UuW9Ct
         pmVCOvMxpjpdILrwPJezLcEe+N4ErUqZ43Jc4/dsbNXYHeFrgD++c9Gyq2Thq1Af9Eac
         rZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722886; x=1754327686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YePw+ur+BCoo8sm0kyxEpDL6zMyyNBj7pMYmP8fOofo=;
        b=mwXvZztvZn8RIPh2VhAnOnStHzPLn7tTBE3V8J/1CrRDf5KeKcPgVKiv1nSneNoHd6
         cfAGwB0daAcBv78u5wLAkKWJ3Y5uu6F9Dq7+FGmAihotWv2Fhy3Wj/KjxWFI/nUxnAxk
         bOSeURuXrrSc+3DMgw5yr/EiIbHJvAYwFZUoAFr/H+FCcbVyt2lVomlSI/0fxdS/Q2V/
         gAUoVBf2Qo8sxO8PZPZupcugBSSADdH230E8J/WOWgtKZKYv3Xjub4RojQTwXFTjpZ4y
         bWpzZ+1SGeJ3vqM8L569BfJEiPwtVFS72TTSqKXNeiHl1IxemY1SccZ+70e4S5MdBL4X
         ld2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBwoen0sBui23LVArZQayurIWn05SYRHxC/teY+bGxAI9+AYRiHdnASFtIXtb2HMq5/P3dWQPIEOl0jK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5XXD68GrduOJ099d2bP5sDmMFZ+Gt4yuMqvAka8LnLeXqz55
	gv5Q2gZ+I0qfX9NmyM/jEEg7yaK8AMw1RycU2iheuBTuE+ry/hP4yaclR0iff6zrhc9oGGQYaGD
	2I1E5sX0UaBlvEocq59Qn1aDWBHjqsx06sJZcCZwz
X-Gm-Gg: ASbGncuOQQLoTx/NmFLtM9XqpiXZJV8cZE4AXCx0E0kskivyDw+eF92CRcZDtbg5dHk
	7RuoJbc8WMTZWcTbqwl8f5z0b3uSPC6Qk7eTq8EGlg2zxWcxsugZPJ7/isH5H461bBmCGxc0Xys
	WamaNk/yMOMwnOaNl1VTcwiJ5OkPwY6Rz+yZ/btHdXpoxY3jhhPwnNcMxViZHvQ8pFAvWQyfPid
	M34yzXwALZQYp+0Amuw0Z6YUxAGZl83tkvDwA==
X-Google-Smtp-Source: AGHT+IGCBgO2XeXZhEuM/rhGLIGSYtuHr4E823f6VQotTFSU3q8PaEyrvPPnSnoBBL0wzUawPuf5si6S8YbGzqod29s=
X-Received: by 2002:a05:622a:180b:b0:4a9:b6e1:15a with SMTP id
 d75a77b69052e-4ae9cc0a9eemr8919311cf.24.1753722885418; Mon, 28 Jul 2025
 10:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
 <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz> <CAG48ez0RrGX-UDhUF+1x5-euJN9z448dsrXMgv4+7-_s=zan_A@mail.gmail.com>
 <CAJuCfpGPjMSMqL1p=dMK3NJ_Cytk037Gm63TU5OuY6QK7Vi+4g@mail.gmail.com>
In-Reply-To: <CAJuCfpGPjMSMqL1p=dMK3NJ_Cytk037Gm63TU5OuY6QK7Vi+4g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:14:33 -0700
X-Gm-Features: Ac12FXz5IIXYMk4-THiDSYlFJH79TK15xvMyn-AQQrpPQLDGdjaOkq22QNqqBU8
Message-ID: <CAJuCfpEMhGe_eZuFm__4CDstM9=OG2kTUTziNL-f=M3BYQor2A@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:36=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jul 24, 2025 at 2:45=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Thu, Jul 24, 2025 at 10:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > > On 7/24/25 04:30, Suren Baghdasaryan wrote:
> > > > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> > > > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> > > > after it calls rcuwait_wake_up(). What do you think about this
> > > > approach, folks?
> > >
> > > Yeah except it would be wasteful to do for all vma_refcount_put(). Sh=
ould be
> > > enough to have this version (as Jann suggested) for inval_end_read: p=
art of
> > > lock_vma_under_rcu. I think we need it also for the vma_refcount_put(=
) done
> > > in vma_start_read() when we fail the seqcount check? I think in that =
case
> > > the same thing can be happening too, just with different race windows=
?
> > >
> > > Also as Jann suggested, maybe it's not great (or even safe) to perfor=
m
> > > __mmdrop() under rcu? And maybe some vma_start_read() users are even =
more
> > > restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-on=
ly, and
> > > use that.
> >
> > FWIW, I think I have been mixing things up in my head - mmdrop_async()
> > exists, but this comment in free_signal_struct() explains that it's
> > because __mmdrop() is not softirq-safe because x86's pgd_lock spinlock
> > does not disable IRQs.
> >
> > /*
> > * __mmdrop is not safe to call from softirq context on x86 due to
> > * pgd_dtor so postpone it to the async context
> > */
> >
> > So I guess using mmdrop() here might actually be fine, since we're
> > just in atomic context, not in softirq.
>
> Thanks for looking more into this. Even if it's safe, I would still
> prefer to make mmdrop() outside of RCU read section. The code might
> actually end-up cleaner that way too.

Sorry for the delay, I got some time over the weekend to work on this.
Unfortunately vma_start_read() is used in one more place in
mm-unstable and it uses vma iterators for the lookup, so combining
lookup with vma_start_read() is not as clean as we thought. After
trying couple of ways to fix this I decided to follow KISS principle.
The fix is posted at
https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.com/.
Reviews and feedback is appreciated.

