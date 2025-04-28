Return-Path: <linux-kernel+bounces-623269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013AA9F366
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F092116B235
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2C26FA4D;
	Mon, 28 Apr 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mztNw7Dh"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882A2AEED
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850541; cv=none; b=IoVBGZifchrdklzVs1do7sgNTOh0BBtP7OIyus6Be5gXHrYHWtNHaJg6pvZya5HbGK9DIgvjNOzFzImnc3Smc/951PTL7qOIwMmIkhyGBPQCNktbl8fs1STF/dF+Z4ZBrVIdK2IL+GG5jn9fh1QJNKKNjXS/7p2/gdcyOiR2bfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850541; c=relaxed/simple;
	bh=PlvGxKBAguiMMvzKwXiOHRNITOLwL/WsS4Bi+NDt3Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fn94zOAg0/72XDdSRz3wJEj3a382iJ6gbQH2P6MYAfl4TpkS/JdHMXbq3tnU4A5UWzBjKVF8kLjlh+AtZ+f0mqlsRcVUvlKhJHJcsPZomB7rpGLbW5wzUXiow5EU6ArfkBD82tZOr7Nb24f0toZupBVVqMltkqkkXCUb6bQi0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mztNw7Dh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so4399856a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745850539; x=1746455339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abibsDl5HoC6YQrSV90fu4wrxKEz17/z8+z0sJ02IW0=;
        b=mztNw7DhHyy+gLCjtcB4c3phd7umAhW0xmF5/1tsJyF68AEKgFL1UQX4awe2RttAy2
         8O9asqXcCY3rD08N6SB6aX2QIvcfHskYXzEoD1dO3tiMW+AMbab1sjwFOjcW6UKQDOqx
         kqEtJoYNZlA6En0JEb79Xn+rMFPOh1SyLzGqfL8f18wlXyQXK0MEz67zcnEKcEITKjod
         6MCuEDm66UafssSbfpjVe2ng8OzVFrQryeYzbbOdXqp2KDybzgJyr3iW/fQiGZDR2O/p
         pP5GgxVV2KZ6Urt4/EZln+OfoSDu5pvCp1d5s72aJwqrx6OpymDPEzGMRG7U7C4E0vwc
         u02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745850539; x=1746455339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abibsDl5HoC6YQrSV90fu4wrxKEz17/z8+z0sJ02IW0=;
        b=dIUu32eDw9wYxpthD2/yS+ok5gnvJcgnIS3m6dDGYQlHJ2aui9lAZyOkXD7vX/EGto
         BPYF4PH+PP6KTXJZwGL84je9UiqY3FzCWpZVRukCcTIAQRHab/N28TltXSXRd0S7jdJj
         4vUzjojMC1zHADnqPFKorIi7REspIPiJwSZL481IRNlFHnOmq4DCVI/fTBseN4zL+c2j
         nAuMOAG3BQy18OBZM7UpBgPlhFvkWnITDEPV1x4JE6x1nE3fe4KCAOr81p/2HXjnCsPY
         8Yxe9gnLN/ZHR2UZy98V4WhN4vPtcuUdNYxW0+kP4E1MWWeEBHIqCb6cWw6dMYPACVzG
         fnjg==
X-Forwarded-Encrypted: i=1; AJvYcCUlNGAPHWTfZChs5dTlQrmDiuYSrANYQUyED3JA4Xs33hZpAZZoUNW2iLa8dbYQHQ/r7Kwq4SSJ+Cw4y0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1+AW70mLbuTTEFUDnJsnd15o1yvOQGqkzAu/0xXsq1Grei+B
	i4aacZeM5AKJJVLyqV6pqoRAFcG+JDMxiAbz5QO+TKJbi+k+s947EoNr3vXlVv0pVKZHUWIL5Rd
	PrA==
X-Google-Smtp-Source: AGHT+IH2g5hOKU5+3T5piD6P0nZGBIX75kRIQmJW5OuqdbA1tGNsWEyhNp47vSCuY7DI26wirbZfbPwsCgg=
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:2ff:5344:b54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544e:b0:2ea:a9ac:eee1
 with SMTP id 98e67ed59e1d1-309f7ddca6fmr19617208a91.10.1745850539160; Mon, 28
 Apr 2025 07:28:59 -0700 (PDT)
Date: Mon, 28 Apr 2025 07:28:57 -0700
In-Reply-To: <aA71VD0NgLZMmNGi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410072605.2358393-1-chao.gao@intel.com> <20250410072605.2358393-4-chao.gao@intel.com>
 <f53bea9b13bd8351dc9bba5e443d5e4f4934555d.camel@intel.com>
 <aAtG13wd35yMNahd@intel.com> <4a4b1f18d585c7799e5262453e4cfa2cf47c3175.camel@intel.com>
 <aAwdQ759Y6V7SGhv@google.com> <aA71VD0NgLZMmNGi@intel.com>
Message-ID: <aA-QqaKo825uIuW7@google.com>
Subject: Re: [PATCH v5 3/7] x86/fpu/xstate: Differentiate default features for
 host and guest FPUs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, Dave Hansen <dave.hansen@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Stanislav Spassov <stanspas@amazon.de>, 
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>, 
	"samuel.holland@sifive.com" <samuel.holland@sifive.com>, Xin3 Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Weijiang Yang <weijiang.yang@intel.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "john.allen@amd.com" <john.allen@amd.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, Chang Seok Bae <chang.seok.bae@intel.com>, 
	"vigbalas@amd.com" <vigbalas@amd.com>, "peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"aruna.ramakrishna@oracle.com" <aruna.ramakrishna@oracle.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 28, 2025, Chao Gao wrote:
> >I assume the kernel has bigger problems if CET_S is somehow tied to a
> >userspace task.
> 
> To be clear, CET_S here refers to the CET supervisor state, which includes SSP
> pointers for privilege levels 0 through 2. The IA32_S_CET MSR is not part of
> that state.
> 
> >
> >For KVM, it's just the one MSR, and KVM needs to support save/restore of that MSR
> >no matter what, 

Oh, it's not just one MSR.  I was indeed thinking this was just IA32_S_CET.  But
lucky for me, the statement holds for SSP0-SS2.

> so supporting it via XSAVE would be more work, a bit sketchy, and
> >create yet another way for userspace to do weird things when saving/restoring vCPU
> >state.
> 
> Agreed. One more issue of including CET_S into KVM_GET/SET_XSAVE{2} is:
> 
> XSAVE UABI buffers adhere to the standard format defined by the SDM, which
> never includes supervisor states. Attempting to incorporate supervisor states
> into UABI buffers would lead to many issues, such as deviating from the
> standard format and the need to define offsets for each supervisor state.

