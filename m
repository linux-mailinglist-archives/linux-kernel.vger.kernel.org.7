Return-Path: <linux-kernel+bounces-775322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF2B2BDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561D7560202
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4F31CA72;
	Tue, 19 Aug 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L2jVmJXG"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FB31AF2C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596908; cv=none; b=tR9qdqjkj1tL5uNNNAtMxA07Qg6u0T0g+jAMOUqYcZwUpbSHSp7SB4p6iDCa8DZSOfjJ+CUFbtTlbLgISuXfoVOpNoIFnd78sRhRO8h2t2m/R6A9jPL/9D2C/ax8cYOtOrdsAzXRbctj6gqjCi+MNYAB5N7o9xrTEJfeA086Nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596908; c=relaxed/simple;
	bh=RdOqegLbDZpP8lvNxVd40m6XQzsVJhmZz5WOZcYizz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKQN/SoLDAVicFKlqMBz6FyHkT1iXH18rgzGHKM7NBuldLAESm51cM1UZPCSBYboftY1E4Tan1H+4v0o1uzxpqH+g/0dYTbegW2KxEhXKoLM3lQ777yEvu/lwdZOgazfApIpCPIOSX0NcYuXPoLVvi2Nn9U5/q+tZ9+JrwwQo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L2jVmJXG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a2befdso685521166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755596905; x=1756201705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zoIFVT3XG9EXVc90RjV4+ABRyGCSo3nnw9SVU84KLAk=;
        b=L2jVmJXGc11jEfhoafqnW/vT1UqMzsQJu79fOgGT6uixfHHBa6hEU4BkB3B7IQrLIb
         jwkQEfiCo1RaE4IkCbMRDXHSHEU6qiZF/0kbUcxBc25NPERpPYjzkQQxEqVyZHCPPzlP
         B3cLS1UIfMe2nVCWUtdcwQNQdcXvbBrTyrLElK+2sFNnFZzI13uUid4SRZ+P6aJk4lwf
         3NkjG/bibFInr0m/IrTQCPlMFYH9RwtTAmrwcYkgodAkiWEQBorROITCJwTV7Irim8am
         X4ssUIfkgV/T9xrTYMad+36k4Dz9hYj3bfhqnGWnfWtHWI2eKaXJKOBh9zHpn9MxHUt5
         wCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596905; x=1756201705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoIFVT3XG9EXVc90RjV4+ABRyGCSo3nnw9SVU84KLAk=;
        b=LUBolwAaQ01DmWFa+NRd36ADnk/6MUccXwE0GnqyvqRUf16UfVOb9/BRMXmIQ6uikX
         xe93oMAXricvaX/JbhkZMD/SRekLTonkNXr/tWfj4dFLqk62MiHVGv5PKWvG9w/UhuFA
         miSqDjQ6+1ou3uaPcdcruiss+epmwAz46jLGMXj11QrvL64MMPpRXcicdoUdL7QQzR38
         nDNZOOyzcrTzFE/jhes6v1KCm+KL2J3bV/wQgnXLeL6827ZQmYF16zID+QOEPT0dPMgp
         b2dO7c2u+21hlc/OEj7oTdJywrKizu7b+rMm7a4tS+xSXPXDlLOgE/OVMJjH/M4MwKZR
         im7A==
X-Forwarded-Encrypted: i=1; AJvYcCWPy3V/K5hSmSQP0QOJube8D33AexDQkK6bqI26QoLr5MGEaAjzqoXnMugu1k2pifurxse0lUNdeIhxyQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzhOo/JQBUEITr5sSA/in/gUNl/L9KG89XYouKslRH6hPvlSa
	R5eGyOkQm7SKvs8pekOumzi01T7cIIQNbu6cfBD0Vewz7UhTqb4V9ZXw3OF+L6/NSHA4Ya9I3II
	vIQ9X
X-Gm-Gg: ASbGncsMdn6SonQwaIAVa6hhKCZ6RkSC+OGnFVHmKEiIYAQWr3hnCOPQqOwQCd4J/9m
	Yvhp+xMw+j+yYe4pHpoG8pPR7aLcu6gAX7w/y3QSfkR3457IjjMMIfaDq0v933l3N/3Icr22U5v
	1lFpZNgTPRrk3YIzqHW7kspK/iPedKjpdouWTvH1OCOteSMG2uQBAARrhgNQa6dhdm9mVuFDdyA
	eARxMeLpEuZfxduEXzxLolW6eqZy1W8jb4chNeaUFDTx/qyr/+t5tJReutyxUXb1zuVq9I7L1DG
	LjvWUznW2JeF43Ihb8q+3gIJJo1mZxY9C4Fa9zhbDPA39dyo+dUBswbo9WJt1RoHVAhvz3pFfx3
	/uIxXQv1bnyvw3OO6jh/DWACEDoDCoKAqPb3X
X-Google-Smtp-Source: AGHT+IFAziZgVbWWfT9kpwZ8tJo0++TUXJRjoSuWHmBQGz3fy7OpCFEJ2+Ii2Ap5080srLoK1Jt0yA==
X-Received: by 2002:a17:907:da7:b0:afa:1bf0:97fa with SMTP id a640c23a62f3a-afddccdcaedmr174904766b.25.1755596904676;
        Tue, 19 Aug 2025 02:48:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccd5asm981820466b.78.2025.08.19.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:48:24 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:48:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH 3/3] panic: add note that 'panic_print' parameter is
 deprecated
Message-ID: <aKRIZnm8EBaPjl8G@pathway.suse.cz>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-4-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071428.98041-4-feng.tang@linux.alibaba.com>

On Fri 2025-08-15 15:14:28, Feng Tang wrote:
> Just like for 'panic_print's systcl interface, add similar note for
> setup of kernel cmdline parameter and parameter under /sys/module/kernel/.
> 
> Also add __core_param_cb() macro, which enables to add special get/set
> operation for a kernel parameter.



> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -937,12 +937,29 @@ EXPORT_SYMBOL(__stack_chk_fail);
>  #endif
>  
>  core_param(panic, panic_timeout, int, 0644);
> -core_param(panic_print, panic_print, ulong, 0644);
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
>  core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
>  core_param(panic_console_replay, panic_console_replay, bool, 0644);
>  
> +static int panic_print_set(const char *val, const struct kernel_param *kp)
> +{
> +	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	return  param_set_ulong(val, kp);
> +}
> +
> +static int panic_print_get(char *val, const struct kernel_param *kp)
> +{
> +	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	return  param_get_ulong(val, kp);
> +}

It should be enough to print the message only once and avoid
duplication in the sources.

Also I would make the message more direct, something like:

	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");

I am going to send a followup patch. Feel free to keep this one as is:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

