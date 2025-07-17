Return-Path: <linux-kernel+bounces-735505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0868B09041
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFE43A5F64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D712F85F9;
	Thu, 17 Jul 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="jWApNJbl"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B42F85F7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765095; cv=none; b=T2NiLBmjhsTzYq1lwiaUeijkHb5OY4JTth9J3jVUKTWoB6ZUB0x5B+pIFW3XYE6Xfyqe/ZnQLjpBfL1vO1oAo675QHw6sRqttH6vZIFBMoI7VucBg93aG06EFuttzElbtTBD9UxDj6sgYu0WjoGLXEIFUu9x/etqbksJO1OVfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765095; c=relaxed/simple;
	bh=UAuHwhH12FUgc3erk5hSuHGsnlMGDgzeXnW9mobVYE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfNv5d66y/MG9L3KUl0UDDAufxJYd59YmZNrtis8xZdyoPSjHfDHIHwe5om0uUPkU6JT449zYwuxu07UN6Aj/KIUdT8S9edpKFSB+5HZjc8F9sgcDdiCqEd7pztCLhHqiKGCC5eDm8bW0L6O5xFPNRw0SIkAUHoCoFzGCfvlpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=jWApNJbl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab53fce526so16791641cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752765093; x=1753369893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCn0C31hN22UugwY+nNOxL0Cz8wHEu8jqXWG+wcYuqQ=;
        b=jWApNJblOot3gPeA+BPH679b0KsTgKUAtjtFfNgzUjFD2jAPV01/OaX4cY1LQISHte
         rKWkOyH8rqtieQciEKjneUTESKxdUyqPqGEtOIL3xuE5nsq9eXomd3BVmPA2E8M2w9O/
         49Gr29s00GFHeAs+7n7NPPDK6Hf5fhgc1zHjcdX0ypDNt5HcED6F1kyxnU+rOigcdnhz
         l6gF3YqvZQYNlr46SLC/rtl7XnrlFvQpW2KbgPUjN9noF1OoXxUzyINjnEFlAyP7ip2u
         4X++OfjW0/dJ1/f2Ct9a4uYYv7/o3KrK8ynfkyJ1VndNT2zN0QMEmjTm3Kgxwi48NfCa
         zOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765093; x=1753369893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCn0C31hN22UugwY+nNOxL0Cz8wHEu8jqXWG+wcYuqQ=;
        b=i64RYjx2Vi9Xt2tFzX9gZPB/TeEBBTpF/4F5l7K1WYoNSn7+xbHZkWn0rDABpF6afr
         Bkgo8spLhgJ7wDkhMbuf1JNCcZULbEt9E2dI2R3EEWvHktJNfpJFYTM9YgQGAoraEp/j
         ok262+90Jl0SEuJ/nlpEtazEwFPeIPrLLPtDCVu1myIlLd/Sv0HbF0+Uw30VerOjRDAi
         sUAnVwN2e/QegmBCkOOzxPOs1DrPSK6TDfujBrsBZAfTjxW3fZUblH/M0hJvww/ckxQW
         80MQZ5eRX8E0aJ/vmWRIkLC5iUaL9EAl/1Ke+Rhn6T4gpAGco8pO/CzAbK4guTmCB5re
         CayQ==
X-Forwarded-Encrypted: i=1; AJvYcCULZmw24nLOZhS56F8CW+czizOQ11dYO1+9jEYX6W9VepbMNAYaKXLcnfIUY1GG80+E3OiB9nl0E5tZqT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8U1/WIT7PhqAQa2tNdUr8JJmnIWZRtcul/YMMV04eiEN4QQM
	ytpvyVMTTMl552/4uQaPGJwV3rgPRsdPmcNIzbI9g5gwKCd1R/EaquIEi7UW2nlxjmMYrEfwdfk
	LdNRQJ+5CneNULrLqqdivUQ3VEZQnidwPCwk/sl8iHiX7xoAOkRkAx1c=
X-Gm-Gg: ASbGnctBdxTw5ZFPCfq9V8xRIq8sCSiZrhQLlT9HlZNbXYbh+Nk9EsE6UhJ17h+Scj/
	CjmGeNolCEvfpeuu+0i1OIwEwwG6qGfSvX5j3hrgHp9IhqXgHMU2W8oFI6FdEqjBSBUPY+Vk8eA
	dKQsTJea9ZdZTUERSXgR3HOYHwjVItc5QrZry47Da9+5l2gChEec6u9g0gpInGcVQP6xA0N75d4
	BuGScJM
X-Google-Smtp-Source: AGHT+IHaFJ1sfqQyWiG9DiWncsz3p3oF6sF6SWaO0rxigj/urXDCJiahMXJIk9SDxHRXku+eh2bgCplK2qeaMk0aX54=
X-Received: by 2002:a05:620a:28c6:b0:7e2:77d0:f33d with SMTP id
 af79cd13be357-7e34356b8admr1012854085a.14.1752765092470; Thu, 17 Jul 2025
 08:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-pmu_event_info-v3-0-f7bba7fd9cfe@rivosinc.com> <20250522-pmu_event_info-v3-1-f7bba7fd9cfe@rivosinc.com>
In-Reply-To: <20250522-pmu_event_info-v3-1-f7bba7fd9cfe@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 20:41:21 +0530
X-Gm-Features: Ac12FXzdth30OveMxtaGx1W5ZBrjzTJj5_mIPZDmwmxiXuGuVRtL8fMgmMv9bXQ
Message-ID: <CAAhSdy1LVhWUovNLwfv2Y2eOzjewM005+gUENFDg-gqUaBuBgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drivers/perf: riscv: Add SBI v3.0 flag
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
> There are new PMU related features introduced in SBI v3.0.
> 1. Raw Event v2 which allows mhpmeventX value to be 56 bit wide.
> 2. Get Event info function to do a bulk query at one shot.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/perf/riscv_pmu_sbi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 698de8ddf895..cfd6946fca42 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -63,6 +63,7 @@ PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:62-63");
>
>  static bool sbi_v2_available;
> +static bool sbi_v3_available;
>  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>  #define sbi_pmu_snapshot_available() \
>         static_branch_unlikely(&sbi_pmu_snapshot_available)
> @@ -1452,6 +1453,9 @@ static int __init pmu_sbi_devinit(void)
>         if (sbi_spec_version >=3D sbi_mk_version(2, 0))
>                 sbi_v2_available =3D true;
>
> +       if (sbi_spec_version >=3D sbi_mk_version(3, 0))
> +               sbi_v3_available =3D true;
> +
>         ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>                                       "perf/riscv/pmu:starting",
>                                       pmu_sbi_starting_cpu, pmu_sbi_dying=
_cpu);
>
> --
> 2.43.0
>

