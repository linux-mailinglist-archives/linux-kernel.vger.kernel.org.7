Return-Path: <linux-kernel+bounces-733502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97247B07585
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793CF188C8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EE22F5086;
	Wed, 16 Jul 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="t+0ZoszS"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494220110B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668698; cv=none; b=Cwwu1lHc6V4ZhlyNuAuGQoXwD9nAjWb/LsCrr6pDsDblhIKVaM9NETiCXBjhJu3ehHw5JigbqEJYefr2vffXm4dXkinPCeqFbe+EKMjMN2Qrl3T+5H7qG2OpaDsHAZwRmc+Xo+iCrjsOW3bKPMGrYotIciUZNsFRZKUeuZ/yvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668698; c=relaxed/simple;
	bh=QBmGc04qrGG+YLJBXEt+7DTVkRFbk8EiP5rSyfHg2qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwzqxJhaB0S21J2xBQXV0aMwAROjGsnUNulU0s5IWmTc33rDo/HgBKx/3oGRswqdfFEpv/rE70PJiRBtKM0ojxXhsjCkPgdhBAjxO9HjQhFMX5hn519EcwAmAobubQXeFriEijDpS+N2vYtsf1yPEc5bWgpth/qbBDQdOW3xkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=t+0ZoszS; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86cdb330b48so509112239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752668695; x=1753273495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ufN3hObMca4GLsjT1dwHltCBaXf3kFOYG4s7v4Jw4M=;
        b=t+0ZoszSkPCglWi3xR/+KVV2Q4nWSFRSgVGCdv4s61JY+4Jl7AgYdpElBSES/d7L3W
         ktf4RKfp+3CF4tL2SfsgKScP0fa/npV55VhbzBetOvZT/6aCSsh0dVxb4ypO38jz3UKE
         QSLM32xmEEDd63CiahXXEXi0lOwD9cbD3qbOXCwbt8YAAg8zHEfvFO18zOc6qet5JfZd
         B0F/y7GZB8EF/zkAvzqmvFO7qI8d0sRqqzmNzq0VqiLhqEsnndFOGfW2tuCbI/HzgMeX
         z6H8TgGMKsC3vc+48+Sd8wos2992eklo7GQgSzuSiuHrFb1BoQY5e+2rihfTZRKHPL95
         xPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752668695; x=1753273495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ufN3hObMca4GLsjT1dwHltCBaXf3kFOYG4s7v4Jw4M=;
        b=RU4bLKkM+8HQs8duu5u3bGika3RLrjNQECJvh9jUg2OAyPS0vxGp+NmLRYDkZSOeky
         8VGGyAl/STjsK+SpFibK26fdyjo8yEAG1GpFD2zsaX1yUop9RiCMtyrcVlLsOdJsT1XV
         8uLH+qrPhOGDYEyIuzBfO363/lTX+j3M7SRYts4IUcZzBxueatS22GBJT3qE6zLvTO1y
         meGelspKhH5Q6yIORVWLLwo5PODGrtTJpNmlqSi6ejsE16RjQeeO+AyI9lqAG3Pz4ezJ
         2IvC+YcJygdVdb3zP9AvaRkkrWHA7wC5Rm2VQgNlxcWtp+5NEZQMKwkWgeGV6wiX5FAb
         cL6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJaKAWOpRweC1lqKWy5aUa6B7usLsxPjCme9OT244fvQctyheU1RZQd1KKM+rc9s5V9nKnOzcTvRWWW/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9qd+6v6SkPigYXpSMJrTRSLUupZ6WJnixj9RaoHU8lbe6x4m
	3fGzU0miIFiujPx/C42Wp0ylzactexltxS1IQ0l2wBPfPJufSoAqVDKZVyzSFE/6ivo/vtdfA8L
	0OGIyeTW+O8KME4ZYoJleKeAIGWuvwc039wS688Lnvw==
X-Gm-Gg: ASbGncvrwrgE2dA9Cw5fEybh5LDJjVj9S5i86VZ66k+rm5NvzNav2hBi2GZYKrZD4I7
	no/oVOjX0buOJ7ajicNUo45kKIhnAKW8Jw/XY23r5cSjtBn7GlqJPblYtbh/sv4zSehjAREfQBb
	ca0mo3ZFT/vc0ax6BCr9j+CD/Rr49YlD7lv2/hmNiiv9YjEW+X1hSmWEaU38mYMXz5eEnKTTXl6
	A/OMnw=
X-Google-Smtp-Source: AGHT+IHcBKm14IqMY2zZCku6eJ3aL9uOlgyeZlrEeJEsEb6pBAtDYAiLwB4M4psg96+hNqoIYo09iBakwOdp9w74hpw=
X-Received: by 2002:a05:6602:154d:b0:879:572e:238c with SMTP id
 ca18e2360f4ac-879c091cc40mr370204539f.9.1752668695035; Wed, 16 Jul 2025
 05:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111004702.2813013-1-samuel.holland@sifive.com>
In-Reply-To: <20250111004702.2813013-1-samuel.holland@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 16 Jul 2025 17:54:43 +0530
X-Gm-Features: Ac12FXw5fRuKRk9Gh9hKxwhWqS2DR3ZACynLX0_VX_3TVKCKPIkjC2p2q_9ELUM
Message-ID: <CAAhSdy2x+bskK2Du-ys7TCeih=QEFRkkydg2VYGZniEt3zW3=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] RISC-V: KVM: Pointer Masking Support
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 6:17=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This series adds support for pointer masking in VS-mode inside KVM
> guests using the SBI FWFT extension. This series applies on top of
> Cl=C3=A9ment's "riscv: add SBI FWFT misaligned exception delegation suppo=
rt"
> series[1], which adds the necessary infrastructure.
>
> [1]: https://lore.kernel.org/linux-riscv/20250106154847.1100344-1-cleger@=
rivosinc.com/
>
>
> Samuel Holland (2):
>   RISC-V: KVM: Fix inclusion of Smnpm in the guest ISA bitmap
>   RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Rebased and queued it for Linux-6.17

Thanks,
Anup

