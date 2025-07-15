Return-Path: <linux-kernel+bounces-731885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28FB05AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BB7ACBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8292E2F00;
	Tue, 15 Jul 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwOwwmkX"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130F10FD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585236; cv=none; b=O8sK63fXQy5W+ToZ6iUl/0NcG+qJdrcOAIEBSpG1TBT9MFhqsS7JAsSxDg9E5mHEGaQFKkqdEfZFwr87QDnUUDuHRbEB5XurSVIrAeThsPYD575OiEpfF0Xwlyev1K86zyGJ+ycyAo+fhQXe5BBD72uZwVIPI++6VKqi1T7AlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585236; c=relaxed/simple;
	bh=eJcH68dTZnSqwnNGej/fVz9qUIxZ83T3awH+/zmeQvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIjRS6hbB2HQy9pvudwZVHY2oO0w6eWvYyLL/cshNFij8/AEaAOEj3mD784UJN7XIuKsZeAtQUihWSIQbAlLZvlsRvUcSChnQHeUboF/HlDEQTuiXiESePdxeHd0wbpq1l/sf4mnNgIbBrejGdjcFmDitvdySmq11IFlGmpOXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwOwwmkX; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87f161d449dso4668960241.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752585233; x=1753190033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbDFWRsHAHLpHMVNyiplmEgMwEk7G0M5DlSwpSbUTcA=;
        b=hwOwwmkXsSY1KY7h+7ekpTTHZQVBJMgKH1EIBi4FoMeB2HBXdu4w/XvTpdTA9CmbUL
         PZtDtGGUwAJkCHmrY0BRTl7zvZ0J9GC78UqOjaYgQnye9o63W2Z/1kwwzGXWurBb8W3T
         yw3oPAk07yMj2PE80JyqwP7gQyuShk/S33xwFH9tkjL1qMM5SY4pcG2DCM+q2JNy5jfo
         HD8i9H/iounq93XT1BC1AXcE5PAdQ8fy9cfHq0fb4I9MONcB3tY2VxBpv/VPucwmNoXS
         NS/v1RcfjT17/j8/1jIq3oSCBOlj1B1/NdyOZsBvtt1atpNJH5DZ8SD+dAW2/ebHZ/9M
         vlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585233; x=1753190033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbDFWRsHAHLpHMVNyiplmEgMwEk7G0M5DlSwpSbUTcA=;
        b=JNFtN7XTTq/7seTVxq9UllYyD3bJIGJSlFQnDcVicpZOtDc4YnRlpMC2Jh7ytS9om2
         3p5leS9M6JbUUmT6pfPywJstb3MRK/puW7ZglrI6nG2hFMybQ5E5yw2HCW3AQ/AfdMMc
         gnQ0Lv8TOnYPjt6EOs8ZwFxNK7M8lHAgkfvShl4L4jf7H4E+NXo2/NRrm6yl2B1HUz4e
         1Xfck5XBFV0N6sYpJpdGNQmkN4QSEk2AdaS6l942t6fAFCMd5yb9hWbpsZhiUpfy/uR4
         J9x0DIRvxlnrzhXRzo7Y1NfgK9xUjqVb5LL7Sml31RABr4V6c8lTzZnZKAX0HhPYdPmv
         QNUw==
X-Forwarded-Encrypted: i=1; AJvYcCXBYURhMOnY07suyDvwdZ4gfPJCvu5LQOjvd3MBo2Yekpv/r4lx148ib89mYwQCUBQR0vQUL/YTANPBV4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rsGjyI8j5zcbHSLI9UmSaoTFCg2wGeeu6lpDNT8vq0yUOUnx
	nP9j2zScLwCiWwSrAhT2n3EukpRH7kMseKMFRox15Uvl6yYreHMXpvnEBMX+xKXAxT4/faK+N/u
	Kbg/L0G28hPUsyTeDw5OiV+1rlEN4Pjo=
X-Gm-Gg: ASbGnct2v7Y1Ctq8UJjwA7OH/k++NtwrJxqYvpd2NDFVQBesZK8/tkZ4LUnf0XqIb2v
	GZVTLj21mO6JfIEGO3infbf//C0ZNE8sT930/J6boUvXnDUAW7x4PBk2Csf0Kh3W1ZLAWyK6wPv
	XN5xe1KRrhLZm1otbLLPlyE8KZlH36jAhDWfZbJkqbQcvH3x9/J7m1sieSzLPc+NFdCDxv81UbM
	4JSZBySFw==
X-Google-Smtp-Source: AGHT+IEjTGVkyeENXrb3wsoZFCXRR7teVOs9ZG3LcJDfn/6S/DX1Z0jfg4DlgDBX2ZfGx65zefSZBcoJ4xzp7NrMpE0=
X-Received: by 2002:a05:6102:38cb:b0:4e6:d7af:a7b1 with SMTP id
 ada2fe7eead31-4f642442816mr9416285137.10.1752585232734; Tue, 15 Jul 2025
 06:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-2-guoren@kernel.org>
In-Reply-To: <20250713155321.2064856-2-guoren@kernel.org>
From: Han Gao <rabenda.cn@gmail.com>
Date: Tue, 15 Jul 2025 21:13:41 +0800
X-Gm-Features: Ac12FXxIe08JtqP4Zd45XgTPp7kGcElpp7m8ymIKWqMzCjAKN6I-WoJy-eT90kw
Message-ID: <CAAT7Ki_sa4OPkC9EPWaeDW1LryR0wfk363dDM6uexOJSbTNsLw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Move vendor errata definitions to new header
To: guoren@kernel.org
Cc: palmer@dabbelt.com, conor@kernel.org, alexghiti@rivosinc.com, 
	paul.walmsley@sifive.com, bjorn@rivosinc.com, eobras@redhat.com, 
	corbet@lwn.net, peterlin@andestech.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 11:53=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> Move vendor errata definitions into errata_list_vendors.h.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h         | 19 +---------------
>  arch/riscv/include/asm/errata_list_vendors.h | 24 ++++++++++++++++++++
>  2 files changed, 25 insertions(+), 18 deletions(-)
>  create mode 100644 arch/riscv/include/asm/errata_list_vendors.h
>
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 6e426ed7919a..18c9f7ee9b7c 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -10,24 +10,7 @@
>  #include <asm/insn-def.h>
>  #include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
> -
> -#ifdef CONFIG_ERRATA_ANDES
> -#define ERRATA_ANDES_NO_IOCP 0
> -#define ERRATA_ANDES_NUMBER 1
> -#endif
> -
> -#ifdef CONFIG_ERRATA_SIFIVE
> -#define        ERRATA_SIFIVE_CIP_453 0
> -#define        ERRATA_SIFIVE_CIP_1200 1
> -#define        ERRATA_SIFIVE_NUMBER 2
> -#endif
> -
> -#ifdef CONFIG_ERRATA_THEAD
> -#define        ERRATA_THEAD_MAE 0
> -#define        ERRATA_THEAD_PMU 1
> -#define        ERRATA_THEAD_GHOSTWRITE 2
> -#define        ERRATA_THEAD_NUMBER 3
> -#endif
> +#include <asm/errata_list_vendors.h>
>
>  #ifdef __ASSEMBLY__
>
> diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/in=
clude/asm/errata_list_vendors.h
> new file mode 100644
> index 000000000000..a37d1558f39f
> --- /dev/null
> +++ b/arch/riscv/include/asm/errata_list_vendors.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef ASM_ERRATA_LIST_VENDORS_H
> +#define ASM_ERRATA_LIST_VENDORS_H
> +
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDES_NO_IOCP 0
> +#define ERRATA_ANDES_NUMBER 1
> +#endif
> +
> +#ifdef CONFIG_ERRATA_SIFIVE
> +#define        ERRATA_SIFIVE_CIP_453 0
> +#define        ERRATA_SIFIVE_CIP_1200 1
> +#define        ERRATA_SIFIVE_NUMBER 2
> +#endif
> +
> +#ifdef CONFIG_ERRATA_THEAD
> +#define        ERRATA_THEAD_MAE 0
> +#define        ERRATA_THEAD_PMU 1
> +#define        ERRATA_THEAD_GHOSTWRITE 2
> +#define        ERRATA_THEAD_NUMBER 3
> +#endif
> +
> +#endif
> --
> 2.40.1
>

Tested-by: Han Gao <rabenda.cn@gmail.com>

