Return-Path: <linux-kernel+bounces-730579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C17B0468F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7215716D83B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961CB262FC4;
	Mon, 14 Jul 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOc4XKYt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7C24887E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514429; cv=none; b=SktcSXQCy5uX5gtomqflpF7HXFa+NooCzhnz8G3b4j5AkRwAbn6DuuXj/rUF0Ygo5c+R/Rf8ulBIA3qR6Zvo6qk024PD/ORQ4Z/0a10c10wGH5hrKooCh+Kb2vf3jx87eDLUkH44e+c40LTGQ+5MIkShb1oHY0Q54Q//oi///rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514429; c=relaxed/simple;
	bh=NAcEGWN765NMyJPGkVkxcVBKXr6EvftVUkpe9TsokTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFdr7vdHkyBsVGqIKWLtub4wH+hFTVzljcH/Hus8wMskwnb6x+ypFI/tA+vpXeAG3Pfo4kpXaM2vtlvxK/5w7LS1JfWNlp8SANXzjHHXu11cKA4iAHB9dmOTjgdkyqbrFKyZh0PQoy9MIlj/jzJIhhcXbcCy/pAI0MV2+tTGiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOc4XKYt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2871013f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752514425; x=1753119225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3B0b5V93YPfWe1+3AICKSgs3ptzNkqsIklSYx0fG0M=;
        b=WOc4XKYtBVYUvYyb2cll5m24qBiWFRktMjOhotTX2ZZOJpvfHH19CuDe6o7QL3oAwp
         RigIVkpPaE6MnFIKQfZnopP32EriaZopK/MorbaaM05lNJdHwH8WtJ+rdt5lndpOuot3
         sQWpeMqiQnjzih4lH8l0d+pZ1+AI1U1n8rjs41++J+qQ45+xBid/JPGkoa4UVLdqUsZW
         me8LgqEGRQIT/0FI34ByznxqlV7f1db4ll0AyC6UFLO3rimrmlRhaZklxqDY0YmDSKlJ
         IDro4hFkYdy9pfu52rN0JnIt7z5X/5sNvrgmkBqbnxZl6Ze1WIP3Hmds+5ZgsqHvIe6N
         ecpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752514425; x=1753119225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3B0b5V93YPfWe1+3AICKSgs3ptzNkqsIklSYx0fG0M=;
        b=TfSpMx32eRcBg6XxZ16uh8PuFpw+eSL3cZin1yLdlYGHXkBGeYD88oic7kR3Tr5ZqE
         eLJ5ErUIdgRMdH53mspm5zqpWQW/dP4YUwJdVX8VgeHvmP3oIq/nKMaB1tkZ3Dg4wh90
         RCSw3L5PAGKKESd5NHQfPDKIPlgO68I3SK5D8NY32nshLmfveXVxHVjG0jgt0o9MiFUi
         7eGwjEa2eA2nfNea6YzG5nNswcis80PFLEWiyro/BI5fisAfRh8pw5pCEo1JlrXvn4ux
         P0mKbL+pGXUeS0E90OrwnWnIIQGlNgcPoKNI+b9Swb5McaA4L+wMKhdTOekFbesSKb36
         uS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXzt3wda9lflPja4EBflcJlFVHtSYRLQDd6sf3KTXw4kqlQUOX+MA8fJ6pR/xfiIt/b3xjgLwkgDrmrZXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQPEXq0oZlb5GLHTekVXqLp0ZUibso9pxf9d7M7/RdlTWGWs/
	EaIMdgvc7pPoTIFp4actXllnKOja2FVgDi6ud4sIIvQACkBEISceNPYA672asgzR6gM=
X-Gm-Gg: ASbGnctOqG1AhP3odk58k0ADI7riQvAQbOlT6GlPQPfGuRvw5SEw8XJTtVYoNxTAFEO
	iNUmkyVUXUi7ouMsfPQ6sNVDevA/fEgYS0aFirhtmLSmJ24kjOyqK6g9vmLC3WS2vSByytN/Qjm
	cVX04I19Tkww6uvJmDydDjcAZXH/PzaQ85sAZ+UnyKAt9PlGiOmIFuRUIJd3tc+uYnhg0p3NNHf
	EGooMC5ve0SvSyWLvEBxZDhfl+VFgyGpjXrkla1woxnDDFZbegLIqGfzaBkTM2Us1aJwnlGSRQs
	fjSZIfSRrudf8tE9cvlVxYG3O9ssubm9Rc6uhi/quIfwkNaiasXrI/Ed5d+XgzMz45GRj4VqNMq
	qe6etjI20TuGMzA9aMGyX4Jf23HEXLEoJ3sOJCkH+CJiMjWpK/DbVYbToAL6Dd8J6uglnDsM=
X-Google-Smtp-Source: AGHT+IH6DuVDTWjH8LEfRHqsJ7nnwbcR5WRp178UvNoIH9ZWv7Jkfjb9l03elkaMQ2JI0lQcObxBKQ==
X-Received: by 2002:a05:6000:440d:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3b5f187eeebmr8615893f8f.20.1752514425297;
        Mon, 14 Jul 2025 10:33:45 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm177642255e9.3.2025.07.14.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:33:44 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:33:42 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Jesse Taube <mr.bossman075@gmail.com>, Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] clocksource/drivers/timer-clint: Add T-Head C9xx clint
Message-ID: <aHU_dhOSoZawi7J9@mai.linaro.org>
References: <20250623231536.1120282-1-Mr.Bossman075@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623231536.1120282-1-Mr.Bossman075@gmail.com>

On Mon, Jun 23, 2025 at 07:15:36PM -0400, Jesse Taube wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> care two points:
> 
> 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> add a quirk for lacking mtime register") of opensbi:
> 
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
> 
> So, we need to fall back to read time CSR instead of mtime register.
> Add riscv_csr_time_available static key for this purpose.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> Treat this as a completely new patch, as it is mostly rewritten.
> Original:
> https://lore.kernel.org/all/20240410142347.964-3-jszhang@kernel.org/
> V3 -> V4:
>  - Add riscv,csr-clint
>  - Allow using of CSRs in S mode
>  - Change if return else return to if return return
>  - Change static_branch_likely to static_branch_unlikely
>  - Fix 32-bit clint_get_cycles64 csr_available check being inverted
>  - Fix is_c900_clint being uninitialized
> V4 -> V5:
>  - Remove riscv,csr-clint
>  - Remove riscv_csr_time_available
>  - Replace all static_branch_unlikely(&riscv_csr_time_available) with
>     riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR)
> V5 -> V6:
>  - Add csr_clock_next_event
>  - Add csr_get_cycles64 to sched_clock_register
>  - Break get_cycles64 into csr_get_cycles64 and clint_get_cycles64
>  - Change default behavior to use CSR time register
> 
> Posible future work:
>  - Check for SSTC support and use stimercmp
>  - SSTC depends on smode which cpufeature doesnt check for.
> ---

I would like to have Anup Patel opinion on these changes

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

