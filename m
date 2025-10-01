Return-Path: <linux-kernel+bounces-839053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39111BB0B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CA4177EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0F25487C;
	Wed,  1 Oct 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGw3iwTK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480D1547EE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329245; cv=none; b=GlZktYrPmiBOA26c84ZPchOYawj/uAq6qeGJGc7Y40jKmkK7EqJXl8+VZP+EsWigVTIBw2b6EwXiF5bvRVE9CFDx7LYKt8S7zC0GFp7PnQv1oqRov2XS76ffYvFfr95QWoyJg6ZXG/Bk7+z/qB5FiMdl5hTiy2+TMl9HvUHuls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329245; c=relaxed/simple;
	bh=lzO+uzIHmPeyolszS9MPHAlX74KFD9pfJL5QmKl+GoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGTPs2vMcsz2ckuHEVrj0c2eEq89B1M2smpFjwAtH3ptSr9NV3GccJjW2TN0c+qyrcf1irrxqCnFLq9LrDV2A5oCM7ZHw86EPX5BH0aEMBHFk+tVd6c0820tgkCOQavYDgr990KKXjlDW+5u7fRA2Fq6ulDyJj9mv46mudDgFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGw3iwTK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d67abd215so227405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759329243; x=1759934043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YakcHEVTGq2IcLc0TeWbio4V719Lk392vundEy8wJyI=;
        b=QGw3iwTKTLIOMoalK1mZ+K9cm0Ql1JFHSQgaYbLwxKk9nEeEc4fG+/OGxYFxuaBrgr
         aG66cK5Qc5ex3UYPGhI6XsEJvpn9nr2cr8lTdaowqhsvJEE4ltLrHD4UVf24Q9DCEzdU
         /BjHqx7Ri2WxVUPWBkXIiOKwFlUIs9xAo2sIbC1JpYAIGVheAghxn1ufrxx3bQRimuVN
         sFuP2BxM6ispMrYiYYmo/f62sW5wYRxPwy3uDM9cnCQ5DBg6oPiYcFjBEwdJwzVKIitg
         ttEO+X8ySuRBTsCz+Nqw0OZrljDPxuOK/E9Ixtrk3e/zj0zUfkrYoKNmE1VczW2VzaA6
         9Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329243; x=1759934043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YakcHEVTGq2IcLc0TeWbio4V719Lk392vundEy8wJyI=;
        b=Ggfg416akXoIzCMqnCLoD9Xyp4ynZBQXKANNapUdHFxAMrmBlYsmvcHnKycY1SJGws
         79VLDrqioeB3NOGJN/jP+UXwYhSKwLi468H1skmY+vqEBcW+AFNH02h2G7Q6lMdKlwjQ
         5gn57hXnsu6Dll/Zlsu9mMNKRVhbL5kb5XwChhCNFAYQE3VqvwOcnEMqAvjNUB/txHNX
         Ry03VV969/fAQNT9cVtUVM234iQAhzI1vKXYWlvfWvsFmq5Z8lPhj+mRr9ydNHCeBnNJ
         30Ly68IAxoNjb+uMFHENGC7ROihvW41q2oA+paWs0hEGb60TyxJ8/9kFMWJjZ1aL2FcD
         Pucg==
X-Forwarded-Encrypted: i=1; AJvYcCUTe1RESJlGdYZLY6sRb5jU02GWhHEtLiBDQ9+uz35l586PCqS935BfuYl//2RTQWZqPiuxSGCXtSzNOTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2+EP+hMoTxiKNzEW1p3WX6kH2fpECULhOWRxOLXbodQjYNPT
	qY3XgE/TyscXJic5fCXWhEcOIkHEVWQCMqhbK/2pui26Ex0KNW71wYLxZeYmDwpwEWXhbWgBR6p
	EX9yNT2f/oTh/0ahJHNxRqotQewvqrISikJe7jWVs
X-Gm-Gg: ASbGncuVgj1BvX0WRquqsrUjTO1OxE/jPKtjpU+A+iP+9k5GcURlWcGLBtnE+ewofJa
	o+5LMk4dXgUyysOOsBkqcJ/Pxxs8RH5+t+OCa1fuLGLDoF9y+jyrHttJBBrtjBUN7wTUrkjIS3R
	9gBrFY6Wqvc07EF7os2Tgb7rNgzkYw/bCrpssRT9BCDXMLAvtrHcdjR1dREfmQLJ0zYpt7g/LIl
	FE2kKjHOKtwnx9g0KWlJYb8oED+zthCh2qigHssJ1I1MfbD0/xM2FFN0Gj7wETxv/hizPM=
X-Google-Smtp-Source: AGHT+IEcZ0QxEZyX/+eRrevKbme4sMONzVwGE1+JZ6/Kk+4dmhH2QsBi/Hx53NbWRtg6nJMImE5VXYIt4ZNYQVLOaD8=
X-Received: by 2002:a17:903:19e6:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-28e7fdd9d85mr4532255ad.4.1759329243082; Wed, 01 Oct 2025
 07:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com>
 <aNxqYMqtBKll-TgV@google.com>
In-Reply-To: <aNxqYMqtBKll-TgV@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 1 Oct 2025 07:33:48 -0700
X-Gm-Features: AS18NWDq-lmC-95Rb2AKRRmqNbI7VM1OPfV3LS5-mBc-a7aEICWR5gMtQnvUsAM
Message-ID: <CAGtprH9sU7bA=Cb11vdy=bELXEmx6JA9H5goJUjPzvgC2URxAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/51] KVM: guest_memfd: Introduce and use
 shareability to guard faulting
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Fuad Tabba <tabba@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> > +};
> > +
> > +enum shareability {
> > +     SHAREABILITY_GUEST =3D 1, /* Only the guest can map (fault) folio=
s in this range. */
> > +     SHAREABILITY_ALL =3D 2,   /* Both guest and host can fault folios=
 in this range. */
> > +};
>
> Rather than define new values and new KVM uAPI, I think we should instead=
 simply
> support KVM_SET_MEMORY_ATTRIBUTES.  We'll probably need a new CAP, as I'm=
 not sure
> supporting KVM_CHECK_EXTENSION+KVM_CAP_MEMORY_ATTRIBUTES on a gmem fd wou=
ld be a
> good idea (e.g. trying to do KVM_CAP_GUEST_MEMFD_FLAGS on a gmem fd doesn=
't work
> because the whole point is to get flags _before_ creating the gmem instan=
ce).  But
> adding e.g. KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES is easy enough.
>
> But for specifying PRIVATE vs. SHARED, I don't see any reason to define n=
ew uAPI.
> I also don't want an entirely new set of terms in KVM to describe the sam=
e things.
> PRIVATE and SHARED are far from perfect, but they're better than https://=
xkcd.com/927.
> And if we ever want to let userspace restrict RWX protections in gmem, we=
'll have
> a ready-made way to do so.
>

I don't understand why we need to reuse KVM_SET_MEMORY_ATTRIBUTES. It
anyways is a new ABI as it's on a guest_memfd FD instead of KVM FD.

RWX protections seem to be pagetable configuration rather than
guest_memfd properties. Can mmap flags + kvm userfaultfd help enforce
RWX protections?

