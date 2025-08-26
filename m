Return-Path: <linux-kernel+bounces-787102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679AB37171
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECD41B285D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04130FC2B;
	Tue, 26 Aug 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJwESBJO"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A12DAFDA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229923; cv=none; b=M2cty5kdMli7jBa/aJk7yMiT82W7s0+1DDAYpZ4xBmxxgzTBUyxISjWWm2yDVBsW8gBqBuu8badA/7Jm+KoUUW+HaJg7+FuYH+FcR5YpSs4bjuMuvmoGEg7swOLMb7lu7sF9lURSrsLoAdX04d2DZl1WP95jx/ikAoA1N4D6Jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229923; c=relaxed/simple;
	bh=7YmuAIzAlIBUp7y//DE3HReO1Z74t8Rq2D6F7fxWl/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YjD/d0BaPrawRIlUB0TG6QQfsyNJKZUfPmMRedkhyFiqYjEpWtrD0NIyAGGBKEMkzfcMMMRNfrleQcreDyBru55o/nVqD/qxQQPdjp/fGhdgyPwOn7DExN6b93z2je64hgOvcwrNBHwLYlXo7FSOlAj3ofT1GH5Ba6q2liQTHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJwESBJO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246088fc25cso65501575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756229921; x=1756834721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WCh3JXHjryZipIcYlXB0ieuuCB/Sbb2yF/QtsWjBX4=;
        b=TJwESBJO0hzUiyhwKX5LXENneowHIw317NErZZSI79uHdxOKu6BCDX7J5/XWN9qB32
         N8/p5UWTyvn5IGM5hPtiLM/gGj2bBhO6niuFKkKXVg6v66VvBFyrZVKdvOnViHRdwEQW
         llTXTy8wn6sUftaunjnpVGH6qtYSi8L0ceMHuZ8wrxHv01ph1UXV6oU++OWVaOjhy+Da
         2xwEdDt4SSErUZcRd7s0QkuzsGQU8AUgXGHNzAqFONOq3BGGNEMv/Jd0lMUc9gHE5L5V
         8smyFSPcg+mA2dzLANn/3lQgnLtDtRkpJc9VtGulE65PJk17FVVrf3JdFQEx6mKzQSTt
         5kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229921; x=1756834721;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WCh3JXHjryZipIcYlXB0ieuuCB/Sbb2yF/QtsWjBX4=;
        b=L6y7hGvF7Qibd97fSr2TS1FYj6vjYeINExAQ2cVb0LIrReC0rRkhunS4wHEl7exoVj
         p0sYPKBxhgbnk7F/9AzMYBOp7VkEBBC6z3wMiRHKnXh+nN4LRecqJlM6PJtTiKnd9PwJ
         8F97nnKEvf0Cc51XgqHPoqZ0AUic2LSxL/m6LlaT3zdogHXW5g86LKjwXnCDoCChH9PM
         RhRuE4ckCO4G/1cvKQ7nSQVihlZxef6nWmL2RYt8T051xDAVQB75FaTHqOxpA8OIU2tP
         8Syt3oyxRqpQBdLZ4m4U+eAPR29RLudx7cNNWlpLzuOZg2d69PA65HtlmjnYiNXwGZlL
         72bA==
X-Forwarded-Encrypted: i=1; AJvYcCWkYgPHiZZmqDreljFjhaESKBx7oWPJrHzV905ExC1KBnS4jX7AIEypIRvJZe+vrGBoqqLO8rKL8R7cb98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAFXU1q9E5je54qv2dRWsapKg0HN/UTyRyq0WqIV8aYDWAoQA
	/XGrqKncX97R1mBfat+hPyUIrhxqnFNSdtIcI3QMDsmblpm18q7NfxuAt6Vz7uRZGqhn6LdavPZ
	o8nO9RQ==
X-Google-Smtp-Source: AGHT+IF/sabRyXB7YxJbLpMEhMF+RFA2vrCfTEi4ek15iUuu7qnI7vkB2cZsrrvv2L09IFq3Ej1crTOd2rA=
X-Received: from pjbx32.prod.google.com ([2002:a17:90a:38a3:b0:327:5082:ca1b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3885:b0:246:61e:b55f
 with SMTP id d9443c01a7336-2462efdf210mr184232345ad.60.1756229921464; Tue, 26
 Aug 2025 10:38:41 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:38:39 -0700
In-Reply-To: <CABgObfaZjcDvFVWO7rsr2e_M=F6r=sEq+GHjtEp04uhj29=MuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1756161460.git.kai.huang@intel.com> <14f91fcb323fbd80158aadb4b9f240fad9f9487e.1756161460.git.kai.huang@intel.com>
 <aK3qfbvkCOaCxWC_@google.com> <CABgObfaZjcDvFVWO7rsr2e_M=F6r=sEq+GHjtEp04uhj29=MuA@mail.gmail.com>
Message-ID: <aK3xH4MGv9ZMxhyY@google.com>
Subject: Re: [PATCH v7 7/7] KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com, bp@alien8.de, 
	tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, 
	thomas.lendacky@amd.com, x86@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, reinette.chatre@intel.com, isaku.yamahata@intel.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com, 
	chao.gao@intel.com, sagis@google.com, farrah.chen@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025, Paolo Bonzini wrote:
> On Tue, Aug 26, 2025 at 7:10=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Can you add a comment here to explain why this is done even if the kern=
el doesn't
> > support kexec?  I've no objection to the superfluous flushing, but I've=
 spent far
> > too much time deciphering old commits where the changelog says one thin=
g and the
> > code does something else with no explanation.  I don't want to be party=
 to such
> > crimes :-)
>=20
> I asked on the review for v6 to make this conditional on CONFIG_KEXEC_COR=
E
> with a stub; Kai said he'd rather not and I acquiesced, but now it looks
> like we're going to need a v8 just for this comment or to follow that
> suggestion of mine, which I still prefer to a comment.

FWIW, I also prefer conditioning the flush with an #ifdef (we could even ha=
ve
both an #ifdef and a comment), but it's not a hill I'll die on.

