Return-Path: <linux-kernel+bounces-880018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C9C24AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4551189810E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C48343203;
	Fri, 31 Oct 2025 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXxcp+QI"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D41EBA14
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908477; cv=none; b=oNkuaT99vTs4j1K6JDTz5pT2Hz2iL+0EvNxhDSEiYa/1AoX6JctOUs48dXeq6uIpQUS9D/RjLLaT/76bqHyjB/7h3OCSUfZbGQUpQ9/eCFfSQ7Qca9Sb4uQXSS5HqXdqxCWPoiBxU8dkEaxWspoJeAzjCkZpz/fsct/g2QI3QTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908477; c=relaxed/simple;
	bh=Id79NlrVdiY7C3LNpK6PG+FaIrEAYaIenAK8fKOPAWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIQrRQjNSd9/BbkqxZt6P8qOU9zRr9cghN43OuqJKsWgkRstw1GLZvTRwenYrsYJU90BDyTrtIvENUFvauyqq0aMvNdY79kybk4CTbFQHMI+aI4muApk29kck+fpHPPd3oZmOvL/o2Thic3Y5p2yWQVh+lQRGpPs/mYLkCs7b8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXxcp+QI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so2951086e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908473; x=1762513273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MelVgbYmu2c9trVYIc+BMDKKDqiiaRVkA5YIS13CkK8=;
        b=yXxcp+QI1Wdc9d8xiY6USzCM451Z9Tf4N53w7WnwecQPwAt7xWOhC4lOYAFe15t/WU
         /6mxQcY0XMIdTXi6eyvQscnRe+lBRtbMegqzKsjytuTkVVa3wSH1uR3UtH/kK8Nq6lBR
         xciS0o7n79ureTqA4e8T9QjP8sMJVaXBFVa6Ht7x3sGR+KKoBCvb+sZRsjMJFUEbFZfU
         7ojlyfGcbJTakCvnUj9YumhYX/lRdbKbXFqofeuS/JIZJmUxKru9+vsX5GMWyM8PpUUG
         7vjOMaTRiEohL2kM7s/neDmP6x9wOchhN4E/Uq9hXMAWKM1xRb/limmmMezeU+mQZreV
         tpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908473; x=1762513273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MelVgbYmu2c9trVYIc+BMDKKDqiiaRVkA5YIS13CkK8=;
        b=ZGG80yPhRDEhu00+Nxq76a7BNZdsEoKcPz1RZ4cwRVoLU72ACfV6RbXIo/dkD0CYVx
         gp1ftP4Or677ThHqjZh08eJicTwMgtdG/eEYJWKD0a1mZr3QSPt8qJqNP5p8HQOd41SC
         xWf2RHc3yvOwQcxmTT894MySewPBcjY7kbcBovrDX1Rv3jvkJLdFvyxZUWJXn+KKIS5c
         /Bti7w+GZxD9czIJun7ImV0XPd8DiW/djwE+Cf600AvULa7nNrmsCaX63YemX2Ov9vIZ
         0Ei94r+CqK0wfUqj0wz0PkfhjTYi6Qf4tQ4wy3PaLRTa/AKYCr0Bpw0XnDbGUJFvwddM
         7NbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNLx/1OcQBv6TOrhbV2Ib+eYe3d+hf2MiElhTjzfqhB1rJGvhZSm+84yl5g8SWkR1VXZb6fKMLaPTRH+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2v+Aild8z6l2fCYpBYiLdiFJdp9XXbNvohomZ+TEvcF3eZrq
	Lzs9yS7O49kAwv/MEVJbzP+SpYbz9vXa9NMeRfGPDN4+ElnMsm62qauYg+T/sZ8Ry/I=
X-Gm-Gg: ASbGncsad7IhmXgm+LicSotyjwBzk5BFvvpZfuaglqakD1VqXP7qlmSxlsZR3CQjXzZ
	YW6G24gE6PTS5VYqobCxS3dEuCu3pUhz4fp6n0rLyaKBsbaF0HrQaDbHpUT4ijMDSmb34xHAKqC
	X4GX1WirqwwetoDCUkS1oN9xEpxW5XuKoIzYQm+o5P17XspiKJ2LlwqopjfpCeEVAbuAbhAf/1N
	DHfLBU8m3ruFy5mBnJ5tcUOfvJYIYFgv8ei56g+IOKLi7DdOBaCG0PorNrbAvoOt27ohFmKS+9e
	M6zE0bosEtHfdDLyciOMyoAQqSbjS2OTWgWBZdZT7kBiov5nAe0Qyzm2W9S2prfBlumzCbQkFEF
	p8nJmxkBsJsWyAKiF2FVfYGcpO/urph/TozuaxCMEHUM/KzvVUSAGrANZ8UQ3HghXT0qJEU6NAx
	EupI367Fy+rBJj5+BJDAuWZIbMCo/TDnqT67tG3a8Cpwq9QauFaA==
X-Google-Smtp-Source: AGHT+IHsT/nk3uXbNF1LOs+Zv/A3vY5tGk3m+upNiz408h90WHKfJVouc2BIcKO7ZcdEjqacd3XBlw==
X-Received: by 2002:ac2:4e11:0:b0:594:1a8a:3858 with SMTP id 2adb3069b0e04-5941a8a3a2dmr1796839e87.4.1761908472127;
        Fri, 31 Oct 2025 04:01:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbaa9sm432721e87.77.2025.10.31.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:01:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/2] pmdomain: Improve idle state selection for CPUs
Date: Fri, 31 Oct 2025 12:00:56 +0100
Message-ID: <20251031110106.62394-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms using the genpd governor for CPUs are relying on it to find the most
optimal idle state for a group of CPUs. Although, observations tells us that
there are some significant improvement that can be made around this.

These improvement are based upon allowing us to take pending IPIs into account
for the group of CPUs that the genpd governor is in control of. If there is
pending IPI for any of these CPUs, we should not request an idle state that
affects the group, but rather pick a shallower state that affects only the CPU.

More details are available in the commit messages for each patch.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  smp: Introduce a helper function to check for pending IPIs
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 24 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.43.0


