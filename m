Return-Path: <linux-kernel+bounces-824081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB6CB88142
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81975522698
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CA34BA58;
	Fri, 19 Sep 2025 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DghesOUe"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60412AD24
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265283; cv=none; b=BbW7Z/VLuxW3U7iAn5kaBw+ali/UcKGQOuZ5bdKXGRI4Q8FYCRrK+RJS9VGqs8kQdb9K+UQ2FAjumO8zPJj/YX0nZ8x+DOoEoIaSLildRxOKJVHRvpEY4enRnQC9JBXShfEwmLnpoyntKq7ikXo+KMJyrVKjIKbbHrdF84ookS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265283; c=relaxed/simple;
	bh=IyqVhlo8K42QH+W0SHvgtyDrDh2UiWihYq1NBZeY6GI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rmVmxEu49mHpP/OF4N7tAqwnWRaotocbeJ7jd7uQ2BNsttvapdlfv658wcdsklarzdkwrZWN7+4EfdUGhAoIf10h1f9HmLiqSPL5KqQbizhqYujeFwmwBsD4oBerZuI9CTRjjgayJsnpw02wsjQ/j0uAcEgoBEqiYmWKguf/0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DghesOUe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1841656b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758265281; x=1758870081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tB6QRb7jrsTmVzw62zDkWBc74Sx3MC31EtdUpSMEsXg=;
        b=DghesOUettlbCAF0YDS55mLq9vnBAJiOEU6UKUR8GxvPU0jDVDD7PbHOzp2dTLkacN
         iVJ9Z0GaZUirmSmXiM4jgw5XVBRBbU1zQ88YQJ/yMuzk/xR03sHYQ7frlYGZRf9kKnPY
         OVdrIHQdO3d9fKux9JRU2mvqTRj3GxJYgAFwmoMT9/UFJWY1JwtpVG92OzpK6geiC/Hf
         lWRkaNJc2xuAV7Nl2pUQ8LcXQKXdIL0f+RgK9rJ0vu9JtEIgponX0caFsw8l6B20xCOf
         Ay9BJThHOvAZuFHdyVklR7eeHeMA76Y0hbyn8J1XM24H81a6uBU6zFoUmDJM5Py+HrlE
         QuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265281; x=1758870081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB6QRb7jrsTmVzw62zDkWBc74Sx3MC31EtdUpSMEsXg=;
        b=O6QgxcIcwSiCYHrMW3iGQlxSju6Ag9LEdMYUjzAa61SeFQhJXIiLuSFGbyLJYFKUnw
         mRw83mZ9Xtvve3t7omxUiobhlgxaRzbV0r8xpFKm5PeQIdiM1a6HH0BMoF4aCN72ur16
         tkKaI3z5ugcTTHaLAWKq8PxGZQq8N+6taXOeljSYSJiiFzlP6WDTWoGheuavrhoXFDNr
         Msmd//wA0RPEQXIlsNMl5qlr46HumwEeOXRALA8w0WQ408qnQ1XcdCezgkQNoYv4ORmf
         hDi7qdu7pmcv0VPDrRER+E9cI5OlXvmfeyfX/2AK26YN4POvV0m2rnebesBzrXLlQLM+
         v15A==
X-Forwarded-Encrypted: i=1; AJvYcCULUSaJ33pNO23ZcEyb6yKfW5E4FmgEqsvQA7995yIo7Ye5h9ZrVZfp/yhMJhVWgKyPs8QhjgbrpuZqcPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2oRQRC9rxLapo0kzzo2h9bsk41JKE9pDpIosXuuyanTAGZ/nM
	KlqF0YSms5ioL6v8BRRaVRQrEhcKOd96HLBso2Yh1eFyhRCWg1lBI+Z1AcAhPz6U4VA=
X-Gm-Gg: ASbGnctPFJcXPlZ9UZ7nO6NuvDJiT3uBYN60sUSl677cIN6fOcbplMjJ7QkRPEliVAd
	oi0+F4/ve8uIgUUTRuUPz2aGBDE4z8/6a6IxXi1xV+x1I9h33kAKgDBu/Q/YCvi2dPOL3HlXBgx
	U3Izm66yajG46ALsqDCaTXT7kB7POXjh+4lajxuIi8r3oKNp47f2EX345/UB6sBij7DiQD7/V+1
	EPQOxvA4JkaIRDkMPZ6IjN0u9HGdJb6J7RsF2Pq+T9gVguJ8nANWHWcsuI90dbUfqo+Ev/MNSIk
	ffDgQyTOPqPfYwPwsAma5xzk+YXXQS+0SA5hdqADl3aOuuj0emEcoI0/9KqvEptQ3EGTL3z68at
	X0AHlE6KGhT58O2vzHl5F6G4eJW9oxzpBtcRYEwbllNKXrRHACxIbf+0435dbAo8=
X-Google-Smtp-Source: AGHT+IHr4UxZDEHkDiNV7EOaRF3VONxVH0Cmxy2oMVJnQ6nic0Vry9y1+483kpnmptspoi7qgVuy9w==
X-Received: by 2002:aa7:8894:0:b0:774:52bd:698d with SMTP id d2e1a72fcca58-77e4d709ac2mr2418765b3a.11.1758265280943;
        Fri, 19 Sep 2025 00:01:20 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dc606e10fsm2938738b3a.65.2025.09.19.00.01.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:01:20 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor@kernel.org,
	atishp@rivosinc.com,
	cleger@rivosinc.com,
	ajones@ventanamicro.com,
	apatel@ventanamicro.com,
	cuiyunhui@bytedance.com,
	mchitale@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/1] Support unknown NMI based on SSE
Date: Fri, 19 Sep 2025 15:00:47 +0800
Message-Id: <20250919070048.94646-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch is based on the SSE features by Clément Léger:
https://lore.kernel.org/all/20250908181717.1997461-1-cleger@rivosinc.com/

It mainly adds support for unknown NMI functionality. Since extension
development has not yet been implemented in SBI, an RFC version is
submitted first.

Yunhui Cui (1):
  drivers: firmware: riscv: add unknown NMI support

 arch/riscv/include/asm/sbi.h     |  1 +
 drivers/firmware/riscv/Kconfig   | 10 +++++
 drivers/firmware/riscv/Makefile  |  1 +
 drivers/firmware/riscv/sse_nmi.c | 77 ++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/firmware/riscv/sse_nmi.c

-- 
2.39.5


