Return-Path: <linux-kernel+bounces-787316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC88B37473
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F1E3613EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190922F9C39;
	Tue, 26 Aug 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjIQ+vab"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F042F8BF1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243803; cv=none; b=Jrz6EFMOaTY5AcxAVg/8l13K8oDMxd3m/CGLeZuMbHiTQo8X0XPu9EiFzYFEtDlfVIxM/J8NuGv7bnxTg7GlqJQ43aufTuQx3iNz42sPfA6r94a0u1mplmznwkmjIXV2afE057FkPH2ls9E/tnZEFmVjIzIcdn9MBXl3IyVRSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243803; c=relaxed/simple;
	bh=wORq5psHRnZ8nN1xyCrydBPgYQLdMfpzqAjO7HR6zDI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4gwIBmclA3pNZUNyfU+F1zBHsMrxRZ2AuD4KoNWxgnSOCcyD2+ul7iwwOs3XJD8vu/FHlfcSTH4gHhplMy3JPiT/yapIEYBz9lPzlO9HC4xYTdl/W1OQLNkIcEyaGlsD6SGZu5XK2jIwEgpOOudT+W6S4GEsBkChjQ2O7uU+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjIQ+vab; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3259ff53c2eso3841084a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756243801; x=1756848601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0XNYuhFzewq5SpoNE6ECYDEqUR/PdEjHr7BqxomWbo=;
        b=PjIQ+vabOumHxj/GH39y//tkfjcWcmLqPf94BbTplrjKhBpPIEglePDcwsm1CMDnRZ
         Gg08Qsvxn2w2sm40QVnsTj2nFPKp8vIpbHkHKIJFCtl37ytu65YEL5se5vAgBYEWRbvJ
         ZoNiqIdQL9Ofw4SXvnnvoOb/ldhOtWwePAjz9Zaoa1Rb5Z0H2ToEqGlOiJyWpGahfZ4F
         DCvmS5Ro5Dgyp9KDzIzqXxdGDitRy9TTUort9dHCKzlZQbl/y5gdz50b/EeCuWXhHXdk
         GZMZ3lYNWhU2khDyrnxiUe5KjOBAt4sPTqdIHSX3v5Tz0OWBePmABdN70cOybWPLw1cC
         x8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243801; x=1756848601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0XNYuhFzewq5SpoNE6ECYDEqUR/PdEjHr7BqxomWbo=;
        b=oq6Fnm1x+F4jCOmRsoUPuSAtPHx/9H9X8SnaqfHp2va33Uv2udEHc234+pCVeQqNhl
         bcV/0cDyrvJtXQIzsnzztqXMFZ2gVME1Jeot8YIWhTkW5Pocrtsw8h/L8dHeI4QiipGz
         p1vTnlTvKdxwA+QvdNWWBS5I4zNz+4fB8bNxXAA3dCh455aNarTw05tyRhlHci7Fwikc
         J7QMsXEL1BVwsCO2HrbF8K4rCEHk1Z4vyitqZwskGyYNAhS8GwcDq6fYbxuXvaucnDHZ
         dUWJOCc3mBY1wA67nYPwZxqaXXGMohT7MKztswSp5X+808e8+Jg3C91Rsq2CSlApEfpT
         RqHw==
X-Forwarded-Encrypted: i=1; AJvYcCUu+E6xB3/Dp/xivR37CEewUaFoV3XKG6g8+7RyrfWwRVGN2mayKv5U2YafVHZW3s0Sf/VPaAGN0pkgkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL41F/FSr7PuUaJOnnfERJhWBqrACzsBsFihyXgkR2KNFjTGJ9
	qisyilJJxNnTtJePFAnKN9qBcyG/h9uRtQCaJ1gpZmYN2ljoa5olbw+9sxKZ1qQIKk/Hi1jG/Pj
	/N0qL9g==
X-Google-Smtp-Source: AGHT+IF7MPxNgNaQJ4UlRAoZAcA9biTVvRMSBkz6IDXnOSl5pa+enjNi1lYtcaOBiqr8KYqBgElOkDB/jcY=
X-Received: from pjqq8.prod.google.com ([2002:a17:90b:5848:b0:325:d07:8343])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c6:b0:324:24d:3207
 with SMTP id 98e67ed59e1d1-32515eabb6dmr23253945a91.17.1756243801375; Tue, 26
 Aug 2025 14:30:01 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:29:59 -0700
In-Reply-To: <aK4LIj-OZsP_35wc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com> <20250821210042.3451147-6-seanjc@google.com>
 <aKeeRynpwFTSONfm@linux.dev> <aK4DwtuQtzYvRei-@google.com> <aK4LIj-OZsP_35wc@linux.dev>
Message-ID: <aK4nVyoEd3hgmxaD@google.com>
Subject: Re: [RFC PATCH 05/16] KVM: arm64: Introduce "struct kvm_page_fault"
 for tracking abort state
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Oliver Upton wrote:
> On Tue, Aug 26, 2025 at 11:58:10AM -0700, Sean Christopherson wrote:
> > On Thu, Aug 21, 2025, Oliver Upton wrote:
> > > > +struct kvm_page_fault {
> > > > +	const u64 esr;
> > > > +	const bool exec;
> > > > +	const bool write;
> > > > +	const bool is_perm;
> > > 
> > > Hmm... these might be better represented as predicates that take a
> > > pointer to this struct and we just compute it based on ESR. That'd have
> > > the benefit in the arch-neutral code where 'struct kvm_page_fault' is an
> > > opaque type and we don't need to align field names/types.
> > 
> > We'd need to align function names/types though, so to some extent it's six of one,
> > half dozen of the other.  My slight preference would be to require kvm_page_fault
> > to have certain fields, but I'm ok with making kvm_page_fault opaque to generic
> > code and instead adding arch APIs.  Having a handful of wrappers in x86 isn't the
> > end of the world, and it would be more familiar for pretty much everyone.
> 
> To clarify my earlier point, my actual interest is in using ESR as the
> source of truth from the arch POV, interface to the arch-neutral code
> isn't that big of a deal either way.

Ya, but that would mean having something like

  static bool kvm_is_exec_fault(struct kvm_page_fault *fault)
  {
	return esr_trap_is_iabt(fault->esr) && !esr_abt_iss1tw(fault->esr);
  }

and

  if (kvm_is_exec_fault(fault))

in arm64 code and then

  if (fault->exec)

in arch-neutral code, which, eww.

I like the idea of having a single source of truth, but that's going to be a
massive amount of work to do it "right", e.g. O(weeks) if not O(months).  E.g. to
replace fault->exec with kvm_is_exec_fault(), AFAICT it would require duplicating
all of kvm_is_write_fault().  Rinse and repeat for 20+ APIs in kvm_emulate.h that
take a vCPU and pull ESR from vcpu->arch.fault.esr_el2.

As an intermediate state, having that many duplicate APIs is tolerable, but I
wouldn't want to leave that as the "end" state for any kernel release, and ideally
not for any given series.  That means adding a pile of esr-based APIs, converting
_all_ users, then dropping the vcpu-based APIs.  That's a lot of code and patches.

E.g. even if we convert all of kvm_handle_guest_abort(), which itself is a big task,
there will still be usage of many of the APIs in at least kvm_translate_vncr(),
io_mem_abort(), and kvm_handle_mmio_return().  Converting all of those is totally
doable, e.g. through a combination of using kvm_page_fault and local snapshots of
esr, but it will be a lot of work and churn.

The work+churn itself doesn't bother me, but I would prefer not to block arch-neutral
usage of kvm_page_fault for months on end, nor do I want to leave KVM arm64 in
a half-baked state, i.e. I wouldn't feel comfortable converting just
__kvm_handle_guest_abort() and walking away.

What if we keep the exec, write, and is_perm fields for now, but add proper APIs
to access kvm_page_fault from common code?  The APIs would be largely duplicate
code between x86 and arm64 (though I think kvm_get_fault_gpa() would be different,
so yay), but that's not a big deal.  That way common KVM can start building out
functionality based on kvm_page_fault, and arm64 can independently convert to
making fault->esr the single source of truth, without having to worry about
perturbing common code.

