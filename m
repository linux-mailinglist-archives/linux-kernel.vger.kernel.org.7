Return-Path: <linux-kernel+bounces-751160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA9B165DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BFE54896F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813DC2E0934;
	Wed, 30 Jul 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDxaT4Wv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CB1E51FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898168; cv=none; b=ok8ss8UmkOll1KuRV7me0YAXClqG7VmoFGDmyletRNR0OjpZKnlxlfK0viWw+o6lvm64RYNuOkvbRUIyCZbMYKzvfqO+Qc9S7o4RcBBPjBFRgFlX9SqQymBItRCkQWk02XvR3B2QbrnJWPR+7acOqfOd6XxFhYxnGvyks4GKFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898168; c=relaxed/simple;
	bh=7OLCRCNR5V/AlevOyvlK6totQukmEA5jV8LJEeHMwaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXAlb6N7xWOcM9QbaJh4N4hjYUNtZaze/WWagbHY1cTRwu9zG5MyQaG1ABjoFstb4HcfhpxVUzSdIU9i6SEAzzu4L4/eafHsXqG1KXgu44mRuRZrwDF6kVX2XV0+FRimXcRxGULnwsap9xYFXnCi0qUbLgiMm0HudDvbXn874aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDxaT4Wv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753898165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tmJpoYYb7eLSC9wRAB/Bqt5vsUFjB2nvCjuXfmwYWc=;
	b=IDxaT4WvEi69hBi+qWenZ8X+VRAX07NwFRIgAgTPj4074ekwfowaZ1NIAEIXp7bZefFEiC
	H9OmspNOadZ7z3Qi7etGJmrdtScxBFUpZfe/BYJVveUT6BNc4eJ8WcxSOAB+0IefSENYrq
	rJR8JbUiaiEhe+va0W4vafPCJdeg6Zk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-yHSoRhRVMsuAiz9D0TkCDw-1; Wed, 30 Jul 2025 13:56:04 -0400
X-MC-Unique: yHSoRhRVMsuAiz9D0TkCDw-1
X-Mimecast-MFC-AGG-ID: yHSoRhRVMsuAiz9D0TkCDw_1753898163
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b79629bd88so36922f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753898162; x=1754502962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tmJpoYYb7eLSC9wRAB/Bqt5vsUFjB2nvCjuXfmwYWc=;
        b=LIlZ76XbVetkXt3Vs+HjCvdwJT4dlC41y5lCxx8E9vEex3fHwVrKnR0OznZp08N98T
         9SjWgHg2h7PEwwHVZCJbCCWGVd6o1QdkwbxQLN+bwh3/Mqfw4HLEGJhbyHctWtKK+jD+
         3ToX/zBxOf/Ss6Lao2tg19qyvt0GR7Utyc8DAMj9nW4WTsFtuQjNdwFh2x09+Xj1dK2L
         nyYMQ96OT4JNkk0TGeGJp7bwDSWZGjVklJ+I9lqyEaBdrPeydV0uIhmqg1s+60gmKoCY
         1MqxZE3wJHW8c54Mlhpez1J63amSKoukXCFAoY6vZyeDnbeBoZHRKjWJ3tUegM/AYDAI
         8AAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqNHd0dYB4g/iQoBFn0F29r4pL+4KVOTs+vesgb+NlQXsba6Wh+B7x02T4O8gVvJ5tFxrID+yzIQ+NCwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd61eimn0wrU6XZpIaq+CKxenT3HFgDAm9bW5651gcHyll0Xl4
	6HeErU0XnZftMXxFK/ZviRbMtoT/Wq7MLEAvnIppH3wTQkbGX6CkS/9svWTek1m+89tBEUvwjVh
	MiXorzgAftsi3y2Hbe0/1qUuhY0WlrNvLFwvSlshMMiCN5nq+UUwWSt9jSqbd8igjlqF44TvG2K
	TAT/aVjSis5jm7eyeMxp3byfBvR37egqNJevel5/AseKSZv9SEZoY=
X-Gm-Gg: ASbGncvco2R0C8ywvllWmEJhVHWq4oRkwyyj+KVddXR6CPM2hVNJNuPuURF3TptE+w6
	1tp0zsQxtH5n5yALY/fjyoViM3RZLApJQ/Pa5iijosTFLk5kSxRZ4vEB8aoVPrOHTlU332ScuzP
	0yNTBnGtZOlJzEaJlid7j+cw==
X-Received: by 2002:a05:6000:1888:b0:3b7:7910:2159 with SMTP id ffacd0b85a97d-3b7950109c1mr3505051f8f.55.1753898162174;
        Wed, 30 Jul 2025 10:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG26N0I19mW9eRY7Eb0OU1Cm5tjgJLaTMjcvx2EQY3LNoUffveVDZiQLM5Ba2OV+n+7p+edjzfMVLPdiokAYvg=
X-Received: by 2002:a05:6000:1888:b0:3b7:7910:2159 with SMTP id
 ffacd0b85a97d-3b7950109c1mr3505038f8f.55.1753898161649; Wed, 30 Jul 2025
 10:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com> <20250725220713.264711-13-seanjc@google.com>
 <CABgObfZWvtskg-m94LRHqN=_FtJpFtTzOi3sEhiAKZx1rzr=ng@mail.gmail.com> <aIkkkaqTbc9vG_x3@google.com>
In-Reply-To: <aIkkkaqTbc9vG_x3@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Jul 2025 19:55:48 +0200
X-Gm-Features: Ac12FXypMCtriNdkn1LbM5S5k_2ZX491ZBTz9QXKmema-A7BqPYwU9xq0s1CzGU
Message-ID: <CABgObfZmn03eQU9XYnFRKfHWNUx006z_4x8Z91hapVHZupUYwA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:44=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> As for this pull request, I vote to drop it for 6.17 and give ourselves t=
ime to
> figure out what we want to do with vm_dead.

Ah ok, so my spidey sense wasn't right for the wrong reasons. :)

> I want to land "terminate VM" in
> some form by 6.18 (as the next LTS), but AFAIK there's no rush to get it =
into
> 6.17.

As you prefer! I had already rewritten slightly the commit log, so
here it is for
your reference and future consumption:

Add a TDX sub-ioctl, KVM_TDX_TERMINATE_VM, to solve a performance
issue in TDX VM cleanup. A guest_memfd keeps a reference to the
virtual machine, which means the VM cannot be fully destroyed until
the guest_memfd is released. However, to release the guest_memfd the
TDX module must first destroy the Secure EPT, which is a slow
operation if
performed while the VM is still valid.  KVM_TDX_TERMINATE_VM allows
userspace to initiate the transition to the TEARDOWN state before file
descriptors are closed (either by hand or on process exit). The TDX
module then releases the HKID and S-EPT destruction can runup to 10x
faster.

Thanks,

Paolo


