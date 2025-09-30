Return-Path: <linux-kernel+bounces-838001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03EBAE33B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB36132026B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA630CB37;
	Tue, 30 Sep 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJYy6j/d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6123D7F7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253646; cv=none; b=eDJlT1V+o5HKkzzOPv7xGOy72Ej/Pgaus3FKCXvYcFps9tKvFJ3FIrck5x7U2mis4dEOj1a4kLJUqlsCBPHhOk1oFcpNh1BUOD3GAOCf5MW6pywtiSOIMG77pse5v4giD++x4QOzrQkXrhWeDUrEAtDv7bMq8/yWrZKxZXFdioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253646; c=relaxed/simple;
	bh=K4Kj52Sc3WHaxQWWb9WPz4PfQKbfYsJ2LEia1X3xeUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbSNV3Wf1AD/JW8GUG/P2EcM6kR1b0pOHnwk5qpYe7cAClFP8VugXSCpRPRalPsggeibt/zmULEJOpYOaIfBFou4IwmPVRnm3GNwJvbw1lx+Nw3Gr/STg37ZrdLalhH0eND2uwuE5B/RIBwjc6NDnJggSzoWj14HR1f4/w/tCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJYy6j/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+AjrEkys0A8lAun7rL+EyAWl7XyGEJmHCLWyCAkReQ=;
	b=dJYy6j/d0CAr7HWL6/fL0MdPzA2az5+nTmLPO2Q3KW37m9YkzPXBouJz5WD6ViyTcyQp9X
	uZrsmEYtFNY0+fy/1MZqp1kqh7s0eRKPX2gyTZ7I10qTHgFO9Ph54zTNu4qjX7KbVtIlzn
	4f5xRa27jGdCcFmRieuP7AzjhMLVxL0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-A5BJb8meMKOCjE5mH58ebA-1; Tue, 30 Sep 2025 13:34:01 -0400
X-MC-Unique: A5BJb8meMKOCjE5mH58ebA-1
X-Mimecast-MFC-AGG-ID: A5BJb8meMKOCjE5mH58ebA_1759253640
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so3123207f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253640; x=1759858440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+AjrEkys0A8lAun7rL+EyAWl7XyGEJmHCLWyCAkReQ=;
        b=OjRQLN3C52A5aWKV9aEJDJHRkREVrbaNMF96UXoyhKsjuqaMthnI7XbmpY4vzI4TMy
         tCuGUYaIA2RNtgW9/0DyxIk4HTgnMJEk07KFvhMobT0qlzR9KZ9uSk6TeravvY/zP6En
         fuuA5YmT3oIef3Oms76ZiXT8CJmn/Gq6zbh3rHVtHHeigSLwJYcjh7mnKRFR22rldsXi
         ADnZsOZPcBe1xDOO1vH8zFXNt4a/ajXafc6lQ/VQQ9EVBwMIYEVTXzLIEmV45/HtPspE
         tOtwlqN7fIt1xhVBhu5O1qX2woX42vzzTyiE203nAZ/YKZlBmOOyPJ/nNV8K/5rnwVNu
         w+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgk0daEDBaMG2jEeye/HIOoaPpLtSrPE8A9qt2KNl7p09W0QvEOTFdHbqcz+byTqN4SUKU/7CyGctTAJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSZgMubTJL57KVl+YfC7hbZ3J2ag6jyWdJEeHrvclyphDzbrs
	WxK3D6PUpW10CySywPSB6oUwUXb+4c43KkFSKmGfi3SB2/OMIRK/NPJwU6eLRQtGN2G4c2+5bjk
	qe6A2RtT8E7WM98G8dEp689r/HSjhlHCnHG6MGEV6t0x7wMwGDA44o2AV1hR13jZAy+HxUiC/3l
	wCJ9CSHLFN4jLaEmK7HgbkyHg2Ai/pf4z5zB7xO6Pf
X-Gm-Gg: ASbGncviK+AUCbGQrYPZunFzyg+6sqwLSEcMDTDe2meLES2NshwZ1F3NUJtHnQ7Bgro
	GbEoz7i0Bq2zg2klWsbiRocNse87hwDhJvrL+e5PSw9DqGwrHfKOGVVSU4zOLkpCaUeNtbdek/Z
	Y4tmF1zJE9oxvfmJSlpaIaYzAZU5n89bRuJYS4CYZ7TtuoI+pZXQZbS1FehA7iLxQtfDIJ0A8u1
	BiTUMqhM41t6kj6eTjWFj+IFHitReHf
X-Received: by 2002:a5d:588f:0:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-425577ed88bmr408190f8f.4.1759253640468;
        Tue, 30 Sep 2025 10:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3esXsCWsgGFUCgiPEWX5HrwSCxn5E9orJMEqPLqizpyiB5xgXSXOTU3gUaxW1EpxeDlmCfno1tPzhUpXUOcY=
X-Received: by 2002:a5d:588f:0:b0:3ff:d5c5:6b0d with SMTP id
 ffacd0b85a97d-425577ed88bmr408176f8f.4.1759253640090; Tue, 30 Sep 2025
 10:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-4-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:33:48 +0200
X-Gm-Features: AS18NWAKmn_gozvK6e2eroDMudheoXMPsQ32SpXHvGeu2n7Tv2i2n7iC9U7Nkh4
Message-ID: <CABgObfaJ7ZBVhY5Fcmh9rfa6w8ji8v33JShUjb5-uZQVZRWHzg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Recover TDP MMU NX huge pages under read lock, and fix two (interruptible=
)
> deadlocks in prefaulting and in the TDX anti-zero-step code (there's a
> selftest from Yan for the prefaulting case that I'll send along later).
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-6.18
>
> for you to fetch changes up to 2bc2694fe20bf06eb73524426e3f4581d7b28923:
>
>   KVM: TDX: Do not retry locally when the retry is caused by invalid mems=
lot (2025-09-10 12:06:35 -0700)

Pulled, thanks.

> ----------------------------------------------------------------
> KVM x86 MMU changes for 6.18
>
>  - Recover possible NX huge pages within the TDP MMU under read lock to
>    reduce guest jitter when restoring NX huge pages.
>
>  - Return -EAGAIN during prefault if userspace concurrently deletes/moves=
 the
>    relevant memslot to fix an issue where prefaulting could deadlock with=
 the
>    memslot update.
>
>  - Don't retry in TDX's anti-zero-step mitigation if the target memslot i=
s
>    invalid, i.e. is being deleted or moved, to fix a deadlock scenario si=
milar
>    to the aforementioned prefaulting case.
>
> ----------------------------------------------------------------
> Sean Christopherson (2):
>       KVM: x86/mmu: Return -EAGAIN if userspace deletes/moves memslot dur=
ing prefault
>       KVM: TDX: Do not retry locally when the retry is caused by invalid =
memslot
>
> Vipin Sharma (3):
>       KVM: x86/mmu: Track possible NX huge pages separately for TDP vs. S=
hadow MMU
>       KVM: x86/mmu: Rename kvm_tdp_mmu_zap_sp() to better indicate its pu=
rpose
>       KVM: x86/mmu: Recover TDP MMU NX huge pages using MMU read lock
>
>  arch/x86/include/asm/kvm_host.h |  39 ++++++----
>  arch/x86/kvm/mmu/mmu.c          | 165 ++++++++++++++++++++++++++--------=
------
>  arch/x86/kvm/mmu/mmu_internal.h |   6 +-
>  arch/x86/kvm/mmu/tdp_mmu.c      |  49 +++++++++---
>  arch/x86/kvm/mmu/tdp_mmu.h      |   3 +-
>  arch/x86/kvm/vmx/tdx.c          |  11 +++
>  virt/kvm/kvm_main.c             |   1 +
>  7 files changed, 192 insertions(+), 82 deletions(-)
>


