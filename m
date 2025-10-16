Return-Path: <linux-kernel+bounces-856448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF301BE42F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121295089E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33D62D2499;
	Thu, 16 Oct 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLp36Y8N"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4442D374F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627982; cv=none; b=lCEXj/2Xs4LWOgTVMqrAa/SaBdH25tIl8fEWED/Ace8Z3iz/Qq/Gt3fQi+n4AKMQgyRF64vCFh/Y2n3eaZM9u6DZOpZGN5++4T9G8lcN0eFSwScJ2fnVJuH/vTGpH4AAZLqeKloYC4wMaUuxUbKgs40Oxjyd1HKqcoOQYO+bVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627982; c=relaxed/simple;
	bh=bXZfrNMwK/JEBIJii72HKvh714OrPuqLNT0U44y47ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQWCLjkYs6WK2XIcY8ycF6mTFwnDZrSxGcPCVWpsZREUI85rzyRT57C6uRYqRtW4NpuxQwqN72VVh9mr4MeKBrI+f75h1lAzWdqCUxryR+NRngg6Su2J2ILCCpLHv3GhPr42gNV1vy7F/WOWbBLX2qISQMgHvqV75GAVwqv4+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLp36Y8N; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57992ba129eso1084192e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627979; x=1761232779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfE5Yv9GjpyVRnSQN/vkaNj6o8FU3n/+3ZZi8MZ8XTI=;
        b=JLp36Y8NnYHdbv+nwmoaC5TGcott196FvpaWO5r+43l1bbfJ5eGakl+SmWfDbJ8E2O
         fpEDZ06XwrGt7IKioD6YrSS/onE8lmaulHnVSQT/Dto1FmZlghoZFCxkK0LR3RcNNxDj
         JWwRFYc5MbjawzpFT8Jamyyc88gS7syIbW+XdFw4mzFDGkNDkO8l0wwwRXDR7KsQaHyt
         ADlLanX7T6YQVpAey7hCaGkZysWSeA1idnI+PlXgs9Vjgp2H3PK6MaoGOM7tFL3ZFhI5
         zUj/otT83WWwIilwcpVtaI1xrpjpkotgHlNZxiOxKO2yctxGLSOkCje5P94dMUghnmBy
         VkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627979; x=1761232779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfE5Yv9GjpyVRnSQN/vkaNj6o8FU3n/+3ZZi8MZ8XTI=;
        b=udgREfULZb0nC32r8nV2/vHSo53pK14VDBf1rS6BqlLnRltclXk+XMArzQ2GRZbEXI
         +cHr8piZN+0mRzykv17TevQIwVOWU+ISUrXwT/wIyGpgFmFFOz9BbBNQGoIQrj5j3q2A
         Y9DNljcS/+uQ9z6pnWM6DEelmFIw75r5NtlF9Xl/o3yoE9Hdj3mCLXjcoINajsMruv4I
         n8F2wNmip18JmxPZsNv3WmE2iEP5EH1RGMpRegvBi3FWaWwO+AAKtcVKxfnMIlAh4b9a
         cqZUYSp+lRT2fHFgMTZ2VOQsZbdKAgZITiaL+iIxtREOYHUH9R0TzHmb8IDxoSuTewR+
         +mBA==
X-Forwarded-Encrypted: i=1; AJvYcCWGuxN7fDvX3kx8VvzfSoYnz+nuK+1VrK2Ol1gf368vHltJuBMUkMip2qdbkvbuyHEUc48InAWLG4IM9+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWALroV6fycTRIq6fyLzWZlJ0+floqgyRNdAdrxTTQfK7mdwQT
	GjA49wjK+MPjqUpbrv8lgi9pJRnydBPP8pbWdxQHHK0nppzfdT+S9yFdyQbsGSPjWA0=
X-Gm-Gg: ASbGncuU2GfWNr3CKsl70I8VyRynz0S/WN2saaS3fzzTYFAERjUuWWIwI8H/FRM830H
	+1PDdBuy0tIe5idBqL1NKqrxAVXU7koVeY2XbD4UU9KPHeEIgkCUGxi9Ni51D2U3BRZQJqjtRhU
	2qpoOEcl9YvfJBuRxoTCSK3PRH3awujAaujWO0jeC/z1BEWvJsRw7pSiPF8xW1T3EdQviagl5E3
	1pUr8KuOTRpNqP1y0MnYBOCXaCLigFsjAMaERPFP0viXNliWW4W2Azb2dh0mAOeBvtc8ziOBFoU
	9sH0GG5a18PGYCcWuao0SjkWZT6IR2r8nTcJOZp6QFBWpa3sTK7N4XDQ3jHcS4c0MdWx2mB/3nK
	gsOxhNKXMVK/UjOzM238I4c8mde4hr4yM6P5iga1K2dVV/xGMUFdtVwcLZpNn+leiIc6Bf8L2Ml
	6/pDflNWDpd4NeyKXRynx0fz/Cdhkcpcq7cUTamO+UWXWnDAQqUl+6YtKcoglYqC7OITAuSUE=
X-Google-Smtp-Source: AGHT+IGJ/UeSvxa0sZ1dZIRgN6jHQ6/U9J7iOW7lWKiGpynUlxR2v6ZbJGaga2S8TYpFoWWTEX9NiA==
X-Received: by 2002:a2e:9a14:0:b0:372:8d1d:6952 with SMTP id 38308e7fff4ca-37797986b26mr2274531fa.41.1760627979247;
        Thu, 16 Oct 2025 08:19:39 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:38 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit for s2idle
Date: Thu, 16 Oct 2025 17:19:20 +0200
Message-ID: <20251016151929.75863-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
	- Limit the new QoS to CPUs  and make some corresponding renaming of the
	functions along with name of the device node for user space.
	- Make sure we deal with the failure/error path correctly when there are
	no state available for s2idle.
	- Add documentation.

Some platforms supports multiple low-power states for CPUs that can be used
when entering system-wide suspend and s2idle in particular. Currently we are
always selecting the deepest possible state for the CPUs, which can break the
system-wakeup latency constraint that may be required for some use-cases.

Therefore, this series suggests to introduce a new interface for user-space,
allowing us to specify the CPU system-wakeup QoS limit. The QoS limit is then
taken into account when selecting a suitable low-power state for s2idle.

Kind regards
Ulf Hansson


Ulf Hansson (4):
  PM: QoS: Introduce a CPU system-wakeup QoS limit
  pmdomain: Respect the CPU system-wakeup QoS limit during s2idle
  sched: idle: Respect the CPU system-wakeup QoS limit for s2idle
  Documentation: power/cpuidle: Document the CPU system-wakeup latency
    QoS

 Documentation/admin-guide/pm/cpuidle.rst |   7 ++
 Documentation/power/pm_qos_interface.rst |   9 +-
 drivers/cpuidle/cpuidle.c                |  12 +--
 drivers/pmdomain/core.c                  |  10 ++-
 drivers/pmdomain/governor.c              |  27 ++++++
 include/linux/cpuidle.h                  |   6 +-
 include/linux/pm_domain.h                |   1 +
 include/linux/pm_qos.h                   |   5 ++
 kernel/power/qos.c                       | 102 +++++++++++++++++++++++
 kernel/sched/idle.c                      |  12 +--
 10 files changed, 173 insertions(+), 18 deletions(-)

-- 
2.43.0


