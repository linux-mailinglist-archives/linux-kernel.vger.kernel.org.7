Return-Path: <linux-kernel+bounces-682458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62AAD6040
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CED0177BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663F2BD5AF;
	Wed, 11 Jun 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0WJLkPp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA7289804
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674609; cv=none; b=Aun667xGVR6wAO/otds6XJpiovIowZUdqjEK7FhfxrcznTNI1evA4MA7y4BadXukfc4qW1HEUUaOXoWKqjOhMeN42wEpx8A32SvP0Q6S6ns7F2XCqxeMdY/uXdeb2Zz+cqD00I78a0bH/zCWryJZwnWo77olEAF/oHJvXCtRu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674609; c=relaxed/simple;
	bh=ULqnTPYsKF06pcvjpS4pJ5ParI3sEYtalCgjbiRL4p4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5+EYMi3qrRChBpjEWGElG7VArDHtZyuIjKeIgUDLwToqOQvr7uDFBWImHlf5rF2flr6xx8YdBbJ2HGxIij0LtUMt87RsuIIbIhFt7RbCX/xYBgY95jPgh/nqhejdMFLW41j/Fz+bq0rLrsyCAxfWzHMzTf22NIgXAbduJxDzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0WJLkPp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so255300a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749674607; x=1750279407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d060pSAq8/DH5mm3MDvBDst9ooXda9YKqtA5WfG4n4U=;
        b=k0WJLkPpl8kTE3vkZCU1KXq7RuIET3L8Ry0BvvM3MSRn0lumBzAqaemBDBNZV8v97Y
         WdCmYYn3HGm7FYz337qQtqh9b22ATDedYk3fQiGYXd6R9fRMXLC9RelihaHywdHFKxEc
         GW6EAFlpHMN6/RXLM1phy9hO2bL2qHtRbFIR4XPoQySCYR9mhFNyBbh4lpGxNkLXh1V0
         +tkn3UAjV3PtWdIVuY7l4z7RZt+I7xOGITHWuDJzDGqqU9lhOykF2SKbdNrEalZqRYj/
         SR8RibDMeJlvINrG92fRWaBLmSxY/oxtgOxvEdaJy5deWYX7FnUhPKSavwHrmyXyvHrQ
         xaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749674607; x=1750279407;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d060pSAq8/DH5mm3MDvBDst9ooXda9YKqtA5WfG4n4U=;
        b=USpaK3oMvCtJvmlBk5F5lrngufnrD4O5FXxVBcKhq8Cv5qhGTuhdLw2KovTKsTSpBl
         dlKLu6DjY5JlF0q8TG6PgDNDL2ydkMunFo4W7raaEzbRyAfMFDS5YrLJ42MmPVEkRjEu
         ScsP4LjvGtMeFqfHU0iZz1WHICCV/DZXuuj3b2mGHBppvfV1YAqOxms04d8ru9DjzCLc
         vEOX6sY2iDiXfWGVu+vkp0zdbL2ieWoTDJrDGXJAoho0BjMhgWHVWUitSa6eaOjAxKDe
         m3dFZgvSSS5d3Z6ymnHnnObAoO696EAUpXRcPD/mySWDaXG1yoR1nSZv2VD9ImZZlKgE
         UGcA==
X-Forwarded-Encrypted: i=1; AJvYcCUthEd9C+F0gFLQ04kgrAGK4zNrTgxSUHOtuzAVVLMkqkhHAPKXIg6EZT9WQQOaPCwuDQ9vvlXkGEuORaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzkidhJyaCh3NRF5h4E336eeET5hQOVsLxmUKLCFwe86pqCjy
	Ez2wBcP8ut/iauRytKJkycEbkgOku4MFiiePZPaVH4PlxIEPbQhO6a34xXRC80yY0MZMzYXGU5W
	lrD3gzw==
X-Google-Smtp-Source: AGHT+IEPpc3NqQdcRYKE9ND1cgLJUga6qqL+x0QwVfYU2cE1MQwosCZtfMiKqfS9BYCSWMrL4J6iY4azHyM=
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:311:ea2a:3919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384f:b0:311:b5ac:6f6b
 with SMTP id 98e67ed59e1d1-313bfb66d78mr1292242a91.9.1749674606997; Wed, 11
 Jun 2025 13:43:26 -0700 (PDT)
Date: Wed, 11 Jun 2025 13:43:25 -0700
In-Reply-To: <7de83a03f0071c79a63d5e143f1ab032fff1d867.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611001018.2179964-1-xiaoyao.li@intel.com>
 <aEnGjQE3AmPB3wxk@google.com> <5fee2f3b-03de-442b-acaf-4591638c8bb5@redhat.com>
 <aEnbDya7OOXdO85q@google.com> <7de83a03f0071c79a63d5e143f1ab032fff1d867.camel@intel.com>
Message-ID: <aEnqbfih0gE4CDM-@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Embed direct bits into gpa for KVM_PRE_FAULT_MEMORY
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025, Rick P Edgecombe wrote:
> On Wed, 2025-06-11 at 12:37 -0700, Sean Christopherson wrote:
> > Ugh, and the whole tdp_mmu_get_root_for_fault() handling is broken.
> > is_page_fault_stale() only looks at mmu->root.hpa, i.e. could theoretic=
ally blow
> > up if the shared root is somehow valid but the mirror root is not.=C2=
=A0 Probably can't
> > happen in practice, but it's ugly.
>=20
> We had some discussion on this root valid/invalid pattern:
> https://lore.kernel.org/kvm/d33d00b88707961126a24b19f940de43ba6e6c56.came=
l@intel.com/
>=20
> It's brittle though.

Hmm, yeah, the is_page_fault_stale() thing is definitely benign, just odd.

> > Oof, and I've no idea what kvm_tdp_mmu_fast_pf_get_last_sptep() is doin=
g.=C2=A0 It
> > says:
> >=20
> > 	/* Fast pf is not supported for mirrored roots=C2=A0 */
> >=20
> > but I don't see anything that actually enforces that.
>=20
> Functionally, page_fault_can_be_fast() should prevented this with the che=
ck=C2=A0of
> kvm->arch.has_private_mem.

No?  I see this:

	if (kvm->arch.has_private_mem &&
	    fault->is_private !=3D kvm_mem_is_private(kvm, fault->gfn))
		return false;

I.e. a private fault can be fast, so long as the page is already in the cor=
rect
shared vs. private state.  I can imagine that it's impossible for TDX to ge=
nerate
protection violations, but I think kvm_tdp_mmu_fast_pf_get_last_sptep() cou=
ld be
reached with a mirror root if kvm_ad_enabled=3Dfalse.

	if (!fault->present)
		return !kvm_ad_enabled;

	/*
	 * Note, instruction fetches and writes are mutually exclusive, ignore
	 * the "exec" flag.
	 */
	return fault->write;

> But, yea it's not correct for being readable. The mirror/external concept=
s
> only work if they make sense as independent concepts.  Otherwise it's jus=
t
> naming obfuscation.

