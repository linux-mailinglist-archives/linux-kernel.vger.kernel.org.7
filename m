Return-Path: <linux-kernel+bounces-819067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0DB59AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DC01B24398
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1E3469F8;
	Tue, 16 Sep 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqQCcOZF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808D321F3F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034132; cv=none; b=A3xDHIMJjGZrj82dnyRXUiyZTmH7wf42MD1LqJsB0cwuAg9PvikB4+jrryVoOchTwwRKbi2v1PIqxPNgQN1kjnBGU9DgSwHhrJD8ZkjkZkMcLJgOaHMfgQSxh9I3IqE0ag2dZ4FqVUOl8Rxcpkj6Xw1VWGgBkkb9QdyywT4JuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034132; c=relaxed/simple;
	bh=rNXTzd8y/wZluRg6Jvfxzqflk4W6xg+4K6b4ed4H3eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bxtxYSi+62PkJmeNhdKACO5FGrB5iVAT3+f2+K0hfHenkAMBXLF+sZYarYk6CMhYMLnkcV6/+g4ed7m6t/T/9xGGdVu9BbWpHL+TopUza1SAzzElMjE47cN4ndMqBTsnyCMt0NvcTselXkJn71Pjl99k7nRHssIaohQGbhqxNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqQCcOZF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso1749244f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034129; x=1758638929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gi8igtDXG6yISj4lOwkgI+AubBkRaNNUbNn455YRy4w=;
        b=lqQCcOZFyikD3mCy8LKGK/u4u51SYo67+ASJ4Kb7Az2xrYM2egccgTodONIHrWQ98E
         ZkeedAfBr0k7IRaQ6eIS2rLRiyZNPtUop6x9GSSCwqdN11dPg0hMVa7ComELoEr5yyik
         u7Gu56BmqqdhyfDoHdULH1tB07Kw6k0Gq7bbvKkxiDhjNdVPdmsGgfg5fiNPwsF4Ycxa
         8NRlZ+v5LFk9PEk6pJl+i/9ivQusziOT+SuAQEDZY4aUqN8NhevJRDZ+9nzTulnzJoaw
         /NMEq9JproZ9iMFmSUWB+4cFa6wuWAnN+BbdTiYDjTp9Xn/sOrf+IDgh/C+lJA3fPzw5
         HUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034129; x=1758638929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi8igtDXG6yISj4lOwkgI+AubBkRaNNUbNn455YRy4w=;
        b=bfu4CjmM8dLq5cqagCyaZh0mgrjSM7egcGQTsp7atHxk9NN++TeHMYRJa0xL3YSIG/
         zbhrf7Fkws1zeVETZbJ6VONyeGKT5Yuio0N5AheKTThTY5ljfwYMGpWN5CWHEGQXjkh7
         UvS6oGVTyFoC6+5ECo2j8YYKYs47f40tod1/3K50r2kRMW6txzp4qkA0IGXWpldvoj8o
         xTTsJI3HemtU9XiiVFbn1BDbL91PnkVIx39hQrbdFgCrjYHhJsGlWL82w82gZzkrAknS
         nv18kyJ5s8Keum0ObYhrtIttWcNHRQCwZioDnnFrjDMHtc4cOJvYGuoTmR7VQdvNp3pZ
         FY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSErhpTK2ULz9LC/iy/r6G+clDkWjuCdIy5r+WCXj0gGO+N9cSGhEP8UeRla9wDjA00Nm/bu4JYQRRbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREtH86UJWG9sNRXt6I7dih/O7/os46LPv27gsW+42gJeZ4cQV
	kSHXLqVqmriHCmnbLRx0/G1AnuJFPvQPYOhQE+FfwCPLXQxAVqatC+dv
X-Gm-Gg: ASbGncteVu3FRxYK4ugMRp89MBf9+6GI1DLA7k4K39Fp4so671p7mNhV2/RH97rsXKp
	Q3H5SlB0q+QsLK6Me95zIsGI5RNqUKyx/bDyAXCu8dTQ+p/bxJXZeLW8sOWhp2NVuTW79WhmUSl
	Kp55xhJeERwJa6BvQUTOfD7GWfox6m1ygLXjrE+cAkRwGOyeYgGWqTflDnUj/1qp7B/HUkIWCwL
	XiC08gthDg5usYDblnc98vYLsKzKXG97U60y4jzFum85kNiDiZoKl9qOoqNZn53kAvzP3YTqPeJ
	+ACiN4HYlMDvnad3n9V/6KzDwUhYdrUvgL39I0czVCoeD8t3MgxSZV0u2F1C7VQ1K6lhysTzRWz
	/0Tdjf+x5LCGjKwc5FseH8Qoku/CF9c3N2RIU49zfVr9M
X-Google-Smtp-Source: AGHT+IGT7w/chOq0xQ5oMWhmAwb9pTJAk7OU7dgxbXf0jDuUrdTnKUuAju0yoQhH6wGHRH+wmsMvRA==
X-Received: by 2002:a05:6000:250f:b0:3e7:64c8:2dba with SMTP id ffacd0b85a97d-3e765a051e9mr16033982f8f.38.1758034129317;
        Tue, 16 Sep 2025 07:48:49 -0700 (PDT)
Received: from localhost ([45.10.155.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b3137sm232324935e9.19.2025.09.16.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:48:49 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/5] net: gso: restore outer ip ids correctly
Date: Tue, 16 Sep 2025 16:48:36 +0200
Message-Id: <20250916144841.4884-1-richardbgobert@gmail.com>
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
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  2 +-
 13 files changed, 126 insertions(+), 84 deletions(-)

-- 
2.36.1


