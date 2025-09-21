Return-Path: <linux-kernel+bounces-826414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610EDB8E7A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171FF3A90C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AA28643C;
	Sun, 21 Sep 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVxYOyNA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477415E8B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491780; cv=none; b=dqUgRKoFlWrmfeqdzV4ek9Bzim4SeDVBxlMvXEHC308I+o0QDEAKjxGHQ3PN0BUF3gw9ZOZHQMYvDagIZ2osOjv9nayd28WrdHdSO68q6/Vo6SlvWz6KXtMaqQyyfn6Mxa9VgCd15lNGbL0umgMHojbH3R3CWu9h1DQNTRyMNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491780; c=relaxed/simple;
	bh=HUv/KqDa+7owTqnRzPUIWK9staNfM29PaK/t0/ja1cs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jZrW4h7WdGXBEQSZ7sCKOF5W0U1KoMk/S/TX/KKbL4yTSsShbKkpc/m1Kwjc629lyfxp6iILEZTR+6NOA8LBe2Mkkr4eOuoYT0zB/s8rGoC/u5TvsFlaLsuca7utJM5MqW4eY+upAYvJkyfodLaX4xOPycbTH86A9Dtinos6lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVxYOyNA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso2497112f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491776; x=1759096576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3vFwP/UATWnOKN/9SU3bVti0yAkZLhmbmjOPQlF8WE=;
        b=jVxYOyNAGqRwObP4qio9VEpsn9Setxx6KmHjnWqQ4sGI0NLC3HZkpSj2eBRAAdhXXG
         2WQW7+TMQdD9OR9uCStTkz6fbwTt9HG9NbLwwG41hz3LSFXpKIRCiHonO4ejYPpZhm09
         HtqP4NJIKfZdfK4SLjAaNkAmbwLbNWp04ZRxB+KF64QolYHUVKYsw4lremxzeZBOYNAk
         r95Fz4igyQMMSG0JCBx17OJ5sv5uSA5NoXk6mmpgCUFB5wruGMcZ6/CnPxNuRGCrmZEk
         YBVHBH7y16qXUFZk9s5EDkrK+PJribhX8kypoABtxpampoToEuhEoqhqWanjQW1QsWBx
         +3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491776; x=1759096576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3vFwP/UATWnOKN/9SU3bVti0yAkZLhmbmjOPQlF8WE=;
        b=sQ3LAhBMKr8QjUCd+s/3YzxHIaY9ambAJFf5uiU1ehEFIDp5bAK6FKp8dcJJqjdz+3
         ObPfYZzwecYHY+NZmyRI4S03ApiuCJ6wya5708WubmFsOYorWW3eiRUMQCjCRoAxuAYb
         zi4jWv1JiDDppZmYTrh+ZFTuYhO0Y5AMZY6YXbCpqvgtwhCBPs3UgCRs/X7J+xkz4geA
         H5jqZHA4nmMjTbPHtGCjZn19teNxHrjUFS1ZUQjLG+IKdtJRLO4cdcgEMWA7FRBlI1yB
         TWoHRCDJUSOJrMIIhy2t+r5/FW1YlsX6NmVa7rDi6kHnqTYx2lmVnLHAFW8x1mSBCLXI
         6qQA==
X-Forwarded-Encrypted: i=1; AJvYcCVbcsvycUMEBCwfwBNK65mxk5vorHl/BKjqEOmdYyN7E8soXXO8FdgSacqhj17snISSnZ4AyhC5Ia+Fglk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDYFpYfANUjABhS2USquaIbsWsyA67zeteTzeo5EdWNQJyJ9s
	dXEZLHGtLrR+xkoUsiBhzkmOZ2zVuDf6FfEjHGw4vYKEMPYfLJYeyjQiWYz24nY/
X-Gm-Gg: ASbGncv/SCA37GA4RCzQkiceZrCOfo/BfGrlak3n3lU3KkHq30gCjAHYB+kKcwM8yQb
	+mR5ACGT/5Z4MCCSyzhkYImzmmMRXaBxpi0xLFti1+J4VSw/JHeVxhFSDrDMhj/Ivq/Up8QA/yu
	qc0YSEg4Ut1TWhNc/deYU5pIj8fbfTVWiLaAXPqCKBr2uGWxV4+Rzk0mFwtQC1uBIuEOAiH758V
	yyBulIpHIi6f85bRenMDgRSacP0r0oD8N3fA43K7hyw0aQGxYpVaPagxTZ+kl3n/evGKAjxIDKL
	7we/SLmXZz8Dm71WhwfYYsNeo2JeAC3/HZEXYWJMZVL9nBvsXMGViZ6K/1EznyMw/h3bLXf2a9Y
	EiaY8SuU7VWW/4FG56i3fshaPd1Y=
X-Google-Smtp-Source: AGHT+IEucFUd0uppCrdOgZW3tAwX6G276I90VT+GnwFylm99xPnt54vCnTtXQgw7HvIviS8Gbud+rQ==
X-Received: by 2002:a05:600c:8a09:20b0:468:5d0c:fb49 with SMTP id 5b1f17b1804b1-4685d0d011cmr59027555e9.19.1758491776164;
        Sun, 21 Sep 2025 14:56:16 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:15 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Subject: [PATCH net-next v2 0/6] netconsole: support automatic target
 recovery
Date: Sun, 21 Sep 2025 22:55:40 +0100
Message-Id: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx00GgC/22NzQ7CIBCEX8XsWQzF/uHJ9zA9IC50EwtmIU1N0
 3eXcPY4mfm+2SEhEya4nXZgXClRDCWo8wnsbIJHQa+SQUnVybHpRcBsY0iCMTN5jyxM67p2eDo
 79gMU7sPoaKvOB5R5QbYMU2lmSjnyt56tTe2rV0v9x7s2QoqrQaNlq1Vv3d0vht4XGxeYjuP4A
 XAfxcK8AAAA
X-Change-ID: 20250816-netcons-retrigger-a4f547bfc867
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=2296;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=HUv/KqDa+7owTqnRzPUIWK9staNfM29PaK/t0/ja1cs=;
 b=TLKs/NnIrCUQcRsQEuPfRPWpA5Yx2ZGDUJpD1uaWibG1wTrHufzQoZ9jK3PGaouaLxrlmSVPC
 RSPEFasBcXcBL0a5R4BbOIbElucgG/M/4xNUzJGyvPpv6uj+ojs8ELC
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patchset introduces target resume capability to netconsole allowing
it to recover targets when underlying low-level interface comes back
online.

The patchset starts by refactoring netconsole state representation in
order to allow representing deactivated targets (targets that are
disabled due to interfaces going down). It then modifies netconsole to
handle NETDEV_UP events for such targets and setups netpoll.

The patchset includes a selftest that validates netconsole target state
transitions and that target is functional after resumed.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
Changes in v2:
- Attempt to resume target in the same thread, instead of using
workqueue .
- Add wrapper around __netpoll_setup (patch 4).
- Renamed resume_target to maybe_resume_target and moved conditionals to
inside its implementation, keeping code more clear.
- Verify that device addr matches target mac address when target was
setup using mac.
- Update selftest to cover targets bound by mac and interface name.
- Fix typo in selftest comment and sort tests alphabetically in
  Makefile.
- Link to v1:
https://lore.kernel.org/r/20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com

---
Andre Carvalho (4):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netpoll: add wrapper around __netpoll_setup with dev reference
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target reactivation

Breno Leitao (2):
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level

 drivers/net/netconsole.c                           | 102 +++++++++++++++------
 include/linux/netpoll.h                            |   1 +
 net/core/netpoll.c                                 |  20 ++++
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  30 +++++-
 .../selftests/drivers/net/netcons_resume.sh        |  92 +++++++++++++++++++
 6 files changed, 216 insertions(+), 30 deletions(-)
---
base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
change-id: 20250816-netcons-retrigger-a4f547bfc867

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


