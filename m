Return-Path: <linux-kernel+bounces-790673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EDFB3AB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E5F1C8654A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF80286435;
	Thu, 28 Aug 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5KaIX28"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C133285C96
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412823; cv=none; b=KuY5hO9eDHCfGZj8Y29A9JN0ZCGOazdxiwzT1WxTIonTiZl0jCGapRyEPYrWENPqcBW+dJlqlX3Dpo3s+BpasVRCZibG+cCrgvrWvK5lRUTn/o1kJexIUXD2HBeu2Sf89aO1mZ8uunZRwnTWRcsSaGgu2GoCUUGmiy2PkUkOiGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412823; c=relaxed/simple;
	bh=lQCj/8DX2+2fPso80C7omivOFNdfKWj9QCf3lQhPPRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ao8aQD36N7UHaHz+dELR56Ok+CerHmzFy+H0GiYMtyhOwK0gDPaIkDyUiLftJ73n8jG2K88M3aen0w6UtkgKbuFa0BpwySClHbQHrkA5zNA4OZEWN3fGX9ZSSaHJ4/5/NfgOxTaEKFJ6sF3KJww7DI0B9FC3lcvLmpr4GjWx9X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5KaIX28; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445803f0cfso17078045ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756412821; x=1757017621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSfr0LzBocl9L9UhuFbA5UhknpM1E+hopBnA+D2wBr4=;
        b=G5KaIX28Rh8o5uyqo7lRCVCQsKNpQzgMSEwyXipGZt6vDjdwX/GhveeczzawiHn9GQ
         uoGdho8c5AhAlurJItG0e7XBXBAwj7VodwE7eFZ73XkrJtPJVenUORTqPkuntN/YllzY
         mdA1sgVCofHJpTR3Tnb3RGv9yrA5S4xcYs1SzlVkjMw0jRtNF7WH463QJk94LwV2PNjw
         JOG+D8tZMmX8QGRzUoxhBkH1nYlZbLp9x16lxsn5GXuNmWU714oC1MUf3pN8PTYwOItu
         5PzjX+efD/BOwwglMNok/smgOxLRltzeXssOmC3hClmhcVNlUaybVPRzkNAoINzU27dP
         dc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412821; x=1757017621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSfr0LzBocl9L9UhuFbA5UhknpM1E+hopBnA+D2wBr4=;
        b=RNmEGgoB9IKTUJEnhsr6jJPhbTZlOPgXOqy2A10me1XODzYnsmB7qkVCmpsXog6WTv
         LmbgILOy/Lu1k93eDJcxfacQRs1nN4NbkXh6R1qlUw4BNhF4Yj23ssh5xzUj8C0mcGyI
         mg/9iyKTRnI+fK/Mja4YHtI4UMGl7T684wj5HVBH8s92XnvjURrtCn6XgINgJMl+pgee
         +WNE2O9Ok+iffQ9nwaUcb7aVaJ2Wbx8HI4+1FzJAsmtZW4wnJvD2BMv5hh7SJwH8Iw67
         6u6xlpWHBVxTglZfoaHN12wu0slZ04xnjkqOQc2rBLPhSAVUdWQm/uf+pUp7hVl7bgsW
         ngCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWagAGz4wzLxjkRyZ0h6c3vdLQabQoMNVTmGNx/cpx6CEwFBvgMTiDdkoDHBgEtdGORzmk/O67RxZo6Fi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41AAvWFF9mIDUxXsO2VZZMgj4tgOTnqCaT6wgaDGsEyVJY5y1
	+pUkFB5CQKmOMY9sRqDfIO42UXLTzUXiXjQjsDopG4k0MF7b9kHXFJTiE0U8fXduN9wigQFj1It
	/9euf+g==
X-Google-Smtp-Source: AGHT+IGzXOKfZVvo+2eg6DXkxP+qrQxlD6YKvr1m/uZAbrEhBiVXCwwJbl3iWJVXN2X6ydlBuQ3wyXAC4sY=
X-Received: from pjbsd11.prod.google.com ([2002:a17:90b:514b:b0:325:b6a1:dda2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d08:b0:243:7136:2fee
 with SMTP id adf61e73a8af0-24371363240mr22615414637.16.1756412820760; Thu, 28
 Aug 2025 13:27:00 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:26:59 -0700
In-Reply-To: <fcfafa17b29cd24018c3f18f075a9f83b7f2f6e6.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-10-seanjc@google.com>
 <aK7Ji3kAoDaEYn3h@yzhao56-desk.sh.intel.com> <aK9Xqy0W1ghonWUL@google.com>
 <aK/sdr2OQqYv9DBZ@yzhao56-desk.sh.intel.com> <aLCJ0UfuuvedxCcU@google.com> <fcfafa17b29cd24018c3f18f075a9f83b7f2f6e6.camel@intel.com>
Message-ID: <aLC7k65GpIL-2Hk5@google.com>
Subject: Re: [RFC PATCH 09/12] KVM: TDX: Fold tdx_mem_page_record_premap_cnt()
 into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 28, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-08-28 at 10:00 -0700, Sean Christopherson wrote:
> > > tdx_td_finalize() now just returns -EINVAL in case of nr_premapped being !0.
> > > KVM_BUG_ON/WARN_ON should be also ok.
> > 
> > Ok, so I vaguely recall that I may have pushed back on using a scratch field in
> > "struct kvm_tdx" for temporary data (or maybe it was abusing vcpus[0] that I
> > disliked?), but what we ended up with is far worse.
> 
> I think it was also that the tdh_mr_extend() loop was too heavyweight for the
> fault path. But that was before we got to the kick+lock stuff.

Me confused.  This is pre-boot, not the normal fault path, i.e. blocking other
operations is not a concern.

If tdh_mr_extend() is too heavy for a non-preemptible section, then the current
code is also broken in the sense that there are no cond_resched() calls.  The
vast majority of TDX hosts will be using non-preemptible kernels, so without an
explicit cond_resched(), there's no practical difference between extending the
measurement under mmu_lock versus outside of mmu_lock.

_If_ we need/want to do tdh_mr_extend() outside of mmu_lock, we can and should
still do tdh_mem_page_add() under mmu_lock.

