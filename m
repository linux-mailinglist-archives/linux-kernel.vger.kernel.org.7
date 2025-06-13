Return-Path: <linux-kernel+bounces-684757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC3AD7FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 02:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BAC174D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5B1A3161;
	Fri, 13 Jun 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJN1GafN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79961E50E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775932; cv=none; b=OmvDswNZK5Z3nXWTTPpQidWks6n/ZHWhDwBqqFMPXO7ymF2cFeW8T/v7+CZazVCNm85CFKAwNS4tr/eAwUA2JAxtVl53aA0aQ7zrTa4mXKdB5X7L0lXDUrGm/cmnRz9XXTR1w8PQS3WK1G0IurdSmQbTK+NOrJ9AeWknSajA4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775932; c=relaxed/simple;
	bh=Y9fqouMbWC/u7E8qeV6xHLgjMBcplZOEarKz0u0J7p4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGxuhH4yoYLQFvChgXxxG3ImNPNYN0zYunPW3TlY7pUqfJ7/JmsOUKyUk/f15C/UVhpD410j7UNpD8/5k/66kzAHrPUYrpHktRStWLzF5L/sBTytuITJupZ2sw6hQnZ7ykYSy5MYV8E6rYhkiJQxt7QP797m+AfXukiVKkaLEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJN1GafN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1630282a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749775930; x=1750380730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDC3Bp47VQywmziigkfie6PRv+RxREIJYB54etTSg38=;
        b=nJN1GafNcYIIYHCylTtQsiickAZj/+ObplQp9+olRdXE48HZFo/neusYMT2v+Gg6GX
         ncKHPNTQ5UB146VlB2quRvLaAo8Fugob8acu5XdVoccCLSdeXs3WG/aR3V3e6J6GO1JK
         eN1Ji8Z7ku9H2bIPv15U5k8rUYaRC3HRYozOZzMqxTm9/8PBOPBcGYf1Zx8vTgxDEJbE
         q9sdDIhm8R55zPc33o9JBDv8OXuZlWBOkv1VW3nJKM0e+1TehQiGtnBpBeUkxnzOLugo
         QQG43AAVnCXQ+DBYZXkc0iFiW8mq43yUK8YAawfol71wRxjifFk+IOv+Z53uD+459EZO
         li3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749775930; x=1750380730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDC3Bp47VQywmziigkfie6PRv+RxREIJYB54etTSg38=;
        b=o1ycGG4Bx66I9gRpR7SsPhjmiPt98m1twtBkopiUUj3t5hX+7o96WzgoteDw5aIhcB
         erS9cXrsqpenPBdBkOUqWxXqiQdsPy8iARdzwEf38chuq8zqUVq8GfIjnXt+Ye20HkOD
         HNhprJLfcgZvJKgPu/JBQ13vlviRCGxbGpmOt0v5t7Sv+603ee+DJ3MZeOhu98QMl/O0
         /AhvWmkwIfEcrFPAzbuNEcLat/OkjVKEIJcjRUEtYg1TIJn1NSeycKUe6uNo6ZlOuXo3
         6SI2qJtg/hkUJ8rXl2uNHU729D3kZwkQ3/XNO74sNHFqclLXNO2leHTsi2jRxa+NA0qB
         cCaA==
X-Forwarded-Encrypted: i=1; AJvYcCXiRdg+JOb2sXBYElRUA012hoLXr9ajjzXBS5rSle5lcZ6Jk5EXnlEAd77iaKTIxwCwOPvWhIY/M/z6OVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSojd9ccpJQ54X/jdP/rOedQ1HU7MjIFqC1jTBC6Dokx8IOcsX
	6tjxNech2NM6zuRoUl2siCHuQ1t/7Jl4eqwBnFt16JoZs9POV5DpuchYqcOL+voRttw0KbfUNcL
	Jsdeqyw==
X-Google-Smtp-Source: AGHT+IE30h8WRYs3H2+xmcIORsn3vKqEjAqKMkjQebOpzu1U+lCJn7zscxn66JCbNPDKoCUmHkAqtEgJO8c=
X-Received: from pjbqi16.prod.google.com ([2002:a17:90b:2750:b0:312:f650:c7aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0f:b0:311:b0ec:1360
 with SMTP id 98e67ed59e1d1-313d9ede996mr1653895a91.29.1749775930174; Thu, 12
 Jun 2025 17:52:10 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:52:08 -0700
In-Reply-To: <ec9cf2ed3f2db01fccf9a01e2739623297b3ca9d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611213557.294358-1-seanjc@google.com> <20250611213557.294358-7-seanjc@google.com>
 <ec9cf2ed3f2db01fccf9a01e2739623297b3ca9d.camel@intel.com>
Message-ID: <aEt2OOQgj2yaW9lo@google.com>
Subject: Re: [PATCH v2 06/18] KVM: x86: Move KVM_{GET,SET}_IRQCHIP ioctl
 helpers to irq.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 12, 2025, Kai Huang wrote:
> On Wed, 2025-06-11 at 14:35 -0700, Sean Christopherson wrote:
> > Move the ioctl helpers for getting/setting fully in-kernel IRQ chip state
> > to irq.c, partly to trim down x86.c, but mostly in preparation for adding
> > a Kconfig to control support for in-kernel I/O APIC, PIC, and PIT
> > emulation.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> 
> Acked-by: Kai Huang <kai.huang@intel.com>
> 
> [...]
> 
> > --- a/arch/x86/kvm/irq.h
> > +++ b/arch/x86/kvm/irq.h
> > @@ -66,6 +66,9 @@ void kvm_pic_update_irq(struct kvm_pic *s);
> >  int kvm_pic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
> >  		    int irq_source_id, int level, bool line_status);
> >  
> > +int kvm_vm_ioctl_get_irqchip(struct kvm *kvm, struct kvm_irqchip *chip);
> > +int kvm_vm_ioctl_set_irqchip(struct kvm *kvm, struct kvm_irqchip *chip);
> > +
> 
> I think we need to include <uapi/linux/kvm.h> for 'struct kvm_irqchip', just
> like you did for "i8254.h" in previous patch?

It gets pulled in by linux/kvm_host.h.  i8254.h didn't have that one (though
amusingly, later on it does get kvm_host.h indirectly via ioapic.h).

> I checked the "irq.h" and it doesn't seem to be obvious that we don't need
> it.

