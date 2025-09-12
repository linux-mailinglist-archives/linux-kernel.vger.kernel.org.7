Return-Path: <linux-kernel+bounces-814369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BD7B55300
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A2B188588F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604C204096;
	Fri, 12 Sep 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2uiKvw2"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD51DE4F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690131; cv=none; b=i/rH2LFXIC1X1N/WkscLehcl4RqE/vKAvAKewiKLHaXBKLCdlTs9hHWX/M1znSEF1F3mHMb0Wgkfh6fzIenP1DLYNPbBib+AxOQxLutc6E3wsRjNU+zqp1HYFT6YnnMBRyi+R6n2s5qtJu+OMkPmHTm8J7UDUEvhlaqYn/4HYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690131; c=relaxed/simple;
	bh=aAyPQU0HgcI1WzAUx4XyXoKrSnHpQFjdA05lbr9RevU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM/flRHpAtHk4xxS+tOmKaFRmRAI1+in6XTPD32m/BvMxG0/WfKSmrrnguqF+r8RgDG2ZMCpulrsuMyVWKpm+QNB0NSzfp+GXK5Hg2Ggb+iKzeTb0ZvoB/pvEiRc6JO+Y6lOLharUzDf8BdfijSnlxJdU9o/23302dIcvNRJScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2uiKvw2; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so318170166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757690127; x=1758294927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DISFPBuhwuQiQ7VtaSSQJZYoE4Z/v987CUXIUT2Ngxc=;
        b=N2uiKvw2kjMQ+2kC4pOFSo8AA0nTYpABkIx6IUdFqb6fXvIeoPVCNyg3yOEfVrKWHA
         mC9RjHt/y2Eg+Td9RaMnMehR9G8cuNCDsUSwA8pgvh4Qv+t6UiBCSmZUjqVFBYvI9el0
         kH20LSrOpHfqE+qKjaJN9vCbym+SegLANRbRHZx8z3QHsAeLmwKWFbeEIfpDJlPthUBq
         rzjWHZi3MtTRSSax8CY2la0ECfaK9ELlMtU7cF/LpJaqZnG69gxlITnItnHM4FnqYy9+
         uKH5wZnHTaI9dbLH1zfVo6qm/dvzo/8XsdDATGk/zFlve660Vsp93U21tt/XljcYldUw
         OVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690127; x=1758294927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DISFPBuhwuQiQ7VtaSSQJZYoE4Z/v987CUXIUT2Ngxc=;
        b=pWzVWj6lQLoVw0P7u1vlBLEyBh656TDB3ovQFB8lEZzg4rh+4ognQ6ZTOAgFtOuu2g
         OJYL+872yzxe3BJg64MrVjbm1wmWkMsHz08VhR9bxZcQKYjua62FzVCwbuOK2uEgxmuF
         ms9rj2sqgN56lFx7+Rpket/b8YfXtt2Nz5/ghj0bMUnSGw3Ud6eZVMmK5WPqG7AFgLrq
         btBOnJm7P0NMnefawg46jD6qhSXHg5V1YzGE7arqOeW4xhvuaEUr37cn3MR+NQ+ftQcW
         0UeUHPPruZcp5wNwU1gP0Fqc+umUDV5GBRj8kq3Q4cM3tKk6TKGKL2gMBI+PnRD4h+JI
         wIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrehiErNjBNKJn7yZ/OAX6BSY6x7sKYArahEWyJXnBRrGwPJr8Hsn8D6XLSBzbCoEB91uYyeofx70RssU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2A2Cev7mh4x62vZb3zwFlOdPnkNshnIvXOgXqki3gbR2k93Ms
	c6mR+JS6a/Hq/akppjDE0bMzFAEQzn6RhUnKbg6/Ow2TYWaWp6F9mOXh6aNxpEPRTsE=
X-Gm-Gg: ASbGncuAVUXkpwW6nP0RqT6j9DWbd151Xde5/7BmcEP/KebFAo9ynwhY1r1rFAYw8YN
	u12siqQ7i1d5oTkoLE7Pa+SZd3tscx0kOfKKkNJkujxZKEyqBeJrB00VhlnrtmjP3EOHB+2mYIR
	JuwkxzBIl2PpgVm7lx0tf6e05QPnjSdJQcTOGcqVjNDmyVWLJ7SbneDvZo4RPiyVQvWfNGcyvIm
	2sT3c57Y2mZNGW5x67oHvrjAznWlxJI91/XtDeGIWZd/OKk/cMqxCDVKuIi26m2z1NY40G+ydEq
	bdAe98EQV8CBgSp9o5YkguRkhG1MLHYzPFvZo2H6tpeBuu43GgPmj/H/SpM1hLt+Vmqook4BCdG
	0rWlV0UEJyEG4CfkDGyJzkxIcjkWpw7iIogjk
X-Google-Smtp-Source: AGHT+IG0/knR1delqni7opuVRY/orLXBBQPghmCf5TA0Cxjc9eEVIvA8SPULmL++0rmtha1vTUTArw==
X-Received: by 2002:a17:907:e885:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b07c909d374mr226263266b.32.1757690127408;
        Fri, 12 Sep 2025 08:15:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad69csm3638083a12.16.2025.09.12.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:15:27 -0700 (PDT)
Date: Fri, 12 Sep 2025 17:15:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMQ5DdY41jlftEZn@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
 <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz>
 <aMQzD9CLP1F01Rry@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQzD9CLP1F01Rry@pathway.suse.cz>

On Fri 2025-09-12 16:49:53, Petr Mladek wrote:
> On Fri 2025-09-12 11:55:02, Petr Mladek wrote:
> > On Fri 2025-09-12 11:25:09, Petr Mladek wrote:
> > > On Thu 2025-09-11 18:18:32, John Ogness wrote:
> > > > On 2025-09-11, Petr Mladek <pmladek@suse.com> wrote:
> > > > > diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > > index 2282348e869a..241f7ef49ac6 100644
> > > > > --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > > +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > > @@ -56,7 +56,7 @@ struct prbtest_rbdata {
> > > > >  	char text[] __counted_by(size);
> > > > >  };
> > > > >  
> > > > > -#define MAX_RBDATA_TEXT_SIZE 0x80
> > > > > +#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
> > > > 
> > > > I guess this should be:
> > > > 
> > > > #define MAX_RBDATA_TEXT_SIZE (256  - sizeof(struct prbtest_rbdata))
> > > 
> > > Great catch!
> > > 
> > > But the KUnit test fails even with this change, see below. And I am
> > > not surprised. The test should work even with larger-than-allowed
> > > messages. prbtest_writer() should skip then because prb_reserve()
> > > should fail.
> > > 
> > > Here is test result with:
> > > 
> > > #define MAX_RBDATA_TEXT_SIZE (256 - sizeof(struct prbtest_rbdata))
> > > #define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)
> > > 
> > > DEFINE_PRINTKRB(test_rb, 4, 4);
> > > 
> > > and with this patchset reverted, aka, sources from
> > > printk/linux.git, branch for-next:
> > > 
> > > It is well reproducible. It always fails after reading few records.
> > > Here are results from few other runs:
> > 
> > And I am not longer able to reproduce it after limiting the size
> > of the record to 1/4 of the data buffer size. I did it with
> > the following change:
> > 
> > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > index bc811de18316..2f02254705aa 100644
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
> >   */
> >  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> >  {
> > -	struct prb_data_block *db = NULL;
> > -
> >  	if (size == 0)
> >  		return true;
> >  
> > @@ -409,7 +407,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> >  	 * at least the ID of the next block.
> >  	 */
> >  	size = to_blk_size(size);
> > -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> > +	if (size > DATA_SIZE(data_ring) / 4)
> >  		return false;
> >  
> >  	return true;
> > 
> > 
> > I guess that there is a race when we need to make all existing records
> > reusable when making space for the next one.
> 
> It looks to me that the reader API is not ready to handle the
> situation when all records are "reusable".
> 
> At least, it looks like prb_next_seq() might end up in an "infinite"
> loop because it blindly increments "seq" until finding a valid record...
> 
> Honestly, I would really like to limit the maximal record size to
> 1/4 of the buffer size. I do not want to make the design more
> complicated just to be able to fill just one record, definitely.
> 
> 
> That said, I still a bit nervous because I do not understand why
> the KUnit test fails. It does not depend on prb_next_seq().
> 
> It seems that prb_read_valid() retuns success even when
> returning a garbage. I have added some debug output using
> trace_printk():
> 
> BTW2: It seems the even writers had problems to reserve space this
>       time. Only few of them succeeded few times from many attempts.
>       I the numbers by this change:

This actually helped. It seems that even prb_read_valid() is blindly
incrementing seq when the last entry is reusable
(desc_read_finalized_seq() return -ENOENT).

And the failed entries are entries which have not been written.
Here is another output where it is easier to see:

[  241.991189]     KTAP version 1
[  241.991511]     # Subtest: printk-ringbuffer
[  241.991912]     # module: printk_ringbuffer_kunit_test
[  241.991941]     1..1
[  241.993854]     # test_readerwriter: running for 10000 ms
[  241.995189]     # test_readerwriter: start thread 001 (writer)
[  241.995451]     # test_readerwriter: start thread 002 (writer)
[  241.995722]     # test_readerwriter: start thread 003 (writer)
[  241.997300]     # test_readerwriter: start thread 004 (writer)
[  241.997947]     # test_readerwriter: start thread 005 (writer)
[  241.998351]     # test_readerwriter: start thread 006 (writer)
[  241.998686]     # test_readerwriter: start thread 007 (writer)
[  241.998971]     # test_readerwriter: start thread 008 (writer)
[  242.001305]     # test_readerwriter: start thread 009 (writer)
[  242.001984]     # test_readerwriter: start thread 010 (writer)
[  242.002680]     # test_readerwriter: start thread 011 (writer)
[  242.002686]     # test_readerwriter: starting test
[  242.009239]     # test_readerwriter: start reader
[  242.009940]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=485 size=4325444 text=
[  242.011676]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=487 size=1145324612 text=
[  242.013569]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=490 size=4325444 text=
[  242.015316]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=491 size=61 text=DDDDDDDDDDDDDDDDDDDBBBBBBBBBBB
[  242.017483]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=492 size=1145324612 text=
[  252.221105]     # test_readerwriter: end reader: read=14 seq=496
[  252.221918]     # test_readerwriter: completed test
[  252.225842]     # test_readerwriter: end thread 011: wrote=0 by attempts=9760048
[  252.226808]     # test_readerwriter: end thread 010: wrote=0 by attempts=9764865
[  252.227766]     # test_readerwriter: end thread 009: wrote=0 by attempts=9768991
[  252.228507]     # test_readerwriter: end thread 008: wrote=0 by attempts=12716826
[  252.229283]     # test_readerwriter: end thread 007: wrote=0 by attempts=12674260
[  252.230046]     # test_readerwriter: end thread 006: wrote=0 by attempts=9769229
[  252.230880]     # test_readerwriter: end thread 005: wrote=0 by attempts=12716512
[  252.231639]     # test_readerwriter: end thread 004: wrote=0 by attempts=12627682
[  252.232390]     # test_readerwriter: end thread 003: wrote=364 by attempts=9766282
[  252.233222]     # test_readerwriter: end thread 002: wrote=0 by attempts=12710049
[  252.233970]     # test_readerwriter: end thread 001: wrote=123 by attempts=9786928
[  252.234758]     # test_readerwriter.speed: slow
[  252.234792]     not ok 1 test_readerwriter

Only two write threads succeed in writing few messages:

    264 + 123 = 487

And the failed records have sequence numbers: 485, 487, 490, 491, 492.

I am not sure about 485 and 487. But the other three read entries
were never written.

It is possible the 485 and 487 entries were read before they were
written. I mean that the reader failed before writers failed.

I am not sure why writers failed. But I guess that they also
somehow depend on the fact that at least one oldest entry is
always finalized. I vaguely recall that we operated with this
condition at some point.

Best Regards,
Petr

