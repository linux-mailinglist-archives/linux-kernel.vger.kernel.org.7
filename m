Return-Path: <linux-kernel+bounces-899587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C3C58638
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755C4425CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674A2FE573;
	Thu, 13 Nov 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX2x49H0"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DB2FD683
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046573; cv=none; b=nj34c5xdipYYBy8CGiAEdZY3dBjDH7kup2VszA5a8/maMZkdGsRfijHbyw9Gyo8SzlU5LO6UJqs23s6X2b6vuXNCufAZGKFcsbd2/JtlsnjnA83Tq1x8EoFswa6q5VCVJwlDqQZwdzkMGhyQKe04/XX55SzT7wS79JJNFDv3TlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046573; c=relaxed/simple;
	bh=h6UlhZ4Ba7cJzydqwOO0750ALHLQFMT8ZapUHDdYcxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlV+alIz4Bfsc8cjXOnOQ5e7iCmgOUjdoeBA3mw1FeEvtMf9dMa/qBplVCG2zZiAV/9ASK4FxLaEWQdn/Y979gVuECc07udA1nu/BgXfi42rR31mYReTtfnx6PvIa4c+Jl75P6+20Bfeq/F3KBp5qxuYrtVhjiw8oVaz8IMKN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX2x49H0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9208e1976so899260b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763046572; x=1763651372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Osoqj+KfH9e9c7HCxCwaBxJ5YlsbXGetX83a8Y9Q07I=;
        b=YX2x49H0DPrnV67Wo26zr2ojc3glG79zlz9zw4iPfuW8S5tx7KXV9Q8wQH1Rjk6WcD
         KgkZ47K02voRDAHbRAeKQ7K52+lH7l6Ap8iddE8JBunxkvR3TTUKGEYKmmCTMUlpWzDB
         o5EdvdjAfm86HaZ2BViipe7APJhDnJOZYlqfa04U5RXOieqp0GL3HUtDPrYfOg+LH+e2
         RdqaPnkbJMRdJItPFuZsVjeqdl5z0pFj93TxQE0Pg+Qf8L7V4GyYH0SzWC0f2fjrMAcH
         VY8ZwT+UxABl+o5B0FmNBj/hRYkp79BFlagrXSq8UM9T9a7KyLtBajZqgqrdSeLBdsJX
         WpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046572; x=1763651372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Osoqj+KfH9e9c7HCxCwaBxJ5YlsbXGetX83a8Y9Q07I=;
        b=J6Ib7SFs+oTOuIVRK8Zu99inXP7PptV/4RkVewGMTuN+d+xg04n/K3eY1Asvxhxa3Z
         53LWqse8MUTbOuyByovftC/sKlb+bipC2KJ0cTQGPUYUYrxNNseNDZRygnnZ/G+15MgO
         DzUKLa12w2JORYNiqoY3aN6vopzQ9NlMP6FO6930KXLVLAzH+0DyXp5V4x67Nvd87flE
         TA8r3tTbF5UDcHwqDgY1mRySw4EnuLSOpUMTffjGqCwm4awKJN8CFzPZPbBQDDXgZRY9
         Hd5PDy4+hdBHtOZJSNe+s4HCLLUqxLjm0196tkd625JCrXnFUbkz7nMs6/N9tf93VkHD
         wI/g==
X-Forwarded-Encrypted: i=1; AJvYcCWFIscqKuTAW4O35GDznlpHTrLl9ywygkkqXQZ60hh/Bfo4oaoOsM/uerilfkS2buE5/MlGIizL5D1tcdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyvdVDQSHFAycQVxHCmJo4HNfmL55gBqO1MpzPP7bvjkBQ3Bu
	xT2JakDRHVM1U3cjYnxl07xMBF97YjsksQaECrFPJrAE0dCuhW+XqaNEIpqEJhPXqmsRg6w1BfN
	2eLaj+Q==
X-Google-Smtp-Source: AGHT+IEuoZ5TTwctwMh+n68VMy6MVwQhHq00IHTFircxz33TSH4UlAXeNZUVuLlkrF78tTLU5wAyIUNjY3k=
X-Received: from pjpy13.prod.google.com ([2002:a17:90a:a40d:b0:33b:51fe:1a73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a83:b0:340:c179:3666
 with SMTP id 98e67ed59e1d1-343dddd8c7cmr8237657a91.8.1763046571703; Thu, 13
 Nov 2025 07:09:31 -0800 (PST)
Date: Thu, 13 Nov 2025 07:09:30 -0800
In-Reply-To: <9adc3a5437cf7d9af99642a0df837bbd0237bb58.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112160708.1343355-1-seanjc@google.com> <20251112160708.1343355-3-seanjc@google.com>
 <9adc3a5437cf7d9af99642a0df837bbd0237bb58.camel@intel.com>
Message-ID: <aRX0iB7gYS_GgGOV@google.com>
Subject: Re: [PATCH 2/5] x86/sgx: Add kernel-doc descriptions for params
 passed to vDSO user handler
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 13, 2025, Kai Huang wrote:
> On Wed, 2025-11-12 at 08:07 -0800, Sean Christopherson wrote:
> > Add kernel-doc markup for the register parameters passed by the vDSO blob
> > to the user handler to suppress build warnings, e.g.
> > 
> >   WARNING: arch/x86/include/uapi/asm/sgx.h:157 function parameter 'r8' not
> >            described in 'sgx_enclave_user_handler_t'
> > 
> > Call out that except for RSP, the registers are undefined on asynchronous
> > exits as far as the vDSO ABI is concerned.  E.g. the vDSO's exception
> > handler clobbers RDX, RDI, and RSI, and the kernel doesn't guarantee that
> > R8 or R9 will be zero (the synthetic value loaded by the CPU).
> 
> Perhaps a nit:
> 
> I am not that familiar with this part, but AFAICT the kernel always sets
> RDI/RSI/RDX to exception vector/error code/addr before invoking the user
> handler, after the vDSO's exception handler clobbers them.
> 
> Since you are adding description to them, should we somehow call this out in
> the comment, if I didn't miss anything?

I don't think we want to commit to that as ABI for the vDSO interface, which is
why I documented the values as being "undefined".  Maybe were already stuck with
that ABI, e.g. if some funky userspace is looking at the register params instead
of its run structure, but IMO we should at least discourage relying on the values.

E.g. if the kernel ever changed its exception fixup to use different registers,
then RDI/RSI/RDX might not hold the same values.  In hindsight, we probably should
have scrambled those registers after propagating the exception information to the
run structure.

