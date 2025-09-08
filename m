Return-Path: <linux-kernel+bounces-806163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A8B492AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778033A9CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08530DD1D;
	Mon,  8 Sep 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QVmPAP4C"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EC30BB86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344475; cv=none; b=BdoN17od3or98BXZoLMT52mJZAaY7VKhhVHLwgBIYDeft7F5MCXAJ2BNEm4M17GgKGpGIWaKTasrEuKG6Fgv5V4Y7RuKQMDiU5jYsYoeZuDj4Gr0jueyR+Cf+h6qAUAC6D3Z16897knSq36PieNtqQTAks0LWFBkow4wLOxTCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344475; c=relaxed/simple;
	bh=VUdjE81W1g8LLR/aTKtukzd5/F8QOLvPReGyK7FlKSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeTVKszoWDEHY4Nv9upB9kvaW0492LyFrP/7hl3nOr1m5T/pgwbQfOoQd3bPeJBXCA8CCdYlccHfZBCdS9CPuveLVCzx4La91+r+j7QdgczjFSGX/D26FXwpzHcqdcR9v/+4wlvgj6a+g+y1lP3sy3LiD6Ty2lzDbVxN4XMDt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QVmPAP4C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b042cc3954fso775512966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757344470; x=1757949270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRCW4NqpepDigQEXQoO+OG2/MkkrwFo1ppttPylNoUI=;
        b=QVmPAP4Cn/KcJshgagDuN/knbg9bdhA4BoIOQn5x2cOAfggsTZQyai3swdqRMd2A1I
         Fom/i8Xg2p5/3msTrK4XGqZ7njk7UNaDfz7ENCeFQu8Jxy8d7UX0NsBIjjkB+RFKT81O
         KlTDIdSmlW7jTksCZzDOx1jlZ8B1E37LOYY17w1vzu9+59T85e74BKy+XmyuxtqETgbY
         VmL/VTr635/cahqNDe4KTvt0PSvq27JrJ/Ae7q54R+9wOhZbZnQspwa3UkiezILmH/es
         ubIr71nZAuUqw65zHhHHxwgX/J7Kd3M9YNltN53tVm50yvFjM7s3iFgimyml/ERaoSN5
         Hu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344470; x=1757949270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRCW4NqpepDigQEXQoO+OG2/MkkrwFo1ppttPylNoUI=;
        b=p5m5YcF+pHYIs0rdsrR9xaCbE/ageX63+odc2b2IbT+zJjINBpjul433sfNJmwz0HH
         zTXAe1XNHHyrhLY07zw8MZoW1ZHBv3RQnDALYbuAdkUigP6cKS+zVUD8IlbEvgPa1mer
         Fsw+4DE9ky8AGm7xpCtXQH3lKbuXkxwhrT9UobDpDZeRhabixIt6MmPXliOPedCYagQn
         9SpPMxbyqfZwzLs1uSnDMTHxfXTU1NvmWDNFG0eDg+7YWLsx23CInXdpve6CD3qgp3/J
         9pMc4rJdmAf25tTjlN5gstwO9gced2GH9VlgPUifyufGK9LzQXSQVv94fxdad88KSmyU
         R4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHur7asxX39voBEZYF4L+ZVhHV9Dxx2uQIm8Ti7I/LlNzOqGVuMzOyFXy0YC6QU0sfXJRMfHvKP0F/kiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynpJpdVyZPquQUPXp6cf5BnZA5546VlicdoXXAKv6sekxRYjNM
	ixjCyLLGUGuEVEkcMI7mRjbUjhKMisYjouYypkYO67SRtaR73cd+9Y1mTC+iXHgnDsA=
X-Gm-Gg: ASbGncti8MMHof5DW8wU/GkGkY3QIsGHRmBLllU6q6kOxw9LjFg1V8ihH6Yfj1f688g
	+EzeI7O/jy5NqLdCgKXIK2bER9QNu5Diw57phfpe1xuSZBu2lhBTCCdZMKB+Up9i5TRsnfHdGEy
	MMUIiYD8qwLIMoKxd7O1HYA7pEfkTcrAXVJQwIDYwdQoQmQI3lLdFu5wPVsEE4Fj/sWV6rRCQq2
	kKmHOfEKMj3bkQiEVgirLpSwcQNFVUJR5fhCJcdVh4WlzYs4UreEPOoklGGVDFAlCXYO4yCrv3+
	C77N2SvImXmagzqOIBpcsP6CSl+NIDI6aRyAehHMdwk7HP+csX+wI0rWDbhvwYpvgAu4sdNxJpY
	jWJFuPXP5ehe2kE5C/5lcDYFpIA==
X-Google-Smtp-Source: AGHT+IGVY1NjNi8h7a6B1deCGJ6XFfknVkp7JGXqbMs851BsmoIGKYTWDbfGdfHefIqZacmhh6EzZQ==
X-Received: by 2002:a17:906:4fd2:b0:b04:2727:1658 with SMTP id a640c23a62f3a-b04b1766368mr852685966b.58.1757344470380;
        Mon, 08 Sep 2025 08:14:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0471c7a163sm1239937566b.47.2025.09.08.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:14:30 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:14:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <aL7y1AvuAAsOSJ4q@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>

On Tue 2025-09-02 15:33:54, Marcos Paulo de Souza wrote:
> KDB can interrupt any console to execute the "mirrored printing" at any
> time, so add an exception to nbcon_context_try_acquire_direct to allow
> to get the context if the current CPU is the same as kdb_printf_cpu.
> 
> This change will be necessary for the next patch, which fixes
> kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
> such consoles. But to print it first needs to acquire the ownership of
> the console, so nbcon_context_try_acquire_direct is fixed here.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * Panic does not imply that the console is owned. However,
>  		 * since all non-panic CPUs are stopped during panic(), it
>  		 * is safer to have them avoid gaining console ownership.
> +		 * The only exception is if kdb is active, which may print
> +		 * from multiple CPUs during a panic.

Strictly speaking this is not the only exception. The reacquire is
another one. I would put this into a separate paragraph and write:

		 * One exception is when kdb is active, which may print
		 * from multiple CPUs during a panic.

>  		 * If this acquire is a reacquire (and an unsafe takeover

And here start the paragrah with

		 * Second exception is a reacquire (and an usafe ...

>  		 * has not previously occurred) then it is allowed to attempt

Best Regards,
Petr

