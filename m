Return-Path: <linux-kernel+bounces-736799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4306EB0A1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE95A609E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3576A2D94B3;
	Fri, 18 Jul 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWyRi8ud"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DE2D94A9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838506; cv=none; b=NUvdtbi+plgr5i0HBwGxcafVMh1INxQ2iXjmDB4AU0DDfuwphXLnJCMq6OL7P2Uet7i918PEojVl3OLcb8Pl1w88X+/lEn5XsSak72zTuU5ez/l/4bfpWkX9ohARO0WK85E+yZvAB0F+fSb+UM4qLk2IBuFjqDqZi3HdKuLbPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838506; c=relaxed/simple;
	bh=jQSOqRGmJhKihBmtIppchJQd79WhRv644pHuQe0irRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI6RuFi85e8brpKaySKdqv8M6+aYs9FiGD6LUFwt7Z5dCHDFqwHIln1wHSwnqe+OEAex2p6glQ8BEAj6TWOeM3xWZ8oTLwG0u16tkhu6aBvafWDfBkluI4y9OZqDWz88KNCSWLzlNAz2l0HA4sco3VTVPUBS7UU7x6TO57u+2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWyRi8ud; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d52cb80dso2300335e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752838503; x=1753443303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nEPBqEpSBX6wiXaEWzWfHLx60QtO1oMIXeti88dk8Y=;
        b=PWyRi8udcmGyqwBy5X5iNPCV+bkGcTbez3ksra6f8tuteD06Ye2k+TDZps5rhSbabP
         a1owIRk0TvmaxWlQjev+c9pA2RcnPQoA+QW1O9vSxI7dQx3DmNfPSvThoNep+LDDFO6G
         Z60Ru4XBFouhrA/QO1bu9tDH1xkVky327UZpWPPlN/kSRV/sfKmUm/d8xq1Kvqo9e/9g
         3FaapBYhUOkvzoaXsJhPl6EJicH7H5TZJYNzRT0EFRcryBxe8pkMbSfseQA146lFH8ZB
         Mcr5MlRxCVXaV6XRWlU70JFR6lU7Ik14d3SE7By1zLW4F4pp4v3yZxa5AkSp2JIewLM5
         3Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752838503; x=1753443303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nEPBqEpSBX6wiXaEWzWfHLx60QtO1oMIXeti88dk8Y=;
        b=sbkl/EiXFsomjDAvZtCxfZ3OIT/GMjG4pknk+sF3RPuvU8tZwTK04MUPo1ZhDy31ur
         Mi/j0hjJrnSzYS6IZeyURhdevyFykMGEd+TRIJX2+kW4m4i0UcaVnnPWCuZxvsTFA0kU
         zfLi8antjXMQnUkUQU4Sl1BN6ZcPSGefjgz1H8YnWjo/SPNtI+LCMo7dDQd36zgkQCJZ
         M/HQr+FfV0slxev/kNSwyPnp/sKcoIuBPRZgu1Qa0wc7jDCJbL2sYci4KfWPF7vo/hC3
         clH5mUF9ndQOudoBIqKUTCL/XqMq1PWeW6wgckRCEIfCRwSyh1ElA/JOv3GXCPDXjI/m
         xaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxHDCnCJ48+u8b+CY1JhF0p6OUdMf3YqVrADr5e2G+3MdXXiVTBhnQakIN6TKODo88Yb44gBF19MKTJn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5w5WMLOnx5sjeK6TaFQIp6N1xHYLQjAac3tp9PKyrT/0PpGcf
	rFfCzPmfQN8AjAfAQNP6s6s+bS+J1PB2Nr00XkhKBI6rOWvgwUZF0dktr9M/uXwtiNQ=
X-Gm-Gg: ASbGncsKwR0j0A3JJ63nh77uiUsLRanu9X7KtDWlj3lRnBvyp2xqUv7QeRYYcfOwTw1
	rPBwz9fy2DbubPuCX0MbcdI5Nly6Pjqkp7zLUL9dlKVXdzXOZPP4UzP+Ub0l+Ow9V0CD/1dKG1+
	53r4KCKG9RyXM+2/mnw66Di6LSDCgvp8C8aVCynbMQAdd4ZAUj0FEH68j197XotU546wmqxEjhj
	D8DUDq7kRyVOTJ6SFoF+5ucmcWcsSWldW+IBEeWFHBYHwvNd5c2y3qG50nXvAgrTV/r7tyUf09l
	Jjq741ow0tHJ32MGZk37Gr49Z2JFbr7/GNp8YtifHWsr5mAbC7VqABrZTM7UMs3MhsM/RNYW/JP
	MaeLwLBwvx0oGGSrAZIPhm+mwdKwg7jd2kUrZLhNhLgPyxk6lAeQlFUOHsSKW0PjQkfuXtYDx
X-Google-Smtp-Source: AGHT+IG4/1xEJsLz+qOzcVFluQ/WLouAG1pqXqN4pbEVpAjZiEuAyzyQxw+ookED+NDC66AWax4jCQ==
X-Received: by 2002:a05:6512:3411:b0:553:2912:cfdc with SMTP id 2adb3069b0e04-55a28ca499fmr2104268e87.9.1752838502793;
        Fri, 18 Jul 2025 04:35:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9cfb1sm226928e87.45.2025.07.18.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:35:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/cpuidle-psci fixes for v6.16-rc7
Date: Fri, 18 Jul 2025 13:35:01 +0200
Message-ID: <20250718113501.80851-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of fixes for pmdomain and cpuidle-psci intended for
v6.16-rc7. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.16-rc2

for you to fetch changes up to 621a88dbfe9006c318a0cafbd12e677ccfe006e7:

  cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y (2025-07-14 13:09:04 +0200)

----------------------------------------------------------------
pmdomain core:
 - Respect CPU latency QoS limit in the genpd governor for CPUs

cpuidle-psci:
 - Fix cpuhotplug support for PREEMPT_RT

----------------------------------------------------------------
Daniel Lezcano (1):
      cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov

 drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
 drivers/pmdomain/governor.c    | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 13 deletions(-)

