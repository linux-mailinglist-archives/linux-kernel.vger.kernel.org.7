Return-Path: <linux-kernel+bounces-721759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC0AFCD82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FA01C20B33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945A2E0922;
	Tue,  8 Jul 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0YIVrUS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1572DEA98
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984651; cv=none; b=agT8dLTuNcZYFUKNGiMo+d2qZK6MprAhxvTrOJYOvyE+LbGe+7Rwlj4zxo76TLr+zCi9rvsgUBqcrbnOM2lkAAX2SMj7oAbod+9ceOmIu8QnzQxWILXLkY1+c9nIdFm8FOlGfPevrFv+XRh7c2u5aRxTRMjkvEd2wDkELSAu48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984651; c=relaxed/simple;
	bh=/kZqCbhqYh5YCXTxk+fK0iWg1EAtPt/kehn1Ec6GM3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NtCoC9viBfqnR2I3zTLabrvVsYN0UbiDgf7cXydi/K8IJiexY1eLXVttoFAGSrOHx1rfjRJAKCJcnZ6ml3U968Z5x/iQlK5fuun/YoMCQ5Izy30VaQ2a95hed5RTJpzQhwZPGp5LApZre7daGKAgSZZ0zC7nwsqg7IW5knojFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0YIVrUS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235eefe6a8fso30548755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751984649; x=1752589449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F91em5bdhzH0evEHfCzXh2OqMZgsdjbMrBY86+xRXLE=;
        b=c0YIVrUS3xRal5UIPJXKtD2qNRePESEk4haQG42HX3/EIR0G9d1uU/itu9kWWiTd6C
         4Hp+8wMZ+dpXDlO155fnGuZYFBEH1L4Qw1wTIgL9hlkfF5DBfj/M/YGtMVQB6UWw4sTy
         F4EYbgAvP+o/5Nsrw2iIeLBuMAwrVmKoKNlUoYP9/mOdtPCQUbRlieG4t8AMDJvjgeyb
         daR+D2gRtQQlFMPETJIoT047IlhmBA0glZKKMbXRFTajY8+8AuHx3DInoUDS0aUm7jvn
         tryC3WmRCknFDesidSi9JOIbv5YGPU91lXrHQbYQJh2t/1iHFqwDmiJ2lLCWAdwYJM35
         Rs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984649; x=1752589449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F91em5bdhzH0evEHfCzXh2OqMZgsdjbMrBY86+xRXLE=;
        b=HZFNopln6eJ9MMVFBFgqXPp/l/0C4YnDqI6g5ayEvJd7QK/E9B8/2xu8TdFHekAd2p
         rvkdSHdWizIihVu4tcahV0FPhYZg2zEqAR+SM3VNVY+V9b0D7t4lN51k4JqQlVIDWLyR
         Q0eLqWJAeqOEg/MtD5XSxkhj61Dn3ciePoGOxPS5M+g1B7SN0Huk4APqxx6F5FQ8+8aS
         +ELZ9HFWeleccNPiXkH+631AOSOjtPLxM2k5v0OC/4RkksK7dXoi7gr3vOOXOj7tvWvR
         nLmZBbhcqDihRnM9rWEc4gsAN3CCz5RBfzSq76pHDOxAxewyI6bwx9J9r7g2SOKrHemO
         IFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcbPjwwxSz2vLAFCokvudC8DrdE4JitZliKVX67GJJpN4fUljk7SI70XJWgZEPTZTqvkIxVbrCDVHCIao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fI+0ngzq4+NOTVXTyKIuRB+7PpX4J+Evf99G3zvYHR/SA4yY
	lWAMogV8cW+z9shD06JDnHUf881TOmnYiOfuM8ZpH2/sajdKg36AnZA/bmBysnQIz47vzZyh+fR
	Yaayg2g==
X-Google-Smtp-Source: AGHT+IFbF1V38gdww09JJdOKoOpDJjez8aU/gHvPRnPoc/lwUMPRCGZHI+DXUdaAyT+Hz7B4vCxsYKhdwN4=
X-Received: from pjbsd4.prod.google.com ([2002:a17:90b:5144:b0:311:eb65:e269])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54d:b0:234:f6ba:e68a
 with SMTP id d9443c01a7336-23dd0b2174dmr54565265ad.45.1751984649451; Tue, 08
 Jul 2025 07:24:09 -0700 (PDT)
Date: Tue, 8 Jul 2025 07:24:07 -0700
In-Reply-To: <d38b37c7-70fe-4c94-9ef2-e5d765ca5c79@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708101922.50560-1-kirill.shutemov@linux.intel.com>
 <20250708101922.50560-2-kirill.shutemov@linux.intel.com> <d38b37c7-70fe-4c94-9ef2-e5d765ca5c79@intel.com>
Message-ID: <aG0qB2OEUmBTKzpY@google.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Update the file list in the TDX entry.
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 08, 2025, Dave Hansen wrote:
> On 7/8/25 03:19, Kirill A. Shutemov wrote:
> > @@ -26952,12 +26952,18 @@ L:	linux-coco@lists.linux.dev
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> >  F:	Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest
> > +F:	Documentation/arch/x86/tdx.rst
> > +F:	Documentation/virt/coco/tdx-guest.rst
> > +F:	Documentation/virt/kvm/x86/intel-tdx.rst
> >  F:	arch/x86/boot/compressed/tdx*
> > +F:	arch/x86/boot/compressed/tdcall.S
> >  F:	arch/x86/coco/tdx/
> > -F:	arch/x86/include/asm/shared/tdx.h
> > -F:	arch/x86/include/asm/tdx.h
> > +F:	arch/x86/include/asm/shared/tdx*
> > +F:	arch/x86/include/asm/tdx*
> > +F:	arch/x86/kvm/vmx/tdx*
> >  F:	arch/x86/virt/vmx/tdx/
> > -F:	drivers/virt/coco/tdx-guest
> > +F:	drivers/virt/coco/tdx-guest/
> > +F:	tools/testing/selftests/tdx/
> 
> That file list is getting a bit long, but it _is_ the truth.

What about adding

K:	tdx

instead of listing each file individually?  That might also help clarify what's
up for cases where there is overlap, e.g. with KVM, to convey that this is a
"secondary" entry of sorts.

> It's also adding some arch/x86/kvm/vmx/ files, but I assume Sean and
> Paolo will welcome having some more people cc'd on those patches. The
> hyper-v folks have a similar entry.

No objection from me.

> I'll plan to apply this as-is unless someone screams.

