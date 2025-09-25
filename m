Return-Path: <linux-kernel+bounces-833001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B8BA0F35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9C176F55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FED311C0C;
	Thu, 25 Sep 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAMXGefJ"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F830F55D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822685; cv=none; b=opW30T+Sf63A7R5lXEPwVK/tTcLdi+/x9C5WKMqLvNstgeJpL+GKvVljSYLDsbhDFv0zokL3JdCW8gMcPhdyvYidAW8Mqp4X3x1/DwohXhLSWrAslCWwd7/eRkv68aeI5OZsiwWbqEWdLlPu04t0KxuC0Ksmuiw0VYoa9GfMtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822685; c=relaxed/simple;
	bh=78aoFPKM60WsxGNI7Ph0+i/e6nCWY8oeVcHsoWNuMdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BtV1vrApliVUdVX9FypWTGtJ7D1cFCH0e4XkcDFEtVdLGOlWVJYmjPe78ncm/bFs5rN94ci0SlTn/OoLInNUprs2V9SiNXllPhVummi5tiPXDu4bsHSdQ6aF5s085qoR3fnKF3T5H5bbHpfSmaTPykSvw8wXBnpDLsMRiVSPHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAMXGefJ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-634741fccc9so1039346a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758822681; x=1759427481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpqAAvRRl8ijYNcMuZKa7G4PlR+tOnu+IYSl1u8opK4=;
        b=XAMXGefJQV93Vth1p+xu3VSXP+rJMhlgt5GZZhJC+aP1DKFBgO7IaCHT0ak7KIeCxF
         D7ML8bM4SgBLnCXf5cvBm8HHmGPnXvTp2ZuBdGF5U/iqCTwmZv7YkKIceXn2QrMlUi8D
         PoFVSh3y4Mbp/lRcgZwKSuKQD8Le/J13Hb9sj7vgbD3kGTgnd3XcFTBnqjaPtRqJ+fd1
         PkZv/k+Os75swFFr3A87XPk9TFsg8dyYmLjxmcaFa6g7jpDGs3PtbDw2mrPr4JY/x3u9
         WErm4NKF7pOvd6Cdbm1vxwy+r6qsRtW1ivzOSO8hflAUPNB5OOilMF6AlFgxxwQgoYhJ
         eNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822681; x=1759427481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpqAAvRRl8ijYNcMuZKa7G4PlR+tOnu+IYSl1u8opK4=;
        b=WyUS3If/5F9jXqEjUDcd/VGNbo0LOjnmVWwWKp+tQNRGBr2pX9pg7YE2xLsLGnS6sv
         bf1W4KAuP/hMB36sWt7mGm/qy3l16oLbZxQUwZy6Iw3/TukuJ7GTBUZms2eYFm3qc5+8
         O1uT6fDylyVaCEDVL+Sf7pMdwURr1TsLWf/aOoCACxP/stLMd0/oqybmGNA4C6vrxgy3
         rnAaK0MxY0nAnSo+eeINr26JQZTH+kAh+BgESb1nkPlYF7BzCtTq6Gz5WeNdYy3uW16c
         EG+GpTlqoKyzpW8Zgzmi2LBSgjNn2NBC5aW36BLr5RAUWO9MNoaoIF9hjExOuS8vW7+N
         SkKg==
X-Forwarded-Encrypted: i=1; AJvYcCVY6Mj5VdU5I5/8xp4b3oj4LTPEI8ns6OJWvJ6tmY1ZXARqNL4wscZmNYVrfkAVbTrwYZTSrD8wepKyIy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7G5KTVlhxn+59r2/FhdKTvyU1JJMQ3ZOLeX+s+ab4xAxoh00d
	L6wz4HXBchJaj1h337fo49xxYABh21F3nZ9GtRjzRjtNtRO2U/BD/LU1W4cgAfuATTJjw+rFtzC
	6fugZeYKCuyeGMg==
X-Google-Smtp-Source: AGHT+IEiFUjjNFB9hUrXlVQKck8BwlAQbc3hiE92OqPlhCkF8YWxZQAwFhYvcC8kcCf0XKrNjtXumE3uyphhJw==
X-Received: from edsr23.prod.google.com ([2002:aa7:da17:0:b0:634:4c0d:974a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:543:b0:62f:4b68:bfae with SMTP id 4fb4d7f45d1cf-6349fa8fcf7mr2697793a12.31.1758822680886;
 Thu, 25 Sep 2025 10:51:20 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:51:19 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: aerc 0.20.1
Message-ID: <DD22LSMJG70E.2N2B3FF1KKPUE@google.com>
Subject: Re: [PATCH 00/21] mm: ASI direct map management
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Jackman <jackmanb@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, <owner-linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Sep 24, 2025 at 2:59 PM UTC, Brendan Jackman wrote:

> base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1

I forgot to mention that this is based on linux-next from 2025-09-22. I
have pushed this series here:

https://github.com/bjackman/linux/tree/asi/direct-map-v1

And I'll be keeping this branch up-to-date between [PATCH] revisions as
I respond to feedback (I've already pushed fixes for the build failures
identified by the bot):

https://github.com/bjackman/linux/tree/asi/direct-map

Also, someone pointed out that this post doesn't explain what ASI
actually is. This information is all online if you chase my references,
but so people don't have to do that, I will add something to
Documentation/ for v2. 

For the benefit of anyone reading this version who isn't already
familiar with ASI, I'm pasting my draft below. Let me know if I can
clarify anything here.

Cheers,
Brendan

---

=============================
Address Space Isolation (ASI)
=============================

.. Warning::
   ASI is incomplete. It is available to enable for testing but doesn't offer
   security guarantees. See the "Status" section for details.

Introduction
============

ASI is a mechanism to mitigate a broad class of CPU vulnerabilities. While the
precise scope of these vulnerabilities is complex, ASI, when appropriately
configured, mitigates most well-known CPU exploits.

This class of vulnerabilities could be mitigated by the following *blanket
mitigation*:

1. Remove all potentially secret data from the attacker's address space (i.e.
   enable PTI).

2. Disable SMT.

3. Whenever transitioning from an untrusted domain (i.e. a userspace processe or
   a KVM guest) into a potential victim domain (in this case, the kernel), clear
   all state from the branch predictor.

4. Whenever transitionin from the victim domain into an untrusted domain, clear
   all microarchitectural state that might be exploited to leak data from a
   sidechannel (e.g. L1D$, load and store buffers, etc).

The performance overhead of this mitigation is unacceptable for most use-cases. In the
abstract, ASI works by doing these things, but only *selectively*.

What ASI does
=============

Memory is divided into *sensitive* and *nonsensitive* memory. Sensitive memory
refers to memory that might contain data the kernel is obliged to protect from
an attacker. Specifically, this includes any memory that might contain user data
or could be indirectly used to steal user data (such as keys). All other memory
is nonsensitive.

A new address space, called the *restricted address space*, is introduced, where
sensitive memory is not mapped. The "normal" address space where everything is
mapped (equivalent to the address space used by the kernel when ASI is disabled)
is called the *unrestricted address space*. When the CPU enters the
does so in the restricted address space (no sensitive memory mapped).

If the kernel accesses sensitive memory, it triggers a page fault. In this page
fault handler, the kernel transitions from the restricted to the unrestricted
address space. At this point, a security boundary is crossed: just before the
transition, the kernel flushes branch predictor state as it would in point
3 of the blanket mitigation above. Furthermore, SMT is disabled (the sibling
hyperthread is paused).

.. Note::
  Because the restricted -> unrestricted transition is triggered by a page
  fault, it is totally automatic and transparent to the rest of the kernel.
  Kernel code is not generally aware of memory sensitivity.

Before returning to the untrusted domain, the kernel transitions back to the
restricted address space. Immediately afterwards, it flushes any potential
side-channels, like in step 4 of the blanket mitigation above. At this point SMT
is also re-enabled.

Why it works
============

In terms of security, this is equivalent to the blanket mitigation. However,
instead of doing these expensive things on every transition into and out of the
kernel, ASI does them only on transitions between its address spaces. Most
entries to the kernel do not require access to any sensitive data. This means
that a roundtrip can be performed without doing any of the flushes mentioned
above.

This selectivity means that much more aggressive mitigation techniques are
available for a dramatically reduced performance cost. In turn, these more
aggressive techniques tend to be more generic. For example, instead of needing
to develop new microarchitecture-specific techniques to efficiently eliminate
attacker "mistraining", ASI makes it viable to just use generic flush operations
like IBPB.

Status
======

ASI is currently still in active development. None of the features described
above actually work yet.

Prototypes only exist for ASI on x86 and in its initial development it will
remain x86-specific. This is not fundamental to its design, it could eventually
be extended for other architectures too as needed.

Resources
=========

* Presentation at LSF/MM/BPF 2024, introducing ASI: https://www.youtube.com/watch?v=DxaN6X_fdlI

* RFCs on LKML:
  * `Junaid Shahid, 2022 <https://lore.kernel.org/all/20220223052223.1202152-1-junaids@google.com/>`__
  * `Brendan Jackman, 2025 <https://lore.kernel.org/linux-mm/20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>`__


