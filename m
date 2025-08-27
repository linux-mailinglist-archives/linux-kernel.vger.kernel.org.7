Return-Path: <linux-kernel+bounces-787629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DAB378D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604CC7A3371
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666E2E7BDA;
	Wed, 27 Aug 2025 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlB3co5k"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF1DF59
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266542; cv=none; b=SiVwsVBRlJ3L7OX3BDqcRFb1s5H07jyU8sZ6nq9KYaCiE7GCnw+YjhHl1/CTv/FbmGN7GGzAMfVGjPWeAzRyraUoJDlDHsryWbOYrhwRChYgkQaBygf05Xg6QMqtBwm8X/8TlotX+uBs5yHOwAtVvykrHcZ0j0WuGAsrUcbMmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266542; c=relaxed/simple;
	bh=bTzi7QUXuDaCSJrEA3tf/IMnP+S1wCxebifcHqRDhFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW5xb94LTeo5fa/qElOrh2n4NnLwZP45UuLovDHpbhqHauQ16ZtFavgqsE5UFMxioPEpI/8QKjihhYvHrRf96zl+oGsyEpcFfs7CGhGvd4GeO1fxE10HX/uDguw1IncTDXGJAt9r3RL7wb/+qehrV6qLWiiQQ2eV/3bx3CAhtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlB3co5k; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-246181827e9so54114125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756266540; x=1756871340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ycg+k8BPaJBsXtt6oFP/HzoMA5d4/C3y5i8DrK9MTbE=;
        b=ZlB3co5k1ofJIkdLQlWAfIrEJBdviw36vY6GWuoCF6D6y43xWbrEtAj4sBYllYMcjN
         d5aX0GPiz06B8jDtpEm5QJrLE9om6z0tvwUKcj6DNWljMKxH6S1fjLC59Mhxq+gW4bHO
         vRCodeKMtGmSQiVDVCXbgpQGe8GTK7uoB/YUgs8CUdDKjcVwvy3SIRiRpKcuKE+XFHaz
         Z3+fcAP5na+RkYkiwTn+4bDf6ft7AYE9xXcDw8kCgZgdnycYvyVeZhIIKoVLhInHF+vn
         Ri7Rp3DS0hSRHf2PqDc3EvvBjqMIK+hIcBV45WXMuD7lNICa9KEL2zoZQLtyF8zUFo6G
         Efsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756266540; x=1756871340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ycg+k8BPaJBsXtt6oFP/HzoMA5d4/C3y5i8DrK9MTbE=;
        b=qIMqHWqOGNQo0k1b9K8pdIdI2DNXb5gZ55zv+fNyIkj21jdpsE6FLCbln7D+bw3PsR
         7h8JcmwKM/jsAFjDszxlFHlueHgrAAigvXDYX5G9r5inzSNWM+1gnms9UCx1aCba1VVL
         Ofw3JXUopxTkhEfvW3IUMNzIkftg6JfqAse9jQdBjsoD2Rk79fYhDpjd8cdSO0NLSTou
         nkxPZJECfTaBE1QCpXIFCrul9CPBeg8oQESrfseJEzXl+uQB4nhfgL12zFiLa2AZxumY
         BfE1PzRcKMVBpRVtF0CPenuoKJuSlrPxGCmwYv2ia2p0cLSCtXs0xikJ5hndArC3x2q2
         GQVw==
X-Forwarded-Encrypted: i=1; AJvYcCW06oaa1RR+//pxXXHcXDYOR/AaMmDemTBYyfGw180FSCcTlWv9P2AGqj/e9nCfmIZLM2npA3TO9l7XHQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzgtiMjqi+nSxRoZqzJo+vjTTCQTbD1V9fAAgSwN1T4foQ3djt
	KWXjPO8P91GYj1UtzEDq5Pk9e5YkAEqm1sCGXlpx0eACfvNambOEcBYq
X-Gm-Gg: ASbGncuF4q4J0VY9qk3fq/Xau6Fg4G/iDkKxdyPXaRn2JIP8jEr6zMuuYFDpiuD/NcP
	S/fK162bDBn5wKUyu5SBGQ22Uoh2a1iB7uh0kC2HBC4SS9nu1a9Ycmob6aWBylTLuqpQHyjcOgS
	EIalOcyiEVykNrtNiNOxrm7SLD/616UVH+47nbb5jb7SAePiwnjSjINdJs8qDBPNJDKyyQP5V+H
	ne9QgIi7w7uNTWnMwuFo6frMp+Pl8ZOxIWDKZ0Y6eqrumnvaOcbpFKRTPvhprAza1529PmVA2ri
	QFWOoMw7L3dSc2lopBWEQwaMZ+aE/vERkgB80YPOILPvV4JRe/7Fw6aYn03pOtg3hxg7AJv6mmf
	Ani04vJJq8MxEQQV9TqBtN0HmXYR2tF8J
X-Google-Smtp-Source: AGHT+IHIqHeQ+7pnLDLG3vRJO8dAn12pGtpKjSirMdb7jEheA4wnpaV508VmCTAKLA0lPi5hO65T/w==
X-Received: by 2002:a17:902:db0c:b0:245:f85c:8c76 with SMTP id d9443c01a7336-2462edd7e00mr184407845ad.9.1756266539833;
        Tue, 26 Aug 2025 20:48:59 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668879162sm109367435ad.113.2025.08.26.20.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 20:48:59 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:48:57 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vivian Wang <uwu@dram.page>
Subject: Re: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
Message-ID: <aK6AKTnUtthEnEyy@yury>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
 <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
 <aKcwtXDJKRf4O_tF@yury>
 <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>

On Fri, Aug 22, 2025 at 01:46:19AM +0800, Vivian Wang wrote:
> On 8/21/25 22:44, Yury Norov wrote:
> 
> > On Thu, Aug 21, 2025 at 05:16:34PM +0800, Vivian Wang wrote:
> >> Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
> >> replacing the use of asm goto with ALTERNATIVE.
> >>
> >> The "likely" variant is used to match the behavior of the original
> >> implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).
> >>
> >> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> >> ---
> >>  arch/riscv/include/asm/bitops.h | 32 ++++++++------------------------
> >>  1 file changed, 8 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> >> index d59310f74c2ba70caeb7b9b0e9221882117583f5..f70ccc0c2ffb86a6fda3bc373504143d0c6a1093 100644
> >> --- a/arch/riscv/include/asm/bitops.h
> >> +++ b/arch/riscv/include/asm/bitops.h
> >> @@ -47,9 +47,8 @@
> >>  
> >>  static __always_inline unsigned long variable__ffs(unsigned long word)
> >>  {
> >> -	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> >> -				      RISCV_ISA_EXT_ZBB, 1)
> >> -			  : : : : legacy);
> >> +	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
> >> +		return generic___ffs(word);
> > So, on the previous round you spent quite a lot of time explaining how
> > 'unlikely()' version is handy over '!likely()', and now use just the
> > latter. I feel really lost about how the code generation should look.
> 
> It's not "handy". The operative part is "has_extension", and both
> functions return true if the extension is available and false if not.
> Functionally:
> 
>     if (likely()) <-- equivalent --> if (unlikely())
>     if (!likely()) <-- equivalent --> if (!unlikely())
> 
> Whereas:
> 
>     if (likely()) <-- **opposite of** --> if (!unlikely())
>     if (unlikely()) <-- **opposite of** --> if (!likely())
> 
> All the asm goto dispatch stuff work like this:
> static_branch_{likely,unlikely}, (arm64)
> alternative_has_cap_{likely,unlikely},
> __riscv_has_extension_{likely,unlikely}. Maybe it's confusing, but it
> seems to be the convention.
> 
> And, codegen-wise:
> 
> ALTERNATIVE("j %l[no_alt]", "nop", ...) -> likely() ALTERNATIVE("nop",
> "j %l[has_alt]", ...) -> unlikely()
> 
> Since the original code has the "likely" pattern, using "if (likely())"
> preserves it. Whatever the codegen was, it's still the same.
> 
> > Can you please share bloat-o-meter report against this patch? Can you
> > also show an example of code generation before and after? Have you
> > tried the 'unlikely()` one? How the output looks?
> 
> Thanks for the tip on bloat-o-meter. I'll take a look tomorrow.
> 
> >>  	asm volatile (".option push\n"
> >>  		      ".option arch,+zbb\n"
> > Yeah, now the diff is much cleaner. Thanks.
> 
> This is why the condition at the top needed to be "!has_extension". So
> the structure can be:
> 
>     if (!has_extension)
>         return sw_version;
> 
>     multi_line
>     zbb_version;
> 
> If I used "if (has_extension)" the code would need be
> 
>     if (has_extension) {
>         multi_line
>         zbb_version;
>     } else {
>         sw_version;
>     }
> 
> And whether it was "likely" or "unlikely" had no bearing on the
> structure of the code.

OK, I see. Sorry for confusion.

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

