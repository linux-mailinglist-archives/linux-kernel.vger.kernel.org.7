Return-Path: <linux-kernel+bounces-834223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDABA437D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C997BE879
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA711D516F;
	Fri, 26 Sep 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHHP65m4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92F199E94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897067; cv=none; b=ErJmDHHNTA2XCk+FEM4itvxbew46JD19KV2VqY9TgRxxbjl2uHvQ2zsoraH+JbPnjOJWxNPUcStIs1byPPWO45AiRRRrD/hzGrqZaRxZ+CgZvHOHyV1hT2PvjiBqMzjJWIfQ7wNTS9umiYz7yvTHHvHv+lXE1jxg45WRFNfiWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897067; c=relaxed/simple;
	bh=IGdCqM/yTaiPyzZyhYs3irmCvSMu4bZkT42mEj1Liho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsFkFKDw+fCGsjRML9sfwvlmSbYLyvZZwQRS27qLwEw9SryOzeCsQoutFJlbILvPsEX5x+rKcXQ7thVdGEvz5t75CBad1m8wHjxj8qYPN/2iHlYmCL3k42rDLGD5xSE0jawdM+MhpYwJuE5IyaXQ/uR07glU0m7fwXS46Fe9wts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHHP65m4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77716518125so1197592b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758897064; x=1759501864; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eu75bAdjt5h24Mx1b29gb92p1XKKnNXBr/2FE3JcqU0=;
        b=nHHP65m405iqIZWXPLrVYY6B49xE6ICq0tyYEo+89liQiLzvCGRzprgyEjl2JFp0Z7
         ttBdnF3hfP1UpMxZIoFxvV9nIr1/mo2y23GSbWJaVcqaLnGSA7/Z6cZRtcKjdTYX3/MZ
         R+T5g42xY11+yrHSNkWxiSzq0IVOl8GrbTX4zOfJfqPtelIDmT0B7Xh23cPF5al3+rQe
         epxPYUMAuvN7Gl7yGNpxtnHusn/mxcc7r4c4TlziGQMsLUzyydxSKfLK0JUsA0v6hfLl
         m3dTraO9Czwje7jSfpA1j22W23lVCQdc+qXDAXJG7d0DjWPBiPSzephdLl3l7UlyxmCy
         Xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897064; x=1759501864;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eu75bAdjt5h24Mx1b29gb92p1XKKnNXBr/2FE3JcqU0=;
        b=R98mLMjq1fe6PzGzrVYR4zrDZSxG6T9LDj8G6IB8PEVRnsbSRe3nGdbEmXxtk01Ukw
         c/4yyfCyk0eYOrSDffah13mj31xUKCSrA4pY0+GSoIjEZuTG2JpB62LaoARW2y/O8qvE
         g6+19YrcPrWpEXxrIQyI8YMImMeKU11wX6t+2dSTfFnuQ7ZBRV1GLtD28BxUG+0UqxIZ
         krV1asx3i9Z8pCOvyK5xfj3bRcE082vYiq+yNrFXsAv63X7QNl65pLsAJbWqf2QgWC9a
         afzjZOnUg32k8IMoHF78YZ4/uv3UN6OhEepAR/z8gpVjWE43MMB8HsZwycWhjPq25oj3
         h2kw==
X-Forwarded-Encrypted: i=1; AJvYcCW+PaAtXcCBjA0R8sAoaWBU96j797L3jTdU2rDMRIhPnnGWdOi+3PfMDLWugS2+Dd374BNbB7S0s8oPazI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaXn43IZ+i7n+wKrxtNmNgEDRZsK8rM/G35bL1+Fv0/hy+d+q
	L7uSNIAWN6Qc1n9264n8V0SPi+nff12cpj8Hz3Za6kExnoiBl4uDC9iCuXAVxrft
X-Gm-Gg: ASbGncvwhIP7/5c+fAYpDLR6ZMfPSvnEaZo2pJwUIodkRXbdsZl0tvmjjQA4UtfVJ4o
	22yLsKxtv0IZTYuUfWL7WxYRm7KdokQLeILoUm9vp4FrmjJa2P0DPEX/LsxXq+GMpmbtHKdMRcF
	EBlHAYwv3LyDl5DQWoKPW+mtQafbdTZTvJaHGpnfkXRKlZDkqfUn2slHK+BPjo+jr/aGQTUXW+M
	eUfnyMJp5UL9lsxdAzbaYXRNba8I+tvW0xJxlLDRCHBBRNm3rvVI0w3zuZQ5HU44Fnymqc1R/Wn
	hu2SUzRw2fkuy2IAjS9Kopg4PQIDzch3IFI0oR47e+Vb9Dgx4uK/clHP/uIQBiewaL1qEldiEtS
	2/PJqAoc2wMJiDMAn5A7CrML4y52lFfyOj5Y=
X-Google-Smtp-Source: AGHT+IGltOAbo12hajVKgocbpBnHZMZeOL2ERzr9t+RXZ6PnxdAexobpssI/N7xOALCEb6/v2s939A==
X-Received: by 2002:a05:6a21:7116:b0:2f9:4cde:34fb with SMTP id adf61e73a8af0-2f94cde4d16mr2209198637.1.1758897063477;
        Fri, 26 Sep 2025 07:31:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cafasm4613070b3a.4.2025.09.26.07.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:31:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Sep 2025 07:31:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN
 enabled
Message-ID: <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
 <20250920234836.GA3857420@ax162>
 <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>

On Sun, Sep 21, 2025 at 09:07:38AM +0800, Huacai Chen wrote:
> Hi, Nathan,
> 
> On Sun, Sep 21, 2025 at 7:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Huacai,
> >
> > On Wed, Sep 10, 2025 at 05:10:33PM +0800, Huacai Chen wrote:
> > > ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
> > > the -mstrict-align flag. However, ACPI structures are packed by default
> > > so will cause unaligned accesses.
> > >
> > > To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.h to
> > > align ACPI structures if ARCH_STRICT_ALIGN enabled.
> > >
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > Suggested-by: Xi Ruoyao <xry111@xry111.site>
> > > Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V2: Modify asm/acenv.h instead of Makefile.
> > >
> > >  arch/loongarch/include/asm/acenv.h | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
> > > index 52f298f7293b..483c955f2ae5 100644
> > > --- a/arch/loongarch/include/asm/acenv.h
> > > +++ b/arch/loongarch/include/asm/acenv.h
> > > @@ -10,9 +10,8 @@
> > >  #ifndef _ASM_LOONGARCH_ACENV_H
> > >  #define _ASM_LOONGARCH_ACENV_H
> > >
> > > -/*
> > > - * This header is required by ACPI core, but we have nothing to fill in
> > > - * right now. Will be updated later when needed.
> > > - */
> > > +#ifdef CONFIG_ARCH_STRICT_ALIGN
> > > +#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> > > +#endif /* CONFIG_ARCH_STRICT_ALIGN */
> > >
> > >  #endif /* _ASM_LOONGARCH_ACENV_H */
> >
> > I am seeing several ACPI errors in my QEMU testing after this change in
> > Linus's tree as commit a9d13433fe17 ("LoongArch: Align ACPI structures
> > if ARCH_STRICT_ALIGN enabled").
> >
> >   $ make -skj"$(nproc)" ARCH=loongarch CROSS_COMPILE=loongarch64-linux- clean defconfig vmlinuz.efi
> >   kernel/sched/fair.o: warning: objtool: sched_update_scaling() falls through to next function init_entity_runnable_average()
> >   mm/mempolicy.o: warning: objtool: alloc_pages_bulk_mempolicy_noprof+0x380: stack state mismatch: reg1[30]=-1+0 reg2[30]=-2-80
> >   lib/crypto/mpi/mpih-div.o: warning: objtool: mpihelp_divrem+0x2d0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
> >   In file included from include/acpi/acpi.h:24,
> >                    from drivers/acpi/acpica/tbprint.c:10:
> >   drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_table_header':
> >   include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 declared attribute 'nonstring' is smaller than the specified bound 8 [-Wstringop-overread]
> >     530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
> >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro 'ACPI_VALIDATE_RSDP_SIG'
> >     105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
> >         |                    ^~~~~~~~~~~~~~~~~~~~~~
> >   In file included from include/acpi/acpi.h:26:
> >   include/acpi/actbl.h:69:14: note: argument 'signature' declared here
> >      69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;       /* ASCII table signature */
> >         |              ^~~~~~~~~
> >From this link this seems a comiler issue (at least not an
> arch-specific kernel issue):
> https://github.com/AOSC-Tracking/linux/commit/1e9ee413357ef58dd902f6ec55013d2a2f2043eb
> 

I see that the patch made it into the upstream kernel, now breaking both
mainline and 6.16.y test builds of loongarch64:allmodconfig with gcc.

Since this is apparently intentional, I'll stop build testing
loongarch64:allmodconfig. So far it looks like my qemu tests
are not affected, so I'll continue testing those for the time being.

Guenter

