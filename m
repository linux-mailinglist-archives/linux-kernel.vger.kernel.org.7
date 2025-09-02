Return-Path: <linux-kernel+bounces-797091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D96B40BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB697A3C58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1C341ABA;
	Tue,  2 Sep 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJVeEJGY"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122523D7C4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832997; cv=none; b=mXKDlcLsKBKlzntme7s4x5IwNmaT8A8h773eVA78OI9d+lhwGEwHq537Z1K3r6uqmB0TlQnxVNcWBlzO7n5BbZSrCq1hJwlGeUZ6Pmh4JV71jW+b8nHpKJ1ktv1cjH4JXoOeTOQu93bDoCaTdxfAdxS8NIqvFkGZYAioTiykbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832997; c=relaxed/simple;
	bh=Dq3iaEisaR2x62gnenzJxtkdCglLNtO7PgkfHaw+RaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZbLUZ43R7+X1pW9hyNrEjypkKbl3jb6O0wn9V4AaAU2vWBRPz6fG7mXi8KJE6vLqlBfBuBt9ob874ZsNP07C3aMDZeBD3u8xQQ/TjfoUA8AuM1tdlvCY2ej1YF6DtTzliAfjyGYNDUN2+7YcEh9oGnR1Ds8/xIApWDihGeZlxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJVeEJGY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so7984336a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756832996; x=1757437796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4AZbfkCmZQBVaKpnm1tZ59PjsZ5ExHlWjz9wa+l5ls=;
        b=vJVeEJGYZ/la9xThYZQ0o1biow7eYNANMFmNPMI1h7EzhYzuy+GFnf43zhJeafcgk4
         7JTdzHsgf05ee8xb+O554tR4Pgxuzmpcn4mF4ciBoqxKO+f7Az9gW9BrE+bnb48UTIcD
         cT8rNymZWSyMJ3UU8ldDW15ScEmyr5bosVXNZTB2jIamd7y5LbRZf4cxpmD46ITMZnwZ
         CywMQyTGs7JLjNbf49MhYU4z7NxCZaHJ9XSXFnZ8YRZ5KUWnMiUMzH0xZoelds0j1hGR
         gisKV8YiNLeNox0R2HePlnixqrpCFJpVXyBUe6OuWW4DGkehrKVs4zcK/5HYp76tEo1D
         SuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832996; x=1757437796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4AZbfkCmZQBVaKpnm1tZ59PjsZ5ExHlWjz9wa+l5ls=;
        b=lpaMDScDEyRtm7cgOgLnNkOHpFewn3S9eTi4KOKzi1uDDOTfkkd5t/ZHQ97YVXOZwO
         3i/uepFSAa2rIg12tW3pe9NkZMb6bYLzFHMy908SWX5S23MiXIYUJAoaG6S7/210ctYI
         RBTB+SBzitxSCriAF9NVUqKZ1CUGHeSS/ITDf1omIO57QmeLV8bTO/VQ1cxRqU0iyllI
         SMIrG0YYVgUZ6UYUUWoxvk4DEObvd/rEcyWyM5J+2/SG4lDe9HmHRqlHKL8f3YvA91w8
         QSg42YgkAMytV5621ZUBQ5tO2v6zOs1LV6eaP6yeIcb8GT+yrFXB9oLPqJ44bOjDjkiZ
         vX+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsMv998K2p6HZA/qXyNLbeo11AWb0eyLla0zidwo43YDU4yyXaEvLqRy8AwbkTBOsJSU9R5NHB2Npvj1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dk8lidrdOJsw9JS45FqGIPNWrP7RhoJb3QCWXevczAGYSSDh
	TbnqjZe+rCzvEFdm0Hz8BtF/Q7Bq4GEe1DpvJorusoFq8tD8qEwbffV84Dv1eqrfZNSTNSoidOh
	eO9Tg8w==
X-Google-Smtp-Source: AGHT+IE/xXUwYFqm7bMkauyv9aS4cZHKZ9pDqM1jFJCql7JTSLt/5PxhMaqsUuPRbVGEgCYaZQcgrlSZv+w=
X-Received: from pjbpq14.prod.google.com ([2002:a17:90b:3d8e:b0:323:25d2:22db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d40b:b0:327:a04b:aac
 with SMTP id 98e67ed59e1d1-328156be03emr17012159a91.24.1756832995881; Tue, 02
 Sep 2025 10:09:55 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:09:54 -0700
In-Reply-To: <17ef5f493d5ef6d76c4dc9ca19f1d4d7fe4c73f9.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com> <20250829000618.351013-14-seanjc@google.com>
 <17ef5f493d5ef6d76c4dc9ca19f1d4d7fe4c73f9.camel@intel.com>
Message-ID: <aLck4twmLDTtiewI@google.com>
Subject: Re: [RFC PATCH v2 13/18] KVM: TDX: ADD pages to the TD image while
 populating mirror EPT entries
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Rick P Edgecombe wrote:
> On Thu, 2025-08-28 at 17:06 -0700, Sean Christopherson wrote:
> > @@ -3116,11 +3088,14 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >  {
> >  	struct tdx_gmem_post_populate_arg *arg = _arg;
> >  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
> > -	u64 err, entry, level_state;
> >  	gpa_t gpa = gfn_to_gpa(gfn);
> > +	u64 err, entry, level_state;
> 
> Fine, but ?

Yeah, accidental copy+paste bug (I deleted several of the variables when trying
out an idea and then had to add them back when it didn't pan out).

