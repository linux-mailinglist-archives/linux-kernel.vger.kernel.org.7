Return-Path: <linux-kernel+bounces-751768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB156B16D32
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0676581E53
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03A29CB32;
	Thu, 31 Jul 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6t4/6Oj"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B0C1B0439
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949338; cv=none; b=uLLocbMgIq3fIFen/Z0BVFuRf5YjVSRotimZOhtJ0sa20ymZAx2bpb10P6E+ptuqNhhZs0xgcPpQ+kv4E3hj6oQt3HPzCY2XlSUxDpyA/e1y/l+sOBcHBncD9OX7PBWOxVqPrQz3DUOPpP8rGe7I/0+PCljtg58hPH56q/pU0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949338; c=relaxed/simple;
	bh=sOdpA6ePDmomXzo1Y2B+Mmkj9rNOUEog8vH9h84ed5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK7F+YrQ+j7vaI9sSN+IY+RdtBxSVhebDudZP0L8wa7LgXbY4GCJliL6pv0Pg1NP+3QNoGoT5XVqmvZI7ZdvRNFjgLq8WuhAAaw0lNM97srJUL3VfDYN+e5uqkvRUR/de/uvpHz27ZJjVFEb9wzDpkfB7df8xmgOZmvewc2mGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6t4/6Oj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso274311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753949335; x=1754554135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnPE+sz1C/80U9yCW9/f/ei/+/2FFUemOvS6oEBnVic=;
        b=U6t4/6OjsX5U1G5ai8+ikOloVpbviPj9OuJXZ3x2wsSf+8t2Hul3wUkzAE8b20BGZ/
         bgj0A4OWRC/d3D+a2IUvsBf/5aGtJxmaNPJowlyffasSKficV9I9sBORINMhHPnddMnV
         /W5vA7UDtMqmHJfoLt/8uRF4cjeM8LAomz3s1TUJsz0D0pcPVy9DhyQPk6VzMQ4v8B/G
         uG+QlWb8jhklVswmcVBbL3BGsULdDzcy73TBGV0fc4rP6bJZiZoeOeF28O+0V7Mun/kt
         5hu4lbXJhk3Ujm2F/Vr0PmMsDTGojHeh5+drYoRivuC6GQ35KT+9lS4Qn9NvfI+Y4RK1
         Gt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949335; x=1754554135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnPE+sz1C/80U9yCW9/f/ei/+/2FFUemOvS6oEBnVic=;
        b=cCIED5ocAu+o7tubbpj9ywTT8MA64kRIVU4GljDm/a6jBUuSWzZQz4bveEU64HV0/T
         4l5/bPZUEQEBzTwgF3Ua8pupeX9Rk41Y+vXHrDSxxUrWdU6gPcTNIdfbvgqNAahqhcNT
         LtZgggo19UVKctwYpBKSQP2MfViuWFER+AUg4/YLfXXTBrl3FA+vnHSTdmZAr4LC8+tV
         ITYEMn5v2A2zE3Xeo+995lMY9q6QitT2SrW4hVeeuTwLXjD6clP58jjTXA7fNCBrLeQy
         QzQRnIZoE4ILtZhCs4bHgjV82I00L38to23dymMKfyPQ1wfsLVu2hSiNsgMjzecC3uJz
         Jq+A==
X-Forwarded-Encrypted: i=1; AJvYcCX6dy1aGA7Zz1fgFGIGQwFP8O78vO1UeL4aq0pEQ2g/stVlWIzCz/fHS9Hfb7GwB/LN3bTHmtcNYBJ6MEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YTzm3MA6IK0NODBqFmHLHMMPbVWyc0M7d4N5Ti2O2qFG0P6p
	g2bqJfNfex++YEkufe9Qpg/5D0XAhO0aeD4xZSVdoSTtZ1EQDi02+vgHGtt2BTetYmbEolMtMNi
	GP60VdmVF73aF8byFfKyVwolNkXd3F2sIQcjVi8EY
X-Gm-Gg: ASbGncu99ZCwz+j02mdbPR7kPW7P7u/FvpI0bqoYFbR71RjQhS84MPTmNny/7etNlZN
	5/j8ERc+0XWlnd+V+Jw9e0S8MT6LCbf3lLPL68YPyfP6RyyJ3alXuZwoiFC6iX2O2+G5VlJtY+I
	fMupuqid4Iy0rTswtu6wpvqpk4oVC42hOUXmj/V5MUrBt6DBDWpP+Tv1AKydOvHwpktcMhjt6aN
	4XNQfE=
X-Google-Smtp-Source: AGHT+IFK/wJp553R4XjzZSWJ+dcd/8ojrcK2vt8dKw6Dg/D6YDKGLkDZhQfaq4WdtYxdsAtQNGiLyd6uqBH+0njZkJk=
X-Received: by 2002:a05:622a:178c:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4aef1c6158fmr1665301cf.9.1753949334737; Thu, 31 Jul 2025
 01:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com> <20250729225455.670324-4-seanjc@google.com>
In-Reply-To: <20250729225455.670324-4-seanjc@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 31 Jul 2025 09:08:18 +0100
X-Gm-Features: Ac12FXwMtfUYkRsjJ3iXPfnzRPX0pAHczqzVmU7Q3OVeBtET53NBzRBcYs_fBLw
Message-ID: <CA+EHjTyZx5pU6Qhe8HNw_ciGXDVfasaD6eBnofSfUJk3VnbzTw@mail.gmail.com>
Subject: Re: [PATCH v17 03/24] KVM: x86: Select KVM_GENERIC_PRIVATE_MEM
 directly from KVM_SW_PROTECTED_VM
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
> Now that KVM_SW_PROTECTED_VM doesn't have a hidden dependency on KVM_X86,
> select KVM_GENERIC_PRIVATE_MEM from within KVM_SW_PROTECTED_VM instead of
> conditionally selecting it from KVM_X86.
>
> No functional change intended.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---


Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  arch/x86/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 9895fc3cd901..402ba00fdf45 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -46,7 +46,6 @@ config KVM_X86
>         select HAVE_KVM_PM_NOTIFIER if PM
>         select KVM_GENERIC_HARDWARE_ENABLING
>         select KVM_GENERIC_PRE_FAULT_MEMORY
> -       select KVM_GENERIC_PRIVATE_MEM if KVM_SW_PROTECTED_VM
>         select KVM_WERROR if WERROR
>
>  config KVM
> @@ -84,6 +83,7 @@ config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
>         depends on KVM_X86 && X86_64
> +       select KVM_GENERIC_PRIVATE_MEM
>         help
>           Enable support for KVM software-protected VMs.  Currently, software-
>           protected VMs are purely a development and testing vehicle for
> --
> 2.50.1.552.g942d659e1b-goog
>

