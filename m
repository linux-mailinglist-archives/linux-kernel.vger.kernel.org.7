Return-Path: <linux-kernel+bounces-831862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831FAB9DB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB31E19C3F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB22E8B98;
	Thu, 25 Sep 2025 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft5uzJdn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CB288C2D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783030; cv=none; b=uHO2gYzqtb3S3V9GWBcrl5zIGlMxA8UPJ9b0CFS6fzTn+XgGrmn7aWcQl+tEX8R+M4Sx+UitrD8nTwhePDaIJdHKjEL3r3zOAeMD8x9vEUfKms2ankcBCothleR1uYTB89J7w2LHWyVKQnogkFPJRg2v5iRDbETSaJ4GGsKxAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783030; c=relaxed/simple;
	bh=Dt5KswCCqFPRf4u4rnxljQ70zWX66Ck+w414xBA7gCk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd121WKEBic1X20wv/LGmFtU1K5jUI0DNJorsaiOfRfK3uK2Ktil+zaADTkRsVQ7Fqqtm7xM8xNQpBtuVVvXafIfuQ5BBv7N7cmH2CAD5plWpuDXgMOESc7UZa4F6o9zLCr4X1Afw/NDj2b86uvsR80Lbxv+zZpKD7KbZoTbAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft5uzJdn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so3438565e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758783027; x=1759387827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4A7uHFyGsqg+/5gcAVyLzJeZKPdXHFpebcPVRaYpAr0=;
        b=Ft5uzJdnIKRgS7AoCC/3Qf+9chNRN/xp2PBYMwZfrTVExAA0GeFO8bKG+FpNxQl4aF
         iFcBgwCiEfHe2m3Zgn43RTS/meY1z+YXLUQQ6tz9VHfZnHQZBk1ngsv8Hr+TjUsFAADn
         nMX3a7d3ssN2I1sZ8/c2LPpnnwpvlptKWt18PL+6nUG5htGDh/29cLF12WNO9rf9PAAI
         uaHzSArBNZvU51kOiJVrIBKdBh/yTTqlPihE32LNuqGoc0x2MHv1TT7XgUE/XMqBYhnx
         ieWTY5g8wwOn4es1XagDFbZnmdFVBH//Err4SKrcRXFZkyLY8XkX+foUK5TjsUX/Mq/M
         eeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783027; x=1759387827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A7uHFyGsqg+/5gcAVyLzJeZKPdXHFpebcPVRaYpAr0=;
        b=dNM7xJ75/5Li7EGTKNOSb2X++dfjygxl5N4LWJigZ2Apu5MA2SgqptM8GjQdLGH2xD
         R4AJ13lHFsr1QhYRjj6C6cmkL0O7hz6NAmhdCCMoHezLSubZv+3vCbKaBnD6cTTCX3yu
         xSCDG2u+XG4luFQUCn29uDrw2uSZGlCCaU5zKSKhFlWvTjuAmkJzsQwEHTggLljWwq6Z
         +0YAeuPkFEoIDGHjJL6Hhs7nBE3Ci1Nd+ibguCqNigLS8jdRZRLPIT3/wXJploDg+9tR
         80c4ID5BEMjh/+2lCD5a05b0o3fTlnN5uzwStxx6tvBWSNXfdrHoAjk7yyOAIFj2QzKr
         7BVg==
X-Forwarded-Encrypted: i=1; AJvYcCUxyII7PQs9kKlx+ia0ImB5mdiamJobyz6WzIHOwLOn+qtqPGDxwavmKr5/AfCnbIynYuaQfJy57a140C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdclUGC0/DDMZ2YNfoair7OwLZdL3g7T9tw+s5qAjQfpz6ty8r
	wKSa013EN6XGWOvXVUDMnnRQ5fdwn7ind11Q8ffY2ufK9vrnYs4m0BI7
X-Gm-Gg: ASbGnctse/uEbpPq2t1Dkm5ke5SosX1G8sxRiD3WdjsGPNjlw+pVlCUoYM7EVO4I6NI
	6VuSrgYlqsm04urHA9U9F2ZDZ9H/703tfl16nxAgAg/lpHkHzExAqjaMN8OLuca64R5gF8YolAW
	buttz9GCEI3ydm7m4eA7Ver3dIa7wRjq8ZNvYKZUT4XBJ5w7lpgFO23TWle4eQ6VZHZggUHa5Mm
	XqMp/ipe3ZGeu6+iG5Uql/kpdVxS/mJrsk3EW8Tt4ncwj2kL3XM9kO5cMY7M8mdVQL2RNx5xnKb
	6usMbzBFgwtRFbW+e1qqhnWMfQVUwexhz6/U4BpV+ATeA7lINcOOuzYumUwSVFUMq3YqPi3g
X-Google-Smtp-Source: AGHT+IFDrBvdqgW3dfAsa53PUDyLwpuKBZY/PKiwkfqmYxUGGh4GPPrCN0aoqOBwEKILDjVmZ7uA8g==
X-Received: by 2002:a05:600c:35ca:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-46e329ab712mr24367705e9.11.1758783026884;
        Wed, 24 Sep 2025 23:50:26 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf6ecbsm20412955e9.22.2025.09.24.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:50:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Sep 2025 08:50:24 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	catalin.marinas@arm.com, will@kernel.org, revest@chromium.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, andrii@kernel.org,
	ast@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix the bug where bpf_get_stackid returns
 -EFAULT on the ARM64
Message-ID: <aNTmMGC3iYoAlfUU@krava>
References: <20250925020822.119302-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925020822.119302-1-yangfeng59949@163.com>

On Thu, Sep 25, 2025 at 10:08:22AM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
> that contains the bpf_get_stackid function, the BPF program fails
> to obtain the stack trace and returns -EFAULT.
> 
> This is because ftrace_partial_regs omits the configuration of the pstate register,
> leaving pstate at the default value of 0. When get_perf_callchain executes,
> it uses user_mode(regs) to determine whether it is in kernel mode.
> This leads to a misjudgment that the code is in user mode,
> so perf_callchain_kernel is not executed and the function returns directly.
> As a result, trace->nr becomes 0, and finally -EFAULT is returned.
> 
> Therefore, the assignment of the pstate register is added here.
> 
> Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
> Closes: https://lore.kernel.org/bpf/20250919071902.554223-1-yangfeng59949@163.com/
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  arch/arm64/include/asm/ftrace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index bfe3ce9df197..ba7cf7fec5e9 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -153,6 +153,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	regs->pc = afregs->pc;
>  	regs->regs[29] = afregs->fp;
>  	regs->regs[30] = afregs->lr;
> +	regs->pstate = PSR_MODE_EL1h;
>  	return regs;
>  }
>  
> -- 
> 2.25.1
> 

