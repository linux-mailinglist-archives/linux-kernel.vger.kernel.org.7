Return-Path: <linux-kernel+bounces-671721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD57ACC53C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91C0188685A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A324122A7E8;
	Tue,  3 Jun 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KfNmzdNN"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D52036FF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949746; cv=none; b=E2NQbijhANgAz1ULyx0bD3sbRKiRFJoHYuxhGpiEC4gniDRKBVeEm4Na89tSJJqlXLZOIN/+JxUMd/GDKpyvunJMxkE3hjY/E/RCVGeEduKxw+08GCdq2yHit/upLCUZD3TmvMJRRxrd3M+rVZWEF3qYCeqPfYxBY5bYx0CBPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949746; c=relaxed/simple;
	bh=4bYe98B7YedxOKQs5dYV9Ing2H+ahxEuWbcKRNwu5jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqe9sjIpHNlt121Ox/Dx+hGznwbxCqu90WONG0OyR/XH+DyRz+rRO6Xh+tbTOX5UrnGhN7nKQeH5bQI9lxqcuNWcXNuiXzU805fVeJuCTGIG0TB4BzNugGpyWY6g6Zd+/rjc94itMV4zrDyNSJKqu+ipwD2OIm39yo8TwGF8/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KfNmzdNN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442f9043f56so33098955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748949743; x=1749554543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uGLHAt8DknR+WLbJkRe9iH2Js5SBq5tvVtKbx041tVU=;
        b=KfNmzdNNJ9gcWeJi/EE65ST4DajPy42BjbnIB+ArDPKQZLIraWt5sjCejFG2nqc2CV
         6G1FO2GKSyqf30J7+yifknQ16gtWAmae0qCdI6gN03k4AKotT8R/b34Sdo8S4hhm2qNX
         e/fxiOJ68H4z4ol0BUeCy3gPKkY2vOLB3wjKfcysBC7zb5wrdwtJbSvYSgsvHwkqloGt
         5r2Po7/hzP6c9p8ZUSSp9sYVtd2+iOllvR5l8RmOx9Ry4YRSLsHXwW8i8uN5l8zo6Uh3
         UJupq/6pE6dIBoe8p59F+geQaJZzfWXF+HlfCjDmJRpE3YklQ/Wh6BToRNWO3AS+jEFt
         qX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949743; x=1749554543;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGLHAt8DknR+WLbJkRe9iH2Js5SBq5tvVtKbx041tVU=;
        b=iPm/h3DJ5OCHJ65SkZZ+Jt6ZyvCGgOBSeSgt8T1IdYfn62uO3ozhnffJtUdTAorM/W
         BjmylW2FgeVTUMlelQ6aDK8OBKYNkpvwsOOCBu1mx+ioIXHNYkMVY3JVDO9MjbQ1emiW
         OSUaOhse3wihdyd/wA2M7SluY2/Es5+mcdZ5Db6m+LXUS8coQtPofatsBzbDKYcTwcqZ
         NtyD03IP3ATMnGp1Xpj7H2xVzZPN8cR9MUCOT7Brct2iQCRu3ZE7XdaSlPD58ZIns9+/
         Cr1W/ghWjwLLwRxUYC40erpHsSL/7s1LgmtaHEaoHyGHqwuVQq4HvuU0+/G2GiK32joS
         6vLA==
X-Forwarded-Encrypted: i=1; AJvYcCWMOB26mMb3A1xDB7sLcWnQDlDVLFh8C8HhQq0enmx/fgWmI8UltD7BJbxJRRPlZKbynkGmoLIoogVhRXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGQMaZvPAuCPVlmZbqOWOmhqx5U7P/uSPlJTAfk2jyU4ANDy7
	Mc26969bEvkS/lAQ3CrTewyIUqoxc4ZTiqQQ1Ag4gk3fZFhJJkY4YU6oHKDs2+3ZbZE=
X-Gm-Gg: ASbGncselTz+YV4oRIC6CoeRgUdmkVGRuClKEQK5fatrlHTquEpipcYvfVui4aZ79JX
	DxorblmmW/qsU3szZY6TUiErT+xdHvKt1Zez5ZUFrzHB7JROA/KArpupekXVMRFlltG1hM3vqge
	VIClFw7wkKu/eUYEhj2Wl9fFyuN1HI8RqUsPXhi8oVUkVqpoAnaGSz+SodTdYPQ4EGiKiqfJxzV
	7Q7OXZAHHu1sGKM/jFKUPgUdk+aKkvweScTkJtjhVIYY+wXWcIq20uBkM1YVR9wjoYNpmncMgSK
	vfIhkDZeMEWjiv0cSHXxH3uz0Dt9H5rzUpbeXc7wV192q2ZJ5SFBGJ2Z6K33m5/edXEB3aH49pN
	LFw==
X-Google-Smtp-Source: AGHT+IEgpygrOhv7gLK00yaoYV7PitKSJjxKjZv024rqcceSRp7/7s8ylWvMN2iyAVhCspNkUGxhTg==
X-Received: by 2002:a05:600c:1c8f:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-4511edd5bfamr127061965e9.16.1748949742895;
        Tue, 03 Jun 2025 04:22:22 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c8f5sm17608560f8f.27.2025.06.03.04.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:22:22 -0700 (PDT)
Message-ID: <d1ec91ad-b368-4993-aadb-18af489ea87e@suse.com>
Date: Tue, 3 Jun 2025 14:22:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/20] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
To: Chao Gao <chao.gao@intel.com>, linux-coco@lists.linux.dev,
 x86@kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, eddie.dong@intel.com,
 kirill.shutemov@intel.com, dave.hansen@intel.com, dan.j.williams@intel.com,
 kai.huang@intel.com, isaku.yamahata@intel.com, elena.reshetova@intel.com,
 rick.p.edgecombe@intel.com, Farrah Chen <farrah.chen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <20250523095322.88774-1-chao.gao@intel.com>
 <20250523095322.88774-4-chao.gao@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250523095322.88774-4-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/23/25 12:52, Chao Gao wrote:
> P-SEAMLDR is another component alongside the TDX module within the
> protected SEAM range. Software can invoke its functions by executing the
> SEAMCALL instruction with the 63 bit of RAX set to 1. P-SEAMLDR SEAMCALLs
> differ from those of the TDX module in terms of error codes and the
> handling of the current VMCS.
> 
> Add a wrapper for P-SEAMLDR SEAMCALLs based on the SEAMCALL infrastructure.
> 
> Intel® Trust Domain CPU Architectural Extensions (May 2021 edition)
> Chapter 2.3 states:
> 
> SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed to by
> the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using SEAMCALL
> must reload the current-VMCS, if required, using the VMPTRLD instruction.
> 
> So, save and restore the current-VMCS pointer using VMPTRST and VMPTRLD
> instructions to avoid breaking KVM, which manages the current-VMCS.
> 
> Disable interrupts to prevent KVM code from interfering with P-SEAMLDR
> SEAMCALLs. For example, if a vCPU is scheduled before the current VMCS is
> restored, it may encounter an invalid current VMCS, causing its VMX
> instruction to fail. Additionally, if KVM sends IPIs to invalidate a
> current VMCS and the invalidation occurs right after the current VMCS is
> saved, that VMCS will be reloaded after P-SEAMLDR SEAMCALLs, leading to
> unexpected behavior.
> 
> NMIs are not a problem, as the only scenario where instructions relying on
> the current-VMCS are used is during guest PMI handling in KVM. This occurs
> immediately after VM exits with IRQ and NMI disabled, ensuring no
> interference with P-SEAMLDR SEAMCALLs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> ---
>   arch/x86/Kconfig                | 10 ++++++++
>   arch/x86/virt/vmx/tdx/Makefile  |  1 +
>   arch/x86/virt/vmx/tdx/seamldr.c | 44 +++++++++++++++++++++++++++++++++
>   arch/x86/virt/vmx/vmx.h         | 40 ++++++++++++++++++++++++++++++
>   4 files changed, 95 insertions(+)
>   create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
>   create mode 100644 arch/x86/virt/vmx/vmx.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b9f378e05f6..8b1e0986b7f8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1932,6 +1932,16 @@ config INTEL_TDX_HOST
>   
>   	  If unsure, say N.
>   
> +config INTEL_TDX_MODULE_UPDATE
> +	bool "Intel TDX module runtime update"
> +	depends on INTEL_TDX_HOST
> +	help
> +	  This enables the kernel to support TDX module runtime update. This allows
> +	  the admin to upgrade the TDX module to a newer one without the need to
> +	  terminate running TDX guests.
> +
> +	  If unsure, say N.
> +

WHy should this be conditional?

