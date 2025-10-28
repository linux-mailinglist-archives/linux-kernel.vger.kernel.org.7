Return-Path: <linux-kernel+bounces-874412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CDC1645D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA51E406D16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6034CFB9;
	Tue, 28 Oct 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l64mDNkp"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3E34B1B7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673364; cv=none; b=fEozsXNh2c7p7fZb5XdC3+Kb6j7NyMB6/+T04HZp+6aeeLuhppddKM+cVEGHJ4BZNzbJxWV7U8ptnpKJHMN3H/5sDOR5jo4I2JJmA9cS435eH4F5aKuvcgctnIqlgXuLVoHzhfOONzckW0y6SR8MMdx871p9WUg38iMpQwIjzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673364; c=relaxed/simple;
	bh=NB4/159VAJ/LOLYrEdLoYDe6gQW8IwjruqaLuSzroRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCtMOPtlYT2w2veXcN4TmTqkjF3IQAfcuK+EqD91xpSwii2Mlk0Tha5GiwaO48r/h1u94Wi6MoegMG4ubavHfkDabVkY4WTSDc3OrOq44NRW5tc5NZJW0FPzZcCP4Ah3nd9FXPfptVUhp/P5vmgvudlUL13mBr0QZY5OVgk43PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l64mDNkp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4884036b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673363; x=1762278163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUzQKBks4b6XgtXD3YeHoVuqCQLUAhrUCly5cGOnfSg=;
        b=l64mDNkpwyGxcOssSDTg7IatUFkEZGofVjCs2qt1FewOF6/6Mpobaw9ECAmBH+SC3U
         tOTITFF/N3wjho6Ta984rJdEWi01dosMFY7ZlShOvoXkMxPmTOU3nItgCzDZc9rzM8en
         NQTddCEyArdIevNn/fpsO+6pUkTMnQuirbEBxYJisTf5ezg/GGy1zTp7f9NmDq4T0mVO
         q9WIuyi01+8S8yufqgtTRSAi0XWqMXuhuoo8H246EkE/K3sjmlPOUGMACkD8nSIK58Uy
         MNTPc/n2iJVlYSCsrjQAX2pLig36SlK5wPb+abvVHmSOkn1csneA1Ulnm51gGjNPv7xb
         o71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673363; x=1762278163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUzQKBks4b6XgtXD3YeHoVuqCQLUAhrUCly5cGOnfSg=;
        b=fhDXWTJ8Rk1IztQVVR7JFsZUam13twlYBZukLOxTJL3hhHLXdFJbJqnItyB7z6fy8R
         3C9Fkcv2Ws0FpD9pLAslHpLURtqjxw25cmYgTTFzR4yYofce/IVni/Lm4KeMDRG6LNOV
         8f5OChhjYAyhoKuRu2OSLGgwX1DwsT1yYD3cnkxZxH5aA5Jd3N90zWsQClDzWAlnkFSL
         xt2zumkIyIal4HRYBo6AUWth2EBwMVbzG2pI3AroYSOF8z89gcoEGcWd6F8vK5y/mqnE
         2+ksiIwYIFDNdGoBOdf6ZJMiWdGlGrFMCTA7dLn//JuJgWnoL7FWwiTw6Wv+a1g/6BCS
         I/WA==
X-Forwarded-Encrypted: i=1; AJvYcCV4d9I8wACbw86wRnQfj/qpdPGS4KxHoyoDnn8uhWkctk0T0OlMqJWgOwMnLv7hNPOxtS4XvmCPNAG8oR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgtWfmVY5i7aJuXGvAhhbB5tku+gElqFgI7yR75IPjZfa4m3v
	L1/+T7GPxNWpDfvDPRGBvDJRRoquJsAZ+LlK4xQY+evWmw8nvaR2/1Hs
X-Gm-Gg: ASbGnctJVpVQT71RqT7pCbID3B6x8zYrQNM697OAQ9uxFoTp3ydw5zY+G4y478l/Brx
	a1lLtxHTO36xv1GvLUtP2Xacad9WXgspNW4LDCIU9DPcQ02Lw77D+o3NjTlvHdOJwrmwzPibZHi
	w4juq2ixyCLy1DYK7JP/QbT8P054z5ce4KK/7of6wn9NWs+CDIeKE6lu+wmLXBA4k8yHHBUV9TI
	DXUbSl4KodTyCfkoM9GvSBo7gdFKisvBS97VwnzCijSAKJJLO/XUSb0JmOknhui9Gwpv3NT1Efp
	1Xk9fhCqGkuBuXciDyV/36DRMwuUCT0mZ8OIhLP4yOcLZi5ujf2KMHFvXNE0xYQaSgNhtzFOeg7
	uZ0zn8CKc3JV5W/qwm8sdCnw6NFeZsXVEbAN64y6XLoYEE+bFczupAPh9P67Tvhoc/pW33H/A+P
	GCKM+fysrS7HNfKaigqhey12ecUhmEQq1m5iz9d/q2IR3KAJmOhBCKC8ooWRMZETJXlUc=
X-Google-Smtp-Source: AGHT+IFkagOU2linMs2kD3kWq1TGqg7rAVt5JSOnY9BDlaUoP7+rT5UX8pceuf3wIHeJnBVA96Qorg==
X-Received: by 2002:a05:6a21:3289:b0:266:1f27:a01e with SMTP id adf61e73a8af0-344d3e45d1amr5219012637.39.1761673362484;
        Tue, 28 Oct 2025 10:42:42 -0700 (PDT)
Received: from debian.domain.name ([223.181.113.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm11086746a12.1.2025.10.28.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:41 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFC/RFT PATCH net-next v3 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Tue, 28 Oct 2025 23:12:20 +0530
Message-ID: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep.

To address this, this series proposes dividing existing set_rx_mode
implementations into set_rx_mode and write_rx_config

The new set_rx_mode will be responsible for updating the rx_config
snapshot which will be used by ndo_write_rx_config to update the hardware

In brief, The callback implementations should look something like:

set_rx_mode():
    prepare_rx_config();
    update_snapshot();

write_rx_config():
    read_snapshot();
    do_io();

write_rx_config() is called from a work item making it sleepable
during the do_io() section.

This model should work correctly if the following conditions hold:

1. write_rx_config should use the rx_config set by the most recent
    call to set_rx_mode before its execution.

2. If a set_rx_mode call happens during execution of write_rx_config,
    write_rx_config should be rescheduled.

3. All calls to modify rx_mode should pass through the set_rx_mode +
    schedule write_rx_config execution flow.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

ndo_write_rx_config has been implemented for 8139cp driver as proof of
concept

To use this model, a driver needs to implement the
ndo_write_rx_config callback, have a member rx_config in
the priv struct and replace all calls to set rx mode with
schedule_and_set_rx_mode();
---
v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch

I Viswanath (2):
  net: Add ndo_write_rx_config and helper structs and functions:
  net: ethernet: Implement ndo_write_rx_config callback for the 8139cp
    driver

 drivers/net/ethernet/realtek/8139cp.c | 78 ++++++++++++++++-----------
 include/linux/netdevice.h             | 38 ++++++++++++-
 net/core/dev.c                        | 53 ++++++++++++++++--
 3 files changed, 131 insertions(+), 38 deletions(-)
-- 
2.34.1


