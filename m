Return-Path: <linux-kernel+bounces-733521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08744B075C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1087A188908C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C72F5C32;
	Wed, 16 Jul 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2jQNzGZ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3D2F549D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669228; cv=none; b=qe0HU1sLo6nt98BDVuNFOb9jp4/LjFA552mv2Y2vZYUhS+bFx6l1tFxtPhlLaKPPzAiOB18QPznuc8pzyxi4qWHJimiXJuZA0qjgoquMPel/7ZsKwP4ckXK48ksoNqExkdrDWEqEz/ytWZ1QRSMxSMy3LROLeJ4Je9yJz++n1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669228; c=relaxed/simple;
	bh=08lvyJpsfPQ7duwM5J1p45KHDISWYaviLzAiNxGI41M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meSyP951iQWCZkfs3jxcniVFFf+GDVoqPb2r56ed7f08SLDmJsdNXfDLXYf0YNSdXWbmd/9Zuvtpy97mzqcWQS5TM4RSTCLwK/nVLBLqQArYJeSLtdfCVw0j1TBqgr9ZLPYATAjKY4bgLMlJm+iI+/gsoi8cP9qY02+WS/KO3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2jQNzGZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ac42bb4e4so54060871fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669224; x=1753274024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFSfQECrsZNiZe7JNStSknK1prfhra2C8c5anJEbOAs=;
        b=U2jQNzGZ+jlOJbVUDsKxI6MQznHbCVPWXqOg9lZmXbAnq/oPDIWjNMyLX67mRaMqNp
         hHJb747yXtr3NffoPJxX4gi62wPFoHhUtUPrsdoV2DmN4Xup8G5L4Z6QG2cJhVJqQncN
         ftlTuw1GfHZB+/5uoIREB6koVX8BerkbMcfI2sUePS0jn1bsW/R25ayDcrXBnBvE93e1
         1ah+MymzKRPPuTj8Jma/9LYO+a/bqD4D/vKirWQFJeoB6TJcrfXgT6AXZHIGeqDlVPpS
         FoO5sQAd9S1FQKjbEcR6PSYXKeSG1y65bwLbTukvVf56rXK5SulHb9SmTjWFZm4yYi8c
         r2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669224; x=1753274024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFSfQECrsZNiZe7JNStSknK1prfhra2C8c5anJEbOAs=;
        b=aRFg58yEfdf8rAb2YUj3DnF8ndPbowgjyr4tDjc6lIE3PgEfyopeJKNP/hkfo+eaWJ
         W4LDjJyobpv9bLTPn6BRm+rNNu35LhvQluUQn7Q+MoCXnWj7w6YLEU1qTxvnU1fWCC2o
         CqJ2QIzAnDloKvobrk6wCJt9JuRJfVn1vx8GvpgBtKkWy7x+EqXUljY3guyxAqiBunJf
         Fcwb1mAUCB/ODdCmN39CIwcCPKwk3F6lAkhXxzBnL744NLWIGNxSTadK9P6yBRkBIlh5
         0grGF7oEMS1v1ga8C44hRQJArEZJisJ9+gPZx5sRKDfsnAAz2MEryjmQ/S9zATTPSqHA
         aHcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTpjLw1BS+Uomki7eNKuT6RSxO/VEM8D9Tsb/4qC+sk30PZc1gCPwhJEhN344VeARmfnnRbbuGgNkZcYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEWplduR50Lk+kfILEJkRVKrYXUhbCjYvUsvqrDYkfBxrqpet
	8cY9MatL48pNRzshC3U+8Esz6ZRgBJ4Ynq+cWjAj7zAbb1jANgqCbol/kwlXeKZuCfY=
X-Gm-Gg: ASbGncvpE5swmTjncbRYld3ebB9zFz40A1llB7b0xfmJTl3AECqOTbUM5snRxc+28fh
	s7kXDOeAhg4jLepq8PgFCF3UlxC9C1f5tOu9R1pLF6PbupuQAJRKL/DLAGeQfcpI/AKNfAx3Bfq
	+o8QQwTFh7CpVjX1yKcRrnSP4eeee+aaU3RKUqH9d77OxZzFuPJVxhp0PWFOBQa2jHn2zm5PPb9
	u+LMMr9C8Dn+74kAX5l8hvJxcwcr/yxIXbuzHBUOG26GLtYv/eApGcvCyUKtI2z3nUq08G31DPV
	RvfyKPcJBBa3R22UuMvclqH1lKSm4pz4F8w/5pQEcAHoq24x2T9vUoMuE4CZeKeQDj1bjSIduxf
	bKV8Rkml2RG8gthOYCb1xsv7LAqRn7jU8b7XyOz38wKk67my0vpVAMQj4JPpXPGK9Qqz4ZgXn
X-Google-Smtp-Source: AGHT+IFwBpy4lInpcZVCKUb1fAf/C3zDl+TrubdAKZyaj7Zd9Zy+8u2pN4OKhcuL9SOsgNmlNkEtwg==
X-Received: by 2002:a05:651c:2105:b0:32b:7ce4:be22 with SMTP id 38308e7fff4ca-3308f60c56emr8564621fa.27.1752669223804;
        Wed, 16 Jul 2025 05:33:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:43 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 0/3] PM: QoS: Introduce a system-wakeup QoS limit for s2idle and genpd
Date: Wed, 16 Jul 2025 14:33:16 +0200
Message-ID: <20250716123323.65441-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms and devices supports multiple low-power-states than can be
used for system-wide suspend. Today these states are selected on per
subsystem basis and in most cases it's the deepest possible state that
becomes selected.

For some use-cases this is a problem as it isn't suitable or even breaks
the system-wakeup latency constraint, when we decide to enter these deeper
states during system-wide suspend.

Therefore, let's introduce an interface for user-space, allowing us to specify
the system-wakeup QoS limit. As part of this initial series, let's also start
to take the new QoS limit into account when selecting a low-power-state for PM
domains by genpd and for s2idle in the cpuidle core.

Note that, documentation of the new userspace interface are intentionally not
included in this initial version. I simply wanted us to focus the discussion on
whether we think the proposed approach seems reasonable, before spending time
on the documentation.

If you want to run some tests, there is a new file added at
/dev/system_wakeup_latency, which works similar as the /dev/cpu_dma_latency [1].

Note that, I was first considering to re-use /dev/cpu_dma_latency for the
system-wakeup latency constraint too, but after a second thought it seems like
mixing QoS limits for runtime and system-wide suspend doesn't really work well.

Kind regards
Ulf Hansson

[1]
Documentation/power/pm_qos_interface.rst

Ulf Hansson (3):
  PM: QoS: Introduce a system-wakeup QoS limit
  pmdomain: Respect the system-wakeup QoS limit at system-wide suspend
  cpuidle: Respect the system-wakeup QoS limit for s2idle

 drivers/cpuidle/cpuidle.c   |   9 +--
 drivers/pmdomain/core.c     |  10 +++-
 drivers/pmdomain/governor.c |  23 ++++++++
 include/linux/pm_domain.h   |   1 +
 include/linux/pm_qos.h      |   9 +++
 kernel/power/qos.c          | 114 ++++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+), 6 deletions(-)

-- 
2.43.0


