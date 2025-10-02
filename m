Return-Path: <linux-kernel+bounces-840112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F24BB391A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D460B3B81F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0D307AF5;
	Thu,  2 Oct 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZtsT0+sZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CB2EBDCA
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399854; cv=none; b=OItAlyfo2+rLfqFj752ax/2WUOQBHCPlBCfrxKBxGXIC4uozCGeMJ/FFhmtrtlG+3mfRSECzybepycx5bn1LVpiv+HjoMJ+zQxa+iwgZEM9l8ibkNv+ZAlOVecbEgsUXdWx6KkugjR8iNFugjbhGiWCGZmcmCpEiJSF10BEU8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399854; c=relaxed/simple;
	bh=wXssKmLPJjqoKaW2dSKD8DrBwPR8NTRLuMaPkl0T40w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqv5wpINHw//W6JHmKYUQMql8/JyT3LYHqW9XPjEr8cTpurxrSw7LxXUg2DFFUeekp+p/nhZ2ol7RTK/wGEgmInpKLJ92gmR6sxdsoDZYKP086ZhFlL9pRTRXdPFzSHznibL5SS89tZvCprDPKC2uI8nDNc6ZUMqlLwSej4SyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZtsT0+sZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b40f11a1027so160428866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759399850; x=1760004650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GE+ky0OQxWYABlQ1pTeY2tV572+/4cRLHoT7laA9e2Y=;
        b=ZtsT0+sZgsiKYy0fczWhOiDJIRnw40azseHJYF9rIQKyECaylmIpEAsSlTiG7kfnZ/
         7vaj0Uyl58ADvOjFmb6LUBxjmChRutzQEZYWfRtaIBbwdXwfFcGbvxBCHPS7GzZSZp0x
         bV621k3HsKFIfT/l0oqhry0n0fOlB3DfvDVcLEhwdfNhsJxlG8FBX1smwsGm4w/1Uw+g
         xaoMLC/eBXAmqiP+K64dJsr0EAnQxLqmJvPZngU4A8XOMorlktsv0tPVFqcfP9E4GS1H
         gIcsdhR52Oy3IB7kOl3Zci5gzDtwuGzPArAW1TMXboP0xjdanisi/IMv++Ul/J5+tYWX
         H0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399850; x=1760004650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE+ky0OQxWYABlQ1pTeY2tV572+/4cRLHoT7laA9e2Y=;
        b=jTLxeUiC2SuzkF+Rqzd7sehrSPeDs65KFZWYWJku8ELCKrBqhMD8yfZCB60sxDEFA2
         JO0d/DkPGbA42tNsBrtV4O4xaniIRWRbomUzYSVSq2+NDIYg4Sbz9xlZJaoFi9r16Via
         //0UWDmUaWa607raxEKycQadaNlS05cF9zAbDaOV15nH11ohD0ftd/HxxjFU+jhBJVka
         /D4KdmsMIkP2cW8OVhPhEBEsT48jGnVNm22xZwKMzPoECwa3MOLpnlpvnmc1MIW7UUQV
         0BZ/PabuxtgKiWUqP9rtj0T9R05LcYjC8muXpye4LHhUFGlhh55bFbQC/JSgIoaTiylH
         BnPg==
X-Forwarded-Encrypted: i=1; AJvYcCWAbLQySp1SNWHys/vAVqGgrkhsMzKXewlb3W9UIUpXrsVpK+L3qjeqH0bV/M4E5MjKr78ErdRSfVaFIpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCt35b2rt9kYZdJLB5Wi5MVFLo9ijuPNSs9d2pQ/NUR4Gb7DM
	d9tVd5OSqOVXwEJYawCF6EOnwAi/yybKlnxIjB3sC/yKTNn6UmW+jmPrzsIe0j8jXZM=
X-Gm-Gg: ASbGncuX3AlBZ7Qb2Eqm9dSQPva9JHY94NANqvnYsfnS/ZLym/X6WqMYAn2xQ5PXevA
	bopcRUYqz3Y+2nRlE7m8xhIR2Nj9BMv+MIWUh8rzow90i/iLrZog97J+gPytZBzOqHikmZ5XPgA
	/jIimR/m7s7LpnMre/4lF8quqkdfm5U1Clk6N1dDbaMfKeofUepAKirf7w9Sr4YmWgCeN1tjinh
	+acUEA1FdCoz2JOoRpxWXZ8J+qYApytxiMgyI0Rsc0CwzzlgXtgulSC6LDU1xtsZztV1lLiDP36
	biCjHTDWL+vQH+Q+K5vrMfau6Nb3m4v62n1sCE0TXc7NyHjOm7i9iPcJ1ofhwkNlPQ2PUCupahQ
	thskYILOpTHQEJZQJNGJoxyiX7XO4g9pq7lhYFVq8QoH0c8HTJIqJXzEN5Icc
X-Google-Smtp-Source: AGHT+IGxl9hTQJndeyrrY2EXOVwu1e5fuv5VEZrM/+o7Oep3Ib43HVi1P0fq44Dw2SHMm6HLcy6y9w==
X-Received: by 2002:a17:907:3f07:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b46e9765a7cmr822509266b.32.1759399850373;
        Thu, 02 Oct 2025 03:10:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa035sm174647066b.15.2025.10.02.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:10:49 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:10:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
Message-ID: <aN5Pp2cFf_pedhxe@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de>
 <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
 <84seg3gd89.fsf@jogness.linutronix.de>
 <CALqELGw8wtbbihLsOcNgnV2vGoSR7kD8_tHmt7ESY4d3buwrLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGw8wtbbihLsOcNgnV2vGoSR7kD8_tHmt7ESY4d3buwrLQ@mail.gmail.com>

On Wed 2025-10-01 17:26:27, Andrew Murray wrote:
> On Wed, 1 Oct 2025 at 10:53, John Ogness <john.ogness@linutronix.de> wrote:
> >
> > On 2025-09-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > >> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > >> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > >> > index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
> > >> > --- a/kernel/printk/printk.c
> > >> > +++ b/kernel/printk/printk.c
> > >> > @@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> > >> >   */
> > >> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> > >> >  {
> > >> > -     bool any_usable = false;
> > >> > +     bool any_usable;
> > >>
> > >> Since console_flush_all() does read @any_usable, I would expect it to
> > >> initialize @any_usable. So I would not remove this definition initialization.
> > >
> > > Prior to this series, console_flush_all would set any_usable to false.
> > > It would be set to true if at any point a usable console is found,
> > > that value would be returned, or otherwise false if handover or panic.
> > > When the first patch split out this function, any_usable was kept as
> > > it was, leading to any_usable being true, even if a handover or panic
> > > had happened (hence additional checks needed, which are removed in
> > > this patch).
> > >
> > > By setting any_usable at the start of flush_one_record, it allows for
> > > any_usable to revert back to false, in the case where a once usable
> > > console is no longer usable. Thus representing the situation for the
> > > last record printed. It also makes console_flush_one_record easier to
> > > understand, as the any_usable flag will always be set, rather than
> > > only changing from false to true.
> >
> > OK. But then just have console_flush_all() set @any_usable in the loop:
> >
> > static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> > {
> >         bool any_progress;
> >         bool any_usable;
> >
> >         *next_seq = 0;
> >         *handover = false;
> >
> >         do {
> >                 any_usable = false;
> >                 any_progress = console_flush_one_record(do_cond_resched, next_seq,
> >                                                         handover, &any_usable);
> >         } while (any_progress);
> >
> >         return any_usable;
> > }
> 
> Yes, that seems like common sense, I have no idea why I didn't think of that :|

Looks good to me.

> 
> >
> > > Alternatively, it may be possible for console_flush_one_record to
> > > return any_usable, thus dropping it as an argument and removing the
> > > return of any_progress. Instead the caller could keep calling
> > > console_flush_one_record until it returns false or until next_seq
> > > stops increasing?

No, this won't work. @next_seq shows the highest value from all
consoles. It is no longer increased when at least one console
flushed all pending messages. But other consoles might be
behind, still having pending messages, and still making progress.

Honestly, I do not know how to make it better. We need to pass
both information: @next_seq and if some console flushed something.

Note that @next_seq is valid only when all consoles are flushed
and returning the same @next_seq. But it does not help to remove
the @any_progress parameter.

Best Regards,
Petr

