Return-Path: <linux-kernel+bounces-756722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED199B1B856
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B62F625D30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E350292912;
	Tue,  5 Aug 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB73Lyth"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF22291C3E;
	Tue,  5 Aug 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410848; cv=none; b=FCFShLdP/2HhvgX47poIQ7B78PN9UaKRMi6yytGYY6fBaaxJqeO35XIEU3nqVoCZhT4rob6Onjoxu+obXm1ZQokSZpP0FZZKVqQkiSdLehSLEdlptWbu9EQktJCLx7eqHc6NF0BCo/dmCMe4t0GvjmWhqzr9tv46VnM9u/TwPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410848; c=relaxed/simple;
	bh=kGu6ateMi7sVTdbqTnQdM6yz9XUdSnjZndgL63CO8s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaSoxKAKrZfdRclJhwZWZeNw94gGSWhmhRGP2dbG/PE0AtDB9bhYIiDFVO6lZFtCFHZRjCuLzv7PSHUMvv7Mhg7FG58Mnkhb1cYm2lVtB2gffxQ64pHjC1777zmUKmlbEnb1EP+5Di6wC++awLz/anz91plVynZtSOi/A0L+C/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB73Lyth; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4090548276.2;
        Tue, 05 Aug 2025 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410846; x=1755015646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPqctxuj25XobMQhW4L+Lm26tm0IYdYeYBgTx2rSnRk=;
        b=hB73LythZSc/aBGsDVxdWqA1ESfD97s75HwbYqmFZjwb0NGEJnxDWuUSiZrtPJbzYg
         DHGx3uWGxsobhzInuVPaX8JWiGloQoPoQR4N/dFTkyjZpOsGyo+bAYZtyWjjN+MVP9Zy
         PDv8DX7tx1Q76to8PcaIlptnals9QnnfVmtN7fx3phADZ3cjafgTZrQ1/J8oaCw/BfXC
         6/LoJAc74VSW3PlaI3bpeOvyp5UtdVxmkyomJB3XYE8Vwi7gZl1QRYhOiXrIjXugZ/uP
         N2XnHwz66Lz9W1EyICvDpMw2ZPuKf5k3UENyUXPeAQgoEnqhEAkR+Jxxt4YBnnanoMTY
         jmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410846; x=1755015646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPqctxuj25XobMQhW4L+Lm26tm0IYdYeYBgTx2rSnRk=;
        b=NodM+DyKCDtQMHC8fjC1hKppwkJr5HPgF/h6F706bklF/kWcEjCjD90QdVUEmSl+EN
         JzihQ2qzhAEx5SBi3zClrcZJLHzWmvRMzQAH5uIg7QVOgycghKK31h/nn/w1/KoEjumg
         2q+/Hf/kJ8HJvsS18zcgFIwq10zLYFdwLcRGa7bHqiY5vDOGnjEVnKCv5B1MfJpncx6o
         /G3Nq8vTH5EecuN32Mlc/c52rXgCWTIsJ5g1laPbALvCQvNAlkEEFhRXpCJsvLDR1LYN
         hLDZCfJ+IUTFqteN/epRr7IqyFZKd43nDP61WWNaCNRkFkWH+N0rkGi+YrljznB6CBFC
         U+1g==
X-Forwarded-Encrypted: i=1; AJvYcCUiAJ4Xe1GH+PwkC6zW/hCn5R0ZHAhqmEAwug4G5ufawTOTan/2Ysfl/gX4AS32pMyy6x9Ah2kiksc=@vger.kernel.org, AJvYcCXj5liRTEydmLxyyx1frm3v9t73INThA0AeP6mPtqrcXnNaMZovd3EzK/3MSZQzmh7b55LR8tY1JaM/ZJoO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0NetwVx9cTKqoPMdEOCRtxWZKw+3/cN/EIwb5pkMFvIEWb/px
	HaXCbZTise1RSc+wbYBY5I+dkytSi28gp89K39oYWRRP0ZYQgBrIBWkUgDevwg==
X-Gm-Gg: ASbGnctyvz02Tt3QqX9wfiNlhIJ8JURZmte7l5iCOW4XFjQ9IIRLXnRtcfdXDYTCrfo
	gHLUaRmcV351ZqpNMG3iafRGsLZTqsYzIUKOcj0Sm477bVJXS/oQTuziT1A2ADxU3PL84C+HTpC
	bB+HB7B8JJVeRFZWAueu6MjJ0Ce3aYc0CDkfPL2LfynV/vTcBq23x0yD2+cK7Vi3ooElJEvUrH0
	ZgSXEhEBMZEuctQNItRqmvAocnA+Bir4clO2TnL7j2YEuLAWHJ3E37FN1GT/1+a6x4S3FxaQJQu
	g6Q3SWbxlKBB5br754+Rp5Zb48CoS1dVcQdtJtUsIULa6aOrW+awQ6PRAUwB8c9V/bcKRnaJmHZ
	XkUSi2iyTyYUAKQtafIMFHqccuiVsXchZO37bdHVUhdH7dtyHIKqx0Q==
X-Google-Smtp-Source: AGHT+IE88seSdzpVdkIzCqTZrsRMzATgLnxXnAhDA3siqgjEUV7PlZGlyUYJyltEuCGK7VDVUQpqGg==
X-Received: by 2002:a05:690c:a0ad:10b0:718:96c2:b426 with SMTP id 00721157ae682-71b7ed887c8mr121416667b3.15.1754410846171;
        Tue, 05 Aug 2025 09:20:46 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:45 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using migration dests
Date: Tue,  5 Aug 2025 11:20:17 -0500
Message-ID: <20250805162022.4920-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patchset adds two DAMON commands, commit_schemes_dests and
wait_for_schemes_apply, that I have found useful for using a migrate_hot
scheme with migration dests.

The commit_schemes_dests command, similar to the existing
commit_schemes_quota_goals, is used to commit only the dests fields of
schemes. This has a couple of benefits:
1) It is more efficient than recommitting all the DAMON data.
2) Doing a full commit resets the aggregation and ops_update intervals. If
a user sends the full commit command frequently (relatively to those
intervals) the aggregation and ops_update events will be prevented from
triggering. Having a separate commit command side steps this problem.

The wait_for_schemes_apply command causes the calling thread to wait until
all schemes have been applied. It does this by calling damos_walk() with a
NULL walk_fn. This can be useful, for example, if a user wants to know when
new scheme parameters they've committed have been applied. Another use case
could be if a user wants to record the system state every time a scheme is
applied for debuging purposes.

The functionality of wait_for_schemes_apply can be achieved with the
existing update_schemes_tried_bytes and update_schemes_tried_regions
commands. However, having a separate command avoids extra work and makes
user intent clearer when used in scripts.

The first two patches implement the commit_schemes_dests command.
The third patch implements the wait_for_schemes_apply command.
The fourth and fifth patches add documentation for these new commands.

Bijan Tabatabai (5):
  mm/damon/core: Add damos_destroy_dests()
  mm/damon/sysfs: Implement a command to only commit scheme dests
  mm/damon/sysfs: Implement a command to wait until schemes are applied
  Docs/ABI/damon: Document new DAMON commands
  Docs/admin-guide/mm/damon/usage: Document new DAMON commands

 .../ABI/testing/sysfs-kernel-mm-damon         | 21 ++++----
 Documentation/admin-guide/mm/damon/usage.rst  |  4 ++
 include/linux/damon.h                         |  2 +
 mm/damon/core.c                               | 12 +++--
 mm/damon/sysfs-common.h                       |  3 ++
 mm/damon/sysfs-schemes.c                      | 35 ++++++++++--
 mm/damon/sysfs.c                              | 54 +++++++++++++++++++
 7 files changed, 116 insertions(+), 15 deletions(-)

-- 
2.43.5


