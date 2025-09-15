Return-Path: <linux-kernel+bounces-816823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D66B578A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4EA188B532
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623482FE59A;
	Mon, 15 Sep 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3syTQ+Z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706A2F5331
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936438; cv=none; b=cDsAktuPWx77DjjtLwSQNaHI9X+s9A/Q6sWpoYpxz9kFP846TXLyVpkJi6Nmf/BdIOc7x3w5Lf5g3pUi6guqJrfFruRu2cMKapyketqhjgLb25CVjvECeOAvEiG6Gs/yzUVMEuDUdSkAPFI941PfNTtISyQRkl9BQIPptUzwCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936438; c=relaxed/simple;
	bh=/L5pK6At8TaftbFwB3g4823q/dFzbzHKMONbQ3wFx5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKHd6wj0oXDPKidv/gTO2Gr1ExnyBI9prALo5XMIO8maHzEnOU5/+szEnGC61aOU20tCM2lBkKrkuo94TDkit/0lHQ/5kr9lLJ5uKtUx0JYKTH81WvYdlofV49QdcrvshoHOLDhh/e+4cW8fKttWx0T5IZiZ9V3iVRkyxYTlNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3syTQ+Z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso40857015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757936434; x=1758541234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrG2SO6pmAXHbgkFVtjT3CbucUptg/RlTro+DaNuLtw=;
        b=Y3syTQ+ZMiW1ESYRY2YZQYqpqRoQWp964NlX4VwBb6DVNV3O7M375FIvAbDVvxOfQz
         GEAZWrwDbFa5FELFeXVkwSqtrxLc9FCa/aPCYHDmv9SHc0Che4lpMrRFmWRIad6j2s9h
         j7UWz8QU02e50yXC8HWK+icpxp/j5sHlMAutxUoeWIjj5bZOgy1UvO3pWAG25t7xeesb
         Ly/O+swAh9Hd0yS1hkXq0fUS80rD7jhwEa+eyjQesoP+Msk9FmLM5fSXNCX32akI560b
         9nMXXN1tY5zX28jFH8eUQwuBKMcJNMND2MzfWi19Hr/MU9MRtJ3gDe10os7s5rpdVqCR
         aJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936434; x=1758541234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrG2SO6pmAXHbgkFVtjT3CbucUptg/RlTro+DaNuLtw=;
        b=E412FpiL1JXxb9GP1/lhpy/xiJE7StG/bgXX9RwE301GOOEZC7+F2SH+Y6OrEta9w+
         tCIjDHgzl/Y2vgJcRktpGi5RKtS0YGUt2aqmdofboxJ4gqye1V03pNYxYGR5/BsSxWio
         +AI2qcarPKsmpIcEn1n0bs5kw7emgESXfqDcVlk64/2vfhFAHacd5+hV6n2keUXeb+Cf
         0c1cPEwrMQfSjWZX8g2Z+8qa264zB3F47LXW5jDy6l9d1KXlVzLQBWKOL7T9K/Om9wlI
         uo9UlsKl7OoepWxutyZkOmUUYgofOtOJ1QTo58aQjqmZ5RNCFKQuCuX4FAmYq0Q5O7Et
         7W9A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9c/DKVATgllQlMnF3wzczxPRoMAJfNveSq3IJpBZ7GrL4B0pQUsPjUkabnJAUoeBiKoOSurCMbXUolQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQz7lwBgYkGTpYVaupDC6QikX04ygepQT5dgvDSNZqkSPJPvL
	yyATs4xkR+NUjr4JDdp264mWuNpVrVMM8WnujU042C8V5gfLSqjqMvDD
X-Gm-Gg: ASbGncuXhN+cQFbywelSQOXf+5gQWCx1gYYraAQS+80S6caYZm1CY8ddDdNM0qeyag5
	FszFBImyD0B0aCxVdZjW9CqqSQp3boEd6QqBCVv67oh6Yl8pFTVNvKGESSRqEQPgrxzdxwNMEMJ
	/F/w8/REHVtnHAgPGdem0ItQ3xJOET5RQLOXeyjbtqFWAPGDW3ab4+XSUYmCHjb+UAiFJR0SgD9
	icdj30oDHc1EOUtizJhVpdyXmShDKKNKFcaMKOhPi1FREvuKCVVDzbCx4y1uq9EmSfowggt/9Lt
	u9wsV9tEa7e+xexNQRFgX+IyVJsvPqNlFZiNyZi7T9/6HWmKCR7q2sVKITsw1Mwq6rv62IaSjNG
	Gz4ooqAoImIR5dsFb8Ifhs2skAjCIciKoJg==
X-Google-Smtp-Source: AGHT+IHqhRVmb9rUlNe+hbUT+gBfrb4voHkQ0nYPxh/42JY+Y65ULBdzDmr0KGWe3Va52LI5AQbA2w==
X-Received: by 2002:a05:600c:4ed2:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f2c410b5emr37850645e9.4.1757936433527;
        Mon, 15 Sep 2025 04:40:33 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01578272sm187063335e9.9.2025.09.15.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:40:33 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/5] net: gso: restore outer ip ids correctly
Date: Mon, 15 Sep 2025 13:39:28 +0200
Message-Id: <20250915113933.3293-1-richardbgobert@gmail.com>
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
 include/linux/skbuff.h                        |  9 ++-
 include/net/gro.h                             | 33 +++++------
 net/core/dev.c                                |  5 +-
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 13 files changed, 126 insertions(+), 83 deletions(-)

-- 
2.36.1


