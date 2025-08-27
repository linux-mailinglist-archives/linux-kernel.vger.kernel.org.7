Return-Path: <linux-kernel+bounces-787900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6BB37D65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBCF7C5E07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01BF322774;
	Wed, 27 Aug 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0gmDLBE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C918DF8D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282725; cv=none; b=XMPaose7zaqii6bxph2pgPdwEYG4UyUGy0/YuRHJnlhkyZVJZsqXvMkhLJjIG4sBMRxWLUbGlRta1l05tzmSgqt2Kj8X2EC7OqMxs3FG0jEx2wMfgi8KZnMnNnypEbjC4JGtwD45UtR5KoxBAD4NcNDwmrafVY5uOqNSXjXRlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282725; c=relaxed/simple;
	bh=xK7XXS6dlLGTreCj7lDc3VdpvM4B4vA0eXDYAmnYe4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbyrAs7BNGx+aHLSu04aus3OEtEDnPXdcE8QlEtaLNCQzIVjFyIRqCHOmM6hX7IwgKlP945NQKcBPtMhShTajR5zHzC7Me8M5C3ypBSShIy/Qbv11HqRp/nG9Wfx85anodUZbH39tdy8f+kESE6P9nGSUy89M22F8l+/Ax27uKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0gmDLBE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756282722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpYXMFv3OLBuc46eBmboMhIN1N7DksJ0Aq0rU5afc3w=;
	b=h0gmDLBE8xxtEJCowfG2c9gcteOlaT8mpP4PD4tqPODGwoWYts5JQiEVGQ7FB6WpRkHKaM
	PRcPwwwDDiygz68XLfrHfMscboTuTgW8ApW8zKX+PYK7Uc0NT84JvlM69bSbYZuG7TLdht
	CoQNqaVZGCZfEIMLD4GqF8NW2m76e4Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-P-McE0RUMjeWWs7pw-xzKw-1; Wed, 27 Aug 2025 04:18:39 -0400
X-MC-Unique: P-McE0RUMjeWWs7pw-xzKw-1
X-Mimecast-MFC-AGG-ID: P-McE0RUMjeWWs7pw-xzKw_1756282718
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so38914195e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282718; x=1756887518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpYXMFv3OLBuc46eBmboMhIN1N7DksJ0Aq0rU5afc3w=;
        b=FiuilZy8LHsDtqo3+DcTpgaC+2usOAJosQiuMtvnxhuVQRzH01uJhE6Xc7/Bz/98EW
         5CC/q7Wh/KvcLwJ7Lxe2m86RJjhpi1nV5L54AiNRkAxWMieb0meDUi4jQncTNjMwbxPO
         wVOZ04fsGzCAGJWT1y1O0a7HBBaTDtO/ab0AxH3/HxGPl6mmC7NwNzJnYC4tlxfuuh1K
         gXkNi6YmXvswwaPCkENpmBPiTmmnx3G5iiFiQ7l1hHEbCz0ZA/tD9kWvlfwL4BY4ZxEj
         dzDrLiXXEKdAgEt58HQ+Pva06B18BWwRnnC6yGR3dcDIne/6LDyDXWMp5BI12lgYavTt
         BBng==
X-Forwarded-Encrypted: i=1; AJvYcCXg6oKZxiVDhhrpZnVCz0zfoF6N76SscGVKlstoKEWfCrOUaVNmmrSCMzNz7EO16Wt91oyrExqVMGfQ+fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhclei/YQZG146jVkcJx+jD6ewnUeyqI8+Van89mwxUAWaOIQS
	P+tH1LF7KfueQc2gLMWuTj0LhI043QdhwPpeH3Fbomgy6RbVpm98FU4QLafy42qpxVn19FaEP8S
	sBIJKmoJ21C5N/KI82JmDDKZdAvhkS3eS1tUJWFHULpEWMJjWvJnvPKyMpsKWHMjYLTbmYyOjSL
	iprn3F9oOG6wBAQK2INW6Xk0FbjTcR7dMPXHEhDJss
X-Gm-Gg: ASbGncvneOu4DvY86gD2AGPcjsSYJkaOFm6Am3M/UKtI/Lw+Gt+gNTQJwgZszRc2YLz
	HdTnkaE1u9Mst+dUrz+FLTZJPEglRa8N58xwvVTgbX48Xz080sxYy6HQyfdQ0+dgxvUZd1o+A4p
	32VsWwRGT9LuKSnmCU+zivPrsVkSLtfRG8JmlSXZ3t2nfJYRFtDtkynieaMqOmZKcZbRjvCuylr
	irtWIauFGLDtum2ADZIGF+0
X-Received: by 2002:a05:6000:401f:b0:3cb:50f6:35da with SMTP id ffacd0b85a97d-3cb50f639f1mr3333850f8f.29.1756282718425;
        Wed, 27 Aug 2025 01:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOBYIU4e1hPC6Vt8ISO44pX2KQYI86Oiq8xuW1iLVhTH6GAM09vnq09S6YknGGrdTxKt7RGbKysN3ZPJ5A0MI=
X-Received: by 2002:a05:6000:401f:b0:3cb:50f6:35da with SMTP id
 ffacd0b85a97d-3cb50f639f1mr3333825f8f.29.1756282717945; Wed, 27 Aug 2025
 01:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821213051.3459190-1-seanjc@google.com>
In-Reply-To: <20250821213051.3459190-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Aug 2025 10:18:26 +0200
X-Gm-Features: Ac12FXwRz0Br8B68OVtxnvOOJpnjHEu659wzC7dPDYR-jEgOUR6eW_KoP95i8ME
Message-ID: <CABgObfZcSrnUb5+dhm5C38B2u56JTVh5w9-LvHMSKZNk7DzYNA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Two KVM fixes and a selftest fix
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:31=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Please pull a few small KVM x86 fixes, along with a rather ugly selftest
> fix to resolve a collision with linux/overflow.h.  Sadly, my attempt at a
> less ugly fix fell flat, as trying to share linux/overflow.h's definition
> doesn't work since not all selftests add tools/include to their include p=
ath.

Yes, I saw that from afar.

> Unrelated to this pull request, shameless plug for the guest_memfd mmap()
> series[1].  We'd like to get it merged sooner than later as there's a bit=
 of a
> logjam of guest_memfd code piling up.  And I've promised others I'll yolo=
 it
> into kvm-x86 at the end of next week if necessary :-)

Will pull it right after this one. Thanks!

Paolo

> Thanks!
>
> P.S. the guest_memfd mmap() series needs one minor fixup in patch 23[2]:
>
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index b86bf89a71e0..b3ca6737f304 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -372,7 +372,7 @@ int main(int argc, char *argv[])
>          */
>         vm_types =3D kvm_check_cap(KVM_CAP_VM_TYPES);
>         if (!vm_types)
> -               vm_types =3D VM_TYPE_DEFAULT;
> +               vm_types =3D BIT(VM_TYPE_DEFAULT);
>
>         for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types))
>                 test_guest_memfd(vm_type);
>
> [1] https://lore.kernel.org/all/20250729225455.670324-1-seanjc@google.com
> [2] https://lore.kernel.org/all/aIoWosN3UiPe2qQK@google.com
>
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.17-rc7
>
> for you to fetch changes up to dce1b33ed7430c7189b8cc1567498f9e6bf12731:
>
>   selftests: harness: Rename is_signed_type() to avoid collision with ove=
rflow.h (2025-08-20 08:04:09 -0700)
>
> ----------------------------------------------------------------
> KVM x86 fixes and a selftest fix for 6.17-rcN
>
>  - Use array_index_nospec() to sanitize the target vCPU ID when handling =
PV
>    IPIs and yields as the ID is guest-controlled.
>
>  - Drop a superfluous cpumask_empty() check when reclaiming SEV memory, a=
s
>    the common case, by far, is that at least one CPU will have entered th=
e
>    VM, and wbnoinvd_on_cpus_mask() will naturally handle the rare case wh=
ere
>    the set of have_run_cpus is empty.
>
>  - Rename the is_signed_type() macro in kselftest_harness.h to is_signed_=
var()
>    to fix a collision with linux/overflow.h.  The collision generates com=
piler
>    warnings due to the two macros having different implementations.
>
> ----------------------------------------------------------------
> Sean Christopherson (1):
>       selftests: harness: Rename is_signed_type() to avoid collision with=
 overflow.h
>
> Thijs Raymakers (1):
>       KVM: x86: use array_index_nospec with indices that come from guest
>
> Yury Norov (1):
>       KVM: SEV: don't check have_run_cpus in sev_writeback_caches()
>
>  arch/x86/kvm/lapic.c                        |  2 ++
>  arch/x86/kvm/svm/sev.c                      | 10 +++-------
>  arch/x86/kvm/x86.c                          |  7 +++++--
>  tools/testing/selftests/kselftest_harness.h |  4 ++--
>  4 files changed, 12 insertions(+), 11 deletions(-)
>


