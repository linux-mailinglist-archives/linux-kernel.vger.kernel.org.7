Return-Path: <linux-kernel+bounces-764891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970AB2286A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D83BCC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B5428000B;
	Tue, 12 Aug 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ckh5bYhw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1127FB37
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004975; cv=none; b=k8V2hf4ZulFpOFHumGZ9oQlJMwRhIcTKflJvLqKS3t3lJ5MbgqphTb0OLVN1L5R3sbQuyBqFk8BxZRIajCe3a8sAWPgNG60mugaARJmVPDb7s0LiQ/o8qgikg2SPBbbQNl/IIR9yPeAZMaGtfwb87ZI6YFjUR9Tu5CsntyxN3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004975; c=relaxed/simple;
	bh=Rc0fSOx4ODT+niej0z9sfBuk37BOAGSBh4g04bdKLEE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=A6yns27J3ZdAzXKG7jKe3dtI4NX3isYi1wWjaA+XBodWK7DeC044pABE90y68XjJ3biQQ+4+EX3oo+c89BAerAAMfokAfd1t13bVBTHX+aND/cVaLIxioUX/UP1ieyiyFnIdjtVPAwIDeYaZmniVtQ+fd9GlV0IEHZV/RExXjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ckh5bYhw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459ebc99726so2194275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755004973; x=1755609773; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B+m7y7gtFTTGyBFc0gL8TaOwTzdqm4Gs9PW5eoUpxg=;
        b=Ckh5bYhwf/WZaDalDmOxheSfMGh8HgZL6604VbXFmRPnfGuOKIqptGunxMUNDQl0DP
         cGhZ7c/XQ7bfHy49cPbEEZSejqoukzEX3jofk4o0S42CqDhkMoNd4sfPYoUr+XbE8O9J
         iwSplD49sBQV/vG7ZTQDLZC+9XXrD8w7Ebm21e+4z7u2VhYaBL8KTLwlxdMo4QZ3yXza
         qlE2yXNDeDXB4kE6maBZDgLsigqPjvkSkq2z01K5WwgAgGmU0t8B9gJOZCf6Ol9ujkMy
         wMMEV7/qAFgTKt7Lee0HLq/uS50UWFAK8j/20UIelsp/jpzViDqI+zWIWhL4tceVtl5Y
         4lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004973; x=1755609773;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9B+m7y7gtFTTGyBFc0gL8TaOwTzdqm4Gs9PW5eoUpxg=;
        b=d66nBXgqc0qm/N/5Hb6Gn+gfRIBLucVU7kvttLZzee1V8A3iSJRO7v5IXV+WEtfya8
         EkAZxLHMl8kPQQ/GQ17QL/J/n1dmvcGJflgW8jSP6fvV3H5xabAz7R48FKc8U5X4ZSc/
         b70UlI2dxZgsfUJcxmfkmKT/5x2mAmdkJSN2f0FVdI0INxQllDQotSbV6uyiq4ggZdjC
         D7RFBzBe8S8/IU5V3BCUonR4y3v6rNnnYoQG8781ipA2L9IlUkW2GI42TS5RtEXdu9YX
         rjTN3q6xNwscKpOK05bzeGO7S7IeVc33r7ME5tEWMl03je8Gu+8OJf8jZBQBHGGt1VQf
         Q4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUolIbOf1dzqI8/VejNRKCJwOuHroO4/QS5CU1ETjMEgC5P/d3XgazzPp1HtRYCY2f+9lGYzHT35SbngbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJCMA75dquGkgFixiln4OI9mYDWi6eceNgCzVYNWu555q847g
	G+7+57v+2amDyiEWay3b9AiWunPBB9h8eAjLhJe0Gs3ym25MZef/edF4LTxbnposon8=
X-Gm-Gg: ASbGncsSXgnyh75gg7nDniWwLqpQeKzvbzvSPCiTwyqd/Q9RYU++Sp3RUq/IcPyiOHg
	AiWAoLBpfuyuxR4CFqIwvyKG2frhnOKD7SxNo5TCNj+9jD4V5V70Ft+EIA17n/4iK2y/AOtITri
	PMzRzva2BmH052Kve02xB+jiwCpfiZ/Q7yFihTr0DwXkvofufvB6ibdeJTtFKEpexRQU6QqhlTo
	edwvXn9uJQOp8JHbFIx1ZM3dzVoI8ZCfSqb9shAxnutBveKvoMjotz/v2wpPyDP9c5qTGoHw9SE
	JF0V3Rkwg6Zzq8KZ22rCW2POy0taNr7kK72/wdv6bCbhAAfwJL3fFieaFCrNN9ekYtqGnu4HTQC
	2o36jmmD0pbCjiJFWC6bL75b7yjh4VQ==
X-Google-Smtp-Source: AGHT+IE2d/O56DZUtoh12B2LgxGIZeb1yHos8UKAErVtVVQ4j+I6Ktyv6mqGKISnmKVi1pnhPfvJHQ==
X-Received: by 2002:a05:600c:1ca1:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45a157b70b9mr736355e9.0.1755004972582;
        Tue, 12 Aug 2025 06:22:52 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453d6esm44093096f8f.37.2025.08.12.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 15:22:51 +0200
Message-Id: <DC0HC9ORWWX1.1LUBWVHPGFK95@ventanamicro.com>
Cc: <alex@ghiti.fr>, <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
 <atish.patra@linux.dev>, <guoren@linux.alibaba.com>,
 <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv-bounces@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>
To: <fangyu.yu@linux.alibaba.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: KVM: Using user-mode pte within
 kvm_riscv_gstage_ioremap
References: <DBX0JNR61UNM.Z42YERAKRFR8@ventanamicro.com>
 <20250809032020.51380-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20250809032020.51380-1-fangyu.yu@linux.alibaba.com>

2025-08-09T11:20:20+08:00, <fangyu.yu@linux.alibaba.com>:
>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> According to the RISC-V Privileged Architecture Spec, for G-stage addre=
ss
>>> translation, all memory accesses are considered to be user-level access=
es
>>> as though executed in Umode.
>>
>>What implementation are you using?  I would have assume that the
>>original code was tested on QEMU, so we might have a bug there.
>>
>
> This issue can be reproduced using QEMU.
> Since kvm has registered the MMIO Bus for IMSIC gpa, when a guest
> page fault occurs, it will call the imsic_mmio_write function,the
> guest irq will be written to the guest interrupt file by kvm.

Oh, so the interrupts were "just" slower.  Great job catching that!

>>> ---
>>> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
>>> @@ -359,8 +360,11 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_=
t gpa,
>>> +		pte =3D pte_mkdirty(pte);
>>
>>Is it necessary to dirty the pte?
>>
>>It was dirtied before, so it definitely doesn't hurt,
>
> Make pte dirty is necessary(for hardware without Svadu), and here is
> the first time to make this pte dirty.

Right, we would get a pointless trap otherwise,

Thanks.

