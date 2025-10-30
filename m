Return-Path: <linux-kernel+bounces-877321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28167C1DD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA2244E430A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7B1C695;
	Thu, 30 Oct 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjIDM3eE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AEE537E9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782676; cv=none; b=H/Rwd8rXbrsxyz6OCQahCTqhD5mX7OmqNHMIDJOIpn0UwBI8NQI87tLZYB87tUk+B/exsUiuyr1ICfusXdkI/z3DaIZqwOjNoarsepaMY9leNgb6qEYS1yZQA/pwEhxGVKfjYOwVLpdChuoxnHhKauThkUaCbPRWGQ2WJ85aMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782676; c=relaxed/simple;
	bh=jaTsmHdwIZq4U4hvQOOEIEvhY+yc1zKy4Ke9cKk5Qsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R812Q+oDHexjMxl4SvW7Y2zsP/L2pHbFilPI9kVsa7sBRPGHCciLFTkRlva4+OoEIO1RGPL041rL4gbQDUzaOSKJ2Vtgl+repBvLfyzsTn1o+qIbCyf9fdRG+KhP7F1y58VOWjnL2euxf8YgubqhN+/m1/kHGjTeNO/Pmi0o4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjIDM3eE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so298313a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761782675; x=1762387475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIrHEmsxfLaAPd45ihCALHVYkxXRqjXH34/AOUl6eqM=;
        b=wjIDM3eEch56p9L60e8Q0M34bgqy9pP2TsCqJBccdumtcjTYa/LzKkSkT6uicu50Qj
         Thuh3r9aF+VQgHgbuHZKNduyZ2JsKewRL7TXd/XFkV5HSeRl0jDeWa+8BeN99JBSv5y/
         iU9MqEnq9ywSi/DV5VG98bqPvOCwitRqfJXGTF3bzQHREPhcKSqSRzuIB2Wv+pFpyWhk
         A4fqSAQs5xWpfhN+GW4y96gTXGNcGKx/+pbe37AWUQAH9/vl1LKPWwxk7g/+eeCxgY88
         +MReZN/DQ9TuMwX+kYIjv/9i489gHb1fgk9LRMZqa+c0VedKG5mTtplVhKvI/j9cImw8
         QmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782675; x=1762387475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIrHEmsxfLaAPd45ihCALHVYkxXRqjXH34/AOUl6eqM=;
        b=gn3Ayqbrte8iObN+odfGeoUbWm6FQbPi48GhSfG+fI2wSNWcogmBxInEJ94vXqFA7b
         3BcGYu+VHML0AQ/NcISFQpJNoZVQJQTGgqnjg+RJOV2oTU9E5dsV5uj3BZfOyiPII8qJ
         dmfbeqdD+smrESav9ga8kb2TLtyhKuTZpmbAFCX7AuTAGESyC9c7VgpkTOtzeO3/LaRW
         87lIrPryWfLhGjc3nyavcg0/eMSuq5XFAaP/DtmIaycc3iD1BT4TEJ+mrEwCLOqmub2K
         HD3AAWqazD+engxilzwzjxwljWbvox3xThty0epfitQdmrZ5bMrZ22zDSyrGZMimFvJz
         WBjw==
X-Forwarded-Encrypted: i=1; AJvYcCUh95on/+Ks9sGOa/7a0ne5B8tyJhzCbV1BnBVFGEhUL4Pwz7MCl9ryrUurYXAq8llmFyc2zHNcjlkorsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZcHB1rvnKqRWJzyqXk9cQust32jjvyfiZ9+u/QWh28bw7A0f
	ZD+ePGwS08IBJZPuL7pvqKv3qLKeBiCSJDoSTeQ1gc0E4tHdOPvo/FgkkE5wi+c5XMvTAT79Oug
	qs6zlZQ==
X-Google-Smtp-Source: AGHT+IEZZpZq+IDi8IyHoM8aIbvprldznJBx279VE3ScrZ8dauMwF7JHqraPSUfxieM8mJgkZDFgN+LxdVA=
X-Received: from pjzd5.prod.google.com ([2002:a17:90a:e285:b0:338:3e6b:b835])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8a:b0:33f:eca0:47c6
 with SMTP id 98e67ed59e1d1-3403a2f179cmr4786753a91.30.1761782674676; Wed, 29
 Oct 2025 17:04:34 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:04:33 -0700
In-Reply-To: <0a4224a5-4357-4bb1-9060-0e0480fcad1e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029194829.F79F929D@davehans-spike.ostc.intel.com>
 <20251029194831.6819B2E7@davehans-spike.ostc.intel.com> <6bfe570e35364bd121b648fe8475f705666183d6.camel@intel.com>
 <2e0e538e-99f0-4828-bdd3-fda7ad3794c3@intel.com> <aQKciMQG9y-szKUm@google.com>
 <0a4224a5-4357-4bb1-9060-0e0480fcad1e@intel.com>
Message-ID: <aQKrkZBeyb3_FLHH@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Remove __user annotation from kernel pointer
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 29, 2025, Dave Hansen wrote:
> On 10/29/25 16:00, Sean Christopherson wrote:
> ...
> > I also don't undertand why you would take these through tip.  They only touch
> > KVM (which is annoying hard to see since there's no shortlog in the cover letter).
> > Sure, they're minor changes and _probably_ won't conflict with anything, but again
> > I don't see how that matters.  These are clearly KVM patches.
> 
> Hey, the more patches off my plate, the better.
> 
> I'm happy to make them more KVM-ish if you want and put the problem
> statements in backwards. ;)

LOL, I'm not _that_ particular.  Feel free to send a v2, but I'm also a-ok doing
fixups on the shortlogs when applying.  I'll also add the Fixes: tags Rick suggested,
as KVM x86 policy is to be liberal with Fixes, and only backport explicit stable@
patches.

