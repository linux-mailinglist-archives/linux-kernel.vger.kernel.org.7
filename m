Return-Path: <linux-kernel+bounces-802340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC51B4513D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D4D3B66F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B482FF65E;
	Fri,  5 Sep 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrAvtl8D"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42501E7C03
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060608; cv=none; b=KrnE5Mwe74nlJBcKyr1J5TwK4PVUlTQi1HcHDNGuQq+Oip90vWFHstCOZRukMTgCj7LupA14+yR2t1Z3YAFwGNLUhRczYVpejz5/JwL8Ih24VIxc3rHtvON9gJxq3kc7wouE8Y+qRznjjMAAfYGDxmGtfaZbCdqOWWaz3aMh+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060608; c=relaxed/simple;
	bh=APGqKF3GyU/I3fMyI+XPtYWiVqEWpTDET7JPhtTGQV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wgm5fMxqdgGQrw1guoHoa1ZTcOeSE6ydzn2Fd10KgyYLRtkOmvVUkFNoanwR0kfFEcHum2zu3HUkuEHwx0JrsG2ai6hro1ntyldLmHt1i4E+m7Ge1WRkUPfR3Cf8vRoDjygILm+GvwTy2Eb+49ycSAoeC7xiEOluoQqIteWwXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrAvtl8D; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso1551558a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757060606; x=1757665406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJnhSI4zKDT3ImFhZhJBvG+6tvoITddVraqHrrqOWpc=;
        b=CrAvtl8Dvy16B69I1/8/nF3mRCSVXYcExVPjCMsr7bJSbsnblfIuWfKGs+LcJDYVj/
         kjINdr+Hyeq5iiulmbNdIDZwcbuq0oQ6/a+EOoPMKoHT6Emj+kDMou4fRBPqjZYzbqiJ
         IOrKggTDOxPtQlf8WS0gzBFSDfh9Y4Kl2v0RYEC1betj2EhhP0esTUDFj7EiltYfmqp8
         tvhAMPhMuSiJY7lD5tpON1/5qcfx01KDytZVRHhgxvifgD1c9O8y0g2EXyqqtTKhhHKI
         zlmL5Ek7FY8i6hx6qGndsrAFRcjDOeOCyjih3ZZzQG2ttL0qo7HxScZgmi+50OeqKwDi
         h5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060606; x=1757665406;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJnhSI4zKDT3ImFhZhJBvG+6tvoITddVraqHrrqOWpc=;
        b=pz3J+3bpgXOqnphBiz2NxoXmQKWyFUkCRb9WaroiM2PMl1kVYPyWDkNx45kTgkM096
         YbxX+TmjGNsG8J2dnOGk70iBiIuvX0xMPVBIbhZl1pTAxMbEJsrvXzNXQs5ABfQo+hDa
         KZIH23pmLQcchCL8e7msXJ3UBC4FrbsYUHhvVysSk5uhHUBk9m0hw0maS1gTSW13n0SD
         vd8M3BoRnprLRLr0a8o/ik8DURy9aI53ov/rR88pHKqbIJwNdWUE42dxTWEjxZZoGtza
         QT0+wXd5Gv3iPKxcoeSVw/IZnsh0iJiFiE8n9xVYJP6wAeFSUSz4mxIZEiWPHBu3nBGn
         otYA==
X-Forwarded-Encrypted: i=1; AJvYcCUi52flgApQz6T8zt2jHkcXXTXpmmKy6uOLKqYE0KQ5F5wblgB8r5o2LlGIj8BhQAEZwBEcy04m92a8nFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0C7Aq7pf5QXNA28rPQfMZGgR+dLXqGTOEK/XXxJqYCxDU/C74
	GUTIkuUZI1Tz/VDFZdNODP6dw4YReS44mWzlRwvku5Ba3RnhznspCjZE6hmdYWt9KwFVlIR0mnF
	VZeuAGg==
X-Google-Smtp-Source: AGHT+IF349552GT13Po4cUSXoxXNT8kDuTD1Q1OQDc9T2EDq42EP/PDKUPEXnt4B6nyuOStBDkTUDu8oxLg=
X-Received: from pfgu35.prod.google.com ([2002:a05:6a00:9a3:b0:772:8559:f89f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:24b:c7d9:88e4
 with SMTP id adf61e73a8af0-24bc7d99007mr7502786637.42.1757060606101; Fri, 05
 Sep 2025 01:23:26 -0700 (PDT)
Date: Fri, 5 Sep 2025 01:23:17 -0700
In-Reply-To: <CAHBxVyHFkNtFdX-vciPvYnTOH=GXvHVW7hjFrLA4MFr9wqWVvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829-pmu_event_info-v5-0-9dca26139a33@rivosinc.com>
 <20250829-pmu_event_info-v5-6-9dca26139a33@rivosinc.com> <aLIR3deQPxVI2VrE@google.com>
 <CAHBxVyHFkNtFdX-vciPvYnTOH=GXvHVW7hjFrLA4MFr9wqWVvQ@mail.gmail.com>
Message-ID: <aLqd9bKB6ucarR3e@google.com>
Subject: Re: [PATCH v5 6/9] KVM: Add a helper function to check if a gpa is in
 writable memselot
From: Sean Christopherson <seanjc@google.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2025, Atish Kumar Patra wrote:
> On Fri, Aug 29, 2025 at 1:47=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Aug 29, 2025, Atish Patra wrote:
> > > +static inline bool kvm_is_gpa_in_writable_memslot(struct kvm *kvm, g=
pa_t gpa)
> > > +{
> > > +     bool writable;
> > > +     unsigned long hva =3D gfn_to_hva_prot(kvm, gpa_to_gfn(gpa), &wr=
itable);
> > > +
> > > +     return !kvm_is_error_hva(hva) && writable;
> >
> > I don't hate this API, but I don't love it either.  Because knowing tha=
t the
> > _memslot_ is writable doesn't mean all that much.  E.g. in this usage:
> >
> >         hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &wr=
itable);
> >         if (kvm_is_error_hva(hva) || !writable)
> >                 return SBI_ERR_INVALID_ADDRESS;
> >
> >         ret =3D kvm_vcpu_write_guest(vcpu, shmem, &zero_sta, sizeof(zer=
o_sta));
> >         if (ret)
> >                 return SBI_ERR_FAILURE;
> >
> > the error code returned to the guest will be different if the memslot i=
s read-only
> > versus if the VMA is read-only (or not even mapped!).  Unless every rea=
d-only
> > memslot is explicitly communicated as such to the guest, I don't see ho=
w the guest
> > can *know* that a memslot is read-only, so returning INVALID_ADDRESS in=
 that case
> > but not when the underlying VMA isn't writable seems odd.
> >
> > It's also entirely possible the memslot could be replaced with a read-o=
nly memslot
> > after the check, or vice versa, i.e. become writable after being reject=
ed.  Is it
> > *really* a problem to return FAILURE if the guest attempts to setup ste=
al-time in
> > a read-only memslot?  I.e. why not do this and call it good?
> >
>=20
> Reposting the response as gmail converted my previous response as
> html. Sorry for the spam.
>=20
> From a functionality pov, that should be fine. However, we have
> explicit error conditions for read only memory defined in the SBI STA
> specification[1].
> Technically, we will violate the spec if we return FAILURE instead of
> INVALID_ADDRESS for read only memslot.

But KVM is already violating the spec, as kvm_vcpu_write_guest() redoes the
memslot lookup and so could encounter a read-only memslot (if it races with
a memslot update), and because the underlying memory could be read-only eve=
n if
the memslot is writable.

Why not simply return SBI_ERR_INVALID_ADDRESS on kvm_vcpu_write_guest() fai=
lure?
The only downside of that is KVM will also return SBI_ERR_INVALID_ADDRESS i=
f the
userspace mapping is completely missing, but AFAICT that doesn't seem to be=
 an
outright spec violation.

