Return-Path: <linux-kernel+bounces-778756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38DB2EAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2651771AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E9217736;
	Thu, 21 Aug 2025 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2OScKM6"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39F20B81B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739571; cv=none; b=mOleQCJ3T0Nm0+kHE1EJyVPXg6OV+h66BqmtjcMtZCx8m63umlzQZPXwQu8+J3oQu6ad9ZD10rbl8gtRgUvH67j4WONBXy0Wu5Wc+hnzzyF1pmR9pTyxBj1nLx6MshS6b7y4+NMATc8Ibaoc/uY6AX78jgGeQwtY9BlTWWKhhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739571; c=relaxed/simple;
	bh=cdqTKx97WMMOrMsIULyVAa3C+DvNmmOBzf3DKBPO6gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9BQeXivs94aozDrMHchrYvMZtspvy1V4dHGZcSo5zMneMmJhpH7R1e3kLZ4LvXD1yRcOR5Y9AlUmaBIzO1jthfqalWZMQoBsFP/rdd4YQmEijcub4FfzxMwlugYUfJAOjqQV+Uk7UfLU7wv4r0UBNI5rxAc7bQzsTKpSm/DbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2OScKM6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b29b714f8cso82611cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755739568; x=1756344368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnEnB+OmfWctn0N7nbpiwPaAHdKfBNMlU6IYB1kOEBY=;
        b=L2OScKM6mTBBIXEpXS43gV2kDUyHRH+LhDykFr9fJDKqYA07yejQYLX15kNsA3dNSt
         j00mF8RwtWFiha7D4N+JO9YE64nW9LTHQZLXbFC7m4nPSRpoLJvMXp+AfX5aHuU0yiJP
         IOU762TpXQyNO2ig8affgW2QojEQVSYzVO4yj+/eooZ9nhfj51DN9clv/sjW5Pp57oaK
         plkOX368wbN2Dn0Y5Lw0zvqE4B41uCFkqSXOkfcX0hi7/uk72vrKjSk+ZRZ2q8Zlfcj6
         hOYqkMpjJuppStdIQWALLWbLeTY8jgQoPvM0B3xQFRgQFzlcVLVgO8rR76VHZ37HI9m4
         jtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755739568; x=1756344368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnEnB+OmfWctn0N7nbpiwPaAHdKfBNMlU6IYB1kOEBY=;
        b=OH2OwvfDLRGCp2Xt42B/DrmSky++7AIq2S6Fr046UqyzVP74jrUKrLeHajljdZincf
         o7n3kHOq1daIZwcK34mf4nXfVf/mkLXpUfVZzz+pb6c6ktYqJXUgPG0BImZ2OmmXdpFT
         APWRQnMdgBqFDfskgz0s+d5UFjGPK2GYFMJ5aS3TXYRKyShBPyIbvhTrDTmQt5i2zDNK
         AB1VqYWBQq8GwwcWvGHxZtUsB/CFM+5tTcO5kvy7TdaX8V4z0cEFor2El7NnDPi9nB6t
         DEasUbJ3Ph0YF9i1IOtjOljXggXXvGPzXaQIwlyINW9o08RjNroJTVgGjlUHGVJSyVAx
         Gbug==
X-Forwarded-Encrypted: i=1; AJvYcCUTDwzMB6WPD6rHF+l2fUiaqsI2P8kbovxRmG4BQfk7WUsTi9RMA2GDfmEdufopznN04PVO4vbfNxIEdbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx412Y/cRPkdIwXxwn7yiyC8nRuB+liOOVuukiRMYRsrfAdTEY+
	XjRR9MSkIU92bRsBd/ce6aVuke51fuOHHRXuvFQzbUii/kuORDDRAioX6+j8VNp0TKYmachFtQb
	vB0l5anC/1R6aRelpqBmde8kO1g64X2jH/iCiQWvY
X-Gm-Gg: ASbGncuUYwqHYCI6eARsa+SO5tkyhgRnQ+GRZw0zoo1/HV+fDvmE7v5XzT9DR7w1561
	PICWPOXJTBK9P9Llvh2nfrkTVXQNucydsoCHLT06k/FhQNqmDRMVS83FCb4D5ACLScBWY8r8HxQ
	yc0grZyWSUoK7mNcQJnd1CVMnvZFr1b5PDqs9LkOgtw6CEgsxblqbyoCC1YSc9D+GEHTT2JltTi
	hwcpOG/ALIo9og5IFdVxRE=
X-Google-Smtp-Source: AGHT+IF25yXOemiZH2ZR4Arkb61fkkHIrHwpV+wk+bChi5o1xR1rtRMEG0QaE7vvEbDuUircQFhw++4IAgrYcJ5sqPA=
X-Received: by 2002:a05:622a:1aa0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b29fa06aadmr1313601cf.11.1755739567869; Wed, 20 Aug 2025
 18:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <790da5ffebf18a5a1211ad8dbe4e5b4a19871408.1755190013.git.pyyjason@gmail.com>
 <20250814201114.1921580-1-joshua.hahnjy@gmail.com> <aKM3j3geY7JiPGQ8@devbig569.cln6.facebook.com>
In-Reply-To: <aKM3j3geY7JiPGQ8@devbig569.cln6.facebook.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Aug 2025 18:25:56 -0700
X-Gm-Features: Ac12FXxfS-7fdVyZ0dA_OJvGZ-bAD31CipxCzxMcWrdx3YWMjTVoIUgJPZr-Bpg
Message-ID: <CAJuCfpF11tbq7eEhzJ-7cneGKXDg5cxQrdWNVo1whyLuFQGzmg@mail.gmail.com>
Subject: Re: [RFC 1/1] Add memory allocation info for cgroup oom
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 7:24=E2=80=AFAM Yueyang Pan <pyyjason@gmail.com> wr=
ote:
>
> On Thu, Aug 14, 2025 at 01:11:08PM -0700, Joshua Hahn wrote:
> > On Thu, 14 Aug 2025 10:11:57 -0700 Yueyang Pan <pyyjason@gmail.com> wro=
te:
> >
> > > Enable show_mem for the cgroup oom case. We will have memory allocati=
on
> > > information in such case for the machine.

Memory allocations are only a part of show_mem(), so I would not call
this change memory allocation profiling specific. The title and the
changelog should be corrected to reflect exactly what is being done
here - logging system in addition to cgroup memory state during cgroup
oom-kill.
As for whether it makes sense to report system memory during cgroup
oom-kill... I'm not too sure. Maybe people who use memcgs more
extensively than what I've seen (in Android) can chime in?


> >
> > Hi Pan,
> >
> > Thank you for your patch! This makes sense to me. As for your concerns =
from the
> > cover letter on whether this is too much information: personally I don'=
t think
> > so, but perhaps other developers will have different opinions?
> >
> > I just have a few comments / nits.
>
> Thanks for your comment, Joshua.
>
> >
> > > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > > ---
> > >  mm/oom_kill.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 17650f0b516e..3ca224028396 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -465,8 +465,10 @@ static void dump_header(struct oom_control *oc)
> > >             pr_warn("COMPACTION is disabled!!!\n");
> > >
> > >     dump_stack();
> > > -   if (is_memcg_oom(oc))
> > > +   if (is_memcg_oom(oc)) {
> > >             mem_cgroup_print_oom_meminfo(oc->memcg);
> > > +           show_mem();
> >
> > Below, there is a direct call to __show_mem, which limits node and zone
> > filtering. I am wondering whether it would make sense to also call __sh=
ow_mem
> > with the same arguments? show_mem() is just a wrapper around __show_mem=
 with
> > default parameters (i.e. not filtering out nodes, not filtering out
> > zones).
>
> The reason why I call show_mem here directly is because cgroup is not bou=
nd to
> a specific zone or node (correctly me if I am wrong). Thus I simply invok=
e
> show_mem to show system-wide memory info.
>
> >
> > If you think this makes sense, we can even take it out of the if-else s=
tatement
> > and call it unconditionally. But this is just my opinion, please feel f=
ree to
> > keep the unfiltered call if you believe that fits better in here.
> >
> > > +   }
> >
> > NIT: Should this closing brace be on the same line as the following els=
e
> > statement, as per the kernel style guide [1]
>
> Sorry for this. I will run checkpatch for my formal patch definitely
>
> >
> > >     else {
> > >             __show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(=
oc->gfp_mask));
> > >             if (should_dump_unreclaim_slab())
> > > --
> > > 2.47.3
> >
> > Thanks again Pan, I hope you have a great day!
> > Joshua
> >
> > [1] https://docs.kernel.org/process/coding-style.html
> >
> > Sent using hkml (https://github.com/sjp38/hackermail)
>
> Sorry that I forgot to cc some maintainers so I added them in this reply.
> Pan

