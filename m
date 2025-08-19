Return-Path: <linux-kernel+bounces-775352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3AB2BE47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC53AE0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493B21ABBB;
	Tue, 19 Aug 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Crgz4/rJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34473311962
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597439; cv=none; b=XE5xRv9YgPmgKRLBErJ8/3zldw6J6qeAAECufYsJcTqzNM2gFQOamUjpBOWAhxyg5sbzax8omTiCebq534UIcBSnMbSigw1guoD8wmmxruV+UewnXQH2YErNg9Jk8zge5T94lKfBiQzcV2W7C7jc1Z06OeAWBONPuK0zfLGImrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597439; c=relaxed/simple;
	bh=RQZmLelstrX1SotmAT9zZXcUSdkqlq/nNJekgpnEDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n06fzAUZ5SaZpUlMkjsfmY902/NnSdsRO3J2cIis1XpRrZMDg9Vg5dZosiDzgAMmkHZnIVaRZfvyWs5AsS5AuIaJY9Mox3Sd/xTnR9LsVPJUNUHHTZghQPdQtsU7/UDcv/9O90OwSelYGySnTENfVJ9Jga/HuCBQkI+rEpCh9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Crgz4/rJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce510f4f6so5409956e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755597435; x=1756202235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B657FCRrA1HpbcN+g/vtvEIg1TfbvbOHf4kJ5LZvO5U=;
        b=Crgz4/rJWY9ajhNfIko3K3qRIt2Ao8Kn/WyBwNb+k4BNCgtl3Hifc3buCHBsGCXAn7
         ER+IXudCW+H/ScI8yAbvRnpnb/mNCcnVrYv9PxKPlwUMKhS5XKanmM2yoytOg1xD2MLk
         WqCA+wqVuBurg8VGgzdI3rpUYxX6Z9daMcOGdySIRBPqiwTdumu7/Puj3tknNnI/aKHp
         If/Vna9fqPuzX1zb7V7P9pXXNwT2o5nBhVScqeTzas75Ee0iQuG8a54m8+YXhk3Q8JI5
         qX6ahOntDHLGUZqm+xSqmfjOD+9plca8SxujfKVMNMeazjWaE8IdEJPVZyYAJOUutGZC
         so2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597435; x=1756202235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B657FCRrA1HpbcN+g/vtvEIg1TfbvbOHf4kJ5LZvO5U=;
        b=bRB6l7ZmnnilJdPrHfsrAm9RMUs7s424H6fX5rMB6BbMKyqWIlDP2iLQtwKAi3jpUe
         9dVS/5zicbbkjPwb5DPljzTWMY1qWiXG2aRSnC5NK9Ps9vNtviON5awC2mHlj8mV5X21
         VmAILPSUlb5q3NMucyGOn8w0kefERYJZa8fTi/5dULSGP3MDQEiZoHQhqaOCxJZxbBsD
         4VR5eaC3Kp9VHKipQvg4BgeUvRF22OmSDWzIAsc12lsY7QpOp1YLtd5N3GN7ZdEf0vMn
         ul1RQYzdbXdMeikWHbHIp5qt7BpTHGHYuF1h7UjbZ+hgQqF8KUPO9l8zahXFx3qAMGJT
         KdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpjgLDosem1KcJUJkNPhSGIZtYqqLXpem/O1b1MQSY08k9NNgT7SIj6nSB5tHMykX3asFF6jfvMvjAj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfXcWWayG5jI6vVjNj9aeHZNftaSrDk1K+17oQ6H8DT0qWEPR
	atPNver+GDggdyoXCZHmw2+a9muiv4zFYVyBw1SsnDJN/VwEvwBveaMgsWDr5uYepqzE2Ae4CMn
	TBfcATKPvm8UcyMsIvFwzV/mo7jWUTeuOPmdFJdDZ9A==
X-Gm-Gg: ASbGncsanHtc37PXK7LVBEjorJKTyRyfMUpCiTIq4dRVwYEena/8V5VNR+tZVTPCJ2n
	ci0n2CbqrNdrdKsgQEZPrkO0MPcrmTgf0FCHjUkfw5n6tvhsyD6nTrcXSo4Ep4AmzgH4t8T6uVZ
	cEsBuVZyKzSqkV+4rOwsI7XXW9MJBAcABIyYldhRSJVYCg8vKEQlNpd7NTY5oTRueLky6L4FF0n
	owRQsoa
X-Google-Smtp-Source: AGHT+IE584Lps5ZJGPPasz2qjXvE1uln/YoeKZ+NEr5/UBb8mlMMaF+8xE4Mk12v0EiPPAIF33QJj8U3svU1V3OfZ8Y=
X-Received: by 2002:a05:6512:3411:b0:55c:e5c3:1a44 with SMTP id
 2adb3069b0e04-55e007db76bmr626581e87.48.1755597435230; Tue, 19 Aug 2025
 02:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy3omyk7YGVHNV5mgR13cON1SxdpqsxGQJsWWE1Hoyw=5A@mail.gmail.com>
 <20250819012558.88733-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20250819012558.88733-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 19 Aug 2025 15:27:01 +0530
X-Gm-Features: Ac12FXyTUxSpF4ciP7rx8i1SvNQzuuHLy0NA8cpXjF9T81-EV5Hi44pHTVwLXYE
Message-ID: <CAK9=C2XN3izaV_cB5dTkRD0FRD+gqdRVYWKxMAuaCG+LP3D2aw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Using user-mode pte within kvm_riscv_gstage_ioremap
To: fangyu.yu@linux.alibaba.com
Cc: anup@brainfault.org, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	atish.patra@linux.dev, guoren@linux.alibaba.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:56=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> >>
> >> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>
> >> Currently we use kvm_riscv_gstage_ioremap to map IMSIC gpa to the spa =
of
> >> guest interrupt file within IMSIC.
> >>
> >> The PAGE_KERNEL_IO property does not include user mode settings, so wh=
en
> >> accessing the IMSIC address in the virtual machine,  a  guest page fau=
lt
> >> will occur, this is not expected.
> >>
> >> According to the RISC-V Privileged Architecture Spec, for G-stage addr=
ess
> >> translation, all memory accesses are considered to be user-level acces=
ses
> >> as though executed in Umode.
> >>
> >> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >
> >Overall, a good fix. Thanks!
> >
> >The patch subject and description needs improvements. Also, there is no
> >Fixes tag which is required for backporting.
> >
> >I have taken care of the above things at the time of merging this patch.
> >
> >Queued this patch as fixes for Linux-6.17
> >
> >Thanks,
> >Anup
> >
>
> Thanks for your review.
> I will send a v2 patch to fix these comments.

No need, it's already part of my riscv_kvm_fixes branch at:
https//github.com/kvm-riscv/linux.git

Regards,
Anup

