Return-Path: <linux-kernel+bounces-735253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C99B08CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D467A8999
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E82BD5B6;
	Thu, 17 Jul 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLlwHrkw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784D2BD587
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755158; cv=none; b=JW8f5rRqUmMnzdmnwtJTwI1nwX52BinQ6NNrPGd/aPysk0Qhmqa7gncRflmwBYgwZcJAnUG64BD33vansGaOx0iH9FOKKSRFokjW1TNEfpKL34oAja90NyB38CLwecxOmKqdFma72U6cO5WXz4onrKWcxGGkVOgq7BpYnH1H8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755158; c=relaxed/simple;
	bh=vFY0nUunvlGqLxXg8e41Kh2n8Hq2zaTpVxr1ylslpZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4++Mz7EvEUcbVR+3x5NItOGsBukkhbPUcXpTXThtawjUORTrYhaeItnT3n59XKtPxVl/WatilMbGw9eCJoM3qUSrKi2LnqtyETuwjyDWjUdNOGVBN8S2Plsw4UjdKzt4n34jtR36FCEfmt70ylywoEIKgvdkfhtrXBgUD/4kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLlwHrkw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23dd9ae5aacso128215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752755156; x=1753359956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChafKmeRDq7BBol4Pt9Xq7FfoEfLdZ8lQh7RZ12ztC0=;
        b=sLlwHrkwQvno3HHxMr20MYNp9zCM5Zu1rXPUz4Mnfc0XFt3sGfJwxeT/mmGJCL5hNk
         baCh/A536znQkEeKNSm1LGdwx+UCUCJype2xgSGQydUZ/7FMGI3YLOhcuxdHHsnoNzOr
         Bt3ywyLTrZzTYLN1e99nRt8Owqd3NARrLcQdSbycQDc7OnTlpoVzN75NLzmPqagEY6hH
         S8Pu9TSlokXqA4uprO4I3dxIZXToK2J3QvINupxZfJCWYMTC+5/6DpW1BetGKnSClv84
         EFBZoNbMcBZA654Ck5c5i3BSuvqgqPjm4awQHxwbEj1zFj/smVK7AYe6WgY9AlxijzC7
         1ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755156; x=1753359956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChafKmeRDq7BBol4Pt9Xq7FfoEfLdZ8lQh7RZ12ztC0=;
        b=rfJEIMvqKGImGo8w51immiikyYE5EMgrWipWvuBZAhSKeOZczlxMTWP0YToJ59YatZ
         2NO4/lus6YxPZyxPecSVGk+OtPEKatvdQ7Qfsj5MLk3ZRj8LRcBaSrCaYVZp4YRkyfqm
         GPBgULHUXpGJq5XeKYMhRSKRZ+QUyluQdWZG3cOB3eXSq6wfCr5d3j04c10P5bAdgGRQ
         x9xZ7at5Vcx6PvrsbqyyxqfWVIUlSrArwLhC2S5ztP/F/VMNKwM1BWnMTEl2d1k0Po9h
         ufhqEf6+6LBxgYVjXCFG7JmqO7pSJGTuQFRHz26OOYX8xU8VEdO5oLXClNKZeEdoIGuD
         qsIA==
X-Forwarded-Encrypted: i=1; AJvYcCVIYi9d0g70IcsksdPRHj7dMYkiD3yySpsqJnfwXv3cifBMkmZHJDvMMS3xVe4/00dvCpuxWdU5+qEs/sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIHJc7vdWYCz6YATbfTFYKZLYxtsyJweIcHX0r15kfaVzUkHi
	1wHl5gQsnxQw5mGvmNnakwX0w0eGeSWX89QlBzzojjQYO01bRkayQtkrG155cncZuTvTfltshu9
	UccW6ZED4HbEZqUinZMLQbx5h3kvp0NtTFsEK2d6u
X-Gm-Gg: ASbGnctSzz7OmWDvd49rAQPiXagE+ZloiEFi9H5xnJC4KtuFlSmyzMUUr6dSZ05Dvr8
	3djEOe7n0f8BzcmTXwtY1coXKez6jtfF1zQh4a19k8u7nSF+fYoRj/f0mIaEVI5t+tuMhIa+mGM
	hw4aB4vvgEZputdtij7cicBJXAHmxa7e5nA123hzLoQRGM6yorE063ek3z8yHiNTEK//rTsOOD7
	d7COv/lgPtcIJ/T+VxyQPR5EmwZFf0fZHwARibF
X-Google-Smtp-Source: AGHT+IEuSUvLGjJ9LnJSu0ASEm9Hu6l9HxUyAYK0uxHFZ7HyWOgUNlbykOmydDQTYxgeeX0nRB1YUMf/QZK64flQTCE=
X-Received: by 2002:a17:903:22cd:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-23e31497285mr2701935ad.17.1752755155331; Thu, 17 Jul 2025
 05:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717022010.677645-1-xiaoyao.li@intel.com>
In-Reply-To: <20250717022010.677645-1-xiaoyao.li@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 17 Jul 2025 05:25:42 -0700
X-Gm-Features: Ac12FXzEyO5jZX8xOPwmf85jko29MZEzFgWRNZrg89OfQOg-N2XQCdwntWcuzLI
Message-ID: <CAGtprH_fNofCjJH1hWKoPwd-wT7QmyXvS7d9xpRNYxBznNUY+w@mail.gmail.com>
Subject: Re: [PATCH] KVM: TDX: Don't report base TDVMCALLs
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:28=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index f31ccdeb905b..ea1261ca805f 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -173,7 +173,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_ent=
ry2 *entry, unsigned char i
>         tdx_clear_unsupported_cpuid(entry);
>  }
>
> -#define TDVMCALLINFO_GET_QUOTE                         BIT(0)
>  #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT      BIT(1)

I am struggling to find the patch that adds support for
TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT. Can you help point out the
series that adds this support?

Thanks,
Vishal

