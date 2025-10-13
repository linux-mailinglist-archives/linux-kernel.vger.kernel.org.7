Return-Path: <linux-kernel+bounces-849857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7BDBD11B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150B63BAEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D01E264A8D;
	Mon, 13 Oct 2025 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9axQ+OV"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44164339A8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760319763; cv=none; b=stty8+SdDV0gh9pjeq4URiz+VR7Ja/jlOY5x/3oDORuBVDoDVT1go5WVBsZGSB6kZHhWysspWlaH0NE90WIdKAR3nIQFbCczHzAZXY9rB7lSPByYzbMZ7jvnwbQznYyXuP+XWZMXcKemBAmnoIN7mY0j6vRZSAXnqffZIOotjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760319763; c=relaxed/simple;
	bh=1RXmBvZpwCUQnfnUxu504fpIYK8mVRkUaMUCkiuljCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ruu9X5tXwWO4iNT/PY3vrd5r7QLt8wg+fdhw+B0N3dmehUOCpeTIk3xZ9/aJGiNTaB1aCyYyQXOYAnIk39iXb9nWViGCTcay816Imfv+cCulQoFrsHiwzqTpqLKAagro3Xq2NMbMRU1KgE0THsqJxXiTLN5sxl4jYtZDGSfxD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9axQ+OV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-650304a822aso152016eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760319761; x=1760924561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZPY89QcCW1ODY+qCZOoE3O7xE8AabOtvINBloElcoI=;
        b=E9axQ+OV5SmngzW9W/8SAOGOh3cwu0VpYKFd+9NQ6gclFK9/zFRbv8Tbkx/hugO1LH
         rPJXclQSitl39BtheZljZPpfn90YFFGlIEGN7zzKHoofDw8vZiC39SRqbhi1RgcDAvH/
         1BBg1raBxJbKCMv+PzuYDzec0fgON6BsezCEPucCPlTgw65jheJh7qwv72cjH/D3EByT
         fQkfJR2jhzTaC9IwC7QMdrm0u21mgdxSkiYngrvzm4chvFOI7PiNO7nwNxEDfoili0U6
         4g3PHf0PsCUHRR9KqkGjdzr5ahhgBXdtUJbKRIZhpM4Cgfql5O0E34bRHkAQRiQuLECo
         qLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760319761; x=1760924561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZPY89QcCW1ODY+qCZOoE3O7xE8AabOtvINBloElcoI=;
        b=qgZGEkYeXvgYf9i/Bm1fwmHgFcaiAQ23z0c3qjFyXzvxyWIQ1/iH8opRtPF4i96fRX
         kbofZYITjLPIlaEOjz0A01fc1/ahLEC5M5eVZPUPIFb8JSZG+OnZMLqr0w5EQR1q5ahg
         3ozPSaKGUtWHeHgwz/wcBu64qKGFsEmcyrTHtD1hqhQOEUmdo9nygWMiyoGVavHyXD7K
         CFq4XWf9t/JEJwuXbllnnj8Cwa9R1xnolIWzyAm7rdTuobeA8kljo5TIlvgHCk885eQ6
         +Twk6Hpodg1D9uZHigmaFMfRik+xXqZWFKv9xu9Fm+fN4nXSufnUcQe2NJCMQHnBLW+H
         sbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7XlsFVrjCQI0LEyxfBf0xJ02hf9xQNmu6oMjTAJT9Ay97Zix3coN0SN14QBqCYUp+iuHHqVLBeuJiH2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJq5Mov0debZKYvkP3kfXcqmoFZ0k9QG6yeMifBo0TqJqj+us
	MtxjwGusKv5NCYmPi019lBok/EtLoGEQmbxoKs+OMcQg0HAfyHb/ysWQP67YY9f2FwZuNryYA5k
	NKDcr+zjDtqKxaI8yc8M+9fG3cIJo2g8gPw==
X-Gm-Gg: ASbGnct8g+HU/XEkjGOgZ+cl/mzsfQ1SvlgR5kFmG0SjbWrvJg4c9eVH6NazQ5WsRQA
	yqUxZgsDSBdpBsoX+TvHwmYVCN5evE+xF5ZUCKjiu/QmfAqiwdj9FxubBTYCGFhEWk/nRx6FbYz
	NV8RwkSyFeyoQwgNujI56jQdEphJ35VLyGErrAqiDMwTPXWdGUE/6IJLz/9JdxFaSC2xlRHfIyK
	xnUwDQI+O1/Cszw025djpMw
X-Google-Smtp-Source: AGHT+IHYP3dibH/f1x2CaUF5Y5qltN0GZfOBX7majkaJVuTomgK3AWbTQB+oXo1Tc7gUg4HY3nLwGt47mmcXZ0kFDMQ=
X-Received: by 2002:a05:6808:6ec7:b0:441:8f74:e7f with SMTP id
 5614622812f47-4418f741aeamr5973198b6e.57.1760319761263; Sun, 12 Oct 2025
 18:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718072711.3865118-1-zhangchunyan@iscas.ac.cn>
 <20250718072711.3865118-6-zhangchunyan@iscas.ac.cn> <00a97b26-0269-4c07-99b9-33bb759067f5@ghiti.fr>
In-Reply-To: <00a97b26-0269-4c07-99b9-33bb759067f5@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 13 Oct 2025 09:42:05 +0800
X-Gm-Features: AS18NWAl8D98G1NQ5dYcpQkVO0Vnz4Q2Mr7ADFdoZHPtKW0Eo0sci0K7w0wIY68
Message-ID: <CAAfSe-umv64D011cjxPJEc0dBK29Xa4u6m1T=-THZ+V=a3f+JA@mail.gmail.com>
Subject: Re: [PATCH V3 5/5] raid6: test: Add support for RISC-V
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Charlie Jenkins <charlie@rivosinc.com>, Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	linux-riscv@lists.infradead.org, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 22:09, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Chunyan,
>
> On 7/18/25 09:27, Chunyan Zhang wrote:
> > From: Chunyan Zhang <zhang.lyra@gmail.com>
> >
> > Add RISC-V code to be compiled to allow the userspace raid6test program
> > to be built and run on RISC-V.
> >
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >   lib/raid6/test/Makefile | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
> > index 8f2dd2210ba8..09bbe2b14cce 100644
> > --- a/lib/raid6/test/Makefile
> > +++ b/lib/raid6/test/Makefile
> > @@ -35,6 +35,11 @@ ifeq ($(ARCH),aarch64)
> >           HAS_NEON = yes
> >   endif
> >
> > +ifeq ($(findstring riscv,$(ARCH)),riscv)
> > +        CFLAGS += -I../../../arch/riscv/include -DCONFIG_RISCV=1
> > +        HAS_RVV = yes
> > +endif
> > +
> >   ifeq ($(findstring ppc,$(ARCH)),ppc)
> >           CFLAGS += -I../../../arch/powerpc/include
> >           HAS_ALTIVEC := $(shell printf '$(pound)include <altivec.h>\nvector int a;\n' |\
> > @@ -63,6 +68,9 @@ else ifeq ($(HAS_ALTIVEC),yes)
> >                   vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
> >   else ifeq ($(ARCH),loongarch64)
> >           OBJS += loongarch_simd.o recov_loongarch_simd.o
> > +else ifeq ($(HAS_RVV),yes)
> > +        OBJS   += rvv.o recov_rvv.o
> > +        CFLAGS += -DCONFIG_RISCV_ISA_V=1
> >   endif
> >
> >   .c.o:
>
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks for the new version, I'll take that for 6.17,

I noticed patch 1-2 are in 6.18-rc1, patch 3-5 haven't got merged, not
sure if there's some other plan for these patches.

Thanks,
Chunyan

> Alex
>

