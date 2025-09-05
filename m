Return-Path: <linux-kernel+bounces-802876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2CB457C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB4D1B28103
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E6350851;
	Fri,  5 Sep 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vS2zVpqr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC634F481
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075236; cv=none; b=Bk4pdawaBB+rJ1k8fuWIFFkpg2BYc24MZcMCgm9cDBnkEBhUcjh+vasWRXlgDU/hBQeWKa5fPFOr9Xk+232wQtuZN+AcRXlndMqNAxO/pj4lWaXERAxjpdqOFvnADFPZZe9/h2MvYo7axY8wyBUgt6WygypyLpim9Qgdnzz3haI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075236; c=relaxed/simple;
	bh=wKevWlaDVATFTRv5UskfQdVzbKDKhm6MQDY8OOEDKcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lOQTYjEEiz8u5nJPB/7i2+dQRfgG8iSzZOeRNE5SZWso1jgYYHoPBzOVOh6z1ZF8JxGm6DKdXQDy6pMGgPlzb7H1sUAtXmPq33YCLxWDDTqD9eU8r6DXsHD0xQmJDMDwlKL4Rw9X9q0PB5RSvefJozCbHz2ZEif3MPc26BnV7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vS2zVpqr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329745d6b89so3605121a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757075234; x=1757680034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEtLYmY8JOalgrgOv2U5MLx2Oeht0cmwE/ZJBlYZqa4=;
        b=vS2zVpqrNA9WXt54rw/5e0ikn+wXouXWw0swu0yaAW++fKTuEebFbROzIqtUI/47Ng
         LxnF8SZ/u6a6rbYH8wIEBk8mYB/VOP6IjI+s3tVpZKyXmaWv/NWCVlJOsqT8PodzdzWp
         NC6OCWSJXVnxBZkCx/Papjo/s2mWaQxhfmjjC7KTyeKfYhwaRaUJzSRKI6uLMojGYmC1
         ML5idKOjYFynRXc16jgu0EuLeiaWQ5PmxlVE1jNg3OrLOFmKwLx/cb+G7EOGvqFa73I8
         SLCxl/Zuq2lBmfscg/04Aw3aY5QDdZPqFRVgrNdq/9c8h4v1OjMYld/FHNKV/uZCwklW
         BJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075234; x=1757680034;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEtLYmY8JOalgrgOv2U5MLx2Oeht0cmwE/ZJBlYZqa4=;
        b=XxlSHu1TTAZ4/tb7BHpyzBiTrEOmrgMSaSwjP2mxQxuA46/+FNOU/GqhhXcG0Xxqad
         zXfTqXslqSucj2arOkA5Y157c0wwwYU3KKq0GgEXIThiJ2Xxu6mBEcB5ssU0C/AyqCcz
         +YBHZSZqpC2RblLR7JI2uuURSKh5K0Lnd1oQOjsvPJ+u1jqXZuDc3XC10VCMfPWkWdlX
         mQsPh4SkhYvGHCIS73MqZMi8qjHAm8MMAS8V3Xxk3VvtJIGq32WdmNm+xdZ1Aed8l74B
         hTlBuhxg4Hhldra5G/13xBf2Hg1nsmA9ysXMFozQTKa2117/i8tBYEUPaayoePBIuxKm
         eDAg==
X-Forwarded-Encrypted: i=1; AJvYcCWlJx+NERvj6mh+Y0XTvZmXP0Q78W86ndUL14R/45HqU99ZGNooPyv9coFNgRIiFU/kGMf4YMhawNieVrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+f6cbwGfAEgDSbU6BQv172EuUBdzeAUZlFkwbTsSOwtkd7EHx
	ulVAStgqy0mB3YUElqmJWQ9qzBor1Hq8HbXc9tnF6Jzl9HvPyZzA8wmBJWXz7GJMqnzHeZRjzga
	vZ3lwfg==
X-Google-Smtp-Source: AGHT+IGL6U3Es4ziofS/w8+rJpx7HwQEqsdYgzJc5tlMCihXPtFAaEH2AeP3MpoxcgsR8e9ya+5ty4Rf6kk=
X-Received: from pjbmf13.prod.google.com ([2002:a17:90b:184d:b0:32b:35fb:187f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8b:b0:32b:b26e:1569
 with SMTP id 98e67ed59e1d1-32bb26e2965mr6479994a91.15.1757075233964; Fri, 05
 Sep 2025 05:27:13 -0700 (PDT)
Date: Fri, 5 Sep 2025 05:27:01 -0700
In-Reply-To: <CADrL8HVxvwB4JrnUf6QtDCyzZojEvR4tr-ELEn+fL8=1cnbMQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618042424.330664-1-jthoughton@google.com>
 <de7da4d8-0e9d-46f2-88ec-cfd5dc14421c@amazon.com> <CADrL8HVxvwB4JrnUf6QtDCyzZojEvR4tr-ELEn+fL8=1cnbMQQ@mail.gmail.com>
Message-ID: <aLrXFWDgDkHqPQda@google.com>
Subject: Re: [PATCH v3 00/15] KVM: Introduce KVM Userfault
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: kalyazin@amazon.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>, Anish Moorthy <amoorthy@google.com>, 
	Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025, James Houghton wrote:
> On Thu, Sep 4, 2025 at 9:43=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.c=
om> wrote:
> > Are there any blockers for merging this series?  We would like to use
> > the functionality in Firecracker for restoring guest_memfd-backed VMs
> > from snapshots via UFFD [1].  [2] is a Firecracker feature branch that
> > builds on top of KVM userfault, along with direct map removal [3], writ=
e
> > syscall [4] and UFFD support [5] in guest_memfd (currently in discussio=
n
> > with MM at [6]) series.
>=20
> Glad to hear that you need this series. :)

Likewise (though I had slightly-advanced warning from Patrick that Firecrac=
ker
wants KVM Userfault).  The main reason I haven't pushed harder on this seri=
es is
that I didn't think anyone wanted to use it within the next ~year.

> I am on the hook to get some QEMU patches to demonstrate that KVM
> Userfault can work well with it. I'll try to get that done ASAP now
> that you've expressed interest. The firecracker patches are a nice
> demonstration that this could work too... (I wish the VMM I work on
> was open-source).
>=20
> I think the current "blocker" is the kvm_page_fault stuff[*]; KVM
> Userfault will be the first user of this API. I'll review that series
> in the next few days. I'm pretty sure Sean doesn't have any conceptual
> issues with KVM Userfault as implemented in this series.

Yep, Oliver and I (and anyone else that has an opinion) just need to align =
on the
interface for arch-neutral code.  I think that's mostly on me to spin a v2,=
 and
maybe to show how it all looks when integrated with the userfault stuff.

