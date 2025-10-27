Return-Path: <linux-kernel+bounces-870686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A184C0B738
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 095064ED8B1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7B3009F8;
	Sun, 26 Oct 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfXt4hKc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25727A477
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761521618; cv=none; b=js+yyqo8yaMGznXYoSw15Z2wZOLOdv8QdUTm1YTIqOaFllgSL1VRVF9zN4uITrqj6PEr6c+da13qVk8+wZzdD7f8YaNMO5l//ahheuisMRSQetIGFNNrsfiWCuFZXl94anxO/17ajIVt+kYvmPguhAST6a4Bmf6pGgpqIL/mT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761521618; c=relaxed/simple;
	bh=sbRNYooBtB6+p36rT2F0AqrqTXcPIfrlNAAiCyRw42w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/FY8p8BfMEwgd1vq+J1zY3tqU70kXr2SJU2f7eGOFgTzQQhFaBmx3ORDCDS6g9EYIIKwgIKm04eng1rjJdrym4KgbGRlBka7Ge2DA3SrNaJD2FbB6dWe1Pp5lShitbB8jXt6VQXOpXGstucaryYl87jhg5S3b3vh/7mU+InSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfXt4hKc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d67abd215so265405ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761521616; x=1762126416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCW78Hi3/UYlpEdKdr8X6gRe5/QZDWAFCCsmRoCqTg4=;
        b=BfXt4hKcVS9pGk9pwNT5ju9tLyQTbqzW1EhHJpxE4aa7yqXvAQCoJ0l/7fs7LO7ENu
         gKYqlOaNzqa/OoumfvVywuQYmTRz/KncPdSMc6T3BBYZ5/05Sb3tnZZ+eOATWYMkvnMo
         PMSSQi+OtDbno1vAJ24yF6yLlpvseqMTt30Cdapa23ey3H6pkp971gpjZTarioJNWFf8
         h8dOczggu78hcVrgFAuzV8Djcj6ZC2WHNJ/cQggAklSeNbNGHTHyG4wYSpgxedy7kCQw
         mCPUF5WFDPhbgdeiyL2iZOpe7OHqn6g6OSz8v2jGDEUjtao/xcFpP7xV5cpG4PPNlQcg
         Z2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761521616; x=1762126416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCW78Hi3/UYlpEdKdr8X6gRe5/QZDWAFCCsmRoCqTg4=;
        b=lfWdUr6e1VV2zBhKcjdr0OIdTlrYwBzruJPtpir7+UvoYJ1FgBs80pKlUZNssMz/n5
         LjlVxegtyIhdPv6BrNmWo5vNHMhF3NFDyY4XNROfwXMODcLTWEYxpoViZWo8J2n4kERb
         kSDaxeHLESnBYRAk6SsiMwDtuwQkocKRhi9wuuVwVd2VT4/pr6yF65niKQbKI3Qy7RwW
         GooIGkXficpCkjSBsYQXFMxgykaNX3mV77G5fNlj5VlyGRl2BNHONH+wtsen/LkwehZf
         28+8We2rzxfHhh0Dgbrsf/rtzXs396BnKt+dW0nBxoSrxIur9KvugEhbqvbf6CiwNoTs
         pBgw==
X-Gm-Message-State: AOJu0YxPyvm3EJyUusJpITYroWHfmQgj7FXYqX9MG7uivTtLijDzAeCo
	gVwo/MA0kSdL+ptFvfXbJzA0swJ0tWnqLlw7E/EE/Gk568RMiMd5taBJvNnXPu0EdGB3T407Yjg
	/4oJZA9/HYA4Y6+ZMp3t2Z+Fy5XWoysyJydlheQeAD5AIob9IiM7pqhbKlIsHMA==
X-Gm-Gg: ASbGncuJcNwqWt+gyR3pAHYO6plnz7ZQcVOYZlA438K3k0nqFsTq6uvQIl7wNs8Urvf
	268DDC0DC5mMRxBeQL8UNpYwBBcso2JyHS1lRhuM9Em+JKc1zH2o9ShMS8S2aGiMRDAnK85DC2Y
	Zh3+hsn6MTceIaLBdsiQbscCR0vsR6ueYbc6QvKniLJV9rqDQZgu7FCdHwKPaUfsHziE1oslKQ4
	0tpcJV4bBz5P0NEitQH4HYRv6UhTd9vEX+03OzaSB2cnucDW7443m6SyvVoOnzPklYH86R8AjNv
	+aOBdWNLr08nQPKTZ7K0p0p6rg==
X-Google-Smtp-Source: AGHT+IFxMBwDJXu7Hd/h37npuGo4iO0LEbP6Za8w7B9GtVqotea/HN1RcYf7r7DKGa0lIaPrHgoUUoiN03uSXvcHZm8=
X-Received: by 2002:a17:903:38c8:b0:275:8110:7a4d with SMTP id
 d9443c01a7336-294977c0828mr5269225ad.0.1761521616170; Sun, 26 Oct 2025
 16:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901160930.1785244-1-pbonzini@redhat.com> <20250901160930.1785244-5-pbonzini@redhat.com>
In-Reply-To: <20250901160930.1785244-5-pbonzini@redhat.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sun, 26 Oct 2025 16:33:23 -0700
X-Gm-Features: AWmQ_bl41s5pNlQiemtHhqHGKWYzsAW5pk9xt-3jx4Wfe7p3yzlVlcr7NlSZxKE
Message-ID: <CAGtprH-63eMtsU6TMeYrR8bi=-83sve=ObgdVzSv0htGf-kX+A@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX
 partial write erratum
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, 
	hpa@zytor.com, thomas.lendacky@amd.com, x86@kernel.org, kas@kernel.org, 
	rick.p.edgecombe@intel.com, dwmw@amazon.co.uk, kai.huang@intel.com, 
	seanjc@google.com, reinette.chatre@intel.com, isaku.yamahata@intel.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com, 
	chao.gao@intel.com, sagis@google.com, farrah.chen@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:11=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Kai Huang <kai.huang@intel.com>
>
> Some early TDX-capable platforms have an erratum: A kernel partial
> write (a write transaction of less than cacheline lands at memory
> controller) to TDX private memory poisons that memory, and a subsequent
> read triggers a machine check.
>
> On those platforms, the old kernel must reset TDX private memory before
> jumping to the new kernel, otherwise the new kernel may see unexpected
> machine check.  Currently the kernel doesn't track which page is a TDX
> private page.  For simplicity just fail kexec/kdump for those platforms.
>
> Leverage the existing machine_kexec_prepare() to fail kexec/kdump by
> adding the check of the presence of the TDX erratum (which is only
> checked for if the kernel is built with TDX host support).  This rejects
> kexec/kdump when the kernel is loading the kexec/kdump kernel image.
>
> The alternative is to reject kexec/kdump when the kernel is jumping to
> the new kernel.  But for kexec this requires adding a new check (e.g.,
> arch_kexec_allowed()) in the common code to fail kernel_kexec() at early
> stage.  Kdump (crash_kexec()) needs similar check, but it's hard to
> justify because crash_kexec() is not supposed to abort.
>
> It's feasible to further relax this limitation, i.e., only fail kexec
> when TDX is actually enabled by the kernel.  But this is still a half
> measure compared to resetting TDX private memory so just do the simplest
> thing for now.

Hi Kai,

IIUC, kernel doesn't donate any of it's available memory to TDX module
if TDX is not actually enabled (i.e. if "kvm.intel.tdx=3Dy" kernel
command line parameter is missing).

Why is it unsafe to allow kexec/kdump if "kvm.intel.tdx=3Dy" is not
supplied to the kernel?

>
> The impact to userspace is the users will get an error when loading the
> kexec/kdump kernel image:
>
>   kexec_load failed: Operation not supported
>
> This might be confusing to the users, thus also print the reason in the
> dmesg:
>

