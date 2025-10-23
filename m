Return-Path: <linux-kernel+bounces-867467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F5C02B91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49DB24E2EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C149347BD9;
	Thu, 23 Oct 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYbIdCoB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E9347BBD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240439; cv=none; b=W5X3HxGvd0g1nEuDpwBAKfUIFsZrIamv4vzxVUfHuS+O2Z3hiq75hzCNAp4/37thjP3x52uPDqifbea5toAk2WaVroabGGeEAjIRMeEU+Zxpc751Ljv7ZTCq3ieWh6fwtfEYqi/9X0xVuSjn009FREoiVEkNjVqKZ6hwZsDcpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240439; c=relaxed/simple;
	bh=XVDzXI4Y1e4iRpQIyW9vAwBiWIuzXTa0TJZpBTTKBPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KFP+Nl/BRYsBTVU+S4OtUaZBfXWK3rhQ8JKPdeGEeL/UbCaP/1Ylmyq3geXziAb5WG96QZ7eGb5f/sQuGsEeVR9/uqhqRcsg4hozjHTVzdtrmEjPN6YZxjI6VxlME4teUyPPgEImKjoa0VZEqjqXyx5G1k2Ud0iUDybN78aWzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYbIdCoB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6fbaso13278995ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761240437; x=1761845237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMd4YohbYBDUY30TTRBHmO9DyPvx8MjhdR/tVFXtYYI=;
        b=oYbIdCoBvuoC0xoZz8Vf64f/MMaTw1kYJUtRLeTOGUnKQytAs8zrLYMyqAcKQY1C1y
         SDURXm8iJER0VyEqb+TpW8ZVe/yc6GFygCVT18Veb0vpkM6TjjEtIH0KiKT7j0ZhPmFY
         JM0j1A5l9nwgDn1Y5wIkyrWb++aO5KPbSiFSUKqb9FiFJZDkTmSem7ufqGMTrsLpv5S1
         /vRuK3uik4CeoSwZ9VQkLd2a75SG0Pdp2Ek1mt9C3sO7fjGen6bOdwW2lw1K1/wgJH9Y
         vb2lm4GEudDdMU26+vX+oMtkwG52wc+A246E9lpwCk8oixKTr2+g9Yf2lwFS2PezeEXA
         kN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240437; x=1761845237;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMd4YohbYBDUY30TTRBHmO9DyPvx8MjhdR/tVFXtYYI=;
        b=sx7KZjUxaeE5ez1/y1AK3Ntw4I+cZswex3rWV3KJ7QnF0MiMvbrjEXKF6mGXAlAMUZ
         OtmTSVbXsNbx5d438OT+AQPhyDRk2yTlYASBqrqPyYnmGvGXiA+5pISxAc+RAok9oH0b
         3is2AQ0dLqVypVSti7UwxU2o6K2bbkbC5rnBynxRnRE6uSCAty8x4ojlaXLHqYG7IdRf
         37x4bg/NiV0eVOYRvgoe34mlcTP9hhY932SuRwpwJchnu9aVTmhFGHQTQXsJvSMKHwA0
         o61Hf5HFLGc8gTf20fg3MIsfwt9n7F7/L0vvmtu3jmLMCeenBkt305nMZ14kxLb9Mtnf
         W0NA==
X-Forwarded-Encrypted: i=1; AJvYcCW/sGLM2ect3kSNVGW+oveIYdC8OQiPpsqKEKdOQsCkAsI5x8CWjV1OsSdv8KdZobl1q406UnYpSY6baeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOCyojlGnNowiuF3fZ+QU+HutVmdVIIEvAifp/h/TrvFEVrMt
	uXwTUtIi/yEiniZDON/JXKuoPCclJZWnKpK7/HjQMMJMa8GyzVJnMgF0k95q8QaS50vGhV0iJKE
	g9mqJzw==
X-Google-Smtp-Source: AGHT+IFjhG//1khxmFCKdE4+6wWu9+6PA/jOl4XyR0eCgR53v+ZECkEt8twGk0B4jVNQwQCsevpreYrKXxc=
X-Received: from pjuj5.prod.google.com ([2002:a17:90a:d005:b0:33b:a35b:861])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db11:b0:240:48f4:40f7
 with SMTP id d9443c01a7336-290cba4efc9mr387536115ad.39.1761240437319; Thu, 23
 Oct 2025 10:27:17 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:27:16 -0700
In-Reply-To: <707a01ee36c28863bdc6a4444a5560e9a0b19597.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017003244.186495-1-seanjc@google.com> <20251017003244.186495-15-seanjc@google.com>
 <707a01ee36c28863bdc6a4444a5560e9a0b19597.camel@intel.com>
Message-ID: <aPpldKdiQYYnl4uC@google.com>
Subject: Re: [PATCH v3 14/25] KVM: TDX: Bug the VM if extended the initial
 measurement fails
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"kas@kernel.org" <kas@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>, 
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, 
	"zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>, "anup@brainfault.org" <anup@brainfault.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-10-16 at 17:32 -0700, Sean Christopherson wrote:
> > WARN and terminate the VM if TDH_MR_EXTEND fails, as extending the
> > measurement should fail if and only if there is a KVM bug, or if the S-=
EPT
> > mapping is invalid, and it should be impossible for the S-EPT mappings =
to
> > be removed between kvm_tdp_mmu_map_private_pfn() and tdh_mr_extend().
> >=20
> > Holding slots_lock prevents zaps due to memslot updates,
> > filemap_invalidate_lock() prevents zaps due to guest_memfd PUNCH_HOLE,
> > and all usage of kvm_zap_gfn_range() is mutually exclusive with S-EPT
> > entries that can be used for the initial image.=C2=A0 The call from sev=
.c is
> > obviously mutually exclusive, TDX disallows KVM_X86_QUIRK_IGNORE_GUEST_=
PAT
> > so same goes for kvm_noncoherent_dma_assignment_start_or_stop, and whil=
e
> > __kvm_set_or_clear_apicv_inhibit() can likely be tripped while building=
 the
> > image, the APIC page has its own non-guest_memfd memslot and so can't b=
e
> > used for the initial image, which means that too is mutually exclusive.
> >=20
> > Opportunistically switch to "goto" to jump around the measurement code,
> > partly to make it clear that KVM needs to bail entirely if extending th=
e
> > measurement fails, partly in anticipation of reworking how and when
> > TDH_MEM_PAGE_ADD is done.
> >=20
> > Fixes: d789fa6efac9 ("KVM: TDX: Handle vCPU dissociation")
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
>=20
> Per the discussion in v2, shouldn't it go after patch 24 'KVM: TDX: Guard=
 VM
> state transitions with "all" the locks'? Otherwise it introduces a KVM_BU=
G_ON()
> that can be triggered from userspace. not a huge deal though.

Oh, right.  And then the changelog needs to be updated too.

