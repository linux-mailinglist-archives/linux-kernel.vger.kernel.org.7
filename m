Return-Path: <linux-kernel+bounces-810566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A8B51C74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FA4161CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9832A3EB;
	Wed, 10 Sep 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y1GBgcaB"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5261A2C0B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519523; cv=none; b=DZcVudiT4so88yEM0QJWqcAVvFU3M4U4NMU2PjWUKLAe+6lzxeKP84b9IkcOrQdH8uqHPKzBmHIuMJPgUnM+067dSuXaVDeLpiyAw1v+QBB0N3oYziOQHJIolSe9ZPf5ZNPunwFpDXn/dYbLqsirs8EhfnPW7FgZu9mkAmWbK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519523; c=relaxed/simple;
	bh=mvncor3HI+W9A/gmILLwXoL0QG8/oktXJxYei8rUIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUlanEVpfY19P5vpWwZ82IXbIl3VSx4H1NJq/c4papUL6EUpRT16iSdDfVRnBG8WJ8VLRhNLE44rNgSHZ4i7KlF0Yz5hQvO9GEJvC47EqSL90O7rellkddHkLLUYDq+i8ywY0DTBir35ec+oqFz7Z4x1cH3ktzYzg6xQN2K2ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y1GBgcaB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b046f6fb230so165203966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757519519; x=1758124319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXqCK+svVlBuAMsr5p4huDSfMQXIvsA6yKXWJhLo+iU=;
        b=Y1GBgcaBhHBdzdjHWdJctGakxSRj+kMJI1Ps1TNkTxlqvMP0fXGLokw5tygfBg2zTx
         tmhelTbKHBV7xR/aECg9Bzy8FsW/PZIxKg363P0UANJBeNjHwpAF70ncVUWP94HmExuX
         XvAPy1lprQBoVhkroDfV982PSsEGbwXmGx3A9/2KP7nDVsDuf2jtJuHgQTMBcwWGuwtJ
         bRk6bSrBGrGET4dD/uiU9x8AiQRajepM2eGBPSelrE8okrBu6Y6n8GU9I0/jNQ6J21Rb
         q13LX7H92PCwTGLYlNB9Psn3ihJkMO0X4AW9yzZGc9e1/2zDeSoQQHU2WLpEZiYpt43i
         Qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519519; x=1758124319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXqCK+svVlBuAMsr5p4huDSfMQXIvsA6yKXWJhLo+iU=;
        b=OgqvqcvjKB/k1vvFKuhNwPL7O2vpWmTWeCwPNPvSsD+LdarX+Cw426K8gkSDmNQjCe
         /JZnS2vlQQkb+ONSN26Z0GaNZzgsqZgBMYFXtsT+601bha1xyeQRKOECUVKwrJBOIcVn
         QLdG7I02TsfasZBydojB5vV7tUjsUHb+CUw9+HbILLXwmHNQ59mPG6SkJsFf+3bMppWB
         6aGoRX+nv8FRFrRKnTZmLyUGLxpIuR7iAjreuuS/j4GPKlsz1ITR1oOIJRia9D7SoPuh
         0R3Xm341FdA4fZVTjLsjVKE0O1r2CfunMcRGWqIey4yjnX+x88AknHQwwygsjJs+OQMC
         zOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHbuaYrcKRRYFyurv8N4hmoMVU25d6wYf7AohKI5kci51cgRdb1cYJQoTDXJmDs9gi++U7jcvWiFyPbd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb61dOIH3dxhziH8dWOZBeZvsovl0wsXxWVmjde/FISzqQDkn+
	wZ3OYsyr83HKCN7a3YTSw0dKQMLztlm24yTaJttFi8wwFZRNe09cU0BGGRNYU75usEU=
X-Gm-Gg: ASbGncvwOkpsx8/QAk7yzbljgr9IBrSqtH/+qmLaPzAwJct8dAbQ5UaKBoBoC+Ctvu3
	9f20ODBtNHL1HXN1L6WX7bhBaFWdxG5N1Ok+LOEuIMnUyhQxLlosqCmvKVBxZtUHj/BSU7e6CKX
	Ib8G4cN5n6IrQ2tnYWRMCed+bp8B6R1GKaqn4EgG9u8j/b01m6GLF4vnKmrTjvrCEL7yQF7Kfe+
	KlosNYHJNMjm+m1SHr3IB6b3JQZ49rTGJZR2+hc9By0601LX5cAU6dwSth+0zLhCO6JxiWc9/bt
	Kvj2kAj/iGE3puUN5HkCbxIQ4lt7C3ho9IW690lheigfsnAIYbD5lHvw8fkOcz2p+3FkseoBRhM
	5CLljs3DOA41/xAUFpjjhzgGHFVIgVUQJ1u3C
X-Google-Smtp-Source: AGHT+IFE9TusuMunCFfr6wNayngNXse/YHX3kwzAYccUed2qnbY4WVC4DPlKEEAXxnWfgkh/JZJ6bw==
X-Received: by 2002:a17:907:7faa:b0:b04:5d56:d838 with SMTP id a640c23a62f3a-b07a648315amr9092266b.20.1757519518832;
        Wed, 10 Sep 2025 08:51:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f6a7esm3543294a12.42.2025.09.10.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:51:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:51:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	Simon Horman <horms@kernel.org>, kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aMGenGUNcBbRUUf9@pathway.suse.cz>
References: <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <aL88Gb6R5M3zhMTb@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL88Gb6R5M3zhMTb@mozart.vkv.me>

On Mon 2025-09-08 13:27:05, Calvin Owens wrote:
> On Friday 09/05 at 14:54 +0206, John Ogness wrote:
> > <snip>
> >
> > NBCON is meant to deprecate @oops_in_progress. However, it is true that
> > consoles not implementing ->write_atomic() will never print panic
> > output.
> 
> Below is a silly little testcase that makes it more convenient to test
> if crashes are getting out in a few canned cases, in case anyone else
> finds it useful.
> 
> Testing this on 6.17-rc5 on a Pi 4b, I don't get any netconsole output
> at all for any crash case over wifi, so that already doesn't work. All
> the cases currently work over ethernet.

I like this test module. IMHO, it would make sense to get it upstream.
What do you think?

Some comments below.

> ----8<----
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH] Quick and dirty testcase for netconsole (and other consoles)
> 
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/tty/Kconfig     |   9 ++
>  drivers/tty/Makefile    |   1 +
>  drivers/tty/crashtest.c | 178 ++++++++++++++++++++++++++++++++++++++++

I would put it into lib/test_crash.c. It is similar to
the existing lib/test_lockup.c

> --- /dev/null
> +++ b/drivers/tty/crashtest.c
> @@ -0,0 +1,178 @@
[...]
> +
> +static ssize_t __crash(void)
> +{
> +	pr_emerg("BANG!\n");
> +	*(volatile unsigned char *)NULL = '!';
> +	return -ENOSYS;

I would use similar trick as SysRq-c and call panic() directly,
see sysrq_handle_crash(). Something like:

static void __crash(const char *context)
{
	panic(Triggered crash in context: %s\n");
}

> +}
> +
> +static void __crash_irq_work(struct irq_work *work)
> +{
> +	__crash();

and call it like:

	__crash("irq");

> +}
> +
> +static int __init setup_crashtest(void)
> +{
> +	INIT_WORK(&bh_crash_work, __crash_bh_work);
> +	init_irq_work(&irq_crash_work, __crash_irq_work);
> +	crashtest_dentry = debugfs_create_file("crashtest", 0600, NULL, NULL,
> +					       &crashtest_fops);

Match it with the module name: test_crash.

Maybe, do "sed -e s/crashtest/test_crash/g".

> +	if (IS_ERR(crashtest_dentry))
> +		return PTR_ERR(crashtest_dentry);
> +
> +	return 0;
> +}

Best Regards,
Petr

