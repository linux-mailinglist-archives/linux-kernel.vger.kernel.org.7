Return-Path: <linux-kernel+bounces-748034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2DB13BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E15165E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFE8BEC;
	Mon, 28 Jul 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UD56bzIY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022243147
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710254; cv=none; b=W51297UxAmz1KPknC5jwQuCxyFFd6WZP02w4YZY8vPB+Z1ofDEgdmN6vjGIpEXFE4SNlacjEuvUdcuDXh4E986tabKJXKaZnF252yct22vVRk+6zsNVi9qHZZKoG2YXFnC2LDkVmteVb02LwyjZrOyQAd61AZwGNj3ipKUto4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710254; c=relaxed/simple;
	bh=su4CDo1Zx/MDVYD4tBXm+oYEvEdyMFDhJC+yOzR/FkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PmaHp3TyeeNsyTYPmnmAJgHv3mrNo4t86uR/ccXY3fcWS582DNgZ4OF+lP3RmYEWFyxLvELQrI3A9Vh7YU+DjObd4c5JZ2bovSQBLZa3VeDRRl8cfyJWEF148S1drsXWdIYZ32O4kKkp/ehWfx91EMyEwNF5086Yb1iMAtQFT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UD56bzIY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4555f89b236so36440775e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753710251; x=1754315051; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrIeEid5T15sP2bmZ2K6W0oyz6k1/QdANuHbM57Jiz4=;
        b=UD56bzIYPJs00JwnMFeODjsaidrlq3z2SvkAzaXPaLBo6YnsM5FJV9K8nCe4ftvdeZ
         uMPnXGXxWJoGi1J+Ldgu9ODIEAJ2k/8wt9pq5SktcxpNZkZrNFPWva6zz2zjSu6PQTBN
         z08rHZc2G8waYoG+K/6V7VMecl74CFYSrjBN+362/z1yLgXH6wCXJW9XGoTe6slW7nSX
         S+d5atTZI/R9UiRR/oJ2DTgYYuFM4yHM+1Xy7FiQil29ZtZaR9w3eGDIUFZdCiWo+WfG
         ADw1gmYmu/Ww9BdJqun6rhwDK5oQi9HCX2g8aHsy5BqlYNbJMOptLk/w/Jskib0LS8EA
         BfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710251; x=1754315051;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrIeEid5T15sP2bmZ2K6W0oyz6k1/QdANuHbM57Jiz4=;
        b=lrJsImjwmm8PE0TVoGd7Veko0MUNb4f6ZALHxmoALhJ7vvLIo4LLzB5wMzcxpM5XF8
         zJdVWkqU2oVs03Dlylop1ZZM3fYkSDvMdGsMpKrr+FDseOVceTJmPnOGpnDl/nxVrldG
         fnn8hxPewpA2n5OSANemxU9zZd7EvZY4GM2jCYUXtfval/4nr3Cy8JZIVIwYzdEl+OaL
         rCsxlXgRGSgOt5ZjVxgj6hTIteFBQ37ovUMaYhbnuw22GuJr1J+aeaYaXwW4j3B8Eb6G
         NeRO8GsRIl8D6X1paTtrB8Mw1yZznmiLlJeRHdYUUNzODVHFV1Z5TJp42m0UmfPVGqr0
         Pimw==
X-Forwarded-Encrypted: i=1; AJvYcCUuK8kq5QA7pVJBwnRT23YZdNVK92TaUyZi3PHDLwkRgXd+/9IJYBOaE5stQ2FcBLIeKFzG02NbXwg3N7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzub1N9rN4wgW/P60Lfof56yiK64AAAPZl41XkY7GTrApIEpFV+
	bXv3cJRGUyLpbcA7ea5Hra+buehUTmHMoV+ZoU2rQ9aTjvyGjA0pRIdlTHhJ/qunPCQrvEcKqU1
	T5hhXbJBg
X-Gm-Gg: ASbGncsglU8yEchuUuBITSn0fVuJGrhoq393z+rF2L5YTcsqs8MJ4FQR2rOtPo8Jayy
	lQSZb7DcpAExq9l8frF7SZHKCsSCME4C/fYkhChCRRniEIAN5PKcGi9+Eh2jcs6kOlXRShY5yRj
	J0qkg+DlLfajX8s/n0+RduTP/oTZE+0AEfxdqTcZ/kSfb8bgd0Jn3bWxteFFai+IT4irh221ykP
	YP2/3uXZkaHWsJ5MteIefdqiOzxVYwA3O9Of2zKmoU9H4TjqJw2OaJTfumXKqLfU7V/kNXcKm9O
	b7rZkBgL0U8pPY1fZYslXGMYFKyEZu3QUK9nByEESm/a3kPnNrtTaeZu8W6ONv89XmC5PQNmj+u
	QOc8GPcDa0UNrT+IP6+j0eHpiqJ1qsiEw7CHRKbr90JvLQhRS3RSJe3UdjfU=
X-Google-Smtp-Source: AGHT+IGH8BKLghgh+jT+3SxZRS57k0kDQ+wmtofkoLYv5wUmCJPfv2l6WQ2mCOYxIedsywIzk/iIdg==
X-Received: by 2002:a05:600c:1992:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-45876656c6fmr81389815e9.33.1753710250471;
        Mon, 28 Jul 2025 06:44:10 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:4524:5552:e4f3:8548])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705e39b1sm152270025e9.34.2025.07.28.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:44:09 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:44:03 +0200
From: Marco Elver <elver@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] KCSAN updates for v6.17
Message-ID: <aId-o3ijDLf38vtc@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)

Linus,

Please pull the below KCSAN updates for v6.17-rc1.

Many thanks,
-- Marco

------ >8 ------

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250728-v6.17-rc1

for you to fetch changes up to 9872916ad1a1a5e7d089e05166c85dbd65e5b0e8:

  kcsan: test: Initialize dummy variable (2025-07-23 08:51:32 +0200)

----------------------------------------------------------------
Kernel Concurrency Sanitizer (KCSAN) updates for v6.17

- A single fix to silence an uninitialized variable warning

This change has had a few days of linux-next exposure.

----------------------------------------------------------------
Marco Elver (1):
      kcsan: test: Initialize dummy variable

 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

