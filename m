Return-Path: <linux-kernel+bounces-753864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43DB18933
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 00:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19687B3FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4F22A4F1;
	Fri,  1 Aug 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+symfCX"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F2190477
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087463; cv=none; b=XOPdPg+ptnAtZMhJIC2GRMgzGWDMHFF+yhfh3onrJLoPINq+sTBaep9oUb/DsZuRC5AYQforrxkuRUAJl5PtQx+pM3UgKxBZk4/cOlzjK/M2a5iw993AP154LiX01TE6CuCTTcH840pyHczr0LGN9gF+Lugk6uMIa2guhs5DmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087463; c=relaxed/simple;
	bh=VUWN2HvYTDE5n7KfPSHzEzLoNV5CiplLepGe6RosOiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/PcsjcQUoSHrI09+cEqucAOiarsmfL1D4G8La33NJX3fkBsrzd0v1iSXA4j53WN++rctXlZsFDYHtj+0Qm5rzOxkMDOBz5923XurDt5v2CuQ85hSFVgef8EH0j4dbClpaesaaiu8fm31uata5+YBNRj7KW6ItnJf7u/VK2dh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+symfCX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so2043800b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754087461; x=1754692261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObP9BGNWZvxLQ6HxStsjsTxsY0AHXigIOFm2u+VAyVY=;
        b=q+symfCXz7LPgp+4lxonH8A7ddlh8cTqqllRs3VcARZjzP2jzdQXzfZ/QnuKzXO9TB
         e9o0ElpVYVsTfdhCTPjXCamcviUjzMfFoIRbOGCPAHm9sOv+nYryweDxrlLt3OoovihC
         qlVakWzH/6gsK3RYcm1AHXqHXdxIZvcn/xCoA775J3EKv/eYG3TpzQrL1RyBWLzCJ8ZP
         Xw5O8i+fv6mULcu1EEHEk7zOp5GFacNzcYc3avUvisUw4NyzVNFxdhUofOWE82DMKoaW
         ComPBxvg6bg+kxrD075B0q5/hQr06zDsufzstHr0IVgNSp3npUGQGGaKh7/PjRk0QOT/
         cWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754087461; x=1754692261;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ObP9BGNWZvxLQ6HxStsjsTxsY0AHXigIOFm2u+VAyVY=;
        b=lTrHdhIeWSs+8hO5S/D0AgODihKCkJQY86rSILTARaKigxPW+uqt/xKnrre/6xlN5z
         OFyO3ovG1DfNIoRJqUHPlesQlOPp529ipWlUGiTrnLGEGZjFsqVCNzukA8o93GRclxOu
         Cs4ls8B3Cym043NvCvtgcvK86zKMis0k/xysV7XV9uzfESSjTsM/KNAHDdg1Tv8AFBn9
         1tbTyd9B36yIx7/Haskpn7nOUaYR2BhtPw2KEcd1yQyKaL1BHlH01Zoz4bxQeiYStE/k
         Y+608RC644pn9nbh1nT1tGHVxgwwJeD/MjONVEdOcIIpSESytrtkPR5w0QtwO/x5N4Gb
         NPPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNV5+A1QHPzxQGQK/65z//s5ph+PWQP2GG4huiq2j6XLlN/xfzgEgtGkLxUzbfvwgOuGFWiS7mOZosRFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGs9GRAroyMpG3BVMCcgZIrFXxkBEGsuUqnBVOM8umHnnpXzFK
	Zpva1SLCygCXtPybKB6gYL0EczqkRnCRmvozr0NaGlo0woIl/3xwpuuEVxyr8wN3WKvVb3jq6d4
	BvWMhlA==
X-Google-Smtp-Source: AGHT+IGlAO66sYjmGILxs+TyefTRU7rCccw4osRvGV9Y9Sgrh7mcvbHJzmWeUGthNTznQE0b7DTa5lqn278=
X-Received: from pfbkq6.prod.google.com ([2002:a05:6a00:4b06:b0:76b:c82b:5c91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b52:b0:730:9946:5973
 with SMTP id d2e1a72fcca58-76bec2f2fdbmr1220644b3a.5.1754087461086; Fri, 01
 Aug 2025 15:31:01 -0700 (PDT)
Date: Fri, 1 Aug 2025 15:30:59 -0700
In-Reply-To: <CADrL8HX11ee3R9HXexk3PbhFRKoOPfW6_=c+OOcaWE=0WJ7K4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-8-jthoughton@google.com> <aIFOV4ydqsyDH72G@google.com>
 <CADrL8HVJrHrb3AJV5wYtL9x0XHx+-bNFreO4-OyztFOrupE5eg@mail.gmail.com>
 <aIzLBWqImtgtztOH@google.com> <CADrL8HX11ee3R9HXexk3PbhFRKoOPfW6_=c+OOcaWE=0WJ7K4g@mail.gmail.com>
Message-ID: <aI1AI3yYTYsb5Ihn@google.com>
Subject: Re: [PATCH v5 7/7] KVM: selftests: Add an NX huge pages jitter test
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025, James Houghton wrote:
> On Fri, Aug 1, 2025 at 7:11=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Mon, Jul 28, 2025, James Houghton wrote:
> > > On Wed, Jul 23, 2025 at 2:04=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > > On Mon, Jul 07, 2025, James Houghton wrote:
> > > > Right, but we also don't want to wait for the initial fault-in eith=
er, no?  I.e.
> > > > plumbing in MAP_POPULATE only fixes the worst of the delay, and may=
be only with
> > > > the TDP MMU enabled.
> > > >
> > > > In other words, it seems like we need a helper (option?) to excplit=
ly "prefault",
> > > > all memory from within the guest, not the ability to specify MAP_PO=
PULATE.
> > >
> > > I don't want the EPT to be populated.
> > >
> > > In the event of a hugepage being executed, consider another memory
> > > access. The access can either (1) be in the executed-from hugepage or
> > > (2) be somewhere else.
> > >
> > > For (1), the optimization in this series doesn't help; we will often
> > > be stuck behind the hugepage either being destroyed or reconstructed.
> > >
> > > For (2), the optimization in this series is an improvement, and that'=
s
> > > what this test is trying to demonstrate. But this is only true if the
> > > EPT does not have a valid mapping for the GPA we tried to use. If it
> > > does, the access will just proceed like normal.
> > >
> > > This test only times these "case 2" accesses. Now if we didn't have
> > > MAP_POPULATE, then (non-fast) GUP time appears in these results, whic=
h
> > > (IIRC) adds so much noise that the improvement is difficult to
> > > ascertain. But with MAP_POPULATE, the difference is very clear.
> >
> > Oh, right, the whole point is to measure fault-in performance.
> >
> > In that case, rather than MAP_POPULATE, can we do the slightly more sta=
ndard (for
> > VMMs) thing of writing (or reading) memory from host userspace?  I don'=
t think it's
> > worth plumbing in extra_mmap_flags just for MAP_POPULATE, in no small p=
art because
> > MAP_POPULATE is effectively best effort, and doesn't work for VM_PFNMAP=
 (or VM_IO).
> >
> > Those quirks shouldn't matter for this case, and _probably_ won't ever =
matter for
> > any KVM selftest, but it's enough to make me think MAP_POPULATE is a pa=
ttern we
> > don't want to encourage.
>=20
> What if vm_mem_add() just returned the VA of the added region, and
> then the test could call mlock() on it?=20

I like it!

