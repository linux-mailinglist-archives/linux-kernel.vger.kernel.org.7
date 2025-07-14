Return-Path: <linux-kernel+bounces-730693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 772AFB04839
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BB16E00C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C5246BD9;
	Mon, 14 Jul 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4U4Xl96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB39204098;
	Mon, 14 Jul 2025 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523489; cv=none; b=QUj+J/Qlv+0COBswiCH+mQMms2/LIQOdPibrsHA2u2Dp+i0mYq7oMapqJx3QwRneWTqTRXQmGPu0WA7Je7al+WJhOe6M16G2wwbnb4EHQcoeslOweAA6CgVnWIU2YiIJCxdRTblHEAikbJbD+8NmWilq+fppCTWNNGxR8QcLonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523489; c=relaxed/simple;
	bh=xd/xfYOEUPPLbpxh3voDncT+zjKQzDRxMcauig6LqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEzsymexlGhQRILwYwW70d5kuBgBagzzLTVt51UL38u7KrZZT+BbQ0QZHMWLXeK3GMvo+PxFla6xZOEMvFa4OciAVL3EoaQUEPpwW7tAzLD+38HPlSupZ3GUh+BDti/EWXbJrKu2+coyzlTMCy1N1qB8yH1GW2z0mj+O+JPKHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4U4Xl96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE85C4CEED;
	Mon, 14 Jul 2025 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752523488;
	bh=xd/xfYOEUPPLbpxh3voDncT+zjKQzDRxMcauig6LqSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4U4Xl96FI2EXcfOd225VoOy4zz2pnnK+h9491TSV+5rOSj1Lubf+m/Jgg/nScmEA
	 tdMt/pVJbU8LpLBm4q8b2qc3Ae3khgKFZTDt+TsRCayPDXmpNw+PftSK/4v9hyBSDD
	 9IiVW1Zi53GhqH0n56csK8bgs5dGOt1bkAr5U+V+qAEUf/v2x/m02COYu9vWnOfoGK
	 tbg54ZQkafgLxLIFaCQXZH6SaLvI+SiPyyzi5Ud2MSZ1JvyNTrvc6nU/jOAoyfMCQU
	 PjoPcjqVWkz+goSPVG2TnvRWR/jTekwUAA7wmaKHOvDCPCq3KBEaMxFRINXs+w63eo
	 h68qY/lwqcf5Q==
From: Miguel Ojeda <ojeda@kernel.org>
To: haiyan.liu@unisoc.com
Cc: Ping.Zhou1@unisoc.com,
	Ziwei.Dai@unisoc.com,
	lina.yang@unisoc.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	shuang.wang@unisoc.com,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <christian@brauner.io>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Meet compiled kernel binaray abnormal issue while enabling generic kasan in kernel 6.12 with some default KBUILD_RUSTFLAGS on
Date: Mon, 14 Jul 2025 22:04:30 +0200
Message-ID: <20250714200431.1917584-1-ojeda@kernel.org>
In-Reply-To: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
References: <4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Jul 2025 03:12:33 +0000 "刘海燕 (Haiyan Liu)" <haiyan.liu@unisoc.com> wrote:
>
> After I delete the rust build flags, the asan.module_ctor binary is right and kasan feature works fine.Could you help check why KBUILD_RUSTFLAGS impacts kernel complication with kasan feature enabled and how can this issue fixed?

I assume Rust is enabled in that kernel, right? Or do you mean that somehow removing those lines from the `Makefile` makes the issue go away even if Rust is not enabled?

Could you please share your kernel commit and the full configuration? From a quick build arm64 KASAN in v6.12.38, I see the `paciasp`/`autiasp` pair in one of the Rust object files:

    0000000000000000 <asan.module_ctor>:
           0: d503233f     	paciasp
           4: f81f0ffe     	str	x30, [sp, #-0x10]!
           8: 90000000     	adrp	x0, 0x0 <asan.module_ctor>
           c: 91000000     	add	x0, x0, #0x0
          10: 52800601     	mov	w1, #0x30               // =48
          14: 94000000     	bl	0x14 <asan.module_ctor+0x14>
          18: f84107fe     	ldr	x30, [sp], #0x10
          1c: d50323bf     	autiasp
          20: d65f03c0     	ret

But I am definitely not an expert at all in this, so Cc'ing KASAN and Android maintainers: https://lore.kernel.org/rust-for-linux/4c459085b9ae42bdbf99b6014952b965@BJMBX01.spreadtrum.com/

Cheers,
Miguel

