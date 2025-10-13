Return-Path: <linux-kernel+bounces-850682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C5BD382B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 595444F286F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213E23D7EF;
	Mon, 13 Oct 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gpr8M+m5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051123AB90
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365414; cv=none; b=aETx+Xmtv+pXqF175uyQPhA2Fu3sb03KyVUJSxoTacgFhp5sEqB9sSQSjdYdGQrRiRnl/cXketG0U09J3VFhPdZY+zsdfvbItWsxO2WnYz5zN04t9QgjKL8r+D/LdhBGTjZ9Q46Pj+aw3Vl40kNJ9w7MknjD1nxY0xn9F3RG2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365414; c=relaxed/simple;
	bh=dJqtEcjgvo9hPngB+YtUypzu7HzbSy5gU34M7TIkozU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbUnVHRojx7EDpAE/1X0GpcKgdQjBHz9KM/fDbbJNHkDVJQWzTCzfMpZEooAhqs/LIY9jfI6PhvvEJt3WxmwRakpIG35Ho86ComhTi6Jt3xhdzkjRlHZL/1pfo91bXiusSO30fpFFc6JUmskvhKeLZc6Uh/PKn9cFdqKOdjhPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gpr8M+m5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so13449654a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760365412; x=1760970212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IA0q+BCGyp+0QkRiU+mRotiQ2wwtZhT82w0C29Tzhk=;
        b=Gpr8M+m5f2mYYqsCbqqH5hQ+j6qGgXMAvEFcxUXdrN/iUJo3ZpEJAJpFOLFT+M15QK
         TvqWRhBg+9XuZkMA/59Z8L4HgifnnRICyR9cV8qXqU1GKTZNamG2Ou+um/uPHeCMHOno
         ApQ5iUoNUelNq4Mx0T+6UMBZvib2rM3+SSrgVE9t+yywEU1coQlP+96x00DqmSBg2Vyw
         88fJxIuSiJBG2ihmyA4Fnq53rSpJQgLFuuxOVo8Se/jl70uXqPIFrCHG7yJDr+VEUFHe
         S0ozKwslrhxnTCdaQTyhehW9FwjhAygtGb9GBn4XBf5tiUZ6cA+FPNXfwrHtNKoqsUlC
         wAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760365412; x=1760970212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IA0q+BCGyp+0QkRiU+mRotiQ2wwtZhT82w0C29Tzhk=;
        b=C/cNfL9mUj8vG5ZPnL/p8LE1IQhcEYODGbIgdm2hGXjMq5Vo+vpOX4At7Euq7jh9+/
         7xy5aq2XRBGLwNtcvKkE4ufRmevnPx01QGwEQR/0yW5utZkI/jrQMGcrCmYX+yzGNTnV
         JaOT3GgpNQ/bWK/VrjVku/tfGuo7A4j0ZwoYn/opMUjOsjGLppHWl+ThBiwNe70GzZZR
         6DzsKinKPuDvYGfkVW5/WanSDJXtQ6NjZAXa5meMPq03gDfJ34JMcFIejiwysmAcc43t
         ZySqP8nqdXeB7NE/CVHjZTPw98mpgBdV2hbMlb5pYCl/tq4eem+BLL3sK3fYUvlrPZz/
         218g==
X-Forwarded-Encrypted: i=1; AJvYcCUrwAObqcD6Xa4DZ/5QBQYYsaQTUTi/XDa+Hf+3xvFuC+LqkGHOz8LPQcWlTj8dCQdzhkqn6Pr99l9Izg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynt7elzhYuFG1c7COOSJvKqG/++5EJUJUGUd4MqyAuj5rQ22pu
	1RX2hnIroPBVvW0vjyBcJLsvwOjvbh5W8NXgy6VFTAsbnCHaHKfaXsgOIejhxe0UzW7FcFw28U/
	NhLv7Fw==
X-Google-Smtp-Source: AGHT+IEtt/r42k36nNjq1mgNkzGtA8MgFLr+mcoAjoS9JXR/HT4Da0zxS7NKvGB/ApBa7EI/8Iui2bia50k=
X-Received: from pjrx21.prod.google.com ([2002:a17:90a:bc95:b0:33b:51fe:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d89:b0:32e:c649:e583
 with SMTP id 98e67ed59e1d1-33b513b3e14mr24273677a91.22.1760365411945; Mon, 13
 Oct 2025 07:23:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:23:30 -0700
In-Reply-To: <aOz1X4ywkG3nG2Up@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010220403.987927-1-seanjc@google.com> <20251010220403.987927-4-seanjc@google.com>
 <aOz1X4ywkG3nG2Up@intel.com>
Message-ID: <aO0LYuzdRHsB7aPj@google.com>
Subject: Re: [RFC PATCH 3/4] KVM: x86/tdx: Do VMXON and TDX-Module
 initialization during tdx_init()
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
> >-static int __tdx_enable(void)
> >+static __init int tdx_enable(void)
> > {
> >+	enum cpuhp_state state;
> > 	int ret;
> > 
> >+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE)) {
> >+		pr_err("XSAVE is required for TDX\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (!cpu_feature_enabled(X86_FEATURE_MOVDIR64B)) {
> >+		pr_err("MOVDIR64B is required for TDX\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	if (!cpu_feature_enabled(X86_FEATURE_SELFSNOOP)) {
> >+		pr_err("Self-snoop is required for TDX\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "virt/tdx:online",
> >+				  tdx_online_cpu, tdx_offline_cpu);
> >+	if (state < 0)
> >+		return state;
> >+
> > 	ret = init_tdx_module();
> 
> ...
> 
> >@@ -1445,11 +1462,6 @@ void __init tdx_init(void)
> > 		return;
> > 	}
> > 
> >-#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> >-	pr_info("Disable ACPI S3. Turn off TDX in the BIOS to use ACPI S3.\n");
> >-	acpi_suspend_lowlevel = NULL;
> >-#endif
> >-
> > 	/*
> > 	 * Just use the first TDX KeyID as the 'global KeyID' and
> > 	 * leave the rest for TDX guests.
> >@@ -1458,22 +1470,30 @@ void __init tdx_init(void)
> > 	tdx_guest_keyid_start = tdx_keyid_start + 1;
> > 	tdx_nr_guest_keyids = nr_tdx_keyids - 1;
> > 
> >+	err = tdx_enable();
> >+	if (err)
> >+		goto err_enable;
> 
> IIRC, existing TDX modules require all CPUs to have completed per-CPU
> initialization before TDMR/PAMT initialization.
> 
> But at this point, APs are not online, so tdx_enable() will fail here.

Ah.  Maybe invoke tdx_enable() through a subsys_initcall() then?

