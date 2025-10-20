Return-Path: <linux-kernel+bounces-861338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D178BF2752
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73AD14E7156
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2AA299950;
	Mon, 20 Oct 2025 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he4OPorl"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CE2882DB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978064; cv=none; b=t78t6CVKr10Exa300r8Z8JR0a607vbt93DcsTC6E5BoTbB9HMWm1NgSWyE1LmuCpoNGkeR5sQAnt8TyBPD0cI4F85xwXhhC20BPgQ6yB0G1uzk4o1NF5jnMz7UO3MV21kUl/3cz5S5k1PVkBvnXS3agtN/9EKU6fgsZ5CPGjo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978064; c=relaxed/simple;
	bh=F8ZdKqCUkWnsHutIEohQCtijUBZ361J+n8QK9owT3uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=j+VAaTxA5DXCn54xYywrcJXjjhdvhPFvxF/BzPa1dmqf91Lml6dNW4a67Slz1v0WbqJ9ISmT9kBOqYTeCd/RShd2InZga2jlKdVrLxhAzTXJAp7TkhMHgaOzuJ6bVBbYIUTxAGCXS21Vsd677ZK8XQGd+WGEwa0QpqQIK9f9Wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he4OPorl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso5189607a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760978063; x=1761582863; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYQ/Yn18Ayoanetc7EMDhQDCxuQe3WF4K+kRhMHbYxk=;
        b=he4OPorl1MSCAjUR+EoQbxO+764x2Pzb9OfmOlbjcK8GF3Qqj5nApUNmafQX3BRO34
         N3B4iBTFoZgbJjqhnGgqfrOWii5G02LTM83eN/fmIeVVTP+/wRA8nfez4U2HsAkmBOKq
         nGv89b7VQsSFJWvcjVnmVwCs1fLyPWiHFQPbhzvW6N0zGb59UXtci+CZHYvK3DySmk4r
         FeZXLrMFSWUKewQNMwjLbXmjq9FTzl/VUe9yWQghti5Sw3Qh6iCciEniSImzyYLfOKT0
         mrBLGxdh2m8Me60/uvs+WVNE1Ab+8BhGgXL0wEW/CSv/55d/p6fXU1gK+HjH09J1UaID
         g3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978063; x=1761582863;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYQ/Yn18Ayoanetc7EMDhQDCxuQe3WF4K+kRhMHbYxk=;
        b=TwvZA2KE+736StAsOzAiVR2Yj16ddSas5NbZ63eYZvE4Hc6eIRslw4agRcxX0nQKU+
         Ooc2MvXsPLdNNaAzJ8/fZdV9oZ6OAmowh421wTHKg+oAhQuGpcOLPxqEf0eZAhDg4lGa
         A3aDKXh9C7fSQqK7bVH5E99tCojmRY8b7RyKinZpeuKiVBXK0EdUYPWxbVbBBkvVgv4l
         y+JzmuBP0tVxHtV70n5ovLvzS9egVUUf9ZBR7tZzhhZKZvZqaJv9L3zQMYToeiXo6+Cu
         e9oqjIMNz347pRG5S+sYfJWxDh4aGHpQVIkh5QxvZAJw1W9Yo6NgbX9Ry63CnpRXwTa1
         7yaA==
X-Forwarded-Encrypted: i=1; AJvYcCVsneN5nehnrtzV2q3j8q8iZnH5CxfCw/PvL4ZxKC1NkCF4cdf2JqvyX25felhGJWIiiVFCa//hxYurv1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedIPeTsma8E/Zg6IK1T/Yvuig9esup50xiRlvqK/3nf5WJySf
	SyjOydrCPuRDg4nQY5CjDXiijsSi1HJAeJdSW+vv+C2WGMPU2TZEzPp47LAM/AClbRuOLeRZVDr
	hfx3ZdA==
X-Google-Smtp-Source: AGHT+IHoYRl16lpIP+uyPt5I3BM/0tRyAePCPWMvseRm11XXxQgSDztnBAGX8rG9UOp1y8nNUE8XiktEjVA=
X-Received: from pjxd18.prod.google.com ([2002:a17:90a:c252:b0:33b:c211:1fa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fc4:b0:33b:b453:c8f0
 with SMTP id 98e67ed59e1d1-33bcf8f9008mr16976543a91.25.1760978062794; Mon, 20
 Oct 2025 09:34:22 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:33:07 -0700
In-Reply-To: <20251001001529.1119031-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001001529.1119031-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <176097608821.439830.10295341588067424162.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: SVM: Handle EferLmsleUnsupported
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	"Xin Li (Intel)" <xin@zytor.com>, Joerg Roedel <joerg.roedel@amd.com>, Avi Kivity <avi@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Sep 2025 17:14:06 -0700, Jim Mattson wrote:
> It is no longer the case that EFER.LMSLE is supported by all SVM-capable
> processors. AMD enumerates the absence of this feature by CPUID
> Fn8000_0008_EBX[EferLmlseUnsupported](bit 20)=1.
> 
> Advertise this defeature bit to userspace via KVM_GET_SUPPORTED_CPUID,
> and don't allow a guest to set EFER.LMSLE on hardware that doesn't
> support the feature.
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/2] KVM: x86: Advertise EferLmsleUnsupported to userspace
      https://github.com/kvm-x86/linux/commit/4793f990ea15
[2/2] KVM: SVM: Disallow EFER.LMSLE when not supported by hardware
      https://github.com/kvm-x86/linux/commit/c53c632592a4

--
https://github.com/kvm-x86/linux/tree/next

