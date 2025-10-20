Return-Path: <linux-kernel+bounces-861269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD7BF23AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C073B7D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664BE2765C4;
	Mon, 20 Oct 2025 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKfmWVLF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D716258CEF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975514; cv=none; b=HEsrf4Pa0whKBypjs2nZMkOem7lvFhpaxWisf2JwS3VO1N9ojoDaxqWfrUu302EJtdCXH7DuIfh7aehx1DCnDfQBfgka4of/ozRYvh4H1onu608etUXSB8OuFwZpXzted79ie26NgeLKz+b5zXc6ko7oSaY6rB+xx7UTH30tGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975514; c=relaxed/simple;
	bh=oz4rbRabZgNqmAFUctyfIcECGNy5RKvN0Ppphwk3EPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fY3aIA/5YwYl2b0rhCK3Mpp8ACaEzVnLgUjlMbxPYI9+v99yoQrBreVu8RwLPDML5zu+5OCXL7EGcYhgnH+d5spCSlh+inuo/3DekZJ+36CA2cDLsgqJLy0+X+A5CAcZt7L5UPyFeSwpo3uOho65ZUlTkQEpcl86gFARng7M4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKfmWVLF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33c6140336eso6782207a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760975513; x=1761580313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToAummVDahhfvKCzkp0wJNL/Qv1mvIGVT9i3zLaA4is=;
        b=LKfmWVLFZNtV/m6IaHkWxfFmY9o1LqlXd0NhpMcTuQPWXHFgI7WGwD156fWwIfY7tM
         GRN3ujSREYkOm86Zf4VBf8mcKt1ldusGxYIR+nZvFvtxCWibI8LXkfwRDcKXLMPjvsgx
         pqEKpzLhvLE0hN1puRbd6XximZJGbkZpxi269RsF0Euz+nQ0SdMDGT4IAOvcgW3OB/eL
         +RGQP1dTImtyvbFOEaCB0+TE9woy9eOgnVo+OTYVL0yMRMaQu33H0nUW8LIGLgWhTXzo
         ZizLweTK5T5fPRMxNb8yuwqjxA9U6324vtewmAMS+ilkkByxb7n44QV6I6AWMZzDusXu
         d1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975513; x=1761580313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToAummVDahhfvKCzkp0wJNL/Qv1mvIGVT9i3zLaA4is=;
        b=KFdk6afeTk6Lo79QUEmeD5ne/F/1fdO0cRb4axhX2C1n+rgY8kAOVPowZ51Al5oTHr
         KYh15d6gA+BoCtDLUebKxKmlI8pAvNpuFFHk7q3OjHKZC+8lY5BmhBxo0URP5datHF5u
         95hfIIFly7uLYwitcIx/2VDSACVpAnJFVMGl9lNOU1w3OKXVdM9SIa7XnQmQH6p18KEh
         3adi05V6Ouza664UQUt/q+0t/ayrEpSXJ5ZOtMphAP1M32P0ra6wy1z3fxT6IuJb0W25
         5UjlGKCbyEWwlAKUCmAA4sQXKUvxKuPqYxbxZ+JVf4SkEHDcpaUQWeLe3FKjUsxbBlzy
         9r8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNkyCPFrnK4wtH3cK4V3/riTlb5iLrcV2iWddJIPgfrFP5zJR864rglTIVcnVAUgBUfxhi6Qv8pGwoY0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kPsnlGtX4UPI694nskU4tA3kFvN/wGAMQaCE7QXzX+iPT1zU
	PePtUoRy7HmLZnnlgnHEXGBgI+6xtQ0sMixJl618IO/MFBbNjMgI6kSyl4qcPBFoNwGQS55Qcb/
	zzXmEUw==
X-Google-Smtp-Source: AGHT+IGARn5icvNN9j18LGHQOhvizTfEF6rFXz09j/YBOwsyeY7uOBIzpTPtLr+vUY434eU5cL21Mst5QKc=
X-Received: from pjyd11.prod.google.com ([2002:a17:90a:dfcb:b0:33d:79bb:9fd5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec1:b0:32e:753d:76da
 with SMTP id 98e67ed59e1d1-33bcf8fa157mr17983340a91.20.1760975512846; Mon, 20
 Oct 2025 08:51:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:51:51 -0700
In-Reply-To: <176055116678.1528393.4651749265873372559.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251004030210.49080-1-pedrodemargomes@gmail.com> <176055116678.1528393.4651749265873372559.b4-ty@google.com>
Message-ID: <aPZal7r0joep0wl8@google.com>
Subject: Re: [PATCH] KVM: use folio_nr_pages() instead of shift operation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Sat, 04 Oct 2025 00:02:10 -0300, Pedro Demarchi Gomes wrote:
> > folio_nr_pages() is a faster helper function to get the number of pages when
> > NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Applied to kvm-x86 gmem, thanks!
> 
> [1/1] KVM: use folio_nr_pages() instead of shift operation
>       https://github.com/kvm-x86/linux/commit/fa492ac7fb04

FYI, I rebased this onto 6.18-rc2 to avoid a silly merge.  New hash:

[1/1] KVM: guest_memfd: use folio_nr_pages() instead of shift operation
      https://github.com/kvm-x86/linux/commit/765fcd7c0753

