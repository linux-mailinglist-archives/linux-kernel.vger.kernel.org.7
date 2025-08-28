Return-Path: <linux-kernel+bounces-789146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE89B391A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61C0368270
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64624E4BD;
	Thu, 28 Aug 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC42G6NH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1507260A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347587; cv=none; b=NoY6qouPeSOmaTkC0ccPstk+YuSOJxtIIlR9Mi1aRmGfnBh33+FsEyQjsRJKswQ+o9I1gipM0+kLNZ0avqwoaeI7pYDxspBo5mZ1mZP97yFonFs3NlaJ0aInNh0tIxfmLn16G/s2ff0ATOHC30ac1JaQlJWajyNvqYF5j3WiUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347587; c=relaxed/simple;
	bh=hvnRnQeBlWogViGHqrd2JOdKSR/3mg9vBmKlLw/Pvz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnRU6d615Zq68Gmdl9oDD58eM+Uw2T0FjuaL7aRPe3UPEejic5mFO5g1xuliMjylYEKTXHfjfK+nhCxjsqokWaGrz/Nbmfb+GBYKEHnYeJWXCIfaTfYafxyu+h1rtcSYvMbz+ZYMlb6ZyT6s5VEQiUhwpByWzo7RnNOHEK0B9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MC42G6NH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756347584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
	b=MC42G6NHW9DsLlBL92bRmJJFRkgPirhVB3Bz+i3v3IgUt9Lvs1Xg/RwasRK+GCe7MxbnxA
	J4SnMdcd2Re4ib4C7kqsCo1cz/wTqgiPE3Me1uoZpClkG+IccZlcTq/EFIFUVaxYeoDlkl
	h/v+uASsev2zsmZKg82bLrN9/fPlV4k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-41_rH_YMOJiYk1gvjlYgEQ-1; Wed, 27 Aug 2025 22:19:43 -0400
X-MC-Unique: 41_rH_YMOJiYk1gvjlYgEQ-1
X-Mimecast-MFC-AGG-ID: 41_rH_YMOJiYk1gvjlYgEQ_1756347582
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-618b3c75161so848445a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347582; x=1756952382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
        b=ixw1eBwzOBBewGH/ba5EzHV1XYWp8/nBMWzMSJfUpn4yDc66s4BI6veahsScnLHA9K
         2ehnap1cg93FMDj8vIgIkojxvQQuA7pe/WmawGYSsHdMAg2ENl/bfJ/Szqt+TYgCje7W
         zFrAvfKVTINI7g/ZxZ/EHTtm5nRR6khCA35MlG5J+MfTWjLHePv4oSPATnPebMQTA6bG
         p7JDcmuhatME1UyotnNC4oqrnoitOYadlsoxG0ai1YK9p/z0LoOAAmucNh6J+HmWqkBm
         NM4e0eMMao6H4RksL8/TdYMteeTG7vZ2zNzgsdH6zhsFA+faoD6z9Fv4cbaeaGia3bCA
         QLDw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9L0tsaP+GHdkhxcY5IvZ5ZxBEU/7nWJhmPdTcNR/T+IQIqxMKwAQ4ifMI2aytHsvPPAzvjMEZ4rNUuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPtB7eurAL73JB+QIwaiAZUU5wlWzuIpcdEVq6TKe65N11eMG
	wgCqbmW9k79o3NX+9ntl4vfsQu6fDyMGqamcicVHm8l9MqG6IJBjNWPBjZWj+jmCflUYKIYtnD+
	OcRF78nfN8IHj/o1k0Yd/xeHEAHEE7tiD/8qzanHiGoQHQlvHvIWyvE/g+BwDkuPGFWuKPImR1I
	f4MMoCeCM8mNJTcBja8dTy5XmM/LT3kb7BsH7641a7
X-Gm-Gg: ASbGnctY9Ioy8I31IHyUfJIupa9ZDtW6Au45oVw1xWr+6kqKXb26BGpb4bUzhdKxccH
	IpN6gki38WwvITqcGty3tfRtTKWTHUsshNKBLYaMTLSTigL/pD7Ax+1reW4dFbpFWqwbH16fkpW
	MHIsxq3Hqjm13iwZzMnVbaPg==
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id a640c23a62f3a-afec803db44mr338070466b.50.1756347582058;
        Wed, 27 Aug 2025 19:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywnZxZXd+LrwXaJupMXn8D4KG8fZV7ZXo9Nhl8+J+/NoGVlVy9jGmEHSZX26lkU7wovhDS1MB/Wlat2HYVJY=
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id
 a640c23a62f3a-afec803db44mr338068966b.50.1756347581664; Wed, 27 Aug 2025
 19:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:19:03 +0800
X-Gm-Features: Ac12FXx3ye1m5pDHDoHQMdklVzQePg1kNlD8XHk5EhKfbtJVcOqPjtReEt75Bpc
Message-ID: <CAPpAL=wp61suVw-VdqpT-Kxxztaokg_-DkjsVEHDTg7rxzsnbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost_task: KVM: Fix a race where KVM wakes an exited task
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with vhost-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Aug 26, 2025 at 8:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a bug where KVM attempts to wake a vhost task that has already exited=
 in
> response to a fatal signal, and tack on a few cleanups to harden against
> introducing similar bugs in the future.
>
> Somehow, this only started causing problems when commit 56180dd20c19 ("fu=
tex:
> Use RCU-based per-CPU reference counting instead of rcuref_t") landed.  I=
 have
> no idea why the futex changes exposed the bug, and I don't care all that =
much,
> as this is firmly a KVM bug.
>
> Sean Christopherson (3):
>   vhost_task: KVM: Don't wake KVM x86's recovery thread if vhost task
>     was killed
>   vhost_task: Allow caller to omit handle_sigkill() callback
>   KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
>     recovery tasks
>
>  arch/x86/kvm/mmu/mmu.c           |  9 ++----
>  include/linux/sched/vhost_task.h |  1 +
>  kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++++---
>  3 files changed, 51 insertions(+), 11 deletions(-)
>
>
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> --
> 2.51.0.261.g7ce5a0a67e-goog
>
>


