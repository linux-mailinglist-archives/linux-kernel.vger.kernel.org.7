Return-Path: <linux-kernel+bounces-895701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C5C4EB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32EC188C92C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5E35B13E;
	Tue, 11 Nov 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GLEvraPl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261ED357702
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873443; cv=none; b=RJw6pV+1o939zvSCR/vgbY0kcWUSyqKqj8vNBXEAcTzO8Xrhg8iG8tIJW83oYogB7oHt1nvDEGUp5eVBZS+wwrAx1hrTPBeyrUfssF16yohdnsQPaYSN5bZgCmNhat0vp8GsdjHdSeW1U3TF5QE+qVgamCj63/SYBpEvZl5bn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873443; c=relaxed/simple;
	bh=ftiPYvx9c/Uo7f5Ce7Yzxcg1QUwJlxqYP2TiKTcKQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/DxFMrkq6LlorZjTL4Fhx1hq+h/TnAcAwmjmh6V97SWGEZR1YiQvung2lC+1VjTfRX17sbQIPfTjiMl5v+aAlau5cyXKUIGPMdi95vsxawd4ydrEcpvqq97dih42Qny9gNC9+9iTW4vz6I4T0YYK6KU8JzlWDvDAjiUCqeN+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GLEvraPl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7291af7190so611438666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762873439; x=1763478239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wi+5dbYm5JIgaP/t7Nx547fFCD450JcmYNBqfgVm42E=;
        b=GLEvraPl7E1jUbk6wW0/aujwLM40avwzld7SwXplnkC23MIZZugLXkJV/P/Zuy0s6P
         biwgt8KXmcwkpr/MRUcOWv6ZfmXMOMWJVaSeDZ9vHm46iKDZ+oGcL0se1vfUH7Op4pUs
         5Vd4PFwIKZI4mZzszYDRTGEK+phtKBSwXAq1BHSWrzwmd7Js5XRPRAe7a8nN/Ojvc46T
         cfUUdsjSUk9Esk/VP5eyrG6XVWOkwmBqxuWu4/MSPASED/Y6j2znswy7LNUS6lkvdTX2
         jVz7XQLzgif/7PSXT9EYDQHoCRqG68y3jCzRrHAQmyAkGgDY6JekuENeGUGz+KZKHQ7A
         hh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873439; x=1763478239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi+5dbYm5JIgaP/t7Nx547fFCD450JcmYNBqfgVm42E=;
        b=lZ08pSdKLRfkNDPIV+Tb3q+i+wyRjK67T9Jpl5hoFUCFvjXYgA9EOvfNmkNP0Pl1MF
         D6+cEYGuuAZwJ130REe5STag1eyPcyLKRMgWQrPWT+BTo/2FajgL3BtpMbrRvx7u0xEx
         WMEvrlhdeapuRjyoEqw2Fu2y+wej/ldYJjS3TW+KJ6eqWWe+7b7QYyCeih8EchHbtkpF
         tKZawu3xlDLtai0WKJNM+uplu3brudsBtHiLgNkS4DD8SeSwvE5VOEAwguhofXsDicPe
         O7rBTeDapHjJfDYmbQoY+pLsQvTN+rqs9Siv/ku55AsvGJlsFdqMdqZjEusWSgMRjQSs
         buJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFmkQ6FTCn82dZ93aK77lAWDK6eX/+VPsiwitd2kb6H0F8MvMJGj7Yc8r8+XeBXd5aF85t6nGUed9eNbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAYXe0+odYWqZE9ELlgs/i9sKewTa4/qyoXH53Qc2QZeJDNnU
	gX+9A9XzN8p1dmQ4vSZbnlkLjxiO7lmgNVTsJa3yedgKva6fh47hWs94dtp8mZOPh40=
X-Gm-Gg: ASbGncu5P63VRhknLlJWjtz0aJ5x8Cboc4tZZqs3LHF6CDUbBuuMUqmc7srISr/vDSW
	fncLndq0h46OO2+Lo1eP9V4QycCEywqHRr34ZMY0SKz60NarmWKMZseb+WdQRiT/qkki+2xdpT7
	dI6Z/WDlE/FhP6rt4btml2zwyZuiIy8G0GgxKA11S57E9yQDqnKPdJj4udfQJscw3ZWIPw+oDzm
	xargThFPJSgTRc9Q2RFs/5I1yrlJWlvUGSVqJ44+nPXctrLWT5yNT6+18Fb4TaoVZVvPp6ztUCZ
	uLTh0Mx+vb+lnXYMPXiE//2hON7+/JWb0jMMWS4b8QfPLkeptPK/AqbGdRXE0ROHgR15AFhwnXI
	x9QDvjzj1DLfA5CoSiF6abdZjknBTtCd2+lRbFCE7VJKNcDxxJhRTK+ETngiPZXe0hhMK8PWem3
	TpVShrD/YAG59LmiGpmg==
X-Google-Smtp-Source: AGHT+IGWUxoIalLG5xLZllX+zCkekRXIo7e3xykwl2APS2wZQPGHNLqastwX+dw6XlJnfwm9Fe+bGg==
X-Received: by 2002:a17:906:f590:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b72e04e4ebemr1306841566b.57.1762873437355;
        Tue, 11 Nov 2025 07:03:57 -0800 (PST)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc9656sm1374243166b.7.2025.11.11.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:03:56 -0800 (PST)
Date: Tue, 11 Nov 2025 16:03:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Add specifier for printing struct
 timespec64
Message-ID: <aRNQWc8O2y94zoj8@pathway>
References: <20251111122735.880607-1-andriy.shevchenko@linux.intel.com>
 <20251111122735.880607-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111122735.880607-2-andriy.shevchenko@linux.intel.com>

On Tue 2025-11-11 13:20:01, Andy Shevchenko wrote:
> A handful drivers want to print a content of the struct timespec64
> in a format of %lld:%09ld. In order to make their lives easier, add
> the respecting specifier directly to the printf() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/core-api/printk-formats.rst | 11 ++++++++--
>  lib/tests/printf_kunit.c                  |  4 ++++
>  lib/vsprintf.c                            | 25 +++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 7f2f11b48286..c0b1b6089307 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -547,11 +547,13 @@ Time and date
>  	%pt[RT]s		YYYY-mm-dd HH:MM:SS
>  	%pt[RT]d		YYYY-mm-dd
>  	%pt[RT]t		HH:MM:SS
> -	%pt[RT][dt][r][s]
> +	%ptSp			<seconds>.<nanoseconds>

I know that that there was no good choice. But I am curious.
Does the 'p' stands for some particular word, for example, "plain" ?

I do not want to start bike shedding but I think about
using 'n' as "number".

> +	%pt[RST][dt][r][s]
>  
>  For printing date and time as represented by::
>  
> -	R  struct rtc_time structure
> +	R  content of struct rtc_time
> +	S  content of struct timespec64
>  	T  time64_t type
>  
>  in human readable format.
> @@ -563,6 +565,11 @@ The %pt[RT]s (space) will override ISO 8601 separator by using ' ' (space)
>  instead of 'T' (Capital T) between date and time. It won't have any effect
>  when date or time is omitted.
>  
> +The %ptSp is equivalent to %lld.%09ld for the content of the struct timespec64.
> +When the other specifiers are given, it becomes the respective equivalent of
> +%ptT[dt][r][s].%09ld. In other words, the seconds are being printed in
> +the human readable format followed by a dot and nanoseconds.
> +
>  Passed by reference.
>  
>  struct clk
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3f99834fd788..fdd06e8957a3 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2464,6 +2488,7 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
>   * - 'g' For block_device name (gendisk + partition number)
>   * - 't[RT][dt][r][s]' For time and date as represented by:

We should add 'S' here as well:

   * - 't[RST][dt][r][s]' For time and date as represented by:

That said, I am not sure about the optional '[p]'. We could
either do:

   * - 't[RST][p][dt][r][s]' For time and date as represented by:

or

   * - 'tSp'	For time represented by struct timespec64 printed
		as seconds.nanoseconds
   * - 't[RST][dt][r][s]' For time and date as represented by:

>   *      R    struct rtc_time
> + *      S    struct timespec64
>   *      T    time64_t
>   * - 'C' For a clock, it prints the name (Common Clock Framework) or address
>   *       (legacy clock framework) of the clock

Otherwise, it looks good.

Best Regards,
Petr

