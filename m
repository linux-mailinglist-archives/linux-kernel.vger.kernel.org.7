Return-Path: <linux-kernel+bounces-837991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB03BAE2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF5B16CEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A571230CB53;
	Tue, 30 Sep 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzoFtb8Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66457242D60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253332; cv=none; b=GlhuORcmU+AvVwt33yTYAVF5oiVKlmz7vVgBi9vkQMQmtG1S60J7w+MnzjSLRiKH7ZyOzbme6/MAtbie64hzGSQvTRD7a1FMLy2NTbK5VZQeDprOmQJqp6/HEQU98sCUNkgWgZIWbXZpqu0Ux/4yOgCRTEYZb9Ua8APNGuTwxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253332; c=relaxed/simple;
	bh=w+3JqlmYLBBaTPiRVhxtcMb1NY5LUZdawsa8jq03Mjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jr7xezaVMZiyIocgCudUXQdxHgQPLq5YBR5AlcAHYnsaUpotTaw9l13k1pPaVEU6Zhxb72u55MBxl6S99O13D5ga7L3fFzlM1l1/wcANboVE5R3BJa6JiOuRdzWiYMD/oLBC5L30G5C9nls8xK40DZpZQkIPVPMG3A4pRsVKMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzoFtb8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Smit4RXry3tFgHAJJpMhFeA2qbWR/NaaUjNlw4h6iKw=;
	b=YzoFtb8ZsoO3eYoWSxeaEzE9K6fu6ddw/zy+oKo+4ogvH7XXXJPoFCv/uonXZb/PPLQqgg
	lgYymstmzoHn7CBPZgiDMkaV4OeFjDgIRzWBhHlN3ufcENMxsJxCFnRpf4qGZVfvAjPnK0
	UW3Jges5Sgcom5FeEO+a6wOqMgQJZII=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-lZnyU_dONceV1Rtf0GPR6Q-1; Tue, 30 Sep 2025 13:28:47 -0400
X-MC-Unique: lZnyU_dONceV1Rtf0GPR6Q-1
X-Mimecast-MFC-AGG-ID: lZnyU_dONceV1Rtf0GPR6Q_1759253326
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso3057545f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253325; x=1759858125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Smit4RXry3tFgHAJJpMhFeA2qbWR/NaaUjNlw4h6iKw=;
        b=rr4G9zJjxTg3f3wzJQnMYsK/UwTNjoJUoxL7v9VIA1o4MH0qZDo+NtjNuIFpwzi5z5
         E30INU/xCgMGs/SXf1g479sbj2wwAq/YcaT+cGh28x0OmlYSAAdrWdhunr+tVKgXTIki
         MPzW866kd8kM4MCE2U3yGataXCD1TF9sz2ktO6R6CJOesNf5G9xaNgOj2S28ciX9GYYS
         2RPIbWqzoX5DdVFzpD4Q3qTTQ++TE+7PnW7B2qm5WJTdsavyx7ewiEA1r7/tsQ4DIiCc
         xryD3OAlm1jW4Iza4YawrxeNrsa/E/ENZ1ODY1Z3DVEvAshHZ3+5y1khkDWcqP+n0OKz
         qNyw==
X-Forwarded-Encrypted: i=1; AJvYcCUU5k4I+R5IV6aIFmbF3M5uoiB1FwZjTx5mXdCJrTWfjjRsI87EKBtsuxjHSgEv521NxUllrIIEeeUV1g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUDsAVSNn3hXIXvitmtEbD01mDMcLzFexYvyi2Mu/JJ3MW3qO
	e0zYBlPbtvpL5evgRbVxLYjWahS8kK/7nMC52+5/b106qok3yBasUoxW62xjcV0g3IyXkQ6ARgL
	SMcwRC57vi7FgjSgz6bTBhyI8egGaSuZMAnBPwnSgU05GOy84Q9Mwb4lVE6rpXqujhm1gtCTt+E
	Ky45MRRPrPQOk3w7mI7I3yCaq4vpKwpkVjaiRIoh09wfJEk8Zd
X-Gm-Gg: ASbGncsBZlefRQx7eT294hEWy1qp3mmnnAqCZb92gmD3o4SAGXZnbxrv/+J6PZO+ab+
	SGVzCWIbnIOjFcwL2w0fKPxJ1XFM9MfjFIB332tyG6u5cRMjsAOCC3qMuy5ACnqyc5LCU8Lid4Z
	IGzJTE758h+29ihMjhctOu8hJ5SCFrHt2tkBOmHUjzw3t7SqrzJfkbnq1NVb0Ks2jDFmk1XI8J+
	mwgTmPpQr/2yma3hOOiRDCrVsEqTHO6
X-Received: by 2002:a05:6000:1ace:b0:411:f07a:67fb with SMTP id ffacd0b85a97d-4255781e1a0mr454525f8f.55.1759253325053;
        Tue, 30 Sep 2025 10:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmJ227aXi221B0wP/BG4vCRwommHhr+79J7w8MzBC7UzOaOiz5JLAhCW5UrWSIpkXDSn6jxqy4zs5ZgKeHLRo=
X-Received: by 2002:a05:6000:1ace:b0:411:f07a:67fb with SMTP id
 ffacd0b85a97d-4255781e1a0mr454509f8f.55.1759253324648; Tue, 30 Sep 2025
 10:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-2-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:28:31 +0200
X-Gm-Features: AS18NWBWhwEGLYreLcKc4mzuFPFEtfbSQww3AWhTkQ-epQgX-DO_hoIEQ2oh5nA
Message-ID: <CABgObfb_vRm+WgR_i_BNrhfs_nt46W=ZvFgjuwnn4P5fYfeQXg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/kvm: Guest side changes for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A few smallish guest-side changes.
>
> The following changes since commit a6ad54137af92535cfe32e19e5f3bc1bb7dbd3=
83:
>
>   Merge branch 'guest-memfd-mmap' into HEAD (2025-08-27 04:41:35 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-guest-6.18
>
> for you to fetch changes up to 960550503965094b0babd7e8c83ec66c8a763b0b:
>
>   x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV=
_UNHALT (2025-09-11 08:58:37 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> x86/kvm guest side changes for 6.18
>
>  - For the legacy PCI hole (memory between TOLUD and 4GiB) to UC when
>    overriding guest MTRR for TDX/SNP to fix an issue where ACPI auto-mapp=
ing
>    could map devices as WB and prevent the device drivers from mapping th=
eir
>    devices with UC/UC-.
>
>  - Make kvm_async_pf_task_wake() a local static helper and remove its
>    export.
>
>  - Use native qspinlocks when running in a VM with dedicated vCPU=3D>pCPU
>    bindings even when PV_UNHALT is unsupported.
>
> ----------------------------------------------------------------
> Li RongQing (1):
>       x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective o=
f PV_UNHALT
>
> Sean Christopherson (2):
>       x86/kvm: Force legacy PCI hole to UC when overriding MTRRs for TDX/=
SNP
>       x86/kvm: Make kvm_async_pf_task_wake() a local static helper
>
>  arch/x86/include/asm/kvm_para.h |  2 --
>  arch/x86/kernel/kvm.c           | 44 ++++++++++++++++++++++++++++-------=
------
>  2 files changed, 30 insertions(+), 16 deletions(-)
>


