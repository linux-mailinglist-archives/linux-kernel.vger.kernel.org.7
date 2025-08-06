Return-Path: <linux-kernel+bounces-758356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2157B1CDFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C01725555
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39B2C1594;
	Wed,  6 Aug 2025 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="YpHbm9BF"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1432248BD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512923; cv=none; b=gvDgYefXQjRZW2GbjDlKHDpSlP1yH8PuWTaIXSIpV9zD3t4U3NQ0yd8y+r1FcAomcmSlA4fgOYFjpbWA0KNqgWLacRJZ1N3EHbROIQkNBrcwVMOpTfjqFX9ShxtOM0SzCLGmn/GSDYe/Ktbb0B9Se6bRqlb/K2OWGht7bGrMdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512923; c=relaxed/simple;
	bh=s0EOAdhvwrRlTuD+FHoFodK8InCyUlWc6YQvy46UQJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ab4lkeY9wBrv4OJ121fcJ5E4DEvhRzZGjmOelLXv510+izUvpAXm6peBNBv3cTEuozeIw32857L3/I23utpbZSyYWRob43diN3yBfSE9mUnBlOfv82QQZ6a57XlOw+xLZDXjnUFc2JGzuyhJqgBVWGq9Jpyjx2Buq29DutiBx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=YpHbm9BF; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30b79c7c918so197453fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754512920; x=1755117720; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9jp6N1K17uriKU9KeaR5LvyZhJOSZW9pDw85wt49U4=;
        b=YpHbm9BF1/TOfggrBBFzbOmq1XbfuO1byp4E/cC4W6q6WDxG7ELxYNmbYIP0q5y87R
         rn6RDmpcXnTpKBhZjX0hRwnSpB40VKSZELFV5CT+tMHQ/ryhPNJxRvEc0EWb4KfHTn7I
         F+tAHBXd9IUzAo6r/KGYLCpiQ2cXpp4a1uwChIvhdzTnZMOanATKQw4c/bNRKCoN/955
         sVgzSrZnbb31yjuXY5w3e+A3JF3tyuATOHjY7HJjhrEOGcLx4AZgufKmNcZSYG6oczuF
         vnWQQoIzqnvqqiwZih+gJr9q7jF7FHu4RD6S4R4rcEIx4qaeluBPBePVPq3JBKL8W1cO
         StgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754512920; x=1755117720;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9jp6N1K17uriKU9KeaR5LvyZhJOSZW9pDw85wt49U4=;
        b=taKULRXyZeSmdNCC//qslynvuEf2VP9ohxJvfnE3BrepogoqmiXTz09rfnS4/re+TD
         cu3o4LqdP+GsK/cKvj8IMZ8aXhpQ6rUdp+5GOHsqwpW59EaRBVHtX4WpxK4OBZiWg/iZ
         WXeM3U44VcR3ith/x4KyhCSC0vG9Uo0uvMy9kTw5FarRd+HMH5Up7imVRhOAxGVHU8wR
         M+3fr5XOKsBxWLpCzs2bx1+Mq9d4Uz1oVV7boXPMP1llvRoiCarfx8Z1ayD3KUP6QhYz
         z4rR5t9aYUO175mHpvYBXkfKZREcEM7DnUyGCM9lcpI+5Am0KLH3HHuI4GtomFMWBOBi
         qf8A==
X-Gm-Message-State: AOJu0YwOKoLC0xH9uToV4BfsOZxfF5WnC6qVnAe5g5InYh3XtILqp/fh
	7SqnvgRh5aQ4UuW9VjFjJ6XPSYKB0yF9XQXjPDwjBK+Xt/wEjONjzDVjV0aYwSz2ijM=
X-Gm-Gg: ASbGncskjNshH1C6K5HT7l+Qc81tr0GdeDbig8yPmrpyqgQsc4b51HFCAUoTQFVaWDA
	NVoLAn6NW5wZVFkP1lcta6jEIS0IqgQNeo+i5/60XpxiqLGgCewTlSS7NFjKEiHVgVCs47+pPgP
	Xosif51TQLupJ/vH6YRP6Xwn9cRvRIyeCMa/pmkMSxi9brUfuzTSFyYoIrnskvASdSlvPZQSyTI
	qsSQOwLu5frrgMGyF7804RhrMZtr2j7vlBDaVqwJPuyU+Hg3o1D0oLT+JCsigW88/v5gA8GMgzW
	kYAdmeeR2I/5/x1LHQPT4jvZFnNL7tuffmcVVZGDpmd2Tbn7HAqv8GDXGONKymxpDhK8wqPBquY
	FfzZMpzmErP4aSQ411YXMNOCp8w==
X-Google-Smtp-Source: AGHT+IFoFhRex+wbXgzoIwHX6xTHB5pmmR/VLnQuQPkYnmodJqbSE9/sZ7BwJArJLWGQ7WcpHBtyPQ==
X-Received: by 2002:a05:6870:5592:b0:2d5:1894:8c29 with SMTP id 586e51a60fabf-30be2bcb7b5mr2809482fac.23.1754512920213;
        Wed, 06 Aug 2025 13:42:00 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:bf4a:88b3:3a0c:4264])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186daca3asm3597075a34.48.2025.08.06.13.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:41:59 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:41:55 -0500
From: Corey Minyard <corey@minyard.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.17
Message-ID: <aJO-ExS1Zz-eMuZe@mail.minyard.net>
Reply-To: corey@minyard.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Something came in a bit late (the rate limiting patch) that I wanted to
get in, so I waited a bit with it in the next tree before requesting
a pull.

The following changes since commit cd2e103d57e5615f9bb027d772f93b9efd567224:

  Merge tag 'hardening-v6.16-rc1-fix1-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2025-06-01 11:37:01 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.17-1

for you to fetch changes up to ec50ec378e3fd83bde9b3d622ceac3509a60b6b5:

  ipmi: Use dev_warn_ratelimited() for incorrect message warnings (2025-07-10 07:59:43 -0500)

----------------------------------------------------------------
Some small fixes for the IPMI driver
Nothing huge, some rate limiting on logs, a strncpy fix where the source
and destination could be the same, and removal of some unused cruft.

----------------------------------------------------------------
Breno Leitao (1):
      ipmi: Use dev_warn_ratelimited() for incorrect message warnings

Colin Ian King (1):
      char: ipmi: remove redundant variable 'type' and check

Corey Minyard (1):
      ipmi: Fix strcpy source and destination the same

 drivers/char/ipmi/ipmi_msghandler.c |  8 ++---
 drivers/char/ipmi/ipmi_si_intf.c    |  4 ---
 drivers/char/ipmi/ipmi_watchdog.c   | 59 ++++++++++++++++++++++++++-----------
 3 files changed, 46 insertions(+), 25 deletions(-)


