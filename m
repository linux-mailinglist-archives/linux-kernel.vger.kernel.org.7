Return-Path: <linux-kernel+bounces-730672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0AB047ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8892B17C451
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D821FFC5C;
	Mon, 14 Jul 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQBX2YtQ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55712CDBE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521557; cv=none; b=q8M/EjQFd+YNt5xCdFks3N+mrqhX+AhgMzK34CAFML/84phuvrJqvICcOrdq3OGauNa3/prn27a+FmjrEHm6pirAFNF4sSjeaODNLgN3UbyfxUSwBpVjBBRs+FubECkwimTU7nucrgGFZuKELyD1QMLMyW1JHlaw2Kqtfjxqtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521557; c=relaxed/simple;
	bh=a2HEin4T5mKgH4UnU+j+pw+iQeGGmxQpjb2Qfl4MXB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMjJOHo8F7u8egAXi/NofaMD1RDCBOuwjWJg5ROCNVTPFsZNWHuYy045z6otao4qDQNx4msSpaVA9stLM7kc+plEQCn8eC1eFspaL4PC1ZUrklZXa2vaOrw7Z1yIQ1TvPo5zjRfEAYRtVItpYHrCcHGYosb97ahx5cc/28sc9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQBX2YtQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7494999de28so6583604b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752521555; x=1753126355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kN0WRPalT18RoBzndkHpefn+s6+2P/jByoSYx/fNQKU=;
        b=IQBX2YtQNCKnuHZnGprTcLVyxPrPsQF8k0myRp6HEb2ppmQtZFPhFC9HCFPmFzAAps
         Xkmk7bjDwhgSkfzlbqepErAWAsUJ63ElMJyVzcidweA1mOwM3E3mxL09aZhRnZnw6DVP
         QtKB2XvvI4on/gZaDiKesMqKxNlNabGlENhvLpNalpccwwp3oqMPLl0+7TRO3JHkm3q9
         7XY/ggfyb6RCyKnKunsJn+hiCYK5u7cCw9m9t+ziagvmMxFUukdzqBkf/l+3W3lyhsJH
         nZ1gJZaBmia2EiT6TIm/460UqNOxPohTqYDZ4xkyA2I+TVMEHwZlra5IG1E3SDqhAqEn
         BLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521555; x=1753126355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kN0WRPalT18RoBzndkHpefn+s6+2P/jByoSYx/fNQKU=;
        b=iWI5wVXx+Fdn5JgeuShpvorSjXYLQb+0LwyYPXjSyV418lKEyEeSq9uTiVVNxAdPsw
         bM8yUPk18tz+n7SSQSaCXA2vYkBXY2cw6t5XtPe9x9lBQkwPaglOmEXE6EKSKXyYDyoG
         xTRG6ky7NmIhY0oKCuRLk9KaArbSjZ5q8FyRWB5PF+1lMQQ+BZpC4wmLt/EEINi9HdXa
         onxTUS5GxiimjCZIVU2peTWjhjpHI7eXttbPXEbZV33EflhaIyZFd99jtWe97w82pVbo
         551j1qwMbaWJ/3YX1z6KhP5KxU/9AJdtWWDFIJegm08kN2vmhhyH2lx38r5vD/ZOnGyM
         aITA==
X-Forwarded-Encrypted: i=1; AJvYcCXSp0YnQMC/r27eUS+BgsUH1c5XTXGf+Tpo+qNay9citB0LsRQf1cDCmv3k0F8scQoC1j2CTiKv3RemdEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/r06kR3ERKDbEvE/sFerJZ/DSHKeXZHYR1+nHTLdVfLrKR2Xk
	iKEzSFi/CJVu3rHiwlz5Qdi/DgaOla8bVjvxjBod73x3h00KFMlN5+u9IzltAtPDJnooJ4Wc4X+
	LUsT82gqLFxuFgXQKTVzm2F6+Zw==
X-Google-Smtp-Source: AGHT+IHA855jXksBvtV5n3vCT+ApX24/hHTyFJBq8J7w0ONUiwLJ6Smk9CmIJEbMuIj0XT5gcIm6G6heyJvLp6fUiQ==
X-Received: from pfmm19.prod.google.com ([2002:a05:6a00:2493:b0:746:2ceb:2ec0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd85:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-74ee0aa5ae1mr19446492b3a.1.1752521555020;
 Mon, 14 Jul 2025 12:32:35 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:32:33 -0700
In-Reply-To: <aGYM6uQkFAtdqMs9@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aGJxU95VvQvQ3bj6@yzhao56-desk.sh.intel.com> <a40d2c0105652dfcc01169775d6852bd4729c0a3.camel@intel.com>
 <diqzms9pjaki.fsf@ackerleytng-ctop.c.googlers.com> <fe6de7e7d72d0eed6c7a8df4ebff5f79259bd008.camel@intel.com>
 <aGNrlWw1K6nkWdmg@yzhao56-desk.sh.intel.com> <CAGtprH-csoPxG0hCexCUg_n4hQpsss83inRUMPRqJSFdBN0yTQ@mail.gmail.com>
 <aGN6GIFxh57ElHPA@yzhao56-desk.sh.intel.com> <diqzms9n4l8i.fsf@ackerleytng-ctop.c.googlers.com>
 <aGUW5PlofbcNJ7s1@yzhao56-desk.sh.intel.com> <diqzecuy4eno.fsf@ackerleytng-ctop.c.googlers.com>
 <aGYM6uQkFAtdqMs9@yzhao56-desk.sh.intel.com>
Message-ID: <diqzms964lgu.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"Shutemov, Kirill" <kirill.shutemov@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "Du, Fan" <fan.du@intel.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "seanjc@google.com" <seanjc@google.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "Miao, Jun" <jun.miao@intel.com>, 
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, Jul 02, 2025 at 11:43:23AM -0700, Ackerley Tng wrote:
>> >> vmemmap-optimized folios. Setting a page flag on a vmemmap-optimized
>> >> folio will be setting the flag on a few pages.
>> > BTW, I have a concern regarding to the overhead vmemmap-optimization.
>> >
>> > In my system,
>> > with hugetlb_free_vmemmap=false, the TD boot time is around 30s;
>> > with hugetlb_free_vmemmap=true, the TD boot time is around 1m20s;
>> 
>> I'm aware of this, was investigating this for something similar
>> internally. In your system and test, were you working with 1G pages, or
>> 2M pages?
> 2M pages. 

Thanks for letting me know. I'll look more into this. I'm currently also
working on some optimizations, hope this will get addressed.

