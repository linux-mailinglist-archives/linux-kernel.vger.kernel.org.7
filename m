Return-Path: <linux-kernel+bounces-623737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4030A9FA09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 21:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F091A80DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7042973D0;
	Mon, 28 Apr 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqSO9uIk"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E606294A0C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870236; cv=none; b=kXd5DcWEqjw0EAfFoaFEUMelJYHE4qB9l7BOdc09LPJEOYVnvbK3peOjcpf8u711XAAmBFC1gV/gHPhYqn7Qwrt6ebe/M7QMV5GEy9UF9uz5Jk+AFqQHAxvYQpKkMd5Qe2p/JwHw/0+lEgZdDKHrEBR6ne5cT60lI/odJDiLZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870236; c=relaxed/simple;
	bh=0MR+x5RCKtHn9xBhZphcnfg1mkJUMUmGnpKVvObhpFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlC6lDZtktrOTNxmKbAM59LpZxF2ur3ks9wOYtdQ3V8V95okiJ/yo8scOa8levIO65+0kgv1f03O/CMFaJiyAjlXthZHAb+pYqsw0+/igfJhzClLAO1YcFf9jPLDQmMLbNvLhtz/V9WQct8RxKjZmOaWkQ4ZHLAqw3BK7x6uq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqSO9uIk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47666573242so85051cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745870233; x=1746475033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUGna70WQpCWkTeNNt6g447tdKBI53CPsya1LM9jehw=;
        b=WqSO9uIknx9gC0PYwxfBFd10Y1aVgzWSsscVzUWEdMebrTiaa7AroxoICVGiD3y1gj
         Um1aGkaXQvi0ejgRKkEfpg4EdtVANlcWYGVXoBOv0fV/aTexu/aAxcJQ+EwPoeHKBm29
         o7TyVx518cM01sXArvPSbw2/so7nFb+V9A4o5E2gJl82j8p8L+wGLfzld3wKM4rgjC/5
         khi0XnSkRLX4vD9L4YyMqGqHFZq2WkeDGtrfadWWSQkIRUrufdERnqGl0iwEtIz20RSX
         ElYfneRkVA6Qxplz/VQVFV0mx7BNwM5nCHJEIBK+u3kNIqBtamErvXbBACcYXyojoipN
         z9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870233; x=1746475033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUGna70WQpCWkTeNNt6g447tdKBI53CPsya1LM9jehw=;
        b=Qfw7w6EllUTmf5ArUhjcS0Ao5MGW5zTZc8rMXxV6Pow4+T5dXtg2CC8y0rJM2Cmd2v
         u4EYrtClaN/mcpfMlsRudEPlbzB/2pLK4WqJ0P9M6RLu/zlIRpg44RtMN/2QjSgihs6S
         NKgLuCAESX2wQzstblqSIq3hq+TKHm+7wdAnRIcjq3Uq+yqWb8k+D+CnVnpBzsDnRE1m
         YluMS8NAILKt/pdfwKq/nZjq/zMcjUfzkwdZEibfx3sqxk/MbzR797GfKDmb10p15hLH
         lrVgOpho+TMG0wrJzet7yt6GlWoasyAw2kC5uDHgm+OQYlFn8qlWSIHrvJ3oiD6Eb/vW
         7skA==
X-Forwarded-Encrypted: i=1; AJvYcCU82bZN5P4/fs78hqoGoKTJKd39pDB/QI3pUcgAIyEwSkSESN8PwuuVSEV0Zo6d+5Z0jLvuOdTaWcPXnSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6vE3Qz4i7uwIcT9BLC91WSdhgA4fsgiuyl4tDuNaaM/f0y9H
	ZksozuHWhmvcE/7BqzargqX0WP0inGYltvUEPn1RvghyBtqNrQ08kr9wGfM1tk7+UPv2LrJide5
	N10JSZGxJTgLnQSREE9iqbOC1UTCjsTb1mJ7A
X-Gm-Gg: ASbGnctjl91VRmDg2DrfIVGF7/gOEnByjdk18zKklfPxtxH6elRE4aCqO1hjAgJsXXk
	RYdast6MECYwbbMwWChpVjxnOwAeAFT8UvaHtVNvoNY8fXv8pe29jH+1pfFN5zQs/vs5O50qTaI
	x1M/WMqye+5DDYArgz+3CY
X-Google-Smtp-Source: AGHT+IEhejaHFThaKwhJCfo8/xHV6yGo88io+XsVdICYQukFeW24MAIkT6Fi1xOMkVwdW/FKQmmwSk2eKpS9NWkWZlM=
X-Received: by 2002:a05:622a:452:b0:480:1561:837f with SMTP id
 d75a77b69052e-4885aacab9cmr871171cf.8.1745870232933; Mon, 28 Apr 2025
 12:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425081715.1341199-1-david@redhat.com> <20250425081715.1341199-6-david@redhat.com>
 <aAvvQ1h9bg11hiqI@x1.local> <bbadf008-9ffc-4628-9809-2d8cf104a424@redhat.com>
 <aA-n9hvSX9JLsRM-@x1.local> <7a26e29c-d889-450a-a5e1-ce671f09e4c8@redhat.com>
 <aA-rtji7ujQgckbM@x1.local> <884fab29-e16a-4663-8e33-885bc70ca2f7@redhat.com> <f08118b3-0736-4a5d-b780-8e3d88f45c02@lucifer.local>
In-Reply-To: <f08118b3-0736-4a5d-b780-8e3d88f45c02@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Apr 2025 12:57:02 -0700
X-Gm-Features: ATxdqUFN4dSm5xUeBut-iPBeU1VBNXf3LtoK4Lvt9a17IgRXhS8pQBx8VXvr8KE
Message-ID: <CAJuCfpEtnBrAkSV-6PDv4Au5gs02vWYeMNHo3OxZb8NB0sy8cw@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] mm: convert VM_PFNMAP tracking to pfnmap_track()
 + pfnmap_untrack()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:37=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Apr 28, 2025 at 07:23:18PM +0200, David Hildenbrand wrote:
> > On 28.04.25 18:24, Peter Xu wrote:
> > > On Mon, Apr 28, 2025 at 06:16:21PM +0200, David Hildenbrand wrote:
> > > > > Probably due to what config you have.  E.g., when I'm looking min=
e it's
> > > > > much bigger and already consuming 256B, but it's because I enable=
d more
> > > > > things (userfaultfd, lockdep, etc.).
> > > >
> > > > Note that I enabled everything that you would expect on a productio=
n system
> > > > (incld. userfaultfd, mempolicy, per-vma locks), so I didn't enable =
lockep.
> > >
> > > I still doubt whether you at least enabled userfaultfd, e.g., your pr=
evious
> > > paste has:
> > >
> > >    struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     0 */
> > >
> > > Not something that matters.. but just in case you didn't use the expe=
cted
> > > config file you wanted to use..
> >
> > You're absolutely right. I only briefly rechecked for this purpose here=
 on
> > my notebook, and only looked for the existence of members, not expectin=
g
> > that we have confusing stuff like vm_userfaultfd_ctx.
> >
> > I checked again and the size stays at 192 with allyesconfig and then
> > disabling debug options.
>
> I think a reasonable case is everything on, except CONFIG_DEBUG_LOCK_ALLO=
C and I
> don't care about nommu.

I think it's safe to assume that production systems would disable
lockdep due to the performance overhead. At least that's what we do on
Android - enable it on development branches but disable in production.

>
> So:
>
> CONFIG_PER_VMA_LOCK
> CONFIG_SWAP
> CONFIG_MMU (exclude the nommu vm_region field)
> CONFIG_NUMA
> CONFIG_NUMA_BALANCING
> CONFIG_PER_VMA_LOCK
> CONFIG_ANON_VMA_NAME
> __HAVE_PFNMAP_TRACKING
>
> So to be clear - allyesconfig w/o debug gives us this yes? And we don't a=
dd a
> cache line? In which case all good :)
>
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
>

