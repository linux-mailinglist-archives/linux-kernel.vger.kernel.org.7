Return-Path: <linux-kernel+bounces-858792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD5BEBD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 199464E31A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B492D4807;
	Fri, 17 Oct 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sznj/c7v"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F19ABC6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737837; cv=none; b=nl2yrxTReUPoFgR2iruxbhGI5lXbDWsverZOqwpXDFdwRMM3bt07OJMoGGBgXuqKOd1lnVgu5Rjo981QErVBQd8om7PfWlfPVrr/ujGvv9+Qt7dX9k7ALTLHycfeDTCeIuuDNfFLGA80Cs49o1cCkN8KzDs285wjvxv3GslD4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737837; c=relaxed/simple;
	bh=uyqps5tD92U8m+2+xoFVTwq4VnX2jZ4eC7e5viKgXQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVb0e0W3gQr1Bn5Fk9d3apYPGCpY8j5M7uTb+4P4K0JXH7iEJNLdADPSZ6aVUnhi4eWgqoGk6AHYZeKeMDi1aKjb0XpLxHUXK/9nIwpZo9kFtiXR8n3Qa0fOuTJmd9Wg2IH65EVo95j+qHacsuLkf/yN035xnbhTx3WHZ+d23Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sznj/c7v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3779184a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760737834; x=1761342634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXowAklNfKjPPLcmHrBPzos0N/jOzPaWiX92u6a/mNs=;
        b=Sznj/c7vVkTWR2hGSw5z8nxA9As5WWtPrnbdcQoltk/bkOt3yBFjLNMa9cgkwRhBZC
         YmwcrspYC6Fg1/kjgbxCq9HZJe6YD/jAb0LftYxtnyaGe333urK2fUzh8F66e2GrsHLF
         +TcaeokO7FilLbr+XRRAaiYrWPA7Lk/+0r7ZnXlKp4IBhbSuxUljjvZimD2+uHkDYgb9
         I5ISU/Y+psxAtnvyLx1sUCHRFNxvvDU4/imxtEq/HE7G0osUKTVEVoWV76OjKiN+omIy
         1NRIdHfMvZav75g0zgr839qR8Lvu3g94Heu3O6hYg7yo/9mCliUF4/NWUvSAt3rS9BPf
         UxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760737834; x=1761342634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXowAklNfKjPPLcmHrBPzos0N/jOzPaWiX92u6a/mNs=;
        b=qqg62rm4lTFSjP0Fq22TajI67WLRnSKhNWcA1wOE+oJjsNvM9b5Idp9FjJH85Tgld0
         XiUzb5JjMUKuUWRK+eMYJpIQrsNzbyyMeulzBXCIpR4fFJ1ys5EkMvVriCDJTIOfvj8c
         Cg1eujXtGMa1hRpKk/FNA630xaitDBaC11QmLk+44pAkYoHWIYJpxGg8NX11FxowTxSp
         /ee3cl3T69rRw0L1+cVCiphSo4WDXeY2uxNcAqNZJoThRP1esjqRzj5js8H/5YL6SbYP
         InoZwgyjeRKAFEPYGDJ/SHOBIMdkZgzZV9+x2Sq1z7UvYmPa0WcUq4QDVErTNf0gHt2M
         rQ+A==
X-Gm-Message-State: AOJu0YwGYTluTb92cxuls32SFSE2Av7YrXkQ+Dtxq1F/o66hrs9qtmqa
	eJv7KO7TGtj24QMwjHLPDNyFkE8hDSw3mVJ1ptPjf17fF/87mD3N6tb3qNXk7ogPIUwP8NM1dvN
	slqqxVtSfJmdluQZQ0A8qP93LDuXn8eo=
X-Gm-Gg: ASbGnctpW82i6uzNGUdZPZPrqS69NV/pw6rd4/UCW54S3NgBk/PnA6zzxsITmhNGVxp
	k5GeFUIZAZh/W9X2Y7hqJUi9Qi+PuhcaLxn4Di+G13AH6PBuVvp4MhnjVvvIfxyBLTNthIkM7wy
	rPJ5oXiS/cavD5Vh0NSNmIv7b6AYJM6zikKnU2eC78iSoXThXRzAE20Y87w+XpwxJedRCw+j+va
	hGuN1r4pr74giWi27iVzDGXHYmyokYB4E/M7EXBeoOY89vqpUIfQtInY2C5+D/GPR3HTqaZKf2C
	JCnL
X-Google-Smtp-Source: AGHT+IGDex2b2+/U0zVKVr2/MzWeSzQhJyHr6KzFEHvW5oCnc4bul8RVh0QOd8xsaqk3b7DaOTMOmuMeLkfSMN3JHFA=
X-Received: by 2002:a05:6402:35c7:b0:634:ad98:669e with SMTP id
 4fb4d7f45d1cf-63c1f64cb6fmr4928070a12.3.1760737833857; Fri, 17 Oct 2025
 14:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013091318.467864-1-yongxuan.wang@sifive.com>
In-Reply-To: <20251013091318.467864-1-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Fri, 17 Oct 2025 16:50:22 -0500
X-Gm-Features: AS18NWA82u5T2BvACLlWQSx3oMVZ8fIoOSroipFBZryvzDVMCHFcr14soughxtU
Message-ID: <CAFTtA3OW6nDDZP=bZXeBa8ua05QiXO1L92tKvf77WUuJGoengg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Optimize the allocation of vector regset
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:13=E2=80=AFAM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> The vector regset uses the maximum possible vlenb 8192 to allocate a
> 2^18 bytes buffer to copy the vector register. But most platforms
> don=E2=80=99t support the largest vlenb.
>
> The regset has 2 users, ptrace syscall and coredump. When handling the
> PTRACE_GETREGSET requests from ptrace syscall, Linux will prepare a
> kernel buffer which size is min(user buffer size, limit). A malicious
> user process might overwhelm a memory-constrainted system when the
> buffer limit is very large. The coredump uses regset_get_alloc() to
> get the context of vector register. But this API allocates buffer
> before checking whether the target process uses vector extension, this
> wastes time to prepare a large memory buffer.
>
> The buffer limit can be determined after getting platform vlenb in the
> early boot stage, this can let the regset buffer match real hardware
> limits. Also add .active callbacks to let the coredump skip vector part
> when target process doesn't use it.
>
> After this patchset, userspace process needs 2 ptrace syscalls to
> retrieve the vector regset with PTRACE_GETREGSET. The first ptrace call
> only reads the header to get the vlenb information. Then prepare a
> suitable buffer to get the register context. The new vector ptrace
> kselftest demonstrates it.

For the entire series:
Tested-by: Andy Chiu <andybnac@gmail.com>

[on rv64 v enabled qemu]

Thanks!

>
> ---
> v2:
> - fix issues in vector ptrace kselftest (Andy)
>
> Yong-Xuan Wang (2):
>   riscv: ptrace: Optimize the allocation of vector regset
>   selftests: riscv: Add test for the Vector ptrace interface
>
>  arch/riscv/include/asm/vector.h               |   1 +
>  arch/riscv/kernel/ptrace.c                    |  24 +++-
>  arch/riscv/kernel/vector.c                    |   2 +
>  tools/testing/selftests/riscv/vector/Makefile |   5 +-
>  .../selftests/riscv/vector/vstate_ptrace.c    | 134 ++++++++++++++++++
>  5 files changed, 162 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c
>
> --
> 2.43.0
>

