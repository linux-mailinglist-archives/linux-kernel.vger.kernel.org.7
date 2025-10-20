Return-Path: <linux-kernel+bounces-861584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC01BF3201
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 080C94F078F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97212D6409;
	Mon, 20 Oct 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XvAly5Lg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660532BE7D1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987562; cv=none; b=ZVNe9bh8yrJKeNLHs+KBP0Ht27eQYOP8JUxdj4HTh/3RhP2v3k5X8BUef2qlf8H6lnZcZ9c7Fz3FPgk4B1VpiWYhZLm4rNf/BSsaHW0bDHV5Lj1uKwbfYbjcfCvY/SAldcM1ayyl4wQpKNKhtK8d3DGv3ldlr1kVbT0MZY6uKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987562; c=relaxed/simple;
	bh=Wto3PZwvEe+pg4mNkQ3S7CuwCsIYj9pOUY9FLfwcENY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukChEstvqOAZaq2NNrmEPDve+CA4j6faBBw7cKbRgjJk+6MSGkKvn8TpN3C70h27UouPvOwuWY0rJlyfQDHYQhFE8xmBu2ZiSJeB/vx3GDhIV6Cm/ejDW/X3fPVtq4SjS+mUWiF8RRMxDnrpOw0zB/pkftjqMDj2cbaRc0RMXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XvAly5Lg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so5824618a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760987560; x=1761592360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc7VJXdo3UtIww5U8CPY9TfvbkDo2/ocS4PDbChl9Jk=;
        b=XvAly5LgIVNg1r6SM0b498KKuGwwSxkTFJJWqf9TasecQehvR7tMLbz1GcsaBqlBQv
         B/e3X58A+ECkNartOxhvHa+/6hewqgVgKedsMO+1fPQAMmyegfPIbELFOU38M7j4AXuV
         vxBuwRzhc/8DzTjA0R9ktONyybRCMa5k+gc7u12nJv+CcYoUhv/fWyhB8bbrVKB+2g6V
         XkaxSxY6c9/ED+nVlXpMwPMgg+PuTDVQJFhN+uE3s+VfN3AGyGlayGO0scujDZ3MSAsR
         BJ3k1YhOsQZW06ZEO4I42EWizekiRDjjhwLUHwzctu8qHUBRFox+V1x8cHEcExsWU2qe
         EYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987560; x=1761592360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sc7VJXdo3UtIww5U8CPY9TfvbkDo2/ocS4PDbChl9Jk=;
        b=B/8xGO6k4xRACXWU41dVuECZVxfw5xxK7LykdLIZw33WwMpdtYjfgwKAiedsAFxznx
         yqMEZFgxhAJuZpSJUPaTfbXcfvcqqAdcOd/+VhuqEHqU8Cm+6fAr7dhGrmtDlAAYAQSm
         SSsK6k0m06WNC07D0qtVdDJAC6i/MH0PlenrIYe1qpuSvxIZPdoJ2N4GxUpYhoIISQJt
         1cTTjINIDtW/WqCv8NHNSF4/R7zCfTQrFzJI0uX2xk/iV/KvwFPPxBYWp/WfvbhFzHVU
         b6gvdLuUJuO1hixNOZ9fUWej6H32rh7/e9vDB1In99pAKA9EnoTYMBdrj4ao4x+YgvD9
         mqLg==
X-Gm-Message-State: AOJu0Yw3Con+Hj5ygst7m9iiAf3VE4pt0yEH2vYgGEa0qlswLpMJnTOW
	jNr6N6q880K4FCR6wMhR9hPfXTjdVIbxXwx6c6dYzWMaXHSqbkQbWml/dedRlezxwhUYlS4Ja0T
	d8z+NW90u1wt0jlpdm8I86SjiujbFNDEYFpv564W2
X-Gm-Gg: ASbGncviux1CWExefDKCvH9HvQ7/7cjC0bJReHJdmKB3hGzE05zuufTCKnxhd4n6QBL
	sGqxBVyIiAByLIGVIZt/Mo8FzFXxD/Zd+F6n8Iw3zkjqf/r0AvM1VC4NjZgMch57cJuXDRJS6y4
	IOp6iSQIf02wQE529TDMY6LE0V6QRm1dy/3JzRe0etD2B6RA8GqcksDsIsnHYpFtBaXhaK339qJ
	xnnNzHB6p6UIFd0Yr0dEw/1XzdBCspuNgRHUbAWClgN6gzrFlww4kaxj6CJs3/AWa+rx+FSDzAL
	YPmyeg==
X-Google-Smtp-Source: AGHT+IFHrTtTH6I3lTgO8qQ7DSrZQAKZFTUY6VZ8yzd1t4lfye4csFe9B9t1LuoroTCUBrs/OA+MDscdSNIVCjPeyfE=
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-33bcf8ec60dmr18193076a91.21.1760987559706; Mon, 20 Oct 2025
 12:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com> <20251017081050.1171969-1-zhanghongru@xiaomi.com>
In-Reply-To: <20251017081050.1171969-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Oct 2025 15:12:28 -0400
X-Gm-Features: AS18NWB9BWqh8x0h5dc2vyZvqxDGjfJS5_tcMkj-8g4gJY7kkSA9hd7IeNuvtrg
Message-ID: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:10=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
> > On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:

...

> > I would expect the number of active AVC nodes, and AVC churn in general=
,
> > to be very policy dependent; some policies and use cases simply result =
in
> > more AVC nodes than others.  With that in mind, I'm wondering if instea=
d
> > of using a kernel command line parameter to specify the number of AVC
> > buckets, we should instead include an AVC size "hint" in the policy tha=
t
> > we can use to size the AVC when loading a new policy.
> >
> > Thoughts?
>
> I previously considered supporting dynamic adjustment of slot size during
> runtime, but this seems to introduce code complexity and overhead. Every
> time avc_lookup() or avc_insert() happens, we would need to check if the
> table exists. Adjusting slot size and accessing a specific slot might
> occur simultaneously, potentially requiring additional lock protection.

I would imagine that a very simple implementation would simply convert
the selinux_avc variable from an instance of selinux_avc to a RCU
protected selinux_avc pointer.  As the AVC already uses RCU, I think
the number of changes should be relatively minimal:

* Ensure we wrap selinux_avc derefs with rcu_dereference().  This
should be the only real change needed for lookups and insertions as
every search through the AVC will start with deref'ing the selinux_avc
pointer.

* Update avc_init() to allocate the cache slots with a default value,
fail if unable to allocate the cache memory.  If we ensure that the
selinux_avc pointer will always be valid, we can avoid having to check
it.

* Policy (re)loads which would change the number of AVC cache slots
would allocate and initialize a new selinux_avc then swap the global
selinux_avc pointer under spinlock.  The old AVC cache could then be
free'd according to RCU rules.  I haven't thought about it too much,
but I suspect we could do away with flushing the old AVC in these
cases, even if we can't, flushing the old AVC is easy enough.

> When increasing slot size, we could directly copy the contents from the
> old table. When decreasing slot size, nodes exceeding the new slot size
> would need to be re-hashed and attached to appropriate positions.

Changing the number of cache slots should happen infrequently enough
that I see no need to migrate the old entries to the new cache
instance.  It's a cache, it will fill back up naturally.

> On my Android device, policies are fixed before system image release and
> don't change or load dynamically during system running. Using kernel
> parameters for adjustment ensures no additional locks or checks are neede=
d
> during runtime table access, maintaining simplicity and efficiency of the
> lookup code.

If your system does not update its policy over the course of a single
boot, and presumably doesn't drastically change its behavior during
that time, there is another, simpler option that we should consider:
setting AVC_CACHE_SLOTS at compile time based on a Kconfig tunable.
The code change would essentially be one line:

 #define AVC_CACHE_SLOTS   (2 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)

... with a corresponding entry in security/selinux/Kconfig.  That
should be a very easy change, and if you set the default value such
that AVC_CACHE_SLOTS remains at 512, there should be no impact on
existing systems.

--=20
paul-moore.com

