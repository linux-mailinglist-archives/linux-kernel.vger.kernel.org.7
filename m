Return-Path: <linux-kernel+bounces-751767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B271DB16D30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D119189C53E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6AA2586EE;
	Thu, 31 Jul 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8FNtaWT"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB851D618A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949308; cv=none; b=tsaloxcdkiAJMcfVmUP+IsWbtxyEcMj9dr08jF+tr2Vi7RDPD4qqTShM080LLtmXZb491QV9gUudTNmAvHhtqxKgVjnIxY07blFknyR7F7yAXqILvW9yIwEksCnAEwiOnl+62u1QL2cZE41i1I/YDdQ3ot5tG1/PUIpFi4K8ebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949308; c=relaxed/simple;
	bh=e5Hocw5GiE127jmgexsLYEDO3B9Flp3i16mxz7Kb7EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+gAieDO1ZdAsdTTAUWuUKYohRRjd2NbKhpPizHfuhyCTx5KY47o7m4WuTJcziaz1k7kALEIkRhwUnsbHV3QO7qYKC8Pq5/DOYuMEAkjKvlqm+KjQQX5t3AsyNelRiwPp8ycYdg+OQGFx6PWtzVeB21CVcb0aL3YGGdJm9Uw+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8FNtaWT; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab86a29c98so204401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753949306; x=1754554106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jeno8f5+usJMV/ac339wMG/DF96hWxCd1z1Rm4i7gbQ=;
        b=T8FNtaWT/pKrGr3ueeNCqCSatd0l8pxAyn6D+Z/CxtMpT1n9j1VgcgJtLLul78pc+8
         f4wvqMX7lCiQc/xnv/ZFfOE3ocJ3nBHVybZSlQT0eedFGkVB9Q1hvbILRDLQ3mj5OV50
         IiBPqxOIukPYG854KtUBrpO50SbB0/BjyT6s5tiBnoR4VMIFrEYNOwpfGztA9BQKGk5M
         rMMYm8eWNOZzuco802yqyUM+3L3hUOq1NxlNXtKs6SH1OXXveELt6wDANT6U9QAMHAUI
         p+2zZ5gZVQ25ANDw+lu8k/QhfK2rCZfivQz2ndDg3futpaW/jYlZKCUmLUK5JrVhSpER
         edSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949306; x=1754554106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jeno8f5+usJMV/ac339wMG/DF96hWxCd1z1Rm4i7gbQ=;
        b=DDLNKf9VzDmHE3QuB+57GObz5ma5oJfH6T3O/akDoedhR0ZE7YTNRY2pI/YiEPVj+K
         8PNldh5bQaY1jelt2wzZsTfrR/7tRw5GWxIzLQm6RN8j6lt1407NbtUWDtAI04J3BKBv
         wvgmi1uvry70N70kuLWlkwWtujPrDklqh0btWLSfYqaQFsxacCEbWmWPbNsEQxhg+On/
         ygqLi6kRgkUzAwAhfhOOQWEcnr9SvWpd/QRVYciAq9JTkmcoM8l8VRTfXUjMe0YmUngp
         xDzXHEcIE62BRF6q6pFMyYzh7Zn9UkEwiW0huriFAUulQ7czZeC2hoTW8JRkMd7QZjwI
         zzpw==
X-Forwarded-Encrypted: i=1; AJvYcCVEiUKEODgaV3nrcREkwQefoFzaHn3Ld1SCikrirTiTDaMIzZmuMrUU8rf2q3J51hxvrft29/D2Y89srT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9c/UZEp3lYNo8FO2g7wnvhcr0/IvnyojsEYZkPPBj9TwiXPXK
	jvC3iq96LZxXT/tINwfyYZ0rmPYdmgEH9ypaSaNWwMCx5zMiu/84GbqTR8y1OINFudIKoy9UR8w
	ah/zR3hPUGjIXAXjd7mafiKW+Ss1YmL2pEYNlQQxy
X-Gm-Gg: ASbGncsrO04H76s+KvN45layNCBUNaaoEguUDNospdme2xDVlLkeemaQLHmHois0Jwn
	3rB/YXO1gqO/eno6oB4lQpeBePZ6wplMFf5V0R3Zo72558qFUFMaD8QOxj3KMEAI0Stk0D5C3uJ
	AfZQHlqNHHqtOOCq/Rsf7ieNBS/qc2UDQzCqhwASnj7kKdIkQpUcJZ/qXZj2SptOtxmvc687ubU
	R3+Pug=
X-Google-Smtp-Source: AGHT+IFbmVQN1x5b+62iRQ3U8XZDUkGVQZbiaLNVWtLXncLKF5qCofgpdoCiMDPvbq7m8yKnT95C2PAE3uUVd0hLcc4=
X-Received: by 2002:a05:622a:13cd:b0:4a6:fc57:b85a with SMTP id
 d75a77b69052e-4aeeff89123mr2556921cf.14.1753949305731; Thu, 31 Jul 2025
 01:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-5-seanjc@google.com>
In-Reply-To: <20250729225455.670324-5-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 31 Jul 2025 09:07:49 +0100
X-Gm-Features: Ac12FXy0R_yNTeBd7qrXPHZNFcLfR6ujjjzcWA_Yc7EECI6d3AjDyGMKsJvuKKg
Message-ID: <CA+EHjTxHk4hsPXDiUY2nOfGdT9GjPvu7YdNKApkUJK4RjBKB4Q@mail.gmail.com>
Subject: Re: [PATCH v17 04/24] KVM: x86: Select TDX's KVM_GENERIC_xxx
 dependencies iff CONFIG_KVM_INTEL_TDX=y
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
	Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 23:55, Sean Christopherson <seanjc@google.com> wrote:
>
> Select KVM_GENERIC_PRIVATE_MEM and KVM_GENERIC_MEMORY_ATTRIBUTES directly
> from KVM_INTEL_TDX, i.e. if and only if TDX support is fully enabled in
> KVM.  There is no need to enable KVM's private memory support just because
> the core kernel's INTEL_TDX_HOST is enabled.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---


Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/kvm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 402ba00fdf45..13ab7265b505 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -95,8 +95,6 @@ config KVM_SW_PROTECTED_VM
>  config KVM_INTEL
>         tristate "KVM for Intel (and compatible) processors support"
>         depends on KVM && IA32_FEAT_CTL
> -       select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
> -       select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
>         help
>           Provides support for KVM on processors equipped with Intel's VT
>           extensions, a.k.a. Virtual Machine Extensions (VMX).
> @@ -135,6 +133,8 @@ config KVM_INTEL_TDX
>         bool "Intel Trust Domain Extensions (TDX) support"
>         default y
>         depends on INTEL_TDX_HOST
> +       select KVM_GENERIC_PRIVATE_MEM
> +       select KVM_GENERIC_MEMORY_ATTRIBUTES
>         help
>           Provides support for launching Intel Trust Domain Extensions (TDX)
>           confidential VMs on Intel processors.
> --
> 2.50.1.552.g942d659e1b-goog
>

