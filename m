Return-Path: <linux-kernel+bounces-840153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10BBB3B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711D43B0915
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3130DECB;
	Thu,  2 Oct 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LDljzedV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC624149C7B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402444; cv=none; b=i3xKi0d9Og47Je7i1iP39KYpHFeLpkejrpREVdXJtT/VJ6qF7ujrKRW2RAz/6zsZMNP8CPgeCtidxtvHh2ephXkNBimmSd00KbD5nqGwMFao2YlYrPn9SwMJpZAY7g4Ove0dwYEM5ZqqlkfiUmxw9lBgLHAD7yvo32X+/NpVLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402444; c=relaxed/simple;
	bh=EFck3o1xCNgBLqNJlIjuFYEf0il2tIbNXe1Zggh4tpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEHE4apfzxrHlwAQBemCPOFmpknGx9TRPW+qonudWktK2JTNwPbvgHVQdykoBwIrak+xGyscTOslLUxYlyYbolh5H8psjlgjTajB4fCaYk4OYtwj+xCinqInf/QDu9XGdYFpmz+vrZho3lxnHmorxiti3qhsKlyYZfkaXSPKjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LDljzedV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so1336288a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759402440; x=1760007240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA32bUeNOiRyndxLIyDPAfp2EzZpRsh1qJqivzlVI5o=;
        b=LDljzedVf9nBy1v/hTlL4gFW22rRGH3s2L/BhQLzzKPYmLQ6J/IgUnvqVYvtbxQPnc
         91TMIek89KB0ENS9jDepWvfyKc1Ml2TYG/jK0RqzMfmsp5VNR8yVNuG+ouSrTxRhKuR7
         j9nNhmhP3tP4R/gjE6AYYOfg8l45Nc4bm35n9PMEaP9kgqp93l4RXu/XYCMg2oI5Zqah
         gk8sqAvYR7wQd3Kkcwb+TKSzegTUcI/iD7IU+6+yeFtE1Lxmi4RKXXGFAUyj3ycqJsDj
         Ruwbc5FWwTDfVvAVMV9ny4A3/Nk5E6F0dkKuzsTbaRp51UkUi9Foe5/JiTy/oMsrR6O1
         TzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759402440; x=1760007240;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA32bUeNOiRyndxLIyDPAfp2EzZpRsh1qJqivzlVI5o=;
        b=Au3Qm2rkPc6EuGcd6uB+sj3tNOLEUJ0EITA4Scw7BXUYsJFF9DLOrFbF+dRYkkMG7M
         wkcrbnWvX1cyb3lJt0xI92ttP1bWQlRJxiKh5KrsEDYlEJ3jaJcMTSr0R9pu2egLR8rw
         LLsXN16YzhiDM8wqXfHfbelBX5/CzmVM3EcXFIPWvuypGgAQFa2h7QFMN+LMSDuMqDWX
         TX5RQppx2xRMLQsk3pbG+IwRvad3Mf9aWgUQU1NNaFWg3pHMOd6Sl9TTQIvOJxZZhgNE
         OvA7CGLahjDAAgQniNs2uarDApbyB0n/K9PMYlneBhqowxZzYidj84XDHoWik7npVSK2
         yAqg==
X-Forwarded-Encrypted: i=1; AJvYcCW5oEt1ONzfsZ1n9xBYlsYgUgbvh39E+50saNOSjN/SeqhzhDL6Oxagq5tW5ThYpVneW0sVE5w2W2iiJPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcjBXRrwHCjpCHW2yMguG2WstPp8LezDNA9vqtAFmGjBwnLt5
	2168vWNH6hH1NJRYwlLuTOFMS216VhdcMcutZ+s+lvhfw7C7G+osftY6iIKw1ScfsCQ=
X-Gm-Gg: ASbGncsReznzSiQOP9c32iSJaWD2W8LgQtfiVjIzrdlWec5PeV12SLxS7dSdr73ODM/
	eSrI6ki7zkH1FBcIctpnD6NYuX72XzcwKdbtebE7fbLGDOvKfiNVqQCxnWEg6zBfv9NGa7llxNF
	uedkw84LQPfxkl8rJPGshWUeMhLydB8WzehsB9kSEbFstO7iIuq6g1rm4UeHiyHsxA2hxec5XO9
	K1xUrIa2PPuvFt3ao8PgPm9j2QaoncUaS0rb5SCDuwLXhytaYKPCr0LG2Ou7Xi2/Y8RMtWGy/Ot
	1m0uXZGbJT71G5y/fUZNaUBkzhPfpNTNtbEWW4ls+HBG1kYJc0wKKdEcdAcM0+fSTH1Bewn338+
	QCD2Rqv9SAzLbW03f4d8nEG3lP30rcNRW7jn3oNMRd+t9QyjD8g==
X-Google-Smtp-Source: AGHT+IFJNPRCGhC7AUdTnuBPi1vd4+LzD8SWu9VIcx4ULGaM8y9ZM+mmg2jlpGSdVPuU4OMiPm8pmg==
X-Received: by 2002:a05:6402:d08:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63678c9f53cmr7090551a12.37.1759402440230;
        Thu, 02 Oct 2025 03:54:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6375eb397fbsm1600921a12.0.2025.10.02.03.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:53:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:53:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.18
Message-ID: <aN5ZxYK9vUfxXyEv@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.18

=======================================

- Add KUnit test for the printk ring buffer.

- Fix the check of the maximal record size which is allowed to be stored
  into the printk ring buffer. It prevents corruptions of the ring buffer.

  Note that printk() is on the safe side. The messages are limited by 1kB
  buffer and are always small enough for the minimal log buffer size 4kB,
  see CONFIG_LOG_BUF_SHIFT definition.

----------------------------------------------------------------
Arnd Bergmann (1):
      printk: kunit: support offstack cpumask

John Ogness (1):
      printk: ringbuffer: Fix data block max size check

Petr Mladek (3):
      printk: ringbuffer: Explain why the KUnit test ignores failed writes
      printk: kunit: Fix __counted_by() in struct prbtest_rbdata
      Merge branch 'rework/ringbuffer-kunit-test' into for-linus

Thomas Weiﬂschuh (1):
      printk: ringbuffer: Add KUnit test

 init/Kconfig                                 |  12 +
 kernel/printk/.kunitconfig                   |   3 +
 kernel/printk/Makefile                       |   2 +
 kernel/printk/printk_ringbuffer.c            |  48 ++--
 kernel/printk/printk_ringbuffer_kunit_test.c | 327 +++++++++++++++++++++++++++
 5 files changed, 378 insertions(+), 14 deletions(-)
 create mode 100644 kernel/printk/.kunitconfig
 create mode 100644 kernel/printk/printk_ringbuffer_kunit_test.c

