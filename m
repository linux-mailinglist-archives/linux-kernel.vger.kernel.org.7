Return-Path: <linux-kernel+bounces-828650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2235AB95191
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A671C1904C50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9131E880;
	Tue, 23 Sep 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyt4risZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18831E0E3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617963; cv=none; b=IZZhvuopRkI13TKGGoQ7kr5DE8v5iMVJBPyJSp4dt9o6nxJ88miZPbkYDCI9Lok4KO9ECKN9tIe6WqZri90rGO5wkWYySObyEDWoVQhx2L5WQwx4o+j9YfsRF0U9v1hK8dMkBRtGY8NFYrnFY9oTke62eIz/kQ9S2+qGlkCTxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617963; c=relaxed/simple;
	bh=Ff3wsakldoKjVsybc922K8tiJTSpuhb+b2u48dEYPnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHuVAZgOCbGijJwOc9YwNwGyYJE5OtlMMdeYvUN/Th0E2/YgNPm//6c6854uaJKrT8LzdmXmtw+h8z5iRVQ0L212HbZ6myhx2Pj6ATi68jB0gNprqGhZL3NedLeYCBYLrup6AmwsvdVPtVQ3huaYw6fbpJuzQ3oOAUX7mdsoA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyt4risZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so35120715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617959; x=1759222759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFWyATSfpVmFqTHer4QnnzA9/eMYqpzK4W6xg6dmXUw=;
        b=Zyt4risZ4tBBJdKBA6TND4A5v8on5gu9iqXOh1eBXeYsgSnOknn8gvFpdTojnQqccn
         j6th114HA+9wvieUGlJw1iTyVsHw3uKXo7/KizTjpzzMqqDD0ytef4LwU9mWoRsg6HNt
         0yd+3E66ndu6GhlrnGPP8z7Z2XxVT8EQGWu+M368jvuBUFHZJohtY4kWRFd6MTGrUZVr
         bPcommV9Dmq4Ut71kXRgzDctcVQtjSBsKyGIQDhr5BQ9wcR2g0v0TAVXttOCKCIKo9eh
         rOrc/o0RjIywADFKJVm5EfrmasHwmA2nJ8khcCK+zfg8jXlUEk8InfbD7yuSPRLKgCDJ
         /gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617959; x=1759222759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFWyATSfpVmFqTHer4QnnzA9/eMYqpzK4W6xg6dmXUw=;
        b=RO/kHDLDcd9TA0EwpBziGXl83GNA+gn7sH+mIqwKCy/SZ3hh1nfeZSQn7Dop46ih7L
         T15apLqsn+81nEfQl7sPHTd11J+EwFNr2zAv8KykAWNVSApPQb3fxnugDF7LF4u23/AE
         uti5zr7oqSzfal2c6LJRQ38p5KcBv6zDgtfllq10P8KXokqz9/bpGrghJ4vdMZjuDhpX
         pOm/5YO4uT1ByAbwXUJqYXy6pGaBzX81UdJdblYmCNXkp+/9y5d7xroyep0M2Ta7dTgH
         DR6uCXZSAWLp4rgaGAsoVKHhQwFpghAasbzj6MlIYihXVhAKNcZPYKB+lpZK8QbR//78
         GDBA==
X-Forwarded-Encrypted: i=1; AJvYcCVps+M5C7LW4BpzpvIcDVZpNZsO+TUB/zYDCQLzdamJwp1gcn2cTGD9kCA6Vw76CpzQOfyg8PFsMx5Esbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykH3anPekwNquzbL9dD1oE6cGJ1DDYaAHJqS5mkv5mqkgeq38J
	5S5ZBTE5jx1n5DOhd4Txd4ntMLZnkJc2kOOmRHVv8pDa3JoCBHYjdub8
X-Gm-Gg: ASbGnctwMjcVubTHLx9J01c6CSkQOdOPCtEf5YrhHJhgDxBaiFICo06fsDKFiu76Ywp
	U+s9MTVkefsMA8Ls6gbC6GZPYPvZCmz6D+eIVYT6sulhLcPI2cdIRWnm6uosVRX+d1wUC2rT9xH
	G0NVr68CxI/6pAkGm4AxtmqwKbB5fAxePu7o66NemzD9o+4Cs/azaI3ifLaOdQDVICp8bozZkMN
	i7VJeeDTIYrSotlNoyrlqbjGdLts83NKeKkc9zwolBm5d7kJC6ujK1nT1EGMYdscdlDKmdseWPH
	ATXCIyS+syO3EyL676+UER2kBwfCwEcieVpNE/NfcmIclpXDJ+wmHIbdrS39fhmzkMEcNQ+naEY
	Tu0Z2yX6FYVhC+sa8KYajur1G3xXQ/aWb8w==
X-Google-Smtp-Source: AGHT+IFQa9rL2dZIKUFX147Vp+1LmNLcm+9xvb/xxS/UaSnExqtT1g3niRFM1wKoScQm4YkKXNNcmA==
X-Received: by 2002:a05:600c:1c03:b0:46d:fe0b:d55a with SMTP id 5b1f17b1804b1-46e1dac7b3emr19082355e9.33.1758617959125;
        Tue, 23 Sep 2025 01:59:19 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461383b7b9csm277904675e9.2.2025.09.23.01.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:18 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v8 0/5] net: gso: restore outer ip ids correctly
Date: Tue, 23 Sep 2025 10:59:03 +0200
Message-Id: <20250923085908.4687-1-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO currently ignores outer IPv4 header IDs for encapsulated packets
that have their don't-fragment flag set. GSO, however, always assumes
that outer IP IDs are incrementing. This results in GSO mangling the
outer IDs when they aren't incrementing. For example, GSO mangles the
outer IDs of IPv6 packets that were converted to IPv4, which must
have an ID of 0 according to RFC 6145, sect. 5.1.

GRO+GSO is supposed to be entirely transparent by default. GSO already
correctly restores inner IDs and IDs of non-encapsulated packets. The
tx-tcp-mangleid-segmentation feature can be enabled to allow the
mangling of such IDs so that TSO can be used.

This series fixes outer ID restoration for encapsulated packets when
tx-tcp-mangleid-segmentation is disabled. It also allows GRO to merge
packets with fixed IDs that don't have their don't-fragment flag set.

v7 -> v8:
 - Directly reference documentation in comment

v6 -> v7:
 - Update comment and commit message
 - Add BUILD_BUG_ON in tcp4_gro_complete

v5 -> v6:
 - Fix typo
 - Fix formatting
 - Update comment and commit message

v4 -> v5:
 - Updated documentation and comments
 - Remove explicit inline keyword in fou_core.c
 - Fix reverse xmas tree formatting in ef100_tx.c
 - Remove added KSFT_MACHINE_SLOW check in selftest

v3 -> v4:
 - Specify that mangleid for outer ids cannot turn incrementing ids to fixed if DF is unset
 - Update segmentation-offload documentation
 - Fix setting fixed ids in ef100 TSO
 - Reformat gro_receive_network_flush again

v2 -> v3:
 - Make argument const in fou_gro_ops helper
 - Rename SKB_GSO_TCP_FIXEDID_OUTER to SKB_GSO_TCP_FIXEDID
 - Fix formatting in selftest, gro_receive_network_flush and tcp4_gro_complete

v1 -> v2:
 - Add fou_gro_ops helper
 - Clarify why sk_family check works
 - Fix ipip packet generation in selftest

Links:
 - v1: https://lore.kernel.org/netdev/20250814114030.7683-1-richardbgobert@gmail.com/
 - v2: https://lore.kernel.org/netdev/20250819063223.5239-1-richardbgobert@gmail.com/
 - v3: https://lore.kernel.org/netdev/20250821073047.2091-1-richardbgobert@gmail.com/
 - v4: https://lore.kernel.org/netdev/20250901113826.6508-1-richardbgobert@gmail.com/
 - v5: https://lore.kernel.org/netdev/20250915113933.3293-1-richardbgobert@gmail.com/
 - v6: https://lore.kernel.org/netdev/20250916144841.4884-1-richardbgobert@gmail.com/
 - v7: https://lore.kernel.org/netdev/20250922084103.4764-1-richardbgobert@gmail.com/

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../networking/segmentation-offloads.rst      | 22 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 17 ++++--
 include/linux/netdevice.h                     |  9 ++-
 include/linux/skbuff.h                        |  8 ++-
 include/net/gro.h                             | 32 ++++------
 net/core/dev.c                                | 10 +++-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/tcp_offload.c                        |  1 +
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 14 files changed, 129 insertions(+), 84 deletions(-)

-- 
2.36.1


