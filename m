Return-Path: <linux-kernel+bounces-606100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072EA8AACA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 00:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C598A441A94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967E25F796;
	Tue, 15 Apr 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV3Ao5fr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DFC257450
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754657; cv=none; b=oN4mTQx0rUSVg9sqrPAJfzwfw/YSewOAtl3xHesP2asMxuB1OL3V5hdYBh0UkjvjvKVf69fH0/7NRcm8z1vAnrKB6iyDPaGrq5QXMC4ufkpEnEFOvHjDlc0OMvjmZztnAzyWrzZAP8CZC8c5M0xJDTVlUd2fP9q4675MVzuOWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754657; c=relaxed/simple;
	bh=ccLH6Lx5JrbQyBvu+4aoaBT9iXuBHDx/w/Prtlwl4PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdLXmu06g1oa1PuJ/XTJZJtsoEihXpUpEOFxzU7kBnY7gwTXlCjV09VSnP8k/oGXICTpPB88HSxmKVmqHZ+O4ekHIV7538KI+yA8Hgvscta8vHSi/4xfVxCQyUjdybDp9Y+XBfZGeLGIZdVpG1M70tz3/RYvKl05a2Bv1Ydm/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV3Ao5fr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso7135671a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744754656; x=1745359456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wo4Okoh6l0stYAMM4y7IqfTAs0x9rsWfp3cuNWU2IgY=;
        b=rV3Ao5frF/RBbaeizp2QGFZ55VKXLrgsvdnYpn5z8CNLLNplsCA0ffaqhUgLu92U6Y
         xhDxTH2cKdlVHiCfNaqC2olAcN626Sn1pajvH5m2ShIyxPFfVNB5Albt8WoQaQPXlyfI
         hgbmR1pUtnkZcy2OxWcex2JxJ0RLpNutnSc9lNS1ICOs6W8tmxLIesYp4mLhe8cHir8G
         Q9AxEKaUwLTqrBiK8JnUX9PlO6QyHoDJsRRUWg+ng+zPfWyXRfHdxjd2vzd+ybJWeJnx
         XjfXZCges//qP1ezC2kEVuyW/lNrxjsZvB5tVKBWW2I7r4AemzyfFZqjM86cTn0UAaRH
         clrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744754656; x=1745359456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo4Okoh6l0stYAMM4y7IqfTAs0x9rsWfp3cuNWU2IgY=;
        b=mKvcOIC7B4+/EF/6misUYWmu6/InWU1ooDVQrP9sQxge1l8OEIuHe3dEiAQquM1N5R
         y4h9rPxwc926rlEH5sy5+WFal9xNH3K0OY4jR1i/qWbpwfkHUhmzwBfb7Budb8KcI2rQ
         lOm4p8CNrhb+jKsTTcB3q/dF1D9b+aRREP9n5SqcbyfOpL86+RdEQyjY8242rHQuvRL4
         7D7V8ckcL33YBMsqQPesKvW9LMtR5e25IZM5GLeLrh+lZwB503UYWjDUQG+kpZ/n2ecZ
         1WGyv212b1VZtnjbL40ydUrN07K89qFL9uEPPumhuV8fd+84M27Q87+60rh+Ngu2DJIf
         ux7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjhULUeJ9pA71yrACO8iIXbhdA+Mhot7Q9HupfXBfCnOsGjd9MWc+qNv+vK9Y10ZgRwhIhv1vzvj8Esus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nROlnHrlvNySLxJmZlB/QFiEJ5yZHM5jpZ1sXfavWDcyBr9t
	F71Qt8T5CaF3FKVhLEyT46KZ2UyneM/tgl9ORnWXQFEwqr30ybmkvuCALsHb9B8eBU/8VnvA1M5
	LYw==
X-Google-Smtp-Source: AGHT+IHFSR2PN9qWnpYuo8R+JF0mYE1/E0Gt7NN0o/QNrpDTn7/4htyrrEr0PnokOWhJQ4DnbnOqrhm7918=
X-Received: from pjbtd5.prod.google.com ([2002:a17:90b:5445:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274d:b0:2f2:a664:df1a
 with SMTP id 98e67ed59e1d1-3085ee7fd3dmr1242998a91.2.1744754655773; Tue, 15
 Apr 2025 15:04:15 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:04:14 -0700
In-Reply-To: <fcc15956-aad0-49ea-b947-eac1c88d0542@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-7-seanjc@google.com>
 <0895007e-95d9-410e-8b24-d17172b0b908@amd.com> <Z_ki0uZ9Rp3Fkrh1@google.com> <fcc15956-aad0-49ea-b947-eac1c88d0542@amd.com>
Message-ID: <Z_7X3hoRdbHsTnc8@google.com>
Subject: Re: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU
 affinity without posted intrrupts
From: Sean Christopherson <seanjc@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>, 
	Naveen N Rao <naveen.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 15, 2025, Vasant Hegde wrote:
> On 4/11/2025 7:40 PM, Sean Christopherson wrote:
> > On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> >> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> >>> WARN if KVM attempts to set vCPU affinity when posted interrupts aren't
> >>> enabled, as KVM shouldn't try to enable posting when they're unsupported,
> >>> and the IOMMU driver darn well should only advertise posting support when
> >>> AMD_IOMMU_GUEST_IR_VAPIC() is true.
> >>>
> >>> Note, KVM consumes is_guest_mode only on success.
> >>>
> >>> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >>> ---
> >>>   drivers/iommu/amd/iommu.c | 13 +++----------
> >>>   1 file changed, 3 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >>> index b3a01b7757ee..4f69a37cf143 100644
> >>> --- a/drivers/iommu/amd/iommu.c
> >>> +++ b/drivers/iommu/amd/iommu.c
> >>> @@ -3852,19 +3852,12 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> >>>   	if (!dev_data || !dev_data->use_vapic)
> >>>   		return -EINVAL;
> >>> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> >>> +		return -EINVAL;
> >>> +
> >>
> >> Hi Sean,
> >> 'dev_data->use_vapic' is always zero when AMD IOMMU uses legacy
> >> interrupts i.e. when AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is 0.
> >> Hence you can remove this additional check.
> > 
> > Hmm, or move it above?  KVM should never call amd_ir_set_vcpu_affinity() if
> > IRQ posting is unsupported, and that would make this consistent with the end
> > behavior of amd_iommu_update_ga() and amd_iommu_{de,}activate_guest_mode().
> > 
> > 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> 
> Note that this is global IOMMU level check while dev_data->use_vapic is per
> device. We set per device thing while attaching device to domain based on IOMMU
> domain type and IOMMU vapic support.
> 
> How about add WARN_ON based on dev_data->use_vapic .. so that we can catch if
> something went wrong in IOMMU side as well?

It's not clear to me that a WARN_ON(dev_data->use_vapic) would be free of false
positives.  AFAICT, the producers (e.g. VFIO) don't check whether or not a device
supports posting interrupts, and KVM definitely doesn't check.  And KVM is also
tolerant of irq_set_vcpu_affinity() failures, specifically for this type of
situation, so unfortunately I don't know that the IOMMU side of the world can
safely WARN.

