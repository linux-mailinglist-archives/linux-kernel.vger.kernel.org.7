Return-Path: <linux-kernel+bounces-780082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BCB2FD84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A3178C68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210923B60B;
	Thu, 21 Aug 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XynSX6NU"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C090241136
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787450; cv=none; b=ktdK8WmLG8ldm022dLteltbpVSNtq7d/7g/JOyW2wlUsu1+Bl4VeC28a07smDk9U8cfQxJzRyoERnFXpTdJ/UpkUyF4NQPcZ5X3oeDv1bc6c61hulMcaZ5p5Xi77+7isjJZjJWakhpK6bkMLeA8KpFBugBaa24eY/1ZmfzZjiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787450; c=relaxed/simple;
	bh=GlUfpY4SZEAJnYp13UMwTw37K+5JehzjCBJTaPu9fNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ailUDOy+TRW3McnI62bAjQigqrmySgou2GpWuq3U8jy6mCE4B5G4eoc8/0706fewZTN8ie5KXe+MGcohRTSGMz2CzfJc7Mc96B1hGJC9oK3zfjA1pyoHQ6L3KkVPC2cHWrSBongtdWR/0xZtbSBpClBpkOKEHbl9YSclJmhDvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XynSX6NU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so761131a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755787448; x=1756392248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjHsK7aYToa+HjdrLphU8TIHfwEe9ycCYnoOfoaBQu8=;
        b=XynSX6NUaoAdAJpSM3Dt21ASr11kL7Ma2P0CyXLUYjj21lALWjgzslQXTIIDAYRgoU
         NZ6sHjaT9Lh84B4M4x3nbIl7U0FVhvHFRpR+hnbiUX6Ujw5Xy4m5TWPquDL1cnfGBw7K
         UJWDAO9vYgzNADH1riLrQT4nKF7yuqVQfm63NOPlbVbzAouxR1fpu7oXPlwU30ufmhkG
         dxctrwC6a9Sp1oV5GBzaN/Boa6IbT3AyoB10WReRX72zlEK9bvxh36lOiX2kdktu8nDd
         7LTlRZIk4nsWRNBk4GpGdH54uz0/Z7Fv2JbuEOOh/sLUYzzWQU+nMJBue/BUg133Pukz
         O+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787448; x=1756392248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjHsK7aYToa+HjdrLphU8TIHfwEe9ycCYnoOfoaBQu8=;
        b=Ziullzvkn7zgP/iLgNMiXVbwd85gLFqf7fakVmlt5cJ2hk+lHuhMUCDFR9p0DRviLh
         7WPKo6ABVeZ70jjjoAJOXAcq3fZPr31hkbuk0mabGcferlLCmDWxSsV6/uKpC0dZAZGY
         xAv3TTvJ71Av814RHu82T/YT4gXCwHPdVWRBJzJRsLwZdZSnrZjy+hSToF7t0DtMImEq
         /rAEUp+HZ8ZuTnaIUeBhPPqpPiKFWgDqoSfjkv6Ea1eNDLxVlo3zGv/Rid1OqAYBeKhY
         xwZevxzGFwwEWJdoi1fK/6y/GItGhGIlc0BqR+gdlzts81BxK3jyszbtHFhzNNx/soXY
         QtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpcb1f1QfvrWL0THF/MX/sDStsoTboAsHoPPETgn7AHZu124SrX5ZYb5y4lpfrJKHRYHuxSPw1ncjRE7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmleC8CQKmVPwc4QSzSPGimXGLn/XwzdWj1JGCs2Jx4kTdQLIY
	93tTCNP6HRqqnWBd5j18PQvZR0Oy4bzWgJgcOQ0zc9K59IVT6gjseY+s
X-Gm-Gg: ASbGncvuKh244t/YZ/mGYromhFkVJPSoEQVCAkCxdujFCpWCl5b5qpjNvN751RYVf7M
	USyLi5V9Lgni5dvO65w+Tgn+jkRHay6BlXIqbAr+gtjqqZ9mx+q6SCIk32fiQBNsERGvu96T6VQ
	MUCMbS9k3dod6K57FTu4Yvqx9t4TVe1DQ7StET9PCyqj6gHe0lWgGUwYaU2/BhA9jo9vZHw6b3s
	DvCY7hBbrnQxa2yFTH5IFSvnpT08BkjbnbZvkgpjgvgjnZndI10H+j9a7ScAVDnMT+HQngBXd3t
	QgxO9svx6rv8yCeSweodV6C2imrjOeQFCOjAHO36XDf0gSCUkVcRs1qBU5WwToJ6FSBSbP32jwd
	8XflavWPgf8W70FzzPpgm4w==
X-Google-Smtp-Source: AGHT+IFrxP8HkGJxHbfo9qdv4+YAssNVvQZ9lHAv8hQBfTrfVQcYKEUe6u/sN3hKWtF5yvYWmfOJTg==
X-Received: by 2002:a17:902:cf0e:b0:240:6ae4:3695 with SMTP id d9443c01a7336-245febed803mr38710865ad.4.1755787448263;
        Thu, 21 Aug 2025 07:44:08 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f2820f48sm48699045ad.149.2025.08.21.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:44:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:44:05 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	Vivian Wang <uwu@dram.page>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
Message-ID: <aKcwtXDJKRf4O_tF@yury>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
 <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>

On Thu, Aug 21, 2025 at 05:16:34PM +0800, Vivian Wang wrote:
> Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
> replacing the use of asm goto with ALTERNATIVE.
> 
> The "likely" variant is used to match the behavior of the original
> implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/bitops.h | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index d59310f74c2ba70caeb7b9b0e9221882117583f5..f70ccc0c2ffb86a6fda3bc373504143d0c6a1093 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -47,9 +47,8 @@
>  
>  static __always_inline unsigned long variable__ffs(unsigned long word)
>  {
> -	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> -				      RISCV_ISA_EXT_ZBB, 1)
> -			  : : : : legacy);
> +	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
> +		return generic___ffs(word);

So, on the previous round you spent quite a lot of time explaining how
'unlikely()' version is handy over '!likely()', and now use just the
latter. I feel really lost about how the code generation should look.

Can you please share bloat-o-meter report against this patch? Can you
also show an example of code generation before and after? Have you
tried the 'unlikely()` one? How the output looks?

>  	asm volatile (".option push\n"
>  		      ".option arch,+zbb\n"

Yeah, now the diff is much cleaner. Thanks.

