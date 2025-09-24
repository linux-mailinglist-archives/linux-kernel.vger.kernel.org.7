Return-Path: <linux-kernel+bounces-829900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50337B9825F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38214A3681
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B322D4C3;
	Wed, 24 Sep 2025 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VwdQtWXj"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB616217F33
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685267; cv=none; b=SqeAA3smIwENmg6dQXPZGhvq/gTwZstfsMCPf/drLMwQAWqpU2mVR6In++2eewq83NGiIykwzzaZa7kjMAzuEWSmLaVcDC2b7r9sqyl1+E4dGt72BZxEiB/tymnK+W497PfmKUXQAWEEHWMGqxoHkeaPwXaKiJlvQ6Sqr+FFk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685267; c=relaxed/simple;
	bh=T+3/qbPAgyyQ8AOtGCLhNLRG39cRJ4tgCa1PGnwEzHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EOLctWejd64IZjykrtSwJrAYotzeUXFqvz7E9aEGSQ+kMXO99dkFY1s+9qt2qy4W/QReBYH0jhhlROeheBm+HbaIWhxA0dXlRQIfv5XoPMjlVhFKVSFgUKG/K9I96J0BS+yz8M6ml3VUBekV/KmCE1Nr+mgvsTuajaBGS6LTHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VwdQtWXj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso5932046b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685265; x=1759290065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ontus9bftLc1g9PbXi6snxrE04UjG3Wyk6lDgBoGb8s=;
        b=VwdQtWXjWulfa+6PBeZUm5sEDT3CuwJ/k9bMR1zrzftSXKuTkdVEqWwEj2Ch5fUBzx
         9FkqhmpZhNGFAj88R41xACmhhbcpyXOqXNqWwy3xi8XjWL2fAk9Itrs0IYiT+kSD3NDU
         di02NMsLR+0X2LtWARCagCMkJ/R+Zkgb4qSvzfqvM7o+KJe3XmUwQBw1ju18w3fHjM3v
         KUWupKr+Tt0/LxI8Zwffu2FPxMZSDztoHnQllsCgWgXXY7yU+l+FMI+cZc2O1Y3InSCf
         9WLdko8IFYkW1l5Vhwdoy92MCC81pNpVO6juNO/VB0eh9lM4OoQb0uOcinxnScvEuyhd
         Xrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685265; x=1759290065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ontus9bftLc1g9PbXi6snxrE04UjG3Wyk6lDgBoGb8s=;
        b=Dtbodhqv8sDOiqYPgdkx6rrtAZEvFkYXUjkiNQnYDIKl4ditKwKFz/d2TR+RWia2kW
         ATSpiFxaKth69arfepxH85j1uPsnf5b5IVm2Gwxm06POv0prlr62J5e0cmG6VpgRgAZd
         QqIEp0efPoS2XBhJ9hM2qfBI92//OY5ygxNaaghcIYXIZduwg1S11XjjSAufeQt//U2s
         bShXppdx/jIpaQ4ztxSZlyLeDN3/gXpHqCr7HQGZgdbtLN2hd3vpB19WXWE8HpWSErFJ
         iJLyxsrenoDMSWHYtWcfMefBwm6fH8AKKFzxg0SDr5jTO5MqfuRM16zWlUOuy8QFI8M8
         A8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4+jVjHARYl+DceLlmj6QK8tFsb/d7nbSnW+FjOiG5xSLI0TSe8rQPRzWRcoLZCiZVgU9D+jcEF+JZmJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECnKLdJ6yZlm/oV2ApzG4azULaarQua7vDxZxyESxaJcztscr
	V3hVDOoEalhPZruwDkLwAh3NRuMRA3tCUS1iyLQARjtiBKDS1A7IE7UVeQ8Wi6RPWnI=
X-Gm-Gg: ASbGncukFN8acpEvrPk6ktI8MYoiIqkgIjewCzchLVNhVNoUuD/OmhfIL/BCW7WwVPb
	sERMLSu1Pg+VSrNLJbDj9Rzbs22W68yL5gC3f/WVb0AjO8gwsS0j8x24u92/MZzu9RaTiaMHULd
	r9IDH+daJ/pnlLai+hRCxLpRLqqkLiB/4nHMig1WxHGuoo5q5jyWqcpKNGQCt8+Ca7lw6uxPXlO
	ztlEbbLN3LtOGmGY1VuxfBw1t2FkZ3VsJpoJLhFAUUnfeelYCqtGqr5IJ1aH+3RTCrdVQYEyovf
	32zHt2UXLU2qb9G15X4kNQk7I7G3rNxGKaHC10+/12rmQNwX/FklPK/dpt26BiDeKpWxz9hVYWA
	hGm7Sz5Plo7MLBduOA91JQ4YTswDZjHI=
X-Google-Smtp-Source: AGHT+IEDi98HKizARK5fICFnpQr1MYhiHxYWBHLNjcl4h9I6r6dFEDUkUC4ICOYn3zaIm6DYoLTYjA==
X-Received: by 2002:a05:6a20:a110:b0:244:3a85:cd7c with SMTP id adf61e73a8af0-2cfd4836bc6mr7199434637.10.1758685264845;
        Tue, 23 Sep 2025 20:41:04 -0700 (PDT)
Received: from localhost ([106.38.226.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f02c15bsm8550793b3a.95.2025.09.23.20.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:41:04 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 0/2] Suppress undesirable hung task warnings.
Date: Wed, 24 Sep 2025 11:40:58 +0800
Message-Id: <20250924034100.3701520-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Andrew Morton in [1], we need a general mechanism 
that allows the hung task detector to ignore unnecessary hung 
tasks. This patch set implements this functionality and enables it
in memcg.

Patch 1 introduces touch_hung_task_detector(), which allows a task to 
mark itself and then hung task detector will ignore warnings for it.

Patch 2 uses touch_hung_task_detector() in the final phase of memcg 
teardown to eliminate the hung task warning.

[1]: https://lore.kernel.org/all/20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org/

Julian Sun (2):
  hung_task: Introduce touch_hung_task_dector().
  memcg: Don't trigger hung task warnings when memcg is releasing
    resources.

 include/linux/nmi.h |  2 ++
 kernel/hung_task.c  | 13 +++++++++++++
 mm/memcontrol.c     |  5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.39.5


