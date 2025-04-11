Return-Path: <linux-kernel+bounces-600446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4BA86001
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9451BC01FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590C1F2C44;
	Fri, 11 Apr 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcOLjv6z"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7C1F0E32
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380340; cv=none; b=tp+j7WD1kdFZt0OhJnekjzVMoh/IHmzgSkoUbHWSwElM+zvEYMLEhYKmG3QbpSCHytWHYIMie2WwxXkl1Mv99O752iTG0Q60bs4LuV5yrNLXjAlnNnXMBb4kLb8NfwE2ZcVXo4UuYJu/T5fAJqwpnoPkPxOG8acBkeGY+2lsboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380340; c=relaxed/simple;
	bh=LcCxHr/aKoOVUR1Sw0imNBOIdr3QEisUuAtNnbOkc3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MQ1akdeYY350H+AOCm0hEyPu86Mte1sK+xmQkqfqBzjHy6Hi3lgWbWOQfOkTZuYIdHUI7BoKk1cErNmbWfv6nWcMnGsvNlt4MX/JSHzoX+Nk5KAGwyoY2vYYLKC7jxO+hetOFkTUcreMvF6sgiKQJjnZRhO9d0tUPPCG/3tL7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcOLjv6z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73009f59215so2324745b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380338; x=1744985138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NggdV5zQ72L1tKbHVRgRvou6wNmW0trj6aXwwFQdZyk=;
        b=AcOLjv6zsdWGPoKXTzKX6Wfo8td5Cj/it7tRnhdE2V2dl35BxJNqByB2MAl+JfL0L1
         UwoD/oM5BWOS8YvR8n1vGZXAHzGJdy97s3Cwk9AWO4+7IpRHhclhYqXK39h0Is2JtgYM
         BqRjNhj/vRp0Llnluk0dF/wwLLAFHdpUvEaVbradw59hZarHAp+hSWBeQ75873qwUDEB
         IHyAL0Rq9TQP4PW2iqSazvrMYnE6MrQs9z4l6RWBYqxPvD5N3PGZ9XKp0y6BHKX+aXPl
         8rQP4eT+oJX4ujVUeh8QAil7Nc/HxbqS5OlLtWYIlq4h0xSzx2rJtXOnebiHo6VpZ+Qv
         cvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380338; x=1744985138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NggdV5zQ72L1tKbHVRgRvou6wNmW0trj6aXwwFQdZyk=;
        b=q7YspsDYgxxkw4S/yjmI2KIx4XRtUxMp8wnt8mBvxRzoCniQj1djzGnn9J+vHAMY7E
         5DEKpYTOPRB1dFWCH4Ikc9O4f/e1Yv6IMYeqBJzAGfTwxIwEzRB0fzMvtQ0kqZxaNual
         adUTgubssX36mOrirQS9+mYf5g491beVJeGtyUjBCT+0t/nKCD+Dq3FA/3EtnN9+PmfH
         xA0G9LR6Lqep174UPobsmUXr7LLpEVJGyPxq4Mp13sWqxceyTWlRv1gU68WfS6pGbqBE
         AzEubzZN6MOzChh/BWxYoKfEam+xYK3ZiPY/0MmNiqL09RYi3/XIE5pPuoJ8+EVuEAIz
         ZMkw==
X-Forwarded-Encrypted: i=1; AJvYcCWpYAbwys6pqHEXNdrzyD5Ypz33knZf2uDXle+Utvlrkut5iG9aDc7+lheS/h+Q5J3Xb/WDEtuNS2wriyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CYGZHOSNoGf6Que6wiMfzfFc50+C0mhFfMdEqwyBoOUDWxIT
	smke9ZZ0xnMEdxgVFPpUQKosweVVsrrQTSztkSMwK/CkzOAMRwz9Luh3xQRzSVkhuBlWOIAkyNt
	Xlw==
X-Google-Smtp-Source: AGHT+IFjPBn8fKWi3Brtj7UOiEH0emgtsawhip261+cOAlJwse7965CBbiVxkrP/JH9W1Oa/e0ROd9eyYMQ=
X-Received: from pfbgj26.prod.google.com ([2002:a05:6a00:841a:b0:736:3d80:7076])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1387:b0:730:75b1:7219
 with SMTP id d2e1a72fcca58-73bd1202f32mr3762228b3a.12.1744380338381; Fri, 11
 Apr 2025 07:05:38 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:05:36 -0700
In-Reply-To: <686dced1-17e6-4ba4-99c3-a7b8672b0e0d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-6-seanjc@google.com>
 <686dced1-17e6-4ba4-99c3-a7b8672b0e0d@amd.com>
Message-ID: <Z_khsNAbh4kIhKVC@google.com>
Subject: Re: [PATCH 05/67] iommu/amd: Return an error if vCPU affinity is set
 for non-vCPU IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Naveen N Rao <naveen.rao@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
> > invoked without use_vapic; lying to KVM about whether or not the IRTE was
> > configured to post IRQs is all kinds of bad.
> > 
> > Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   drivers/iommu/amd/iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index cd5116d8c3b2..b3a01b7757ee 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3850,7 +3850,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> >   	 * we should not modify the IRTE
> >   	 */
> >   	if (!dev_data || !dev_data->use_vapic)
> > -		return 0;
> > +		return -EINVAL;
> 
> Hi Sean,
> you can update following functions as well to return error when
> IOMMU is using legacy interrupt mode.
> 1. amd_iommu_update_ga
> 2. amd_iommu_activate_guest_mode
> 3. amd_iommu_deactivate_guest_mode

Heh, I'm well aware, and this series gets there eventually (the end product WARNs
and returns an error in all three functions).  I fixed amd_ir_set_vcpu_affinity()
early in the series because it's the initial API that KVM will use to configure
an IRTE for posting to a vCPU.  I.e. to reach the other helpers, KVM would need
to ignore the error returned by amd_ir_set_vcpu_affinity().

> Currently these functions return 0 to the kvm layer when they fail to
> set the IRTE.
> 
> Regards
> Sairaj Kodilkar

