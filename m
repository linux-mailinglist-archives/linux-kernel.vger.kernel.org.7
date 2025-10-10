Return-Path: <linux-kernel+bounces-847888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A802CBCBF56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 498B94F983F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1D274FF9;
	Fri, 10 Oct 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JR5shWlv"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCE273D8D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082037; cv=none; b=j084xFhpwrq/hL+VaQkUTBDS4sdnBMPYU8R5TRbgDUx92kZaTvic8wHvEfd86aeoLibftqlpuwqBMCdDF5fEzL4EnWLUdZLSEZNaDZNX1+RDANjnMvPITIsXN8ILA5Bo6Wi7gF7A9jeJX5EskqB/Jif+9Fi+9ZwMbhGJIG+A6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082037; c=relaxed/simple;
	bh=PPcJCSKMPFXEeL2o4ap2Vo74xeKb6zlrzKO+B3ProxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giLOeqI1oUNIxAxZGL9k6l6URaetQ0Gg6wKsohuP5JVQsJoiNMyvGO6rD7joUVYmRYnUgMNiGWIS/TIOXLlHYJe9a5Lq8q7wrCHJif7kaAtO8Aomhi0/d49lq6AH/+dkLwjfNohJmSfvKOL1oLBC4EG0k39NoJ/6ELSuCgTNW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JR5shWlv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5a6e114dso23550766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760082034; x=1760686834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPWGr7mjVtDKRHxuAAyeQAtdvhyq7/Khh/BgxfxKBLU=;
        b=JR5shWlvsFPndjzyC2WzApa69BRod0VGMva3VzBQJ5dPkUZoTInguuVjuP9pCpBM8J
         OIx0gHLzoaiL/iADHq8dI2iTVqYxJM7hwn+08UWRHKAWIsHjKSKlsttBrK9Y8EJmC9nZ
         TpP0dGjGIdytM6rUeApNq7ywxMbot2SxxfV2HeS4s4jrdtirP5i5oHfFGGgcktxbHpDW
         DF0b9ZgwbyrlcxUklTMMxTMnKdMdEzHikIGBgrOGrsaTwaHTOzH0S/GsMefam3S+iJAi
         86s+tfc0127Dsbk4TGd+JscySZgvABZsHH2uXFVOG8f+CRNCzOtG1ZhEma6HNrvSmWZK
         c7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760082034; x=1760686834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPWGr7mjVtDKRHxuAAyeQAtdvhyq7/Khh/BgxfxKBLU=;
        b=U59odOdL8mtQ3GNCFqhmSpwl6kiU5iqLCA8Ber6cbb4666eD+/X/MZAGonwX+fi6CR
         L5M8dcdpzFcUKEnfQMMpPs7/3KKhcvB0nzbdmK80HVt3MorQt9c8hgD6hxklmJfE6nP9
         oUsJXnpSOHeh0mBssAp9nHZug19TUi2AKubCnptKodi/FC/DCE/0oefQc80kpPqE84IW
         Qsh3WN7+PeUy4t/Bco+jqWMngCBTOZP22kN1SzE5hBXgtTRgYy0gso8a0u7pq9V97/Gf
         dJiZITxErx7rskag9aagZVfKcUleNVrPTr0ih/+ynyoJD/AH8ZnHOlcvGQTr6hts2yLV
         5Lyg==
X-Forwarded-Encrypted: i=1; AJvYcCXwsHSwFFMrb3kcsYxPxTKjYlTF4AOb1hGUJeO3t0mqk8x7Qx4L+eQ/QGrpHnqCrw3Kjrcxkwuh3Pf3srg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygeyANe/gCThe36dZj8yfXr6hOwRPHTGYT3zMiP+o0T1pjNEbS
	JcqIA4SzbEdYWLzXxqkjco/QCsNIjLi4WnZ/BE7Gmmg5RkRHBQc9fc0W3izyAh6eesg=
X-Gm-Gg: ASbGncuLPvm+wtgxUftyHnVXphmnYCodyvJGAz9ftwlWQtJBHZiqaTzDV7xi0gxdU3a
	7V7vdwK4FH+SFT654UjPXW69R1a71lHBXZoLz+2uG5I1Rj7wYnaZ6Lb2kcQYcvK6YPwElD1oF4m
	Wl+ximn37TMPpIPzq/8c3plOdW3tWpR9rMsP41Cmhf78YOGA3egR0I9HAIPaovwDTN1y4t7GEPb
	/L77CHYvoUtRZTTw9GbHWHYJIoTGCTIEkDXCMOrjaTv4sewYhyvZ1wB2LnS1kioG0t1IRJcRHCy
	m8welW0GZ58ujYpyZ1o2qcyor+8RPw+ewZQbSUt2i/OUJHKRrm4tO2xHpr/ZuR9AHC/+ZnS/jK6
	SoPabyV8tLNbXn/EYBxZxEtVF+49h+/7ukE7/ANlBjzCyLY4EgH9E+PqVY3A/Qrw6rw38KYWfHj
	aKHe0T/2Jx4jF4bvAFLBB2Klel/Xa1UgKI/QuPQkPN/HPiHPg=
X-Google-Smtp-Source: AGHT+IGrL50wIWH37dDbv7XmmGeiQz5s2tGBdUcjy8KqMAyLeCELYf7p8iYyEnUpPEkgSsZkadMBHQ==
X-Received: by 2002:a17:906:3794:b0:b55:c837:f6f8 with SMTP id a640c23a62f3a-b55c8380b9cmr104968766b.4.1760082033769;
        Fri, 10 Oct 2025 00:40:33 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d002esm164756466b.26.2025.10.10.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:40:33 -0700 (PDT)
Date: Fri, 10 Oct 2025 09:40:21 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter
 with early_param()
Message-ID: <20251010094021.4c09144c@mordecai.tesarici.cz>
In-Reply-To: <20251009185134.fb4evjrk76rwxv37@desk>
References: <cover.1758906115.git.ptesarik@suse.com>
	<63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
	<20251009185134.fb4evjrk76rwxv37@desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 11:51:34 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Fri, Sep 26, 2025 at 08:01:02PM +0200, Petr Tesarik wrote:
> > Use early_param() to get the value of the tsx= command line parameter.
> > Although cmdline_find_option() works fine, the option is later reported
> > as unknown and passed to user space. The latter is not a real issue, but
> > the former is confusing and makes people wonder if the tsx= parameter had
> > any effect and double-check for typos unnecessarily.
> > 
> > The behavior changes slightly if "tsx" is given without any argument (which
> > is invalid syntax). Prior to this patch, the kernel logged an error message
> > and disabled TSX. With this patch, the parameter is ignored. The new
> > behavior is consistent with other parameters, e.g. "tsx_async_abort".
> > 
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  arch/x86/kernel/cpu/tsx.c | 41 ++++++++++++++++++++++-----------------
> >  1 file changed, 23 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> > index 167dfd38b87a2..bb407331f64b5 100644
> > --- a/arch/x86/kernel/cpu/tsx.c
> > +++ b/arch/x86/kernel/cpu/tsx.c
> > @@ -20,14 +20,14 @@
> >  #define pr_fmt(fmt) "tsx: " fmt
> >  
> >  enum tsx_ctrl_states {
> > +	TSC_CTRL_UNSPECIFIED,  
> 
> s/TSC/TSX/

Ouch. Yes. ;-)

> >  	TSX_CTRL_ENABLE,
> >  	TSX_CTRL_DISABLE,
> >  	TSX_CTRL_RTM_ALWAYS_ABORT,
> >  	TSX_CTRL_NOT_SUPPORTED,
> >  };
> >  
> > -static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> > -	TSX_CTRL_NOT_SUPPORTED;
> > +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init;
> >  
> >  static void tsx_disable(void)
> >  {
> > @@ -164,11 +164,28 @@ static void tsx_dev_mode_disable(void)
> >  	}
> >  }
> >  
> > -void __init tsx_init(void)
> > +static int __init tsx_parse_cmdline(char *str)
> >  {
> > -	char arg[5] = {};
> > -	int ret;
> > +	if (!str)
> > +		return -EINVAL;
> > +
> > +	if (!strcmp(str, "on")) {
> > +		tsx_ctrl_state = TSX_CTRL_ENABLE;
> > +	} else if (!strcmp(str, "off")) {
> > +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> > +	} else if (!strcmp(str, "auto")) {
> > +		tsx_ctrl_state = x86_get_tsx_auto_mode();  
> 
> NACK, this introduces a subtle bug. With this change x86_get_tsx_auto_mode()
> would return TSX_CTRL_ENABLE always, irrespective of whether the CPU has
> X86_BUG_TAA or not. This is because early_param() is executed before
> cpu_set_bug_bits().

Thank you. I was afraid of some sort of init ordering issues, and I
could not test on a CPU with X86_BUG_TAA, unfortunately (because I have
none at hand).

> > +	} else {
> > +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> > +		pr_err("invalid option, defaulting to off\n");
> > +	}
> >  
> > +	return 0;
> > +}
> > +early_param("tsx", tsx_parse_cmdline);  
> 
> Rather, a patch to add a comment would be better.

Well, some explanation would also have to go into
Documentation/admin-guide/kernel-parameters.txt

I'll consider the other proposed approach.
Thank you!

Petr T

