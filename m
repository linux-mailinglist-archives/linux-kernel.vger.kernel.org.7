Return-Path: <linux-kernel+bounces-813631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71EB54873
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFE1768F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4BD28750A;
	Fri, 12 Sep 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NLkp2wrM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7092571D4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670906; cv=none; b=oqM7xZMgMPZnsyzm/snn6n22ZsQSAtiDW6sguHO1Vf7KGINP9jn2DtV8FaUVWbHOXSFqrxEVWbgIFZV735uBzbpqY6qpYmjhMFQTGZou+SUSQcplpLr78ICe1HgGR1zf5wHBrzb6u4rqHKggck8L2Nq9AK4j2m36Fl+7oJPU6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670906; c=relaxed/simple;
	bh=EuhKOu5I9B4y/dYif9Sc1fgwAmFm2XI1KeMdUaX7hAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3AyNHsxJRLSr8uBxzOToc2J61X9heloE1FVNa8UIGhQftQWN3HfV6mCuE1C2/USJBO0Pv3Et5Rm8WGIhngpLvO+7AAjfOcbhhjWv311lOyzfSE6EXLjLggmYUxdXmoKGEk+ftP6wl9Z2bB6EghAKN2b+VxjK78Bp4QB7rzgCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NLkp2wrM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso2784364a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757670902; x=1758275702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu8eftj9lO+8MZ35o1UII2RnGbq23waotf1b1sIZgRI=;
        b=NLkp2wrMgkst8ZYBwoO7vrEwFOxhA5ES9VYeigCGXh9IxhSxMnHgsntphbO5RDSeZz
         2Nf0VdLIVsvmExWR+NNpavpFR7xywSd3y82bW8n2aPteRSMuwXVjnEoJJnjuTutDlm8Z
         JwWu/bEymhG4K6s21TpNff92dgkFIfFs1SbJ+JQTtUWKdak4wXEkhLwl/Xa3zVtTCtFt
         V0nctHktTrPJk6hNQ1UlTsLmc2uvb1UyZpHEakfoDqc+ys+HmhAa7oSOUi1/eMiVWs+9
         nZayQdgwB2of1DELiqYSAFyQ71veA0bzgVCrg6QZ9P8c4fEa5RdsXLR9gEQXqcbYvFgA
         hBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757670902; x=1758275702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu8eftj9lO+8MZ35o1UII2RnGbq23waotf1b1sIZgRI=;
        b=P6vY0W4I752k7eHovqxxmftGUlwyxvVhb2KCjNoi1htnyT0kPViwD2qqFrq6I6hkdb
         4SjMIYnPJhLt++2JyDVWKoM1gX8OGo12BRCypaMWZUDBIVtPxtFLAfZDjr8QQgsk1izV
         FSR7TaVseHiFy1g0mJmB8eVA78r5/nvKt75P1HxTob7L0GNh3AVWbfnYbmuBYtjAEmwb
         L7zwjampV/7JeOO37brQwv8obAsAuRnui5VpDJvOYd3ebU+luD8DPh2/M57q5KLSRD7v
         Qk+WlMS4JCUC+an2Au/pM4SI67TUlbXyQukKizCgm1oMIQZaJtmFrU4te6+/5ee4ZtS6
         Dk7w==
X-Forwarded-Encrypted: i=1; AJvYcCW0hu7HTlMJvozgf+df1kKeAoej6RPCpoqpRGgABZUnI4oYseQusZC9/4Arug8zftp5CjyZQO5bve1pKBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj062uM1bpX49/B8jIcG0fI8rOhsfXEry8L517NIb5hx994vQv
	7VwmSPEI3DkE8NUs1HY+rLcGJa6qj1eNqa+ZLxWgw6CXz7Ln09ZkJjXa1YZWh/ma/RRBGGytJhr
	W6Kb+WZw=
X-Gm-Gg: ASbGnct7f2ZfgnOrOjjWL6EA+35PDHIYNhrS6jCOrnWYHNchOc+oQ+6NFXFla7WRqRG
	/y7iExJeXkXgL1kC+JVZHhXEzPOx/J4nXcK0tCwDcIlWxcAFM1G3Wk9LIsmuCvkYTPAv7HqUPaP
	XEBlUxSoLgDBI6LWk4Bl2HlSrhePk3Kj9nyT8R3YZEN3+W6jrYZnLVEUP1LLwrJAbYSfTLGQJu9
	tNetWIjsM2KYIT9B5cGAS5swk/hqToS1i0a5FiuwM/BW4mFS5SNt0rZ+xR0532h4M8EKMvM918P
	m1/moyzgX9xjkM910uPVTUN68QSt4RHcz4gsMp8XhI4dcFhoZASqR6wVtZl/iHB3ZATlHVHZCv3
	Rn88sN0J7pD5MvIELcNkbROFazw==
X-Google-Smtp-Source: AGHT+IGxyE9vkABOt3gbaAeUK07jTCLD+YMy9b7gS6a0UrTNFcfefOdVYqgMjyZDfqObnnOor64qEQ==
X-Received: by 2002:a05:6402:a0cd:b0:626:1fce:d2f2 with SMTP id 4fb4d7f45d1cf-62ed826785emr2591915a12.16.1757670901948;
        Fri, 12 Sep 2025 02:55:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad741sm3032515a12.21.2025.09.12.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:55:01 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:54:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMPt8y-8Wazh6ZmO@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
 <aMPm8ter0KYBpyoW@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMPm8ter0KYBpyoW@pathway.suse.cz>

On Fri 2025-09-12 11:25:09, Petr Mladek wrote:
> On Thu 2025-09-11 18:18:32, John Ogness wrote:
> > On 2025-09-11, Petr Mladek <pmladek@suse.com> wrote:
> > > diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > index 2282348e869a..241f7ef49ac6 100644
> > > --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> > > +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > @@ -56,7 +56,7 @@ struct prbtest_rbdata {
> > >  	char text[] __counted_by(size);
> > >  };
> > >  
> > > -#define MAX_RBDATA_TEXT_SIZE 0x80
> > > +#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
> > 
> > I guess this should be:
> > 
> > #define MAX_RBDATA_TEXT_SIZE (256  - sizeof(struct prbtest_rbdata))
> 
> Great catch!
> 
> But the KUnit test fails even with this change, see below. And I am
> not surprised. The test should work even with larger-than-allowed
> messages. prbtest_writer() should skip then because prb_reserve()
> should fail.
> 
> Here is test result with:
> 
> #define MAX_RBDATA_TEXT_SIZE (256 - sizeof(struct prbtest_rbdata))
> #define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)
> 
> DEFINE_PRINTKRB(test_rb, 4, 4);
> 
> and with this patchset reverted, aka, sources from
> printk/linux.git, branch for-next:
> 
> It is well reproducible. It always fails after reading few records.
> Here are results from few other runs:

And I am not longer able to reproduce it after limiting the size
of the record to 1/4 of the data buffer size. I did it with
the following change:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index bc811de18316..2f02254705aa 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
  */
 static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 {
-	struct prb_data_block *db = NULL;
-
 	if (size == 0)
 		return true;
 
@@ -409,7 +407,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
 	 * at least the ID of the next block.
 	 */
 	size = to_blk_size(size);
-	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
+	if (size > DATA_SIZE(data_ring) / 4)
 		return false;
 
 	return true;


I guess that there is a race when we need to make all existing records
reusable when making space for the next one.

Another aspect might be the very small amount of descriptors (16).
They are quickly recycled. But it is not a problem after
limiting the size of the record to 1/4.

Note that my test system is using 12 CPUs in KVM.
And it is x86_64.

Best Regards,
Petr

