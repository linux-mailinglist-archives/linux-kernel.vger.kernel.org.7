Return-Path: <linux-kernel+bounces-780894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55BB30AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251B23A6B06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37619D07A;
	Fri, 22 Aug 2025 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9xMrYXs"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E3393DCB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825142; cv=none; b=tTz/2tMBH1lBNXgka7C22tQcMrqmQeN10g6vxszVNqGPTLAGXSD8VDmW7MZRHuxiL0155RvT1neM94iIl0csBIA8R2x8myDTHrbAScD1xpM1iHsYOtSvisht+W1astCy7DkkynpWgfEera0Qp+JmZG+oq0wJyWcJHujtqXSBDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825142; c=relaxed/simple;
	bh=1w9ZQo1QuUIFGK9ero+dpXtPi/S9+pvO89f42HIseyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRUASqh0LY7T6RVIVrff8mj+PC9Y9NkS/lsqlr6eLBuLwh+GFpPrbke9LEnhGnJ1T1qI2EnQdf4lckKfnvGkMROKhazArRdnTrlxhSt+gonIIXjlz9PsZYxJ+6UpRUADf9nemlmSx7BwWw0FfG79pu2sIQ9jnZSeV8d2cDDWWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9xMrYXs; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89018eb083eso822049241.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755825138; x=1756429938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0FcD/oVxoPQ77T4biPgELeumlOupiV5BH4VUwkpTs8=;
        b=l9xMrYXsynwnDOKQlylYQRI9BKbdrGrr4NpbFTQK6uWuuS7nYlqq9Jig6JK1lNawzO
         IC1enjm2+5Zt6M92nPDEVToTdvMZLiqGRvtp2k/+Xj1dxaP5tJyw1Gjtw+N16skCkH1R
         9EEpKs8cmu3owmAa2aV/BusMyMjXOC8S2qFiWOgwX1hY1nc7l+L6lknxDY2c2pTOfSEn
         kYA9Qb8TaTb7BHInqAOFOD5JTyc9SMJCH39Ns9OMR+A5cnEiErodmHf9Cdoq1LEhPbDu
         9IoRiK8TPevGiFvyXtpyilKtUnbZ+MZd4jtXOTt3AvakuF7vwnxMi02yp+AY7lpmWsCU
         jOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755825138; x=1756429938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0FcD/oVxoPQ77T4biPgELeumlOupiV5BH4VUwkpTs8=;
        b=VR2ielsLwpHjd2AAb03BpbKBxn5zNiPkXT2MAcHakieUHLo6YS0LlKU6CRbgyywJzY
         KFD9ddmQR6mlggPt7b1qTu6hfW8c/9LJ9tmCYcGG2b3n85GqcbnwNtKk8+ZFc46YY2na
         +bbhsxJIyiu+9Ehv/p+b6dNkgFWMrzyHR2O6Yoiab5JAeqvIKtFvbR5iQNswywu2pYJN
         4/lSagvD4UAjYWCiI/bDQlxUxMTkJhqd6L/YW0aiEN5xfu8M0WkX945E6asZN0EMAPjK
         VKpiX7q5wVpCxkrvj8K8eo2p+BbbohOdoE4CWLoVwRxxyvXYGhrlyJElgH1KGzmo4wg+
         4pHg==
X-Forwarded-Encrypted: i=1; AJvYcCVAMkfHTgx/LysLfbL6kXXGjX6QIPMTQ0zyMHF42i7/87c6Za5E1V/+szfzzkb8VPxq1bMym3semd1l7HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjolaDMoYddx38ogBnuwa6sUbtvx6t5CUQRpeSTbIJM4+B6clR
	a4O8iENK03YVJHPQy54OQkn02JiOPr20CXRB+HzwnTKHsRNv1o14zbziof+Dj44tjvLamP9Z5iS
	AiitO7zac5PWAlydl6kE15+POrKqJuZU3w0Ma
X-Gm-Gg: ASbGncuqHNrBRXdc7LseQsS6IxfXNUdNz1R+EWM487AYRnu1ZPXqjlg+LmHRvBJBEZg
	PF2W+Io4HFBjYkaHpUKrlaDx5bZ2LoF/pbQdC9cxnW0+6LYu0vynnt2G+OrjSd9zDb54RXe7B+j
	3AbRtkS9geb5M2+AIWtUThK/0lEJ3qr2muB0oBGIzcTNXdIYCFp9Ajc1KvyXqBkME5F1kuImweL
	V8PHBw3
X-Google-Smtp-Source: AGHT+IH3U767Rp80SVggumPoivWmgdeHwUStS+Or4TCpoL0Ia6zXuibuvpTiss1BdGLdf5LixcZUj41iKPJE7Mtj9ns=
X-Received: by 2002:a05:6102:5129:b0:4e5:9628:9e39 with SMTP id
 ada2fe7eead31-51d0c8cbb87mr352736137.6.1755825138452; Thu, 21 Aug 2025
 18:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814133527.2679261-1-xiaqinxin@huawei.com>
 <20250814133527.2679261-2-xiaqinxin@huawei.com> <CAGsJ_4wbgqGavjQNXtbFVeMw8j8oSCEVSdL4BrBVWEuNHzomPg@mail.gmail.com>
 <8db50f47-9295-4c7c-8bbc-dbbbd3fb5f79@huawei.com> <CAGsJ_4xXt2uEtAohcq+3XF_cKdsZiWsRaRh+ZK4nj0-Zw-yWYw@mail.gmail.com>
 <ca162322-b97e-4ec1-828e-dad7b09f4735@huawei.com>
In-Reply-To: <ca162322-b97e-4ec1-828e-dad7b09f4735@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Aug 2025 13:12:07 +1200
X-Gm-Features: Ac12FXxiFSDe23vD-Fzg0TGuSF7N4Xb4HsknEZzp6c-G8nrF2HXfK9UVG3NKtj4
Message-ID: <CAGsJ_4yTOPoO98TTh3oQ4t6rag==yqeYP8HQ1wKvYdvg4e1RTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Type: text/plain; charset="UTF-8"

>
> Does usr/include have header files? Did you run make headers_install
> before make?
> [xiaqinxin@localhost linux]$ make headers_install
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/unifdef
>    WRAP    arch/arm64/include/generated/uapi/asm/socket.h
>    SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
>    HDRINST usr/include/asm-generic/mman.h
>    HDRINST usr/include/asm-generic/stat.h
>    HDRINST usr/include/asm-generic/ucontext.h
>    HDRINST usr/include/asm-generic/int-ll64.h
>    HDRINST usr/include/asm-generic/unistd.h
>    HDRINST usr/include/asm-generic/kvm_para.h
>    HDRINST usr/include/asm-generic/types.h
>    HDRINST usr/include/asm-generic/ipcbuf.h
>    HDRINST usr/include/asm-generic/termbits-common.h
> ...
> [xiaqinxin@localhost linux]$ cd tools/dma/
> [xiaqinxin@localhost dma]$ make
> cc -I../../usr/include -I../../include dma_map_benchmark.c -o
> dma_map_benchmark

This is really frustrating. Why do other parts not need this, but
dma_map_benchmark does? It is also not acceptable to hardcode the
path to usr/include.

It is also not good practice to access a kernel header directly from a
userspace tool - such as -I../../include.

Shouldn't map_benchmark.h be a proper UAPI header that gets installed
into the toolchain like the others?

>
> My test is ok.


Thanks
Barry

