Return-Path: <linux-kernel+bounces-756510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092AB1B546
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EF73BE255
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57009275847;
	Tue,  5 Aug 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeqQltMx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DF275B01
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401825; cv=none; b=jSLzPays5mSIJOihLWiWwLOeLFUfPLSWF9bJvVbxh9z1xCrlyyp3JQ8dDq8mbepEyYP0k5DqoRKA4NrJK20w3Cu2uUq9/0u1ZB9tFmNvndoen072iy2FZy+aCsaFPIStZpO8Z9fGCFE8QIbkdPsIQHL1CbP2MO0DcmH6Be57C7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401825; c=relaxed/simple;
	bh=g4Mlbi2FrsdDMsKp5s5oVMyNcAM40UvdkQxPRClr7Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heoUQPGIBnVej850GGYASf5Wq1TNGkXUn0v9YOs5sSSL0WqbdM8bmN2PiST8n9jvnEjD79/EBdk4o9G6tm4D2Zkcog/oIHDDx8VPTCeoL5BQhZpCFVxfiwgvovUrs2criGXe0LFitEobHQmX5YzsfoZuqQch+sZavyq7iEsH5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeqQltMx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso11685a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754401822; x=1755006622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM5Sak9VYNXA/4oFKKbDTzSyVDrMPAA9ankjux7yv0E=;
        b=HeqQltMxDChXoa95DqIgzT82hEsZEBzJ9JkPWGrVQqRETgRiq6fdvF7VzJsTH1ePdL
         PzKBXgHMLB+5gUe3geUQGnrBXWy8GkNlR4D2KENOyJoz+6mptXnFZ4xQYo2n0tVB0jEP
         71+a6EAJ2ZBZPSiCXHWfze7UBBCvcVcrRb+iTsRZyJ9eRckP8/EWnRq+sFBbJujoLztj
         Qt9Tkm35abj8btolBhMTtlMgVNUGOmQC7mGL32torbDdn5mjcXxf86U6EaPpnH8FsM2F
         s32WK/mF9/iwm49jqGBWhQVZ74PYj2GYtdDBN1ylYyXtnIdVGZ+m0FjnXc6rurqhExIr
         WEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401822; x=1755006622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM5Sak9VYNXA/4oFKKbDTzSyVDrMPAA9ankjux7yv0E=;
        b=MVehJvV+zzkAhQAvp6R/aNA2K2+xMP70Lv9icm0CznJfiKSAVLfGn6APj//bHDYpTB
         JfQquak14jLZQ+mSi9AjMJCOwzZs/znwpUdx41j7HymqIxnAO2peD5GUmRhZwQhI2Lu2
         xYyqXhRUxFSPBOrDUd7kZy6RC7l5wLhkh0nX2zzqRPC1/zWNGO+MVJpJ/KwgkJc3px6c
         NnBH0J3y4Wdr1OuWjeiE5fpfxH7kTyMYa0rHTR3dBto9U5JWUDqZQXWRirixqtyuQT0v
         6ONydTcw7/dw5W6ONYiAq6ygEGgZ0J3rzUFuIJ6NsfxN8XHqxX2dhwQMTfE9dmDCaBun
         PWfA==
X-Forwarded-Encrypted: i=1; AJvYcCW+73FhzbY+4JfDUmLMRRHpOG5wyQ49O0LOydBKOm7b+6r6KiW0IayZZ/CqvDaW2vsWfR0FJXzCFr47h5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJmq7muQp3EugatHe99ZazTo5weEOmkaF0RDn9wLkHuNWXcw6
	6wjJk8lHww82olENzL2ghQBsL8n/pVXoe8hb6adRcCCYRD9rrs5nUXe9xs7ap8CX8mPpy39X7k+
	4UzAi0ahyV47ItbTJOrIX7fIyrPumo+PYVtATV6gb
X-Gm-Gg: ASbGncvuwy6wJvVIqT76lC2emL3Fay+qTNkyLeGws9Vj6/9q6TZFmrlzUM3O3lj0wab
	6xDuO2bNaySWWy3XiJuFK/5kL28toujQyqw8fhT0/eOYxE+DEAcGHURmQYEN/O0GrBhbSIdb5eU
	DeHS9Eu+p9ObXSZt9xiLEj0QGr2vGNtiUxfkgIA97EGovDGX517MKDWLRQC1QxBZ4VBVT/28udq
	OZejBYnhdXRYM/1KC2pOD9mTyDwnKa1Zp4=
X-Google-Smtp-Source: AGHT+IHkUewzm/8PTdOyIiW/iPVhbXcnpy+KcxT34FnucOdRizqHQ5Mn+Gui7Bqb6LBcfhucb4rfr5500SDXDs4vrhI=
X-Received: by 2002:a05:6402:325a:b0:615:3fe5:a925 with SMTP id
 4fb4d7f45d1cf-617848372e4mr53602a12.7.1754401821913; Tue, 05 Aug 2025
 06:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-kasan-via-kcsan-v1-0-823a6d5b5f84@google.com>
 <20250804-kasan-via-kcsan-v1-2-823a6d5b5f84@google.com> <CANpmjNOJxJ+kM4J7O5J8meSD_V=4uAa6SwFCiG83Vv_8kn56sw@mail.gmail.com>
In-Reply-To: <CANpmjNOJxJ+kM4J7O5J8meSD_V=4uAa6SwFCiG83Vv_8kn56sw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Aug 2025 15:49:45 +0200
X-Gm-Features: Ac12FXy65DGv8cn62c1xeecD1pKxLWVWZniqqA9hR2KQYd_-HuNZowNKVDRPddo
Message-ID: <CAG48ez2_HrKjRuH+5KSB+vK_9dGeNnh2O6qAN0ePr4BRnt3xzw@mail.gmail.com>
Subject: Re: [PATCH early RFC 2/4] kbuild: kasan: refactor open coded cflags
 for kasan test
To: Marco Elver <elver@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:31=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
> On Mon, 4 Aug 2025 at 21:18, Jann Horn <jannh@google.com> wrote:
> > In the Makefile for mm/kasan/, KASAN is broadly disabled to prevent the
> > KASAN runtime from recursing into itself; but the KASAN tests must be
> > exempt from that.
> >
> > This is currently implemented by duplicating the same logic that is als=
o
> > in scripts/Makefile.lib. In preparation for changing that logic,
> > refactor away the duplicate logic - we already have infrastructure for
> > opting in specific files inside directories that are opted out.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  mm/kasan/Makefile | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index dd93ae8a6beb..922b2e6f6d14 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -35,18 +35,10 @@ CFLAGS_shadow.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> >  CFLAGS_hw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> >  CFLAGS_sw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> >
> > -CFLAGS_KASAN_TEST :=3D $(CFLAGS_KASAN)
> > -ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> > -# If compiler instruments memintrinsics by prefixing them with __asan/=
__hwasan,
> > -# we need to treat them normally (as builtins), otherwise the compiler=
 won't
> > -# recognize them as instrumentable. If it doesn't instrument them, we =
need to
> > -# pass -fno-builtin, so the compiler doesn't inline them.
> > -CFLAGS_KASAN_TEST +=3D -fno-builtin
>
> Has the -fno-builtin passed to test if
> !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX become redundant?

... oh, bleh, good catch. Somehow I had convinced myself that
scripts/Makefile.kasan did this, but no, that only sets -fno-builtin
for uninstrumented code... I misunderstood what was going on here.

