Return-Path: <linux-kernel+bounces-724251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8EAFF07F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D95616CEE2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B3238D42;
	Wed,  9 Jul 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+AE0fp7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29C19CC28
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084529; cv=none; b=Vm2qCu50a6NOfAu7gjn9eQ5AwKNfxk9ojiulHwKvAKDTuGQyziwd2EZbYwJG+ikMapaOqqIaR8P5AZeH4tQsUmonXArOxDdaoLyXCCxdTzkgIbWb74QwpDqnFWv0HNsEQpoUL3vR/dDCdK6DDy3qUowiHpxwtQXFgPLrb88V6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084529; c=relaxed/simple;
	bh=NXywK+mmTCoC0aABwmr6OWQXb1nFsypL1uvzFH6uyJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzA3lCiPj77Kp04SAlSKPgsV9djVqKNFp9sx/+9J3EDhgXEzPGBI7Ujpjn52/nHpujWZb5zDHvPz3pzRoVJli7dRf9ziHBjpMuZrDDfs65DWMeBa1M0vX0rD96WvKxy4EVDYYgCk3MZF8sqp2r0yVHI37MXpqOmTFkEm+cqs0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+AE0fp7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752084526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti4LPRIkFOCBWTQGffTOlaGCCCvOPm5j4OoCEyc4FiI=;
	b=f+AE0fp7NL6UfSVOnRGLVTCVP1KT51HA350F5atGr1T7w4S74NKB4Ea44PGNX8v3Aqc3E3
	1MNT0p66fG5QZtthPNMDealr0j5eNwaxUD3P9fTYRVaUAmj0pb3aE/NIdXq63J/Z9jV3En
	5qaUyLeEb3Xsl8wrPIQmS53doxQPyHM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-659F1B3cN-u6XhgleawZ2A-1; Wed, 09 Jul 2025 14:08:44 -0400
X-MC-Unique: 659F1B3cN-u6XhgleawZ2A-1
X-Mimecast-MFC-AGG-ID: 659F1B3cN-u6XhgleawZ2A_1752084524
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fd0a3f15daso5785346d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084523; x=1752689323;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti4LPRIkFOCBWTQGffTOlaGCCCvOPm5j4OoCEyc4FiI=;
        b=OXbGoaCsiJaX0SMwcgqL7EFVhyf0FUzq3DWbP4/IMxcYn+73GAoFKRn1MVJcQMcvWT
         LgMIGvzJ83UbUInlrjvNhdlgyUePjtU6Ao9DyW9E68/BAOboVNqp7ZwBCrLEYgA9nt3T
         63kv306amxr4T9uRzSMz3HyEXVRniFFN2rf16RxoVXJFMTLiK98MGXB+hFtHd+MlLekP
         O6DM2vjVvgTHaDsGRfXNuyJsSSzt3TkDwY+2h3jCQ3u3pRh0PTWwdfz2Xerrut/Mk5mf
         bAgJwPXmqBLdUVYS3mLqvOALjnEufIRfsL90YqJDmNd6B9no8YzPdYa4FYdgkGcJFdmT
         nrzw==
X-Forwarded-Encrypted: i=1; AJvYcCX28G9SvwkvLPZ+i7AJHnqVICkYZ4+wBs9auAdx4wvD+2CvPhVabAWjDD1FR7NWjg3q+wv3PF+fOe917ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKEb4Frptli3T7f7ZKUHA78EFI1rdZMdcmx3veQzUjU5k8Pxm
	+h10AGNPKbkNQDmgYrelzQrDhaGX83dZ1hhTsM6ZrU9YxkDGlL5Ctk2vNb9LIWrBEIVuTfdgxol
	F1jOQ3Q8WYbCqyIJ7M2tfzIGtMacEBdMJcOoCrO8nTdH6ow6ZFa5r3qkXRR9ciNwY1m16rtf9/Q
	==
X-Gm-Gg: ASbGncu1PyKspF7uj7HY5dnupgrepA6eQAash/xy5cC8Fgunr5/3kCWN/zLB3N/aSNf
	Fn8LZZawiMWcFj78qbMAlfUZUKVmhOlLa0dezqO+gLWq7HlPv7wOhdAkLJirNHC9+ZdI3DV+cCC
	vo2YC79OTq/vFdkL+L5k0+M+cQeY4oElmjd4KLkt3ulg6/QpctYMsqu+Rf9UII6DrJzt5u94egQ
	vxLzp/T/bUpSZWU2oVMdx9MYdkRlU4p7h/ayNacfHQK81TL7D8TDiwQWx8MI8C7mWqY1CEVHIff
	S7DbK7IFi4uoJvynT5BtQ9WClyshJgEJFe4y4C2t/o1iLu1XLWVsTQmwEPhROEJhcoSE4w==
X-Received: by 2002:a05:6214:5348:b0:6f5:38a2:52dd with SMTP id 6a1803df08f44-70494fc0484mr15861396d6.31.1752084523539;
        Wed, 09 Jul 2025 11:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdeh1IV3HqtvPQTQBkoZdbTuvrxmYPDkFZPidpfSSKad4eN0FUqT4oCVisBNXt8dFjIl6NnQ==
X-Received: by 2002:a05:6214:5348:b0:6f5:38a2:52dd with SMTP id 6a1803df08f44-70494fc0484mr15860996d6.31.1752084523176;
        Wed, 09 Jul 2025 11:08:43 -0700 (PDT)
Received: from ?IPv6:2607:fea8:fc01:8d8d:5c3d:ce6:f389:cd38? ([2607:fea8:fc01:8d8d:5c3d:ce6:f389:cd38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd950a4sm975443185a.24.2025.07.09.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:08:42 -0700 (PDT)
Message-ID: <dfd970bb10235adfa2b2b545ea26bffba1ea3a66.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: avoid underflow when scaling TSC frequency
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Yuntao Liu <liuyuntao12@huawei.com>, Sean Christopherson
 <seanjc@google.com>
Date: Wed, 09 Jul 2025 14:08:42 -0400
In-Reply-To: <20250709175303.228675-1-pbonzini@redhat.com>
References: <20250709175303.228675-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-09 at 13:53 -0400, Paolo Bonzini wrote:
> In function kvm_guest_time_update(), __scale_tsc() is used to calculate
> a TSC *frequency* rather than a TSC value.=C2=A0 With low-enough ratios,
> a TSC value that is less than 1 would underflow to 0 and to an infinite
> while loop in kvm_get_time_scale():
>=20
> =C2=A0 kvm_guest_time_update(struct kvm_vcpu *v)
> =C2=A0=C2=A0=C2=A0 if (kvm_caps.has_tsc_control)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tgt_tsc_khz =3D kvm_scale_tsc(tgt_tsc_khz,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v->arch.l1_tsc_scaling_=
ratio);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __scale_tsc(u64 ratio, u64 tsc=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ratio=3D122380531,=
 tsc=3D2299998, N=3D48
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ratio*tsc >> N =3D=
 0.999... -> 0
>=20
> Later in the function:
>=20
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 kvm_get_time_scale arch/x86/kvm/x86.c:2458 [inline]
> =C2=A0=C2=A0 kvm_guest_time_update+0x926/0xb00 arch/x86/kvm/x86.c:3268
> =C2=A0=C2=A0 vcpu_enter_guest.constprop.0+0x1e70/0x3cf0 arch/x86/kvm/x86.=
c:10678
> =C2=A0=C2=A0 vcpu_run+0x129/0x8d0 arch/x86/kvm/x86.c:11126
> =C2=A0=C2=A0 kvm_arch_vcpu_ioctl_run+0x37a/0x13d0 arch/x86/kvm/x86.c:1135=
2
> =C2=A0=C2=A0 kvm_vcpu_ioctl+0x56b/0xe60 virt/kvm/kvm_main.c:4188
> =C2=A0=C2=A0 vfs_ioctl fs/ioctl.c:51 [inline]
> =C2=A0=C2=A0 __do_sys_ioctl fs/ioctl.c:871 [inline]
> =C2=A0=C2=A0 __se_sys_ioctl+0x12d/0x190 fs/ioctl.c:857
> =C2=A0=C2=A0 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> =C2=A0=C2=A0 do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> This can really happen only when fuzzing, since the TSC frequency
> would have to be nonsensically low.
>=20
> Fixes: 35181e86df97 ("KVM: x86: Add a common TSC scaling function")
> Reported-by: Yuntao Liu <liuyuntao12@huawei.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/x86.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b58a74c1722d..de51dbd85a58 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3258,9 +3258,11 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
> =C2=A0
> =C2=A0	/* With all the info we got, fill in the values */
> =C2=A0
> -	if (kvm_caps.has_tsc_control)
> +	if (kvm_caps.has_tsc_control) {
> =C2=A0		tgt_tsc_khz =3D kvm_scale_tsc(tgt_tsc_khz,
> =C2=A0					=C2=A0=C2=A0=C2=A0 v->arch.l1_tsc_scaling_ratio);
> +		tgt_tsc_khz =3D tgt_tsc_khz ? : 1;
> +	}
> =C2=A0
> =C2=A0	if (unlikely(vcpu->hw_tsc_khz !=3D tgt_tsc_khz)) {
> =C2=A0		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


