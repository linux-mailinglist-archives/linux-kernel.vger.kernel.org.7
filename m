Return-Path: <linux-kernel+bounces-836201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFEBA8FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE987189F70A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B72FF678;
	Mon, 29 Sep 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tarNqph7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A128725E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144413; cv=none; b=qNgAgQx5cT7TH0L7fRZPr0sSKz+/Yh4uHNMbsuSCvl1uYS2bDqx56uOLYPnrI7amWAKCRKNliMtE6r2hVZkD284WlHaks8ZqBYj7WLyb/Kt3C4rLAFipMbq093waC0wFR+UnCNoiwUYgxmOUssyhA1oOyPwL1fN4h6pH/Q0QThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144413; c=relaxed/simple;
	bh=eDAbDsuDWJBnFLwSXYate6997S7sXXMeDpcxPIwNhnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uQR10bJ16G9pTocG+SgevhQJR6ADk0BB64S/onuyywauwfCv+RupgwnbKTrsLYwcjft/vKpF3A9WHK68ICOQRsNreepae+59mIt/fUCKT0+ZURIgKsCKdVv6XypW/Ij/TSBZfiS9HdaMxTWTfo3bcHacvm3NKXx/G9CYUmOE2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tarNqph7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e4c9083a0so12454645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759144410; x=1759749210; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXO5GvU88t7UVH/Ib6wizEbX+5jKFC6htDrC7AhnY9s=;
        b=tarNqph7bPeo0Yr2/GmTQ9kswoHLU8eqokkrS3nCmVqAgyfu1jy+g6kvX8tEGUSrq1
         q0cLBm2M+AiTj/hCehc2QzDq3NP/8neFxOaEyt4+7dfAedOJkfFo2sc8UPEgbTpq2IIp
         rPvlAstQ7Xmdrnn/ICOu1ueyTj6Ikf/XB9iW1Hf7xhBbQZFfude/3+2UuxCspq+bJpVS
         5e05hhfZla/RHBJOWp7I44iUGHiCUg6GnriQtv0VPWU4vPuw0Q3It9dKVS6RMdBka/5e
         hNvCba7IXqVD48bWkNiV73d7ReaYteNa5bzK7QzrqTvF3Pihj3xwKlEbDBa1ZcfviItP
         YRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144410; x=1759749210;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXO5GvU88t7UVH/Ib6wizEbX+5jKFC6htDrC7AhnY9s=;
        b=RzGl7ImCnkQ8Yi2OL5W+TmCQzTNk8iCHMEU4OKjUumfqXjGBpPnJkKSYaqr0fqdSDp
         pCOHCRIOMTcVk5Qi/w8ESP13hLxYOxY/E8zLXlIg65miO8Ak3yNvNvLgrZOkN0Ezl23e
         Bam2b0hts3aUQreEb28NEmgBTDY7GLMglu8Dvr+hzWDJ+2sOnnX/DQ0afI39wR3hF09o
         pwW9OzRyR/gZl//EDZl/I9c/DyjWoKnVVhqoynzPLJFua9rYQ9CCUgyoJ+b6K03hsiar
         l6l0+Ma+u2cVLwl9wQ2E992evsxPGLQuc+L+gyO+4iK5p2S9cSQijeXRDpeTxF6UIn0w
         6wpw==
X-Forwarded-Encrypted: i=1; AJvYcCXIEUvWQ/KsKtOlY3kER1JoPJA/ei9aqy1F0oMb9E7BznRdNBW0T16MXUWB7iEd67whwIkXEqrMv8XqPtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEy/nV/Cj/aWiZ/Ht7SDFI/haU/Yi6oFS2YwJPHWW16qXKOrW
	S8zs674uc1eeW+QlqA0Yg+WX3yGXoWNLxbBgEkAQRd4xdugau6aW7MeaZiXNkvzyJQ==
X-Gm-Gg: ASbGncugU+D9fz+JvCfx1WD3bBMVy1SqCGajodafjrRFIoBM71JwfY7K5bGoP0PYwyA
	YkusXi41oPD89m+ErOuZPzAgrbx1Y59LrqHj5PoPfrY3UNpykLr9g9cR+Ezt/TCzao/YlbNOz6G
	lMGC7PVFHMo79iX7KipWpY4el665MQ2Po/Nqa3ZofE2OgNkdbWAG5hVK+YJGFjsLiD5MYG63lIr
	cFOY89/AZrPG9huBsvJtMs6ynCAvgkW6IfaE8cSJ5grRIIfOWvBkKFCVgHU7Z7PUZVw1W9XqChf
	ZL0h/grRvI9zTClLUXt+Gefs3cpL7VOUAEbiieYKwaJmXbKlp57ecGTf/IeK1ML6ZeRcXcN5KpS
	tncJnuTIdJ+CKp/cKoxbTq+fLWWRuFwBVePXPPnYoyMqi+uIHQ2byIZdy3amDcvUBgRp/MpdepQ
	s=
X-Google-Smtp-Source: AGHT+IFmDi44BJ5cSgRZdY6afUZLxSAzHtCSD2K+6yjJmz21p8UGgLN7RUrE90YvYfc39Fg4XPe5yw==
X-Received: by 2002:a05:600c:3506:b0:45d:98be:eea6 with SMTP id 5b1f17b1804b1-46e58aa2434mr2220055e9.3.1759144410179;
        Mon, 29 Sep 2025 04:13:30 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:79dd:ee6:d7a2:800e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm17729603f8f.33.2025.09.29.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:13:29 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:13:23 +0200
From: Marco Elver <elver@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] KCSAN updates for v6.18
Message-ID: <aNpp06-SzK-OOpUt@elver.google.com>
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

Please pull the below KCSAN updates for v6.18-rc1.

Many thanks,
-- Marco

------ >8 ------

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250929-v6.18-rc1

for you to fetch changes up to 800348aa34b2bc40d558bb17b6719c51fac0b6de:

  kcsan: test: Replace deprecated strcpy() with strscpy() (2025-08-19 12:52:12 +0200)

----------------------------------------------------------------
Kernel Concurrency Sanitizer (KCSAN) updates for v6.18

- Replace deprecated strcpy() with strscpy()

This change has had 6 weeks of linux-next exposure.

----------------------------------------------------------------
Thorsten Blum (1):
      kcsan: test: Replace deprecated strcpy() with strscpy()

 kernel/kcsan/kcsan_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

