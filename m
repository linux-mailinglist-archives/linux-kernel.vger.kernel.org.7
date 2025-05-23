Return-Path: <linux-kernel+bounces-659934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC87AC16F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA7C171F04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D74288CA9;
	Thu, 22 May 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+mAW5sB"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBF1E5202
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953948; cv=none; b=VEAwIZafZURHpsalfB+bmxIE/LqW9vYUoDvDLU1YwcLgQMP2feojW3RHy3PsD25KYqMPnuUjN/V5XRORu3HPn8LKmCu24e3mvYgBnsPzmnaoPAWihuuNBXASrPPDknY/eYQQQmAgVoHo0DlhITBOpVZG+ZG/LkpNTQ/ePiLvLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953948; c=relaxed/simple;
	bh=/4BQCi3jvtdajWus3hg8cgl7J4SS003mjq0vewuYalU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUKd9Be3T+F7XOeXDD/RSemsTNSLLt1vD6h5UnLXOmuW7oORU+uc1OOMckzSgf6/vsg5/Gigk6JdTmHzg1Tmoyw6A1VfUyjJfBZqd2xvjQaPHAntCORRc6szZgj5efFgpbSFx7fl4NSR1dO4S1V9WzyTrnRtHdYDe4M4EmTpSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+mAW5sB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso7313308a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747953946; x=1748558746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3AxTb6qkauANJSLdkn2Rljd6hCnTnUjzlT97QXyndHU=;
        b=v+mAW5sB08j8mcvPFv1etBdGmFTXF+tdNSqKzpIpP5PjfLhbNj4ayMDx3u1XwERfEo
         exB629+dvS3UypmzpkZL5FNmBu4ucDdrTYOdk+ODGw53ba0S6hBN2PV+bkqRen0o/MrB
         xILTh5r2U40UKdvarjrYe4orlNKiFMdMc7+n2+PbstsVI1DTOh234Ak4Zfdsi5nzmrTD
         UIEhVLYo9K57Ht1yqfdaOq8oLfuuYuSGtzQahHI7soJrXKqgf3tWOoqJ3OUXK4jkAFpT
         Zq7ao+GnLdyalnA05grjWnIPHQdK7hocRgf+/YE7mNpWPiPCfKUwLB6bR7XBN65XU+hP
         PN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953946; x=1748558746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AxTb6qkauANJSLdkn2Rljd6hCnTnUjzlT97QXyndHU=;
        b=r62Cvx49uN6vJVvK56z9dN34sCHK4/RSDON/dvndUffBU5kVuw5E9/88IlCRri6VeS
         hVvKKZuM3tKFhPkQI+IUHMGx4PdcJoO8JdR/25P4AKx9eOMxIJ1HmDYjA2ed3GELiBIn
         W2zi8TAdmCEUnVpv+8Kg5aAuiS0Wd3I4uri4pH9mrvbyiLyEZ8w/nTewToNRJm4VNsVs
         N1xX9GBiur7xqb+ixIlYNWv+/Vm5JaHyZhJkxFlf5gzZ3LGu166kho7iT+iLPBzy5zdb
         VvxwkWPnx3iI5e+IOXtQ46X07l1QB9Cth80mmwPkJUH7XD6xVFzOmsRUZsbsTE9HvDFM
         Up0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9qeEuOyY3H7peJ2EUUBTnhhiPwyHYuKh11bkOfWLLcSAFB4DQJfF9i2IhgVcXCvM2imU2xcvWkDB2ZmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qbZmUmEpjvdOp2YgrTvro8jXOohA5rgSpnmrNBSsMkS2NWC6
	G2+bUL+2TnosyZWUjGrNJKtt7hpQ68U2Kjd2JxKdNj6RLGXrdFCZulgx9/Z23QUeVD33rnyaGS0
	qDsHVHA==
X-Google-Smtp-Source: AGHT+IFNKqqHdblFbUk9DQFGyS5wY/y/pndJWF/GWniPdnZ6giU/V86VRHJVAeoJpjay+iWJes8jG/Z7ph0=
X-Received: from pjbpm9.prod.google.com ([2002:a17:90b:3c49:b0:308:64af:7bb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c90:b0:2ff:6af3:b5fa
 with SMTP id 98e67ed59e1d1-30e8322592emr33592948a91.22.1747953946139; Thu, 22
 May 2025 15:45:46 -0700 (PDT)
Date: Thu, 22 May 2025 15:45:44 -0700
In-Reply-To: <aC9npqQAAdowxfsn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522005555.55705-1-mlevitsk@redhat.com> <aC9npqQAAdowxfsn@google.com>
Message-ID: <aC-pGA3Xv3O6STuJ@google.com>
Subject: Re: [PATCH v5 0/5] KVM: x86: allow DEBUGCTL.DEBUGCTLMSR_FREEZE_IN_SMM passthrough
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 22, 2025, Sean Christopherson wrote:
> On Wed, May 21, 2025, Maxim Levitsky wrote:
> > V5: addressed the review feedback. Thanks.
> 
> I'll send v6 later today.

This ain't happening.  See the conversation I'm having with myself in patch 3.
I do have a refreshed and tested (ignoring the nested mess) series prepped, i.e.
no need for you to work on a v6, I just won't get it posted today.

