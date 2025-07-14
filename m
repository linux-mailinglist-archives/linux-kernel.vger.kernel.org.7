Return-Path: <linux-kernel+bounces-730092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2361B0402B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA98818899A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D00B2571AC;
	Mon, 14 Jul 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMgQNFoT"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978772517AF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499929; cv=none; b=GbJOWh/k8VylBFNDGDC1EHKmXuRlXXHT3dox9oYs7/ukKoRFqfSYz8oKLXr0NNgxnF5lOtcVl3CbKWC6clyw/x+PI4Y2Ct4dtXhoVnZRdlV12ollRFoR6RYGsaIiBfERtJFo4bzpLRIrKLy3HBuybxgMNzwUxHH6XU5hw+mWYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499929; c=relaxed/simple;
	bh=pzY1zzP5XZiseR6QvyPRUFl4wC4guT21TFCzuh0WteQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Suhm+uK8F/KCy4Fpuu5wnfv/9h5bRWjDDIDi8Jvg2F6JqGfdNtg9K3sfa7oZ0olhE+kkW6yR9op4Gp9y63IgtVtZ9bsrIbNBJq8vVKOqvdTVM3Rk/ipD+oxE4bwDHXfb+FlAoPsA2Vw+5i6ViMOfNFQzuU72kY5m6CpPft+mxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMgQNFoT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e1d66fa6so39796025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752499927; x=1753104727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oUNzcQ1xlAA6C+zv++Z/UrxHElTSq2AcaBcHlPI4ybs=;
        b=yMgQNFoT7czQB8N2PDVivvIQuIojbYXw/VxNiS9NDI+ww4a1HQum98kFGDoe80AjE3
         gmyR6DCfmHxHmE7dlucmG01Xh1+Nch+3awNu74/9QnD4U9P3XrB5vcx4g2Nq4iEtOdFw
         g/MlwIz0EvzoUCzPp1Yu+diqqGlkc66PNKGM4qr96XCit1hvjcpvDE47TUHqdg7nT2xI
         Gwlj7fCxym16+O0lMnAV69pfDvhaZNwLCBEvvt/IwsrCSOllZCXd+3P7kfk7U04OTXH7
         NLimouXE+08q3is09RkOdEFILSfR5PQyJ0Zj1Z8zN5Gm5S/q31cw06LeBLEiVwQUXDpW
         qMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499927; x=1753104727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUNzcQ1xlAA6C+zv++Z/UrxHElTSq2AcaBcHlPI4ybs=;
        b=oNgQ3gGvUT1BXa4b3fSW0HXwJyNIthEx7ZT0unCTq14cYn1TMdGgb9A9vcngXjpciX
         Pb4qqkOSMleWIov9jurFuUXOJm3kP3haBmmIfm4u1zTmnPQniC7j7JRuvkEVHji8YszJ
         HvGnqfbzEBd3SItijRYKaXE+7PzgK8AJQIWqZM1V7cAGHHX+ElURy5zDCzbzh/sP0uoL
         fQdfjG59hFUgDZbxgylzGtBXKA4Vq8n+B6Xy13BJKxkVRTyoCGcqd18tPPLsIxDGA5qd
         UEYra58SQVTBvZG7n0EkzUZDJI9avWhRzijch/G5hf6UOdZwzJQavfKXJpIgPbTp7jXt
         HtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfQoKP18y/q2ydu3bJgz7wz92hcKwD0HkhPcm7CST84gWcnJs+3Y8G9SwFQYgcqmzQBeR5G2eWJF9DOsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWmcnbdOXv9IW5qQqgpz4kh2SGLXiQDR8KnF9OpEtX94nMGvZ
	MbyhwaC0ePKS8eOPqFR3irvaWRaEHC9l0bvGVf/aY0XRMOyOFYzevXTHtLo3PJ+nHT7HlwGbNhE
	6rIrlyA==
X-Google-Smtp-Source: AGHT+IHOhQ+T9na3EwZ8qs0c6r6zVVWjEa/PX5Yja9odLBhtSlSKchBHzSBRBu2VFmUKCMfBYNYdJDBtasA=
X-Received: from plgb2.prod.google.com ([2002:a17:902:d502:b0:237:f270:4be1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db08:b0:235:f49f:479d
 with SMTP id d9443c01a7336-23df07da842mr176069085ad.3.1752499926932; Mon, 14
 Jul 2025 06:32:06 -0700 (PDT)
Date: Mon, 14 Jul 2025 06:32:03 -0700
In-Reply-To: <20250712184639.GFaHKtj_Clr_Oa3SgP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com>
 <20250709033242.267892-16-Neeraj.Upadhyay@amd.com> <aG59lcEc3ZBq8aHZ@google.com>
 <be596f16-3a03-4ad0-b3d0-c6737174534a@amd.com> <20250712152123.GEaHJ9c16GcM5AGaNq@fat_crate.local>
 <e8483f20-b8ee-4369-ad00-0154ff05d10c@amd.com> <20250712184639.GFaHKtj_Clr_Oa3SgP@fat_crate.local>
Message-ID: <aHUG06Fz1Fg61NWT@google.com>
Subject: Re: [RFC PATCH v8 15/35] x86/apic: Unionize apic regs for 32bit/64bit
 access w/o type casting
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	Thomas.Lendacky@amd.com, nikunj@amd.com, Santosh.Shukla@amd.com, 
	Vasant.Hegde@amd.com, Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, 
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, 
	kvm@vger.kernel.org, kirill.shutemov@linux.intel.com, huibo.wang@amd.com, 
	naveen.rao@amd.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Jul 12, 2025, Borislav Petkov wrote:
> On Sat, Jul 12, 2025 at 10:38:08PM +0530, Neeraj Upadhyay wrote:
> > It was more to imply like secure APIC-page rather than Secure-APIC page. I will change
> > it to secure_avic_page or savic_apic_page, if one of these looks cleaner. Please suggest.
> 
> If the page belongs to the guest's secure AVIC machinery then it should be
> called secure_avic_page to avoid confusion. Or at least have a comment above
> it explaining what it is.

secure_avic_page works for me.  I have no real opinion on the name, I suggested
prepending "secure" purely to avoid creating a too-generic "struct apic_page".

