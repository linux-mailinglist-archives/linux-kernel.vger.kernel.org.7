Return-Path: <linux-kernel+bounces-826900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA6B8F98B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5554A2A0AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E964275B03;
	Mon, 22 Sep 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBTCA/yH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBB26E718
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530477; cv=none; b=S4OwH/Ah+tOWSTwxFmje092Tw98Mqaae5vKyR+bE8KZQbXlt0ZrDou5KKbM12qN2x8l1QD6cBer5GwQQchSSKRfw6IhyBrmZff2CDHjBfU1InKJ61wYvtj7HN568fJmpcl3DTrWzBWQfASGMxRrXABQD1uJCfAbV3/lH+0ITyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530477; c=relaxed/simple;
	bh=IgDmUWmAz3k3xMYGbslmykc44jrCG/h+cJ2EcZIzq7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hzQIIPHtUhUbR7+Ipv+bI9bmBhZaPfGUk2YH36kZvElkCtI8lc2TdG6yVflkJCvy9wu1HIYTWgU+IorNdtxib1ngmPlundHyREjNLQGA4buiBjg6iFHO7JsIc6TSAZxHwqEh1U2N0OB8YC3xXqCdosMJKAFikLiqE61rcmXfJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBTCA/yH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso12889895e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758530474; x=1759135274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBlTOa/JIIU4AN6VgsnPXOfeNO8zUmXwwSI0iEAF4tE=;
        b=SBTCA/yH+ejLjouKu0YUJTzyh0BZOCqC94BTGFvG+yyQOQ4an/cWrqaqREHnVpiYTZ
         kc/0Fkf9sHNzwIeLyntKoSYMe2bNdHC2eBW+IbSs7I8MKDX8FIm8mMZmyDwourixnRch
         +OAOVlyzLRqt8+A3FerLWVMOekcG/GG9sPAd2/qrB7bHdlS2/ylhzXborBwbpwbtirXy
         R+XH+tqwHViS3LTi9ckE2HNSPPjB1BWA+4/igwt6C99yMF2L1GDgFncI3giiBElRG4+d
         +rm10+QMraVncE/QRB8DjF4X1Pp0QtiPHMQ2trGfcK14nWhVoF+4hvwMF6GIi2xhp2Xw
         Gccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530474; x=1759135274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBlTOa/JIIU4AN6VgsnPXOfeNO8zUmXwwSI0iEAF4tE=;
        b=qHIysgaCb0lkx7wXDBr2OOl6u+HcPvDJUxPryVWcKwZsmBBTbx7KzcvLxLsQ5qCQq8
         jr3r1lqkYZ6PF6rqlkW79ZZvzAUiSOPx52cK4G7ul4iZJd7dbAc6sgWlOV+g2ixqOJPS
         1pjJWVNHVlmDbGfrXScy8yE+pylbcupbqUboE1bWfhrV92X3JspDlxY6UcP+S4mV1gW7
         TZLD1s5VruQw3Y8BAoUJLwkrEVjWL4OIG3pKpCvdNNzp8yIu3y2wybi+ogcqvinvvhX3
         uRSn2OhdLOt7wC05kaGpGO9c4USJf9YrPmX030iCAtSO4pzuhI/wzBnqdtCfeskU2XZl
         /4XA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5GiPwF5wqCjCi0d8ijVclT1/f6AzfnkBFGONqii2oZbozsv+jyhS8erNfAn1VtnNEim8reu/ZELcl3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczqN+PBI4U1Vw1V9X7Jk4vwXJc/GaNaZayVlVmRMkbVUIFhuu
	3sOR753guzcJQLwDWOpvsi+rlftwkYAUh0phGaMEC5Lk+GvT+AwlBHdL
X-Gm-Gg: ASbGnctNIA/cI+dLTAQWDK4XUApRQ3L5za/PcKxaTqB6kMkFYL8sOExoCGtXd2k1ODw
	L8Dz2OhjVcFLxJibcaC/uPD+c/tr9JFvVnIzf6M9tzCFIiQmDekinJ5kKOvreHO3msZjZBu1cSU
	EYEtw2TDbxKPg3P63wo4yDTXwu3j/TtDcNvMF+Um5arJJF/zsTogYHrkxpJiWaIuHkuxM/iz12E
	I3f/qNa2HTyXUOLhfKUxVTZH0Vdj4XJ4y9wQ9ePS3RJaKMsWSjy52vn+nZGFB7tOq1mboLRmOTF
	vlphPPxGzO1u2ce9Rv3IjMSNNAs8hfGJWjc1u2Hpu58bQkANt7g5KwunY6uXR7B4+AbC/8vaYQQ
	HPpqhTkJZVm9zDvJfI8F/3gc=
X-Google-Smtp-Source: AGHT+IEEpjDF7/jDbuuZ9uvE77K7VPyrIf8uLU6V10I88hb6CbUenR9CJX5qSU2VbLrTHzh5Qt1MHw==
X-Received: by 2002:a05:600c:1511:b0:46e:19f8:88d3 with SMTP id 5b1f17b1804b1-46e19f88a15mr3866775e9.22.1758530473602;
        Mon, 22 Sep 2025 01:41:13 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e09f879sm232005265e9.19.2025.09.22.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:41:13 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/5] net: gso: restore outer ip ids correctly
Date: Mon, 22 Sep 2025 10:40:58 +0200
Message-Id: <20250922084103.4764-1-richardbgobert@gmail.com>
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
 net/core/dev.c                                |  8 ++-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/tcp_offload.c                        |  1 +
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 14 files changed, 127 insertions(+), 84 deletions(-)

-- 
2.36.1


