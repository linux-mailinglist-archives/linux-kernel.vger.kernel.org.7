Return-Path: <linux-kernel+bounces-744349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C0B10B72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A7018846C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3C72D3229;
	Thu, 24 Jul 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sBckWNT"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD3BE4A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363911; cv=none; b=tsjSFUpYnQ//+tfAJf3AXkyqXKIc9oZmb7Q67+caEsGXUV7QnGpmi1Xv6E48Z7A1dXs3LsepMYOz1jpH5c+XMX0dTQG7q9eGPi/iDQ5jXY2sjJE7Ymbw8mta99r7yqbP78txjcbqFWJ26hpKIJv9UZpi9D3IcuNi5aHYFFAMrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363911; c=relaxed/simple;
	bh=gJVEnKD+m86/Uy00KKGOC2HsXj1DksP0pHClj72P4RI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCEKkYBg952EeidaFr/4BGAkXSVepATxOBAkBbTrWPnW5dDF9Lf9tPoOoWh6h1Nu8Bqu76gQ+JYAhZ1jUkIaGtvW4LqqAF4xG4FFF7HrK735Ss0iovFWv8S4+DBkoe4qFxto5WlfC8kXLg34q2aQ64HImkdorrRojxvQE/sAh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sBckWNT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so1062987b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753363909; x=1753968709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+//CxCRIZc81uvnzJthipR4khrLAZAMHtnmjaKkETc=;
        b=4sBckWNTMET7dm4fucNTlZXCkUi0DMq+yr/O+N0Y3JVgx31NxhQTzktadiEzZV4V1k
         jzAk3zEQsaX+s5P2g0at/p/Ym8d8nY064n9sVmZ5JdXKb521ER7Nqq1/cjQZWwyE+c+T
         oTAEyeJz3oFT/LrxChc6z8hpFvzJ/IK2t6dPnAjtk7P5rvv7e6VAEbgTjtjV159L0DdX
         e7UcKQkcEscPm/G88kkERgIo9sKjP93yaH8e09gZ6EVNuEgV15IJSSzvF4yrzpm1WvYh
         cCvcsmfrXV+JCEb6CJ0Eu7y6sv7988vFS3M6yJ3f7kmAQHhEkdE5qPctz6kmmKVciDDH
         7vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363909; x=1753968709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+//CxCRIZc81uvnzJthipR4khrLAZAMHtnmjaKkETc=;
        b=FI2JDvshz77+fgoAe1W0chlgozmSPpCpB+wEdh54kP1o4S3IqtKHA5IreLRa/Qutip
         ntX7wEdmANlewUHBOAoQExFCakbMTevycSXeEDF51Zhi6WMwumZYP5vL+w040A7VIa24
         Lb3II8KDGXI3AK3qYOXjDqxwR05vEBsrX4z4cfAvDplxAtZcNu1MltjhRVeoXgl9y0Oc
         AEKuqBOWpowBWAIrHeIMuK8ADLtRyadWG4aONFArQTZlP/b2DR9N9G7zlhSFNZVA02dC
         YbzRdAW2z/b99y7qAHGJ2WwO1atTbmzSAwjMIwmIa9xmoTnAfKEPNVWlDcjYZEdW+QUP
         1MXw==
X-Forwarded-Encrypted: i=1; AJvYcCWB1SBBzVKaiNt7+ePvkBo+xUAhTrfA2VQ4h2ej4FdKMTxRRsamJQJY3m67Uf6cFvJJ7nmKRRf2RRglJlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlX+nWyBPc6doqQNOMfCQikZUIfWuaxxg1nqhsjoQ4WlLDjVJ
	2yQiEjiFjNXogr0d+FzoTC02pMaM/0Z4neG7NCeqYj5GveoaPsdgnsJU94gft74BLkQzOZF0UGa
	TnJmiGQ==
X-Google-Smtp-Source: AGHT+IHhPfyTLkgtMrtOM72kSjVGgRr+PyxLdwXo7qRQAzq2mFsE6l1xZorbTdGGRX+gMDUp6XZbhD1GIX0=
X-Received: from pfbil10.prod.google.com ([2002:a05:6a00:8d4a:b0:746:1857:3be6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a1c:b0:746:2591:e531
 with SMTP id d2e1a72fcca58-760353f447fmr8854470b3a.12.1753363908737; Thu, 24
 Jul 2025 06:31:48 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:31:47 -0700
In-Reply-To: <eeec8f7d96b9dd9482a314b8ed81d3e26f6f6b9d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704085027.182163-1-chao.gao@intel.com> <20250704085027.182163-2-chao.gao@intel.com>
 <eeec8f7d96b9dd9482a314b8ed81d3e26f6f6b9d.camel@intel.com>
Message-ID: <aII1w2zfPHN9yUwM@google.com>
Subject: Re: [PATCH v11 01/23] KVM: x86: Rename kvm_{g,s}et_msr()* to show
 that they emulate guest accesses
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chao Gao <chao.gao@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Weijiang Yang <weijiang.yang@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"john.allen@amd.com" <john.allen@amd.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "minipli@grsecurity.net" <minipli@grsecurity.net>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Kai Huang wrote:
> On Fri, 2025-07-04 at 01:49 -0700, Chao Gao wrote:
> > From: Yang Weijiang <weijiang.yang@intel.com>
> > 
> > Rename kvm_{g,s}et_msr()* to kvm_emulate_msr_{read,write}()* to make it
> > more obvious that KVM uses these helpers to emulate guest behaviors,
> > i.e., host_initiated == false in these helpers.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Suggested-by: Chao Gao <chao.gao@intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> Nit: I don't think your Reviewed-by is needed if the chain already has
> your SoB?

Keep the Reviewed-by, it's still useful, e.g. to communicate that Chao has done
more than just shepherd the patch along.

