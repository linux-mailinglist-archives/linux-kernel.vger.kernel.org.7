Return-Path: <linux-kernel+bounces-761125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D0B1F4B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE825607E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457C298CBE;
	Sat,  9 Aug 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="fNcsrYI2"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06A157A5A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754745785; cv=none; b=hY8gVOe/UXE1OEow1Oa06ojGlQgcoHXVzpvtiXmcDU6Qs0OJMB75KxzHwbQt54mmk6UBOtmQv6tFWNruUM3yjR6qkMNZkSUuoDb+9QbrJW+9odLnF9oaVZZ1ajy7iEZS8O17IWOMznbwSNGzWv4561V1VqGyl6fbWbr+np+3Eaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754745785; c=relaxed/simple;
	bh=+KyfCEflr+zZidAMqnUZw06lZ660anfekMb+MV59imQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0enl2Yas6LaiEzTyHdyo1qkVclExoN/1aHziTYje+5boM4anYcNLtV7RnKTgaUG46vEnFMM4/MFYmhc4hlwWXs6ck0H+VPWB/v+LFEZ7MJZa6rFfDSysgbILiqfcg3vAA8RMMoCW9eIukE/z6MA8ILWDc43k3mbfzk6+63gzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=fNcsrYI2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso30108236d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1754745783; x=1755350583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1HWAIl/l6Jo/icoJcFI/eQvHLHYv3eOCzqgLsh2+qQ=;
        b=fNcsrYI2fV0prO4ma3apgK0/xIcci1TXq59c61CmS6v6GEDlSxSE+7Qd1DZL+KORHx
         /TC5AkUUSFxISI1OA4dHP7u/Rkr2NoYXhGg0tzS5nFSvG0db0UdTYHZZTSc1/DQN2666
         vZPlQvfGpgQTxJ1KWO3tzsHuBTy78Lspd4fExzyClEWXXl3U9q65UU501eb8uZoEjSOm
         ekJRvZJEA2AeGOlW13q5pJmUJ6rd7cO/yof/UoaG4/b8ZBa6L42SG0AiR/RvTgOY1a8k
         5CmYJ2J7qSNsT9Qer2N8mlT0ullxM25hfL7oI817IEZOQ3g+0F7LIR5Z4Y5GljGU4wiz
         pwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754745783; x=1755350583;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1HWAIl/l6Jo/icoJcFI/eQvHLHYv3eOCzqgLsh2+qQ=;
        b=btvug0fPn4WElXbHV1zL71nKVXiO9/aVtYUAF1y0zmlsyttGxC6N9dWJRiEMwuc3Lr
         HMDKFt0IU1UuESjjsJlkbJvs1vPti1HrrM0+7uq+vXUg3IpFUASXRT1PBygjg5gkInMI
         Fq7Y50P4RZ7M7uBvdzPr5IADUJtl2QUjtnsJ1EEs/87bMF3o9CU89Hcu9Jj5o3hJSeC1
         PQgz+FNh4GZUPQ2FixFPOZdkQ27QVBVhA/jOHBnXtX2hMMEFOLR//T7ymMyVWVNX/JCX
         X37xKolxeylMSwED829G9vHhC4nVnvUbflQ5UFaqzSOYQeITl7E2YLFOIwRuud8C81uk
         Xi9g==
X-Forwarded-Encrypted: i=1; AJvYcCUl4Ruoa19RWoE4aruyb6ktz4mzv70w6N+OutOFr6SXOTXrlpLO/ILA+0xA3GlPJP8ZuXSn49shotay4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9+616f3BJ+A4UuYq8OxyPS0kreWnCuAiFU/vKnYr5dzn9/8V
	qESBNGwWWli1XKX9dkbJjrohYCh76/9BkL9CtiIoQEPbT/bkfJjQ3gMLGIdufnUe
X-Gm-Gg: ASbGncsEoAHKZ9H+PeFMvGt4NHNQ6BXQ6ZxkxhussyF/vWV4iu6vHVA1n9VSnOlXrbw
	SP0F/aHpCkirPwhVxiA+22XsOM5APnwvF001qdMX5vP/c6+JI7cZf2fr3IqrKYGcLneNwT7pGOd
	rM1ZvJP0IT2Lo6GV04mzFOqEjeAiXjS+l5o9s5mwab/2YWKVyoDAjpUq9fPwaIbjlurjQ7q1Vn2
	wifEiCneVA5LVvEsfy8tgjQ4m791NLUFUwlvoK+BJf1WzXUtuKp2yYj9WesKNrTYTpD1s/mZKWd
	XSCawMtXMSiTzCXcYNMWQJWb+0fwhss4Sc+RC23ftxHRIGVzog4LW0oeW1+o5DqDQH6tgzZ0cYk
	TQStTIylh1mYK6Uv7yyPlFrVcZP2fZf8=
X-Google-Smtp-Source: AGHT+IHnkjLCl6BuRx0vZJ+XlCeUb46kGhdYSIkBrOOBdb1kcWB7KRzOq298Msvi9tw1zh6I7RJfNw==
X-Received: by 2002:a05:6214:1d0a:b0:701:77a:88b with SMTP id 6a1803df08f44-7099a30586fmr77763936d6.21.1754745782762;
        Sat, 09 Aug 2025 06:23:02 -0700 (PDT)
Received: from localhost.localdomain ([37.19.220.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7094e245309sm88739056d6.1.2025.08.09.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:23:02 -0700 (PDT)
Date: Sat, 9 Aug 2025 09:23:00 -0400
From: Darius Rad <darius@bluespec.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Drew Fustini <fustini@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <aJdLtG8jcAxT8idC@localhost.localdomain>
Mail-Followup-To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Drew Fustini <fustini@kernel.org>,
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
 <aJXvWuPKIc2lCSX3@localhost.localdomain>
 <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4d21516-23b5-404b-a7da-cf6ebfd02dbc@iscas.ac.cn>

On Sat, Aug 09, 2025 at 11:58:24AM +0800, Vivian Wang wrote:
> My previous comment on v1 on prefering clobbering with VS = Initial
> handling aside...
> 
> On 8/8/25 20:36, Darius Rad wrote:
> > On Wed, Aug 06, 2025 at 07:03:28AM -0700, Drew Fustini wrote:
> > [...]
> >> diff --git a/Documentation/arch/riscv/vector.rst b/Documentation/arch/riscv/vector.rst
> >> index 3987f5f76a9deb0824e53a72df4c3bf90ac2bee1..b702c00351617165a4d8897c7df68eadcd2d562e 100644
> >> --- a/Documentation/arch/riscv/vector.rst
> >> +++ b/Documentation/arch/riscv/vector.rst
> >> @@ -134,7 +134,25 @@ processes in form of sysctl knob:
> >>  3.  Vector Register State Across System Calls
> >>  ---------------------------------------------
> >>  
> >> -As indicated by version 1.0 of the V extension [1], vector registers are
> >> -clobbered by system calls.
> >> +Linux adopts the syscall ABI proposed by version 1.0 of the V extension [1],
> >> +where vector registers are clobbered by system calls. Specifically:
> >> +
> >> +    Executing a system call causes all caller-saved vector registers
> >> +    (v0-v31, vl, vtype) and vstart to become unspecied.
> >> +
> > Perhaps:
> >
> > Clobbering the vector registers may prevent leaking information to user
> 
> No... Not clobbering does not "leak" anything. If you find that it leaks
> information, please report - that's a bug.
> 

That's why I wrote "may".  If such a bug existed, either now or in the
future, clobbering here would limit the scope of it.  But this may not be
important enough to mention.

> > space and aid in debugging, but can significantly increase system call
> > latency for some implementations.  [...]
> >
> >> +However, clobbering the vector registers can significantly increase system call
> >> +latency for some implementations. To mitigate this performance impact, a sysctl
> >> +knob is provided that controls whether vector state is always discarded in the
> >> +syscall path:
> >> +
> >> +* /proc/sys/abi/riscv_v_vstate_discard
> >> +
> >> +    Valid values are:
> >> +
> >> +    * 0: Vector state is not always clobbered in all syscalls
> >> +    * 1: Mandatory clobbering of vector state in all syscalls
> >> +
> >> +    Reading this file returns the current discard behavior. The initial state is
> >> +    controlled by CONFIG_RISCV_ISA_V_VSTATE_DISCARD.
> >>  
> >>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 36061f4732b7496a9c68a9a10f9959849dc2a95c..7bb8a8513135cbc105bd94d273012486a886f724 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -656,6 +656,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> >>  
> >>  	  If you don't know what to do here, say Y.
> >>  
> >> +config RISCV_ISA_V_VSTATE_DISCARD
> >> +	bool "Enable Vector state discard by default"
> >> +	depends on RISCV_ISA_V
> >> +	default n
> >> +	help
> > Perhaps add the following paragraph:
> >
> > Discarding vector state is more robust, but has negative performance
> > implications in certain implementations.
> 
> "Robust" is too vague... I don't think this word is helpful for anyone
> trying to understand what this does.
> 
> Vivian "dramforever" Wang
> 
> >
> >> +	  Say Y here if you want to always discard vector state in syscalls.
> >> +	  Otherwise, userspace has to enable it via the sysctl interface.
> >> +
> >> +	  If you don't know what to do here, say N.
> >> +
> >>  config RISCV_ISA_V_UCOPY_THRESHOLD
> >>  	int "Threshold size for vectorized user copies"
> >>  	depends on RISCV_ISA_V
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

