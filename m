Return-Path: <linux-kernel+bounces-824959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A14B8A90B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD11D1CC3460
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D55321279;
	Fri, 19 Sep 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXMtji/i"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B717B50A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299330; cv=none; b=XWNcISS+y5gDwOe8aUaCS6YWPXGKN1lv1Wqk/POm6MPSQIZrSKWuxsgWIvhoXgRs9hS0QPGH5lJCTECb5VlWRrYwD3NTXBE4bJRUu1qT+01raHPuFIPiEHJTT6/xMTzWoEDuiUC4wFCKSp5mS+rlHD/30klzzajtvD3gHHQ0e+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299330; c=relaxed/simple;
	bh=voFuRsL4YLr59jMmHqSbikmA59tmWW9OVELATF5uhA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQBMFypl3JP6bYXuIn8lr6d+IWcfXgayZVqQK+5ri+zpA9An48LctjNIcc5klFrcE6ZHyAJKf+jo9AaSgNaZylgCgU6M27WHyxgdXrjmKVPruueggCv7N4wA5UBXHcKA+elND6QTOPQsECoAe0i9aIKqRk5cZxLairr4x5RZ4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXMtji/i; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so2407444a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758299329; x=1758904129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sw6lXKewcpgRc9hHImvoDhh3kWLFx8kqA2O7oPsouqI=;
        b=UXMtji/iv/bBepdH7PEtp4nNHKPDb1gk7B8+m4zJgXxfqJuqvJYgK+xX+AjOjm8dV9
         YxnJFWHsfIVlM8FbtO8p4+L7J/SySfvoVV1fjbFqoYmtmnRJrLWWJ8gxjAf3q9yYfqlP
         f6XnPGgLW9lljvsFAgysA1AHG7Pll0Jl6fpS64J8ZVDsvEr0+EDaNGjheqdZD5781nsm
         1vLhcWYBoxoEXKxFj41O1Iz6hfs1vcHGXiPl8GzeSDgzbfJMVtNEiffo7mJnzGCNadXW
         VXvj4kt/W/lvRUpnuxDCTxvH/T8689OnGUvZTvhnGQRUAKMCb8I6tCYb7gHbeYof9c3M
         pSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758299329; x=1758904129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sw6lXKewcpgRc9hHImvoDhh3kWLFx8kqA2O7oPsouqI=;
        b=xAMLfnpX9o9BqQdZumLx5LAo+377vXkq9vgO/BCIC/OSmeHuFswx3/RMPWJ3LtH6Pt
         hpguobqVaGJbl/sre++sE56JuCw2dwcQXHJINmP6YXecsdLsAN1Xx727ZJjG2jVWFOxQ
         eF4eTjlS62LOeapBLO8BBRzLYvytcPGvTGmuQJAWMZIkPk+JJzy9izgQkfc2Cy6a75NS
         kn7fnuqVAHQpklbHBYLhyQpct2WSVK0q9xlOGILrNHWBHEnImQhlpHjSJ4FW28J1iFv+
         FoWV9JjPPM3b6MZG0bGytsqNpNW3NFOur/9kEyPUGgcBSDzn2XXa9ZCyVBAVMSc4NYAi
         3jJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV3LRIyF+pz7tYYy/cNSrwQVCTe3WIMBo6Ow3rT2kg5lQUXx4Pt4f1POm+uXP0+vEme9x5T0Z+opwZcjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9Yc+20nB1J7vMGaBD20Z/lIZ/zQnvgUE+Xnj6AUXX5yec3S0
	ITJEZYSLoakUDlkwEm+6kHXblpCjmv9/9LBUCRSlWkRiILy6A7dU/MDRvQQdL2pl8fOIOqT9qqy
	OCksPTw==
X-Google-Smtp-Source: AGHT+IGYI3+Xma4Db54oaTtVFazxlb7LiWgLNq+frsJSnslA1h6CdOP5MjI00kEeR1AOEplv4KFCdMULkjE=
X-Received: from pjbqx7.prod.google.com ([2002:a17:90b:3e47:b0:32d:dbd4:5cf3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fc4:b0:32b:8b8d:c2c6
 with SMTP id 98e67ed59e1d1-33097ffa20fmr4777104a91.14.1758299328797; Fri, 19
 Sep 2025 09:28:48 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:28:47 -0700
In-Reply-To: <05a018a6997407080b3b7921ba692aa69a720f07.1758166596.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <05a018a6997407080b3b7921ba692aa69a720f07.1758166596.git.houwenlong.hwl@antgroup.com>
Message-ID: <aM2EvzLLmBi5-iQ5@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Add helper to retrieve cached value of user
 return MSR
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Hou Wenlong wrote:
> In the user return MSR support, the cached value is always the hardware
> value of the specific MSR. Therefore, add a helper to retrieve the
> cached value, which can replace the need for RDMSR, for example, to
> allow SEV-ES guests to restore the correct host hardware value without
> using RDMSR.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/x86.c              | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cb86f3cca3e9..2cbb0f446a9b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2376,6 +2376,7 @@ int kvm_add_user_return_msr(u32 msr);
>  int kvm_find_user_return_msr(u32 msr);
>  int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
>  void kvm_user_return_msr_update_cache(unsigned int index, u64 val);
> +u64 kvm_get_user_return_msr_cache(unsigned int index);

s/index/slot (the existing helpers need to be changed).  The user_return APIs
deliberately use "slot" to try and make it more obvious that they take the slot
within the array, not the index of the MSR.

>  static inline bool kvm_is_supported_user_return_msr(u32 msr)
>  {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6d85fbafc679..88d26c86c3b2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -675,6 +675,14 @@ void kvm_user_return_msr_update_cache(unsigned int slot, u64 value)
>  }
>  EXPORT_SYMBOL_GPL(kvm_user_return_msr_update_cache);
>  
> +u64 kvm_get_user_return_msr_cache(unsigned int slot)

I vote to drop "cache".  I don't love the existing kvm_user_return_msr_update_cache()
name (or implementation).  I would much rather that code be (I'll post a separate
patch) the below, to capture that the "cache" version is performing a subest of
the kvm_set_user_return_msr(). 

void __kvm_set_user_return_msr(unsigned int slot, u64 value)
{
	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);

	msrs->values[slot].curr = value;
	kvm_user_return_register_notifier(msrs);
}
EXPORT_SYMBOL_GPL(__kvm_set_user_return_msr);

int kvm_set_user_return_msr(unsigned slot, u64 value, u64 mask)
{
	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
	int err;

	value = (value & mask) | (msrs->values[slot].host & ~mask);
	if (value == msrs->values[slot].curr)
		return 0;
	err = wrmsrq_safe(kvm_uret_msrs_list[slot], value);
	if (err)
		return 1;

	__kvm_set_user_return_msr(slot, value);
	return 0;
}
EXPORT_SYMBOL_GPL(kvm_set_user_return_msr);

> +{
> +	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);
> +
> +	return msrs->values[slot].curr;

This can be a one-liner.  How about this?

---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 17772513b9cc..14236006266b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2376,6 +2376,7 @@ int kvm_add_user_return_msr(u32 msr);
 int kvm_find_user_return_msr(u32 msr);
 int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
 void kvm_user_return_msr_update_cache(unsigned int index, u64 val);
+u64 kvm_get_user_return_msr(unsigned int slot);
 
 static inline bool kvm_is_supported_user_return_msr(u32 msr)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e07936efacd4..801bf6172a21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -675,6 +675,12 @@ void kvm_user_return_msr_update_cache(unsigned int slot, u64 value)
 }
 EXPORT_SYMBOL_GPL(kvm_user_return_msr_update_cache);
 
+u64 kvm_get_user_return_msr(unsigned int slot)
+{
+	return this_cpu_ptr(user_return_msrs)->values[slot].curr;
+}
+EXPORT_SYMBOL_GPL(kvm_get_user_return_msr);
+
 static void drop_user_return_notifiers(void)
 {
 	struct kvm_user_return_msrs *msrs = this_cpu_ptr(user_return_msrs);

base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 

