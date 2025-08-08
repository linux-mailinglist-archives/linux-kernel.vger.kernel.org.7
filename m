Return-Path: <linux-kernel+bounces-760248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F0CB1E878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9339C1898EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40B27700C;
	Fri,  8 Aug 2025 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="KedpE9RO"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA84C8F0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656607; cv=none; b=s9ySILKGnZ+sjijk5Zmn6BdQClDow4mHdBDWL66qHmdgxnp2BM3zZ5o+kC3vRXG1el750zSYTg1K4Yb6lQhXHvxlHQDnDmfD4YYoojQqUH1dwBjQEJmTJs8om+QKownHHgiIG8yQmMLO/UfSy4IY+Dr5LD3ipPY1k4FcdTsMXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656607; c=relaxed/simple;
	bh=mciXqH2GUekD5bIhtYabTeQorF5XwOQA2SG4e6Bns6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT6j/egBxufW0mQPfKz6sVqM7ETka3D1GuokVyr8zYk8M0g2kJ/uTBbF3hFTNbhEdVeZzU7++IP/IvBaORhTjX63n8DfkEZamPncVSzhkUShAGUQqO4DfEvtqHC7bj82HqytgDdl1nQ0YTdxvwWx1peRCcN+JZlvf41zBjQeKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=KedpE9RO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e806613af8so246956385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1754656604; x=1755261404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=So5R9ZlnKJJ4obt5mEmMc4Ho0dKfaA3unsl38Yws8b8=;
        b=KedpE9ROcgUAMGS0qxXRNbDTlzGcFHk5UCZ2BbUKSnm67upwH06fuzv3CaJHReQBNh
         k9+j7Q2KgXc2Opy4LEunIyep1vt/s6nEdhCiyG4jHHJyGt1KQf76LW95YatjzQpXi6Kf
         J9htX4WCmF1hnxgxCAhxGzIi9UKik3E9ULxtbbQ3sOy5aOwK7KlK7Zh5dcS/MHiZRv3P
         XVK2rMRRE+icpyuoDo+7kwzcCK4w2zzPpoYA9hZiSVzB2IMSL4e4WoIi/d6XYxMxi0rQ
         Y41HKnZyAGT6ELD/rtF39PIV4aPeW1q9B+/LosOy9fdtAQ0rIY+ZrdjQLu1XLrVLsNg9
         2Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656604; x=1755261404;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So5R9ZlnKJJ4obt5mEmMc4Ho0dKfaA3unsl38Yws8b8=;
        b=dgHstHUXH8olzkbIuv6/DtYg2M4eKWyhA/QTrEWaA4geKYi/GEGsrqxg4/D9oswrwe
         NizH6EBxoWawuIYpOq8EZWf42rXyCB97xrn1WbP8qU1EXX/0GvQdcwJzsjEICXdw0TwR
         bWlpL3NVWBwM19vAD2dZ3bZBvCgvUPmx0ekxpc/YZMM3IbukK9IDEoW1ixwhQKz9BCf2
         JBoxWexkMtKkkon7mrXb080agjQ3i7YiRO406LHvApQSigLxKg0uy7aH6aH0H22YIBnv
         66zjZZSxVh1rm2Y1Ko+sjgtqz2q5JTk34pEyJtYgTo72PTB4yFnL+/BmEVe2L2oiuZa2
         uSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfogS02sPHTkWpKxnkkIT2X546Nh4F0Q5M8CWmX44y2cEkbFtwiq6QpQ/8vCRk8Ywd6kk/yaA4RAnhbVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybvShqgmbDaee4QMlxiRi9rVc9SV9ZNgq0QbZYsPBk3P+rvzZ6
	TyGjFfznfIfbMRSK9XTgmYY/B/bMtmKeyFXu9zT3REyC23WvMYR1RmyKSfxNCk6b
X-Gm-Gg: ASbGncuD1hSM3TkRrp0or5hr1yBWNUU3JvgEibrrUbTzc6ibjuLAya3+R0KIykvZqW9
	7oFvymnfM7p9Pu+TsrJV47cYk0C1hGN1Dtx7A2MciDr57bQr7laGGuvHHgoY1s0OKjJAU8SRIMa
	OH0czH9OBijIHuj65Jp4g9zu99PzhiZ841SpB3c4xbMFUogwiXTHz2wp8IT1BHpYZS25Dwvch4w
	sz1SANkNt5TqwLKzrglSgAqji4XvGwRembRYc+xICeFqhKgw3MiK3gqFcoJqRZ4c1goxHGO5o44
	wSBl2BFTXWBTK96dpYAbwDXoVxgNvPM2ymmL9Oyc+gYbDhw1zInK9l39Kj+N8sZyJiDu08FJ8Rl
	pShk0iA/yBptKmyWJ6EaEOg6Py7Wp3eEKbPx7qFo5Ww==
X-Google-Smtp-Source: AGHT+IH2lbmFHZqNHJVGHjy4ogO2VYhO6V47Bv3oIaip42J0xoV/NzCukHATaOzfImBWGhmprpzXeQ==
X-Received: by 2002:a05:620a:2910:b0:7e6:67b3:ebf2 with SMTP id af79cd13be357-7e82c68965dmr374630785a.27.1754656604365;
        Fri, 08 Aug 2025 05:36:44 -0700 (PDT)
Received: from localhost.localdomain ([37.19.220.61])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f72b045sm1102877685a.60.2025.08.08.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:36:43 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:36:42 -0400
From: Darius Rad <darius@bluespec.com>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>
Subject: Re: [PATCH v2] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aJXvWuPKIc2lCSX3@localhost.localdomain>
Mail-Followup-To: Drew Fustini <fustini@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Drew Fustini <dfustini@tenstorrent.com>
References: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806-riscv_v_vstate_discard-v2-1-6bfd61b2c23b@kernel.org>

On Wed, Aug 06, 2025 at 07:03:28AM -0700, Drew Fustini wrote:
[...]
> 
> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
> --- a/Documentation/arch/riscv/vector.rst
> +++ b/Documentation/arch/riscv/vector.rst
> @@ -134,7 +134,25 @@ processes in form of sysctl knob:
>  3.  Vector Register State Across System Calls
>  ---------------------------------------------
>  
> -As indicated by version 1.0 of the V extension [1], vector registers are
> -clobbered by system calls.
> +Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
> +where vector registers are clobbered by system calls. Specifically:
> +
> +    Executing a system call causes all caller-saved vector registers
> +    (v0-v31, vl, vtype) and vstart to become unspecied.
> +

Perhaps:

Clobbering the vector registers may prevent leaking information to user
space and aid in debugging, but can significantly increase system call
latency for some implementations.  [...]

> +However, clobbering the vector registers can significantly increase system call
> +latency for some implementations. To mitigate this performance impact, a sysctl
> +knob is provided that controls whether vector state is always discarded in the
> +syscall path:
> +
> +* /proc/sys/abi/riscv_v_vstate_discard
> +
> +    Valid values are:
> +
> +    * 0: Vector state is not always clobbered in all syscalls
> +    * 1: Mandatory clobbering of vector state in all syscalls
> +
> +    Reading this file returns the current discard behavior. The initial state is
> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
>  
>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
>  
>  	  If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_V_VSTATE_DISCARD
> +	bool "Enable Vector state discard by default"
> +	depends on RISCV_ISA_V
> +	default n
> +	help

Perhaps add the following paragraph:

Discarding vector state is more robust, but has negative performance
implications in certain implementations.


> +	  Say Y here if you want to always discard vector state in syscalls.
> +	  Otherwise, userspace has to enable it via the sysctl interface.
> +
> +	  If you don't know what to do here, say N.
> +
>  config RISCV_ISA_V_UCOPY_THRESHOLD
>  	int "Threshold size for vectorized user copies"
>  	depends on RISCV_ISA_V

