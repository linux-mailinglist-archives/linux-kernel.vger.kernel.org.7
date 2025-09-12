Return-Path: <linux-kernel+bounces-814311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247EFB55242
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F0189F572
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F130DEDA;
	Fri, 12 Sep 2025 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JFMKGcIG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCD19D065
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688597; cv=none; b=bqI+ZYR2NnhvPR5lzXdyDlCFHdT5QwwiePNXJPiTwOfQaeDMabsKsEl168verIJCw2RmcFOCfRJTmmTFM8L+jHI+o9g94oHv8Vs2wyrFfYItBdE3U2P86KmD5VOIwtzyshiJyaiWLb+4ABg76Zn44j//yoEqRpnlQwy7tmnJkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688597; c=relaxed/simple;
	bh=U1lI3ZpBRuHXvUA3OHcz7g8g2Uds60issmg3Gfz9jbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN4Bmcq5h9lUOM/qTM1ulQgj8VyZ22+IFe+w6KC0WEgzabuR7P+2Bx3+BwwNpHf4i9YkowNJHGrFyk3xGGB8kNVylY1t85daK7P1OjbkBv5m7vDV+oA9PrSaAPjGh5ihcM4rfpe5XJaoIzMj0NzlpSMSZp0N/j8Q8/LYV15e12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JFMKGcIG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0418f6fc27so348006766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757688593; x=1758293393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qQb5KvZJBUUSlaKBevCwqp/YotLKMogK7EJGEORCSg=;
        b=JFMKGcIGPSl/1K0HT3bV9RrgJUvQNmRrHZk3UtuqPu83gGfL7OXwm84/KnjalhPv0G
         /qZKkDDlapZME3GqQQ/co0cKCCaJ7fWw/WxEUN2BSO14pVyno6t9SnD5/9bxyssuF8sy
         sqYgK0oFJCKTeFIDT2jMphAR/kXV96qUA5YRu6DxO/c0moSrFNZiK77yA1BP3wFM8hXe
         zz9WQM8ed6DReJuSopF28HQlD9v1Q6mwr2RZZYAU9K7jZPsYPc2Cyw4JXW3poOAX3tnS
         1p1FyG2j/0zjUiX9hpaeUXjeOgpocp+BogMaXPT4xXHqOLroLz8eVFcpYPylBozhQ7cG
         gFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688593; x=1758293393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qQb5KvZJBUUSlaKBevCwqp/YotLKMogK7EJGEORCSg=;
        b=q0iShGU9T/uRNCo4vZnJPmLz5WrjZe1kCRV+OnAokZrzQHDArj3Tupl79kbWErqAHo
         Q/WuF0UaVvuzfKfvpiU5pIChQg9LWjpmSJ7BM1f+TvZxmAsuzDeADKLQEYXI46p4tCQw
         LHgZFtQJ3qJ3UgLgAlk5jf9ZECUSFhJdGO0NcHfBq03yyXfJ0H/JInrNUFipwEKaeDMI
         v7SIKty8jniQ7+qPjJ4WqijrzFFl98sCD9lCJWhQHXzAC9JTw7wFaajfe44loJp0QeDA
         LzCaK+7Ms+saaTjAXsRk/CfCPfu8Ve92eWqTq5HFCHGIvUfuSWVxGQM9vig8X5Xga54O
         PKWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQQ8znyq/7DVWw+P19l1YxbXPuanvwYn99KW6xnvHdgdpA+fsvFMIb1vpTy1jaKq1LEBb6d26mc5MiIQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NRzra40xrSR/8l2K+X7nz5wM5pG9GEdjeCSQv1re9XI1ZB2j
	Ge3qVJp90jSORuuIjbUNkmbZ2X/7YZoLk81Vq29gjzTKWMoZEtNpRpbe1EuI+hsE3E2IHN4I3GH
	EcJFWWjY=
X-Gm-Gg: ASbGnctwRK4HgCI1nr7VCMF057dDWX5Is83OQiNz/VbtfI58D0zxP00UAcywt2i8Djc
	gNhSBJj4PvjQgJvQw1FCsnKi0e4ClcJ9ArO5v01dAbB+3pECEQ3FBmYUEr2s3T9PJYheJQtv2R9
	q8/hiv73LVVS5o2qdsSlxlmWvORHn60Fn76fl9XaS5q8mBsEizXNAaLgcoNjC/C34DvHQjziwVF
	wxjIeW1Q2LqgXFexYuh6/ed1Zn3GU5nHkWUSSjB3PtBBbNBV1vyeHY7c4P54t2JuY2wD9+CUW/n
	OVTCU7Ub7qOjUmqwIuML8Qx9M3LSOtGh5rHzbrH3GQEb1maSusBwg8zpTakyv1wCWUlj4x5zuUr
	kSd4fhlwSllrBk1TScMXdTDO6NMQTMgnQlkgf
X-Google-Smtp-Source: AGHT+IFFmpOq7PMlffPseBM6Y0xBmEsPODkNAN3DH4ybTp224pGOQG/0ISdNYVpaILhseHQq5vo8UA==
X-Received: by 2002:a17:907:944b:b0:b04:21c9:ad83 with SMTP id a640c23a62f3a-b07c3662cf5mr307093066b.52.1757688593404;
        Fri, 12 Sep 2025 07:49:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da4c5sm373993566b.21.2025.09.12.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:49:52 -0700 (PDT)
Date: Fri, 12 Sep 2025 16:49:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMQzD9CLP1F01Rry@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
 <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de>
 <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMPt8y-8Wazh6ZmO@pathway.suse.cz>

On Fri 2025-09-12 11:55:02, Petr Mladek wrote:
> On Fri 2025-09-12 11:25:09, Petr Mladek wrote:
> > On Thu 2025-09-11 18:18:32, John Ogness wrote:
> > > On 2025-09-11, Petr Mladek <pmladek@suse.com> wrote:
> > > > diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > index 2282348e869a..241f7ef49ac6 100644
> > > > --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> > > > @@ -56,7 +56,7 @@ struct prbtest_rbdata {
> > > >  	char text[] __counted_by(size);
> > > >  };
> > > >  
> > > > -#define MAX_RBDATA_TEXT_SIZE 0x80
> > > > +#define MAX_RBDATA_TEXT_SIZE (0x256 - sizeof(struct prbtest_rbdata))
> > > 
> > > I guess this should be:
> > > 
> > > #define MAX_RBDATA_TEXT_SIZE (256  - sizeof(struct prbtest_rbdata))
> > 
> > Great catch!
> > 
> > But the KUnit test fails even with this change, see below. And I am
> > not surprised. The test should work even with larger-than-allowed
> > messages. prbtest_writer() should skip then because prb_reserve()
> > should fail.
> > 
> > Here is test result with:
> > 
> > #define MAX_RBDATA_TEXT_SIZE (256 - sizeof(struct prbtest_rbdata))
> > #define MAX_PRB_RECORD_SIZE (sizeof(struct prbtest_rbdata) + MAX_RBDATA_TEXT_SIZE)
> > 
> > DEFINE_PRINTKRB(test_rb, 4, 4);
> > 
> > and with this patchset reverted, aka, sources from
> > printk/linux.git, branch for-next:
> > 
> > It is well reproducible. It always fails after reading few records.
> > Here are results from few other runs:
> 
> And I am not longer able to reproduce it after limiting the size
> of the record to 1/4 of the data buffer size. I did it with
> the following change:
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index bc811de18316..2f02254705aa 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -398,8 +398,6 @@ static unsigned int to_blk_size(unsigned int size)
>   */
>  static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  {
> -	struct prb_data_block *db = NULL;
> -
>  	if (size == 0)
>  		return true;
>  
> @@ -409,7 +407,7 @@ static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
>  	 * at least the ID of the next block.
>  	 */
>  	size = to_blk_size(size);
> -	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
> +	if (size > DATA_SIZE(data_ring) / 4)
>  		return false;
>  
>  	return true;
> 
> 
> I guess that there is a race when we need to make all existing records
> reusable when making space for the next one.

It looks to me that the reader API is not ready to handle the
situation when all records are "reusable".

At least, it looks like prb_next_seq() might end up in an "infinite"
loop because it blindly increments "seq" until finding a valid record...

Honestly, I would really like to limit the maximal record size to
1/4 of the buffer size. I do not want to make the design more
complicated just to be able to fill just one record, definitely.


That said, I still a bit nervous because I do not understand why
the KUnit test fails. It does not depend on prb_next_seq().

It seems that prb_read_valid() retuns success even when
returning a garbage. I have added some debug output using
trace_printk():

--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1856,6 +1856,10 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
+	if (data_ring != &prb->text_data_ring) {
+		trace_printk("  %s: reading from 0x%lx (%d bytes)\n",
+			     __func__, (unsigned long)data, data_size);
+	}
 	return true;
 }
 
@@ -1939,6 +1943,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	if (r->info)
 		memcpy(r->info, info, sizeof(*(r->info)));
 
+	if (rb != prb)
+		trace_printk("%s: Calling copy_data() for seq=%llu\n", __func__, seq);
+
 	/* Copy text data. If it fails, this is a data-less record. */
 	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, info->text_len,
 		       r->text_buf, r->text_buf_size, line_count)) {
@@ -2160,6 +2167,11 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 		}
 	}
 
+	if (rb != prb && r && r->text_buf) {
+		trace_printk("%s: Successfully read record with seq=%llu\n",
+			     __func__, *seq);
+	}
+
 	return true;
 }
 

The test failed with the output:

[   57.654444] KTAP version 1
[   57.654739] 1..1
[   57.655363]     KTAP version 1
[   57.655766]     # Subtest: printk-ringbuffer
[   57.656105]     # module: printk_ringbuffer_kunit_test
[   57.656137]     1..1
[   57.657997]     # test_readerwriter: running for 10000 ms
[   57.659135]     # test_readerwriter: start thread 001 (writer)
[   57.659328]     # test_readerwriter: start thread 002 (writer)
[   57.659626]     # test_readerwriter: start thread 003 (writer)
[   57.659827]     # test_readerwriter: start thread 004 (writer)
[   57.660008]     # test_readerwriter: start thread 005 (writer)
[   57.660209]     # test_readerwriter: start thread 006 (writer)
[   57.661648]     # test_readerwriter: start thread 007 (writer)
[   57.662040]     # test_readerwriter: start thread 008 (writer)
[   57.662283]     # test_readerwriter: start thread 009 (writer)
[   57.662539]     # test_readerwriter: start thread 010 (writer)
[   57.662833]     # test_readerwriter: start thread 011 (writer)
[   57.662841]     # test_readerwriter: starting test
[   57.662945]     # test_readerwriter: start reader
[   57.663072]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1519 size=1145324612 text=
[   57.663253]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1520 size=4473924 text=
[   57.663432]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1524 size=1145324612 text=
[   57.672125]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1526 size=4473924 text=
[   57.672322]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1528 size=1145324612 text=
[   57.675564]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1529 size=1145324612 text=
[   57.675761]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=1531 size=1145324612 text=
[   67.904538]     # test_readerwriter: end reader: read=14 seq=1531
[   67.905316]     # test_readerwriter: completed test
[   67.907023]     # test_readerwriter: end thread 011: wrote=0 by attempts=10260578
[   67.907974]     # test_readerwriter: end thread 010: wrote=0 by attempts=10271385
[   67.908929]     # test_readerwriter: end thread 009: wrote=0 by attempts=10281631
[   67.909675]     # test_readerwriter: end thread 008: wrote=0 by attempts=10266089
[   67.910571]     # test_readerwriter: end thread 007: wrote=0 by attempts=10278468
[   67.911294]     # test_readerwriter: end thread 006: wrote=0 by attempts=13344945
[   67.912009]     # test_readerwriter: end thread 005: wrote=160 by attempts=10290490
[   67.912800]     # test_readerwriter: end thread 004: wrote=247 by attempts=13351217
[   67.913499]     # test_readerwriter: end thread 003: wrote=294 by attempts=13337712
[   67.914167]     # test_readerwriter: end thread 002: wrote=281 by attempts=13373189
[   67.914858]     # test_readerwriter: end thread 001: wrote=439 by attempts=13283005
[   67.915980]     # test_readerwriter.speed: slow
[   67.916068]     not ok 1 test_readerwriter
[   67.916930] not ok 1 printk-ringbuffer


with the mathing trace output:

kunit_try_catch-1487    [000] .....    57.792815: _prb_read_valid: prb_read: Calling copy_data() for seq=1518
 kunit_try_catch-1487    [000] .....    57.792818: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (78 bytes)
 kunit_try_catch-1487    [000] .....    57.792819: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1518
 kunit_try_catch-1487    [000] .....    57.792821: _prb_read_valid: prb_read: Calling copy_data() for seq=1519
 kunit_try_catch-1487    [000] .....    57.792822: _prb_read_valid:   copy_data: reading from 0xffffffffc0255520 (17 bytes)
 kunit_try_catch-1487    [000] .....    57.792823: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1519
 kunit_try_catch-1487    [000] .....    57.793011: _prb_read_valid: prb_read: Calling copy_data() for seq=1520
 kunit_try_catch-1487    [000] .....    57.793012: _prb_read_valid:   copy_data: reading from 0xffffffffc0255558 (15 bytes)
 kunit_try_catch-1487    [000] .....    57.793013: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1520
 kunit_try_catch-1487    [000] .....    57.793182: _prb_read_valid: prb_read: Calling copy_data() for seq=1521
 kunit_try_catch-1487    [000] .....    57.793183: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (131 bytes)
 kunit_try_catch-1487    [000] .....    57.793184: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1521
 kunit_try_catch-1487    [000] .....    57.793185: _prb_read_valid: prb_read: Calling copy_data() for seq=1522
 kunit_try_catch-1487    [000] .....    57.793186: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (95 bytes)
 kunit_try_catch-1487    [000] .....    57.793186: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1522
 kunit_try_catch-1487    [000] .....    57.793187: _prb_read_valid: prb_read: Calling copy_data() for seq=1523
 kunit_try_catch-1487    [000] .....    57.793188: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (131 bytes)
 kunit_try_catch-1487    [000] .....    57.793189: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1523
 kunit_try_catch-1487    [000] .....    57.793190: _prb_read_valid: prb_read: Calling copy_data() for seq=1524
 kunit_try_catch-1487    [000] .....    57.793191: _prb_read_valid:   copy_data: reading from 0xffffffffc0255530 (87 bytes)
 kunit_try_catch-1487    [000] .....    57.793192: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1524
 kunit_try_catch-1487    [000] .....    57.801868: _prb_read_valid: prb_read: Calling copy_data() for seq=1525
 kunit_try_catch-1487    [000] .....    57.801869: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (107 bytes)
 kunit_try_catch-1487    [000] .....    57.801870: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1525
 kunit_try_catch-1487    [000] .....    57.801872: _prb_read_valid: prb_read: Calling copy_data() for seq=1526
 kunit_try_catch-1487    [000] .....    57.801873: _prb_read_valid:   copy_data: reading from 0xffffffffc0255558 (60 bytes)
 kunit_try_catch-1487    [000] .....    57.801873: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1526
 kunit_try_catch-1487    [000] .....    57.802067: _prb_read_valid: prb_read: Calling copy_data() for seq=1527
 kunit_try_catch-1487    [000] .....    57.802068: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (51 bytes)
 kunit_try_catch-1487    [000] .....    57.802068: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1527
 kunit_try_catch-1487    [000] .....    57.802070: _prb_read_valid: prb_read: Calling copy_data() for seq=1528
 kunit_try_catch-1487    [000] .....    57.802070: _prb_read_valid:   copy_data: reading from 0xffffffffc0255540 (67 bytes)
 kunit_try_catch-1487    [000] .....    57.802071: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1528
 kunit_try_catch-1487    [000] .....    57.805307: _prb_read_valid: prb_read: Calling copy_data() for seq=1529
 kunit_try_catch-1487    [000] .....    57.805308: _prb_read_valid:   copy_data: reading from 0xffffffffc0255508 (57 bytes)
 kunit_try_catch-1487    [000] .....    57.805309: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1529
 kunit_try_catch-1487    [000] .....    57.805505: _prb_read_valid: prb_read: Calling copy_data() for seq=1530
 kunit_try_catch-1487    [000] .....    57.805506: _prb_read_valid:   copy_data: reading from 0xffffffffc02554c8 (45 bytes)
 kunit_try_catch-1487    [000] .....    57.805507: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1530
 kunit_try_catch-1487    [000] .....    57.805509: _prb_read_valid: prb_read: Calling copy_data() for seq=1531
 kunit_try_catch-1487    [000] .....    57.805509: _prb_read_valid:   copy_data: reading from 0xffffffffc0255550 (109 bytes)
 kunit_try_catch-1487    [000] .....    57.805510: _prb_read_valid: _prb_read_valid: Successfully read record with seq=1531


It seems that the first successfully read record was OK.

BTW: I have added the trace_printk() "Calling copy_data()..."
     because before I saw that the test failed more times than
     _prb_read_valid() returned success. So, I was curious
     whether it at least copied the data for the seq number.


BTW2: It seems the even writers had problems to reserve space this
      time. Only few of them succeeded few times from many attempts.
      I the numbers by this change:

--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -112,6 +112,7 @@ static int prbtest_writer(void *data)
 	struct prbtest_rbdata *dat;
 	u32 record_size, text_size;
 	unsigned long count = 0;
+	unsigned long success_count = 0;
 	struct printk_record r;
 
 	kunit_info(tr->test_data->test, "start thread %03lu (writer)\n", tr->num);
@@ -154,6 +155,7 @@ static int prbtest_writer(void *data)
 			prb_commit(&e);
 
 			wake_up_interruptible(&tr->test_data->new_record_wait);
+			success_count++;
 		}
 
 		if ((count++ & 0x3fff) == 0)
@@ -163,7 +165,9 @@ static int prbtest_writer(void *data)
 			break;
 	}
 
-	kunit_info(tr->test_data->test, "end thread %03lu: wrote=%lu\n", tr->num, count);
+	kunit_info(tr->test_data->test,
+		   "end thread %03lu: wrote=%lu by attempts=%lu\n",
+		   tr->num, success_count, count);
 
 	return 0;
 }


Best Regards,
Petr

