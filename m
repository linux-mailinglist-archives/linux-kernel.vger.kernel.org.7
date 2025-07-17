Return-Path: <linux-kernel+bounces-735518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D190BB0906C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52A14A2AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58B29AB09;
	Thu, 17 Jul 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="l1bZu5xd"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C831E8322
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765554; cv=none; b=tyWOfkJymJO5flLMpobEr4brJVLK3b5/gY/x1PgFLejZ7i2LupcMAklu1hcCyE19r9JXv9NA710RoY92s73+KvWS34FvfFpkJAWCS6aLg76p3bQRPDxShT30MXRtGXhLbm028X/pJiDpnWGqkRmQBbBQm0w0puoCuC2UmVVJHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765554; c=relaxed/simple;
	bh=sEH8huyYpvNQfqn9VnitIqOJAs+4IuQO9XkijYeBhU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sby1WD5P38oX/CntOvFjT/P9IdLZvXiJUz1PUB7oorr6Xj7gP7f+lO7AzVti/izAUo0+5fhVg/Dmxy5k477TUBjHRInPQp/GvwREOGkJmkKtjSXYMzFm2G83jc9D/TwJHAXa3E3Lpg3LJDpvMJ5qOcQncu+BMUTtN9TWyxOzeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=l1bZu5xd; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e3142e58cfso67260885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752765552; x=1753370352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5xUBrBCpzFPT/Ceifws++OIUGJp175GJMu2Bn4O4tU=;
        b=l1bZu5xdE6uWJs44259xRXhy10gnZRtWRoUxfxENA3CQ552uq/scQJyqpj9ccblpWy
         VgQKUgKIl2nrZlxCN36Ax6sirnNolTz4rkKjktVUJpumCDuJydj0YAxIdpY4kKGJiFOg
         U1arDbrsTrH8AGUSUfy0ZZwXCe+X333PEIzP7ojFAiyvuhHnoJ4LXHp7oXMmMh/OUvcJ
         OmE+kd1uh0IyAMiwOnmP0aju1y8u0agFvyfqp0E0AGmv/jtxQW0f2hhm+z0duxLHXXbK
         paDpCCiVOit2mLMZu/7DiPxm7ugojlEzWXyCuz0MaczLfTgOnkQRI1KOf6WzfDZC1wVN
         plZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765552; x=1753370352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5xUBrBCpzFPT/Ceifws++OIUGJp175GJMu2Bn4O4tU=;
        b=KGDr5OcCJmnEBkg2TNXNCGrfeLxs0z4okELWHNYE8ae8/78U2beKoomEqoaMpsLDS8
         BMYGxZOk/F4x1j+I9RBuUhPa2wNR7WUrEXNcg2J8w9NHPx4PN9ub/QgFWITQUSu2qitq
         JQHR0htLmkaJXewYeWtaeJeN4zg3FCXgQl/Ds+FBPT89JqPxuTZLM9KcUAL3uedzA607
         1QH/GbjdZhz8OWPQLcSc2w24BWxjIpbUrb2zOzYBVeg4+RGRh6wvVXdgPyy658Z13jpV
         TmPu2XAPxGAUKk6mwsaYhhQuxTBzKc4hAIaX2uHJ22B6wueu8n59jswZF8sHqab0bT3F
         Z6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXX1lBdz5naHavTUUcCstZ853s3AM2TZvo5UJ/xTn0uHKgKU8K69PA2V1cOIYt22ALv+WVF51o01eDwLJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgiytDp8jQs3ppyRsxMTm69T6W+Q+JctbWuFQeUGXVpXZydsk
	OBJLPN66xykappn0AFta8RDY2rqdLvmstow1IzCprS2C0rNbXist+a3sgDQ4IVtf625yvKfLt+T
	Zk1Fq7MTV/4dgr7Dhbe4JULGkN82v1jsygKqdpXA2WA==
X-Gm-Gg: ASbGncvkKLpt/G9R0Ymoq61CIhAJ1GD/uN4gLGW+95vYkXVbTXr0mqhqsLewDz5qc2d
	p0lx91Ukja8W4onJq7ytlScMntZv09PIG7BOFhKtZBWBnito0gy5vO48RzjKPGvKLWinys7A4AA
	sCn8SBlidkraGsSND6fAwC129774nj78mYtvNP/dPDEzqRP4NumoV92ue2TjR2LfGQg7T90uLC1
	hzpF+g0
X-Google-Smtp-Source: AGHT+IE3X2vck2pgSl2t6KFn5NgHq0p0Hh8fU3rZDbhsrXFgiaKsssOSMAr59vMNLRAJb0iXVxOVbhMl8sP6UXRX7pU=
X-Received: by 2002:a05:620a:1794:b0:7e3:320b:437 with SMTP id
 af79cd13be357-7e343351613mr1118889785a.1.1752765551906; Thu, 17 Jul 2025
 08:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-3-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-3-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 20:48:58 +0530
X-Gm-Features: Ac12FXyPbawu-s2Ss3H3yKP5ugd9T6IetcEyIWyv14Bbl9oa3EI2UsBfWrZcDw8
Message-ID: <CAAhSdy304FBYo-3TZyNhKqtDsUSnW+B=U3ktR5JHLr9+LLqXEg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] RISC-V: KVM: Add support for Raw event v2
To: Atish Patra <atishp@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> SBI v3.0 introuced a new raw event type v2 for wider mhpmeventX

s/introuced/introduced/

> programming. Add the support in kvm for that.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 78ac3216a54d..15d71a7b75ba 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -60,6 +60,7 @@ static u32 kvm_pmu_get_perf_event_type(unsigned long ei=
dx)
>                 type =3D PERF_TYPE_HW_CACHE;
>                 break;
>         case SBI_PMU_EVENT_TYPE_RAW:
> +       case SBI_PMU_EVENT_TYPE_RAW_V2:
>         case SBI_PMU_EVENT_TYPE_FW:
>                 type =3D PERF_TYPE_RAW;
>                 break;
> @@ -128,6 +129,9 @@ static u64 kvm_pmu_get_perf_event_config(unsigned lon=
g eidx, uint64_t evt_data)
>         case SBI_PMU_EVENT_TYPE_RAW:
>                 config =3D evt_data & RISCV_PMU_RAW_EVENT_MASK;
>                 break;
> +       case SBI_PMU_EVENT_TYPE_RAW_V2:
> +               config =3D evt_data & RISCV_PMU_RAW_EVENT_V2_MASK;
> +               break;
>         case SBI_PMU_EVENT_TYPE_FW:
>                 if (ecode < SBI_PMU_FW_MAX)
>                         config =3D (1ULL << 63) | ecode;
>
> --
> 2.43.0
>

Otherwise, it looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

