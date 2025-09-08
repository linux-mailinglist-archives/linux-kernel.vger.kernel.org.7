Return-Path: <linux-kernel+bounces-806180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBAB4930A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56216447347
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6730DD11;
	Mon,  8 Sep 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MFEWZ3nH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1F305975
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344991; cv=none; b=gEDzajum4gegkQq35lyFr8UpVtJyYsJ8WuPa6HNkhhfFjKR1AYNj1/nQxY0hl8HXzjuQc9x1AwkZpFbS23oq4ZcxxdruCPFgR+TwtI+c9CjEwZCyw2DBHJGa1nv8STPniO3EPp1nsBppaoXLtzjxPbfFBpl99gdpPZRigmM/tDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344991; c=relaxed/simple;
	bh=4hzCqvpV4SoM1sbSZdJU1KTjvAPH0UdwKPuGuR/Fti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo1pEthR4vXnn8bTL51iRMTHdH0gf+MWWpJlXVy0Xt7ClP/1XTEO21Z2hSUU39SbhJIjeOlqxP7mdUtN1G4JH5CBymws8XSvCf7Dzlno3yEG3HcGPZzXGBEGXiX6q6ukdmyGeBXnP/XU/O9Muk94uRs0MJh7lIlEIw6h1mrBjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MFEWZ3nH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b04679375f6so800797266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757344988; x=1757949788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7e3NHcRtUdMeGJ27w4CDbN47GbaVmfZ31ggRbiSxLI=;
        b=MFEWZ3nH2osFBJ9KkDpqodc4IEV+du4L0T8vXwC5PNGq39QqiFoQlFQeklk0x9h7Ng
         up2JeM1JXuGyvlIyUHlIRbHOGB8s4Fa5yWlGzmok57ViGdNitaDUyL5ut1GCDCrkOXRL
         yay5pCxO/V79RpdOsoWoBqK3EXzsA44hTlpplkeiZxYfniUd5xFgIKkubdSOVhc5x6fe
         icsz7kis8acZWTTP50wom5ev/V0VtXmPJ/gLRGPJWiBgbn6FyItkR3y5o38fd9WtRpx8
         /qIlWnHIDpGUCr0NJuVzQiBQkrJKHmPKe7j25TnV46VYmS79oanaswSVzDDh41RFk39r
         DkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344988; x=1757949788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7e3NHcRtUdMeGJ27w4CDbN47GbaVmfZ31ggRbiSxLI=;
        b=DKtpNJ4gkLQKHacLxi2Z2g5ysw/bECCBYQXMZGgS6FThGQqp30T2sju9svszUehisF
         PaDMIfs6TlShrSPo46vaSgr3whumfbBWedjM+kRY0RC2pKLfi4zBOzgto0mIKHSbsE9/
         sORPNLnmX9V3QnRuYj7j3fq+h4++iKXhTTdH4IkJ6TwC8swfM25a3xvGDy4FOANXz6nw
         3QWpEP5xOsH6Si3XllySc9o0pc1nVbm6oGOcY6VZlFW7Ad01J0ADARHVxpQF5RWT5ApD
         IojO5MczGicIJGIo5CYdORXtJGL5qIzC/tRwrJUVGzlh/W3xiz5H0mJe4Ce/i7bYojCi
         zCWg==
X-Forwarded-Encrypted: i=1; AJvYcCUR37sAvfIU8i6aglahkHhnvYgt3ueyCIJO3TT2aQRhuTHpguwACLS28Hj7/asEtbPvzZpOJUWn9dxkzAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3dkHmTtZ9Kw4mWlJM+LMf3uU4O9zVkk6Em360oz4XXSpzm5G
	7NiNC1GJKlZl7B3CrgbKv6k8QzNxSpLBWGaD6x4poCrqBXdQ3m1H+RM3wMpbWRyg2+k=
X-Gm-Gg: ASbGncuYZ5esJ/nRVqlmb6iDcgLvq09To+9Dm++Eor367n9JjCvcd8sEjkIkBq1NtlS
	ohabzRX5gaefhbpKVDFagqfvxJ8U68TjAwQaur4ih65RDAy8xfyUFuHQYDZD5a476H0rGmBovNS
	+cZWZCk5S/1ORTgs1TbSrzjvNocF1hAERGuWq4Ddj5G88cVdCQduF7mmOa4yrXN5fGNE320IU20
	sLY1jr3NduXg4p7ap5jjQd0HKSyBdu0wdj1kcB0DyToEUIwG1FOjZQCYTye3aE6PqYPu4dTXkWI
	OQgpW5XP6PnDwDViLDsq3XgDP3un1t5/fznE96CTi+3B2BtTxORJSuhpjqRGChuNEIkhjpB6Uhk
	J7nisGf1atNI/bVKEC6qYkUl6T5CCnQdpOOtE
X-Google-Smtp-Source: AGHT+IG0+BqTueSpNbnuBlandiDGEja6A/cZ02YwvG41q3EwLk+9b/IGnNBQqbfzTmMyGVG/StOaRg==
X-Received: by 2002:a17:907:983:b0:b04:8420:b6ef with SMTP id a640c23a62f3a-b04b16d713bmr837603166b.61.1757344987584;
        Mon, 08 Sep 2025 08:23:07 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041d7107d9sm2097741066b.4.2025.09.08.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:23:07 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:23:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
Message-ID: <aL702dMFPy2bvfkp@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
 <84y0qtdk99.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84y0qtdk99.fsf@jogness.linutronix.de>

On Fri 2025-09-05 16:58:34, John Ogness wrote:
> On 2025-09-02, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index ff218e95a505fd10521c2c4dfb00ad5ec5773953..352235a0eb4a484caccf86d3a57d1a149218ecec 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> >  		 * interrupted by the panic CPU while printing.
> >  		 */
> >  		if (other_cpu_in_panic() &&
> > +		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&
> 
> This needs some sort of ifdef CONFIG_KGDB_KDB wrapped around it. Maybe
> it would be cleaner to have some macro.

Great catch!

> #ifdef CONFIG_KGDB_KDB
> #define KGDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id())
> #else
> #define KGDB_IS_ACTIVE() false
> #endif

I like this. It would fit into include/linux/kdb.h which already
contains the #ifdef CONFIG_KGDB_KDB / #else / #endif sections.

> and then something like:
> 
> 	if (other_cpu_in_panic() &&
> 	    !KGDB_IS_ACTIVE() &&
> 	    (!is_reacquire || cur->unsafe_takeover)) {
> 		return -EPERM;
> 	}
> 
> Or however you prefer. We need to compile for !CONFIG_KGDB_KDB.

Best Regards,
Petr

