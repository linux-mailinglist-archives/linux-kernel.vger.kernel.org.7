Return-Path: <linux-kernel+bounces-820783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C277B7F448
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF6B54335E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5E288DA;
	Wed, 17 Sep 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QQxCIRKm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735733C773
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115104; cv=none; b=S3O5ufVHgV0uJclQxiX2nUbFcMgd43TlyqEH0LilkK5J3YCLkEkZbXQCX6to+J19jjk+qiO7m6OB7JcBiiK38OuPHZvyaFTCjE7iecLx6WyMixoUkLouwK0/NV0AB62kxfAAFWrgrBi6qPtk2qTctD35UNmhTsGJxoqTPU4rwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115104; c=relaxed/simple;
	bh=//cq/p/L9Lg4Y2+h1EhITJGQ1VUCUDmSB4L8im+kDbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nly3SwdAheeUFMO7xNeeCeqk5JXrt5T0v8pESjMFkfO0c+g33ZQYC3eKhAwb2FSJYCKgLF33TanJC+ZwAtcfB3UNqmFR2Zg9131vU09as4Y49zqDj5a8NMIyG7ICkmQd1QBNT4Qh99XFoD4C9AOi5u/KOBfXx5R+XHed0BYenAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QQxCIRKm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso9707283a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758115100; x=1758719900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zloa2homgRV657c0j4xRp8GX48u4v3lknY23Klde2kM=;
        b=QQxCIRKm0jioog8uDUM7rHqFqwSaFQWnbsVeyhQURaMF1epYqlyzQ6co3Hr+RNVVk7
         443207jOiKDOLfEf08M5NnrCGrLiL/JcTI4Lgy9jC5Qy0sHTdJm8Ae0gHAMjmia7rZY9
         hFk5++MpJ270927vggHkm/9Wwh1GmDJ2UESDB37zM7xgseWFb+Zlquf1bZUI00WjYM4g
         i5qOx1W5wWM7thJl2+n71uQUWqWjRorNTHvkQBIu1NRu9kRqsuGcFmkX0RpZ599rf60U
         GytJbjjKD+xLHeBIBuhNQMlnYiefmqoNk6hyX0iN4ht9MN/exv+z4kcLCTUoQUF7WsAx
         5YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115100; x=1758719900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zloa2homgRV657c0j4xRp8GX48u4v3lknY23Klde2kM=;
        b=s0a2dxwspVGfMpU9PPmNM5MesEDJlhfmJBtCR++HPd4inS+mK8HaliMncU3/+2xMGX
         gWjWltH0+lFxsriHLS3ptLAF1kJA+eq5CeSl4bMkNMkq9XJj+mLqnOdaUIXNZat1/Ee8
         MBQAhuvoiRohkJBlbJukJWADVd6YO+vQ6P7Dkq62Rq1YoCHJypNCryc4q77zFVr8RZHN
         6Azr3rBRDvjJKzZifRCOzAWBJM1bjv/T2I9XI39LDZlSAPd01avfwBfxRWD1STB5VW8t
         1oCNcik9XFmkpXIikRPpVL5wCO/tBV28AG9EbxW7Ihweslw8X1JAEq5upV1FX5qqxlVg
         swPA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/8zyrcVrMxxXu8grXh5jezLriVdEw0w3R90yGGHJeA7SFJ0A3nxkUyfHB1CBF0Ya+JuD0Re01DDy8J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCUhP9EiLCMmk/qQS1jzXfziIJwJ0GcaAHMtfj6gKrO2Hxlp7
	mLH1v+8Z7edGUEn+87ulqP69kd8+nAUOayrlvfb82OdpUBc12emRSi5QDeZetMO4mu4=
X-Gm-Gg: ASbGncv6tfTRxx44jayDuOztyMQ3ioLX9CG+Ace2NamJ4/H+69N4Z+zKJALt6vtzhIO
	xIvZGn9hO4aFVbWFJivvTsl3KDqgQCn0uxbTdwoZkMeDYqFBvsr0mim7RVYRBpUIEMJlxRyY9e3
	04BHpG7Gjr91bNu8kq/n9l2t0pbhbiM7rzUY97NYhjjrMGbOLEZEnhkwoq2VuHYp2Iup2ocdCxX
	r3aXPJ4r2neZZ2gRGCdfSqWncuVg5HemKz5FTNXqAc86apg5eFQYVd4hmifJeTw7Cd2npYjEvhd
	Ucz+J6NdL9RYpmi9uEV50JcLVRtq3/Q+Qs6sjwVJgpOVeVs7rcJa66Jq8HFjcVgB1Zg1VBrVnIK
	XiSmBVzpVIMtVC1p2nuZhmMvwow==
X-Google-Smtp-Source: AGHT+IHF1X14bCj5/Sms8/MnGd40XMtcc6YIyaDEEhL+NqAfUXiukJj85FQd9PZ56yWVzc0VEDZBmQ==
X-Received: by 2002:a05:6402:42ce:b0:62f:345e:45df with SMTP id 4fb4d7f45d1cf-62f84213d35mr2450752a12.1.1758115099588;
        Wed, 17 Sep 2025 06:18:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f5c248742sm4269138a12.8.2025.09.17.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:18:19 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:18:17 +0200
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
Subject: Re: [PATCH v4 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aMq1GRHwo6xnsPBG@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-5-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-nbcon-kgdboc-v4-5-e2b6753bb566@suse.com>

On Mon 2025-09-15 08:20:34, Marcos Paulo de Souza wrote:
> Function kdb_msg_write was calling con->write for any found console,
> but it won't work on NBCON consoles. In this case we should acquire the
> ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> kdb messages should only be interrupted by a panic.
> 
> At this point, the console is required to use the atomic callback. The
> console is skipped if the write_atomic callback is not set or if the
> context could not be acquired. The validation of NBCON is done by the
> console_is_usable helper. The context is released right after
> write_atomic finishes.
> 
> The oops_in_progress handling is only needed in the legacy consoles,
> so it was moved around the con->write callback.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

It looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

See one note below.

> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -589,24 +589,41 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		short flags = console_srcu_read_flags(c);
> +
> +		if (!console_is_usable(c, flags, true))
>  			continue;
>  		if (c == dbg_io_ops->cons)
>  			continue;
> -		if (!c->write)
> -			continue;
> -		/*
> -		 * Set oops_in_progress to encourage the console drivers to
> -		 * disregard their internal spin locks: in the current calling
> -		 * context the risk of deadlock is a bigger problem than risks
> -		 * due to re-entering the console driver. We operate directly on
> -		 * oops_in_progress rather than using bust_spinlocks() because
> -		 * the calls bust_spinlocks() makes on exit are not appropriate
> -		 * for this calling context.
> -		 */
> -		++oops_in_progress;
> -		c->write(c, msg, msg_len);
> -		--oops_in_progress;
> +
> +		if (flags & CON_NBCON) {
> +			struct nbcon_write_context wctxt = { };
> +
> +			/*
> +			 * Do not continue if the console is NBCON and the context
> +			 * can't be acquired.
> +			 */
> +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> +				continue;
> +
> +			nbcon_write_context_set_buf(&wctxt, (char *)msg, msg_len);

I have overlooked the (char *) cast in the earlier versions of the
patchset. It would be nice to fix the nbcon API so that the parameter
could be passed as (const char *). It looks that the API using
struct nbcon_write_context never modifies the given buffer so
it would be the right thing.

But it is beyond the scope of this patchset. It would be material
for a separate code clean up ;-)

Best Regards,
Petr

