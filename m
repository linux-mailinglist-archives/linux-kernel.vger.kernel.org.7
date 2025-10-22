Return-Path: <linux-kernel+bounces-865985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C3BFE7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB0F18C73E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14714309F0E;
	Wed, 22 Oct 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BZWmGKO9"
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BC3081A3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174825; cv=none; b=LCMZY+UkSw7y/DRmbUAHaK6YFiFf3u3aRSw38L1L6YfXQCvCdQLxE0gDhSsMP27LtxWiV7egxIu7QuhQsMsfx+njQOoa1mDmndaEaqg/xYvIr48FHJp+Papez98q0lrKXDifA8MqROUZzHnARxAhw0C5s/B7rt1zLcyZlXFKcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174825; c=relaxed/simple;
	bh=+8TQGyg0ZV97+kPFYJBnRauC5Q+QxqG5BEUv/mu4y9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebC7TohJQrU3OXGTjXqP8c5CvddaZgQ/QgPjor9JE8pPkdux0CfPhs2ZKIsHfWv9ei5Nw7ExBvzCak9+9eSqIQS8M7Z0V1SXOFBZuYIIIcXpWgxWzNyT0U16gTH79yPccYlIfHifNXtnQU5omKclqq7KjTRU9vfCaZzRCZa/03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BZWmGKO9; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-592f2d0d3e6so19814e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174821; x=1761779621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=BZWmGKO95mD2clfYM/PYqVpX7rGOPzXaBNdIxo6ldORmYIU9uBypqtCxh4clf8sg7p
         bbPfaMsN7iLQ3zmHfVqgp0KZOJTmocZJh605cfVR6RZ4eyuZEiryrUz3UjN6sJcbRuLw
         8B+Fd7EYoRGQnTx1q4yLgQoa/iMRapBsKvpc+cu8J5u96XjxcKdReTAR0i3usD+gUIre
         5xBkmT5LrdNzzrK7Ea0M1dpI+W25Hwuhn1oeXWrTL6cRWN18YvIfFRWWY2/QkX2n22G1
         iAWc4OQMve7TJLXWQbXzftDQIj1GtrxTS5Zw+8nVeEACw2dcTAO60Gd6UwnK9A8E7KtU
         3Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174821; x=1761779621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=lL08Y14J2nsru1yuOdKrig6X1hoq1ZnhNeYQiZgyDrnQv7lKu5EvCJengLfLy4u0No
         87wWG1P0BvXvCah3tiyfjQf6Ni1qA2g2ksKK8NUMrRBv59MNtAq2sENsC3BFisix68EV
         M3XUh8ovvRjpaU7UfuRRZ7AvD5rtEh4HqVq59ZPiIPbnge6WVgD9Fq6NK9QqLajuTTfC
         Dinu+3FHq0uWAj+pGbR+GuAyGz6Tkykl2bXn25qjU2PJydDgQ+istHyB/RCwNwAjSQ5g
         bTwj6KO81UHd6NNf6SdK/RM57bOlIgcA28JhEB13iQQeKLSKBsbTR0pAMAnXVjUQ7x4A
         D5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWDXmVbtY7zllXzER39g4SvLC1BVvV52KvK5xAiWQZpcBinJ6aOhONETfU/IbaMednyw8yiByE/mBt4yfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCdOFe5xa2ORRLAU+7GezvFqr/z0M/e3+vMTifMYslYygI+lJ
	OpIHk1TYzTPsMwJOaiHWm/MfErvrBkbx0MVdfGri7Bl6bDvZIwB27EDls1M3jm/i3XYQB7zS9bj
	YYyoG3W/s9w+BPS3l5Cd4uE4eBl9HEpS9B1+Lz8D3OQgWJ7/6DZHV
X-Gm-Gg: ASbGncu2N7vayf1/BdHpH0R15I59PxJ3kmT+W989Lj2MnfCZCm3PfVpdt32rKxP1Dan
	oEwuF8PEydzm9T07RKSiCEZMFFuv0QSCOnuHZgYK7bijmXKOzRRDiNRDlQ0JwxfUL7Z16oEOv6Y
	M3YBV4sN7gV7cCBQF9VAh8AsSvZDZoScPU+wkyDOlPajE/XPMd4efEPmPBh8h9+Nf1pn4qSZy/X
	jJYCTHCoEhqWEuJnivfNFSNsnzIODicGhy8GTCfVqgrXWmX4e2nX/Ufni54oAbXdu3g80NgrxTj
	NojIZlv/kTfNBl6zQa5l4gHBDPEGhNJmXIwwvkULCQqua0XgtlXqz+JRahECh7pUWIu2Gm9Tw3Y
	xiXZO06lXw3PukjWJ
X-Google-Smtp-Source: AGHT+IE8YXW1bqh82Pv83CqBL++4EorD9wKI8kSNSxyaHaZobY7QUQj2BR1bXjAEiGky/6dYa+2+odrIWp7W
X-Received: by 2002:a05:6512:131a:b0:57e:ed2d:190f with SMTP id 2adb3069b0e04-591d8598d06mr3612400e87.7.1761174820409;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4aa2259sm40463e87.0.2025.10.22.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 86E1B340283;
	Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7A5DAE4181C; Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Wed, 22 Oct 2025 17:13:23 -0600
Message-ID: <20251022231326.2527838-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a io_req_tw_func_t wrapper function around each io_uring_cmd_tw_t
function to avoid the additional indirect call and save 8 bytes in
struct io_uring_cmd. Additionally avoid the io_should_terminate_tw()
computation in uring_cmd task work callbacks that don't need it.

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  1 +
 drivers/block/ublk_drv.c       |  3 +++
 drivers/nvme/host/ioctl.c      |  1 +
 fs/btrfs/ioctl.c               |  1 +
 fs/fuse/dev_uring.c            |  3 ++-
 include/linux/io_uring.h       | 14 +++++++++++
 include/linux/io_uring/cmd.h   | 46 ++++++++++++++++++++++------------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 ----------
 io_uring/uring_cmd.c           | 17 ++-----------
 10 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.45.2


