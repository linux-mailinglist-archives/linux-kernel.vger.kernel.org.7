Return-Path: <linux-kernel+bounces-887535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C7C38781
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5F54EB0A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8E189;
	Thu,  6 Nov 2025 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2N2/Con"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940A70808
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388773; cv=none; b=a/SnZiZKIQhFDV3gAtzZowrFVX+cPySGACH9Tm5tbP0r8mq6eoQX59UePMYX1B3CN/3GQ7o6URQD58uM/yoYK7g1NGHvzpx1mgYXuNo3DvCcICCILvA+4ERnMMp/DprRakzRHbukSsTDlu0sMt+o2jJHlmnsW4RV383JkfYRKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388773; c=relaxed/simple;
	bh=sQdTyr9ih6RF2YPehPL2Ylkfg6TvbUiN4h5OUPmT3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RS07xScZji6gGX6EfzSGY1KH4fDI6qKpqQ2sIuMou9JP2uKzCNIfxMk2Utxj4nF0psQSw++AzlZNjzVHtrqvjhD6pL592SV5F3vKx82/NFdU1evdn3MiLUv6sQbrlOMcpTmKwCdk91S4xBJqmxlY9+jZaFruCjcDd/xXiqeCyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2N2/Con; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787ab220b1cso7751097b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762388769; x=1762993569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTuwJ7NKxX0LIJYOix0ApAXE6uhqIfJ+6m6NHZT3nGM=;
        b=l2N2/Conz/AWKaSRufK7pkjNjymehFxkSS/ZP85OaC7o+CmK2GGVt3d16wwDKfwjOH
         HC3vDt0xbFpYIrsDek46JIKKIlkPG1EUUlI2n6OwnMs299wK6YRT22/g2IYr7X1l4jGW
         ULRiewtPhO8PRNPU1823O46XYy9v5s3G85WRSkV9kduxtxeRqdFH85s9YgCOPrjfWKO0
         bsCt4uJKEs4RBgouVB9yb8Ecu+DuSvosDC9BEwYabTnbtlk0uMH4IfvyEUyL21/3VQ+J
         Ssb+dzj4LoYWHz3w3aV704j51MR3npHkRr5KQFs6xa4j2fkigX7h5/QTuYoqupvHy0+a
         zi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762388769; x=1762993569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTuwJ7NKxX0LIJYOix0ApAXE6uhqIfJ+6m6NHZT3nGM=;
        b=M7DQXSpg7J76lAwNsohj7FFue7clGhGn2EGp+MZPrWnRJU9MUjmIVhLANu32GVLaU/
         s3Mz8EqnQtybXDcWMMSzZYCmB8EUtklnwcw9LTtC2RGaCKruZw3EHVJ6V9F1qwrlADak
         tzwnFyMbqHg3G3nkWKDbXzxLCNzicyYRUEqrQ75NBbxxFHAlvKM7KXMLqQU5A6++srJL
         YXEhgpnLq/9FZeMUn0HhMdqh85UqqefWPBfHY8hU0gHK1xhJSXEbtlwJvb7HYALZSUEh
         k08OEOZmDcAjktEHWiCdlUFSDmwjX1ZPtGfk+bnk7X9TW2vaNeEPSCpxz4/UI6ketCIL
         GeBw==
X-Forwarded-Encrypted: i=1; AJvYcCUO+uwmZWVhQpZNp42pIjpB4j4mv0QvFS9V2LLRC0KGlaN3JvWM7iUx6OHDLuRKUrkkfXn/67UD3Et9y+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjjMGASJ6jgsGtvwnuxbjL3Wcxy80EmXZ0gVyk2uK8KrBjBhf
	uFfIEb6Sf2CfElcOhDQ6WMIBHS5uLHPt/erye+PLmyY0kPUtfcHpDpNU
X-Gm-Gg: ASbGncv/V4njcV4CfaBiC9TtDLdKbPrXv0usK1HgmRkVz7r9l8dV8hBDXTh8yHCKSd3
	ehJ4ppz/Ak/hjy4AQ8ZzHE08CcM0p+Llod4JKMWnrbJ2Urij/v9t4bO/QVrIFapZhUrAzjnkA85
	sv0xQotrS+i1IzN6qeGZGSnlrIDzsYeGqYkxJVmjAuEO14t4VDO3k806W0O7hsoZYn6wa8rxIHp
	Mb+Dt8ezWvgrfUPV+qv3eKfplYBfRSPp+yN+uUkQ2KCnlX0bYIXnwqRyQn8LQYhMhacyQckZxR1
	oOezHYvNFufJlTM41noATWvomd9qAZQVbO/I3Xc1uOGywI8jYhm+cgsAJWovO0lYTxiLMfsqWHj
	AtdTVPFkIQvkBw1Hph3JK/e50mZ0lpXM16abzR0uZJN+1x47X1mWlp0z5V592imAGO5q+cr3JNx
	pLGntpCNU/
X-Google-Smtp-Source: AGHT+IHwPpyD9rXstOAxRuHWvFVIkK6uDGF7BLbIb0kUr+fXh1ZNwp1JjPufwwulH4G7kf37cBrXcw==
X-Received: by 2002:a05:690e:42db:b0:63f:c019:23b2 with SMTP id 956f58d0204a3-640b54aa11emr823736d50.28.1762388769400;
        Wed, 05 Nov 2025 16:26:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d9533csm286607d50.22.2025.11.05.16.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:26:08 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 0/5] psp: track stats from core and provide a driver stats api
Date: Wed,  5 Nov 2025 16:26:01 -0800
Message-ID: <20251106002608.1578518-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces stats counters for psp. Device key rotations,
and so called 'stale-events' are common to all drivers and are tracked
by the core.

A driver facing api is provided for reporting stats required by the
"Implementation Requirements" section of the PSP Architecture
Specification. Drivers must implement these stats.

Lastly, implementations of the driver stats api for mlx5 and netdevsim
are included.

Here is the output of running the psp selftest suite and then
printing out stats with the ynl cli on system with a psp-capable CX7:

  $ ./ksft-psp-stats/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
  ok 7 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
  ok 9 psp.test_case # SKIP Test requires IPv4 connectivity
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ok 12 psp.dev_get_device
  ok 13 psp.dev_get_device_bad
  ok 14 psp.dev_rotate
  ok 15 psp.dev_rotate_spi
  ok 16 psp.assoc_basic
  ok 17 psp.assoc_bad_dev
  ok 18 psp.assoc_sk_only_conn
  ok 19 psp.assoc_sk_only_mismatch
  ok 20 psp.assoc_sk_only_mismatch_tx
  ok 21 psp.assoc_sk_only_unconn
  ok 22 psp.assoc_version_mismatch
  ok 23 psp.assoc_twice
  ok 24 psp.data_send_bad_key
  ok 25 psp.data_send_disconnect
  ok 26 psp.data_stale_key
  ok 27 psp.removal_device_rx # XFAIL Test only works on netdevsim
  ok 28 psp.removal_device_bi # XFAIL Test only works on netdevsim
  # Totals: pass:19 fail:0 xfail:2 xpass:0 skip:7 error:0
  #
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 1 to 0x3
  #  Set PSP enable on device 1 to 0x0

  $ cd ynl/
  $ ./pyynl/cli.py  --spec netlink/specs/psp.yaml --dump get-stats
  [{'dev-id': 1,
              'key-rotations': 5,
              'rx-auth-fail': 21,
              'rx-bad': 0,
              'rx-bytes': 11844,
              'rx-error': 0,
              'rx-packets': 94,
              'stale-events': 6,
              'tx-bytes': 1128456,
              'tx-error': 0,
              'tx-packets': 780}]

CHANGES:
v3:
  - simplify error path in accel_psp_fs_init_tx()
  - avoid casting argument in mlx5e_accel_psp_fs_get_stats_fill()
  - delete unused member stats member in mlx5e_psp
  - remove zero length array from psp_dev_stats
v2: https://lore.kernel.org/netdev/20251028000018.3869664-1-daniel.zahka@gmail.com/
  - don't return skb->len from psp_nl_get_stats_dumpit() on success and
    EMSGSIZE
  - use %pe to print PTR_ERR()
v1: https://lore.kernel.org/netdev/20251022193739.1376320-1-daniel.zahka@gmail.com/

Daniel Zahka (2):
  selftests: drv-net: psp: add assertions on core-tracked psp dev stats
  netdevsim: implement psp device stats

Jakub Kicinski (3):
  psp: report basic stats from the core
  psp: add stats from psp spec to driver facing api
  net/mlx5e: Add PSP stats support for Rx/Tx flows

 Documentation/netlink/specs/psp.yaml          |  95 +++++++
 .../mellanox/mlx5/core/en_accel/psp.c         | 233 ++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/psp.h         |  16 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   5 +
 drivers/net/netdevsim/netdevsim.h             |   5 +
 drivers/net/netdevsim/psp.c                   |  27 ++
 include/net/psp/types.h                       |  32 +++
 include/uapi/linux/psp.h                      |  18 ++
 net/psp/psp-nl-gen.c                          |  19 ++
 net/psp/psp-nl-gen.h                          |   2 +
 net/psp/psp_main.c                            |   3 +-
 net/psp/psp_nl.c                              |  93 +++++++
 net/psp/psp_sock.c                            |   4 +-
 tools/testing/selftests/drivers/net/psp.py    |  13 +
 15 files changed, 549 insertions(+), 17 deletions(-)

-- 
2.47.3


