Return-Path: <linux-kernel+bounces-894018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4990C49177
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50E42348F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F37B3E1;
	Mon, 10 Nov 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2VjVHLy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1731B810
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803407; cv=none; b=FW00sLro2EGxrmReR2o9Nf8xvFDzvymsAkvZEeznqrWbHXWKNZ3daLd/k/JTKBMmQ3WmGEXrUda+t60mojtsM04d2lz+YXzBsHowmWN631WJmn1m1BlQ6P1dLml692YcGopSCs6S/KqTI6pMm3YumlMvZUiKqPgXOE3yu0RSSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803407; c=relaxed/simple;
	bh=uOPdRM2zXUbj0uAF4/Y1KdXhAAYdQVcF5zz7omcQwNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIv/u36gthL3ed42kaLMhvj6C08eVpLKsiBHLJxx8EfY/dfRtSGgOeBwpPzkpYRAO0qza95O6mX/jgp9G7abyYGX0dG3jrRwukSFx2QLvNNFeASNHbAtlUZz1bAyqTkdotA1rL4D73qtLx4hI6OPJucj/ygF27bi/AUyKi1b3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2VjVHLy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47758595eecso18052965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803403; x=1763408203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDpt0zy7PtnsCd6fKg/NI/I37lccoSys25WO0LkUemM=;
        b=H2VjVHLyJvbeTUJmvaX6D1/Mk5MMIzvGOzaQ0YqgDPSWmjLUWywvO7mHfVQVCldqig
         FdYnboyQqE7doRR1hyBJx7CVkbvbgNsg3Xz1/fkOoodMaZhFarOWw3geJOxwLGXTnTKc
         funqi5dWl05SbdIRZ2bWB0GgackLEXXsk8XSH9QPK5PTY5ZXIlOY0v1S2pKYcBi0KZL9
         u4LEJt1P6dfaUAMwXJgZaVwVN4c4jei3eQes4nZ7cX4eV5mPjJ39f7JcXcm0LqCMkwTK
         Nll6ntBK/xDWfEyF7iBtf+rK2TOlIfemg+tIQDboywb39uqAWYHQ1QdTCgE5vtqmRosW
         Axxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803403; x=1763408203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDpt0zy7PtnsCd6fKg/NI/I37lccoSys25WO0LkUemM=;
        b=Vk0NTkmV1s0TKx7/wvpHgMUhcPBWQl/KYHGBEJP1Nz8cZa5Wxr3We8XgLdP6oTTwjG
         vIcCWVaAGkcEDjYZoz4uW+IhprbST980MpWNArS46jm1eY1H0F2MnPxOgY1/pQdaW6R3
         1ViPpgdwOtjF8vV1Yg6W11TdSBDSl+eEztNWf3XWABHByF0AqjsEerkmSzoQog5JgT6e
         tYlSOAFak3V2opvWMneeTVm4vnQZZtTL6RvTWv/5rJFo1eGdJTKpG/vtpuuzWRn23YQ9
         2/H/3UVBYb6T1LAuPQjdZN0a0M2fXZxJ5D4AhksXRkr0BwwWRe8aOO0jTsNd1iNGMBlc
         82tw==
X-Forwarded-Encrypted: i=1; AJvYcCWiWUF3nmOnpIaEKzoE5ROyRu1JSknLj1MgxVDuEiGmU1Ai1ksVL+8w9Rzvb0CFMwj3lnCoM9srmBfc2og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3Ra4dgw/r9om48N+LXqW7EkoBya5t+NXHAZ6/c62LkNgEnuz
	75y1C63NWUGE8ueR5TjALUhPAoD+/K4Xa3WGsLjvaSY0X6ES6wk5Qpc5UG4PPMq20Gw=
X-Gm-Gg: ASbGnctjIBKX9Q+RHUlLPWTlzau3gyRZuAW2aF9hx0x7Q/XKmfV1EEUGGVmnPhXKK+9
	ln0OAmaJVQ57ygpne9pFwgucNycznmvhU/BbkZto7ebhNdjeHVybY1bCGrJgkmlIQhnNo5A24rY
	ItyaLGpvUttK8sH+odow9SstJWqeAEFJOwzJ+CegyCxD0dv6yck79S2o9Eniaw0uZSg3rX9fAST
	XK7pCRBObMd/ll59xMTmknBGNkSS88na+OuewcS1c1rw24NBsQKjrEdbiTCaR/3veqhSU7O5+5i
	N4ty4dwHsehIxvQL4a4Xd/aUbkAZAIfGwTVDykB/8qrPnRkn9KiQaUUcqzyRg6i4ZKCMLHuKi8Y
	/n/1+P+Y2AWuoFUhUgvNKNhyH041c9JofYZDrkLS96PtAbVX5lZe+tQoIFC6tCe9h8YpHTRAwnL
	plVv3W1HEDSxan20i/4byyqHOUotrpoVU=
X-Google-Smtp-Source: AGHT+IHeuLkKSsH8AzcRusY4bSGEmMJr+yCrFo1Kif3KcLfYiwCAAN+hODaeTCLagsz7hdm8X9yqTQ==
X-Received: by 2002:a05:600c:3b01:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-47773288bf9mr97918675e9.31.1762803403412;
        Mon, 10 Nov 2025 11:36:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:43 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND 0/3] Memory reclaim documentation fixes
Date: Mon, 10 Nov 2025 20:36:32 +0100
Message-ID: <20251110193638.623208-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think the reclaim target is a concept that is not just an
implementation detail and hence it should be documented how it applies
to protection configuration (the first patch). Second patch is a "best
practice" bit of information, it may be squashed with the first one. The
last patch just makes docs indefinite until the idea is implemented.

Originally sent in [1], this is rebased and resent since I still think
it'd be good to have the concept somewhere documented. (E.g. for the
guys who are implementing protection for the dmem controller [2] to
arrive at similar behavior.)

[1] https://lore.kernel.org/lkml/20200729140537.13345-1-mkoutny@suse.com/
[2] https://lore.kernel.org/r/20251110-dmemcg-aggressive-protect-v3-5-219ffcfc54e9@gmx.de

Michal Koutný (3):
  docs: cgroup: Explain reclaim protection target
  docs: cgroup: Note about sibling relative reclaim protection
  docs: cgroup: No special handling of unpopulated memcgs

 Documentation/admin-guide/cgroup-v2.rst | 31 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)


base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
-- 
2.51.1


