Return-Path: <linux-kernel+bounces-721829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AEAFCE47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9A7422981
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED52E0923;
	Tue,  8 Jul 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwVvK5v8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5D2E0914
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986424; cv=none; b=kozgQR+mLdKZwzegKx5EUlFhX05Q3TfLWnHCphm2EUuK34VIDuCXWNSYpBSU9Xb72kRinaFe4Kvj10HEXxcYFWYAFVVYsRlLFUqDvnWrpTnbvEdliFZG6WdJ8HPr41lPfXqFszhh+bUXYciekbtebDDhiQPV0RDM+QyUB4uKlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986424; c=relaxed/simple;
	bh=d7gbSEXI43GBTfZOdsHtl52JHaIzxl8mG4ZoaZZRJe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PY64kGru0te7Z2U8ZadJf3ra73iloI4Mb+TcekJ3gx1TMqJEP0MqI3tPs4Y+qzDEWpYPAHqSFzaxY8Yenu6hrxrXNW8HLUPtAljHKXKJECsGZS2CqdKxigqVaC5T0M/nuTFqdq4VGNB+r84hqlqxzoVMeN0B4NYnZXxbYDlMaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwVvK5v8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751986420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3gWcJzt2OgQaD/j6Pq/hyKgRUxk20XSr1dWAvhw+P4=;
	b=iwVvK5v8ofZ67sNSXxilE4nBDLGMcyA4oe8ZacH/zom9xKeLBG//4u/y25hTtZUFawK5Ry
	vrSl+pAQ0Rji8VQ25uddQHQXaqLyMnXGraMEH0ljsnqghKN8ZLUZqlUH54fy+5ugfP25RX
	6mtuR+jmIrz/vrD3EjhnHoqlTp+U2t8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Qn7UfTL4NyChSGQF2Y-Q4Q-1; Tue, 08 Jul 2025 10:53:38 -0400
X-MC-Unique: Qn7UfTL4NyChSGQF2Y-Q4Q-1
X-Mimecast-MFC-AGG-ID: Qn7UfTL4NyChSGQF2Y-Q4Q_1751986417
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso1949893f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986417; x=1752591217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3gWcJzt2OgQaD/j6Pq/hyKgRUxk20XSr1dWAvhw+P4=;
        b=Xwg55iq9pCcRXiixlej5u/8AbDlT4ELABiBOApwZpIgDRwqfitarxY0MGls8u5zRd3
         n7GyoWEkTqrVy061VvucueV+pYdgc2dJrZzgb2dk+nRIhuBSLce2cw//YptYUzaIkFV/
         1N+EmjLliR92Wnawj+2i91InXegjPuVkaJg0L9FDzRnC420rv7Y4JwPHWqAfQHEIcr9O
         lwcvf8soj+qhD093KZgg4t/DXNlV8Fext/ZCBkeliusFv5VW4dfjMgy0OwrFsIwpTtMe
         VmFAM7M+7JZkT7aRXNnmuaax8bO3umZzdgJnH9qRC82BGQadrS4Y5F1yD94O+91RR0gc
         DpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfsCZSrxYRBzV6I28CPl1UeDQyhvD1nhiTgWO9e2dx4ojDXtHbpi7V8awMwZVZyiQC+HPbAVPBJE0lZDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRJpS4sIiGk/W3m1htTbwDXZDEDFCz0cDVAVYnhxCua0JQ3Ca
	BelabH56P00RBRbN3xZ8C8PF530yB18zT5mmvqfWMrG9AkQr+hHRoNdCS94jIFw1wjo3wRZNjV/
	qS9b8vtcfEPFx7WczDJ892xLJJVe5nL39VoXy+zEzKlmkvYErVScvndLYU6QU1FztrK0quY4o4d
	Y7X1RvK0QpRyvNlKFnhAw3ppDmIXeGe6qcEU2DeIzy
X-Gm-Gg: ASbGncvM/IoJq3vOwbZvY3hHqKcQZERIW39nJmqP0cAby+weakRW36Gt7JJ3YnlNcTb
	TdzGQlkOH7GstWo0NX7/q5cxVAi0o8sWzAwmyDLq54HvBSf7liMJQR/1Ayk4hmHoMA+XlgeNsQy
	JPZg==
X-Received: by 2002:a05:6000:25f8:b0:3a5:1410:71c0 with SMTP id ffacd0b85a97d-3b5dde8bc28mr2590923f8f.38.1751986416892;
        Tue, 08 Jul 2025 07:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg3GmJ0S1o2rJ6zUsGGi+EaAx8edXiRPCdL8Si/WJUjuf8mbyhxY1fg84y1pk7fznC+2FEzhd0WZ1UFOXwtxY=
X-Received: by 2002:a05:6000:25f8:b0:3a5:1410:71c0 with SMTP id
 ffacd0b85a97d-3b5dde8bc28mr2590899f8f.38.1751986416369; Tue, 08 Jul 2025
 07:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626223142.865249-1-seanjc@google.com>
In-Reply-To: <20250626223142.865249-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Jul 2025 16:53:24 +0200
X-Gm-Features: Ac12FXx-DcAtBfbayKvwyU5qyZxOC1zIlmf0cVeiOP-SXoMxreAmZGSLm7CcTLg
Message-ID: <CABgObfaF7Usi=UfreXDwRdnjXZ-zq4PT4bumOXb_Up1cD_UD9A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 6.16-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:31=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Please pull a random smattering of fixes for 6.16.  Note, the SEV-ES intr=
a-host
> migration commits received your "Queued, thanks", but they never showed u=
p in
> kvm.git.

Ouch, sorry about htat.

> Oh, and there's one more fix that is probably a candidate for 6.16, but I=
'm
> waiting for a response from the submitter, as I think we can go with a mo=
re
> targeted fix: https://lore.kernel.org/all/aFwLpyDYOsHUtCn-@google.com

Yes, I agree with you there.  I see no reply from Yuntao, so let's
decide tomorrow what to do about it.

>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.16-rcN
>
> for you to fetch changes up to fa787ac07b3ceb56dd88a62d1866038498e96230:
>
>   KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush (202=
5-06-25 09:15:24 -0700)

Done.

Paolo

> ----------------------------------------------------------------
> KVM x86 fixes for 6.16-rcN
>
>  - Reject SEV{-ES} intra-host migration if one or more vCPUs are actively
>    being created so as not to create a non-SEV{-ES} vCPU in an SEV{-ES} V=
M.
>
>  - Use a pre-allocated, per-vCPU buffer for handling de-sparsified vCPU m=
asks
>    when emulating Hyper-V hypercalls to fix a "stack frame too large" iss=
ue.
>
>  - Allow out-of-range/invalid Xen event channel ports when configuring IR=
Q
>    routing to avoid dictating a specific ioctl() ordering to userspace.
>
>  - Conditionally reschedule when setting memory attributes to avoid soft
>    lockups when userspace converts huge swaths of memory to/from private.
>
>  - Add back MWAIT as a required feature for the MONITOR/MWAIT selftest.
>
>  - Add a missing field in struct sev_data_snp_launch_start that resulted =
in
>    the guest-visible workarounds field being filled at the wrong offset.
>
>  - Skip non-canonical address when processing Hyper-V PV TLB flushes to a=
void
>    VM-Fail on INVVPID.
>
> ----------------------------------------------------------------
> Binbin Wu (1):
>       Documentation: KVM: Fix unexpected unindent warnings
>
> Chenyi Qiang (1):
>       KVM: selftests: Add back the missing check of MONITOR/MWAIT availab=
ility
>
> David Woodhouse (1):
>       KVM: x86/xen: Allow 'out of range' event channel ports in IRQ routi=
ng table.
>
> Liam Merwick (1):
>       KVM: Allow CPU to reschedule while setting per-page memory attribut=
es
>
> Manuel Andreas (1):
>       KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush
>
> Nikunj A Dadhania (1):
>       KVM: SVM: Add missing member in SNP_LAUNCH_START command structure
>
> Sean Christopherson (3):
>       KVM: SVM: Reject SEV{-ES} intra host migration if vCPU creation is =
in-flight
>       KVM: SVM: Initialize vmsa_pa in VMCB to INVALID_PAGE if VMSA page i=
s NULL
>       KVM: x86/hyper-v: Use preallocated per-vCPU buffer for de-sparsifie=
d vCPU masks
>
>  Documentation/virt/kvm/api.rst                     | 28 +++++++++++-----=
------
>  arch/x86/include/asm/kvm_host.h                    |  7 +++++-
>  arch/x86/kvm/hyperv.c                              |  5 +++-
>  arch/x86/kvm/svm/sev.c                             | 12 ++++++++--
>  arch/x86/kvm/xen.c                                 | 15 ++++++++++--
>  include/linux/psp-sev.h                            |  2 ++
>  .../testing/selftests/kvm/x86/monitor_mwait_test.c |  1 +
>  virt/kvm/kvm_main.c                                |  3 +++
>  8 files changed, 53 insertions(+), 20 deletions(-)
>


