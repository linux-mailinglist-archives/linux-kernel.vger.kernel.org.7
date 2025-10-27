Return-Path: <linux-kernel+bounces-871817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48EC0E636
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0EFA34E8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD33093D8;
	Mon, 27 Oct 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8i7j3f7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570C3093CD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575065; cv=none; b=Gw0uIV0e3S3KW0tDwcGyqwcs7fMuJ0e2kYQpyexVKUF6EJSXo41Ka9pGNgAzfxzkMJMmjFO6ngtujXcqdExB6Xg+OoC4yAc4xI1/YEkqtoENZZ6f0kz9t2wluDcP8lRDugD3eHnTD3Dxr84ivyFuvVzhWP8d/T5anCoJBR4gVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575065; c=relaxed/simple;
	bh=yDonmrETatQNT7/grehW8rXtNarrRogC5sOjMf1WNvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbHlddTJ3RQ0P7PTZCBdMcKjaB3RZ1Lgs7kgVYf7yWijjKNw+0c3O5ePe4EmRnTOdh22BeedIU+vo6mRBfHsJKCksYaRCsFFwmElFv7WlcxBpMS5ScgXa433IidqZhYlTrPlSUPyG9pGIW4tFHFAVQAuO1PpoPlg8h1t5pX176s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8i7j3f7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so35447015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575062; x=1762179862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bY4Yol7rQsRXFZXloUVp/P/3SRjn01ieeD7U5hV1ms=;
        b=M8i7j3f7kKb11xVhHWW1j+GdUMknwQaqfWcGTP+nGT6MdSLdRnlg3t5vaIQHubWQSj
         /o3E8Eu65p+SGb7bQtLv6PNiNEeWn9TtKB82UA7A8vm09+PxJjfPHb+PD3N9TFVzoIeF
         5XHT8RqVSgKlm4q0aIhK01O21TtLq56/O2q6zxl5gHwRNOZpsdSXrMhxDKuvqYv3V6lW
         KwdN0XbAyM0s8j3OFkows2V4QvZ9Qe114bmwBonmC3+Fd3uEJrthGfNl0ZIUdHs4gbxo
         sZikjiz2wCAB+HSGlZWLeGb+cKL71QKikV2QaC7l10tzlvCJurKS+0msZ+FaMHNXM0gH
         2ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575062; x=1762179862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bY4Yol7rQsRXFZXloUVp/P/3SRjn01ieeD7U5hV1ms=;
        b=tw+kH4iY02Lb6+VXi8IsN+EPzULnnY69zReW8S0zDMvumD1oNkBssyWPKKkIB9/0j2
         /NRbEnSQi9cQBFs7gZqAYwPlRrjQWrK2Mw4GeAvlrqg94v64L3oOLP2BjqBWKkOyxaQh
         9VOHm5tS192lvSb8zJ+RTBzFvmTck/a7cor+rj3gtFQoVtfBhgOt0rUCdlqQXa+a3Q+S
         7D54XImVk7FJ87dLYJ9ng0v8pAUH9kfVy3k32TJda1acX5mRUlGSzKMZEOK+rbMEX2WB
         ekaa5ZtdxFfXjM/eDQh33EG6/8vpIuprBRNnwO2vHsGWhfCqyKx9mjMonIaZ7dgFjUvC
         ymYw==
X-Forwarded-Encrypted: i=1; AJvYcCWwxX8le1sZ343whAsY/uA7F5ABX0AumKVa2JXwBHFv6gbS8S4WeDLqdbbOR4nHZIPxgy1g7X0VTKYIAjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxReU1WotPctCJ3rRMMdHToyvlpoe8aZHoKs/uubEFafIgcnWLh
	5tfh3slMB374G1Tmwi0vHj824yGtZ7ZJKmCxPibWPCI5YcGJj3sBXEQj
X-Gm-Gg: ASbGncuOWiZwySILbJUF0DwrFCpOvVkNskxA3zSjQhHpcVEAgTxiJPYNS89DsG76q0J
	5Olx1nu2lOBrN3vq5KQyTjk8rYMs/J4fHDy9R80iXXE2WgXJXi9pTLzfBWyd2MPkPymrCuIJMb3
	lHVjqNK7nVYJX/q0Yvjje7eMKBgdQ6cxtaIU+L+qYeJszdHOb203WFiGwB/nSlzAKWZWzJsWl3G
	dsBa3ruDtuz13r4g8tSx9rs4cGCzd7HQLZpEQlzrNKOBIfZtTPfAdwtUKodyA4iPXjPCrTZNDzk
	ErH6oy702dlGxVjUgAXvl1AzAJBhb1OhX3W+aLAWJUS1TYpwLuMzEhZIh2UcXcsLQ/41WiNmE5w
	753GmoLZQWZi5j0PuBZo6bHCTeT8YxC7hrMymh+XJ7vuF0MAX4AV2K5C0jwbddg+gm5b8quHJsT
	GYjTrl6LGEfNEz2FP9fR+0wqvM47K/E4PVpXFcAEcEsphkZjUGC+Kd
X-Google-Smtp-Source: AGHT+IHrQNGu7yfsQ6sGUFFRF4TbgkbvCaZvwqyTNRWQgfAH9k7vZW+CwaqCmCCB1PJO0sECC2w9nw==
X-Received: by 2002:a05:600d:834a:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-475dac36adamr48977805e9.27.1761575061808;
        Mon, 27 Oct 2025 07:24:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm14676087f8f.47.2025.10.27.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:24:21 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:24:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 55/56] x86/debug: Show return thunk in debugfs
Message-ID: <20251027142419.1f04c7c4@pumpkin>
In-Reply-To: <9ff5551d-79e8-4358-bbdb-cbc7e5c7c36d@suse.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
	<20251013143444.3999-56-david.kaplan@amd.com>
	<9ff5551d-79e8-4358-bbdb-cbc7e5c7c36d@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 14:29:59 +0200
Nikolay Borisov <nik.borisov@suse.com> wrote:

> On 10/13/25 17:34, David Kaplan wrote:
> > Make the value of x86_return_thunk visible in debugfs to support user-space
> > testing.
> > 
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>  
> 
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> > ---
> >   arch/x86/kernel/cpu/bugs.c | 44 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 26ceb42e0cfb..8365448b3aef 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/sched/smt.h>
> >   #include <linux/pgtable.h>
> >   #include <linux/bpf.h>
> > +#include <linux/debugfs.h>
> >   
> >   #include <asm/spec-ctrl.h>
> >   #include <asm/cmdline.h>
> > @@ -4065,6 +4066,49 @@ void arch_cpu_reset_mitigations(void)
> >   	tsa_reset_mitigation();
> >   	vmscape_reset_mitigation();
> >   }
> > +
> > +static int rethunk_debug_show(struct seq_file *m, void *p)
> > +{
> > +	if (x86_return_thunk == __x86_return_thunk)
> > +		seq_puts(m, "__x86_return_thunk\n");
> > +	else if (x86_return_thunk == retbleed_return_thunk)
> > +		seq_puts(m, "retbleed_return_thunk\n");
> > +	else if (x86_return_thunk == call_depth_return_thunk)
> > +		seq_puts(m, "call_depth_return_thunk\n");
> > +	else if (x86_return_thunk == its_return_thunk)
> > +		seq_puts(m, "its_return_thunk\n");
> > +	else if (x86_return_thunk == srso_alias_return_thunk)
> > +		seq_puts(m, "srso_alias_return_thunk\n");
> > +	else if (x86_return_thunk == srso_return_thunk)
> > +		seq_puts(m, "srso_return_thunk\n");
> > +	else
> > +		seq_puts(m, "unknown\n");  
> 
> nit: This might be better suited for a switch construct but it's fine 
> either way.

That won't work - they are not integers.
eg:
#ifdef CONFIG_MITIGATION_UNRET_ENTRY
extern void retbleed_return_thunk(void);
#else
static inline void retbleed_return_thunk(void) {}
#endif

I'm not even sure you want to be testing anything against a static inline.

As coded the compiler might generate all 7 copies of seq_puts().
So better to use temporary for the result.

	David

> 
> <snip>
> 
> 


