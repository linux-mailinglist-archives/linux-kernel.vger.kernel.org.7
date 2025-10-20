Return-Path: <linux-kernel+bounces-860018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34EBEF245
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0204E9F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F341B87C9;
	Mon, 20 Oct 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edJU7Wfh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDD23C4EA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929602; cv=none; b=DLDAbx/wqFRczMwC5q2/upQG0M+UWzugiMtkFuYFa7qu5OR4ykCermYPNP7Wmh9uFhMjTkEkruy1eENKGd9F199/jlI2CR6nrxg4c1QA34GEMuqIMYcXzspNgS0Dhn7BYf5gqngFseEjnih1SzBSVI4V2bzBjW3R+fWDu3kLBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929602; c=relaxed/simple;
	bh=YBjpHWk/OjbuNVrw3LpJ4l5G/Z9oVIc1hegX9iwUI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzLBQoIvLIvXJ+6PBX0lTEpLqswkgNlj2kfZ5KTSTCdklQ4OHZ5FuAThswtfh/oZuD8kkljWColpqU2q2JCFfWDPzuPU1NXwZenK4E/231KWqOxpZI5eKxZ3BDmol9FH3h7kB4xwLkBSgwSBJgAQOpS5qKoMFqlXUTO8UokcWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edJU7Wfh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so774652866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760929600; x=1761534400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bPrht/7jsBGYQSWDd7TS53BYGn+Ml8MxvPS8eVQKrE=;
        b=edJU7Wfhc3rheRoyPXvBEYqHWKaZGPZzPY5B5aA4WEU4a3lAn/Cw+q9kXVPwyiNY7D
         EpYC205n7QpQn0LKfVImYHkuvGLHNfgeJuSToClzFC3WbfJkGcd5UYK2xVgamCtcpAAl
         tj+RyaC4dn7Y0AZ6FSCsgo4ziDdDuBcoK9Zjr3SMZhPNlSufj651FlEQlN/EMf3H+js8
         2+YHkdf7HX3sl4hLU34rAkH3FQhY5LqXWoqD3I31iSIcj0mieagsjyiWuck4/UK1ke9D
         /SrleaGVZs5ycYVirTUPgSHsiauoZW/lrHHe9r7oyHger6csV8Cjn17+7S10iX69Ead0
         8fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929600; x=1761534400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bPrht/7jsBGYQSWDd7TS53BYGn+Ml8MxvPS8eVQKrE=;
        b=dbzZD35qfQc4Nw3T0piWR/iWN9HjIo9Zlc6Tgq6WIDPbWDQ79zAxVPj7hMCgJDmHE4
         GqKt9GhMwOdBj54iZ+xqSR+WYk4m7ple2QdtDdSkJgqCktCQ3MDvjFsHn6ZbIBhXaeib
         /Q6xGql5uoqZdhQ0TqdjB4a4RkP0HJZktCx4NHhPP9Elt8uz4Swh244j8eMOnTWLq6h0
         uyiTVTCW8JdABPqmos68OgZHKSnLWx8LDSyspvSLWWRhGfhz/vRQdi1UEk28PzguPM10
         RZ7w6a72UcksX6LL9sOv069Z4imnck0g4WRtXpUCVQJz795w86NxQfEuwCJSXQhf/e9q
         Ev5A==
X-Forwarded-Encrypted: i=1; AJvYcCU4Y21IY30d+bXjF1GvTpHKIMLqga1xrNrJN1DIdP/333qk6/n9L/AR/IQ4tKJ2JIhEQTDpXdvzitB/Ruw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjcADt+b4zmlSH4/vKTRheTsfJkozZYoQdpvQfYD3+6xkJp2M
	g3q5R7dxnJBZyYTtTjwAof6yJ6IuNzCBQ491cmjqM+KmfeQAMPM2gkvA
X-Gm-Gg: ASbGnctDey1u2sFkv2ToRdAZ1nqqSaRVzDJvbvFjkv5Bla65Ye+esSbc9KuSckhVVsV
	rV6ldZ1or+ZjMMOGp16bGs/1UPwsoRf4oQLjqogzNSN3Nd0g7pgOVfnnMD/2xPXnuNFIfCRYEMQ
	exrZ8FycLGnMqXtTL8w55/72U5N4/UjWoDXwHd5lxncyPuiKlfSwkkva+vwbuL6G+vmDGpf6ioM
	vHKXkFD063etNHRPo+xpeKWoBOiZyklTO51j+bpmZVLEeGH2vgxRTWgLr04PflKy6X2pFE8RyL0
	pt1wzrHwAMUu32jKFErA7bAx8rAkKZ+8WqIQGFav6uaGGkNvRCsNicZG+2eFG1tG9j5D26Hk10f
	aAvNddZlqPbQ1f7Xg63bHvGttuXLpgdAzIikh+BWYowxvvmZPWekweoIn8rFaXuU7bam1xL5sFM
	o5GXDDsl4by9U=
X-Google-Smtp-Source: AGHT+IEQIa2Rgx7bzVTwOpdEVIvCqpvuq3SS6qfKghO3EwkdnvJIJZkgozXupmlLYPPkVsElcWnqkA==
X-Received: by 2002:a17:907:3fa8:b0:b32:2b60:eed with SMTP id a640c23a62f3a-b647500eb13mr1142751366b.44.1760929599453;
        Sun, 19 Oct 2025 20:06:39 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25c9sm668375866b.11.2025.10.19.20.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:06:38 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v8 0/2] Improve usage of 'ret' variable and make pcf_doAdress() void
Date: Mon, 20 Oct 2025 06:06:05 +0300
Message-ID: <20251020030607.10219-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series is a response to Change Requests made by Andi Shyti on
[PATCH v7 0/3] i2c: pcf8584: Fix errors and warnings reported by checkpatch
and more specific on PATCH: i2c: pcf8584: Move 'ret' variable inside for
loop, break if ret < 0.

Change Requests:
 -remove initialization of 'ret' variable inside for loop of pcf_xfer() as
 it is not needed
 -change pcf_doAddress() function type from int to void as it always
 returns 0.

Testing:
  *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
  top of 6.18.0-rc1.
  *installed kernel and external modules generated by build on my laptop
  *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
  *when loading the .ko with i2c_debug parameter an error is seen in dmesg
  and this is expected as the parameter was removed.
  *No success message related to i2c_algo_pcf was seen in dmesg but also
  no failures.
  *Module loading and unloading successful.
  *No PCF8584 Hardware was available.

Cezar Chiru (2):
  i2c: pcf8584: Move 'ret' variable inside for loop, break if ret < 0.
  i2c: pcf8584: Make pcf_doAddress() function void

 drivers/i2c/algos/i2c-algo-pcf.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--
2.43.0


