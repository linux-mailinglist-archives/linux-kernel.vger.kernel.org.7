Return-Path: <linux-kernel+bounces-786762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA945B3686D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AE81C4178F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C2350842;
	Tue, 26 Aug 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tdsfn3ZI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4034AB0D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217117; cv=none; b=LMhmg6ppHafdn1qlYTOweYnlNab9MR95eAtBInXVvjyRD15YToZc+joPku7/5+2wyklSHQMTz7guiKkYEhK8j/6tl5UI/rqsvnWEgoWaRbmw38n7f43iW7zYmkGvKyaIw7MoIt0T83iRbSyNLxHr3/nmay/FNWXzePePTMBbjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217117; c=relaxed/simple;
	bh=E47bQJ0fSKLMTa4+BbXXtJ7X4w0mQUaOEOsTXbSBPvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nN9dl5EQNuTh1PidYIOXuyX+/H/MOzolfaK0N/2z8DEcnQpXepcv9iUGKe7GBqoS9fPRmqi60TNaCHCRuj2CJR4zJ+myt5mJB0WNAY3lYL3wTWFPCNEunLJH1va+FBRe4kYxM+BRpAVhxKZRRLYtLvFAh+igj5cTXgpsn8/PsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tdsfn3ZI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2464dc09769so90500565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756217115; x=1756821915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8sjcZwofKG6BnJQmAymrI3Jle93znSmRx0EtubpPtg=;
        b=Tdsfn3ZILUtiBA0AQQ6P1e1sIjHJYzUeNBEm/wf838nYk2Ng3p/onkIu/vSx7DcRr8
         F2s8I6lJlMQuK6TnMRogZgpqr2ffnB8Mc2v36qjmk6lCEM4mfP7RfoxVfFxfaRYx8FDZ
         r9a8Os9nhuad8+HZX2n8DfPrQlKSueh0s0owNwgAPO5CDwmLvBN0SIA/IbZBuvtzVSwK
         M1hlpwC6ul9h2oiyP+HUf7MjKucb0zoVnLLhYpHFOlbSxBZrahssld5wG8W4Js/rHLbs
         4blIQAVFEhHz8g5X3eNY5/WzfP5GddN/pvDNk52y3Sa5T91VLUQD60VZtcmMMPn1XI2B
         kZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217115; x=1756821915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8sjcZwofKG6BnJQmAymrI3Jle93znSmRx0EtubpPtg=;
        b=IxEGddGwrMs9EUEs4qRSa73MgyHWBWzj2VnyYiNovVn63dLdoxp9MktF7TRWMXACT3
         1SNjjTUlKlYlt3HUuFHhmVuz1xGVNGGQMyvOQ4HzOg0wbdYfNPfLP1mgTd2aWdFmI4Qx
         pRO/f/qZ5D8QjNLpx4bQFRXHpUPw/AIQ0nDu3RcOtpkvac31oC0wsrO15wkDdzc1isiu
         yGtCykMm96UTk2Yb0E3SZI+2pzL1zi56bBNYoduHzcs7QPaC6aNRDUhVw3nzYYM2lwnB
         1tgfd6VPGhLwxutXupxEp3c1+aC/0um8dam21pIaLea07Y/CJbZzlEYFpwrKHNR6x0DS
         20Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUPyWSXsyGkUD2W6RRP74/g3ReD4tFICAdlToA0xY0tWIkeucxgF6cCRibZaEfoYYMWNh/7W0uuZ6mC2d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnoRgH3gTps6J9m281hp1DzK5uNFOjqLfKUKxq4CdTFwElZ/R
	GDQ+oFqnU2gUKkLeGlhwwyL19qQWIJg2gmvKWN3YoZ2aVJoqiiq4QGhrfHgy+Hr0OaF6Lv5jZp+
	VLOhn9g==
X-Google-Smtp-Source: AGHT+IGb7UTw93XDTXoLc3UC3K1e508fQEqN/Z8f7EWKzjedshJnEFb0jKrFZrSKXsmYFuidjgvX5MOYCtw=
X-Received: from pjzz12.prod.google.com ([2002:a17:90b:58ec:b0:324:eb0d:70e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0c:b0:240:9f9:46b1
 with SMTP id d9443c01a7336-2462ef3e955mr197406155ad.37.1756217115314; Tue, 26
 Aug 2025 07:05:15 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:05:12 -0700
In-Reply-To: <e04d31a3-3243-4141-88d2-1f0ade6d648a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-4-sagis@google.com>
 <e04d31a3-3243-4141-88d2-1f0ade6d648a@linux.intel.com>
Message-ID: <aK2_GMSYuPCXe1A6@google.com>
Subject: Re: [PATCH v9 03/19] KVM: selftests: Expose functions to get default
 sregs values
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Binbin Wu wrote:
> On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> > TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> > default values of certain sregs used by TDX VMs so they can be set
> > manually.
> > 
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/processor.h     |  6 +++
> >   .../testing/selftests/kvm/lib/x86/processor.c | 41 +++++++++++++++----
> >   2 files changed, 40 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > index 2efb05c2f2fb..5c16507f9b2d 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -1026,6 +1026,12 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
> >   void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
> > +uint16_t kvm_get_default_idt_limit(void);
> > +uint16_t kvm_get_default_gdt_limit(void);
> > +uint64_t kvm_get_default_cr0(void);
> > +uint64_t kvm_get_default_cr4(void);
> > +uint64_t kvm_get_default_efer(void);
> Can these be defined in the header file as static inline?

Yes please.  Performance isn't a concern, but as a developer, it's nice to not
have to bounce to a definition to find such simple information.

