Return-Path: <linux-kernel+bounces-824696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3FB89EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D1F5846F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA651314B64;
	Fri, 19 Sep 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siktNYbf"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD97313E3D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291922; cv=none; b=diktS6D8UXoCPlo9V/D5yfHOyUc2Vytiu6Erzdzkq0RxuQyCxiwLzd8n11zTTToQ8AzI1F+/+hf4IEQSakxAhV9Hk8HOdNQE37dYFaSI3vevFUGxwSpOZCbG7A+prqDqRavR/kaTcxn3RhchkJG+nKKnKagF4ifbggqc5zhTVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291922; c=relaxed/simple;
	bh=7W9wumr16Wg3vvyAELbNqNIP362OxWQp2AoZc56V6Nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LdNeC6Jyv38MRmwN5n8GZ7X+KrCjetXfzRVGH7keMBOXFholwB97TBnmMEvr4XLnGYnuHXXc53c5CiJHGT1oaVYAp94/N4Q17SBOpdXBL1hTmeqTMTS2d93u48t6xhnuahQO0XFOyBWqvDULkqgiFED7jcXmWG1kVC6rPm5nQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siktNYbf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7725c995dd0so2181870b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758291920; x=1758896720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es4wbZQJbCTMrRymYAsVRRwPE+x7eh/fwfma+fUrYSQ=;
        b=siktNYbfmSuPcOljG1/TcozWlHTVO5loOaAYMt6qcc+gQcQSqyognOLwdqMahOCHsO
         sHafcSYF6sp68CEgsHln6cl8hDwripNzPcSQnZGRfV1gjWOrv7945oc4TNNZg9tz6KBB
         I/rVplr2FF/oUvrsS7tsYkmn4dhDITNC9A5plVVRixYZxDYoRGidWJFP+ELWrsO2nb59
         E5mMY5NSRPAS4QWNt/BgZOJxsFXMf0bzmV1duYH+RHUF2kprSJkaXuxsCUl75TIUDNcn
         v+rG/pIEV1LKLyr/E4NR+f2vdo22Qf9Hp6k9vbWVq2QmtlKZp+OW9BmfUZnibE3QpDqK
         Z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291920; x=1758896720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Es4wbZQJbCTMrRymYAsVRRwPE+x7eh/fwfma+fUrYSQ=;
        b=NMYeTdo8KvZHCq7BHy0ypQFsAoTgBgR69eJ8LgfmfFrQtqcsEaRS/5XCEH0B+C1lV6
         KOHlhYOz3LDJhHIV2zd6S/j19Y5h6xIZqUxCILcLyovOFSJ9b8Nu8e5pT1HM6dpNSg8l
         uRAUUNwo2i5DFBtQOZrZ+IQBR2BsdOiZtFs6JXomnP/lCJebdhKrWu1QJ0xpGNmoPIsE
         Cpd5k2ud5k+gFN7U6lhHcnddoWJkYH9nu0k1yJJzufe4ST4zVyaJED18xylTXgUXR4Dc
         Fha/GR7vQwOd+y3/f7LconES/+cl9eClDRzv1kIWq3gCMzVIKAhTZpQ1NjeCUDlIUkv9
         Yoxg==
X-Forwarded-Encrypted: i=1; AJvYcCXbXt2qn4CETqeRIj9XmJZgdYbQGuxr748C5sNQ50kgpXTygiwhBg80kk55PIeeH6iSXDtIjN/ae0c3OMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQcy7dIdMvigKYQ16ugvKFpuwU/xuPnRCOQYotOouCwJMUUK3
	xwLhZdGhC49djLE/Woli6pa/2OwfgWAH7IWxl0m1Zki0ymkhjQla5oki2JlZqYccHnMBHbp66mV
	7QXsnfA==
X-Google-Smtp-Source: AGHT+IFkOCaOupHcOkaXlHgn3Y4agoGfsg6u9VbIjaB+GyxpgmVATWVgXTBSwUQQUyL8VMUgJ9cUfq4k9rs=
X-Received: from pjoo3.prod.google.com ([2002:a17:90b:5823:b0:32d:a0b1:2b03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9150:b0:246:682:83f1
 with SMTP id adf61e73a8af0-29271ee19e2mr5659020637.43.1758291919771; Fri, 19
 Sep 2025 07:25:19 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:25:18 -0700
In-Reply-To: <9cedb525-a4a7-4a84-b07f-c6d9b793d9db@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-20-seanjc@google.com>
 <c140cdd4-b2cf-45d3-bb6a-b51954b78568@linux.intel.com> <aMxKA8toSFQ6hCTc@google.com>
 <9cedb525-a4a7-4a84-b07f-c6d9b793d9db@intel.com>
Message-ID: <aM1nzrldhASNKqOn@google.com>
Subject: Re: [PATCH v15 19/41] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 19, 2025, Xiaoyao Li wrote:
> On 9/19/2025 2:05 AM, Sean Christopherson wrote:
> > On Thu, Sep 18, 2025, Binbin Wu wrote:
> > > On 9/13/2025 7:22 AM, Sean Christopherson wrote:
> > > [...]
> > > > +static inline bool cpu_has_vmx_basic_no_hw_errcode(void)
> > > > +{
> > > > +	return	vmcs_config.basic & VMX_BASIC_NO_HW_ERROR_CODE_CC;
> > > > +}
> > > > +
> > > 
> > > I think "_cc" should be appended to the function name, although it would make
> > > the function name longer. Without "_cc", the meaning is different and confusing.
> > 
> > +1, got it fixed up.
> 
> May I ask what the 'CC' means?

Consistency Check.  It's obviously a bit terse in this context, but it's a well-
established acronym in KVM, so I think/hope someone that really wanted to figure
out what it means could so with a bit of searching.

$ git grep -w CC | grep define
svm/nested.c:#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
vmx/hyperv.c:#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
vmx/nested.c:#define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK

$ git grep -w CC | wc -l
156

