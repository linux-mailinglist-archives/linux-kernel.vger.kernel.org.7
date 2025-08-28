Return-Path: <linux-kernel+bounces-790568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61806B3AA50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385C617CB42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09630F922;
	Thu, 28 Aug 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLLMsTcy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F727933A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407054; cv=none; b=t+cqb4C3v0qO1cC+wsMhBfSKDB8+hpnyvksuFzRm/CYzTszPzwnG9YIx//YX5tPKgZQ3ztkILDB+D/Sn+Uaev/L3mGwCnehWDuB5gOFU1yJXRcfgFAZyvhUdF4BJ+DeNWPZz4KDmDW6hla9Jpy6lVjhS8ruhh6x3whYqLO3jG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407054; c=relaxed/simple;
	bh=uMprsLdlUZHVQH3p/izRIbHQDv3IWlBF+WIzCbkppXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boSEaLDcS0ZqsE+FfH6EKX16VwuxBTrFsedMiD4mlu7VYJfTqIKwf7ePygAGKggUwUIYY6x2BnbTWVMAfTBKvumSN8F9kF1iaTZndwfEyiC5cSrb1LLHyfM5CbfVU5pL1hErrv8nmrQnQE1NKQgirvh1nfgmY3HuC0vXJPNH23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLLMsTcy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24680b1905fso14256205ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756407052; x=1757011852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1rw97Jv7WO8rIxCRP/6iXIaLlr9MH2m86cuFa/MXV0=;
        b=NLLMsTcyMWs/HOIzSJ6XuaKXxtIyr0SGVrLBq69kueRBez0WcwQvAZoG9WmODTOIzD
         xiZkTXFn3OeOOLhH5Ef1Nqab1hal1v+lCOMJOq3UTVkqFtCI58Icq+/mfr9YMJINy4RF
         XHM2dZVv+psUwCzO0yWOOCmP+YTWtNc1D9N/nSfd8eOoDEJleBKr3u7hYrC8ip1U9PWz
         KBdDXh+y8cUy/phHeRGEp4hlYhrGxSbrCj1i/5Lhul5JhEATTUZKLKUmNtCEuDQQhQs9
         FWmM720MHRy0+QQSbMev7ssXelo4HSA7yfo2x7dwcfyDpsZFjWYOHzhbrvpKNORFQLln
         mvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407052; x=1757011852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1rw97Jv7WO8rIxCRP/6iXIaLlr9MH2m86cuFa/MXV0=;
        b=w7xbwCrsgy8et7laGxDE24BRmFlRAAbGoXY4bbAlxgp6xzkXfJpIdwk03vT4s/quVg
         8Thrm4cJt8E8UEgVSWgQ7TD4QoT9jqwDnipdSMJg7gqBSNShdajuJDIUbFsd6aZ7Z63m
         ui417oEOCpkbR+pRMcdwgHDPyCHplej1rL19cHtbupAuYjsl/3tLRtAsRTfeVRl8ejFf
         Gueb7hwInByR/UyPu069fUbNtiwYdWlOdhNReCD9kwS+DqvJukzRfVw86Pai7ZKZaJtX
         5jDrSdQrItnRXCud1qHkPUdF05YqnxktpsKSHfrFu6kCynmBWyM4ev9R3U4IT61tTVk9
         rg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVqbDSp5la6FmMLyyiGu+vZ5SPZTTB/K8XfA4qXzf8HiQMFGTw4v7jB+GFSKo9kr4yD30lTrIV724keQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPaGOrMSJDbi0aLKdOYm63aKWQKyTfkzaP+nzghs9sTNZRxLy
	JXDwBMzyGFAGsiETOfkTFwREGD2rLQwlWWF5aC2/9qfjP+27WD4IFFZBsZuAFsHYiBa7roZn11Y
	afTdSYw==
X-Google-Smtp-Source: AGHT+IFZtOIBWH5nMa6NGPW/i9RAPDOqQQExWvsrON8HpUDCdiJQCG7zSV6Pl3SHf9QVpQqLPeYiu0FYvRs=
X-Received: from pjbeu15.prod.google.com ([2002:a17:90a:f94f:b0:327:be52:966d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c410:b0:240:3f0d:f470
 with SMTP id d9443c01a7336-2462ee50129mr348989685ad.20.1756407052469; Thu, 28
 Aug 2025 11:50:52 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:50:51 -0700
In-Reply-To: <953ac19b2ff434a3abb3787720fefeef5ceda129.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com> <20250827000522.4022426-5-seanjc@google.com>
 <953ac19b2ff434a3abb3787720fefeef5ceda129.camel@intel.com>
Message-ID: <aLClCzTepEk7bczL@google.com>
Subject: Re: [RFC PATCH 04/12] KVM: x86/mmu: Rename kvm_tdp_map_page() to kvm_tdp_prefault_page()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 28, 2025, Rick P Edgecombe wrote:
> On Tue, 2025-08-26 at 17:05 -0700, Sean Christopherson wrote:
> > Rename kvm_tdp_map_page() to kvm_tdp_prefault_page() now that it's used
> > only by kvm_arch_vcpu_pre_fault_memory().
> > 
> > No functional change intended.
> 
> I realize you are just trying to do map->prefault here, but "page" seems
> redundant once you have "prefault" in the name. Why page here vs all the other
> fault handler functions without it?

kvm_tdp_prefault() feels a bit ambiguous/bare.  Many of the fault helpers do have
"page", it's just before the fault part.

  kvm_mmu_finish_page_fault
  kvm_handle_page_fault
  kvm_tdp_page_fault
  direct_page_fault
  nonpaging_page_fault
  kvm_tdp_mmu_page_fault

  (and probably more)

How about kvm_tdp_page_prefault()?  Or kvm_tdp_do_prefault(), but I think I like
kvm_tdp_page_prefault() a little more.

