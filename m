Return-Path: <linux-kernel+bounces-698640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F77FAE47BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057873B2DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D51256C8D;
	Mon, 23 Jun 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz2r1i42"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F019CD0B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690669; cv=none; b=PfZUu7VzlGxUWoiTOF8lC5JDKQzXVmwXcXLFYafIRoycieS+26XYRZmhpw6+ylROtYgJmzwvTb+zO78D4zHGPuK6hnEBGXV70UrJkCxb2ej8osmN15aRh2vMPRhr0SrI35sxz7EdTIATZKLatk+f6ewwSd9RtOJbS6hO4mYYV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690669; c=relaxed/simple;
	bh=uFj1nks66HpCTOX4MeLDBXxKrKss2wT7BOe7crK65IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOvkroJVshpO7rS4fZA2T1PaUV66D6Sc1aiwITtD71xyUA/EytB6WAZu6CWPT5984FGoGou/jWlfbSm/JADtFkPycCqDXt2t41BdNfZQaX3/rZ/dikl4lY0+0niXpAiEzpjDP1YPYXtaFXMKPcYnpOK1qWpyUQlgg18KRhuEhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz2r1i42; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso6580361a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750690666; x=1751295466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu9Ih/QcFbUQzus3T5HcRHRjyftZN8WMC5c94j7UZRU=;
        b=Nz2r1i42zzjxSqHeitrKW59FT/dpF7vmM0A3jNeluh82Ssh5Z+M7nf8oJiU5Ka2VYp
         yHe+xNnloeruAsBDwbr9a+hHJ6F+igbmfgae8zRP0fp1qDxlUCrmCgG9tz06DagnoCZy
         wVkevuiUprIELBuqS/rVmlo22LnxLtH+dXEwyd1Tz3n2A3x0OiK2Pp2VONN2fiE6oPRe
         OEhjxfZztEHps0g8ALAXJ9oE32+qknAWrAKiglnK+JgttdnpJEa3Yk73ecOAaZBTn69A
         sAXhGyFHeQtxJpePiYyTLnJ/xo5St4Yma+HRGAXkVmJfMZ9aa+0D/VMzSSygm5erK/dj
         JUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690666; x=1751295466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu9Ih/QcFbUQzus3T5HcRHRjyftZN8WMC5c94j7UZRU=;
        b=Kwxjlptu5NYIFaB4EmbfTW5+Kic6lH/7AFY2e1dh2MMboPtn2VvebjMdxeQ8pj8Ys+
         4RVRqAVgMHarYLFxM4rDJ6iMfOMmPGAgYnUhyWnBeMt3+Ab8cdzZaZwVfr6YNqL6yUko
         X06p7UUX64jSQ9wpolZ3xYZu88BIJlzoOwJ7KHBeuo634/BS2zt/Swlgpyx+/VCnCPkC
         xC8zWdsBtfpzlGJ/jQMMUPyPyAXv/RSEI4njFxPDUl5JranACi1o894FasPkh8mWK/my
         ANaGSawLv3CKfymsE+Zn+qPgeoCzHKqJXn56hI5LzOKfN9VCF2KV9cFlu7SJ3rs6e6AZ
         1rIg==
X-Forwarded-Encrypted: i=1; AJvYcCWsmdJohqlLhsUqH1tSblkuXJO8zw1sPcB9Y7xMTK4luYjRx2wonxZPF6f5/y8JNW+MAZ/xypDhOifwZjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lniZgLgJfw1mF1feU1Xisng/L0NeJqHYy4Q/OliCDzX61g2z
	+V+Xro4oOzv7IilAZr65pTqaiDO34/ER2/jNDCeYODmplHtO5OVDyhe1VVu6CYep+uL4QnD9a5V
	4k7iIoVH+vlx5hDHtyagP0YI84w+HEOs=
X-Gm-Gg: ASbGncts0cCwL7qYA+n+eOJ+j+lt4PdT48v9qqKEiaaCWPKxK2Qhfnlmwlk+bQmgUD8
	HRrvbqDCx7624q3OX8h5QQdtVu7YW94yoBX8P09U5b1GHgG7r89EFpLjyMl5NwV76E5FoOpM0FA
	ocR+N8WU/Ph8NQCSUMYJXR8QHfdD4fVCOVyYuOcQ0M1zq7Kd1VZYS8wg/SJChKl8FEjG9Ht+tTY
	IuN6w==
X-Google-Smtp-Source: AGHT+IGXKKO40ILnL3YoRR5459rm4GnrhaPtevLb3eJiUTwSri6c4aiU0gObCtK6uhbrpKoJuoEo7jlLWoxV+Vz7iNo=
X-Received: by 2002:a17:907:7f29:b0:ae0:54b9:f8a with SMTP id
 a640c23a62f3a-ae057ef74ffmr1276581566b.39.1750690665601; Mon, 23 Jun 2025
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620180458.5041-1-bijan311@gmail.com> <20250623134550.2367733-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250623134550.2367733-1-joshua.hahnjy@gmail.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 09:57:33 -0500
X-Gm-Features: AX0GCFuDT7kRq5r15XheIRRwt9P0C3EBB7kazhFRcdKb_Nq7cSmIIMffkqiCDis
Message-ID: <CAMvvPS65Vi-1U2vgezx649J80nfYeZ5YeA=+1NBuhMkbyOvc8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	sj@kernel.org, akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Mon, Jun 23, 2025 at 8:45=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> Hi Bijan,
>
> I hope you are doing well! Sorry for the late response.

No need to be sorry. I have no expectation patches sent on a Friday
afternoon will be looked at over the weekend.

[...]
> > Performance Test
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Below is a simple example showing that interleaving application data us=
ing
> > these patches can improve application performance.
> > To do this, we run a bandwidth intensive embedding reduction applicatio=
n
> > [5]. This workload is useful for this test because it reports the time =
it
> > takes each iteration to run and reuses its buffers between allocation,
> > allowing us to clearly see the benefits of the migration.
> >
> > We evaluate this a 128 core/256 thread AMD CPU, with 72 GB/s of local D=
DR
> > bandwidth and 26 GB/s of CXL memory.
> >
> > Before we start the workload, the system bandwidth utilization is low, =
so
> > we start with interleave weights biased as much as possible to the loca=
l
> > node. When the workload begins, it saturates the local bandwidth, makin=
g
> > the page placement suboptimal. To alleviate this, we modify the interle=
ave
> > weights, triggering DAMON to migrate the workload's data.
> >
> >   $ cd /sys/kernel/mm/damon/admin/kdamonds/0/
> >   $ sudo cat ./contexts/0/schemes/0/action
> >   migrate_hot
> >   $ sudo cat ./contexts/0/schemes/0/target_nid
> >   0-1
> >   $ echo 255 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/no=
de0
> >   $ echo 1 | sudo tee /sys/kernel/mm/mempolicy/weighted_interleave/node=
1
> >   $ <path>/eval_baseline -d amazon_All -c 255 -r 100
> >   <clip startup output>
> >   Eval Phase 3: Running Baseline...
> >
> >   REPEAT # 0 Baseline Total time : 9043.24 ms
> >   REPEAT # 1 Baseline Total time : 7307.71 ms
> >   REPEAT # 2 Baseline Total time : 7301.4 ms
> >   REPEAT # 3 Baseline Total time : 7312.44 ms
> >   REPEAT # 4 Baseline Total time : 7282.43 ms
> >   # Interleave weights changed to 3:1
> >   REPEAT # 5 Baseline Total time : 6754.78 ms
> >   REPEAT # 6 Baseline Total time : 5322.38 ms
> >   REPEAT # 7 Baseline Total time : 5359.89 ms
> >   REPEAT # 8 Baseline Total time : 5346.14 ms
> >   REPEAT # 9 Baseline Total time : 5321.98 ms
> >
> > Updating the interleave weights, and having DAMON migrate the workload
> > data according to the weights resulted in an approximately 25% speedup.
>
> Thank you for sharing these very impressive results! So if I can understa=
nd
> correctly, this workload allocates once (mostly), and each iteration just
> re-uses the same allocation, meaning the effects of the weighted interlea=
ve
> change are isolated mostly to the migration portion.

That's correct.

> Based on that understanding, I'm wondering if a longer benchmark would he=
lp
> demonstrate the effects of this patch a bit better. That is, IIRC short-l=
ived
> workloads should see most of its benefits come from correct allocation,
> while longer-lived workloads should see most of its benefits come from
> correct migration policies. I don't have a good idea of what the threshol=
d
> is for characterizing short vs. long workloads, but I think this could be
> another prospective test you can use to demonstrate the gains of your pat=
ch.

You might be right. I'll try to think of something for the next
revision, but no promises.

[...]
> > Questions for Reviewers
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Are you happy with the changes to the DAMON sysfs interface?
> > 2. Setting an interleave weight to 0 is currently not allowed. This mak=
es
> >    sense when the weights are only used for allocation. Does it make se=
nse
> >    to allow 0 weights now?
>
> If the goal of 0 weights is to prevent migration to that node, I think th=
at
> we should try to re-use existing mechanisms. There was actually quite a b=
it
> of discussion on whether 0 weights should be allowed (the entire converst=
aion
> was split across multiple versions, but I think this is the first instanc=
e [1]).

Thanks, I'll look over this.

> How about using nodemasks instead? I think that they serve a more explici=
t
> purpose of preventing certain nodes from being used. Please let me know i=
f
> I'm missing something as to why we cannot use nodemasks here : -)

I think since we're moving towards DAMON having its own weights, this
would only apply to mempolicy. Changing an application's mempolic
nodemask would be nice, but based off Gregory's previous comments,
having something outside the application change that application's
nodemask might be a bit difficult [1]. Also, I think it would be
easier to change one weight rather than every affected application's
mempolicy.

> [...snip...]
>
> One last thing that I wanted to note -- given that these weights now serv=
e
> a dual purpose of setting allocation & migration weights, does it make se=
nse
> to update the weighted interleave documentation with this information as =
well?
> Or, since it really only affects DAMON users, should we be ok with leavin=
g it
> out?
>
> My preference is that we include it in weighted interleave documentation
> (Documentation/ABI/testing/sysfs-kernel-mm-mempolikcy-weighted-interleave=
)
> so that anyone who edits weighted interleave code in the future will at l=
east
> be aware that the changes they make will have effects in other subsystems=
.

I think if we continued to use the mempolicy weights, it would make
sense to document that. However, it seems like we are moving towards
using DAMON specific weights.

Thanks for your feedback,
Bijan

[1] https://lore.kernel.org/damon/aFBXuTtwhAV7BHeY@gourry-fedora-PF4VCD3F/

