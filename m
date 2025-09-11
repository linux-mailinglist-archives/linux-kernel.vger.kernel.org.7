Return-Path: <linux-kernel+bounces-812457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025ACB5385C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F153ADCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542E338F51;
	Thu, 11 Sep 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J6XATnQ0"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89390265CDD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606153; cv=none; b=eQQZg64gp2HpKaMsH16qrAiREYX01V4//vcKdFWBwQl1minFTDbOxO2B1SMBnAoYT7kRNRHABwWga7D2xpudpoAc17doj6Qx2SBUtXPeFFWLzaGui6iePuxJxQHODNNZ/o4LmyZ2ug5POTd6eqBiTaRgrDN80Yisw43gvbVU4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606153; c=relaxed/simple;
	bh=5caI5z6boVJD8o3Qn0pwQ0J6yngyS4IHgtF1g+nxoWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Org7m0SwaKSMzjBZY0a1nVU6hMFU7GCcqbRQQtX/xpMTm+ZgyGzr9XEy7ZNAL2nRrhGUNScUd+kCKtpYbhFUA+Exd+rtPMPMz98rZ0lgH+WVv5rQxZ4BpSNmYOE1llfYIfids5Nd4SWgyIKqkSLXmUpPvgNjhDpABsPenACGAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J6XATnQ0; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso155397166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757606149; x=1758210949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ1xH/n+WEalzMjvlkdL2OhZWHiUBYRYpTYaB69REYQ=;
        b=J6XATnQ0RKVvBvO+WkzxoNe7uqsEQioQjL0b+V0gBzUulDhoTilgz4N9ODfPItsdcf
         r6XN13pyGyPCY+OnSEhTxAiLLKrCq/IZ5aqLr2bmyiZLWaSP6uYwnJnIdo0wgXjlUpgj
         n8qej3pvwGrQCtRCpxXj6QCN0AFh//I8Ux4Q4S/rzcVO8SoriCdpKENVQj9CfSy1ybjN
         aU+R1m0tpTXPfWmdwg0Dz90ayu472RB/5t9PII53/jvuq1IoN3aipbT2iLB9Z1fMrFCa
         wzIjtdqfClIrnhFICR1hgDyBSRHx3TGoF2u4TEQU1niGeDz+j2dBdMQjJUA4dAf2GLls
         wRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606149; x=1758210949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ1xH/n+WEalzMjvlkdL2OhZWHiUBYRYpTYaB69REYQ=;
        b=JfNa/MFkHiCCyJDVJ8ErTwlS3sSKmUoWPhfK6DXhI0dDSlklA2ttaR97G30qzUb8Wb
         p20YwKcOfi31bQAy+Dn8Hp+AOdrPY01/kxkYX+GAVr9OIq39iFriPFgirdU60VfTWnin
         MU++PRuhCuIcFJlEtCXGcGVmz4kXkiwJSElZwqkhXA8foJUK92s4FGasuqq/N84rX4QV
         bV+EqV2+kKRTsG0Eqd0p2GTX1dmLc657bpdifH11xoMJsMckP81TAkKzLA3XSr+Rlk0L
         dNcY+/d9ll5CWaNpxNjhgPwCqeYPytqAOc8BBXVpjOGi/Mi8ZuEdg0IrptSbfDJT83v7
         mTDA==
X-Gm-Message-State: AOJu0Yz9+RQFynBQ2mLsewczmHxo3eMtC4b7DoH1fWQZ9ygdcWZ8wjTi
	jJH5n21FWvmy/mnXMygdtzxc8BzQ4z/5ZPigcn2oOleopMXQcWAxROB+qMtVtvKzujw=
X-Gm-Gg: ASbGnctRqlbNZIrrN6MUkj3hUBfe1RtnddQFg2FNu6Og62k04L53yE8Q5SJu21WneWz
	im776JMWRzie4CWjRuVVTM7rzI64xGc4qVukBq/jfWIOugpzbl2/EtpDMNWOvxxx5OgHt//ELjM
	zJCIYMnNlwWIwhe2R4Bc9pw5bJkcoMKSyu9xxjdp4gIeKF1JF8869tnm+DlTQ4cUzhpfG1OPMGM
	nVUi6Mlc0tgydaOE8QAA19oSKGFP2tnpNsoN8tPiSeod3Vo54aJtJmUPsv4KiwmGzSROn9zfzVY
	QbH/yrm4NPThyBGDPgvweiQ3NyZiLkgcW79N8kHGBvzkgSSHAxU96pRqwBvhdRaKF09FDcqC5Gf
	wo6Pg6RnyUHI4NqSy4ZqGf+zoa9cvqfOqd7P8
X-Google-Smtp-Source: AGHT+IEQayCLlY4P9qt+koJf+eZXhLP1kss8EF5cNM+0QRAXJcyOYBHXk44saPdnU8CKSRcia5aXKg==
X-Received: by 2002:a17:907:d16:b0:b04:568b:8a42 with SMTP id a640c23a62f3a-b04b14bbbf0mr1983586366b.29.1757606148685;
        Thu, 11 Sep 2025 08:55:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm162094266b.86.2025.09.11.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:55:48 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:55:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMLxAlUgXpSs-tVN@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMLrGCQSyC8odlFZ@pathway.suse.cz>

On Thu 2025-09-11 17:30:36, Petr Mladek wrote:
> On Fri 2025-09-05 17:41:50, Daniil Tatianin wrote:
> > This series fixes the issue where data blocks would wrap in cases where the last
> > data block perfectly fits the ring. This caused whatever was at the beginning of
> > the ring to get discarded in this case, and the data block would get put there
> > even though it could be put at the end of the data ring just fine without
> > discarding anything.
> > 
> > Fixing this issue also allows to simplify the check in data_check_size,
> > previously it would ensure there's space for a trailing id, which we
> > don't need anymore.
> > 
> > v0->v1:
> > - Fix severely broken code alignment
> > 
> > v1->v2:
> > - Rename & invert get_next_lpos -> is_blk_wrapped
> > - Add a new commit for changing the logic in data_check_size
> 
> The patchset looks good to me. But I wanted to do some tests
> and it failed. I did the following:
> 
> 1. Applied this patchset on top of printk/linux.git, branch for-next,
>    https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=for-next
> 
>    I this branch because it contains a new KUnit test for the printk
>    ring buffer.

The KUnit test fails even without this patchset, see below.

> 2. I applied the following patch:
> 
>        + It reduces the size of the data ring. If I count it correctly
> 	 it should be 256 (2 << 8).
> 
>        + It increases the maximal size of the text so that the maximal
> 	 record size is 256.
> 
> 3. I built it with Kasan enabled:
> 
> 	$> grep KASAN .config
> 	CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
> 	CONFIG_HAVE_ARCH_KASAN=y
> 	CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> 	CONFIG_CC_HAS_KASAN_GENERIC=y
> 	CONFIG_CC_HAS_KASAN_SW_TAGS=y
> 	CONFIG_KASAN=y
> 	CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> 	CONFIG_KASAN_GENERIC=y
> 	# CONFIG_KASAN_OUTLINE is not set
> 	CONFIG_KASAN_INLINE=y
> 	CONFIG_KASAN_STACK=y
> 	CONFIG_KASAN_VMALLOC=y
> 	# CONFIG_KASAN_KUNIT_TEST is not set
> 	# CONFIG_KASAN_EXTRA_INFO is not set
> 
> 
> 4. I loaded the test module:
> 
> 	# depmod
> 	# modprobe printk_ringbuffer_kunit_test
> 
> I am not sure if it is caused by this patchset or

Hmm, the KUnit test fails even after reverting this patchset.
I havn't hit the WARN_ON_ONCE() in get_data() yet.
But the data seem to be corrupted.

This is from two runs:

[   45.808363] printk_ringbuffer_kunit_test: module verification failed: signature and/or required key missing - tainting kernel
[   45.820389] KTAP version 1
[   45.820682] 1..1
[   45.822088]     KTAP version 1
[   45.822387]     # Subtest: printk-ringbuffer
[   45.822729]     # module: printk_ringbuffer_kunit_test
[   45.822759]     1..1
[   45.824001]     # test_readerwriter: running for 10000 ms
[   45.825762]     # test_readerwriter: start thread 001 (writer)
[   45.826187]     # test_readerwriter: start thread 002 (writer)
[   45.826607]     # test_readerwriter: start thread 003 (writer)
[   45.826881]     # test_readerwriter: start thread 004 (writer)
[   45.827193]     # test_readerwriter: start thread 005 (writer)
[   45.827512]     # test_readerwriter: start thread 006 (writer)
[   45.827724]     # test_readerwriter: start thread 007 (writer)
[   45.827951]     # test_readerwriter: start thread 008 (writer)
[   45.828200]     # test_readerwriter: start thread 009 (writer)
[   45.828353]     # test_readerwriter: start thread 010 (writer)
[   45.828548]     # test_readerwriter: starting test
[   45.828553]     # test_readerwriter: start thread 011 (writer)
[   45.828575]     # test_readerwriter: start reader
[   45.828662]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=15 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x80O\x81\x88\xff\xff
[   45.835013]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=16 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x01
[   45.837261]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=17 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x01
[   45.837415]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=18 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.841872]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=19 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.844515]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=20 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.844663]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=21 size=1111638594 text=
[   45.844816]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=22 size=1111638594 text=
[   45.849842]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=23 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.849990]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=24 size=1111638594 text=
[   55.841113]     # test_readerwriter: end reader: read=14 seq=28
[   55.841869]     # test_readerwriter: completed test
[   55.846197]     # test_readerwriter: end thread 011: wrote=15338812
[   55.847027]     # test_readerwriter: end thread 010: wrote=13113829
[   55.847838]     # test_readerwriter: end thread 009: wrote=16786746
[   55.848469]     # test_readerwriter: end thread 008: wrote=14555662
[   55.849240]     # test_readerwriter: end thread 007: wrote=13117536
[   55.849873]     # test_readerwriter: end thread 006: wrote=13147885
[   55.850478]     # test_readerwriter: end thread 005: wrote=16799892
[   55.851085]     # test_readerwriter: end thread 004: wrote=14468908
[   55.851692]     # test_readerwriter: end thread 003: wrote=16795798
[   55.852311]     # test_readerwriter: end thread 002: wrote=15430923
[   55.852918]     # test_readerwriter: end thread 001: wrote=13106357
[   55.853645]     # test_readerwriter.speed: slow
[   55.853681]     not ok 1 test_readerwriter
[   55.854080] not ok 1 printk-ringbuffer
[  202.098871]     KTAP version 1
[  202.099389]     # Subtest: printk-ringbuffer
[  202.099901]     # module: printk_ringbuffer_kunit_test
[  202.100039]     1..1
[  202.103458]     # test_readerwriter: running for 10000 ms
[  202.105324]     # test_readerwriter: start thread 001 (writer)
[  202.106870]     # test_readerwriter: start thread 002 (writer)
[  202.107413]     # test_readerwriter: start thread 003 (writer)
[  202.107805]     # test_readerwriter: start thread 004 (writer)
[  202.108256]     # test_readerwriter: start thread 005 (writer)
[  202.108486]     # test_readerwriter: start thread 006 (writer)
[  202.108777]     # test_readerwriter: start thread 007 (writer)
[  202.109017]     # test_readerwriter: start thread 008 (writer)
[  202.109608]     # test_readerwriter: start thread 009 (writer)
[  202.110028]     # test_readerwriter: starting test
[  202.110039]     # test_readerwriter: start thread 011 (writer)
[  202.110054]     # test_readerwriter: start reader
[  202.110138]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=5 size=1111638594 text=
[  202.110279]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=8 size=1111638594 text=
[  202.110407]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=9 size=94 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[  202.110792]     # test_readerwriter: start thread 010 (writer)
[  202.111323]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=10 size=1111638594 text=
[  202.120582]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=12 size=1111638594 text=
[  212.257479]     # test_readerwriter: end reader: read=12 seq=16
[  212.258233]     # test_readerwriter: completed test
[  212.259613]     # test_readerwriter: end thread 011: wrote=13062252
[  212.260418]     # test_readerwriter: end thread 010: wrote=13059061
[  212.261766]     # test_readerwriter: end thread 009: wrote=16683360
[  212.262379]     # test_readerwriter: end thread 008: wrote=16680568
[  212.263016]     # test_readerwriter: end thread 007: wrote=16687096
[  212.263644]     # test_readerwriter: end thread 006: wrote=16646963
[  212.264265]     # test_readerwriter: end thread 005: wrote=16708452
[  212.264878]     # test_readerwriter: end thread 004: wrote=13065967
[  212.265531]     # test_readerwriter: end thread 003: wrote=13090840
[  212.266098]     # test_readerwriter: end thread 002: wrote=13074259
[  212.266695]     # test_readerwriter: end thread 001: wrote=13083747
[  212.267471]     # test_readerwriter.speed: slow
[  212.267502]     not ok 1 test_readerwriter
[  212.268136] not ok 1 printk-ringbuffer


It is interesting that it did read the same size=XXX values for
several seq= numbers. It was 1111638594 in two independent runs.

1st run:

               BAD RECORD: seq=15 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x80O\x81\x88\xff\xff
[   45.835013]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=16 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x01
[   45.837261]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=17 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\x01
[   45.837415]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=18 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.841872]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=19 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.844515]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=20 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.844663]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=21 size=1111638594 text=
[   45.844816]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=22 size=1111638594 text=
[   45.849842]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=23 size=217 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[   45.849990]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=24 size=1111638594 text=

2nd run: triggered by: echo 1 > /sys/kernel/debug/kunit/printk-ringbuffer/run


               BAD RECORD: seq=5 size=1111638594 text=
[  202.110279]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=8 size=1111638594 text=
[  202.110407]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=9 size=94 text=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
[  202.110792]     # test_readerwriter: start thread 010 (writer)
[  202.111323]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=10 size=1111638594 text=
[  202.120582]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=12 size=1111638594 text=


Best Regards,
Petr

