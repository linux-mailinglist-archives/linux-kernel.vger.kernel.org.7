Return-Path: <linux-kernel+bounces-828089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52DB93E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7717A2F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF826CE17;
	Tue, 23 Sep 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ixFcepof"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FD2CCC0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592467; cv=none; b=YRtxKHp9YmxBQkQruDMY5mgtrcNisJ7mANLc1AD1sLPJrWSseAh/HCozsBBKNWY0ic+diPL16Fan7gqOjHLqlrF5MVdurw2RcroP+Qx5ZhDZULKjzF1ZhLv1yT/o5VLNMgSEqp6xoN64qGna7XDCvXXuNbsLyem12BU7O5A2iX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592467; c=relaxed/simple;
	bh=mB39U94LWkUhP6XrdaSVFjBp6q8Y+yp0Uqq4bPSlw1U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gZ/EURWWsSownFtslJGdJJSksQ4z7iMx7il0lcqtqt8Wq2TLmai3vwmmrOqxzwlwCnFcyjUfqgZlz6AuVtrU6fhW+lDZyDcQQGJtIJMydYJJblXGWpaCm9QeePgR+UompXQiJPfecj8faxtrSFx4VO3ZNpBpqPF4+VZ67qrzSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ixFcepof; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso4333309a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758592465; x=1759197265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDFFhZlnzsy41ndmGt6OQYFcCCEw2Vt6HJxHarrRTzY=;
        b=ixFcepofHBR1PGd+htbWi//MA4HsKwOc/V6bN0NSb68f4rvY/0yYU84UegTPwm8Ud/
         9idyOmo3tpQEnhFjYxy/oxApl/rt+mdwP1iz793mOZNTrtmI3Osg+wA1aVLliKj414Uo
         +t5mZmGzYU+HDkIWy8WSdLd28sGdJWvVfXjmc9YQuCPBRBZWti4k20R9H2u7U9t02wFf
         aA7OfoUKwPsKv05TKNX6KOPQjQaVgdiyviSxCrMpHIjLd9gIyex4RigvLnDj4V2DM8wI
         F02tVdetwayZ4zc72rQZdeoyDA5jFCykGAJLqDMQweoWrNhpTyPLVZtJ69s9/BegAyMs
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592465; x=1759197265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDFFhZlnzsy41ndmGt6OQYFcCCEw2Vt6HJxHarrRTzY=;
        b=rr2DXo1ULgFvAnNOv7D/3+L83dkt7674q4jm6cZVAb0gC+XgCJw9PbRdyOb5cJNSTO
         abwZ8OZlcJmVf1lJ/1peLRZphDTNEIDslHGUQOhlnlEgd/apRMRY4I2/eYL5nnwlVRu2
         TalYpy+Z/4O/JGdtMdy3meds1gcskorVuG5A/rJBpWz2qxZbVaQePb13/+2bdClRDl7j
         EjsqMcUNy6Ep9QL73ytW6QJAxuYBD2jl7/JAC7rP7mtkUu3o7UG64cU6J7NoEvRroMq8
         MZ1bpHaxsSJHPT5C32gFcdzeQRIzlWhklBB49zDHBY2aLfAJ9oiXqGLevDHdzUsCwfPB
         3VIw==
X-Forwarded-Encrypted: i=1; AJvYcCW7JLyM4OVKgyYbwfQUwpeneXorcJEAobxqyom6PRBEmn66uBKi+yGDY0ctLBPYrXQ87+nxjFaT+JS44YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3/jSJmEoaVfhDsc+XNW4ZDiyijHDvN0FefY94eiW47nHTCGU
	Zl5XJORWBjeK55qyAJOsmyQJlKypoPPSCUYz9Kn42oJDUlSKTWaE4roNP7HgQVtLV/0=
X-Gm-Gg: ASbGncuEtdda3othDxLy7/W7+ykrRvEk4iA/cVIZ4RhxbBVr81qXPyQmwzLfFL2Opbb
	AsSqH2m5YDzv7AIOT7Nh+Af5zeDfeTZXENQJJRC8Fgj/SLKdr4DcjUBxq9senvP+BHMNWJcIyQw
	yfBe9PC6xJ3hFw7uAB3LQMx+z9sm7Jo3gF+Y8sz2sKLydq6y9+QtPhm1ojkfdpC/0xfJWiB9noD
	ylaPf0J4ikdPVa+PU2JhaAClRK1Yd4U77tlWv3ktrvS9MNWjZ1L2mh3WINYBfXJ0iMLdeYZPRx1
	UyYDO/zRtDzcXhFIsKhl9anLLPaBGn+aHr2wZvNeCsP/Xu/6caLcx1YvwSJMfmkuedZ9nPUAPYi
	DE0LYSLr8W9b7oCp+90gbOxYGgZD1ZZOpxX4lqxElj42JwpOF6O6VBg==
X-Google-Smtp-Source: AGHT+IF3wdg1xqu2ITvjzMmM1K1iJJ66E+kaUzvqT3Dn7T77NFDGuicqLfU2zWU07DUh0NNcErEILg==
X-Received: by 2002:a17:90b:4b0b:b0:332:6356:86b6 with SMTP id 98e67ed59e1d1-332a952a625mr966000a91.9.1758592465023;
        Mon, 22 Sep 2025 18:54:25 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed268813bsm17503265a91.1.2025.09.22.18.54.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Sep 2025 18:54:24 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	mario.limonciello@amd.com,
	cuiyunhui@bytedance.com,
	beata.michalska@arm.com,
	sumitg@nvidia.com,
	ptsm@linux.microsoft.com,
	yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] Add support for parse_acpi_topology() on RISC-V
Date: Tue, 23 Sep 2025 09:54:08 +0800
Message-Id: <20250923015409.15983-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
Place the struct cpu_smt_info{} in drivers/base/arch_topology.c instead of arch_topology.h

v2->v3:
Modify the return values of acpi_pptt_cpu_is_thread()

v3->v4:
Introduce arch_cpu_is_threaded(): if acpi_pptt_cpu_is_thread() fails, try
to get the CPU's thread attribute from the arch.

Yunhui Cui (1):
  arch_topology: move parse_acpi_topology() to common code

 arch/arm64/include/asm/topology.h |   3 +
 arch/arm64/kernel/topology.c      | 101 ------------------------------
 drivers/base/arch_topology.c      |  96 +++++++++++++++++++++++++++-
 include/linux/arch_topology.h     |   5 ++
 4 files changed, 103 insertions(+), 102 deletions(-)

-- 
2.39.5


