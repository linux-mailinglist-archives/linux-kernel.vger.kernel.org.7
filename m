Return-Path: <linux-kernel+bounces-806536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9BB4982E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870753AA6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC15314B62;
	Mon,  8 Sep 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldp5gwWP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0D31283B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355733; cv=none; b=mBdKO6f+g0uf3zKpAOJ5F8WUQr4rQS1/wp17ggp30orELdffXBaefXy7Qq0dXNyUO7Oupy50bpRASpeks5DRAj3zYt+aSAJmFUW7oen2vZBL/niyBgh5NkDb2HrcOKgQZE/LYFF7zhJn7w/HYQ1tJDsqgK+v51cp9eR21AFfzfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355733; c=relaxed/simple;
	bh=rcRKTHMgDAX8PllGZPZD6P0e+xxwPm+8g2lAktqnBbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ty/HoROeEa1FZBQy5BjQDZ2oF+b+faAdSY/i5yWWCyr6MAXr7pHcROzwqcdOygakq9fB/OnKNgqe0sXqanoksHQ8hqj7awpYUc/VZpONF1HXoQD0poyH4hmHks+QB6ZGU5pIoQNJzjxWdKpbRkmbBEC9bVeNfWBURMeDOQ2OywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldp5gwWP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fb25c2e56so3886841a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757355730; x=1757960530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqJ6oeupyFoCq22K3h7rYsUxN6++htHlX4jz9YWLbIY=;
        b=ldp5gwWPcxMMip03s8xlnlHbN5nmUgVJDWSskmbUAPC71wUXaF8jDPn/ReKMBwL1+v
         H/aaxlrik5dAW/FzIVOPWBo8TYJ/eLt3/0B4KVaeyGgdRFQpGBBNK94aX+HDe5+0ZoKQ
         DyzTab9MYj7w1QKOgIh1hub6Ce+nnl2tGBcQU4iIiBDF8hytnaYbjq8JfE4zC4nXAcIX
         oxcN8oK1BqVjqcVoMzrJkgH6gXL+MjUO2Nwrek7av+tl/45fyL6kBDQIQurxu0Fzz5zU
         p+ZH0KSDq4fEDmwHo/BOe7B9UW7QJnUNeZexDmmOVY7hY0QbfVZya6Izuideu/EtmAiM
         gyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355730; x=1757960530;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqJ6oeupyFoCq22K3h7rYsUxN6++htHlX4jz9YWLbIY=;
        b=a3ibJNWCmfY2UcmC0kSA2dG3Ew0ICzqAyff6KY/hMbyq3GchvtywctjxIuhBW4F4d+
         mrgZIhA9dHyIDl2kjB9eDZfWEXZ/xecF+HyLrCntGEe+ahwe35nu0157kVywJy5WKNBO
         wuL2GVicFvLtNc09vKAm4+firRa5s9bkn19KiQKpx102xSsxX+4j/SJKwxXzL2jDSj3y
         l/rBhVF04HVrcgHJSh2ZYrS9ZvieMT4IU8NxbF7j0/cUpSA6ngAIAMPt0HqQc/Z58mqY
         zUySwMBWZq2XVoafoJhNXSpfkmBYahOH+ZfOWWKaFt6p0GXBxiiT2N23PZ3dtLeg7S5y
         X7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi54JE1Q5GM/mphpYMgKyrXHyiSVkQ9b5ieR9fH41lqo0WPRnJ6zO+gAYWV+X8kCz69jIHoge1rrQF2I0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W0UyGTHpCL1csh0FYdSP/cnoy1/EF7ltBEvQw+MeSzoSIpme
	VvapTsSjpUFMzRlsMpgcAXYugm+2jtA+6YxkqhwWMMWzMii+I36N6mIw1P9TIv/j3zz3xkWASnE
	dfShkeQ==
X-Google-Smtp-Source: AGHT+IEbQvkee/CaXvw/+WaunbStZu4YLk5hf4ArlRIAE0BaoHNJSPnumXPNrYPD+Ij4vIhQjuh+661a/us=
X-Received: from pjbpq7.prod.google.com ([2002:a17:90b:3d87:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc7:b0:32c:923d:b840
 with SMTP id 98e67ed59e1d1-32d43f04ebamr11088886a91.7.1757355730160; Mon, 08
 Sep 2025 11:22:10 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:22:08 -0700
In-Reply-To: <20250905135957.12341-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aLqh2ojEpZZhjheT@google.com> <20250905135957.12341-1-aqibaf@amazon.com>
Message-ID: <aL8e0MMa4U2-nstQ@google.com>
Subject: Re: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: aqibaf@amazon.co.uk, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025, Aqib Faruqui wrote:
> Thanks for the suggestion. I don't see your previous redefinition of PAGE=
_SIZE=20
> upstream, just 3 lines above the warning redefinition:

Oh, I manually added a conflicting definition to demonstrate the warning gc=
c
will provide.

> > In file included from include/x86/svm_util.h:13,
> >                  from include/x86/sev.h:15,
> >                  from lib/x86/sev.c:5:
> > include/x86/processor.h:373:9: error: "PAGE_SIZE" redefined [-Werror]
> >   373 | #define PAGE_SIZE               (1ULL << PAGE_SHIFT)
> >       |         ^~~~~~~~~
> > include/x86/processor.h:370:9: note: this is the location of the previo=
us definition
> >   370 | #define PAGE_SIZE               BIT(12)
> >       |         ^~~~~~~~~
>=20
> But I investigated further and found that both glibc and musl define PAGE=
_SIZE in=20
> sys/user.h:
>=20
> glibc (sys/user.h):
>   #define PAGE_SHIFT    12
>   #define PAGE_SIZE     (1UL << PAGE_SHIFT)
>=20
> musl (sys/user.h):
>   #define PAGE_SIZE     4096

But that still doesn't fully explain how the previous definition comes into=
 play.
E.g. if I modify x86/processor.h to explicitly #include <sys/user.h>, then =
I see
redefinition warnings:

  In file included from x86/tsc_scaling_sync.c:8:
  include/x86/processor.h:373:9: warning: "PAGE_SIZE" redefined
    373 | #define PAGE_SIZE               (1ULL << PAGE_SHIFT)
        |         ^~~~~~~~~
  In file included from include/x86/processor.h:13:
  /usr/include/x86_64-linux-gnu/sys/user.h:173:9: note: this is the locatio=
n of the previous definition
     173 | #define PAGE_SIZE               (1UL << PAGE_SHIFT)
         |         ^~~~~~~~~

> KVM selftests (include/x86/processor.h):
>   #define PAGE_SHIFT		12
>   #define PAGE_SIZE     (1ULL << PAGE_SHIFT)
>=20
> This creates redefinition warnings with both C libraries on my system. I'=
ve already=20
> sent a v2 patch series with the PAGE_SIZE patch dropped but I'm not sure =
what the=20
> next course of action would be for this?

I don't see a clean way to resolve this other than to eliminate the #includ=
e of
whatever is leading to musl defining PAGE_SIZE.  I don't want to #undef and
re-define PAGE_SIZE because then different compilation units (or even code =
chunks)
could see different definitions.  And as below, relying on libc for the #de=
fine
isn't viable.  So I think before we change any code, we need to first figur=
e out
exactly how musl's conflicting definition comes into existence, and then go=
 from
there.

Ideally, we would skip selftests' definition and assert that the existing d=
efinition
is compatible, but that won't work because musl's definition isn't actually
compatible with KVM selftests' definition, and more importantly isn't compa=
tible
with glibc's definition.  KVM selftests and glibc both effectively #define =
PAGE_SIZE
to be a u64 (KVM selftests only support 64-bit builds, so glibc's 1UL is an=
 unsigned
64-bit value).  But musl's definition is a signed int.  I.e. we can't solve=
 the
64-bit unsigned vs. 32-bit signed by relying on libc.


64-bit unsigned vs. 32-bit signed is unlikely to cause problems in practice=
, and
in fact there are no problems in the current code base.  But I don't love c=
reating
a potential pitfall for musl, especially since it's quite obviously not a c=
ommon
libc for KVM selftests, i.e. could lead to very latent bugs.

E.g. building with this

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/te=
sting/selftests/kvm/include/x86/processor.h
index 488d516c4f6f..1b5e92debd20 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -368,7 +368,11 @@ static inline unsigned int x86_model(unsigned int eax)
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
=20
 #define PAGE_SHIFT             12
+#define PAGE_SIZE              4096
+#ifndef PAGE_SIZE
 #define PAGE_SIZE              (1ULL << PAGE_SHIFT)
+#endif
+kvm_static_assert(PAGE_SIZE =3D=3D (1ULL << PAGE_SHIFT));
 #define PAGE_MASK              (~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
=20
 #define HUGEPAGE_SHIFT(x)      (PAGE_SHIFT + (((x) - 1) * 9))
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/t=
esting/selftests/kvm/set_memory_region_test.c
index ce3ac0fd6dfb..822119e8853a 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -608,9 +608,12 @@ static void test_mmio_during_vectoring(void)
 int main(int argc, char *argv[])
 {
 #ifdef __x86_64__
+       u64 total_size =3D PAGE_SIZE * 1048576;
        int i, loops;
        int j, disable_slot_zap_quirk =3D 0;
=20
+       printf("Total size =3D %lx\n", total_size);
+
        if (kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_SLOT_ZAP=
_ALL)
                disable_slot_zap_quirk =3D 1;
        /*

Generates a warning:

  set_memory_region_test.c: In function =E2=80=98main=E2=80=99:
  set_memory_region_test.c:611:36: warning: integer overflow in expression =
of type =E2=80=98int=E2=80=99 results in =E2=80=980=E2=80=99 [-Woverflow]
    611 |         u64 total_size =3D PAGE_SIZE * 1048576;
        |    =20

And yields:

  $ ./set_memory_region_test=20
  Total size =3D 0

> > Please keep discussions on-list unless there's something that can't/sho=
uldn't be
> > posted publicly, e.g. for confidentiality or security reasons.
>=20
> Apologies, doing this for the first time!=20

No worries, we've all been there :-)

