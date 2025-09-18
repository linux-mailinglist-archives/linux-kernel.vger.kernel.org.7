Return-Path: <linux-kernel+bounces-823281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FEB86086
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C129E3A7FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86E311C01;
	Thu, 18 Sep 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RBuaf0Lx"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C67312814
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212853; cv=none; b=MlkcyAfCe6mBVl06F9VGCPzRE3iZVVLvSe9MgjgB4uuoZz39x4ZnGoTHDADkcx43QfId9IU49OGSlSnXUW4kUWJVb4ryPyvWkg1nzlJ3RjiU7ySqU/Ucw2Y7p2ku4EzNOMO51i41T4HapnjURNaBQ46djONAkjGjKQzLI5HtogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212853; c=relaxed/simple;
	bh=tEk9HWFdRPv8tRvCLX/9u7LW7w3eToXs8nV+KE61HiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cks7kKN1OfR+xM4I6Cc/BK4ySEC7w79d3pU9PqA6ObWRAUnic4QwN/8q3unmS3EboCvDMZzBG88zL4gNZRFdiR6lf+WAul3dgjcmvCyL9i//Hxm55jL8YpdgMHjfcLt/VSCmuO4L+wibYfgbY7oB2d6Gq3+SdfohlNQTyWTRrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RBuaf0Lx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so21525566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758212849; x=1758817649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2SvNk7ykfGNqisG18LLbQw/fgulldYTfC+cfPexRQY=;
        b=RBuaf0LxiL10bmj8Fy8fyBj6wsLqKMfw2f5f12qzKnHP9tjoVmK6IIKKS8Mqi3KqCq
         62NiQtN5H/4jzYKqa9p+gHpHFMDwKjTpZEoJw0Ivr1osR7L9giMi5wA5pku7Afzo8fqj
         cTbIIjUt3ijZCDT11+gkj1vZsXF7nt3K9ghooV02kx2H9RNKDyKSZmC/pKnL4NPUcC0j
         2aUR0jZ8oJDfALP21biOA6/AlOdGbth+W2ASSkb8kS1H1dNr+MYWqdCFA4AJPotyCWwg
         RGYefoODnFW3+P/OFtF9QT7Szv+n9tf3JZnGmtSgmK2BenK/XF/gVvCYUzbHMwrmjHf0
         bAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212849; x=1758817649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2SvNk7ykfGNqisG18LLbQw/fgulldYTfC+cfPexRQY=;
        b=tEo9pGTgV5cVi2MRbvfOLx4zAt+pf/Ic6p0xXG1DtYALm8TwFThq3ilPrCZ7nHBtkF
         J0QnlpMiJH0fewIuh5G4+giYZgsamlAdRy6yvBhJtUwVTsW2b6H8fWViNDtBUfup23hu
         LK082hN1eeWvZnVC4XW5gXA7xNFYylvNrH6srMrxOKTV7msS60xY9s4fmPq0HXHhKhrT
         AgH3HHeCNRX3HVAQIChVCR/e6TdexCuI/sx0i6Nbpwc48Z9ey652UzC6Hc+Yzho+97yS
         Grs+AM7AyCUMTjDYdcSTluuLPtJDoHHGg6kLDxpY0QnpqP8yVacMyi+PFJebNgscIwSg
         FTdA==
X-Forwarded-Encrypted: i=1; AJvYcCV9HwkjmdeNQAlyzGeVuQAkhIwYEn7duxjaGuRTr4XQ7mDlxz8SEdHrxwGrWv+dcqPjsu0wewZyiaohu4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuVQmnUwxrVzlLAa3j6bIs5W43NzNu2WS3FbIPeWitHRQMHxC
	dtQW5liX1SRxeUkQ7Wg7Sue831g9dGjRZ3JfRzbqg9AgtHavEMVUT5FGzN48+JYdrA0=
X-Gm-Gg: ASbGncsmaZDp5T0FEkXu0BEXkAcXyjR4AIQwchUxdxmPLGOdSFK6Z5ZwKm9/tkFyd0I
	KzcDj8TJEsJaEQxjcrwRYFpWrDXiv68rqglC96P9DbHL0T/fcgL4RxJUU/w1VrqyUWkHNqWwMCL
	f0z2wYFzFDdLvFE7wgfUCwXs6x4XNImC7TQUAjZVq6Odrhwoouk+1mNtpcxir9RwezcEPfzek/m
	i4jLQQ0ojjSLXJIPCZZdvQwykQ/jjiR23PQVlkkR4AwWHuvRFmHQki5Doy7Id7uLanPW9Pkt0aR
	3nJ3woX8usme0oGDDH6BxfN7quIRRiWIBOjXYFa0rsFBRS+hudmxckoy5GmA7d50M+Xc7IGfd0/
	bi9tY5iG+waZ3oJ87/tdAIPpUAdmVdYgzXHSEnO/lPa7I
X-Google-Smtp-Source: AGHT+IHMcabZ1KgOh/a+DRvZH5G35k5AtS5XymOGDIWB6MFqNfVHHPpfpbRpb+Am7MLr7slKu+qyJw==
X-Received: by 2002:a17:907:1c29:b0:b07:e3a8:5194 with SMTP id a640c23a62f3a-b1bb0d3a868mr699385466b.22.1758212848904;
        Thu, 18 Sep 2025 09:27:28 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43884sm230540266b.3.2025.09.18.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:27:28 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:27:26 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
Message-ID: <aMwy7pFM7EExLxaX@pathway.suse.cz>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>

On Mon 2025-09-15 13:43:06, Andrew Murray wrote:
> The legacy printer kthread uses console_lock and
> __console_flush_and_unlock to flush records to the console. This
> approach results in the console_lock being held for the entire
> duration of a flush. This can result in large waiting times for
> those waiting for console_lock especially where there is a large
> volume of records or where the console is slow (e.g. serial). This
> contention is observed during boot, as the call to filp_open in
> console_on_rootfs will delay progression to userspace until any
> in-flight flush is completed.

It would be great to add here the boot logs from the cover letter
so that the real life numbers are stored in the git log.

> Let's instead use __console_flush_unlocked which releases and
> reacquires console_lock between records.

It seems that the patch does the right thing.
I would just suggest some refactoring, see below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3301,6 +3301,46 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  	return any_usable;
>  }
>  
> +/*
> + * Print out all remaining records to all consoles.
> + *
> + * @next_seq is set to the sequence number after the last available record.
> + * The value is valid only when this function returns true. It means that all
> + * usable consoles are completely flushed.
> + *
> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
> + *
> + * Returns true when there was at least one usable console and all messages
> + * were flushed to all usable consoles. A returned false informs the caller
> + * that everything was not flushed (either there were no usable consoles or
> + * another context has taken over printing or it is a panic situation and this
> + * is not the panic CPU). Regardless the reason, the caller should assume it
> + * is not useful to immediately try again.
> + */
> +static bool console_flush_all_unlocked(u64 *next_seq, bool *handover)
> +{
> +	bool any_usable;
> +	bool any_progress;
> +
> +	*next_seq = 0;
> +	*handover = false;
> +
> +	do {
> +		console_lock();
> +		any_progress = console_flush_one_record(true, next_seq, handover, &any_usable);
> +
> +		if (*handover)
> +			return false;
> +
> +		__console_unlock();
> +
> +	} while (any_progress);
> +
> +	return any_usable;
> +}

This is yet another console_flush() API with a complicated semantic.
(return value, parameters). It is not bad. But it would be nice
if we did not need it ;-)

>  static void __console_flush_and_unlock(void)
>  {
>  	bool do_cond_resched;
> @@ -3346,6 +3386,17 @@ static void __console_flush_and_unlock(void)
>  	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
>  }
>  
> +static void __console_flush_unlocked(void)
> +{
> +	bool handover;
> +	bool flushed;
> +	u64 next_seq;
> +
> +	do {
> +		flushed = console_flush_all_unlocked(&next_seq, &handover);
> +	} while (flushed && !handover && prb_read_valid(prb, next_seq, NULL));
> +}

The semantic of this function is not much clear from the name.
IMHO, it would be a puzzle for people who would try to understand
the code in the future.

> +
>  /**
>   * console_unlock - unblock the legacy console subsystem from printing
>   *
> @@ -3676,8 +3727,7 @@ static int legacy_kthread_func(void *unused)
>  		if (kthread_should_stop())
>  			break;
>  
> -		console_lock();
> -		__console_flush_and_unlock();
> +		__console_flush_unlocked();

IMHO, it would be pretty hard to understand what it does by trying to
understand all the layers of the code.

It might be better to open code it. And I would take inspiration
in the nbcon_kthread_func().

I played with the code and came up with:

static int legacy_kthread_func(void *unused)
{
	bool any_progress;

wait_for_event:
	wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());

	do {
		bool any_usable;
		bool handover;
		u64 next_seq;

		if (kthread_should_stop())
			return 0;

		console_lock();
		any_progress = console_flush_one_record(true, &next_seq, &handover, &any_usable);
		if (!handover)
			__console_unlock();

		/*
		 * There is no need to check whether there is any usable
		 * console in this context or whether there are pending
		 * messages. It is checked by legacy_kthread_should_wakeup()
		 * anyway. And console_lock() will never succeed again if
		 * there was panic in progress.
		 */
	} while (any_progress);

	goto wait_for_event;
}

What do you think, please?

Best Regards,
Petr

