Return-Path: <linux-kernel+bounces-894373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB73C49E04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 281E94E6958
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C8721D5BC;
	Tue, 11 Nov 2025 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lw8sbVIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39921FF30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821112; cv=none; b=kjMEPNH/I+2UY3NVJiS5x1qtl2x0QSlxo0z3ib+9MBr/QyCFLo9tZ9GwU3NrrnAH6VhWupjxF25WTzeauDJEOZaWWnBzWuoj7T4b5mxiCMPnMdEIfZamGg+frD5nVmzI18U5t9kUvd51GKw59BNmkkO6gsamouMs/q99cyuAUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821112; c=relaxed/simple;
	bh=cYQLBQaZxF3PDY1Bc+YZDBeaxhR/L9lxTpKsjhBSIxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nox6RAwqFmN9okCpNp5U+7x2sHn5pqc6k8mw3k2IsQ4+9ouiIRC38TzPxyjDEtZ/CL0n0c15x3EahCq5fU4ZuLmduFEmRO4NSdKmts3w3epbp6lRtA36ghvRDuMHpNcl6PTXq3lTO5tk4ACgnCJ97zgvhUqT6IyF9+8HwVQRJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Lw8sbVIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB2C2BC86;
	Tue, 11 Nov 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Lw8sbVIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762821107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blb1/ciOhE2OCrxwXS6HsYPX1R17uPGtvigTRZqt6V4=;
	b=Lw8sbVIoKwDSgCntessMesWZJ9TnvAvG5TU770IJ/ltmICQucAdGouAaA/dvUie1aF8bAo
	N9vv5uTcHL8phqHXogZrjGMJ/nbmOapptUqssFQ3FaS8ulS9JJR0NibbmXzJFHslOUo4fV
	Zezz2+5Bd8BjNjRV+9z7gunC4tSkDe8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dd871144 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Nov 2025 00:31:47 +0000 (UTC)
Date: Tue, 11 Nov 2025 01:31:45 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: drop check for static_key_initialized
Message-ID: <aRKD8W999x9asNWq@zx2c4.com>
References: <20251110-random-static_key_initialized-v1-1-5343715a5986@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-random-static_key_initialized-v1-1-5343715a5986@linutronix.de>

On Mon, Nov 10, 2025 at 12:56:34PM +0100, Thomas Weißschuh wrote:
> Commit 77b644c39d6a ("init/main.c: Initialize early LSMs after arch code,
> static keys and calls.") changed the initialization sequence to call
> jump_label_init() before random_init_early().

No it didnt:

        pr_notice("%s", linux_banner);
-       early_security_init();
        setup_arch(&command_line);
+       /* Static keys and static calls are needed by LSMs */
+       jump_label_init();
+       static_call_init();
+       early_security_init();
        setup_boot_config();
        setup_command_line(command_line);
        setup_nr_cpu_ids();
        setup_per_cpu_areas();
        smp_prepare_boot_cpu(); /* arch-specific boot-cpu hooks */
        early_numa_node_init();
        boot_cpu_hotplug_init();

        pr_notice("Kernel command line: %s\n", saved_command_line);
        /* parameters may set static keys */
-       jump_label_init();
        parse_early_param();
        after_dashes = parse_args("Booting kernel",
                                  static_command_line, __start___param,
                                  __stop___param - __start___param,
                                  -1, -1, NULL, &unknown_bootoption);
        print_unknown_bootoptions();
        if (!IS_ERR_OR_NULL(after_dashes))
                parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
                           NULL, set_init_arg);
        if (extra_init_args)
                parse_args("Setting extra init args", extra_init_args,
                           NULL, 0, -1, -1, NULL, set_init_arg);

        /* Architectural and non-timekeeping rng init, before allocator init */
        random_init_early(command_line);

jump_label_init() was called before random_init_early() before
77b644c39d6a. And workqueue_init_early() is much further down, after
jump_label_init().

As far as I can tell, jump labels have always been initialized before
workqueues. So your patch is right, but the explanation is not.

What really happened is that e871abcda3b6 ("random: handle creditable
entropy from atomic process context") moved things to a workqueue, but
added the workqueue condition without removing the
static_key_initialized one.

Anyway, I fixed this up and committed it here:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=2db833312d7e6ae22111a6fd3e733b2a14986a29

Please submit patches against random.git in the future.

Regards,
Jason

