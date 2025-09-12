Return-Path: <linux-kernel+bounces-813565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DAB5478C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2009B560D02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F0283FDD;
	Fri, 12 Sep 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JKBaJ4dP"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B5283144
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669113; cv=none; b=J+5+ibW+ZSb2Xjub0iVh+NAquVFL0FPd/84OphXlhehWLdqltGBkRVQ/wuDuPwaKzWW8/hLByUJSecH7K/B/BwTcrAbC04YzR0qJxt6Imn+jyzK0tn9uui80oxeHPrhml4kYWXqex+F8rkNtM801+c/OfbxcL53q19qW4ZeUtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669113; c=relaxed/simple;
	bh=JkqcJNCNrP/NBrvMF2SCmQxB/OaERHTNSgGlQSqDjMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uym/EFdI4NmrDpWKd6QTRdi6bcJmESZ5rEY/ZRQ9DqOFa3d+vJbVwY5Ci7Jecmq5tUFqfAcyze4mb7Ilzt860XcitEN7DO3FfgFV15YoBihq5vBBwC9Lgs5IcpOXjAcGCUas1xHT6PafF0IhipO2Bwon0nfntsBbvhARDSvbT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JKBaJ4dP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62ee22c8940so644901a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757669108; x=1758273908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSCNKaGQ0TXo9yOTAb9N6YviqsEUR693AcIHTThc0/g=;
        b=JKBaJ4dPLWvRdae6n0fA1aOQgzKmWjXeZpaCoX7+6o8qo4cvOOX1BWjMHJCoFKrTkF
         rQa8BfUvA04r+YszQyXEhRnAfMVBJet0zagygFFdl7BaGOb0UG2nuYi5IouOP9P3ASbQ
         6yw8U6ZZmserLw5IncSZAohZ2/L15FauzXYizoqmWIkvq2NUsN3jbhyemjE5IQeCN1QQ
         g9EkUg5dv4MO6BJOJd965P7FdMvd66QM18sJf2wBOrrqPQtj+eKxTAguGMASsfFXN92x
         5KSUWDDuigRJsnTl6On19dv5MIB7g60Be8Z7FfkmFH+4oRHlbRf78eBMBTKLIjQfymP5
         oHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669108; x=1758273908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSCNKaGQ0TXo9yOTAb9N6YviqsEUR693AcIHTThc0/g=;
        b=CRipo+sCLWp11Inaj9vigayZnk/uz+aDTnRRjUInF5900rM8aRM4gV33+zmngw0l9T
         IX/qxCFB9kUt7AGZcPMgqt7NLGHWI6SqFeqmqpv6kRKnWUt4dPlyFrf/bARz1j9JFBLq
         9g2ktqsBTdA2ByucYuLf3VnXB9LuIqndwKlZnsrALd+xeEZ8N2tffgOkaR7az3sIVO+q
         Xq5uhGihsRWqqTFAgNTPno/vMSkYXvLOSFpUIThfdcfQW71LqkWsMwb0F9wGHrCukTYF
         w2u9oPIduhUwmwh1Ay8tYsil+AdGuMMXQMxU9ppldqjkAtH7gZdw/Nt5BRPsMeqZkuQ0
         apwA==
X-Forwarded-Encrypted: i=1; AJvYcCWd8Y3Li4JxMcyjeo034gixCMJ1Iekt+sPZaiNj5xbuom7VtXkhO3XjxQqPLE0uo4JxjCsHaz8bsPTQdnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysH0BFs8SZleCGpVg4PhTFp3qG0SsrcGdFzy2Kr7xozdqZgEq2
	x2RjDLXekHqOw5lR5PgNRAK9GnWeDCj17x8tQ4Z3syrf6gkBj5ovX6dX3D5jRhVQK3Y=
X-Gm-Gg: ASbGnctGzRuedtBCCsB6MQLoWUjSlCsakjhA+Z2sB0jvRmpNYtQ8R/4uUZ4bmhhH4r2
	Vui88X9opNy4DNmyNEuZk4PRAEmkM5+2AT3Y/w1M4is7H/Soe5Lu5zrOhvyc+KA+/c4ElfwFEWC
	dmmsPiWqjvON2VU4FcYyrVbzDIHjV4OLghQor59peQmfiaA/RVLuqJfNylLEhBt4dRakhlCZuOv
	qiqdZiyb8N/GV665pNefBIlc8EzqgHS5RjnYJsJspse+UngCLWC7qVlxzS0zqx9eXUkgY2g5T9u
	eZ3iD/7sDD0Y7qLaQXxDIv2AdVb/OH5P5GpC3Wv5eB4F2JbkneWdxrdVGBFzYF/RfMyzi7aSGQ3
	Rajjulz7IgGL5Yb9ENzbJflCehg==
X-Google-Smtp-Source: AGHT+IGmH28eR224mv6k+mP1uIMnq977Y7n1QQRwBYcwaoIBDdm+NNMF/7KE1WGvsBG+g8xzOxo/6A==
X-Received: by 2002:a17:906:dc90:b0:b04:a831:4b8a with SMTP id a640c23a62f3a-b07c3869f66mr201431466b.53.1757669108229;
        Fri, 12 Sep 2025 02:25:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd408sm326866966b.59.2025.09.12.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:25:07 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:25:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMPm8ter0KYBpyoW@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bjnhx91r.fsf@jogness.linutronix.de>

On Thu 2025-09-11 18:18:32, John Ogness wrote:
> On 2025-09-11, Petr Mladek <pmladek@suse.com> wrote:
> > diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> > index 2282348e869a..241f7ef49ac6 100644
> > --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> > +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> > @@ -56,7 +56,7 @@ struct prbtest_rbdata {
> >  	char text[] __counted_by(size);
> >  };
> >  
> > -#define MAX_RBDATA_TEXT_SIZE 0x80
> > +#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
> 
> I guess this should be:
> 
> #define MAX_RBDATA_TEXT_SIZE (256  - sizeof(struct prbtest_rbdata))

Great catch!

But the KUnit test fails even with this change, see below. And I am
not surprised. The test should work even with larger-than-allowed
messages. prbtest_writer() should skip then because prb_reserve()
should fail.

Here is test result with:

#define MAX_RBDATA_TEXT_SIZE (256 - sizeof(struct prbtest_rbdata))
#define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)

DEFINE_PRINTKRB(test_rb, 4, 4);

and with this patchset reverted, aka, sources from
printk/linux.git, branch for-next:

[  229.020133] printk_ringbuffer_kunit_test: module verification failed: signature and/or required key missing - tainting kernel
[  229.029453] KTAP version 1
[  229.029793] 1..1
[  229.030461]     KTAP version 1
[  229.030771]     # Subtest: printk-ringbuffer
[  229.031111]     # module: printk_ringbuffer_kunit_test
[  229.031142]     1..1
[  229.032371]     # test_readerwriter: running for 10000 ms
[  229.034348]     # test_readerwriter: start thread 001 (writer)
[  229.034721]     # test_readerwriter: start thread 002 (writer)
[  229.035398]     # test_readerwriter: start thread 003 (writer)
[  229.035697]     # test_readerwriter: start thread 004 (writer)
[  229.038006]     # test_readerwriter: start thread 005 (writer)
[  229.041965]     # test_readerwriter: start thread 006 (writer)
[  229.042244]     # test_readerwriter: start thread 007 (writer)
[  229.042559]     # test_readerwriter: start thread 008 (writer)
[  229.042748]     # test_readerwriter: start thread 009 (writer)
[  229.042996]     # test_readerwriter: start thread 010 (writer)
[  229.043288]     # test_readerwriter: starting test
[  229.043299]     # test_readerwriter: start thread 011 (writer)
[  229.043370]     # test_readerwriter: start reader
[  229.043574]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=15 size=1111638594 text=
[  239.133686]     # test_readerwriter: end reader: read=14 seq=24
[  239.134417]     # test_readerwriter: completed test
[  239.136019]     # test_readerwriter: end thread 011: wrote=10466402
[  239.136856]     # test_readerwriter: end thread 010: wrote=10461343
[  239.137825]     # test_readerwriter: end thread 009: wrote=13686189
[  239.138478]     # test_readerwriter: end thread 008: wrote=10475551
[  239.139106]     # test_readerwriter: end thread 007: wrote=13652622
[  239.139765]     # test_readerwriter: end thread 006: wrote=10473282
[  239.140376]     # test_readerwriter: end thread 005: wrote=10444451
[  239.140989]     # test_readerwriter: end thread 004: wrote=10466857
[  239.141652]     # test_readerwriter: end thread 003: wrote=13733553
[  239.142243]     # test_readerwriter: end thread 002: wrote=13710538
[  239.142859]     # test_readerwriter: end thread 001: wrote=13738411
[  239.143738]     # test_readerwriter.speed: slow
[  239.143771]     not ok 1 test_readerwriter
[  239.144161] not ok 1 printk-ringbuffer

It is well reproducible. It always fails after reading few records.
Here are results from few other runs:

[ 1617.607865]     KTAP version 1
[ 1617.608377]     # Subtest: printk-ringbuffer
[ 1617.608891]     # module: printk_ringbuffer_kunit_test
[ 1617.609041]     1..1
[ 1617.613633]     # test_readerwriter: running for 10000 ms
[ 1617.614796]     # test_readerwriter: start thread 001 (writer)
[ 1617.615562]     # test_readerwriter: start thread 002 (writer)
[ 1617.616399]     # test_readerwriter: start thread 003 (writer)
[ 1617.617911]     # test_readerwriter: start thread 004 (writer)
[ 1617.618763]     # test_readerwriter: start thread 005 (writer)
[ 1617.619067]     # test_readerwriter: start thread 006 (writer)
[ 1617.619368]     # test_readerwriter: start thread 007 (writer)
[ 1617.619650]     # test_readerwriter: start thread 008 (writer)
[ 1617.619921]     # test_readerwriter: start thread 009 (writer)
[ 1617.620211]     # test_readerwriter: start thread 010 (writer)
[ 1617.620462]     # test_readerwriter: starting test
[ 1617.623169]     # test_readerwriter: start thread 011 (writer)
[ 1617.623175]     # test_readerwriter: start reader
[ 1617.624508]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=9 size=1111638594 text=
[ 1617.626400]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=13 size=1111638594 text=
[ 1617.628225]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=17 size=1111638594 text=
[ 1627.681624]     # test_readerwriter: end reader: read=14 seq=17
[ 1627.682370]     # test_readerwriter: completed test
[ 1627.683960]     # test_readerwriter: end thread 011: wrote=10452656
[ 1627.684779]     # test_readerwriter: end thread 010: wrote=13707777
[ 1627.685412]     # test_readerwriter: end thread 009: wrote=10480695
[ 1627.686274]     # test_readerwriter: end thread 008: wrote=10470822
[ 1627.687081]     # test_readerwriter: end thread 007: wrote=13697351
[ 1627.687716]     # test_readerwriter: end thread 006: wrote=10464543
[ 1627.688317]     # test_readerwriter: end thread 005: wrote=10488791
[ 1627.688919]     # test_readerwriter: end thread 004: wrote=10488529
[ 1627.689492]     # test_readerwriter: end thread 003: wrote=13738659
[ 1627.690321]     # test_readerwriter: end thread 002: wrote=13718856
[ 1627.690915]     # test_readerwriter: end thread 001: wrote=13675859
[ 1627.691694]     # test_readerwriter.speed: slow
[ 1627.691753]     not ok 1 test_readerwriter
[ 1627.692512] not ok 1 printk-ringbuffer


[ 1627.693708]     KTAP version 1
[ 1627.694046]     # Subtest: printk-ringbuffer
[ 1627.694385]     # module: printk_ringbuffer_kunit_test
[ 1627.694410]     1..1
[ 1627.695698]     # test_readerwriter: running for 10000 ms
[ 1627.698351]     # test_readerwriter: start thread 001 (writer)
[ 1627.698935]     # test_readerwriter: start thread 002 (writer)
[ 1627.699341]     # test_readerwriter: start thread 003 (writer)
[ 1627.699657]     # test_readerwriter: start thread 004 (writer)
[ 1627.699891]     # test_readerwriter: start thread 005 (writer)
[ 1627.700111]     # test_readerwriter: start thread 006 (writer)
[ 1627.700337]     # test_readerwriter: start thread 007 (writer)
[ 1627.700620]     # test_readerwriter: start thread 008 (writer)
[ 1627.700885]     # test_readerwriter: start thread 009 (writer)
[ 1627.701134]     # test_readerwriter: start thread 010 (writer)
[ 1627.701371]     # test_readerwriter: starting test
[ 1627.701374]     # test_readerwriter: start thread 011 (writer)
[ 1627.705369]     # test_readerwriter: start reader
[ 1627.706115]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=16 size=1111638594 text=
[ 1627.707966]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=20 size=1111638594 text=
[ 1627.710886]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=24 size=16962 text=
[ 1637.917622]     # test_readerwriter: end reader: read=14 seq=27
[ 1637.918372]     # test_readerwriter: completed test
[ 1637.919848]     # test_readerwriter: end thread 011: wrote=10559459
[ 1637.920670]     # test_readerwriter: end thread 010: wrote=13811125
[ 1637.921309]     # test_readerwriter: end thread 009: wrote=10572663
[ 1637.922176]     # test_readerwriter: end thread 008: wrote=10570916
[ 1637.922818]     # test_readerwriter: end thread 007: wrote=13832304
[ 1637.923456]     # test_readerwriter: end thread 006: wrote=10571421
[ 1637.924082]     # test_readerwriter: end thread 005: wrote=10579437
[ 1637.924703]     # test_readerwriter: end thread 004: wrote=13861481
[ 1637.925318]     # test_readerwriter: end thread 003: wrote=10590865
[ 1637.925977]     # test_readerwriter: end thread 002: wrote=13852926
[ 1637.926570]     # test_readerwriter: end thread 001: wrote=13845110
[ 1637.927172]     # test_readerwriter.speed: slow
[ 1637.927202]     not ok 1 test_readerwriter
[ 1637.927611] not ok 1 printk-ringbuffer



[ 1658.412099]     KTAP version 1
[ 1658.412409]     # Subtest: printk-ringbuffer
[ 1658.412784]     # module: printk_ringbuffer_kunit_test
[ 1658.412813]     1..1
[ 1658.416372]     # test_readerwriter: running for 10000 ms
[ 1658.417927]     # test_readerwriter: start thread 001 (writer)
[ 1658.418309]     # test_readerwriter: start thread 002 (writer)
[ 1658.418785]     # test_readerwriter: start thread 003 (writer)
[ 1658.418996]     # test_readerwriter: start thread 004 (writer)
[ 1658.419262]     # test_readerwriter: start thread 005 (writer)
[ 1658.419531]     # test_readerwriter: start thread 006 (writer)
[ 1658.419758]     # test_readerwriter: start thread 007 (writer)
[ 1658.420028]     # test_readerwriter: start thread 008 (writer)
[ 1658.420239]     # test_readerwriter: start thread 009 (writer)
[ 1658.420516]     # test_readerwriter: start thread 010 (writer)
[ 1658.420737]     # test_readerwriter: starting test
[ 1658.420739]     # test_readerwriter: start thread 011 (writer)
[ 1658.420791]     # test_readerwriter: start reader
[ 1658.420879]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=8 size=217 text=DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD\x10\xa2\xff\xff\xff\xff#\x8b^M\xa4\xff\xff\xff\xff\xb3\x8a\xb5A
[ 1658.421015]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=9 size=217 text=DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD\x10\xa2\xff\xff\xff\xff#\x8b^M\xa4\xff\xff\xff\xff\xb3\x8a\xb5A
[ 1658.421152]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=10 size=1145324612 text=
[ 1658.431961]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=18 size=1145324612 text=
[ 1668.637609]     # test_readerwriter: end reader: read=13 seq=20
[ 1668.638384]     # test_readerwriter: completed test
[ 1668.639464]     # test_readerwriter: end thread 011: wrote=13482649
[ 1668.640116]     # test_readerwriter: end thread 010: wrote=10354440
[ 1668.640934]     # test_readerwriter: end thread 009: wrote=10388436
[ 1668.642245]     # test_readerwriter: end thread 008: wrote=13621613
[ 1668.642886]     # test_readerwriter: end thread 007: wrote=10072648
[ 1668.643536]     # test_readerwriter: end thread 006: wrote=13582778
[ 1668.644171]     # test_readerwriter: end thread 005: wrote=10397092
[ 1668.644792]     # test_readerwriter: end thread 004: wrote=13499818
[ 1668.645415]     # test_readerwriter: end thread 003: wrote=10362779
[ 1668.646319]     # test_readerwriter: end thread 002: wrote=10348508
[ 1668.646924]     # test_readerwriter: end thread 001: wrote=13616849
[ 1668.647584]     # test_readerwriter.speed: slow
[ 1668.647618]     not ok 1 test_readerwriter
[ 1668.648311] not ok 1 printk-ringbuffer


Best Regards,
Petr

