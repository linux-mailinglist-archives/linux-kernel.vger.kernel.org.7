Return-Path: <linux-kernel+bounces-792463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD52B3C444
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46D6A20EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894B221F0A;
	Fri, 29 Aug 2025 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kxorGt1e"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108C1DFDE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503256; cv=none; b=F8wXYNW1xZ87TYUqdABdy62RAzOip5sRS2+fkCsOeGFc0eUlUhAe22bfTcjEDb5VcYgSpxSFZziQYwZcHUzU5Fc0OhfghjersgpBl5Bch7v1us+ojo5lSN5F+Nhenp2VgzRRFB/BjvUIJD0ghpf8GRBz03abqkzbhesEDwNQghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503256; c=relaxed/simple;
	bh=von6eHvl6KgBL/4WwjFrHfO6TT4yQpG/ETSfXa6LoEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FybDsgXyXwux78PAYXFdk1XMpW8if8OIr/eVEhPGJLhoYmokXz2PJ8PDSJsBaMgCbKRFtYGUn7s0lY2Z7YnYDIDN+Ih4C2oQYx/zw0/Dms6lMEs2n4WzY7r7jlZAF/Zfipvvmlt1XZIypIeOW/otuLM4RfkdLT3jGzukmMURDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kxorGt1e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327f95f750eso773772a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756503252; x=1757108052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dis7nbiiCt2fP4GWwjgCXhTEHKxInIHXXX1XONaAGoM=;
        b=kxorGt1ei2R2eJUvSlADCInxpq1CkWQzr8J53tBHl1brJb6acJlu9nzz3XwZnS45X1
         WfHND/r6StGSKmyl6FU+OqNku9NYZKGHukp2HYPfZ7Zm3N+wKqHr/V8/uuXxuWSlIULn
         ZnSYsZIrhlwGyixnBvCt/p03IJl/WFFx7WrAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756503252; x=1757108052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dis7nbiiCt2fP4GWwjgCXhTEHKxInIHXXX1XONaAGoM=;
        b=LRXz+zR73oUBgamBcuqv5reCjxeTJHWe/YdX9R5/7wojuVcFc+Th4t2jCzEIjQZy1/
         URoMfMrgqCXU9hWIqbGaRqAWH1kav8M+2gV1HdyHyOeMVVjUSSju/i4FOh2GiOjgd6d9
         i2jYBJww5B1bfb+ldEBnk8N6wpQEbDpBzl5ZEzFhpk06mw+vczbGsaq/IYpoy2HjJfnp
         LZFResT4mRiQGM9jeM+kSKdhT7+tTuqcOfbUoD/SMLyUdHZhSiMPTVZPJXsjGIbREoE4
         HyTzb5wP/EUbB6BrTWUR4eXcMkFEA4swyHoRgl3cprwdTQFXpcYlMu8SH9IE/2cuosZP
         PMhw==
X-Forwarded-Encrypted: i=1; AJvYcCUrnGCJsLJhaDbCyvhnFYl4xjEsP89tjoDOwRougA1Ws2GEW1jcTjLfUEk0TbV6xurOIvKUPH2UYlWLIvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4js5UF3WpgvRfWbsTZokR6b+kkDTWfpLTC7B1sDqNaaeRkPFW
	wUPnJ34z+9XqjLslQZjhGLqoZSigSWII+DHoZjzbzqeyGODlCR9MPPbWy7hXFqerx+25Cq+LRhX
	JYZI=
X-Gm-Gg: ASbGnctTCCN4A/unjwinWlP80VN9/cGzrSaeiwD6FXJQF4Hl/iUt3yb9nvQT+TekuYt
	zaS9LR9rGeUPyhnSOMvZjk/g2GnAwf1KPK2u52VMNg+g0irqInRzTK6ESad/cSsClaVDm9r8378
	NqxY3thgkVCieOxJ5dlds2GOd9fTOu4V1UIoYdwEtEutOAqnCCQO2xWxJAeOTn/fbWaFD8rHs8D
	nH7FtWfpLIjvl+P7Hrto4yzqPGPhZv7cBBmNKG/pRYd2LBwnAQIlgu5LuWKy7R8k++HMZl4rqcC
	7FDeltWyhIls3Ckou7doRLkfLOgZ9xoGMoufHwX0U6GECavABaV3gjdiVWk83Yzsnztwzx037LO
	kyJRJ0MON+Pye69pq8E1ejrEFlsimSP2Z+l/rPwnk7zLpduoVBIfrYGR7ccwSPXFABA==
X-Google-Smtp-Source: AGHT+IEN095z/yVA5Q4VurWvODXF9vjW027EavZVNuPHJnfCG9kdGTdxSOROjOunRRkL8sYi7OTZKw==
X-Received: by 2002:a17:90b:28cc:b0:31f:210d:2e56 with SMTP id 98e67ed59e1d1-328156e2e6cmr105623a91.28.1756503252376;
        Fri, 29 Aug 2025 14:34:12 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327eda94e3fsm2653319a91.3.2025.08.29.14.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:34:11 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445806e03cso27548735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy+gc30ECYstqD0xh8FnC6yK9Xypmf9j0gXJCnMKe1wiOwvAMUPHRlurTkawPNc8JtQ6h8xA/PYocE5tA=@vger.kernel.org
X-Received: by 2002:a17:903:1a2b:b0:245:f7a8:bc68 with SMTP id
 d9443c01a7336-24944b1f682mr902835ad.57.1756503250127; Fri, 29 Aug 2025
 14:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827100959.83023-1-cuiyunhui@bytedance.com> <20250827100959.83023-2-cuiyunhui@bytedance.com>
In-Reply-To: <20250827100959.83023-2-cuiyunhui@bytedance.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 29 Aug 2025 14:33:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
X-Gm-Features: Ac12FXwa45bnt2Fo7fophuQQG1oKhw1sdW41Dqgu52LADz5-5chJEPC22bATC7M
Message-ID: <CAD=FV=WiZ5=4Ck3G2gme=ey6uYQhi-3Wo32DpLj9P53wxGCojw@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, 
	mark.rutland@arm.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, catalin.marinas@arm.com, 
	masahiroy@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, mingo@kernel.org, 
	lihuafei1@huawei.com, akpm@linux-foundation.org, jpoimboe@kernel.org, 
	rppt@kernel.org, kees@kernel.org, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 27, 2025 at 3:10=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
> to arch_pmu_irq_is_nmi() for cross-arch reusability.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/kernel/Makefile                   | 1 -
>  drivers/perf/arm_pmu.c                       | 2 +-
>  include/linux/nmi.h                          | 1 +
>  include/linux/perf/arm_pmu.h                 | 2 --
>  kernel/Makefile                              | 2 +-
>  {arch/arm64/kernel =3D> kernel}/watchdog_hld.c | 8 ++++++--
>  6 files changed, 9 insertions(+), 7 deletions(-)
>  rename {arch/arm64/kernel =3D> kernel}/watchdog_hld.c (97%)

I'm not a huge fan of the perf hardlockup detector and IMO we should
maybe just delete it. Thus spreading it to support a new architecture
isn't my favorite thing to do. Can't you use the buddy hardlockup
detector?

That being said, I did a quick look at your patch. I'm pretty sure you
can't just move the arm64 "watchdog_hld.c" to be generic. Won't
hw_nmi_get_sample_period() conflict with everyone else's (x86 and
powerpc)?

-Doug

