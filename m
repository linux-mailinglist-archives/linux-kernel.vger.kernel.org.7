Return-Path: <linux-kernel+bounces-748209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E9B13DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C10189DD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5AE26FD9D;
	Mon, 28 Jul 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNYDF3Ai"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A8237163
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715333; cv=none; b=h4buHjVL2VXnUSkhbbuAJX7RIODU5nc5dNNoUsEayTu3YQx2MFXr8iWPOacSFelc8MrmwozZ7UI3GMwQ82GC5p/EoqC/BTHhrO/Mc8DA4Yda7mk/ksUErRLb+/xHxxd+YxlVMawH1Ze7ZLXeNkdAgsYDMDF+YeWukSr/iYqLB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715333; c=relaxed/simple;
	bh=jLMUpIThVRj9B99qwbkaCZZddI1mjJuIMA2gVWp64EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V42ECAM/IqQ6auDLdMbrgRs9TreFjQjAh4I+HtTibgjaFydDCbo/vlxaXLD2M3revnfEI/ZMeFFTETpY63nmibUBeCg4tgHGAEbCUH7e71xFxxN8eZXxLj6KFaRPryvC28O+WmJxxxe9HBQJyj31uAzBGk5QH8Y/Ez3KtDQ+C3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNYDF3Ai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753715330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeLrAEmcy9a/KrwIPIKDCcX/OKOyUI8WSyV8CWftljI=;
	b=DNYDF3AiFq1W21TrtEhaVMbTKMlvIXyJeK0tMBIsKdXWIVLH1q+4u95I6dya7v75WjhpeB
	D9HHdxPmTclfU2mXe4/Q7vjo81DyrClxlBtXkjXRJKAxqSroKy+u8rPYtD5uo+1rRBUMoI
	yc3N0q06Ax2CnTv7hkpYdxUlHC/m/U0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NfpGLdG-OI67wiFGcISXmA-1; Mon, 28 Jul 2025 11:08:49 -0400
X-MC-Unique: NfpGLdG-OI67wiFGcISXmA-1
X-Mimecast-MFC-AGG-ID: NfpGLdG-OI67wiFGcISXmA_1753715328
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2194971f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715328; x=1754320128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeLrAEmcy9a/KrwIPIKDCcX/OKOyUI8WSyV8CWftljI=;
        b=m0pg9nCDirIiAtp3RgdLezqRtMLS4nWgCNyA9dES1/apyiqOtiPdr/ys59+WnlXW4I
         s+JNv9d0yMMaSruVJkyz4Fui+7qNPWLymzyFuEctSovn9r6zfoespKTsCHAtorDsQWm2
         0r00N0wgL3w15fwsu+QGMNawRRIwWlCToo+yq8bQF5GSMe75HCS3NMRAw+mIS2t1SX78
         LLcbMXMcrtbMxIvmTx6b/0zNPhNAXxOuxvyxVnZ9K8WUp9Xhz4oFBtt40UKjF1DbH8hn
         JllrApJ5HLEsOlfUHkxomKb4rZha1E1dmv6q5z02phgp77nwJLz1pBGpab6+P5yF/aQw
         FNqg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0oAUPLqUAkN3yBw5upAgYDtXc4yB3kUeibHaHYtZq1JZUemF7flHtrlxcs8ICtEzsgtw3EIiY4HbkYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFms7u/QYKP1fxGsbEep7+6cuvOoj8HcXO0yneNxO7U2rNuMcI
	tpJ17PDNF5sJW5uCLtIhkTn8RElbj1CItQAqK6ehNP9bTams/zelqSjE8byVaeC1bUGtiZO48ex
	pBp7Hpe4LWeNuWjqojtU+oiI5AL4Q4MyC7hOpL9GSUmXPnCmBg2Be5eeOqcjQEk1peCPZi/0x9K
	rub0NXr57d1NvSsBBVBJcT4MtLrj3mVbzBRgUlU+Ev
X-Gm-Gg: ASbGncuAjb3uUk4+UBvWyU/PI8oc3/LTXeH8qpYnoMvbf0jbPoSocQ2tDTEvChdn1tv
	Q7FXZEjPwIvr/jM6WPo/Z/zMlYFidas45EdRvJThPVxp2GMWfayVm89hFn2MLGcMjYF/F54Yc0T
	Z0bbKv7gbF3kHxLYhEritmCg==
X-Received: by 2002:a05:6000:2289:b0:3b6:13a1:8861 with SMTP id ffacd0b85a97d-3b776777071mr9485023f8f.38.1753715327655;
        Mon, 28 Jul 2025 08:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFmHYpmqZ9zAX2CcX08tRRdeZpKf6Z5qzT3uq5pwtKvIAjnzoNsGEd6aRd0vCr+dPvcZ2cQOc9SfTXllEpT6E=
X-Received: by 2002:a05:6000:2289:b0:3b6:13a1:8861 with SMTP id
 ffacd0b85a97d-3b776777071mr9485001f8f.38.1753715327196; Mon, 28 Jul 2025
 08:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com> <20250725220713.264711-9-seanjc@google.com>
In-Reply-To: <20250725220713.264711-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Jul 2025 17:08:35 +0200
X-Gm-Features: Ac12FXzGVs_0x9CCSPjreZguRYWItHAnWn3AnKIBY24adXqI17Gs_Zsx6oRZp5w
Message-ID: <CABgObfay+-c+xdqA16Df-D1QzzwWry5JAjoZtF2oescoismUDg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Device assignment accounting changes for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 12:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Two changes that depend on the IRQ and MMIO State Data pull requests, to =
kill
> off kvm_arch_{start,end}_assignment().
>
> Note!  To generate the pull request, I used the result of a local merge o=
f
> kvm/next with kvm-x86-irqs-6.17 and kvm-x86-mmio-6.17.  The resulting sho=
rtlog
> matches my expectations (and intentions), but the diff stats showed all o=
f the
> changes from kvm-x86-irqs-6.17, and I couldn't for the life of me figure =
out
> how to coerce git into behaving as I want.
>
> AFAICT, it's just a cosmetic display error, there aren't any duplicate co=
mmits
> or anything.  So, rather that copy+paste those weird diff stats, I locall=
y
> processed _this_ merge too, and then manually generated the stats with
> `git diff --stat base..HEAD`.

Yep, that happens. Not enough to consider writing a replacement for
git-request-pull, but it happens...

For me the problems are usually due to back-merges from Linus's tree
(mostly unintentional, like if arch1 uses rc2 as the base and arch2
uses rc4), so I just do a final merge from Linus's tree and use the
*reverse* of that commit's diffstat (git diff --stat HEAD HEAD^) for
the pull request.

Paolo

> The following changes since <the result of the aforementioned merges>:
>
>   KVM: VMX: Apply MMIO Stale Data mitigation if KVM maps MMIO into the gu=
est (2025-06-25 08:42:51 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-no_assignment-6.17
>
> for you to fetch changes up to bbc13ae593e0ea47357ff6e4740c533c16c2ae1e:
>
>   VFIO: KVM: x86: Drop kvm_arch_{start,end}_assignment() (2025-06-25 09:5=
1:33 -0700)
>
> ----------------------------------------------------------------
> KVM VFIO device assignment cleanups for 6.17
>
> Kill off kvm_arch_{start,end}_assignment() and x86's associated tracking =
now
> that KVM no longer uses assigned_device_count as a bad heuristic for "VM =
has
> an irqbypass producer" or for "VM has access to host MMIO".
>
> ----------------------------------------------------------------
> Sean Christopherson (3):
>       Merge branch 'kvm-x86 mmio'
>       Revert "kvm: detect assigned device via irqbypass manager"
>       VFIO: KVM: x86: Drop kvm_arch_{start,end}_assignment()
>
>  arch/x86/include/asm/kvm_host.h |  2 --
>  arch/x86/kvm/irq.c              |  9 +--------
>  arch/x86/kvm/x86.c              | 18 ------------------
>  include/linux/kvm_host.h        | 18 ------------------
>  virt/kvm/vfio.c                 |  3 ---
>  5 files changed, 1 insertion(+), 49 deletions(-)
>


