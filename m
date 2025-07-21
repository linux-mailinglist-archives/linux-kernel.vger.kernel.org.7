Return-Path: <linux-kernel+bounces-739872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D9B0CC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724F27ADC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9D23FC66;
	Mon, 21 Jul 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEr1hJ3k"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD423ED63
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132808; cv=none; b=XscQoQR02S7Aw6JfGa3rOKIYZYYyZGO0NyE2vLnjrV7POcv6ysV27MP5nsNlMWdmdEQxqaRMV6OT2KHxS58scS26opsFgaPtmCkGj1CyhsZCnc+O1odJDH8fYnZ5wNqcjPii4QFW0S8LbUDlKmCw7jXjZQDqbg4sh9ni3CEIACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132808; c=relaxed/simple;
	bh=LKu67CIYq90TwwyYHAYyvC8j58xllgMDUbwDDwSNTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdxuei4EN1K3IiassLuHzfFNXXpCa8On64sQn0F6lsWnZRzLZ6syCVKBNraAOl0dGCJElfwrd1LTEf6z3Ps+jDi+Gigx5vzApW/QqGV+dRpbDfWRQ4F3ummyY9OOiM99ns7xVjix7bOk71K6bVmEOUU2o7jkm89wxe9p37L9bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEr1hJ3k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8f179e1bso48039065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753132807; x=1753737607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NsMO+b+iZrAnk8twiiMQUvHd9IjE0h3cm/6jfh9vqZ4=;
        b=aEr1hJ3kBbYmXyeWJ10wI04s3Y0PsVflewIvsDRlvyYuE9NWVr8/7pjmG8MVt0dyo3
         lcHdxVsO9tV0IRcfEbDlzJw+lKm0k+plsauHNP4Qj4+8seKOBwpHoickvwYd4HlbM0+A
         78RplVuO52YefC62IEFddnCP0eiO5+tYbyKe0LCldvyEE/hLAzxgQlgokTAxgYSTFOni
         TJHRbKBM6IxgzqPTCagHliMLqG9WW9ueqEhB4emPuIB6s31iJE7uOlFjRjuqByZIaDlj
         XchuumD9MQadUxa9AOdtkgpIyLBeP8fn1mhX3HR9V8Pas4OhzLs1VMtM+lwumX4QHzMX
         xR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753132807; x=1753737607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsMO+b+iZrAnk8twiiMQUvHd9IjE0h3cm/6jfh9vqZ4=;
        b=W2YZc6R5hypOlO5Hp6dqwN3nkVsRLs5zpQxcPRraVKmleMrLA+jhcGXb0vl/goSuTx
         eCUV5Gt/hRP/hqQ4pOIh2j3d8BE++dkEKDCTgF27Ab6MGI+We0d3X3xBjTdZlUMBnqJT
         YcqZVSJTE36xCC6B+hwRi+grodatGsdXwPZhmKnD78um2AYUfDBd80v5wapdGgfFmfKh
         1I93MGr3pGiiLsymiBLsV4KF+MNxmvrYPGdBOJSQgVZBInhfycEKKjRnDLn8CsOrRZpD
         seGxssWjzSiuhdWQnR1n4i6iHVEt+frEQFS8wBjuwH9ZPuIVlTxW53XMgwP45AQ1Tbe1
         GVRA==
X-Forwarded-Encrypted: i=1; AJvYcCW5XYr68pwa9NVp2jweigjckK+D4C2Evtuh0RYia5rP7DrkUgxwSu4Elk0wAf8O1pT7+6pBDU38umqhZbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58WE9YC3cTk80vF8yS6oQ1BSalYHol0mh7x3/6HGQ4GzgkgaD
	gKa/M4pJuKEoDrgrMX/4ObfKgQXkXTgyhrIOnFrsHYym8EjxMFLOXmgw
X-Gm-Gg: ASbGncs1qLscBSEyj+dVMf45IVnC0ft8yy4h7klHA+j9sLh9oSKiRrxIoHcNNDxBLw/
	83ffvf2lHK2ueFJ0AozipPiQC3K6qxbecSjzbZjwFtmj32WbzNy6kS48r48eKetk0UYrbx60mEq
	BuvpazsgXZGvdd/TL9TtmoPR+BuReBRnnv2RfEeJCzvpS3VZ66ZCAkh6VcKoIaJmwI6l0FSZ7sH
	1gMRvMvVCdSSLcvRoIZsqYyoqXN/sg75SRrtJsHEm9BnQe06hifJQoBtmjvNXgtPcEKObKde5p6
	JL5PZLa+3FrJmv4LsqKTM8JoZ7sSwqgZ+WXJtWt3cqUSv0jL+72wSIdrEJ8Gd50ffeX/J22YsQx
	zEePUUCGaXRhsKGJYQjKJQioT1kvEnX4SuB0eVkzx
X-Google-Smtp-Source: AGHT+IEkrqK81MGGJPFPsHSJxmlWubLxrncXIrtyZWouT8x8xtt/3iePZr5qCtjEQXIhNUovnxMIdw==
X-Received: by 2002:a17:902:c40a:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23e25693727mr292205455ad.4.1753132806605;
        Mon, 21 Jul 2025 14:20:06 -0700 (PDT)
Received: from x1 (97-120-254-139.ptld.qwest.net. [97.120.254.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3d5asm62662505ad.15.2025.07.21.14.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:20:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:20:03 -0700
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Drew Fustini <fustini@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Andy Chiu <andybnac@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Message-ID: <aH6vA+e5v7NMMGnc@x1>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>
 <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>

On Mon, Jul 21, 2025 at 04:54:25PM +0200, Radim Krčmář wrote:
> 2025-07-21T14:35:38+02:00, Radim Krčmář <rkrcmar@ventanamicro.com>:
> > Shouldn't the RISC-V Linux syscall ABI be defined somewhere?
> 
> To clarify this point.  My issue is with the following part in
> Documentation/arch/riscv/vector.rst:
> 
> >>  As indicated by version 1.0 of the V extension [1], vector registers are
> >>  clobbered by system calls.
> >>  [...]
> >>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
> 
> The ISA does not say that vector registers are clobbered by system
> calls.  All the ISA says is:
> 
>   "This Appendix is only a placeholder to help explain the conventions
>    used in the code examples, and is not considered frozen or
>    part of the ratification process.  The official RISC-V psABI document
>    is being expanded to specify the vector calling conventions."
> 
> while the RISC-V psABI says:
> 
>   "The calling convention for system calls does not fall within the
>    scope of this document. Please refer to the documentation of the
>    RISC-V execution environment interface (e.g OS kernel ABI, SBI)."
> 
> We made a circular dependency, misinterpreted the ISA, and probably
> implemented a suboptimal syscall ABI -- preserving vector registers
> seems strictly better.

Thanks for providing these references. It does seem like this is
something that an OS can decide and is not mandated by the ISA or psABI.

> > How come we could have broken it with 9657e9b7d253?
> 
> We changed the ABI once, so maybe we can change it back?

Reverting 9657e9b7d253 would solve the performance issue for some
implementations that I've highlighted in this patch. However, I am
interested to hear from others that feel the current mandatory
clobbering behavior is ideal for testing (and maybe security?).

Thanks,
Drew

