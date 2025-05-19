Return-Path: <linux-kernel+bounces-654201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF14ABC535
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A58B1B62CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73908288C0E;
	Mon, 19 May 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdAImZ6J"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264A288521
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674386; cv=none; b=bWl3lJGWaN30BMVCSkhOFnMBmiZmicW5jHfzr+63WdBIDlEkJRDpczf/cyU5XRNEEWkt48+uLNRlA3vT9CnS1QzulI4NaS14bW1N5ikxxJvz6QpPMxqGAWsCysGfAXKDSytjbrMF8yV3Orp+iSj186oFpBijEQ/L7H3FMX6x3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674386; c=relaxed/simple;
	bh=rPtEnueZu1fQ1Z+0L4jzWuZxgdvWIZWOxFaQr0QuS9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QI/jEcQafHqwOr8eHj6PF2iC+awTl/qpLcnh9lI522umw6U+CaRsqVhT7szjrbQLy//2YIN+SvF5BI+K2vZDxfTUM7+2bn0bvIzvGrw7oiRPOcgR9Yx105mJ1GjQprSnRZL3Sw8bQpK0cejZY3MjieQfur2SmoPtYkNQ1JqR5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdAImZ6J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9b2e7a34so2010975a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747674384; x=1748279184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CSC+HCWpqN6SsYs8tw1wIkbTL0pH3vw2ecb/zV3Ilw=;
        b=IdAImZ6JSofA3wvLclsmFTxQOmlq1xLR1jnQRsKjMAjIyHKKI3lXX/EBGuoCe1ZYOB
         m5pFIHf/WKwQ1pY59hO4lIk3T/fVho07N6l/uB7VFzOhWz92iesvPPN58wmvS5vDuZJX
         iNFWKOwGmqQZr/Mc6AGECIhcIZy3WbePlO+9wwRhmC5eFOu8FiKpOjvnOjMblth/NQfi
         raDGlEz+o+aBBBmyzfRlyrv7+rr5ErD0ZOI6rI9lY5G6a5qM2p2wn+rUYw2gdfmo32FP
         f8ONMxqDXquKLBtb1eYcn96Yyw+VBfNGQTlhaoMf6wTzFlZWclrJsvW9bIfMpqs1zZIs
         okFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674384; x=1748279184;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CSC+HCWpqN6SsYs8tw1wIkbTL0pH3vw2ecb/zV3Ilw=;
        b=pYMfH5NrZXawrf1qVF7H/n0km2OrlEUDCsM+Piay5o97qQ2Mm6Dv4s+/oL8I8SVBTq
         cCOvFqKGnhTuweNOjpGg+hRYFfunsp0A2a1atqsbNf1gbNhepOnGCiL3stipyvsnbudC
         0QYP8CvLT+N4LoON6p06KVPaphVcm8kLwoMuPy83V82sl0hfzufj9E4bjM5lgS3N4Frb
         cLrDmpDASxNR+ZmyrgbqCgleQBjMiBuC7E7eJofskZlkniK2DaTqz336USGFHY+jsPcQ
         NQ+oaA5Y770gHRJeP0HQ3jKJ4UGIM8ybizreE28VOaqOj46bIIUzFt8anzGiigRMncYm
         b7nw==
X-Forwarded-Encrypted: i=1; AJvYcCVqdLrRN7/rkBv7RFmHdFrGqrxYauaFcq5ObB9zGJz335xhk/YSk2ZojdnTov1aqzInxpszevHrG9Im4Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+h6h03s+sMVIO7wA17htRykc2DTPTivMs5pbjHjWmjUnWz9dB
	G3pWBCTHIVQGc1WA5rjhdiNga5owkdYrP9rBydAVcE1LWhIRJRilVLY1nTPyE9t8ZztThGvS2g4
	j+gCiJA==
X-Google-Smtp-Source: AGHT+IErhOyhbUJocygbMiLfwF85LDGz9gDIuF1ttLyAMZsqm1b+6hEX7SsSUvup2vSy2R5Hda75UX7lY/4=
X-Received: from pjk3.prod.google.com ([2002:a17:90b:5583:b0:30a:4874:5389])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5105:b0:2ff:62f8:9a12
 with SMTP id 98e67ed59e1d1-30e7d5b763emr19408120a91.23.1747674384237; Mon, 19
 May 2025 10:06:24 -0700 (PDT)
Date: Mon, 19 May 2025 10:06:22 -0700
In-Reply-To: <52bdeeec0dfbb74f90d656dbd93dc9c7bb30e84f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023613.30329-1-yan.y.zhao@intel.com> <20250519023737.30360-1-yan.y.zhao@intel.com>
 <aCsy-m_esVjy8Pey@google.com> <52bdeeec0dfbb74f90d656dbd93dc9c7bb30e84f.camel@intel.com>
Message-ID: <aCtlDhNbgXKg4s5t@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Add RET_PF_RETRY_INVALID_SLOT for fault
 retry on invalid slot
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025, Rick P Edgecombe wrote:
> On Mon, 2025-05-19 at 06:33 -0700, Sean Christopherson wrote:
> > Was this hit by a real VMM?=C2=A0 If so, why is a TDX VMM removing a me=
mslot without
> > kicking vCPUs out of KVM?
> >=20
> > Regardless, I would prefer not to add a new RET_PF_* flag for this.=C2=
=A0 At a glance,
> > KVM can simply drop and reacquire SRCU in the relevant paths.
>=20
> During the initial debugging and kicking around stage, this is the first
> direction we looked. But kvm_gmem_populate() doesn't have scru locked, so=
 then
> kvm_tdp_map_page() tries to unlock without it being held. (although that =
version
> didn't check r =3D=3D RET_PF_RETRY like you had). Yan had the following c=
oncerns and
> came up with the version in this series, which we held review on for the =
list:

Ah, I missed the kvm_gmem_populate() =3D> kvm_tdp_map_page() chain.

> > However, upon further consideration, I am reluctant to implement this f=
ix for

Which fix?

> > the following reasons:
> > - kvm_gmem_populate() already holds the kvm->slots_lock.
> > - While retrying with srcu unlock and lock can workaround the
> >   KVM_MEMSLOT_INVALID deadlock, it results in each kvm_vcpu_pre_fault_m=
emory()
> >   and tdx_handle_ept_violation() faulting with different memslot layout=
s.

This behavior has existed since pretty much the beginning of KVM time.  TDX=
 is the
oddball that doesn't re-enter the guest.  All other flavors re-enter the gu=
est on
RET_PF_RETRY, which means dropping and reacquiring SRCU.  Which is why I do=
n't like
RET_PF_RETRY_INVALID_SLOT; it's simply handling the case we know about.

Arguably, _TDX_ is buggy by not providing this behavior.

> I'm not sure why the second one is really a problem. For the first one I =
think
> that path could just take the scru lock in the proper order with kvm-
> >slots_lock?

Acquiring SRCU inside slots_lock should be fine.  The reserve order would b=
e
problematic, as KVM synchronizes SRCU while holding slots_lock.

That said, I don't love the idea of grabbing SRCU, because it's so obviousl=
y a
hack.  What about something like this?

---
 arch/x86/kvm/mmu.h     |  2 ++
 arch/x86/kvm/mmu/mmu.c | 49 +++++++++++++++++++++++++++---------------
 arch/x86/kvm/vmx/tdx.c |  7 ++++--
 virt/kvm/kvm_main.c    |  5 ++---
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b4b6860ab971..0fc68f0fe80e 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -259,6 +259,8 @@ extern bool tdp_mmu_enabled;
=20
 bool kvm_tdp_mmu_gpa_is_mapped(struct kvm_vcpu *vcpu, u64 gpa);
 int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 =
*level);
+int kvm_tdp_prefault_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code=
,
+			  u8 *level);
=20
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cbc84c6abc2e..4f16fe95173c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4851,24 +4851,15 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t g=
pa, u64 error_code, u8 *level
 {
 	int r;
=20
-	/*
-	 * Restrict to TDP page fault, since that's the only case where the MMU
-	 * is indexed by GPA.
-	 */
-	if (vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fault)
-		return -EOPNOTSUPP;
+	if (signal_pending(current))
+		return -EINTR;
=20
-	do {
-		if (signal_pending(current))
-			return -EINTR;
+	if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+		return -EIO;
=20
-		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
-			return -EIO;
-
-		cond_resched();
-		r =3D kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
-	} while (r =3D=3D RET_PF_RETRY);
+	cond_resched();
=20
+	r =3D kvm_mmu_do_page_fault(vcpu, gpa, error_code, true, NULL, level);
 	if (r < 0)
 		return r;
=20
@@ -4878,10 +4869,12 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t g=
pa, u64 error_code, u8 *level
 	case RET_PF_WRITE_PROTECTED:
 		return 0;
=20
+	case RET_PF_RETRY:
+		return -EAGAIN;
+
 	case RET_PF_EMULATE:
 		return -ENOENT;
=20
-	case RET_PF_RETRY:
 	case RET_PF_CONTINUE:
 	case RET_PF_INVALID:
 	default:
@@ -4891,6 +4884,28 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gp=
a, u64 error_code, u8 *level
 }
 EXPORT_SYMBOL_GPL(kvm_tdp_map_page);
=20
+int kvm_tdp_prefault_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code=
, u8 *level)
+{
+	int r;
+
+	/*
+	 * Restrict to TDP page fault, since that's the only case where the MMU
+	 * is indexed by GPA.
+	 */
+	if (vcpu->arch.mmu->page_fault !=3D kvm_tdp_page_fault)
+		return -EOPNOTSUPP;
+
+	for (;;) {
+		r =3D kvm_tdp_map_page(vcpu, gpa, error_code, level);
+		if (r !=3D -EAGAIN)
+			break;
+
+		/* Comment goes here. */
+		kvm_vcpu_srcu_read_unlock(vcpu);
+		kvm_vcpu_srcu_read_lock(vcpu);
+	}
+}
+
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range)
 {
@@ -4918,7 +4933,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *=
vcpu,
 	 * Shadow paging uses GVA for kvm page fault, so restrict to
 	 * two-dimensional paging.
 	 */
-	r =3D kvm_tdp_map_page(vcpu, range->gpa, error_code, &level);
+	r =3D kvm_tdp_prefault_page(vcpu, range->gpa, error_code, &level);
 	if (r < 0)
 		return r;
=20
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b952bc673271..1a232562080d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3075,8 +3075,11 @@ static int tdx_gmem_post_populate(struct kvm *kvm, g=
fn_t gfn, kvm_pfn_t pfn,
 	if (ret !=3D 1)
 		return -ENOMEM;
=20
-	ret =3D kvm_tdp_map_page(vcpu, gpa, error_code, &level);
-	if (ret < 0)
+	do {
+		ret =3D kvm_tdp_map_page(vcpu, gpa, error_code, &level);
+	while (ret =3D=3D -EAGAIN);
+
+	if (ret)
 		goto out;
=20
 	/*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b24db92e98f3..21a3fa7476dd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4266,7 +4266,6 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcp=
u *vcpu)
 static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				     struct kvm_pre_fault_memory *range)
 {
-	int idx;
 	long r;
 	u64 full_size;
=20
@@ -4279,7 +4278,7 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu =
*vcpu,
 		return -EINVAL;
=20
 	vcpu_load(vcpu);
-	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
+	kvm_vcpu_srcu_read_lock(vcpu);
=20
 	full_size =3D range->size;
 	do {
@@ -4300,7 +4299,7 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu =
*vcpu,
 		cond_resched();
 	} while (range->size);
=20
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	kvm_vcpu_srcu_read_unlock(vcpu);
 	vcpu_put(vcpu);
=20
 	/* Return success if at least one page was mapped successfully.  */

base-commit: 12ca5c63556bbfcd77fe890fcdd1cd1adfb31fdd
--

