Return-Path: <linux-kernel+bounces-686319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF7AD95DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127481E2EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8DC24A069;
	Fri, 13 Jun 2025 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu1aolB8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46A244676
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844999; cv=none; b=duJ+K0ufLtLmTmHinKc8CkjLtRTknMjaicJ4KseswWIWGi6Z6C8C+NMF7WEFdbx0WRP3AC8vnGmKz3CWI8iiUXC3ph1tPZieP1naaobstKAQSNzXqmRXRzWJ2CSko+WVUGMFZe9+/ERGUxh1JGHv3AkRpTJt0xEbnnm4oywSDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844999; c=relaxed/simple;
	bh=H1fXVD8SmgWbaPrQ37kvyYzIJ8KMmGQOBuk316FWEpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JktUX8Y+YswvBYMIZEAYLR7GBe2SD/up2vAHX8jvt1qagPOdvgAO7ZgsTJNIl2VCzGXmOuw7L5pJBsWOtR2L87rz7iB3jYA+293uKquxPuDNj30Lh16zdFjkc/EBDEHDc+oc5MMwKRtW9bVKz1eWLNNDP+08N1Z/q16EREGJVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu1aolB8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31220ecc586so2397760a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749844996; x=1750449796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jkTY9es+L0SHOQjbsKMylNmSXtoJEwR4XCF9O55X7U=;
        b=Wu1aolB87FBOhs+l1YK6rRSlhgdVaYprjE/vORx1mZMg1R/XBTqFq2dboxqRo8roBC
         et+qi0oBIjByY5omKChJN2M264RIaS2felZjZ8Dyb4Rhhydu3z5Z/oXNd/bcuAvz53ku
         4oyWySSLBh8F+nk39FMlDhieu/+SWzaNaK8jD8aNg9IXKXkw9neIbwO+wVHgo2rQCiqo
         Oj6xyFh2br7z7npyjBHCLcEKM3DMLqPHh+Bben/6Ybq5wzeSlIfD+664JlzHlExBmiw2
         d0vHsjzobBfxDMx5BkvN1ssUWTQ2yAql41TaqDV3sqgyjGiC9y+akOWCLaeUjyBM73af
         Jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749844996; x=1750449796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jkTY9es+L0SHOQjbsKMylNmSXtoJEwR4XCF9O55X7U=;
        b=f7NmtIgvb/P3RC3YyQv9b6xz2oMh5BtxSwOeCAfDnjJq+WqjJXVvRZSBJeX3EFvl2n
         TiRB780JJWwn5cb+JGJLbGkAAepA/ahILtKH5U8YiTWBgWQJNI3BFEcqla5R41Ahx1tC
         vz+lroOwA5xHzfy5P5vnwuJ2PrslPhlLXoqAsVaaMbJe4H/0oDMobDlcuboTy+8SQ8Hj
         s9PDh3J04L6SpbewEQbooYo/YbAZfqyyc/Ngnz3Vi+H85CeDhS+/7IqSK0Oax79S/1Mr
         iJrElKY1vEeAkgz8BrvXjtBIwIgMdyoidEnzeJQvo3r0U1trlisel5uSzbcSiVOwqYnU
         WAWg==
X-Gm-Message-State: AOJu0YxUe8uTkGz3hZSXHhOmWk0ICwb9daEwtinChUJSXG+cLxG5HSTP
	aCaI1aLiPdkGag8YnBdK2CDKzGnYNkcl6espXcIWAUa9R3zo8ESrG2JVVvLDgwd71He3M6WbTwY
	uCgp5YQ==
X-Google-Smtp-Source: AGHT+IHeFRFgvpHTT7ADjIBFSpJOAij4nlVS+2t6k1iLjMAhZ20QavMK8ENnHmWsKo/qdTUkyN8SO+Uybws=
X-Received: from pjm11.prod.google.com ([2002:a17:90b:2fcb:b0:311:ff32:a85d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cd:b0:312:639:a06a
 with SMTP id 98e67ed59e1d1-313f1d0aa4emr1327100a91.31.1749844996505; Fri, 13
 Jun 2025 13:03:16 -0700 (PDT)
Date: Fri, 13 Jun 2025 13:03:15 -0700
In-Reply-To: <00358cf3-e59a-4a5f-8cfd-06a174da72b4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613070118.3694407-1-xin@zytor.com> <20250613070118.3694407-2-xin@zytor.com>
 <aEwzQ9vIcaZPtDsw@google.com> <00358cf3-e59a-4a5f-8cfd-06a174da72b4@zytor.com>
Message-ID: <aEyEA6hXGeiN-0jp@google.com>
Subject: Re: [PATCH v1 1/3] x86/traps: Move DR7_RESET_VALUE to <uapi/asm/debugreg.h>
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, pbonzini@redhat.com, peterz@infradead.org, brgerst@gmail.com, 
	tony.luck@intel.com, fenghuay@nvidia.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 13, 2025, Xin Li wrote:
> On 6/13/2025 7:18 AM, Sean Christopherson wrote:
> > On Fri, Jun 13, 2025, Xin Li (Intel) wrote:
> > > Move DR7_RESET_VALUE to <uapi/asm/debugreg.h> to prepare to write DR7
> > > with DR7_RESET_VALUE at boot time.
> > 
> > Alternatively, what about dropping DR7_RESET_VALUE,  moving KVM's DR6 and DR7
> > #defines out of arch/x86/include/asm/kvm_host.h, and then using DR7_FIXED_1?
> 
> We definitely should do it, I see quite a few architectural definitions
> are in KVM only headers (the native FRED patches needed to reuse the event
> types that were previously VMX-specific and moved them out of KVM
> headers).
> 
> Because there is an UAPI header, we probably don't want to remove
> definitions from it? 

What #defines are in which uapi header?

