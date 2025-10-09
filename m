Return-Path: <linux-kernel+bounces-847198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D9BCA39F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5157C3C2931
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E232236EB;
	Thu,  9 Oct 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gxy8k/6i"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFA155C88
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028386; cv=none; b=RQgN2gtPBf5iOieq1gopnsHcW+F2pthazvLjyr6ejWXPVBWcMwx2HiqY84/BsdeaJOOLMGm4cD1fJ0qwRk/fNFxYDE9RgNGe7C5Dy6Z9/TBmUEHcrtqKoJAjisSYkuaScmwI0TF9y7OEEcVjGutkzG2+KjdwS1RCLrz4IOdzdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028386; c=relaxed/simple;
	bh=uKkoVdHHQpINnOOc7yMyxMdnFxyYgw6tts6v+l9uMss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhUJvl6WwoTJxrbzPyRtEtuQgJ97fdHwQyR/nCWF2jPfJqLkK7nHD3cfFTFUUeJ+uk0tiLyDycrtH1IgV5LVmhafKvUnYdby7VZDw8Xdf1fpJsqTYxw2FyIuGVYa+NlQVd6X8AjdogT5tr2s//kfMymVWj/lszvA6ExZW4FajYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gxy8k/6i; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-91179e3fe34so67458739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760028383; x=1760633183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l69sAA+RqcMkjrNYYlZnvTMiAxsxuDk6BohwO3k0jM4=;
        b=gxy8k/6iWbaPBMaHcPa6UBOZfPQZMJvh/8QzxvONUjVvaAbPF3qMZ+gZ59XeymltuN
         Ft+vsm/hd6x/LYrjz99UnNAFNcFnkfZbub9wJ+f0/Ozh9IgHWOMmmb39RjmFFcN0CacI
         qfAWvA5zcyCNy4Ce9fQ7/xo5NE9lMl9uium8PPZNlW6wDX4J9wrfwZxJtQ4SqjkOwjTZ
         4RabWJxQ9A2smqPGhX+0StTD7h8KPQKMsYp8x7NRiDCXtnjQ5wTBcsP6nRLZs+eWD2sV
         aeh1O84ypCXty9yPQfJxf66OvPe2oxowpOWWVH3gfsCUCIR0MYlFRnmmWrovIx4JXwFU
         6o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028383; x=1760633183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l69sAA+RqcMkjrNYYlZnvTMiAxsxuDk6BohwO3k0jM4=;
        b=uRuuYKsLeKcBoncZpxLiHOvNaap0OPxrdMuC3QSKNfLVrslZxoPzQzzt0LVin1QwwR
         pC16PUWfMi28c5P56Yad7PEDAsEi4c20J/jpnT4d4z2O4IdRsJbmiM0pFWRS31ZG/xCk
         q48JCB4bIqvfvgJRLUGYT6I/Lx3v+uLKbTyzwxysHt+GpnY3u19uA6YbQChXM+F+ppOK
         UcFXxTWGJYm8yi0IpdBkSVryJPnB0T4L8epRTWrnFrcBOgNlm9/QhHsA5YppU9upd2TF
         FwXkZXfWv0LfeMRbmZh/2E+qRP5rcj1syJvmh+8IL98HG5BP1Pnmr60PVSFyHndu1Ywq
         tFxA==
X-Forwarded-Encrypted: i=1; AJvYcCUel/JbEBsfTHeDKGU1fKrKMrEaP4kIIvMe0jaSs1OHi1QZxtxVntmTw0RnTd8/daOSMo5QTsx7PFvfn7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDHEUu3Bs373EWaXS3vWphVLB7khX1UUNgEz9F3Gn6qwBpA9E
	ZZiPpK+5NX3se5vFqY7Megzhl4Ug+axBm5vcpHkeGmJAIEuKeertfFb+GkSGi2dT3FwmcZMw9YK
	ln5WB6dk=
X-Gm-Gg: ASbGncsxRIeICaxa6/OXooIrJ2Gknnu4VvfXFWxQKzQTOQBWgxjJzbaWQ1uvdEq/Vbb
	2l9neoaVMUScUH0+0dHfaBB5FCXts43XKXyJt/CnNGuXwDFCGLv7Lm6AuxwMcy5Z6OwQbSwkh31
	Orwd1K2Y5s+vbhAFL3olZIAV3UPhxrfe1BQflq2KbR/rsZsa1l83ce6ys5Fs3xTOP9YCCIVwlDO
	2e9kM2jL6t/il2oCzNECnrl32WBShEQqUBoXjz5gktf/0qBHqUQ79+irfvdIFS/6csnKIhJ26JY
	EUCz7NvHBVH/xVI/2x1SfgsGmDp9d1qQq4rr1LVeerO8zjjmLAOZenxMelqJiyEkFB3WqMcUuVa
	ji/SmtYSxnorfvAI5hTNFCZCWx+guNkCSPw7lKtjdwEuSoQh7mCbI9YyrYUY=
X-Google-Smtp-Source: AGHT+IHb56VLYwDyYpisbd61rv4b/ynpgAfxpu83YRCwm5JW7AaildP7fCF4cs3XdphAf5nkTFwpyQ==
X-Received: by 2002:a6b:e916:0:b0:8c3:e106:74c2 with SMTP id ca18e2360f4ac-93bc4119105mr1227233739f.5.1760028383330;
        Thu, 09 Oct 2025 09:46:23 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e2594a558sm8145139f.7.2025.10.09.09.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:46:22 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:46:21 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>, 
	Cyan Yang <cyan.yang@sifive.com>, Jesse Taube <jesse@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Nam Cao <namcao@linutronix.de>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] docs: riscv: Document hwprobe for Zicbop
Message-ID: <20251009-27aafc23cb2a92c1c9b324b2@orel>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
 <20251009134318.23040-4-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134318.23040-4-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 09, 2025 at 09:41:53PM +0800, Yao Zihong wrote:
> Update hwprobe.rst to include documentation of the new
> :c:macro:`RISCV_HWPROBE_EXT_ZICBOP` and
> :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`, following the same
> style as the Zicbom and Zicboz entries.
> 
> The extension bit records support for the Zicbop extension, and
> the block size key reports the block size in bytes.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  Documentation/arch/riscv/hwprobe.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 2f449c9b15bd..3b9c9d7e1409 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -275,6 +275,9 @@ The following keys are defined:
>         ratified in commit 49f49c842ff9 ("Update to Rafified state") of
>         riscv-zabha.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOP`: The Zicbop extension is supported, as
> +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
>       :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
>       mistakenly classified as a bitmask rather than a value.
> @@ -369,4 +372,7 @@ The following keys are defined:
>  
>      * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
>          vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
> -	Instruction Extensions Specification.
> \ No newline at end of file
> +	Instruction Extensions Specification.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`: An unsigned int which
> +  represents the size of the Zicbop block in bytes.
> \ No newline at end of file

Please ensure this file has a newline so the last line doesn't have
to change every time we add new keys.

Thanks,
drew

