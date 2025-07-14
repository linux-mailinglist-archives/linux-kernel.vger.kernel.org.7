Return-Path: <linux-kernel+bounces-730902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2DB04C05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03B5560442
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0A28689C;
	Mon, 14 Jul 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcs1Ihc4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619C24679C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534731; cv=none; b=ia8ISLwB/28sUL4NtDkswMtta5nHObbcOFdGVceo//shK5X5wsJiPXFs8SDkKKwfG4tgrhrmQZris41bsFMNaRduYCQ3eA2rJWcXGT27Nnyn4XEFlRavzZ7BIKHBKzo/agEHohsYwCp7SYDWXegCoKoNV2Cr+qGfU1LXmeyP3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534731; c=relaxed/simple;
	bh=JS8+GsYrWXB/OgNcS4dyHDFXjB1Fan1qX8YF8Kq1ifY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AcVrWcJLoFi6gZld5Aweyd97d3Nn26xx6hBcW1NUvCJ6+/3dbHI7rdyBU7t3YIQNNBAXSSGi74GjmyH1nv6FjEgMKxL2//eWUoJJqdWfDuwEiGErTlYFwwdNd5HMJn86A33f0ChaEAghCd31u51KwWSsDXgj22kw45A4T/DgkxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcs1Ihc4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso5053095a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752534729; x=1753139529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldIlIZsTmWxf4Q+RRVJYW7oQvHk6FV8rejAxUTRDEWY=;
        b=kcs1Ihc4G2GjoiDrNp8JbakZ7eEIlcMAq0YqZIhpMXxl6Q8a8lFyof3+KMQktEJO93
         iDXlvScxBvRv0F1N58sGUBhzjjsY3CJdRlssmy1NTw7GJf12biKu642yTZC7Gl6INGAr
         F88KHZfkbLe20Z3v2oeYOeHYyJMyTlQffAxsuLIPjl15eYkYdoqkXfBy8wZW2XfBH2Bn
         NPK+5FYXIZk8C8z0Liqsb20UzZk7QUsNhaVl78eGDxaAFiA/3uK8NU/FARaQTpAkzgKY
         WWuWTmdRwEE+FQEU1bmoM7olot8xjg5F9v5U7zYGyCk5AEaUC4WVNw/TwGMmNc2a0QBp
         8deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752534729; x=1753139529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldIlIZsTmWxf4Q+RRVJYW7oQvHk6FV8rejAxUTRDEWY=;
        b=X4XKDWBv1Z/b2ccRI3P5634US5ipP/hEd8fsdshFNpmPNHNg8SO4FtdkGtA7oFtLk6
         s4aSwHOBLo3IFPPkeehmqdZDnrLhMOOa7tIxEMTMc9Lb55bPtZgmkcICI0zJzUuiucIb
         +UoRa7ESu/wCBUbfAlCV19q4AiszAkxzb+1XY8MXDF3THzGaYX6mRYXEz+O6twJsfOlq
         ECwPi7aStdLs8hbH8NzNbQjTVPqF0nJc8G4wGSCGbQex+2haQtW8Vo2rwk5AyKAbr9MN
         78TbroSiciJ+cRVS/Ws8PI6uQJxpso25q7XKgeQeejFYBNtdPJf5331705CKfcdZw21E
         CWfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwi7yUbZfITnUWbwizn1vK/fln3Gpu39rHDSXdobR5qEzVrD7qA0DJhNNDxhG1fKKzo+88YpsKubTawMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqqrbHWGNVuET6xex8s/JXL4imZ85Gd771dBuMr8tkZG/1BhT
	j953nl5Dl85bYo135DPOY3DtOJkXxF0+qELCdFo+QsjXzWFM73hgf/fk1SiG6xuIOT+pU6U5hoS
	eOUbqKg==
X-Google-Smtp-Source: AGHT+IEzy6Rbika3xLoFUr4Vlk4xlhsX2KuawN4KiX8pvy3epkbma1XhqdnQYReJ+Wv1KnbebzcJCwnHiP8=
X-Received: from pjbee8.prod.google.com ([2002:a17:90a:fc48:b0:31c:2fe4:33b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:46:b0:311:a561:86f3
 with SMTP id 98e67ed59e1d1-31c4f48baa6mr23431669a91.6.1752534729373; Mon, 14
 Jul 2025 16:12:09 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:12:07 -0700
In-Reply-To: <68758e01d3ae4_38ba7129493@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703062641.3247-1-yan.y.zhao@intel.com> <20250709232103.zwmufocd3l7sqk7y@amd.com>
 <aG_pLUlHdYIZ2luh@google.com> <aHCUyKJ4I4BQnfFP@yzhao56-desk>
 <20250711151719.goee7eqti4xyhsqr@amd.com> <aHEwT4X0RcfZzHlt@google.com>
 <20250711163440.kwjebnzd7zeb4bxt@amd.com> <68717342cfafc_37c14b294a6@iweiny-mobl.notmuch>
 <aHGWtsqr8c403nIj@google.com> <68758e01d3ae4_38ba7129493@iweiny-mobl.notmuch>
Message-ID: <aHWOx6-IztKB--Af@google.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, binbin.wu@linux.intel.com, 
	dmatlack@google.com, isaku.yamahata@intel.com, vannapurve@google.com, 
	david@redhat.com, ackerleytng@google.com, tabba@google.com, 
	chao.p.peng@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 14, 2025, Ira Weiny wrote:
> Sean Christopherson wrote:
> > On Fri, Jul 11, 2025, Ira Weiny wrote:
> > > Michael Roth wrote:
> > > > For in-place conversion: the idea is that userspace will convert
> > > > private->shared to update in-place, then immediately convert back
> > > > shared->private;
> > > 
> > > Why convert from private to shared and back to private?  Userspace which
> > > knows about mmap and supports it should create shared pages, mmap, write
> > > data, then convert to private.
> > 
> > Dunno if there's a strong usecase for converting to shared *and* populating the
> > data, but I also don't know that it's worth going out of our way to prevent such
> > behavior, at least not without a strong reason to do so.
> 
> I'm not proposing to prevent such behavior.  Only arguing that the
> private->shared->private path to data population is unlikely to be a
> 'common' use case.
> 
> > E.g. if it allowed for
> > a cleaner implementation or better semantics, then by all means.  But I don't
> > think that's true here?  Though I haven't thought hard about this, so don't
> > quote me on that. :-)
> 
> Me neither.  Since I am new to this I am looking at this from a pretty
> hight level and it seems to me if the intention is to pass data to the
> guest then starting shared is the way to go.  Passing data out, in a Coco
> VM, is probably not going to be supported.

IIUC, passing data out is supported and used by pKVM.  I can see use cases for
things where the output of some processing is a non-trivial amount of data.
E.g. pass in "public" data/inputs, protect the data in-place, process the data
using a super secret model, then finally pass the sanitized, "safe for public
consumption" result back to the untrusted world.

