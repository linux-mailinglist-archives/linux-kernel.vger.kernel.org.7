Return-Path: <linux-kernel+bounces-812410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D2FB537CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58441893DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21621772A;
	Thu, 11 Sep 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C79dluKA"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFFC17A306
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604639; cv=none; b=r9aUOAnBVR5kPVkDlQkuarBaKr7paNarfLONgR3OBTlGa/zCbnWC5OYrI2KmBihRHBXDeo39fYI8UcST0Wvqi3GtRm4MKiwXci4Y37xUjhAtNJ828/1egevjOVqI8AZ4OHtgI8JxYX3+HlwpEyykl07bWtvs3QVAt7yfcwc0Gf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604639; c=relaxed/simple;
	bh=tQOC6BQSu2y6RZ4P84SrhKEt6dZfHIQ08Yutxti0/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmINmJ2Q2wXcN4sPxnOVUlRRaYpqwm5Mn2xqRcpcbbZX1rHE4rTOZ3SvPGZjZJBI0cdBufpQvNYw9asyPuVNSmDP3dRL/uwmYKNQTqGS+vcSB7iF9JlHsxv+Y04pSiVdKqaTl5CfEZ2iY7PSkPLRSC5qagdvHGV3Ox//UIXRmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C79dluKA; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b043a33b060so128125166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757604635; x=1758209435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Sp0zUdCOW4iej6l6fFTWFmioq2xY1gAX3dIPC5XwA=;
        b=C79dluKAKT1E3YDz9Wfp7TZyo2XkY0YJ+OqYZZZmaYrN5QHNHnSC7zlZnFhjEc2/a4
         sb1GWPZdSWMHoLd5yHqmVhIcrl0yp3RUB96mlJ2vdNsv4HdKJnCVuKDL4hqNxBce+EM4
         1rzLtZsswZluiav9gFQYxe2K7o4cQAlDoeruAFpUzF4JXdozrNP4O+6c4dJwTVdnix6D
         5NBrfmX+BBqYVHAwqLFpOiEP91JkVQ//DNwlTpYCrLcdcWzL/f5QQIEBw+jgfEPIhHW8
         DOmPkFa2eWxSSGxasfffep/epH4c1OAUAawD4wruMXLBS5DMFcMdVtj9wcXDhyDsHude
         jsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604635; x=1758209435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Sp0zUdCOW4iej6l6fFTWFmioq2xY1gAX3dIPC5XwA=;
        b=NGIyjepMGCFcG4BrTsiOYWVQFtKyb2yhy0EFM9yUBPMf+03zRVJsM///xWGwG2bBmf
         YXn65lCjpz5gHIa2VPsc6odkSyAM+XLbZ17RtWayaAK4WJhko8V35f+ISKTWWyrMvc4w
         VdL/t7glVTz7Plwspe6k526JV9B0Fl40q8xTisEGOAgkpHYL2MZrSIOouA7NYLlKd8x5
         6/T0wTnWEHYCb4uuFIswKh83oTnq7yPPSnsn4FoyqvNeIogc8t/TDxbSgOuyYxpeLLqf
         lHwbsVdsA9v78XB4hD1cNzP05aP4o13tGL3kXjKwzzmophaRto/nVaI9DlH94t5AMhMF
         6YJw==
X-Gm-Message-State: AOJu0Yyp17MqhvvqSCEvTABlY8f2Uf/a250l8+rIZvzatvIB0V1ZXKe3
	Cdb9B2xVo/PMe32XGg2+f423ik97SzSBWM30M0RnsWHZCUpLkXHvrQkZV6XjVwJA+2Y=
X-Gm-Gg: ASbGnctDF5QliJUh/Dq4NNvb1zYqRQm3jgBzLWDKsMJ+PQmatP7uIJ/Mxc7EsXOhNnI
	Mq+zh+3AMKylMqTD2MAtfzv1sfpE8NqkOzm5J/5PIqs+sQEilo2A2OcQJBZZ3XEre0cF2MbbPQ7
	QCX7ERvnQLstNsY6+Gr3WVmKeSweL4selLESKqM4BOirCNVMQPpEMQKSMOERSku/KIN1viJl8VF
	r4OwQkPEnNcDk7KhvfE/O2+oJKL34X8FOHPT2GA26yT0tZB2IFS1cQaxQjXjJ3eyMmMsSrrQ2zI
	+Lk7QbREVxl381+Uup2m+C1CunR8erhnCJ4sDmS338K1ioQ8d3PYZ1SVOqOUAKcXKlh2sxGTna8
	Khj2rLypwZGH6qOJQKsa9AVXhdA==
X-Google-Smtp-Source: AGHT+IHza4kGOjbXheBD7QY+RqUA7ohhiIlwL515pPQe4VxsTf4qsPMXJzaJCY76G0Zg6BCNYhYmfg==
X-Received: by 2002:a17:906:9fcb:b0:af9:5ca0:e4fe with SMTP id a640c23a62f3a-b04b179c35emr1991460366b.56.1757604634733;
        Thu, 11 Sep 2025 08:30:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31292aasm156937666b.44.2025.09.11.08.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:30:34 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:30:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
Message-ID: <aMLrGCQSyC8odlFZ@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905144152.9137-1-d-tatianin@yandex-team.ru>

On Fri 2025-09-05 17:41:50, Daniil Tatianin wrote:
> This series fixes the issue where data blocks would wrap in cases where the last
> data block perfectly fits the ring. This caused whatever was at the beginning of
> the ring to get discarded in this case, and the data block would get put there
> even though it could be put at the end of the data ring just fine without
> discarding anything.
> 
> Fixing this issue also allows to simplify the check in data_check_size,
> previously it would ensure there's space for a trailing id, which we
> don't need anymore.
> 
> v0->v1:
> - Fix severely broken code alignment
> 
> v1->v2:
> - Rename & invert get_next_lpos -> is_blk_wrapped
> - Add a new commit for changing the logic in data_check_size

The patchset looks good to me. But I wanted to do some tests
and it failed. I did the following:

1. Applied this patchset on top of printk/linux.git, branch for-next,
   https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=for-next

   I this branch because it contains a new KUnit test for the printk
   ring buffer.


2. I applied the following patch:

       + It reduces the size of the data ring. If I count it correctly
	 it should be 256 (2 << 8).

       + It increases the maximal size of the text so that the maximal
	 record size is 256.

3. I built it with Kasan enabled:

	$> grep KASAN .config
	CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
	CONFIG_HAVE_ARCH_KASAN=y
	CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
	CONFIG_CC_HAS_KASAN_GENERIC=y
	CONFIG_CC_HAS_KASAN_SW_TAGS=y
	CONFIG_KASAN=y
	CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
	CONFIG_KASAN_GENERIC=y
	# CONFIG_KASAN_OUTLINE is not set
	CONFIG_KASAN_INLINE=y
	CONFIG_KASAN_STACK=y
	CONFIG_KASAN_VMALLOC=y
	# CONFIG_KASAN_KUNIT_TEST is not set
	# CONFIG_KASAN_EXTRA_INFO is not set


4. I loaded the test module:

	# depmod
	# modprobe printk_ringbuffer_kunit_test


And I got the following:

[  128.983916] printk_ringbuffer_kunit_test: module verification failed: signature and/or required key missing - tainting kernel
[  128.993363] KTAP version 1
[  128.993643] 1..1
[  128.994282]     KTAP version 1
[  128.994579]     # Subtest: printk-ringbuffer
[  128.994908]     # module: printk_ringbuffer_kunit_test
[  128.994938]     1..1
[  128.996142]     # test_readerwriter: running for 10000 ms
[  128.997243]     # test_readerwriter: start thread 001 (writer)
[  128.997545]     # test_readerwriter: start thread 002 (writer)
[  128.997767]     # test_readerwriter: start thread 003 (writer)
[  129.000142]     # test_readerwriter: start thread 004 (writer)
[  129.001086]     # test_readerwriter: start thread 005 (writer)
[  129.003865]     # test_readerwriter: start thread 006 (writer)
[  129.004125]     # test_readerwriter: start thread 007 (writer)
[  129.004329]     # test_readerwriter: start thread 008 (writer)
[  129.004584]     # test_readerwriter: start thread 009 (writer)
[  129.004896]     # test_readerwriter: start thread 010 (writer)
[  129.005089]     # test_readerwriter: starting test
[  129.005092]     # test_readerwriter: start thread 011 (writer)
[  129.011876]     # test_readerwriter: start reader
[  129.012639]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=5 size=1145324612 text=
[  129.014417]     # test_readerwriter: EXPECTATION FAILED at kernel/printk/printk_ringbuffer_kunit_test.c:80
               BAD RECORD: seq=6 size=165 text=DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
[  129.017373] ------------[ cut here ]------------
[  129.017927] WARNING: CPU: 0 PID: 1497 at kernel/printk/printk_ringbuffer.c:1266 get_data+0x240/0x350
[  129.018920] Modules linked in: printk_ringbuffer_kunit_test(E)
[  129.019628] CPU: 0 UID: 0 PID: 1497 Comm: kunit_try_catch Tainted: G            E    N  6.16.0-default+ #159 PREEMPT(full)  20fb7e6f689e04f2e29367f5d7a03c64ac29a9f9
[  129.021181] Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
[  129.021746] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
[  129.022898] RIP: 0010:get_data+0x240/0x350
[  129.023397] Code: 89 4c 24 08 4c 89 1c 24 e8 0d 21 81 00 4c 8b 44 24 20 48 8b 74 24 18 4c 8b 54 24 10 4c 8b 4c 24 08 4c 8b 1c 24 e9 9a fe ff ff <0f> 0b 31 c0 e9 6a ff ff ff 48 89 7c 24 08 48 89 f7 4c 89 44 24 10
[  129.025323] RSP: 0018:ffffc90004d2f508 EFLAGS: 00010297
[  129.025935] RAX: ffffffffc02194c0 RBX: ffffffffc0217780 RCX: 0000000000000b00
[  129.026729] RDX: 00000000000000ff RSI: 0000000000000b00 RDI: 00000000000009b0
[  129.027522] RBP: 00000000000000f5 R08: ffffc90004d2f5d0 R09: 00000000000009b0
[  129.028328] R10: 0000000000000000 R11: ffffffffc02177b0 R12: ffffc90004d2f770
[  129.029122] R13: dffffc0000000000 R14: ffffc90004d2f6b8 R15: 000000000000000c
[  129.029915] FS:  0000000000000000(0000) GS:ffff888193898000(0000) knlGS:0000000000000000
[  129.030800] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.031457] CR2: 000056180c2595a8 CR3: 000000011caee000 CR4: 0000000000750ef0
[  129.032271] PKRU: 55555554
[  129.032637] Call Trace:
[  129.032976]  <TASK>
[  129.033280]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.033849]  ? __asan_memcpy+0x3c/0x60
[  129.034320]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.034889]  _prb_read_valid+0x27e/0x620
[  129.035397]  ? __pfx__prb_read_valid+0x10/0x10
[  129.035956]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.036531]  ? __pfx___kunit_do_failed_assertion+0x10/0x10
[  129.037176]  ? kunit_log_append+0xb3/0xf0
[  129.037672]  ? __pfx_kunit_log_append+0x10/0x10
[  129.038220]  prb_read_valid+0x69/0x90
[  129.038688]  ? __pfx_prb_read_valid+0x10/0x10
[  129.039214]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.039808]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.040381]  prbtest_reader.isra.0+0x2ae/0x75c [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.041538]  ? __pfx_prbtest_reader.isra.0+0x10/0x10 [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.042779]  ? lock_acquire.part.0+0xc7/0x250
[  129.043308]  ? local_clock_noinstr+0xf/0x100
[  129.043862]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.044428]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.044990]  ? __lock_release.isra.0+0x1cb/0x300
[  129.045547]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.046109]  ? rcu_is_watching+0x15/0xb0
[  129.046600]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.047159]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.047721]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.048324]  ? __pfx_wait_for_completion+0x10/0x10
[  129.048902]  ? __pfx_prbtest_wakeup_callback+0x10/0x10 [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.050107]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.050728]  ? wait_for_completion+0x99/0x360
[  129.051253]  ? __pfx_migration_cpu_stop+0x10/0x10
[  129.051833]  ? affine_move_task+0xb41/0x1020
[  129.052356]  ? cpumask_any_and_distribute+0xee/0x130
[  129.052943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.053504]  ? __set_cpus_allowed_ptr_locked+0x362/0x610
[  129.054127]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.054689]  ? __set_cpus_allowed_ptr+0x1b1/0x2c0
[  129.055240]  ? __pfx_prbtest_kthread_cleanup+0x10/0x10 [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.056461]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.057019]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.057580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.058141]  ? __pfx___set_cpus_allowed_ptr+0x10/0x10
[  129.058738]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.059297]  ? kunit_log_append+0xb3/0xf0
[  129.059820]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.060379]  ? set_cpus_allowed_ptr+0x80/0xb0
[  129.060901]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[  129.061471]  ? kthread_bind+0x14c/0x1a0
[  129.061962]  test_readerwriter.cold+0xd3/0x244 [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.063106]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.063668]  ? lock_acquire.part.0+0xc7/0x250
[  129.064213]  ? __pfx_test_readerwriter+0x10/0x10 [printk_ringbuffer_kunit_test c283de0751f9c111bb1c6a71f2f57c1c47bab8d5]
[  129.065377]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.065939]  ? __lock_release.isra.0+0x1cb/0x300
[  129.066494]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.067061]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.067627]  ? lockdep_hardirqs_on+0x8c/0x130
[  129.068168]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.068732]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.069293]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.069858]  ? ktime_get_ts64+0x80/0x250
[  129.070356]  kunit_try_run_case+0x179/0x290
[  129.070865]  ? __pfx_kunit_try_run_case+0x10/0x10
[  129.071420]  ? __lock_release.isra.0+0x1cb/0x300
[  129.071995]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.072607]  ? rcu_is_watching+0x15/0xb0
[  129.073088]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[  129.073779]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.074341]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.074906]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.075471]  ? lockdep_hardirqs_on+0x8c/0x130
[  129.076016]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.076588]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[  129.077270]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.077840]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[  129.078529]  kunit_generic_run_threadfn_adapter+0x82/0xf0
[  129.079159]  kthread+0x3b0/0x750
[  129.079576]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.080165]  ? local_clock_noinstr+0xf/0x100
[  129.080689]  ? __pfx_kthread+0x10/0x10
[  129.081157]  ? __lock_release.isra.0+0x1cb/0x300
[  129.081716]  ? srso_alias_return_thunk+0x5/0xfbef5
[  129.082282]  ? rcu_is_watching+0x15/0xb0
[  129.082774]  ? __pfx_kthread+0x10/0x10
[  129.083246]  ret_from_fork+0x38e/0x4b0
[  129.083719]  ? __pfx_kthread+0x10/0x10
[  129.084207]  ? __pfx_kthread+0x10/0x10
[  129.084680]  ret_from_fork_asm+0x1a/0x30
[  129.085195]  </TASK>
[  129.085512] irq event stamp: 1867
[  129.085930] hardirqs last  enabled at (1877): [<ffffffffb56f82de>] __up_console_sem+0x5e/0x70
[  129.086858] hardirqs last disabled at (1886): [<ffffffffb56f82c3>] __up_console_sem+0x43/0x70
[  129.087783] softirqs last  enabled at (1134): [<ffffffffb55416b2>] handle_softirqs+0x502/0x6b0
[  129.088744] softirqs last disabled at (1129): [<ffffffffb5541982>] __irq_exit_rcu+0x112/0x230
[  129.089668] ---[ end trace 0000000000000000 ]---
[  139.039960]     # test_readerwriter: end reader: read=13 seq=15
[  139.040720]     # test_readerwriter: completed test
[  139.042049]     # test_readerwriter: end thread 011: wrote=13124589
[  139.042860]     # test_readerwriter: end thread 010: wrote=13101241
[  139.043667]     # test_readerwriter: end thread 009: wrote=16785932
[  139.044803]     # test_readerwriter: end thread 008: wrote=13123788
[  139.045626]     # test_readerwriter: end thread 007: wrote=16778106
[  139.046259]     # test_readerwriter: end thread 006: wrote=13119340
[  139.046857]     # test_readerwriter: end thread 005: wrote=16800807
[  139.047457]     # test_readerwriter: end thread 004: wrote=13136578
[  139.048084]     # test_readerwriter: end thread 003: wrote=16805445
[  139.048665]     # test_readerwriter: end thread 002: wrote=13156382
[  139.049232]     # test_readerwriter: end thread 001: wrote=16847574
[  139.050000]     # test_readerwriter.speed: slow
[  139.050034]     not ok 1 test_readerwriter
[  139.050497] not ok 1 printk-ringbuffer


Observation:

1. The test failed very early. The sequence numbers of the broken
   records are 5 and 6.

2. The record with the sequence number 5 has very high size:

       BAD RECORD: seq=5 size=1145324612 text=

3. It triggered an internal ring buffer warning:

      WARNING: CPU: 0 PID: 1497 at
      kernel/printk/printk_ringbuffer.c:1266 get_data+0x240/0x350

   It is the following one:

static const char *get_data(struct prb_data_ring *data_ring,
			    struct prb_data_blk_lpos *blk_lpos,
			    unsigned int *data_size)
{
[...]
	/* A valid data block will always have at least an ID. */
	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
		return NULL;

It looks to me that the ring buffer got corrupted.

I am not sure if it is caused by this patchset or
if the problem was there even before or
if it is a bug in the KUnit test.

It has to be investigated.

Best Regards,
Petr

