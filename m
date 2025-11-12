Return-Path: <linux-kernel+bounces-896487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EBC5081B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D32A3B2CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862852D663F;
	Wed, 12 Nov 2025 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1YwtTMb"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFB2BE035
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921689; cv=none; b=ePI0V40+nEmRKpYn12AIpDCCRYwXuqCxwiykk8IOin7yRfNJGfrYE4BtyMGrwRvsxkDvnUJHGurCNanmihMVMscy3LpK6SQDUnxRF56d72ARDSbnN2Y9Xk31NbBQUgqv/gVRTx/xyws9KcVYNq/YVFXWOjURMaR18qyEVIRAy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921689; c=relaxed/simple;
	bh=y29hhM9bDU990mFxxu/b+W/znqX6em5uaKBZyOrkMpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMqeraE7WCiLQKY+8LOWtBMzrMt9I2frKV8UeJ1cyuOcyAFIcgGBP2VHFxbxJmBR2B5h3Fx1wJdzPPMOFZPcKr9hVAs88WJ+bV2NiQQz2v1ZJNRoYZzQAJ7xKmja+STg8AB8byE9yK4vPC7eYEecH8scvCpc0UtB1qMbeJQziqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1YwtTMb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34361025290so382407a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921686; x=1763526486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWcPwvpyGHeQ7Te8LbmgWrzKDF0qH1U1PIJiFE/G1QA=;
        b=e1YwtTMbVuT8X1S15zaGGiDxW97fQdarMZ1wobpDWWt3YrkBJTMYbqwfHl/5kIwdcM
         vjdIIxIA3+LDjKVsnEeVfoyZhnH1rpcrWMGU5zHknszZdQ6Kk2nH4FRJ6tVU6uw6+w2Y
         KGMkuqPjWvRW8IdQ0vPjT6RvOdIWUDUHjdxKKXLTmPoOjcE/yUw8PJa1oTubLhDWeMos
         Yt1vDu6gNyrPCAHA0ioFdnsBxA4CJ1C2DnfdkvAQJeeODMEHkkk59afpE95xRVfcapnu
         0mbgtvMhcLwiXCdAYUyMTBVRAvOmoNkWCdrt/6D5smP2yFKgKHXLxAGHEan4CLJPdy2o
         peiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921686; x=1763526486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWcPwvpyGHeQ7Te8LbmgWrzKDF0qH1U1PIJiFE/G1QA=;
        b=QCKhFJ9McGXQbk5EFx26xth7h189qpoBCe7AYNpzHgLuKuJ7dj6qKIE6VCs2Tzx+De
         FGJflOjN/rS+CwZB9FMNRKZ/GmYuxoR9qEeXYERBsaldUq+erROSG0j0DgGZDgAnXQtm
         ZMGbPMX4sfPEfXSvSUud3o89kf0y2F8cOthCWPMnY/G12AeO9hBTb/LNvlyuzqidkJ/M
         Cw6yCdjL3S+bZCQhWxyuZbxqJOUZokdh//uIWiXOs7EWpLJl9rhknW3f/SSQetmiE8p4
         LB7ESFh6FIecqqvb2B8jLiiRFVS6vxhzF0bVIHSkriPAFISWJOYcbB0UIoW3GkbuOPlo
         oQKw==
X-Forwarded-Encrypted: i=1; AJvYcCWXEyWBEdb20lN+ZiMUCGXXdzInTjKCR+UgCKUcAiZD5zRScGMekexpQPNxMS59v82XJ1iymJVXeAMzx8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBw8bu+fJWmAp70UiyLqKiJ/RLS9fsYure3qY0oR9gu2bRGJI4
	oRvWS+9h9muPU9IadLRE0e2Uz4Qtdr8BifexbTcnaj+d7E8z7UpmRwEx
X-Gm-Gg: ASbGnctIzT17GdBjWTxyMMwdDS8exE6+qRHZkYr5cJzMBzjLoHWKPtkVY/D4ILzdi4m
	2EgW1kGtfceflY6qgz8oQS8LbC2Ca00S6iNJZHtrRt8/LWCqei/jZa+HbL2I0YpMUOMnpzatPMv
	lmWdu1Vpvkoo5Inu55dGlBqO4GLNwbySD2rebhprsMCiAPWlKDvB3lp8rURpg91HuesDFJ3RMcq
	KsdUshhGqiDd4Koe1DuqpZUQ39LT3tH6KZjwmmh6om8eO+nX0xpJEVQzWIWLviWtixRvMCxcXXm
	nypXcH8ecg3SyfUei6R1kLvl0Bcv6MbbrSIy7aSWE7B8+Nn0Nf2k5DhY55WN82BIfY/usnIdXae
	8xZSWcJnDaV7xxfP+0YhoILd02kWAJEuob+J09ICbSJl5kN5zxdJ5rUYSh2n5pJxk8HwPk3B9RV
	0Hh/AtVcDFIaqzUpQHjO6PNuljEBNWDpt97hjtUpxwB7c4et1u6SVHjrdttlzvOJoAVUZPZuM7c
	I8FbpxT1w==
X-Google-Smtp-Source: AGHT+IEW77FvieM+vtVkbmhzlz0RFLk71+mgtXTKXN86kZaDWUH4yy9113DxeoOKMAxSWBEyakVQSw==
X-Received: by 2002:a17:90b:590f:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-343dde8b46emr1933248a91.24.1762921686366;
        Tue, 11 Nov 2025 20:28:06 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:05 -0800 (PST)
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
Subject: [PATCH v5 0/6] nvme-tcp: Support receiving KeyUpdate requests
Date: Wed, 12 Nov 2025 14:27:14 +1000
Message-ID: <20251112042720.3695972-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
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

v5:
 - Cleanup code flow for nvme-tcp
 - When using recvmsg in the host code first check for MSG_CTRUNC
   in the msg_flags returned from recvmsg() and use that to determine
   if it's a control message
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
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

Alistair Francis (6):
  net/handshake: Store the key serial number on completion
  net/handshake: Define handshake_sk_destruct_req
  net/handshake: Ensure the request is destructed on completion
  net/handshake: Support KeyUpdate message types
  nvme-tcp: Support KeyUpdate
  nvmet-tcp: Support KeyUpdate

 Documentation/netlink/specs/handshake.yaml |  20 +-
 Documentation/networking/tls-handshake.rst |   1 +
 drivers/nvme/host/tcp.c                    | 103 ++++++++--
 drivers/nvme/target/tcp.c                  | 216 ++++++++++++++-------
 include/net/handshake.h                    |  10 +-
 include/uapi/linux/handshake.h             |  12 ++
 net/handshake/genl.c                       |   5 +-
 net/handshake/request.c                    |  18 ++
 net/handshake/tlshd.c                      |  96 ++++++++-
 net/sunrpc/svcsock.c                       |   4 +-
 net/sunrpc/xprtsock.c                      |   4 +-
 11 files changed, 397 insertions(+), 92 deletions(-)

-- 
2.51.1


