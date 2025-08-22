Return-Path: <linux-kernel+bounces-781748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBDB31636
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C1F1C86DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875C2F6181;
	Fri, 22 Aug 2025 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="1OjGNOk9"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5171E5B70
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861635; cv=none; b=Ow15JlpHLSXXLJGFROQwDNrCPV40OxI4F0kFY+r52SS+xOvmwSDaGQ5CAfMB+/l1a10Wm+5/rBluu8wTJCAnriJZV1V7FTpmZwArC3dD7gKu2x5h49oovCjz+9Ozy3iBDGSZh07TBJWU0ZUdBQ7wSnoQxuFTU5JXt+iKSqPvpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861635; c=relaxed/simple;
	bh=c8WaWLL/LfS1u8VhVZZkyvB1L6L5PRqd9nkHdeBWsHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAy1PLLNJ77utIguK2QVcVA16QNFJhWSRXlkJFQvdT9Zv7OYjiuf+GXDkWG41c7DdqLP6nfMQKoWPemXdmrQ+uAU8bjGs+/uFlGKA8IqwZYiviLvpiUYaE3JnplQUkYkOL2g9xDYVwYcl4JePrHbLbpm0/grzRczR/irdvAAukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=1OjGNOk9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e57010bc95so15358225ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1755861634; x=1756466434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/vfvb14CGNszwxeStpY4dH+U6nsuyg9PGBngcSjux8=;
        b=1OjGNOk9jmpZdudtkoKhp3kk8hEOZ/UpjB/WLMIY5ZC3YK5sJlNhs6LEtxb4iapKoO
         4ZdV7ihufMHtlydJTCFlFi7mRbBb1+SXMmOzSVpF+IN0mBPGDf1+Gke+IBKqYArVuR5P
         LcJ3LHuEmIATM+v+SSMDzQcuxYZl/+Xp4nGYM/bIqyh12BktM3hXGEBjcO5bujcNLIwF
         oazHMZHF2J/Rsps0jDpiXyKF49V6uD2GfLKZuwSiULuctfLzVv87xeQ2PgxrrkdNswbz
         EtX0C35GD6aBWnzHLNVaCRZis8YdVIwhhRsMwnORWemxbgHmXzMRUEZbO5yjx3AXPIAz
         hGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861634; x=1756466434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/vfvb14CGNszwxeStpY4dH+U6nsuyg9PGBngcSjux8=;
        b=bs2sxjyp05wQRHn6ytL3tvVK4xNyHoYmot/zk4Q5A4r/4NLcw1Nmz++5Ig6CzEA85f
         hmosjJFUnPPmLLh61S9CX4APj/Dz4WbczFftNxLYFv1Q92GZBEAQvBhFbqNLxW2wbAPW
         DVDZvBsjvCPcIRLWOJa+5aMTPzTS8aIqOESO0TS/C/MhrndKnKYAr5pbrVY94pehFr/t
         EfY7eKkMF2Foo5pYg/Kgd7A0bfYet0pQ3yJupbRMlVg7JSFWGJl69OyKl1teKqtJYny5
         kuULqQK/nWJQkDDUEkeTkF2yxtwlzauoIxaymdgw2dD4eSfchAf5P5CZB54TqaHheVgm
         LGSg==
X-Forwarded-Encrypted: i=1; AJvYcCXvhlt8apikCkOc5zkQ/Vqob44sFrEVz8ZRdX/9H9bW6SvlMIwD653lI0UV2KwgOldlOqXY04wdP+6Q6lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyHrrFcFPRygLfPaVcRqdJBppqMTaMFM0MYj4zrSpEXEWJRnR
	d4nxe5ZkR7Mm6yHzKeaRtWP2iBNuWEkXYRIb3het6yIXU4C1kaNUvRCcSN5HUQMRwNyQ5RI3R/y
	0mL8XNlF91pL2AkpoI5Q3t0BRb80U1UMFzS7bmhyYFw==
X-Gm-Gg: ASbGncvbYZBMOMXcWMLG9LyU1S+KuRWwwcTCWPVqM/sQNIITW1sLFAx+u8VlKEWYi84
	ShqoOGch6gFbH45yWu8xE89Hy6Ff4rKnWvX1g8Wu3hIHlo8RHiOoru9TLlzNj9pJET9/NpKJir0
	Lkp7JuXEz7vN5ACPB3Ykufeh8pRiUmFI7KX3cF3X0FGy7Y66/VKeQ8o/ihlNIusc8R72dQfu1eJ
	nNeLKCO
X-Google-Smtp-Source: AGHT+IH6sSUh2jwMrj6GuWBxvwwTPiTBYkovYilK1h5/YeKQYLbFNsHzLiFIEtHdGgUpX3elX/k9WeCcNC+wsnPHQ84=
X-Received: by 2002:a05:6e02:1885:b0:3e6:6a43:1890 with SMTP id
 e9e14a558f8ab-3e91fc26d9amr43027185ab.4.1755861633631; Fri, 22 Aug 2025
 04:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754646071.git.zhouquan@iscas.ac.cn>
In-Reply-To: <cover.1754646071.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Aug 2025 16:50:21 +0530
X-Gm-Features: Ac12FXybuZh7H_EDZYZxjvBDpOJ1Lg5p3N7w9IhOsJAO1wqpnDrt-kCUdBS50To
Message-ID: <CAAhSdy1n+R5q3F4Fw4npz3gOGEWueYd0tDuPyzjE1stPATMdfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] RISC-V: KVM: Allow zicbop/bfloat16 exts for guests
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:00=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Advertise zicbop/bfloat16 extensions to KVM guest when underlying
> host supports it, and add them to get-reg-list test.
>
> ---
> Change since v1:
> - update zicbom/zicboz/zicbop block size registers to depend on the host =
isa.
> - update the reg list filtering in copy_config_reg_indices() to use the h=
ost isa.
> - add reg list filtering for zicbop.
> v1: https://lore.kernel.org/all/cover.1750164414.git.zhouquan@iscas.ac.cn=
/
>
> Quan Zhou (6):
>   RISC-V: KVM: Change zicbom/zicboz block size to depend on the host isa
>   RISC-V: KVM: Provide UAPI for Zicbop block size
>   RISC-V: KVM: Allow Zicbop extension for Guest/VM
>   RISC-V: KVM: Allow bfloat16 extension for Guest/VM
>   KVM: riscv: selftests: Add Zicbop extension to get-reg-list test
>   KVM: riscv: selftests: Add bfloat16 extension to get-reg-list test

Queued this series for Linux-6.18

Thanks,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h             |  5 +++
>  arch/riscv/kvm/vcpu_onereg.c                  | 34 +++++++++++++++----
>  .../selftests/kvm/riscv/get-reg-list.c        | 25 ++++++++++++++
>  3 files changed, 58 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>

