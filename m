Return-Path: <linux-kernel+bounces-858480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC268BEAF97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE37586EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21632E88AE;
	Fri, 17 Oct 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12AT3N/9"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C212E7BD9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719762; cv=none; b=ihhwEDUsc6dzScKLQ8j/R+W+QsMIkRbDf7xRsbz4xsrX4Sld0wkUU/JL0WKCe/omuVo+yb4+OgGIqZ+DSc96N9KgOZgHR/fDkJxenlwh3TQNWhW5BnGZ1a81ju2JoJuKgxWXXNJW4wUnCdgS58NKUpNyX4CxWMUdMfoaUQ/0D8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719762; c=relaxed/simple;
	bh=gVgiYRt/rqFaySiyrmr5fh20anzP3rCx+EcjH3amo/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JkvLnRUJXgtgpnOxGvtlMJpoTB/hZKfdo6p+CimmPu1sUvuNUycwuyyi0/CyQX5KUk0aw3gB4TZ27SQKEbleqUSZ3xr80SFM3l/EAsqxT3Nmj/aSfunTeYa1BQoJsH/iN7+viDDG8nvurm7i1Jq1Uii5MGAknnGiCJ9f4xqvrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12AT3N/9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so1795663a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760719760; x=1761324560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOIrByP8ZUQuvgPySyDlm6fhYAgi3WQo8mV8b43qPRw=;
        b=12AT3N/9cYYSiUxzv8icu5bnXMFwA1BBfhhmgMX6ik3Dws1rvaIXGxyG4gAuBajA24
         r7oz/g/ke6UT7zC1KgduHFUn8Boh9M1qMqG7n47AA+4+r2eGXHocdX99KmQV/jU6sPTv
         Qu7Ml2CjIrmGIEVanK485VbbMH0tlSNgf0O5qbAntCG5VuNQ1jGUpCucZHHD0brlx3Pk
         diX6f6POxLJbrF2uaauuy98HKO96AXYEjcBVvl1zFA6DeYJBu6kIX+ABX3RKAKS56UuT
         gOWcquuAcL8TkYO/h2hEjRZOs4wwdz+0feoLoPs2W0q2GFKfily4SlmDL1ejU18kUzwh
         AN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719760; x=1761324560;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hOIrByP8ZUQuvgPySyDlm6fhYAgi3WQo8mV8b43qPRw=;
        b=iU7DBi6m9rr68sV/kid804F988nP72wF897+IbUKALaWFhyoJrexHNwCKl1njFOe9J
         O2QhdqzU3sZZU9wACI0xrOVfIMoquoiEKlmDG+MceKvGsEhKrB4NOVqAqAKgZ+Dsa2tj
         M207D3pof+dDctzIKD+YjsvNC+LxuvMD0uuT/db2rIDXmAxS5Dc3WVhbvLRJpoH2gA/o
         QcNn/CozH/ZPCafkfdRKkSzxh+9+v2+70gIoAMHF5HhxDf1R7KHri/3y+Wy86umYrNJe
         z4OwtbG75Vb755QvNg7GXLlBX/lNLVQaGVF3T8U4/r6rDvg1ZiHyrMukTQCgpRIilAFi
         eGLA==
X-Forwarded-Encrypted: i=1; AJvYcCXY31dc8N9p8DnX8iY2RMqNbGEROuS9r8O/2jfB7jIcIGtyIfhRCgPq9BhJnqkXUsARZlRFmiGosVsWenQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOavogZYSGBUBmubcR82HCDayD9EB1NTws8KudjeFGHUHlo+kK
	Ip7krHGNY+LG+CQ8S87kZcANeu1fbbqk2FTqlaq5mLmjn1uiWxbDiP1HrLK9BHfGLy7lUZdKFwr
	hAuOAnA==
X-Google-Smtp-Source: AGHT+IEuqhHVpbBVF4PRy6ZWRfMuRBmBaTfUEEN01d1cgDPtR7abw4umz8fmd13HoIYheHHmygdWMEDHdzI=
X-Received: from plbkg4.prod.google.com ([2002:a17:903:604:b0:290:be3d:aff6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40ca:b0:290:b928:cf3d
 with SMTP id d9443c01a7336-290cbd35d7dmr53537195ad.59.1760719759868; Fri, 17
 Oct 2025 09:49:19 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:49:17 -0700
In-Reply-To: <CANiq72m0rNCaKandZgRa4dMhNOEN7ZanT5ht4kT8FLxYoWLVLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com> <CANiq72ntKAeXRT_fEGJteUfuQuNUSjobmJCbQOuJWAcNFb1+9w@mail.gmail.com>
 <aPFVcMdfFlxhgGZh@google.com> <CANiq72m6vWc9K+TLYoToGOWXXFB5tbAdf-crdx6U1UrBifEEBA@mail.gmail.com>
 <diqzqzv2762z.fsf@google.com> <CANiq72m0rNCaKandZgRa4dMhNOEN7ZanT5ht4kT8FLxYoWLVLQ@mail.gmail.com>
Message-ID: <aPJzjWzL4EbwDM66@google.com>
Subject: Re: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
From: Sean Christopherson <seanjc@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>, David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025, Miguel Ojeda wrote:
> On Fri, Oct 17, 2025 at 1:57=E2=80=AFAM Ackerley Tng <ackerleytng@google.=
com> wrote:
> >
> > Using the command on virt/ would pick it up. Would it be better to add
> > "virt/" to the "automation" + update .clang-format while we're at it?
>=20
> Yeah, that is what I was suggesting if you rely on it (and if the
> maintainers of the relevant folders are OK with it).

Hmm, my vote would be to go all-or-nothing for KVM (x86), i.e. include ever=
ything
in KVM, or explicitly filter out KVM.  I don't see how auto-formatting can =
be
useful if it's wildly inconsistent, e.g. if it works for some KVM for-each =
macros,
but clobbers others.

And I'm leaning towards filtering out KVM, because I'm not sure I want to e=
ncourage
use of auto-formatting.  I can definitely see how it's useful, but so much =
of the
auto-formatting is just _awful_.

E.g. I ran it on a few KVM files and it generated changes like this

-       intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
-                                                INTEL_FIXED_0_USER |
-                                                INTEL_FIXED_0_ENABLE_PMI);
+       intel_pmu_enable_fixed_counter_bits(
+               pmu, INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |
+                            INTEL_FIXED_0_ENABLE_PMI);

and=20

-                       intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_=
0_ADAPTIVE);
+                       intel_pmu_enable_fixed_counter_bits(
+                               pmu, ICL_FIXED_0_ADAPTIVE);

There are definitely plenty of good changes as well, but overall I find the=
 results
to be very net negative.  That's obviously highly subjective, and maybe the=
re's
settings in clangd I can tweak to make things more to my liking, but my ini=
tial
reaction is that I don't want to actively encourage use of auto-formatting =
in KVM.

I think no matter what, any decision should be in a separate, dedicated pat=
ch/thread.
So for this series, I'll drop the .clang-format change when applying, assum=
ing
nothing else pops that requires a new version.

