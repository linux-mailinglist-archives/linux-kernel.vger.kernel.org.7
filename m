Return-Path: <linux-kernel+bounces-742867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3EB0F789
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93B0162D30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1FC1E834B;
	Wed, 23 Jul 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3YGcbU3"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A313BB48
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286238; cv=none; b=dorXqDzsZ+m5wXaQ0GD2TcqMQHQYhwSUFmBmP5qtApJxComvC9+LjYNTvMkIwfSXBFJjE/O9xJ87MJI6rgDIZk3zabvR49iEPBsM/ZWIXADfpgww6WYhAM5+2tl9Guzkx/1HCEG04ilIK5GEVcRAp8OvhV2IjaYR/IQUlyLpqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286238; c=relaxed/simple;
	bh=6PAkTe1dj1TtO1WACsCPAZuyivpj6xQq+J5+CpFI4cs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YB2+0Eps1fGT/K0MWBlRYywKUfoFxKkYoQN1UcxMinUeBlw9q/ntTadWrwunMK5MopZbHhhqE+yOYTyVEAYNsYWIKHz72gTvOEllcvUIi8bo++YA+glVJQz1VfZHS7Avv+nlU8jtNVFtN6Iatair4M+aT7y2cp+moNGpwpfdmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3YGcbU3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23632fd6248so65247085ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753286236; x=1753891036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnll/DJyW6AHp9YnPp0+5ZkZG0dK6J64xQlXrA23muA=;
        b=n3YGcbU399jZMhaY0C9XwcMWr7uKYBeI4Rxs0DkXBRoRLvdfBWA0CYU63RAqtqDUe2
         QBPfNOgtI6A744ZSeqAmyFWnn0gYZkIGBPmheVP4NtuxOTvPsGYd9bSrm0WfPSD+jH0h
         wnq5wvs6bLVtk9Xmcift6wJqAshdVlL2dmtquDJMQQ/49eygJF5+x+18keWg6OccmVWF
         /iHnSf5inGQARaRs70yMiF6hBT8JHTbROs6M1U/lUV4K4q42gugPuWhGUzYOJ5CWfHp0
         aJLaCU0rRQFG4ms+xuW6v7UD8CWmcrLZiF93Q61lmvv93WH8123Sun6MBO47s+6T9Xls
         8DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286236; x=1753891036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pnll/DJyW6AHp9YnPp0+5ZkZG0dK6J64xQlXrA23muA=;
        b=jhMHHypmVwYS/AJunHaAJ4ImAGQnGzblTHsMxZRJhCxJH113PIqHhE+51VxvboY5A+
         HmuvMigNqOVQfOL5bKrgXqMo28W9NCmxT3np56zHO4jWWnR2LHvnBqxDaYcCNbMwVkpr
         wq/Jd76C+G68BaJEDX/GUJvJGv8BCX9IOqxBgSq7c2MmhYOQ3JhnMhbqYwohGDFhT9Yo
         8afZsOAyWK5qD0Ab7xTAajmk40ts8P1oucwvNWun8ItdoKAPafCnxg5tXj6pDeCfEt1W
         SC6ymNQ4bE/Ojt9SDbZDoP/vN4ubn/N7FJyT/inP4sJUJnn2p6Iw4C3EQvdaZALT/CJ+
         K43g==
X-Forwarded-Encrypted: i=1; AJvYcCWvZdnYhtgIQQF/OxWFre58dcKZ7pUgvaXaXkKs8lnNKgRqKb2hKmCGt8b5rMva7LMofcVCFING1KLUZ2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy5qrP+0Qo2iGNurpYoNjxMHaOTS6JPRreUYSVdLXvoSjfCak
	2xNZ5+75Y8fCamaHqo4fL0ie+KltC4YlCrJp/at6VHe96h0i/v+t9DpzfWUWM+67nmif5PwgXDJ
	xDbxqbg==
X-Google-Smtp-Source: AGHT+IFFztsHdzhGL156gGYuLAl7YBZxBB76oIkYrIz9tRK0i7YqAXFfsNkZmV6Q+PyuD/S0tjzOV1yCoXg=
X-Received: from plgp7.prod.google.com ([2002:a17:902:ebc7:b0:235:6d5:688b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea06:b0:215:8d49:e2a7
 with SMTP id d9443c01a7336-23f9823e7f5mr52579355ad.50.1753286235929; Wed, 23
 Jul 2025 08:57:15 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:57:14 -0700
In-Reply-To: <20250723120539.122752-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723120539.122752-1-adrian.hunter@intel.com> <20250723120539.122752-2-adrian.hunter@intel.com>
Message-ID: <aIEGWoM-kY_6gL8N@google.com>
Subject: Re: [PATCH V4 1/2] x86/tdx: Eliminate duplicate code in tdx_clear_page()
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, pbonzini@redhat.com, vannapurve@google.com, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kas@kernel.org, kai.huang@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@linux.intel.com, 
	binbin.wu@linux.intel.com, isaku.yamahata@intel.com, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Adrian Hunter wrote:
> tdx_clear_page() and reset_tdx_pages() duplicate the TDX page clearing
> logic.  Rename reset_tdx_pages() to tdx_quirk_reset_paddr() and create
> tdx_quirk_reset_page() to call tdx_quirk_reset_paddr() and be used in
> place of tdx_clear_page().
> 
> The new name reflects that, in fact, the clearing is necessary only for
> hardware with a certain quirk.  That is dealt with in a subsequent patch
> but doing the rename here avoids additional churn.
> 
> Note reset_tdx_pages() is slightly different from tdx_clear_page() because,
> more appropriately, it uses mb() in place of __mb().  Except when extra
> debugging is enabled (kcsan at present), mb() just calls __mb().
> 
> Reviewed-by: Kirill A. Shutemov <kas@kernel.org>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

...

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 7ddef3a69866..57b46f05ff97 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -131,6 +131,8 @@ int tdx_guest_keyid_alloc(void);
>  u32 tdx_get_nr_guest_keyids(void);
>  void tdx_guest_keyid_free(unsigned int keyid);
>  
> +void tdx_quirk_reset_page(struct page *page);

Might make sense to have this be a static inline so as to avoid two exports if
KVM ever needs/wants the inner helper, but either way is a-ok by me.

Acked-by: Sean Christopherson <seanjc@google.com>

