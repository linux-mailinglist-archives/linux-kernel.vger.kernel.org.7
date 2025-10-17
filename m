Return-Path: <linux-kernel+bounces-857236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED130BE6485
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66E24E18E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC0221F1A;
	Fri, 17 Oct 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBW8AnPz"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C71A9FB8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675014; cv=none; b=DvBt7P43qOIe/BGIgFImdoCK4KXWEiEdgYsmJBYNH2Xrym72AVrIf/dwGQCWZVa7BJA9+d5RHY+Wt1e3yMbIC3iW91rDtbrPyN3hvod3lgg5tptLWPvbdhbbwiHTgWBdnA6uINwJ72/Us4ZVH+jfa0YZMXCsDPnG8uy9udsUQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675014; c=relaxed/simple;
	bh=xlTdYn3ctaCUjwm/bvJufu9sD/yMlLPgVKinrC/dKzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9T6zXgwUbFGEN/lzHmiSq409Ll+7IMGvleSMsEk02i9aQDQsBlaiRkcBCG3hnUIZ7VdVq7c0y1Jp5b1UlaiPTxa+Z9R/PUheUAe7guFFRykequLdVtu7QBldcXnPueD53rIp+xMIV9NmHn0e5JpVKJuKW8YJTkIyNZQkzIA3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBW8AnPz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330469eb750so2053906a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675012; x=1761279812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=NBW8AnPz+hbH4/HO5YOBRc3Yjnv1tWdFqSxgniJU1Dwvn1AcrNgTvEuo1eAYASIoQF
         GSpXsfWEf7YxtxiqLTAnVnVNy3dZS/7sl0jCrjl/cQvdE0Wjqx+tx0hIkvbOSPrE2OTu
         DRGQoxeLXDZbt8LM6VbT9JGtW0ygFoXBJCgNATbqbIL8OcIG/c+H8xwBXdv74kFV6SgA
         KJhvpKl1KdbyHWgqp1zUMCR19OSxQV40xsx22E+RKI8gPDa7J0aZ9MU46/RLuRtt9ZYC
         yqXhPpfo/8cQqzIZuTCpG4MzfS0X2ingfEp1TiWt7umxd6h0TWdIzNoa3gkLuL5OhS6k
         INbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675012; x=1761279812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1LD4bJtaXgmuHvhblZcw2cHe5FWG+R07TopH1OUOIo=;
        b=OkXgaX1x+QajqBFvlRQL5eZC+LP3ZYAj2aPi6EjFOFkpCe/a1h+uKMQcMU9+5fNWfs
         Xi/u8zAR9tc4xY9jqvUF7MdbLU6c0kRV3FQK31Wjh6T81SiUbx6Iqe/DHOIgW7L+E00Z
         8sjsYWh1fQfz7Xg94ua1eFK6XhK3lDDMAl8VGpoQXSlFrB1698Vs9C2QWL3I20nvWr29
         J4XfhqB5vC3XGMyKE4W0F0Bmo0cFCme/P2Et/ZGKJDSyDOFmDrRT1BrKM2VNzc3dbHp1
         14kkDiKUwGR51mAhY9nr+Esznh6SGcZG8pbiGY6LtfWPDVYBSlf1+ay0kHbdMVzptMmu
         2RBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJz8ZvEUEtLw8XMEZp4YniI+inU26BW4MBkhITVhGTX/j975iWAO+dT/A+4AQGbNjBc7tGl9Rpm7TzX44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWf7o5xrqFpPm2H0Q0YsPWzEdWPUiRPJrGuNu9euOMUUKrYhuY
	EElGGLtIliZ6o6a7Xn6f6/WbJ+852Gie17oAhxkgNmj2Mjesfns/4xMS
X-Gm-Gg: ASbGncudGiXnmmF0y9jggrwZxtc06JdubH0lf1MBXt10z2VnJk7FwH6SLNG5MJWZKY0
	4meKMGABu09xruYXDMOD2fK+pKn2RdMo/JGb5B9y1c70LJ36Z7XZ85qprNV75RuYzDXYEh7PrOD
	zWMPEppRQYnFPI1Atk9M/Z7GgJKdEBh0DaimRMc3qheftQ/0PlZOvlpUmt6SXICVtURbRvwCk3o
	msWXzcwpLV1XJMRaQYk2MF6ZHtAnFtCI3SqJI4LjT7R9uYGCbnjqOZahxJ7wGqUv9jIYdU1Ckmd
	nk+1bwQA1dHSZQNnsmCSs4ZwP2y14YfgFLfddGnEfpAJ9nVTjUOaJ+/oI+MldFS5+1pZzGK0Z53
	m64XhNX2SWj0FYyA3uZnmdttovLgp0KecHZZ0CGJXKo+ORD5m54IkHltyqCuSQZtR7cnjSSojv5
	rfwBgCuf1hose3m0clPhztb3WREeIii19as/paYJj/lfo/NU4gcjGSonrIWtUbMpg4i3mGVYwza
	DIk85vcEg==
X-Google-Smtp-Source: AGHT+IHf/fkMawdLEFWrxmlDZmQ5xGwA8hncSDzmuHZwevx77yhLGUBDFp3M4+pUOvAJ23AfWMIQvg==
X-Received: by 2002:a17:90b:4f:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-33bcf8faabcmr2469604a91.29.1760675011886;
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
Date: Fri, 17 Oct 2025 14:23:05 +1000
Message-ID: <20251017042312.1271322-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The TLS 1.3 specification allows the TLS client or server to send a
KeyUpdate. This is generally used when the sequence is about to
overflow or after a certain amount of bytes have been encrypted.

The TLS spec doesn't mandate the conditions though, so a KeyUpdate
can be sent by the TLS client or server at any time. This includes
when running NVMe-OF over a TLS 1.3 connection.

As such Linux should be able to handle a KeyUpdate event, as the
other NVMe side could initiate a KeyUpdate.

Upcoming WD NVMe-TCP hardware controllers implement TLS support
and send KeyUpdate requests.

This series builds on top of the existing TLS EKEYEXPIRED work,
which already detects a KeyUpdate request. We can now pass that
information up to the NVMe layer (target and host) and then pass
it up to userspace.

Userspace (ktls-utils) will need to save the connection state
in the keyring during the initial handshake. The kernel then
provides the key serial back to userspace when handling a
KeyUpdate. Userspace can use this to restore the connection
information and then update the keys, this final process
is similar to the initial handshake.

This series depends on the recvmsg() kernel patch:
https://lore.kernel.org/linux-nvme/2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de/T/#mf56283228ae6c93e37dfbf1c0f6263910217cd80

ktls-utils (tlshd) userspace patches are available at:
https://lore.kernel.org/kernel-tls-handshake/CAKmqyKNpFhPtM8HAkgRMKQA8_N7AgoeqaSTe2=0spPnb+Oz2ng@mail.gmail.com/T/#mb277f5c998282666d0f41cc02f4abf516fcc4e9c

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3

Based-on: 2cbe1350-0bf5-4487-be33-1d317cb73acf@suse.de

v4:
 - Don't stop the keep-alive timer
 - Remove any support for sending a KeyUpdate
 - Add tls_client_keyupdate_psk()' and 'tls_server_keyupdate_psk()'
 - Code cleanups
 - Change order of patches
v3:
 - Rebase on the recvmsg() workflow patch
 - Add debugfs support for the host
 - Don't cancel an ongoing request
 - Ensure a request is destructed on completion
v2:
 - Change "key-serial" to "session-id"
 - Fix reported build failures
 - Drop tls_clear_err() function
 - Stop keep alive timer during KeyUpdate
 - Drop handshake message decoding in the NVMe layer

Alistair Francis (7):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   2 +
 drivers/nvme/host/tcp.c                    | 150 ++++++++++++--
 drivers/nvme/target/tcp.c                  | 216 ++++++++++++++-------
 include/net/handshake.h                    |  12 +-
 include/uapi/linux/handshake.h             |  14 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 ++
 net/handshake/tlshd.c                      |  96 ++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 11 files changed, 455 insertions(+), 86 deletions(-)

-- 
2.51.0


