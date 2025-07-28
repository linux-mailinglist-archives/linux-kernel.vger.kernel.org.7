Return-Path: <linux-kernel+bounces-748296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471DFB13F27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF64618C13ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FC271A84;
	Mon, 28 Jul 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b97a9+QX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848770813
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717642; cv=none; b=n38jvPSCGK+JMJFt0izcSFz8U+3N0KvJt8454KgC1Xp6BEy0tSQF2/ssOphL5GCJde3sX0JoOhqRxkkqhETrw/udKCJJzJ8Wkwr8HO5Sy2OeREBQOplx3dC95LkvRt2eqy5ZI6oE0YtFXpflELlb5+H4CJiOaThaU2V8Bk94RR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717642; c=relaxed/simple;
	bh=egEuEBlsNKwrfzIztqb0TZJdB1FrMTRyzYhn8Er615U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PohBHyk9WVRH796zeEmwYDVS3WuuKuh9sPp4bTrJ2axzfu/wAJcfYf3DAIIFTZUTlgprKTY0sQS33a83rqGRlqSM5jnpWXrzO6EeeVVZPSLq3FwwWdxDmoMX7I1yIkxe2zZ/iK26u7YnC46dHw+zx01gjEplwsET4rUm9PgsAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b97a9+QX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753717639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Wtgg7/5DZCONUh3qG3g+QKqH7gdzPFy8ZnZGt8cpek=;
	b=b97a9+QX85oto6u1X+4Kpg6QFUxytPe8BrWb3qFzYu1GeP6uwhcTL0z+a/NsU3S3klqQef
	utEHrVB0UVL8LtarL7LQHfjCPRZ77CBN4E0IWNhP15zvb6IOaiy3AZF5Mqn4HRgJunWIyo
	mhmgvByzyxOm52k1HdgHzrMLMgh70iE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-uN_IRHNuNYaXEd2pDCdVDw-1; Mon, 28 Jul 2025 11:47:15 -0400
X-MC-Unique: uN_IRHNuNYaXEd2pDCdVDw-1
X-Mimecast-MFC-AGG-ID: uN_IRHNuNYaXEd2pDCdVDw_1753717634
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so10371f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717634; x=1754322434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wtgg7/5DZCONUh3qG3g+QKqH7gdzPFy8ZnZGt8cpek=;
        b=HROO92/jCbebB6WiY1lI/Rn9CCrRKllHrw1t7/nnazMBq3ctpHDLSIMd6vtWEpiRug
         jH6X5rCYRBogSBQUv7oM5ri6fFL4galX8yvpR90/LX0MqLdGdNOBF552/9VHemuty0f7
         bPIkF3QZvJcKsRGR8pLAtR6MWxPvtQsxNJkx1PDLrnrywaj+lwy+CExdTcCNQ3CSngw2
         A9PZ8NRazC3T1MgJ4wVxLYe374Mq7XFrFbgk8GGcapenDn0BXbS1erQ3ju9++4aQPyVo
         F9Z2OW7L+ug6XPt89sRN6XDR3mfrgru/X9Q/5O3pGGiOC/g2T0cZQDJULeJzIgIEIaOU
         cwtw==
X-Forwarded-Encrypted: i=1; AJvYcCXgtLG8XAd0Mm4w3Eddt3gMsH3Y6Wf9dH5JaKma8ypY6Vaiiq2AAtyxfhe2oEaDdHsu8uZe5wOhS88usCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrRmwqffKmaj7JULaLPES5Ewg5dxEO5BeDhZME+AI4sxwC1oQ
	sMQBS8UjFZxGDdFBZi1ehSRhmPKqTBdWQPuGAujVM89nhkkqMeD6cwxdJiHpFn1hJ2grYBTRQB3
	aPPMZFJLiw6IwpQgjcCY7ixYZ2h1GQtcFpEMhbaNJqVgGt3YCq4YEA7mR9HOA3UWl3lVyNwfmE9
	8zktPzAeUJaDdiLjxahtSxjqu57ecnWzYdfY9PRUD4
X-Gm-Gg: ASbGncv3Mm3Hyzgd2++GTQnXsszyd2PgB8AvPpuovQYVT3mVDmKsCKbD27i3Fxq66Ab
	51HxHHw1fNkBM70Ci3OJkoTJWFeaHBl01ZtxSXCDclbfcb0F4ZDaykFW6KLbx1RDN3QBteVIhbG
	wSZy2+17fJSXoIwQ2K09YGsw==
X-Received: by 2002:adf:a392:0:b0:3b6:1e6f:6219 with SMTP id ffacd0b85a97d-3b78e61f76dmr31681f8f.29.1753717633829;
        Mon, 28 Jul 2025 08:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEuUHh2z9sR3e6IbuZjWrbdwq+hlIKVlO+oMmkrmiIewdVjOer41IlJpF2WIwA6ygSq5MtN+KcAQYw/quy6K0=
X-Received: by 2002:adf:a392:0:b0:3b6:1e6f:6219 with SMTP id
 ffacd0b85a97d-3b78e61f76dmr31669f8f.29.1753717633375; Mon, 28 Jul 2025
 08:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com> <20250725220713.264711-13-seanjc@google.com>
In-Reply-To: <20250725220713.264711-13-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Jul 2025 17:47:01 +0200
X-Gm-Features: Ac12FXwGUZbd9mg0v05ty49eqrNrq8qFqZGXKq22GPDdO5lkh_Fh1cjjSjkkQQk
Message-ID: <CABgObfZWvtskg-m94LRHqN=_FtJpFtTzOi3sEhiAKZx1rzr=ng@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 12:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Add a sub-ioctl to allow getting TDX VMs into TEARDOWN before the last re=
ference
> to the VM is put, so that reclaiming the VM's memory doesn't have to jump
> through all the hoops needed to reclaim memory from a live TD, which are =
quite
> costly, especially for large VMs.
>
> The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf19=
11:
>
>   Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.17
>
> for you to fetch changes up to dcab95e533642d8f733e2562b8bfa5715541e0cf:
>
>   KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM (2025-07-21 16:23:02 -0700=
)

I haven't pulled this for now because I wonder if it's better to make
this a general-purpose ioctl and cap (plus a kvm_x86_ops hook).  The
faster teardown is a TDX module quirk, but for example would it be
useful if you could trigger kvm_vm_dead() in the selftests?

As a side effect it would remove the supported_caps field and separate
namespace for KVM_TDX_CAP_* capabilities, at least for now.

Paolo

> ----------------------------------------------------------------
> KVM VMX changes for 6.17
>
> Add a TDX sub-ioctl, KVM_TDX_TERMINATE_VM, to let userspace mark a VM as =
dead,
> and most importantly release its HKID, prior to dropping the last referen=
ce to
> the VM.  Releasing the HKID moves the VM to TDX's TEARDOWN state, which a=
llows
> pages to be reclaimed directly and ultimately reduces total reclaim time =
by a
> factor of 10x or more.
>
> ----------------------------------------------------------------
> Sean Christopherson (1):
>       KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
>
>  Documentation/virt/kvm/x86/intel-tdx.rst | 22 ++++++++++++++++++-
>  arch/x86/include/uapi/asm/kvm.h          |  7 ++++++-
>  arch/x86/kvm/vmx/tdx.c                   | 36 +++++++++++++++++++++++++-=
------
>  3 files changed, 55 insertions(+), 10 deletions(-)
>


