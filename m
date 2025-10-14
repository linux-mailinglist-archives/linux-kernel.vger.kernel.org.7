Return-Path: <linux-kernel+bounces-852630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E7BD97F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64394FFCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEA2F5A2D;
	Tue, 14 Oct 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epqoEHI6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D931DED5C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446832; cv=none; b=EWG3OkWSlCo/EyNtMiXpAd81BzoGb7NctIFZjp1O+/qUoigpaG48zf6QfakFWEap056B+oZ03ViF7ddRqd5WfKZ+OD2qtBP+P69QOVThnKDzRZw5F7R50RqS9s4mb6nVPaNk0Ypga2THdX7whWfxUxG/6dXmQojHEvIx+DLzvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446832; c=relaxed/simple;
	bh=yC16Cf9FMJscSBzx0tg70+ZAO1nULgzq46Rq7RWDwRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJqqJWHmk6+IR1zavmn96/JfNhuNbc/xmGUaf7ZgVr6lGTg3UlpZ1+kWLrMPyL2bYCU/wv5cDEhN+lRnLaN2M1XwD8uMEyqzpZdiYaa4iWumO2si6+MRGPPmkt/NP0i5jRzmAO98gij8Jhx02wkg5ODtWasMPLB0RpoSiu9Z058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epqoEHI6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3169442f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446829; x=1761051629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drtmDZAOmuCnQVy+ATNHRyErjp9xi9I5nuXjriiDL/I=;
        b=epqoEHI6UasjISOjXZQ5jSX+wK5NAIYmDIcr8EBc1M4BHt4ZYNokrEpVkU1XrNBayS
         PdsasiSjsXFQ1rv7m9urjGR+eAN9YCah8FJTySyNgyUQr/+3Q8A/qH372S00H2leXvX0
         sllY2k9gE8Y73a+1RpJGW0UtpkY0/uo3Cl/gAxVGxoQYnd+6BzImW/OFeT4JkcatAIwa
         IL97z2hCxTbHiJl/VBCVudgqBzK+F3+q3kMBwsYvDzgiuWtYPXylJ2V3TC4g3JQ48slv
         6Hb/mK3Zk+FkEgTc/J7XO5Qo5IRM8sxCxZVnY0tleD1sVjOM58AkBewfMiM5gCYwJToE
         OJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446829; x=1761051629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drtmDZAOmuCnQVy+ATNHRyErjp9xi9I5nuXjriiDL/I=;
        b=E8/cPtD5TvY7P1Z0d5TCAMaIIJHy2d3qFn/OgfNgQBHuuLpcCLHpL/TKYzcXF66+l8
         m1DLF1xgK+baYjrHcY88vsXaxt9xeZedl3Rwu5t0822rtptaLHpfmOcBbujgJWj2Tlk/
         MI6ee+alH9qDpx6UsrW46+osLc8pfv8AROYqHqLjav3XarIaQjKMGnDEBjC2X7soWIXR
         0BiZ0HxN/KUo4GRns7zd1PYZ0z6cA6mQ8B5bkP3329FLr4B78nAGU/vblVlZApx4cmF3
         D89MgyRONcD1sGmTh2yP5bNtYjt1Tu6eNn8EF/PX/0bt/iixAvADU4SvotRz6wwAJL4O
         Dm4w==
X-Forwarded-Encrypted: i=1; AJvYcCVkR45U5k8oUsXHlfj6wGqbPUt7IvvErsFQf3jXez/Y+uWgmv09SVYAILdRCgl+SFRWQvwWGyI7/SOy078=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahXIL//Jg48SAA6YpZQpi0bERyr9R//aFnTi4SdMp51m/Y2cv
	ohFU7Mls3PmCBovefMCikvWq3VqgdavRqutMoK/ajOwFyCyjZBFD04v8
X-Gm-Gg: ASbGncsyuXSk96334KjJeaTFv6p8pcd0GgsweObnwz1A1Yw/bTqWSjS6xqgD4faFxaO
	8y59BNLusCGLhPa2AFyMSIK9pTLz0H1BFsX6tyOB2iurdIokesJyWW0N8c5j6gswwrYn8mlPU/3
	ftIhxFVKElj4z+3NRvxR3t/GGOLA2qcph6BXeds/pxtFIz5/WGdgkNTeqxN6Ug0uUJSgXTYuZoa
	aU0ZEQGqWwCx7zZ/qi1IXmBR5n9EDdncg6oLHCkWBo+k9jODIfPpyFAlbFFLwxqdkVExYbuRslP
	WzY9ZLb9cuDpHzNoUgLm6pR0q1fjeYeqJhVkgoOuVuMByQrYqFQeRsuPiFWv+AUmMyf+CPnh6qe
	Wbkx6uPw68oRJ9bBz3m8z85/Nst/quc0bsc8=
X-Google-Smtp-Source: AGHT+IGQ0Gd56K7JwPfQZZ3tAk3u4pF1GdKS8UOWl4Tdgb55qv85ApxtPpM/O9AT16A2P/7TiGsfKw==
X-Received: by 2002:a05:6000:26d0:b0:425:8bf9:557d with SMTP id ffacd0b85a97d-4266e8dd3c2mr17404314f8f.44.1760446823887;
        Tue, 14 Oct 2025 06:00:23 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:7ec0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b39sm23296494f8f.15.2025.10.14.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:00:22 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 00/24][pull request] Add support for providers with large rx buffer
Date: Tue, 14 Oct 2025 14:01:20 +0100
Message-ID: <cover.1760440268.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many modern network cards support configurable rx buffer lengths larger
than typically used PAGE_SIZE. When paired with hw-gro larger rx buffer
sizes can drastically reduce the number of buffers traversing the stack
and save a lot of processing time. Another benefit for memory providers
like zcrx is that the userspace will be getting larger contiguous chunks
as well.

This series adds net infrastructure for memory providers configuring
the size and implements it for bnxt. It'll be used by io_uring/zcrx,
which is intentionally separated to simplify merging. You can find
a branch that includes zcrx changes at [1] and an example liburing
program at [3].

It's an opt-in feature for drivers, they should advertise support for
the parameter in the qops and must check if the hardware supports
the given size. It's limited to memory providers as it drastically
simplifies the series comparing with previous revisions and detangles
it from ethtool api discussions.

The idea was first floated around by Saeed during netdev conf 2024.
The series also borrows some patches from [2].

Benchmarks with zcrx [3] show up to ~30% improvement in CPU util.
E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC, napi and
userspace pinned to the same CPU:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

netdev + zcrx changes:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v5
Per queue configuration series:
[2] https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/
Liburing example:
[3] https://github.com/isilence/liburing.git zcrx/rx-buf-len

---
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-for-6.19-queue-rx-buf-len-v5

for you to fetch changes up to f389276330412ec4305fb423944261e78490f06a:

  eth: bnxt: allow providers to set rx buf size (2025-10-14 00:11:59 +0100)


v5: Remove all unnecessary bits like configuration via netlink, and
    multi-stage queue configuration.

v4: https://lore.kernel.org/all/cover.1760364551.git.asml.silence@gmail.com/
    - Update fbnic qops
    - Propagate max buf len for hns3
    - Use configured buf size in __bnxt_alloc_rx_netmem
    - Minor stylistic changes
v3: https://lore.kernel.org/all/cover.1755499375.git.asml.silence@gmail.com/
    - Rebased, excluded zcrx specific patches
    - Set agg_size_fac to 1 on warning
v2: https://lore.kernel.org/all/cover.1754657711.git.asml.silence@gmail.com/
    - Add MAX_PAGE_ORDER check on pp init
    - Applied comments rewording
    - Adjust pp.max_len based on order
    - Patch up mlx5 queue callbacks after rebase
    - Minor ->queue_mgmt_ops refactoring
    - Rebased to account for both fill level and agg_size_fac
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi().
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters.

Jakub Kicinski (1):
  eth: bnxt: adjust the fill level of agg queues with larger buffers

Pavel Begunkov (5):
  net: page_pool: sanitise allocation order
  net: memzero mp params when closing a queue
  net: let pp memory provider to specify rx buf len
  eth: bnxt: store rx buffer size per queue
  eth: bnxt: allow providers to set rx buf size

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 118 ++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 include/net/netdev_queues.h                   |   9 ++
 include/net/page_pool/types.h                 |   1 +
 net/core/netdev_rx_queue.c                    |  14 ++-
 net/core/page_pool.c                          |   3 +
 8 files changed, 118 insertions(+), 37 deletions(-)

-- 
2.49.0


