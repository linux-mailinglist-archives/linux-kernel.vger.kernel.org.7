Return-Path: <linux-kernel+bounces-878537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE6C20ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECE634EAF87
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27DB363BB0;
	Thu, 30 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jajQrP+V"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F324363B87
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838087; cv=none; b=DE8UF5ta/FGJcZRDaC/qUkluDPsV5Tq8HOSclgDJEPvvX9q9HA0xi7AnnGaw0hNa/0//eBtEID3oUx5r0Rgn2FXo1jFf5jWCtYK2LVjZ9/s7M79ziUFmqySvGjC58egq/QI7PGcUQK9xsQJcL64r4QNXufn3nqL1eNYUsY6xqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838087; c=relaxed/simple;
	bh=ECIWqf/VCNCzPTY80OhIw37324pVyeiFSTePderg26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyaRfih0LAWcPz1FbgJ4vtsoHAGoWPwBLN3FHmW25+YESxC4wl6vLEbdoDxndvc6/ZvfV2QrmFiTZs9nIg4UjlTtKeNnTBGetHDhpSyKgdKTnBZ6VJPXclBsoPXaCS+il8jycmFw9uIak0AkR3iWtN8D57L4FE9GWbn0t9D+eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jajQrP+V; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bb95a238so338401f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761838083; x=1762442883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=jajQrP+VBI480GS5m/RuuYQKeZ5vJDPrMawcKU9fcPND4PyKMdZFpTQsiPbybHi7+j
         6gNmudQdrhl163NcYhTcboP+XDrArAKh51XUQwa34ZlUkjFON5wBSK2vFFSP9iwHz2f8
         d0VTBKyI3KAIgqUacn/NlEUTjkWlBSXpJiGgnk41cXkrilTrz4lQh+eL41iCXjX1/x8e
         PH1qhBSthocC9qeV/JQbiSQc6hAkLR3J3zLWEiQMXqU03kXwr4Z8vY+sQZdXCjuW0OC5
         08WQCs7tcU4sjgcQL6PZsalFCLwgAoneSwHxep22kSdkys0wjvpA3zBtmAOO4ybjlaXK
         elEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838083; x=1762442883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=Jpovi15XCU4qlZVxQbXXYTXa/+So3TPk+L6cs21uUN5udyzklAY2AeAdRW3LJwRcfd
         nTB6N9lbuGsEJcKJREx99wbWUGtaVL1O7B6qMEqqXz5JF7UwOstmFoIuWHTVqBKTuUXR
         6T+76k5GPlz1+4v3nuxPE13/02v5/J7yxHu23BJrM7DvDF5UudBX8dt/7y5kqVapXIl0
         Q6YKNK39Gjs2HRU8OZkCG0vqRdOwz/YDbcMFKlvwtUhs7qLzWM8+9N67W/riFPWJ297N
         W0CB1Hhx3/0IwHprfQaIvh6oD+exv73XYbe+9aiwk1W8WaLM5ONjkGD1Li85bkMSIq5C
         iaOg==
X-Forwarded-Encrypted: i=1; AJvYcCVAdgoQO23MzNGP1E7ohGZSweKMVjSJtnIz6HQUKZuaTXLKx3PJWrPdV0DWNO0QVH4lBeRsAGo35kVfhAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8Rj/X4uLHX0mj2KIqVqmd2d3X3pYC/Xp70kRr1vBme00Swq+
	O0Tyr1KtdOBtdqrK1gpps4+UxEvOLmhdZpeiVG12vx95Dj+KhkH68GIME/hYwnjfpb1lQN6jk3Y
	HOUQWb2nrpVVo9fVPFqZiZDDZ+yJOxZEKDMGe
X-Gm-Gg: ASbGncvTfndNdvR+fPR3YO1anBalZa2Z0DYw3YKIqdznvQjgAfebM5XR0wQ5caTSi8C
	tL6U5Qsp4huaG1oNYkpmN3aXoP1lu38iHVh2S2swZUSawnp66fWWJZMwRkcVdvQoXGZ1ATcOjZP
	ypP55dY3h43OQOKutrAXg3QL7kvmjj0Szy9bRgIKhx72ShlfUiq3Sh6Duo1Bl7rM+DgYByKDh6S
	OAfHSR9LTpg0fuPih7RHb0ZqE48z2BeX1QQJStqvGh7U1ajwtyAslwdOKHqwNbwe5zDPzJWNGHx
X-Google-Smtp-Source: AGHT+IGXaWxPk/3M+cKYU/Pj7lpnExCAg79uXAbYfhqPsFtqXmL801omvA7wJAIBtF+VQCS8C9jbNQcSyBX5V1IM/6A=
X-Received: by 2002:a05:6000:2006:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-429b4c9ee68mr3815611f8f.45.1761838083095; Thu, 30 Oct 2025
 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz> <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
In-Reply-To: <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 08:27:51 -0700
X-Gm-Features: AWmQ_bnX5zwf36gXg3U_L6nD0Y-OhNsAUiH1Wv4xcOqbTsg1lnruV_RapPX3X1o
Message-ID: <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 05:32, Harry Yoo wrote:
> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index e2b052657d11..bd67336e7c1f 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cache *=
s, gfp_t gfpflags, int node,
> >>
> >>      stat(s, ALLOC_SLAB);
> >>
> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> -            freelist =3D alloc_single_from_new_slab(s, slab, orig_siz=
e, gfpflags);
> >> -
> >> -            if (unlikely(!freelist))
> >> -                    goto new_objects;
> >> -
> >> -            if (s->flags & SLAB_STORE_USER)
> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> -
> >> -            return freelist;
> >> -    }
> >> -
> >> -    /*
> >> -     * No other reference to the slab yet so we can
> >> -     * muck around with it freely without cmpxchg
> >> -     */
> >> -    freelist =3D slab->freelist;
> >> -    slab->freelist =3D NULL;
> >> -    slab->inuse =3D slab->objects;
> >> -    slab->frozen =3D 1;
> >> -
> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> +    freelist =3D alloc_single_from_new_slab(s, slab, orig_size, gfpfl=
ags);
> >>
> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
> >> -            /*
> >> -             * For !pfmemalloc_match() case we don't load freelist so=
 that
> >> -             * we don't make further mismatched allocations easier.
> >> -             */
> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist));
> >> -            return freelist;
> >> -    }
> >> +    if (unlikely(!freelist))
> >> +            goto new_objects;
> >
> > We may end up in an endless loop in !allow_spin case?
> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> > held in the process context on the same CPU)
> >
> > Allocate a new slab, but somebody is holding n->list_lock, so trylock f=
ails,
> > free the slab, goto new_objects, and repeat.
>
> Ugh, yeah. However, AFAICS this possibility already exists prior to this
> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we should =
fix
> it in 6.18 then.
> How? Grab the single object and defer deactivation of the slab minus one
> object? Would work except for kmem_cache_debug(s) we open again a race fo=
r
> inconsistency check failure, and we have to undo the simple slab freeing =
fix
>  and handle the accounting issue differently again.
> Fail the allocation for the debug case to avoid the consistency check
> issues? Would it be acceptable for kmalloc_nolock() users?

You mean something like:
diff --git a/mm/slub.c b/mm/slub.c
index a8fcc7e6f25a..e9a8b75f31d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
*s, gfp_t gfpflags, int node,
        if (kmem_cache_debug(s)) {
                freelist =3D alloc_single_from_new_slab(s, slab,
orig_size, gfpflags);

-               if (unlikely(!freelist))
+               if (unlikely(!freelist)) {
+                       if (!allow_spin)
+                               return NULL;
                        goto new_objects;
+               }

or I misunderstood the issue?

