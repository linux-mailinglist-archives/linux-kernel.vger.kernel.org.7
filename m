Return-Path: <linux-kernel+bounces-797064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83822B40B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3091B6190E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24055341ACE;
	Tue,  2 Sep 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrU7l8Ta"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032E341AAA;
	Tue,  2 Sep 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832363; cv=none; b=YkaIiJG8vQp8C7ks2MaCXRX/y+PASKzZo9ZEONL/5TlfruTJ0F/iZu3bMG4njIpTO/CEjNUHBpwr7dJQmHLRBnzQaJF2UBN4ZshDjuoSdo8iiZUQt2XMED/i49OU6BUbcfb7txacZftGLrJaQnZlOJp2X+4qJQlw8Mx77OuMUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832363; c=relaxed/simple;
	bh=HUkSGRPN4BD+fEvRlZx7d7GFizdwa+PnjQ0AQqBdqaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp9bsEVPYTfidH4zSWom5QVFUltI/Q4BKHC8yOvAcIO4XyHmMzonFUxTo3O1Iw/c5BvEi41CFD9JeJ5V447uWWW4Nnq3VqaXMZiKO2h6tIJu88klbvjwg/bE63UuaEMQ2kfCNmHXII4TFK9d0qo150zZnTQaoyyUnJp77zC6+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrU7l8Ta; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ace3baso398066066b.3;
        Tue, 02 Sep 2025 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756832360; x=1757437160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtcABniGBGfe4M36DJWdff4JzQBtomJlWVOqnivR4+0=;
        b=WrU7l8TaU0meiRT0oqIoVkMKvJiWK/sSayV2J7s/ggka6N18iGC34DEWSSWjod0Rpn
         3Eb1uWxi9erbosT4wRsNQy2vstD/mdb8aoeY7oGT9BOmfF9yCF8w0pQFjCLXEtAyujU5
         KeJ079rR3JiRm0uCHO3pXxj4d1/pmdnDis7jIoHnVMtc5Q6KJLPJPegq4D+ZRpZE5xvD
         w7UP2ZIuJe0DTsMcSdZ2SDEzhvolbw3ioNhYBHRviYE9ATfdalAnCTNl6g+mtQU9ZdyX
         QyIGpvlyzm76p3nj6ublXq8VbCcBuoi4we/D3mOHOxoZXIN0g/byQANf+ON5UZ0Z9zvx
         SWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832360; x=1757437160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtcABniGBGfe4M36DJWdff4JzQBtomJlWVOqnivR4+0=;
        b=vIq4k0OUlkj1Gv4UEK6ytFqjr2rJLq4gp1rTSCK090oJMZG89B7wLvMr+Bb63nPuXD
         oNr/rx+bl1ItQKK6oVYIBa6dDLTjDPOadlqU0m4xUfkqGKes/jaqRIhGzIxDtBR5rTlx
         PZodYSFdCPMrOkHE9TXhTEzNJSdx5x5Cl9lIBKNZmm7xEjKVhbYA5YL5IK9aT4mfazzI
         Hb5VAlfU4ez9CYXq/b32zexUTHXaB2iXTWvRejraStulMq/utbYoG0SkzYcQObx1geX8
         F/j7EIT12nzV5hSgTEoJldfneMGRfSyVErnHmWaM4Qj+IIcKIL/wMIVwApfk88KfAbAK
         /gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd0XRCMX2aVM1CZpVA2aUldGP9mUsQ6fasNGUeaw68g57787HdSfFWYL9wJcQH/xLjC0vTsbFyU8Ou@vger.kernel.org, AJvYcCXfLA8Uei+mhPBIJTYAjIfd8PAgdWasNrBJIlmrDr7i9okgluI7wLqLGc/1btQyqywk9easExhBMDpEgoiK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XTyYDDTdYnsYx/2gQOZlFOq9ty3FHShqjt5t7ApQYVFWOjrm
	YlMIgnaH5HWoN145zpHUkX1r6cXaT0miRy4qrusTCyo4vdAhikpVqg21
X-Gm-Gg: ASbGncu/Z8SzgD7GUFip+RKBBBkXzXoOQ2BvbeepLvdV6aps8z4A0DT3tkxMGLiXi0t
	AAoCC2N0kGn3pa4ZF2kCbj64LTMDuJLWKm8oICUHIv/9A6AlN16nknNsmEDtORO15PDTuYIFckQ
	6bOn5CloTK2tsm/wr0iGPWLPqh93bfNPknpchKIFMjI85RrPx+gHz5Z13HCP2maAjr06QDOoUyi
	Tqwe1kOqBaj2ecsDPpwQZdWTpiGkUAgLpHqv5AxT9tEvEwz4mhT9PicQ09c9101Xfcy8vwlpwou
	T7eJ4Z0R0lIgjA3VqLwp37MSXXDTgfT09wwpCRMvKtaWye3g13LFo4BcoUkgFLTwZEKhwVGZCNE
	NADeOwIDLY1bA4ncqrA==
X-Google-Smtp-Source: AGHT+IFmwKHYfonApFOOGip4uG3j2rTCt9Nr86ZM5L26iKq4gF5nLZmvoVLWR3ySUVIH9PxrFVWW8Q==
X-Received: by 2002:a17:907:1b22:b0:aff:16eb:8b09 with SMTP id a640c23a62f3a-b01d8a2639dmr1080892366b.5.1756832359853;
        Tue, 02 Sep 2025 09:59:19 -0700 (PDT)
Received: from andrea ([151.76.45.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm3236369a12.20.2025.09.02.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:59:19 -0700 (PDT)
Date: Tue, 2 Sep 2025 18:59:15 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Subject: Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
Message-ID: <aLciY2putG8g2P9F@andrea>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902042432.78960-1-luxu.kernel@bytedance.com>

> Xu Lu (4):
>   riscv: add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: Instroduce Zalasr instructions
>   riscv: Use Zalasr for smp_load_acquire/smp_store_release

Informally put, our (Linux) memory consistency model specifies that any
sequence

  spin_unlock(s);
  spin_lock(t);

behaves "as it provides at least FENCE.TSO ordering between operations
which precede the UNLOCK+LOCK sequence and operations which follow the
sequence".  Unless I missing something, the patch set in question breaks
such ordering property (on RISC-V): for example, a "release" annotation,
.RL (as in spin_unlock() -> smp_store_release(), after patch #4) paired
with an "acquire" fence, FENCE R,RW (as could be found in spin_lock() ->
atomic_try_cmpxchg_acquire()) do not provide the specified property.

I _think some solutions to the issue above include:

 a) make sure an .RL annotation is always paired with an .AQ annotation
    and viceversa an .AQ annotation is paired with an .RL annotation
    (this approach matches the current arm64 approach/implementation);

 b) on the opposite direction, always pair FENCE R,RW (or occasionally
    FENCE R,R) with FENCE RW,W (this matches the current approach/the
    current implementation within riscv);

 c) mix the previous two solutions (resp., annotations and fences), but
    make sure to "upgrade" any releases to provide (insert) a FENCE.TSO.

(a) would align RISC-V and ARM64 (which is a good thing IMO), though it
is probably the most invasive approach among the three approaches above
(requiring certain changes to arch/riscv/include/asm/{cmpxchg,atomic}.h,
which are already relatively messy due to the various ZABHA plus ZACAS
switches).  Overall, I'm not too exited at the idea of reviewing any of
those changes, but if the community opts for it, I'll almost definitely
take a closer look with due calm.  ;-)

  Andrea

