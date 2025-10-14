Return-Path: <linux-kernel+bounces-853241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB13BDAFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B50B35679B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517D2BDC35;
	Tue, 14 Oct 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHoRD3ed"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471A235072
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468731; cv=none; b=L/1qBDJ1GIunypmrxQA1Yl+0cp0/HpIJ4wdR4LHm5Mw3cPvX69P3o0lhKKBdbfRzggB5gw94SL4RHBhUxQ/1mQXkXTRUOKQMJfpwmL7cITJL0vVjl9M5DUEQHUpNrT7acpRp9yTDNuLJJ0cn1IGwfu3VEX6kBQwIPRt4cBjUDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468731; c=relaxed/simple;
	bh=k7sLOjS3mwqYX0wOEW1KBhtCAUTziTwPywv1CTVyHNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iEOfCCXI/qG5ulERqVdOdbyuGJf6vkXYYBQcz8rIZYbaacNycjEQDvNlyJ0rFgt86tVPVDYQ5KwYJjFQcznnExWDxc1UYxgiLP5zZ+vZKOj4PhQi2cU5ppvEysOVjvgMPSCax4l4bH21B3Uzu2XZSJUK8IHk+j2trT0Hw4fhK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHoRD3ed; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befd39so22393760a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760468730; x=1761073530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rc58PPiWOIscw4gzc1uP4pr7xQS6V7163kSeQz2T208=;
        b=GHoRD3edEz3z9KDv0wxm3cpnuV71pCBN2pVGiXcpab2AmZbA8KQXsLkObK8qRYC6cv
         TwNHkj3SiTIb9mnR4fuuVpP6HxwHiJv13/Cz3R1JMj5/f5fITSABR23DmXvhiHLBvkHX
         wJhzo0IZwkYcposzM9QG9m+uVWrlW4IBXalYCLRjJyzgMNargTVWrqxUfmIng4A+fOsF
         hm9hvTxb6TzookUAC0Jk5Itmy6d9dR1bCqAKjxTmbjj4txNJNVFTpb8XONf6Pq5pq1wW
         gLQsx+2BmAhYYn1Z73Gi7DCkJqJInSZac8mMYQePDi4q2C46KHxK6ZFou5Dbyb69y3Sj
         j1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468730; x=1761073530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rc58PPiWOIscw4gzc1uP4pr7xQS6V7163kSeQz2T208=;
        b=MohWLkA6FCSIz0myW7AuU207IKLXf3hGpHwRJVg5QBl5F06GboZzY+L6IFFe1RFn6f
         95lDJNOyTg7Bt7PiZbH/LGR70lXmUjKQ99hdyHbO3v0e9QVVGhZ5DDz2XsE5BatcX4BL
         dWY4x1gyRPcw0uOUEhri1UlkzQOVaduN6cS4yfXHuJjuKttAyZuYiv/+vi4/Zkqlrj7C
         cJpzi2ab2xWwiG6OrKbAEDmV6Olei1MAngcP7CTOhfv1qljxP1eDi9TYZxeqq0tpU+cM
         mhA29d74WCJ961pm6M1/nGSUUnZKZd5+FqZ6oYaURe5Kdul9tlP7y15z4+btAbA0PNLN
         NvIw==
X-Forwarded-Encrypted: i=1; AJvYcCXBDm0vHhuLnJhxakBoSRmvqIbvnO1O1l2wh12gWPqtAJeJvrtQDT40qKiCNktcFG8Vqejy3Sr7eOiZqjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zCKCdi9iyczJxDonJgF29eieMYorP0Lkos8runaiTEpb+OHl
	UexbOdDSoLPUK/0yWnyNbg311KIdTcJMubk1tVljO37+y3ICw5ji/4DRZtgaRL1y7YqI3tb5/mA
	8uDmfng==
X-Google-Smtp-Source: AGHT+IFPeoJzDvTAF6xr4A7hQhLSCx/6X0JPH4z/3Z9BNtyzLqFJ4dyjiFG5gqILjbnBFdR2+iVHQHmVLHk=
X-Received: from pjbga22.prod.google.com ([2002:a17:90b:396:b0:32f:46d:993b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224a:b0:336:9dcf:ed14
 with SMTP id 98e67ed59e1d1-33b51375a05mr37471970a91.23.1760468729683; Tue, 14
 Oct 2025 12:05:29 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:05:27 -0700
In-Reply-To: <68ee9bcf14fea_2f899100d2@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010220403.987927-1-seanjc@google.com> <20251010220403.987927-4-seanjc@google.com>
 <ffc9e29aa6b9175bde23a522409a731d5de5f169.camel@intel.com>
 <aO1oKWbjeswQ-wZO@google.com> <aO4LVTvnsvt/UA+4@intel.com> <68ee9bcf14fea_2f899100d2@dwillia2-mobl4.notmuch>
Message-ID: <aO6e9xuii8vsuNQH@google.com>
Subject: Re: [RFC PATCH 3/4] KVM: x86/tdx: Do VMXON and TDX-Module
 initialization during tdx_init()
From: Sean Christopherson <seanjc@google.com>
To: dan.j.williams@intel.com
Cc: Chao Gao <chao.gao@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, dan.j.williams@intel.com wrote:
> Chao Gao wrote:
> > >> Also, can we name the two tdx_offline_cpu()'s differently? This one is all about
> > >> keyid's being in use. tdx_hkid_offline_cpu()?
> > >
> > >Ya.  And change the description to "kvm/cpu/tdx:hkid_packages"?  Or something
> > >like that.
> > >
> > 
> > Is it a good idea to consolidate the two tdx_offline_cpu() functions, i.e.,
> > integrate KVM's version into x86 core?
> 
> This looks good to me, some additional cleanup opportunities below:

+1.  This crossed my mind as well, but for once I reeled myself in as I'm very
susceptible to self-induced scope creep :-)

