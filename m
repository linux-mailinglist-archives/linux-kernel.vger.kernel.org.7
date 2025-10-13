Return-Path: <linux-kernel+bounces-851126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045CBD599C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03E818A62B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C92C3768;
	Mon, 13 Oct 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYDoKku+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753025291B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377763; cv=none; b=C8IVSrrr7g4vvuYOcBChIZkkv5MFt3FdxW/eUSOdQ3mz4w29pWPyN6CgMDQDb4v+UD8Fg0mE3nXTWHFiBS6yJAR+hWk83CqJ/NMCxPJUKfg4MXJkLpnl8FlQW/bHlwFgaON9T0qXsRRxbh08MNdlVjFmQQEJNOtGFYfc9gGzDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377763; c=relaxed/simple;
	bh=YpOrvarDsgX+BoUcJp30a+73+gS1d+gCoNWkzrol2Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DYr9/krVIvx4nsgo3Jlq4I5KhhaHW+AO3dyoHnbXN177LM7Q93b+L9g423ePNu/xO7czW4zuQEv9U547eOhrnYLrdSNcwcJwRdgIPsaE7E6+Rwb99S9/ytZUDq2nGppt/5ICX2gAsoTstmCCHPT0lc0k0q5LYfof9Ou4VcIbh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYDoKku+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so23770533a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760377761; x=1760982561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LukZPy5/CZdWHCV/h7XbMjLCjzkVUD5w5QgJZZyHQqI=;
        b=aYDoKku+jZmKnk4if5dd0rTv1LX6iyEHKcnXuhcklX0LO3cjxUAHj2zZtyNHt6FECE
         BxSWWTK525BaO8xEefXbJBsKIfytOgSgbDrpNbJNYewtaKuJW5/lEY+RYHQzBmsknE6T
         LoLerJ/sAMKCpppWLtEJ78nVmgy6t6LkJGox8mYmlhN+6y7bbsFxdIIPr4HO3TJZUvyV
         0VLfoEBBpFrflboIxp/xioT1BSfEhLUsJdSQ+hkUOeP5ItaKuI7GJXh6Tr2VS9kPPyj1
         MmjpbIG+0ZxIuwSscsw63MQyfcg1Ps/QF4cocMjazgH8x/d4ylthOtNcF43Jr/bjk+5Q
         2T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377761; x=1760982561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LukZPy5/CZdWHCV/h7XbMjLCjzkVUD5w5QgJZZyHQqI=;
        b=IHki4AVa4MlE3Wv4OXIT5dsMy8lWaY9T8Mo3ZOidfy8hGAqQRs4G1uPvQ+/iovgoVG
         naUG4EK3ZKBFkJLZw3mQwizz5ENthejZi0OHSLw8O9a5zBHnPXlgr6pKIYUFEyHc/IRU
         UUE+73ksMoI7cBZwkm4QChQkllKM32zpVc/oGapkKRgOhfGyvHYRgC2oAG8PQhUjH4KZ
         UZCrONI80DpcHWHg8xYiJaCQiCiLlID5tRrVHQXiJDNi0zIfNwwN8ppdIymihBN1Bavd
         ngNSpssb/lBoCLOLURZsBbOY9HNFclrbC6Ch/e8FJcR7pzohYd7RxfNfrunwqcwXMWji
         ZgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnYlMhzAhX0kWIHrMu5IxRMPQWPLKzhDd9SAAWOSGkGNCSe11nCmPMFM1A5PWI5UkU6X4edPVWMI99kPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HLfmvz2H3MyRLz2vO0rUWyDIXypshTKl9NsIViv6yfQNcaHC
	Z94bYHMrvAr+hopjWH8L/6BECI94uCb/gDMvLdeDH6pNTnGMtT4CB5vWf/mX2GACoeiXFoWJ/uZ
	8ldXiNA==
X-Google-Smtp-Source: AGHT+IEHWN8e42GwQBxFY89j15A3l2TcV+QryJNJewInavabM7dzmeX+taQwOLPmxj1PdL/WYv3lcA396qk=
X-Received: from pjbfr8.prod.google.com ([2002:a17:90a:e2c8:b0:32d:57a8:8ae6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:32d:a0f7:fa19
 with SMTP id 98e67ed59e1d1-33b51375940mr33870345a91.17.1760377760845; Mon, 13
 Oct 2025 10:49:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:49:19 -0700
In-Reply-To: <aOz8gHzmZ8PdsgNw@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010220403.987927-1-seanjc@google.com> <20251010220403.987927-3-seanjc@google.com>
 <aOz8gHzmZ8PdsgNw@intel.com>
Message-ID: <aO07n_1LYtY8Oio6@google.com>
Subject: Re: [RFC PATCH 2/4] KVM: x86: Extract VMXON and EFER.SVME enablement
 to kernel
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Dan Williams <dan.j.williams@intel.com>, Xin Li <xin@zytor.com>, 
	Kai Huang <kai.huang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Chao Gao wrote:
> >+void __init x86_virt_init(void)
> >+{
> >+	cpu_emergency_virt_cb *vmx_cb = NULL, *svm_cb = NULL;
> >+
> >+	if (x86_virt_is_vmx())
> >+		vmx_cb = x86_vmx_init();
> >+
> >+	if (x86_virt_is_svm())
> >+		svm_cb = x86_svm_init();
> >+
> >+	if (!vmx_cb && !svm_cb)
> >+		return;
> >+
> >+	if (WARN_ON_ONCE(vmx_cb && svm_cb))
> >+		return;
> >+
> >+	cpu_emergency_register_virt_callback(vmx_cb ? : svm_cb);
> 
> To be consistent with x86_virt_{get,put}_cpu(), perhaps we can have a common
> emergency callback and let reboot.c call it directly, with the common callback
> routing to svm/vmx code according to the hardware type.

Oh, yeah, that's a much better idea, especially if x86_virt_init() runs
unconditionally during boot (as proposed).  cpu_emergency_disable_virtualization()
can be dropped entirely (it'd just be a one-line wrapper).

