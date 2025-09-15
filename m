Return-Path: <linux-kernel+bounces-817441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814BB58234
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781801B207BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1027D77A;
	Mon, 15 Sep 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmfuQ0tf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71813B1AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954203; cv=none; b=U08y+sIOCWAa6oNJEX3oeOWpJtk+GUU3DcF9kirncrj5oREepJ0Ox2uHwYJ2JjWIHB0VKBvaXmYsOSdqRqGyPjga7HjCL+TI2WIW7vwsWeLKfU+k0I8x+aEzoAFruVzJoOp6sj3/UGs06UVv4M9ugC+mZeiJyDprQgUa785rluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954203; c=relaxed/simple;
	bh=LmUDYigashfMZF6CZHcwIHmyuo0kJL6Jfg0MzEexKl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAwxn/P1KHlrIFo9WlDNGUnOdyMBnBx0DStvQPNDHFxwErA1NDQGQdlzJs20/fspd2PPxjwO22J6jD2kOew5Z3wcMZ/uv/7T9xxjqarQlC73RNyTxLXH+YAaTNozyX6wwBlU03rFeRX50Q7bOQWaVWiIPZcZM/0tTOd/lnI1XbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmfuQ0tf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2fa8a1adso7575415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757954200; x=1758559000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8HdgELhKqPV9nUMnND4gW+HT0yEwJDjyUHYZ5laZEk=;
        b=GmfuQ0tfdEC14TGHeWlrWZwwCeQylEtzu7Qujlk5GCexyvb2Y9SWvZ+TUntGer/jgC
         YrdB6Ali51ki8hdOCI++yBD4Rbil9rUMHj47VpsHBlIs3sPLnxn0eGWlkJmXJdRY7Nyx
         Sc3mzD4jsGjn0fKC224qFgNWfgDDrYWwTH5fH74ersFlBj3wH/TX6ueQCS9P3uvWeBkd
         sP4331cKCwlsZmOeeHTw3zUM7UNVFAAgE5FhUcLllLAs1OK+SfATTDT5UnKYnekN+oBi
         ql4itAwG2ss+V6AsiClcJaxwSKnP0H2Eupddvr0F7SIT6hocwQlQqsufar108ZMcexW1
         OCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954200; x=1758559000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8HdgELhKqPV9nUMnND4gW+HT0yEwJDjyUHYZ5laZEk=;
        b=Jm0B8hd2zTGFxhypjKIdiaj9Itm8WGCRMWk7d6PRpTt9rD6bEqX9z5niXsiBbkevMc
         /tEGIRbr5AsEJsa1M23Amr2oh6Z9Si6oFh+QeuZv8bLtzP60fkPQAxoYChEh3Uz5WwIT
         Q2VDw8mZNaNwxCZXwXevia07W+TZOMKsfNAHP5RZptp9JfESAq6+S7bG7gWtyKjuE2AR
         LGb48nDm+9ChVsaTnXR5+RzmvGJfOqCBafoWvLnsV8R3Q0b7wJ5PCplTD6ELmzgKH8EM
         be4RGekcP4r/1EiAQsQj9E6f+bxIdvvWH8PbzLpwgPIcXwBSIlHofnTcQmxa+ohnaVow
         a2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXM3haAEdD6uxUkOqxTfltrDNpalRmLyoZBv1WxBPogR7awXxmZj26CFLsrvC6wjV5noPNTEf8JJ88ER3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbINt05Mea2WD3HZiuD54pVmgjYYXTk9C6tV4WAYDG+b2Lq3Qj
	gT6IJXZjGYWRhjmH4B4jIjm8e781sMqU8J74Q2b2Og7h/xrH/6uUdfyt
X-Gm-Gg: ASbGncttPAe1FGPHF47148zrebp6RWrjJ8+dkPshLB7tYKqRcv+Laqb9t/1uHIBX+/X
	cM49L6iz5xZRji9tMga0NvOKQdKOzEaniqtxJayyXKQgIbwM4bZCqCoOFWI1021hwI79ukplx4W
	SgI8RqjqyV8BfaCQi1T+XcwGniuZXVuKS0yvAj+8T3FNmj0uge495JpErmiKThiVsfH9Fi9Hqwe
	0pt1G5DBVHseqLhD5d0nDKT/tfADJxjSJe9pLhFaAHczaKUfvVfDsW+QQM8xYRTc/u98lj705mx
	4ElMvgKrTPjgnm2tXcnZNRvSS7r8X9s2LoSsOKrsDrLq0x7pnFPAN8ZnmELHg3pfDK3WEmObCPj
	1CgpuZyW9Vcz2idU8aRDkMHxbY+kpWtNrPk1zUgQLLxKlPnYFhMJdexXlNX8YZZLQs+6FIvoiFZ
	VvxVLqn7duh60UBYDDCeUSWmg=
X-Google-Smtp-Source: AGHT+IGmi/H1It/1GPFQp8dQ47NqyEPOwZpWvVqqC9+daZXqWT08e6o60zckzEx8yfWYIt5WqEutxQ==
X-Received: by 2002:a05:6000:3103:b0:3eb:7f7d:af0c with SMTP id ffacd0b85a97d-3eb7f7db39amr2336521f8f.0.1757954199825;
        Mon, 15 Sep 2025 09:36:39 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8f4d644adsm9521728f8f.52.2025.09.15.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:36:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/2] pwm: rzg2l-gpt: Adaptation to waveform callbacks
Date: Mon, 15 Sep 2025 17:36:29 +0100
Message-ID: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Convert the rzg2l-gpt driver to use the new callbacks for hardware
programming. The first patch fixes an issue where cache value is
uninitialized during disable().

v2->v3:
 * Prepared as a series.
 * Created separate patch for fix for reinitialization of the cache
   variable in disable().
 * .round_waveform_tohw() do not fail if the requested period is too small
   but use the smallest possible value.
 * Added lock in rzg2l_gpt_read_waveform().
 * wfhw is reinitialized in rzg2l_gpt_read_waveform if channel is disabled
 * Optimizated rzg2l_gpt_is_ch_enabled() to avoid redundant reads to 
   RZG2L_GTCR(ch).
 * .write_waveform() returns error incase of invalid period for second
   channel.

Biju Das (2):
  pwm: rzg2l-gpt: Reinitialize cache value
  pwm: rzg2l-gpt: Implementation of the waveform callbacks

 drivers/pwm/pwm-rzg2l-gpt.c | 197 ++++++++++++++++++++++--------------
 1 file changed, 121 insertions(+), 76 deletions(-)


base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
-- 
2.43.0


