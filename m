Return-Path: <linux-kernel+bounces-893241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A010C46E25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5ED54EB006
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529463126BE;
	Mon, 10 Nov 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5qqUFsl"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E03115BD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781218; cv=none; b=F9+rar2tc1CHQX5XvdNPA+MgAkJVW80RQxk6K8diMqiYo1N75FEfhKLr13XaG4/6rPp84AcK9ES3lBA5PudW7vPQfnogvY9+kLxls/B1kehQrxatewwEOuYagsn/bq+mVNSkZf0SvZwsCkurhnv2VAKJ4iXxBv7EasEaP2uNFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781218; c=relaxed/simple;
	bh=7zBlKI19nm4l57l+GSpU34xDjL4DbJLxfBwZWCrg3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu07nGpzMrPbrVpM0IrD14+vgG2OUfjlpoVu70OYtklo5/bOTDb6dKz9cagI2Ij6DELnnNxjmtKTiXcPoSuBN80jlzmDqkRyt2rNEmrqH4qhsqkEVFCVm8PTqDNTYJoUBEwMsLjKfTHctnVvT9bhniT/OA6mV6tnBXnisnLqGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5qqUFsl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so4329388a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762781215; x=1763386015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=E5qqUFslVJXWPHhafsxsLihzT2Hp1H7ZL3bmTpHc1vF2FQcxh/aQ06ldMfj/Vuroos
         6hElXI3/nIMU2tmAI7rb47W4ouuJ2zEDvb8xbb8ffZIju8HaIU51HE4S6tnw71CNQ3Bf
         SgKBbPLG2cJ7UoeLIsWfFCk78xyOgWyvCGN2fFCZjODv9YM0tjvAzWt8o0pPmpRbmKjq
         5gvS9Pg1mDvRrHYdnSJIGr093yv9UAsFVNVIGZbrH8Ga2I9QDAIM+z0ttJolmmxcgcpQ
         aZjjcynCrC/094+Dg13xfDzZR5iiIEW/g6WMD43PJ1HEEajIHDCWJfXyimpxSn2TnjQ4
         JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781215; x=1763386015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=av0n4A6cbpj1lstM6m+XAN8etVyakLgS0VWVpw4qytOFA1NhhFdSn7wxpG8NjIJjq3
         nrU0yRdsSB3by7iADgPeYXd8MKFkTq8aW1GykG/keNJgBSpqUwDOArvieovqXdsiHgbH
         Z3v0/wKWmPqndG8YP9eMjoaBa9VhQlA0u9I3poJif/l0Fay9SQAWbgP2WjFhvAKUkbxg
         WK99rqXAOKRBsxB8fK8qRDqKke9+npCy5QKRtcmYk1gtbuz686oAU5e/GuLpTGmRLP7O
         +1Tfab9e1psEfQbn3nUXiYh/sVYsYtgYJyKJ7WcV+B1OarSfCuzpcSb1tGuEPbZAH7an
         TInQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQaTJREmzArykzOtiuVHhxzLgDK/pHSJ25tKYdImkfofCbQcbF0myvz7d4yooVmBuTXi8D38QQSUGGYN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvoQT4pqag+6kOFJ7vSNuu10NS4CDhKFyP4kjVJxYjWu2DqoT
	Z2dmER4Zw2KD/RvHNLcnEzEdAcKpOPWWa/dWc6WjtxpZTJ2FT7YorgOgpnz8gEuqd0CfS78s9D5
	3UbRe
X-Gm-Gg: ASbGnctWls2EPdy6pvkzAunGozlPN9Jtad1FZo3W0ZECJF1BPReaI5hr5vbMYmj3y98
	8oq9BjD1lPghzdfIph7KKXQZpjxM8a784vHJFxJLLOaIE5Vge/KJilGxwBVLVGj3xh7ZjvWqMUN
	4QX0Qqo+bYxgzNHPA2P7QSXlYMunoQi8giD3I+rfK3Z0eTLHghx6XM++x7RHeEkUWMDwYc/lTC+
	+zMTeRc2YM2YMI/ddAowjSskS/I4zQUqcBubEdPXmKBIyRgcb+rwLdi5G3lnkO3q2emu77+Sy+S
	JiRFhejaItnHtYrUx8jiymEDG03bnqlynzJM7Wb0nKAoNVDj+ayqIVBlJ2EM0ramYP88c1WX9Cr
	xhr7r731cjRQNWMnjYctkgaI65eO+gvbhn07N6dT8MP0os8Wyv/r6jlEqLbUo9rotoVwpG/mRDJ
	jssaC+KPn0wORtSg==
X-Google-Smtp-Source: AGHT+IEFvin7sLruegH2ZxQ0SW44BHRX6xFr54ZAVGaHqC0y7M8M930cBHeCWlcadsxgJM1CQZ9cXw==
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id a640c23a62f3a-b72e0310d6fmr928514366b.17.1762781214802;
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1129492566b.45.2025.11.10.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Date: Mon, 10 Nov 2025 14:26:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kallsyms: Prevent module removal when printing
 module name and buildid
Message-ID: <aRHoHMJYAhSoEh1e@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
 <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>

On Fri 2025-11-07 19:36:35, Aaron Tomlin wrote:
> On Wed, Nov 05, 2025 at 03:23:18PM +0100, Petr Mladek wrote:
> > kallsyms_lookup_buildid() copies the symbol name into the given buffer
> > so that it can be safely read anytime later. But it just copies pointers
> > to mod->name and mod->build_id which might get reused after the related
> > struct module gets removed.
> > 
> > The lifetime of struct module is synchronized using RCU. Take the rcu
> > read lock for the entire __sprint_symbol().
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/kallsyms.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index ff7017337535..1fda06b6638c 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
> >  	unsigned long offset, size;
> >  	int len;
> >  
> > +	/* Prevent module removal until modname and modbuildid are printed */
> > +	guard(rcu)();
> > +
> >  	address += symbol_offset;
> >  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
> >  				       buffer);
> > -- 
> > 2.51.1
> > 
> > 
> 
> Hi Petr,
> 
> If I am not mistaken, this is handled safely within the context of
> module_address_lookup() since f01369239293e ("module: Use RCU in
> find_kallsyms_symbol()."), no?

The above mention commit fixed an API which is looking only for
the symbol name. It seems to be used, for example, in kprobe
or ftrace code.

This patch is fixing another API which is used in vsprintf() for
printing backtraces. It looks for more information: symbol name,
module name, and buildid. It needs its own RCU read protection.

Best Regards,
Petr

