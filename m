Return-Path: <linux-kernel+bounces-777986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B3B2E025
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7E63B8740
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3A321F47;
	Wed, 20 Aug 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9FdVCOt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688C2741AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701796; cv=none; b=pfrX7dMIY12s/LqgebFAl2LYGs+u/OnhITbv5NevfUzHXxoZ0yCGAb8qJs5aw0q2EItuNPBg+sByjAgxzTZJ5r+iOJv2VvesOWGESQjkSFYL41PBb+8ipToBRRZgO3OccdR1MjyHbIQUj4famku3/LoRr1zV9Lw93akBwHzMPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701796; c=relaxed/simple;
	bh=/7DuHu+A84nt9SGy84aAMyzOz9HmQfBS7B+tZF4hKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Ndjuf1cGeznjR9UrBVPkc7wKNMdiNh5vcNMT3fu4Yb7VY0T70XF6R6AfkX6u9eq/Q2qL110ubcB0M1oMsjCxfkGv5JzPHgetrRB28kjgSkZeRCEK0HWjHMZ2y8XV4leHxleqivB/Wd/9kpmGOjcASi7cfl6rr8Fy3xAVQAlPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9FdVCOt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445806df50so49752475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701794; x=1756306594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moeebx/JYPecP7+5BXDqI16mVoleF3sa2PSk0SopksM=;
        b=P9FdVCOtdW4O7ep0OxTkTACes92UCe/7yLsNmxOeyyz+pAjxxKxlPi+u989JFUj5eD
         TiGXnXjvVfUAsulJbqWkK04TSh8dNJOh4tGk+7aQCL1ZqUAMAXqBrust/LbnV/9NHd2v
         EbRsnx2OJYnMSMEW9nt5sJWyAZ97ucWaDRg3Q3Er79s8XKjWdrqTm/BTg5SregMAJ2FD
         aZhQ1UIgd5pPBJ7YUab/5y6/wuAuBYWIvWR4HmVKyFNqE1kZM1q+h32BCdaJk7znxvch
         GyU8ttOcxhM278H6Q61XWg7M8gpMlO6/+P44yvuIxcaMF7+FBnxNDh+N+aRphS21Lz+n
         xvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701794; x=1756306594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moeebx/JYPecP7+5BXDqI16mVoleF3sa2PSk0SopksM=;
        b=bvojByuu9iPigSzdDWNqo9KWUz3h6sZRf+yNR6TIqV/sC5rOwvAqAlQSOTzgyz/uqX
         j3VpZ+eNDrQDWjd198KuruakcXsUjd6CRv1hQ5HIC0o7do3SNg3J8du72thH5S+jW928
         Y2pmCgb/xlu+sjeCwHjPLTMi6duhbzcWUzojGhu8e1Kx3ckrNz+iBQcnZNxyrd7doKBf
         m4IKK+Xhgw/PAFqxgvetXQ/qNPl2hSil/8HKfsJb+6JQk8g1cU3r5JhZcltboiVmttpO
         dWOQr7j2ze/n2NliX3kYcrhiDNgwjXZRygu7PWXAJhLjBwVGk+PELEfpZXChv/8BTRlq
         4PIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg/mC0bPcCmuRqtJ37k4iBV6khuMY31ZTx+0Fczny88TkIhC9/2CblLmq/JVvEcWkM8h2FZZxRq5B+Bro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChH8/qbuOSGLGPEYjv2WnKbRn4TO59QrQH9aerbzGNJoeBTEj
	3v7JdwE1C97Vj4dgU8iur2yhMHI1ypW/xwmoJ+BW+QZVKwLJZExIYgxufHkEuw==
X-Gm-Gg: ASbGncuc0FVbNiNnFLCWbRnfBCj+LOBRfutI8rF+hxfCX8YJqqaGBfetngHHHX4FkoJ
	8ObhSrg/sp+jenKRDqi1/LdVcl5kGuOOfmktJN6Gyr+BZLZro0vxGWnGzB2lYeELaHqYmo1ZEiT
	4Qpyzof2pNHa6Ed/u4Y4ZXzLBDCM2MUd94Xoom/xkiJfoQTgmYb4WEwJb4OJKzgygGryEjgtOZt
	UfHWDj3ZQ1a3Bj+Y6trn2tA1BcqDQv2gTBqdCIGPMZ2JGaN3MCFmFcBcFEvN3CeK5z9AIxhHxtk
	yxnX3mT0WoE1B0fvv80GH5VBJQ6wdYCAfRNbslo6aI7/XHZl+2tytyDsReL8qi68if06T7mLnbG
	FT69YKUvENJEMz/gJqxL8k1uP8Ek3II9g
X-Google-Smtp-Source: AGHT+IFvmJ+PFgyRTv6iBOk9rxDjBEezlxvSGHL//EVCX7uKCA4RaW440nBfEbxK3UBFWSkUHyyBLA==
X-Received: by 2002:a17:903:18a:b0:224:10a2:cae7 with SMTP id d9443c01a7336-245ef25dc0fmr44522095ad.40.1755701794342;
        Wed, 20 Aug 2025 07:56:34 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f374595fsm19276835ad.105.2025.08.20.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 07:56:33 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:56:31 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vivian Wang <uwu@dram.page>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?QXlkxLFu?= Mercan <aydin@mercan.dev>
Subject: Re: [PATCH 1/6] riscv: Introduce use_alternative_{likely,unlikely}
Message-ID: <aKXiH1eqGliLNb8u@yury>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>

On Wed, Aug 20, 2025 at 09:44:45PM +0800, Vivian Wang wrote:
> Introduce convenience helpers use_alternative_likely() and
> use_alternative_unlikely() to implement the pattern of using asm goto to
> check if an alternative is selected. Existing code will be converted in
> subsequent patches.
> 
> Similar to arm64 alternative_has_cap_{likely,unlikely}, but for riscv,
> alternatives are not all CPU capabilities.
> 
> Suggested-by: Aydın Mercan <aydin@mercan.dev>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 73 +++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 231d777d936c2d29c858decaa9a3fa5f172efbb8..be9835b5e4eba03d76db3a73da19ac9e2981c4db 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -158,4 +158,77 @@
>  	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,	\
>  					new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2)
>  
> +/*
> + * use_alternative_{likely,unlikely}() returns true if the alternative is
> + * applied and false otherwise, but in a way where the compiler can optimize
> + * this check down to a nop instruction that's patched into a jump, or vice
> + * versa.
> + *
> + * Always returns false if the alternatives mechanism is not available.
> + *
> + * Usage example:
> + *   if (use_alternative_likely(0, RISCV_ISA_ZBB))
> + *
> + * Similar to static keys, "likely" means use a nop if the alternative is
> + * selected, and jump if unselected; "unlikely" is the other way around.
> + */
> +
> +#ifndef __ASSEMBLER__
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RISCV_ALTERNATIVE
> +
> +static __always_inline bool use_alternative_likely(u16 vendor_id, u32 patch_id)
> +{
> +	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
> +	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
> +
> +	asm goto(ALTERNATIVE("j %l[no_alt]", "nop", %[vendor_id], %[patch_id], 1)
> +		 :
> +		 : [vendor_id] "i"(vendor_id),
> +		   [patch_id] "i"(patch_id)
> +		 :
> +		 : no_alt);
> +
> +	return true;
> +
> +no_alt:
> +	return false;
> +}

Apart from those BUILD_BUG_ON()s, it looks similar to
__riscv_has_extension_likely(). Can you make sure you don't duplicate
it?

If so, can you describe what's the difference between those two in the
commit message?

> +static __always_inline bool use_alternative_unlikely(u16 vendor_id, u32 patch_id)
> +{
> +	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
> +	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
> +
> +	asm goto(ALTERNATIVE("nop", "j %l[alt]", %[vendor_id], %[patch_id], 1)
> +		 :
> +		 : [vendor_id] "i"(vendor_id),
> +		   [patch_id] "i"(patch_id)
> +		 :
> +		 : alt);
> +
> +	return false;
> +
> +alt:
> +	return true;
> +}

This 'unlikely' version is just an negation of 'likely' one, and it
looks like an attempt to save on one negation. On the other hand, the
function is __always_inline, which means that compiler should normally
take care of it. Can you prove with objdump that it really works as
intended? I mean that 

        if (use_alternative_unlikely())
                do_something();

generates a better code than 
        
        if (!use_alternative_likely())
                do_something();

Thanks,
Yury

