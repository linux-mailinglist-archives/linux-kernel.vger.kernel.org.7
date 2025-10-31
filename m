Return-Path: <linux-kernel+bounces-879419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD25C230F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53293B92F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B451EF09B;
	Fri, 31 Oct 2025 02:50:54 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777714A8B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879054; cv=none; b=IrZ4W5ENqbyR089b/Znyu1HLRGFZjG+uDPf3rBgrohYEorHI0fGEco22L/B1zlG/YgqxbO78vVdXLXh5WuXibFoMRtA3YyC3Y7EgHVvPI5HZ3Z6qQWi71PQQWHFYS4O1xUtih07QpNjfj5i5myDT880SarCR45ezA6HW/2FgkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879054; c=relaxed/simple;
	bh=qS8tf6ZdxD5YdgAohIV+PFDGE+5VuGWpefXJWTNedps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ommJlsG2JYRTcbNbcs4yivtmdLbIuEevOKsuWoCQTfCYuBzJalLupOb9r/iifz0LSt8DGMgyeTi+yBbEhzqBYtX4Cu7RzNWg5VJL92mwvo4/a9xTo3eoUWru4rQ70oFvkMylKHAUc398JXQCyxptDZRhxM8z+3YEzIBFgsHr8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89019079fbeso929648241.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879051; x=1762483851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDVU1PDXVKtyHtSPl3IIz+yw4eJmqS8Dvhc2np0RKUA=;
        b=P/BH2VXYHwCXXcfKSrcQRRfXTqXO59AdpoJhF6Cr/mkkNU3qJVcjwYtZhNpy/7mF9S
         qY4oe6ErheqoHDRV5iGYLTPOqirG2FLFUopnIDN516928llMx8JWdJCZjgrqpeLckKa1
         2hdsuLh6emkPeV2u+P8zgmZahcqgQtqccnkKozmMQl1J4Qab8UTBqlL2W5HrI/E3eMzc
         LR2npbsvdxnMMKM56xaXWYWK/VtghpVwHwsamAvI4DeU/46xziLzmSHUqnQSrPKP5HDZ
         t8KuGyS7BuwjeK7V6JyD2PVHDCF1GxmuK+SGwc3Ttq99j3iXl6Lkm0ekuL461V8GEj3J
         EJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvt0ns5Qi6c6aIo4vSLLyAQjUKPEWx4Z7JqZMCwhYE+bySg9cflziQS3VLbU+6Q2Q2xCuPDkOEiLMR+O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzQWYj+gc9H2kutDSP8O0gokTMzNhNlun0vSHM6ie5hKf0eEW
	Zfu0I+nWJ+TiMP/cbekfkpSwTcTj4UNo/wxda9xPo8aCRITKVaGXG1eEesPr+Q==
X-Gm-Gg: ASbGncviuW4K2lygajoKTjxkVV9uX5Tr/+rsA3AwyUzNDIj/xoLFt2iDDVxXEtS5DMi
	WQOJXaWvYq5DV8sV8SkjA0wG4RlRgBSys6ZQGZuDemphvHObCjPNbJ1GCosUyiUj091EnU03Cuk
	Dy51U2aw48z0mSxiPrGxPTuTfzh3rPztgh/9RAqA0z3SMauWPeb+vv+xTBcuZq49O/WxFzobBwg
	o9v5wuQQXSx8EovgtqjwXN52sAlpChGZyfUhHVLA7Iw1RUY/dru2j1w0RrlgJtNjn0r++Uiy7Lt
	0xXG9shh62ciOfJEZVNjfYZF9uaRl3fUPKOqvR5JQiJ7N7oDyEfsMgZzXfxAGTFM7Tvz5eOP7Ox
	C5lxhlnpsH2Y7Z9tBPdazNcOCbcwgAcX+x5++2rkHHEylV5l4c3wHqL94MAXbdTY7iGXdw7gzPF
	IQ5dXt/DpsfwkLIYsa2vK86rVyhMDr4ngdl3s9rnoW6MxWz6eQ5OY=
X-Google-Smtp-Source: AGHT+IFnj7w1lQf1t6e/NwIXhhDfjOfP8yLPDwNOCBijuGp12AKgYLjb5bXE75DUf4rTA9dqRjvvPQ==
X-Received: by 2002:a05:6122:80aa:b0:557:c97f:f987 with SMTP id 71dfb90a1353d-5593e5962d9mr720832e0c.15.1761879051493;
        Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55944b976c0sm169263e0c.21.2025.10.30.19.50.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-934ad40c2c2so780839241.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:50:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSmFFnwmIqBKticJI65tJuU2Wt/XMKol+22vCPKandPsMXmpaxhrmVwxOp0eUPUiCKq0LOGpC/LGkyX38=@vger.kernel.org
X-Received: by 2002:a05:6122:2888:b0:54a:8cfe:193e with SMTP id
 71dfb90a1353d-5593e3eee23mr689960e0c.5.1761879050970; Thu, 30 Oct 2025
 19:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <aQMUGvXv6sy75nKn@tucnak> <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
 <aQMcYe5BK+Rsu3xF@tucnak>
In-Reply-To: <aQMcYe5BK+Rsu3xF@tucnak>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 19:51:03 -0700
X-Gmail-Original-Message-ID: <CAN30aBEvVbYh4bUerPSK3nk9VV=Szu845+PVww_XoU4gdMSJLw@mail.gmail.com>
X-Gm-Features: AWmQ_bkToldiXwOSFlKVHRT7mRZ7QErCYaHn1a_Ye5mYyw3G3dxbB6B8-BAj7j4
Message-ID: <CAN30aBEvVbYh4bUerPSK3nk9VV=Szu845+PVww_XoU4gdMSJLw@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Jakub Jelinek <jakub@redhat.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:06=E2=80=AFAM Jakub Jelinek <jakub@redhat.com> wr=
ote:
>
> On Thu, Oct 30, 2025 at 12:50:42AM -0700, Fangrui Song wrote:
> > An effective compact unwinding scheme needs to leverage ISA-specific pr=
operties.
>
> Having 40-50 completely different unwinding schemes, one for each
> architecture or even ISA subset, would be a complete nightmare.  Plus the
> important property of DWARF is that it is easily extensible.  So, I think=
 it
> would be better to invent new DWARF DW_CFA_* arch specific opcodes which
> would be a shorthand for the most common sequences of unwind info, or all=
ow
> the CIEs to define a library of DW_CFA_* sets perhaps with parameters whi=
ch
> would then be usable in the FDEs.  There are already some arch specific
> opcodes, DW_CFA_GNU_window_save for SPARC and
> DW_CFA_AARCH64_negate_ra_state_with_pc/DW_CFA_AARCH64_negate_ra_state for
> AArch64, but if somebody took time to look through .eh_frame of many
> binaries/libraries on several different distributions for particular arch
> (so that there is no bias in what exact options those distros use etc.) a=
nd
> found something that keeps repeating there commonly that could be shorten=
ed,
> perhaps the assembler or linker could rewrite sequences of specific .cfi_=
*
> directives into something equivalent but shorter once the extension opcod=
es
> are added.  Though, there are only very few opcodes left, so taking them
> should be done with great care and at least one should be left as a
> multiplexer (single byte opcode followed by uleb128 code for further
> operation + arguments).
>
>         Jakub

That's a good point about being careful with new unwind formats.
The LLVM compact unwind format, used by Mach-O, utilizes an
architecture-agnostic page table structure but has
architecture-specific opcode formats (i386, x86-64, and aarch64).
I.e. it does not introduce an entirely different format for each arch.

I believe the size issue with .eh_frame is primarily driven by the
CIE/FDE overhead, not the CFI instructions.
The inherently large size of a single FDE (around 20 bytes
https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwind-de=
scriptors/47471/10?u=3Dmaskray
) is a significant contributor to overall size.

The performance issue of .eh_frame seems largely related to the byte
code nature of the CFI instructions.
By encoding locations with different CFI states explicitly as
different frame entries makes it faster.

