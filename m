Return-Path: <linux-kernel+bounces-844593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B9BC24E7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F623B8953
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283D2E8B9B;
	Tue,  7 Oct 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4TC1DP3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB52D5408
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859685; cv=none; b=cGM5CWXtHuXVrsHwkrtW+iGfEiD2z4A+JvWtO5fF2zzp7wSL9r/XXEHO/Z+Btt4ENRN/sLfya8rskRP64MLuH9LRfov1c3NQlPl0snYF5IfiHBCrRxDMyWfNFZAr+qk+D6TTiVJQ58Q2DM5leWTc0xLCEQviaXTKLI3lgi0MGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859685; c=relaxed/simple;
	bh=2r0JdXKCeVe9VBGPBX7YgW5LS+LGefnDxCKhK7rrcWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/TyF2yUt3N44lhZTESlB6IXGcXzWo3OvKeSQAPc83o7axzq16ctkYGcBLMbXqwvdkFNOaQ9nPyc+7Whxkwn6+RDHEvB381M8YJSA6Dfd8BfzwxXTJStBwsCco+9x6qxaBAfwffsAmMtt88Di8C3r/pF4r15yLwnBaeb4PkAz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4TC1DP3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so6645043a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759859683; x=1760464483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiHdAF668/2CebNhsKGCc+Mo+khp6HCpNN5SRyYyO0=;
        b=G4TC1DP31jzmZszLxlmSeiAeeXguE/ByXAC8pFi0+r80F+/S+fZLQj/VHyAhb9IS40
         1lGOPJlcg8Scj1vPdFnXS/fO/U7tcOnuXfWXGVmWzGQAkXk//1uT4Z6PEGN/JDDetWJ1
         Ngp4QNLSoV+rIn8zQfKwLx1u0bbrVIVnJFNX+qDx4Ga23IA8UV5c5k2AOh/Pv0DtUpH7
         CzQkmJ9QiUB8GjojqoJ58u/v3/zeXOhUHorSuZIfL2X6rUpsN140FFUmVqW8f7Uk2Lgt
         /qyFKXMxawNtGBLs1IaKvlCjTh6vHedYYng2OUcYXWDcV/dROo1IkTauMTk5Z/PBmWIB
         M2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759859683; x=1760464483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiHdAF668/2CebNhsKGCc+Mo+khp6HCpNN5SRyYyO0=;
        b=GvOy9Jc1ZVANQaYffbTKqkNOStliewbLrJEHx/UolW+rBvWEslfEajDObqwXMCLrgm
         jMSLAkiFlCEummkJUNlSwJjw704J1O68C+fbvzsCApw2tOCQ2W6zamm19Ke2o2UDvfif
         CdadIQcXjL+6n9HP3/7f/bizzUfXcjQmxeopf8+OHPylktSczNqt+l79Xju4Bywb519D
         ALn0ycBbblQ4XlrYWq7K78yDwRCFd7SFiXLXlX9kfkz7EsaU4JlMOTziQO9OlySdBOL+
         aunbD//3ACph8cn+pw2pLufqFsGsSEdxZzNP3f1d8ryE6zUwooVQHsIukNH13Fu6sDZ9
         /GgA==
X-Forwarded-Encrypted: i=1; AJvYcCUnp84Jb4feSs9pr5HHCdLRzmc36Q85xsvtHw3vAEtGwHSjWH3q7uwFsZLFKWlkAOKve1USt+k2HRorrlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgNs3spNanmljCj6lehVhHUSAn+UoI0oeAsAtzNpz7tnBlBHiX
	0OCab4vJrmCAwTkH1ZrAIG1AVz/7HPLEPrOEuZbL8HgM0qb5sHlzmJ7xIlhiGqu9rPQ+hJheZyc
	w+jFx2g==
X-Google-Smtp-Source: AGHT+IGJlrr/LCzcUL09z20onDWdDhGAc1LfHCBGyLIEH4WKBfa0LY3kl4bE3fyFX7Z6M3k3Fcs24jbGwFY=
X-Received: from pjbmy15.prod.google.com ([2002:a17:90b:4c8f:b0:329:7dfc:f4e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:339:bf9e:62a6
 with SMTP id 98e67ed59e1d1-33b51129786mr472557a91.11.1759859683491; Tue, 07
 Oct 2025 10:54:43 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:54:41 -0700
In-Reply-To: <20250918130320.GA119526@k08j02272.eu95sqa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315031048.2374109-1-seanjc@google.com> <20250918130320.GA119526@k08j02272.eu95sqa>
Message-ID: <aOVT4VlumG01X0Hk@google.com>
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Hou Wenlong wrote:
> On Fri, Mar 14, 2025 at 08:10:48PM -0700, Sean Christopherson wrote:
> > Synchronize RCU when unregistering KVM's GA log notifier to ensure all
> > in-flight interrupt handlers complete before KVM-the module is unloaded.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index b48a72bd7b23..b314523d9194 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
> >  {
> >  	iommu_ga_log_notifier = notifier;
> >  
> > +	/*
> > +	 * Ensure all in-flight IRQ handlers run to completion before returning
> > +	 * to the caller, e.g. to ensure module code isn't unloaded while it's
> > +	 * being executed in the IRQ handler.
> > +	 */
> > +	if (!notifier)
> > +		synchronize_rcu();
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
> > 
> > base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> > -- 
> > 2.49.0.rc1.451.g8f38331e32-goog
> > 
> >
> Hi Sean,
> 
> Sorry to bother you. I'm reworking the hardware_setup() path in our
> internal multi-KVM, but I didn't see any usage of
> 'amd_iommu_register_ga_log_notifier(NULL)' in the KVM code for now. Has
> it not been committed?

Huh.  I completely forgot to send (or even write?) the patch.  I'll send one
shortly.

Thanks much!

