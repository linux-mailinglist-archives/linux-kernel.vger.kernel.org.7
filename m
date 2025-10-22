Return-Path: <linux-kernel+bounces-865320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DFBFCCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4416281B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200134CFC6;
	Wed, 22 Oct 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH8wWI07"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898433C53F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145586; cv=none; b=kQX1HTf0PpjVn95bgx3J4kcbXxBO0HTKro5yW1a50Jd6fjlcXwk0gKKoeVnKV+sZSEpbczuJBGNpz0lqzdBO80EtJcbMde0QgeFXjDesSaoSrpgXUZ5d0Umm0GVacAplfZyk6sZ33Ovr5p3d1gWSN6s0lxvz/9qrF13kaKLJlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145586; c=relaxed/simple;
	bh=WpipEQJXVYcFkpkRLqzSzEcCHbasdGEjiXt0RvDq5AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YMoUfdDw/gsXbj5jOugFWqQDFiLzuGZh+TBvqlS5PJ6Lh3yx2EXf2Ap8JJ/Ih2K9Q104xUF++8znAbCAR8pRWudV9aUCZdtYBICBWrj9TQkO/r4O+wxZf5WWyfT9hWvsdLvSciBGFw7nDkZOyBSpNTtS0ub5Qc31FFKHqBpJT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH8wWI07; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso7971806a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761145585; x=1761750385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbNHPrOmzWNWm5K2/uwLb5lW4ecWkzdO5AE+PIr0iHg=;
        b=dH8wWI07a3QClUYQRV/CZqdw7NpMtH+hAJHjx2P9A6aHE66ZKfmB6SI+22/VuELdPP
         ZqeTRTyL7HV4YZQeOEOKHh+LcVKuyEImzydslsU3rMWMYbMobwf/JejqW4ogubHUWX+b
         3eMXTIAP/q7wBmlElGCKp7CAboigQA5Q4x//uuW/GHPEZH435seEChVnWD+4ELq7YpTt
         HeZ6740eQO0GIJxm21zJ9sR86aWPI6FCIYCz4QZPsWRwmJbp5Tp75chCP2SXElIybSX3
         +Ut6d5QhWtigr7vY0ZT/M8/yCq1g87x82We17jdbBPRNWMdV7tHzqqJZnfiozY8U9b5u
         NS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145585; x=1761750385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbNHPrOmzWNWm5K2/uwLb5lW4ecWkzdO5AE+PIr0iHg=;
        b=tb1lYf0aVg14qDaV4nX11Cz8QpUDTn97yvViFWVqFBoKYPxaAtk0x/cXCa2rkN8o/g
         GuFmDH9YqvKnETWtir/n3tqtUqloCR4+djsev2xxXmZmyaKLpc+ZCPC7rTNxNArRQm/n
         csO5pMqkooNs/OtuckL/ZQoiGPJbI30KObsg0arAZYDNU+YtUS8fd1m4aSPLsuxzdgpF
         dy4zmBp1BBQn0eBs6vT1tobAd5i6jTTcTB3LRUiXL6t8MIPXDhTeMJnNkDlw4ZyH6FXt
         mBBB8CEq8Mk1JNAlTu7RihMrydQC5ZNLGtw6FvDAVcnkzb2/aIyFN0jHZ9qyOuzabDIK
         vM1A==
X-Forwarded-Encrypted: i=1; AJvYcCUoT3Ulh2cvg/gSe2AuynlmqJH2iMAimxVnlg9Y5zG3v5q4BOiQZFD4LpDaqVZa82UD7+8Wxd4G3tGu2f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlwTAdBoDOJMK70tTid2s7PRRB4y6L/blWFm9pad2cxf378UN
	Ho3cpGTMyHtA3+g0YDlYjGxcL9mls/DuTWcjt5pZGa9jufWLg3+TA/cNydg3jARHOpjARaQK/EX
	OeziHaQ==
X-Google-Smtp-Source: AGHT+IGz5vCeuL6eg8BiHl+RDaAcDo1Jpgx/peM1TaCMEc8yk3bL7cPCwEmOI+HAuhAgN2IA8jgg5UzY0pE=
X-Received: from pjbbk16.prod.google.com ([2002:a17:90b:810:b0:32d:a4d4:bb17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2403:b0:33e:2d0f:4793
 with SMTP id 98e67ed59e1d1-33e2d0f5972mr2232790a91.11.1761145584675; Wed, 22
 Oct 2025 08:06:24 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:06:23 -0700
In-Reply-To: <20251022013657.n2he5yabfgunm5vb@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com> <20251016200417.97003-4-seanjc@google.com>
 <20251022013657.n2he5yabfgunm5vb@desk>
Message-ID: <aPjy72H6q3CH-BB1@google.com>
Subject: Re: [PATCH v3 3/4] KVM: VMX: Disable L1TF L1 data cache flush if CONFIG_CPU_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 21, 2025, Pawan Gupta wrote:
> On Thu, Oct 16, 2025 at 01:04:16PM -0700, Sean Christopherson wrote:
> > @@ -302,6 +303,16 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
> >  	return 0;
> >  }
> >  
> > +static int vmx_setup_l1d_flush(void)
> > +{
> > +	/*
> > +	 * Hand the parameter mitigation value in which was stored in the pre
> > +	 * module init parser. If no parameter was given, it will contain
> > +	 * 'auto' which will be turned into the default 'cond' mitigation mode.
> > +	 */
> > +	return vmx_setup_l1d_flush(vmentry_l1d_flush_param);
> 
> A likely typo here, it should be:
> 
> 	return __vmx_setup_l1d_flush(vmentry_l1d_flush_param);

Argh, I have a feeling I clobbered my branch with a --force push, as I remember
fixing this exact problem.  Or maybe I saw Brendan's struggles and thought, "hold
my beer!" :-D

