Return-Path: <linux-kernel+bounces-723894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B27AFEC1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6271C21A10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75782E54D9;
	Wed,  9 Jul 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIF7f86V"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30402DC352
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071745; cv=none; b=EsYM2IY+FfR4VZeo/P9kxwkkGvw+3JsFug6DlO7/FK+Qf8QZTyzs56QNJGxAkz6bYbt0VAIHQofgrMHtm1kWlRtxYRjFGInNQMimtvcWTX6Lt7AOEqSs2OgDVrOwN3grczO7EbY+7ygr1TSxrc40g7leYCEKXeXnwMNVI95quLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071745; c=relaxed/simple;
	bh=8YdhouPZUQY7P02LpNcD2sAAAo0fpakGafqDHAv2Kc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PB9Z30wl2iTFwfzdrxeUP7omuVyS1zfKa8YjAlY2ekVYycemDaE3dMaAuDu9SIfB+Jus6Kei/uQxK4eH83mbBJgbjI8ciZTcjTo4vKoiGC6pH/niXBFG9bJgCQiAThtQucW7wcZfjIG35VxJTJihYlzrSsN8wUJF6y1uSmPstgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIF7f86V; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38ffb62492so10475a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752071743; x=1752676543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ku2zCzFozPaRS9AkpqL2P6VacMaLZmJzKar7ALrJmU=;
        b=XIF7f86V14osrCebtLebr9kGMH1iXayeAVCvV3iLNXlHYwuwLJbYACFLR3O0jCyMNH
         43kMkZrJ/Lsn7sOBWClrdeOKEXgm8RTNt+II9KZ4q+Xyac5QFoBtu8atXYyZ85BZ9nvm
         rtPhGYpopj9TchxUCuvtPmBRhf+YcY8Cv4XkDf1+SWklnP5E0JRZA60Aef8LoAt3hKMR
         b0aylzwnAcXU21GzXdJlevbJGMtCXNbchXzl5H1pTfx3k0kSR8Qw5+KoCGUN1Vp0qPRN
         UUZ/7Ahh5m5V77/4QwxxesklNhTe20td39VZ7PaP3vV6aZH/ATFv0yZ9r0oP2YI5R9Wp
         hc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071743; x=1752676543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ku2zCzFozPaRS9AkpqL2P6VacMaLZmJzKar7ALrJmU=;
        b=aB5nc1UCkx6/ezNCOq7NiDAr7S3lM4H9yxa+JRlVPAPLoXFd64i3edHfONbVJaDqKw
         oZGYlhshEiVCsWoRaFkyOvGpykocTbBHL8Rsq0ufg8okorSYkeTLZISYqrzn7RiwwQNn
         hesUsKBgaK2ST7dAonVyr6Dobl64Kk1esU8o27L/ROuefCIGnVoUJQ4DT9Rt8y9HS9sU
         H03h9wo3uE0r8boycT8g3sjQ4bwCP2jOezJAbJBoowkn3VIdbNjzC/oZfszhBsPj0z4f
         iuofsP5r4pRZ8MclFdltE2q4yGwOtVr2IMIIRZ2AM+v272wtmkN4xM99K99AeaO1W3+1
         qjOQ==
X-Gm-Message-State: AOJu0YzgPVf6N4RxP85/lISqRpPRGD4dnYkFCAs8HDEUlaxT8OOOS1GO
	ENWDHSV1Ob9IVCTFALYjeCae/wfauv9ubZvov2rnN2BUIzfd9ZfNwcleEtHnQifWidukTMLb+T5
	f8DWXdw==
X-Google-Smtp-Source: AGHT+IE0iW+1i/bebxqmH/aw62RiVT3uR6d207t1zHEY3Yckxx2JH0pCq5Zv8hHrmou0iASKFFw+cYWcpqQ=
X-Received: from pjyd8.prod.google.com ([2002:a17:90a:dfc8:b0:2fe:800f:23a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d06:b0:312:db8f:9a09
 with SMTP id 98e67ed59e1d1-31c2fd00c80mr4781765a91.14.1752071743347; Wed, 09
 Jul 2025 07:35:43 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:35:41 -0700
In-Reply-To: <20250709033242.267892-17-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-17-Neeraj.Upadhyay@amd.com>
Message-ID: <aG5-PV7U2KaZDNGX@google.com>
Subject: Re: [RFC PATCH v8 16/35] x86/apic: Simplify bitwise operations on
 APIC bitmap
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> Use 'regs' as a contiguous linear bitmap for bitwise operations in
> apic_{set|clear|test}_vector(). This makes the code simpler by eliminating

That's very debatable.  I don't find this code to be any simpler.  Quite the
opposite; it adds yet another open coded math exercise, which is so "simple"
that it warrants its own comment to explain what it's doing.

I'm not dead set against this, but I'd strongly prefer to drop this patch.

> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index b7cbe9ba363e..f91d23757375 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -564,19 +564,28 @@ static __always_inline void apic_set_reg64(void *regs, int reg, u64 val)
>  	ap->regs64[reg / 8] = val;
>  }
>  
> +static inline unsigned int get_vec_bit(unsigned int vec)
> +{
> +	/*
> +	 * The registers are 32-bit wide and 16-byte aligned.
> +	 * Compensate for the resulting bit number spacing.
> +	 */
> +	return vec + 96 * (vec / 32);
> +}
> +
>  static inline void apic_clear_vector(int vec, void *bitmap)
>  {
> -	clear_bit(APIC_VECTOR_TO_BIT_NUMBER(vec), bitmap + APIC_VECTOR_TO_REG_OFFSET(vec));
> +	clear_bit(get_vec_bit(vec), bitmap);
>  }
>  
>  static inline void apic_set_vector(int vec, void *bitmap)
>  {
> -	set_bit(APIC_VECTOR_TO_BIT_NUMBER(vec), bitmap + APIC_VECTOR_TO_REG_OFFSET(vec));
> +	set_bit(get_vec_bit(vec), bitmap);
>  }
>  
>  static inline int apic_test_vector(int vec, void *bitmap)
>  {
> -	return test_bit(APIC_VECTOR_TO_BIT_NUMBER(vec), bitmap + APIC_VECTOR_TO_REG_OFFSET(vec));
> +	return test_bit(get_vec_bit(vec), bitmap);
>  }
>  
>  /*
> -- 
> 2.34.1
> 

