Return-Path: <linux-kernel+bounces-866284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A8BFF628
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5C358004
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092912C159C;
	Thu, 23 Oct 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CF6kF8Ja"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774362C08BA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201919; cv=none; b=TWXxAn4gp+TUOuD9QDJgMNey3+a8YlPPZ8fYZMl3r/9JNNthZxJXznWijJkDs4hg5b4vb0pXxhVsozC68Ler6Msu3UVBT07ZLcai4vkw2Xk/vEmES2dCk4Bpl0ebkS3dgYYjzYHCd3rmKuyYPszIzKRE51hzwwUOeT2RJJ7sTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201919; c=relaxed/simple;
	bh=Q6syN2U/kg7SVNb9/+fI88jAEOI93lk0180pEu3AQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7LXi/hu9qH7nliT2fL4bA0UVTh6uG4hypWo6JiuLOoWsURaKh/ygfOsaWBLDus+LqIRCrJDyAIg+LqkfR0GYJtw+WIsHEvlE/pfFiqi0dpPSzN74LYusI7BIb9v8jJZXO2j0zhmwzARRoT4IiCmE8fNEgb32pxPSfi3dTLZZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CF6kF8Ja; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42702037a01so65033f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761201914; x=1761806714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNPJYP6r90cMIhHtjFw9cecGFJVdIxbD+0uriFYd5bk=;
        b=CF6kF8JaYxT4KKeM6U76mJmwMlPYpox8e2pYMd0e+Iw3lNgfmmQWvdndNuaZvAjV/0
         /KWDCp2WLpcljBvY7In1a3g/fbNzILlcpHaLoSohcWm2hQaZohrKl7F9SQBntlTZwVQP
         NDwXK9nt/UNpSWAfSczBx8pNSEfbBedkQpEUy9mSEr1und4ZaDkC/yYm+LP/sLkZ6bU4
         xdtSr2d1nUdFu9rDgkWWuVrCO/EUbjr+98sRdSlJOD0g+GV+PR1iecUkKSskZ5Q310Hl
         blH+FRay4SBwphB2sG+zjv6Av1rmMcCWTmVfBQlQz4BhmNJzRb5wX2NJumDiTLWhfuTD
         1+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761201914; x=1761806714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNPJYP6r90cMIhHtjFw9cecGFJVdIxbD+0uriFYd5bk=;
        b=NvL8TtLZReyyFY0UyFp2XGxQbXJ78zuTaEcx+dy7MUDff+lstewpJ6VeFA+nyVrlo+
         FOr6qTj5oDrvV0i3Mkf1wjZ17JyCfHWdWmUmzH7LppnGRIR8gL1YVwNp6zmaPDW7Ih9E
         hUYrB3WR6VagAqz5nV0OqXKC9c3UF3ONhLty8mQUJhOX2xWuoEkrg4cE5qowstiqiidc
         x2RkGaD7Sa+t1t1FAgdLiwXklDvG0s1M+WnGY+1txAEOsFQFCLRdmxTqyg6Tbj6eyPkE
         ZoPDsiyyYs3UVJgxVsy4904tGgfXtOkXuBWBWIW0LfvKS5yO9nH2JPbSvwtKzl87H2pY
         o74g==
X-Forwarded-Encrypted: i=1; AJvYcCVZqZ7r7wSRQehmTTErikRpnSnJkJ9W2kpvgXspLbIXcHw+S9USEuoX+ekjsanmmBkNdB8P0LPIQx7841w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCF7iKHCbtZm+19a4nH+iQ1RuJDKQQUPKTOsZuNbKSWSA1WKY+
	dlG8G/kdmq5aQBPB/hsLjSwyjJDFJU9T3b8cPTPbzEMA8DMzkD7gpL7VqtpPV+ZmymU=
X-Gm-Gg: ASbGnctccSrhGjrxkks/CDi0pmGlqOhmHfiNapAz9WSFAlVFcC24m3QmaPBAel5ytaY
	wRO3aifo99eEIjxzQrOmWT7A+hBOXVVgLYf6ckxa21SvCPRVpdj86p5cgUtULMECkX/uDbEbH2y
	XBfYxAWZe/4DlE/sr4d/ow50I5HFLo5FdfuKfUBPIfjyCGIpxldyFS4BEsApT6TZRk3Rn1hLcC+
	XbeBJ/9DJLQSzRT2pUJgmdILPtZjHBF2cIGDIYS1QesDyyLFXcX3yub1t/btuPQd+KbE5N/+37S
	H1xdspdQZa/jYLMnlkqOOFAtvwWdZDDGJW7in0h6QQzQ4b6Io4T73UgkVnLXFj/1RsLsPa50J38
	jGEpej/IPTtW007j0q6MMrPETFqG1le592WURxdpIQ2gaI2Tssb/H4Zv4Upb4QnS04V9AVBUWRX
	StoZsyXzg+TrTDMdcDOud5s+/yNaf5oCqFSk/ObnUaiO8cEw6r/99bjlXvUmvNksjZkg==
X-Google-Smtp-Source: AGHT+IEEbSWHJ68olFyNXTL6G/WJieyPscvfbJ7jtJUURO3283Lli9NeVR1f5nczETHjqFcVCHg9sg==
X-Received: by 2002:a05:6000:26cd:b0:427:25:3c31 with SMTP id ffacd0b85a97d-4284e528b25mr4403538f8f.1.1761201914397;
        Wed, 22 Oct 2025 23:45:14 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e77dasm2337018f8f.2.2025.10.22.23.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:45:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:45:10 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Nikolay Borisov
 <nik.borisov@suse.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/tsx: Get the tsx= command line parameter
 with early_param()
Message-ID: <20251023084510.4b1cd2fe@mordecai>
In-Reply-To: <20251022174603.mx7sze3w5e24obps@desk>
References: <cover.1761127696.git.ptesarik@suse.com>
	<befa0b859777267a11c90aebde6a3bedce276b90.1761127696.git.ptesarik@suse.com>
	<20251022174603.mx7sze3w5e24obps@desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 10:46:03 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Wed, Oct 22, 2025 at 12:26:13PM +0200, Petr Tesarik wrote:
> > Use early_param() to get the value of the tsx= command line parameter. It
> > is an early parameter, because it must be parsed before tsx_init(), which
> > is called long before kernel_init(), where normal parameters are parsed.
> > 
> > Although cmdline_find_option() from tsx_init() works fine, the option is
> > later reported as unknown and passed to user space. The latter is not a
> > real issue, but the former is confusing and makes people wonder if the tsx=
> > parameter had any effect and double-check for typos unnecessarily.
> > 
> > The behavior changes slightly if "tsx" is given without any argument (which
> > is invalid syntax). Prior to this patch, the kernel logged an error message
> > and disabled TSX. With this patch, the kernel still issues a warning
> > (Malformed early option 'tsx'), but TSX state is unchanged. The new
> > behavior is consistent with other parameters, e.g. "tsx_async_abort".
> > 
> > Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  arch/x86/kernel/cpu/tsx.c | 52 ++++++++++++++++++++-------------------
> >  1 file changed, 27 insertions(+), 25 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> > index 8be08ece2214..74ba4abac7e9 100644
> > --- a/arch/x86/kernel/cpu/tsx.c
> > +++ b/arch/x86/kernel/cpu/tsx.c
> > @@ -20,13 +20,17 @@
> >  #define pr_fmt(fmt) "tsx: " fmt
> >  
> >  enum tsx_ctrl_states {
> > +	TSX_CTRL_AUTO,
> >  	TSX_CTRL_ENABLE,
> >  	TSX_CTRL_DISABLE,
> >  	TSX_CTRL_RTM_ALWAYS_ABORT,
> >  	TSX_CTRL_NOT_SUPPORTED,
> >  };
> >  
> > -static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
> > +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
> > +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF) ? TSX_CTRL_DISABLE :  
>                                                  ^
> 						 The extra space I had in
> 						 the version I sent was
> 						 intentional.
> 
> > +	TSX_CTRL_ENABLE;  
> 
> Also this can stay on the same line.
> 
> 	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO    :
> 	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;
> 
> IMO, this is so much more easier to read.

Matter of taste if you ask me. I have no preference either way, so if
you do have an opinion, let's write it your way.

Do I have to resubmit, or can an x86 maintainer adjust it when applying
the patch?

Petr T

