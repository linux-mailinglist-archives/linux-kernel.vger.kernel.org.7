Return-Path: <linux-kernel+bounces-867224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A9C01E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC1189DC79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7632D422;
	Thu, 23 Oct 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TDhUBtWz"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468B4C85
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231278; cv=none; b=a2q0PO5FQp6GocnBwWa8Eain8GFpoQFXoQVrUvabolMHcN3Faa58aQvXklO+jmUuevxcdMA1vbJmzR4oKuOUDZ9/AnfKgPMl3K98ECmgTFq+ehJKQM0aicd0CEvEW06TPYjooOKhRhWf4pI8JSSkxhn1Nitf5SUYO1KIf0hISpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231278; c=relaxed/simple;
	bh=mq3ytuZQB2bJYE0+c31ERiVTt17TGPs5iTAMVJpNvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkrOYGANA5Rgx9J2DfzMMgyJXpR8+PTG2O9+b1fi0MNN1NkQeRwFIDrGXjmXqVKcP26t7rLuET8JIugRMd6ZxsUj7LLDyi2jg9aKqbRLU2RGHtsXFwm0/e6B3nsa+wROL4E/u+U/ItYSePz5J+wusnqKkfen3wTEDa8Z4ihgpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TDhUBtWz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270a0127e1so642048f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761231274; x=1761836074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3jMmjvo4FLTzfyi/n9vqZV57e7ueqQo5y8dwn4MMig=;
        b=TDhUBtWznusorreltGm9ngjBn1Chb/dHqIYbMbVC5ucjsO4fdLQoMDICWwIhnhF9yC
         1wtsQjL5EC0wPvukEYVZCRaN9SRwVy71o+c6ttwfn1go3fwulMIdd1rEKBCQjvwnOXRw
         V560D2vfbXIqyjq/Ij0q74Ef2W/SsiKM8Uqo8SoSiKWsvBIfENOfn1Wu2BZq3ebNEZxn
         qtC+TSdxfdaVpx+mncIfxKX+KpLN9N0CVHw0l0LCc2BMTh5Z7o76TR2zFS3NgFxirNO6
         nG9bpmoyLiQuEOGwphlhOAQypa6qm4nX7myJuoR0iWBOZgAV03F6Khd5scFh5gYqjpyd
         48hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231274; x=1761836074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3jMmjvo4FLTzfyi/n9vqZV57e7ueqQo5y8dwn4MMig=;
        b=ieEar2sJMKF4wYW8yXRPQ6LYe6ZBu+v7WD+D1r9tFGjI6g0Kjnyjh/R1nU+RZdUh3j
         +gzjizqdsBl4ycfClXqjBox+/Ssk+g//S4otARVbAGjfqalqX/lrSHa3+fXfkm7j8D09
         YvdqYSCugQDOgw4X20V5jjJV2k4To2/FVLzic2F6A0IyYYT7GrHOme6sup3ShrrlUJbb
         mWZ4K1chalLBkRMiA//L+mSFXDYmAvWSNCt8HOlRvp76taHlj/Egs2GtmRBeuR68otqz
         Lh1KQNgHiFVE9gL0sHXENwlseUhUMKbsEHLcLvCYJXBUWhNJAyimExwkspZ02Niejd95
         dqsg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZKHeHfXmadlIp6EGjaY7LZY+8BzjrtCYU9Qo93+fqCD0yGMgSa/9yvtbea5JSrGI8BBIqIijbb2ZNvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjg2w7/dQAV+d1uHCsKU1iS8avTgpooRKVr2LV0gnK5v+KIxpK
	Ub7H3x8jtKB5kCXg6AFuLktdexzNzSdhxnm/4Tc9Li9Mo+IKwBtWFudpBZoueVkTtGNBVw4QEWR
	sPbN7
X-Gm-Gg: ASbGnctw+N/O4PNDG+dAknQNxlZ7bjuRgvwzQmBY1y0rZAezZz1xZmZTwjkTdAde+67
	38Z/iefACEaBfxYYxOnxs6IvwfIFVnblomgSrMo0OeNmzHFeTGim/Geqgiqr53hbILtsXCdWOmV
	y3I2v8N/Rx/B/YSvGni4/JrKVd9JYGVdeAHI9M9TjGUP2rOtdtMmKJ8XM60vhd3K+F2uWkR9d6x
	ralJgzpL4KN9OgTIkxfWMoN2mM8mQUUuo1XY2LgKAkNkxjGu8qgaESEjA2dsoq1Undy/hcGvlXK
	4lPoQwxU+kqOXguvSoQ7rTz7R4VfIixs+EUNnJIUbqH0hmvSbZztXpk+aCRZ9hFpCn5hwIMTveT
	vhNVCQkCGgLrzvz+bUfLeDomO15BLIuUrJpYy0uUpGdA/kZU3ZP1+6PmBKNysbuWqljFASpdao6
	5nLXVLf3ZnQbce5JQEt16RwB1p3NOv
X-Google-Smtp-Source: AGHT+IG+x5XaGdFxYnTTOzKLrWXRxSEit+DQoSYA9xn+oADNGLblx8edpMNnBeKopqijW6ZoM+kjqA==
X-Received: by 2002:a05:6000:2486:b0:3ee:1125:fb6d with SMTP id ffacd0b85a97d-42704d442c9mr14223004f8f.9.1761231273900;
        Thu, 23 Oct 2025 07:54:33 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adda1sm4466044f8f.29.2025.10.23.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:54:33 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:54:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] printk: console_flush_one_record() code cleanup
Message-ID: <aPpBpzjm2TpnbiNs@pathway.suse.cz>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk>
 <873479daeh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873479daeh.fsf@jogness.linutronix.de>

On Thu 2025-10-23 15:24:14, John Ogness wrote:
> On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 1c048c66d09919967e57326e1732bd17c10f3c76..6c846d2d37d9d20bad58c6e3a7caada3be9552ca 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3142,31 +3142,33 @@ static inline void printk_kthreads_check_locked(void) { }
> >   * context.
> >   *
> >   * @next_seq is set to the sequence number after the last available record.
> > - * The value is valid only when there is at least one usable console and all
> > - * usable consoles were flushed.
> > + * The value is valid only when all usable consoles were flushed. It is
> > + * when the function returns true (can do the job) and @try_again parameter
> > + * is set to false, see below.
> >   *
> >   * @handover will be set to true if a printk waiter has taken over the
> >   * console_lock, in which case the caller is no longer holding the
> >   * console_lock. Otherwise it is set to false.
> >   *
> > - * @any_usable will be set to true if there are any usable consoles.
> > + * @try_again will be set to true when it still makes sense to call this
> > + * function again. The function could do the job, see the return value.
> > + * And some consoles still make progress.
> >   *
> > - * Returns true when there was at least one usable console and a record was
> > - * flushed. A returned false indicates there were no records to flush for any
> > - * of the consoles. It may also indicate that there were no usable consoles,
> > - * the context has been lost or there is a panic suitation. Regardless the
> > - * reason, the caller should assume it is not useful to immediately try again.
> > + * Returns true when the function could do the job. Some consoles are usable,
> > + * and there was no takeover and no panic_on_other_cpu().
> >   *
> >   * Requires the console_lock.
> >   */
> >  static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> > -				     bool *any_usable)
> > +				     bool *try_again)
> >  {
> >  	struct console_flush_type ft;
> > -	bool any_progress = false;
> > +	int any_usable = false;
> 
> Nit: This should be a bool.

Great catch! No need to resend the patch. I could fix this when committing.

> With the change:
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks for the review. 

Best Regards,
Petr

