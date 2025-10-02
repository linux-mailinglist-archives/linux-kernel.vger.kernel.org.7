Return-Path: <linux-kernel+bounces-840545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4CBB4A83
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4B019E50A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D526B755;
	Thu,  2 Oct 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDd0KsRZ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB78946C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425644; cv=none; b=D5k4S4Uc9bvnvEOyrO4SyNr/IP8Ps2i6PvckHwWcu73MAooMERNMjRTLJM3pfOaDRPWGdqBd5YKDB+BX5E+G00NS1t9BDLTKziD+1A4+iYij/xCnFSWcs42BdZNF4XcaAqAdYu38WcosZ01iAnxKn4eHuU+t4pWwQ3YZIZxl3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425644; c=relaxed/simple;
	bh=dk1NQw2VERkubWjw6V1HZnO05TMxyayltyTZKNX/AzM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pAKNvjXMwQAXnJzxB+NvINJ8zkUiXElZngPYJtmtLy6idACJxOt9Ekf7ogADr0oBJAZBeiUaDVsILT3fqdsIetFOtQ/yYp5DbiDPowiSTNat9stSem9HemUrzoBxVu1UWJnATpuo/k6giGpa4N52V8/LF3VIqwisTFWVeK+vWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDd0KsRZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78eba712e89so11488986d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425641; x=1760030441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAtu6/ctQVIzK5vPxGcQc/s7kZti3z+hmRQu3O4UCtY=;
        b=SDd0KsRZoZR19Le3LD7ViwLmE3XXbpJz1XgB21Ik0R8sSqMXl1ktKhOTFSp4F1/dzk
         ZSBOZve0k0xjS7YC1GD0fAAZUD4DJq1wILwbzyHHwUuYTLmfCCIAZX8WAMtaYlozcSnR
         zwciR8/hecUtLNllbc2iCT/UQkWT2Y3tRjWVq6JBhfMkDmbBUBxjYZRcYmvdcTHbzag9
         1uAf+szf0dpOQ6fRJoFRymPq2a/02+gl15PhuiVPBIUCliUqPSoo75e10zjHNQgLadlI
         9avXNaHT1gPNXiyOeGMUkiTo/+9Kc0QwFLQlz+3ASwJX1kRqujdCzhRmw/P+Hg36fMZb
         1V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425641; x=1760030441;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAtu6/ctQVIzK5vPxGcQc/s7kZti3z+hmRQu3O4UCtY=;
        b=Xs5OKIFeMFwVtEMnP1al+5wp1Vd5aoQR1wO1ksU7srvWFP7jtgH8Na5PbzQ1l3WiaD
         merRFSUPD/PLkTg04t3YUFYvni3mkOkpqz/s11thNwKmAYQgmXG/dDrbUwc76s+whPXB
         RlNhU16hb6xitFIC5X28b/iLm/a9IaWOb0KkEw7nKPYpZtLDaHVXg5X4+UuHIeyH20KO
         1I4dfAWbMUxmXea1dRK+WozRNcbf8KHwD7PqZXMn2qvMGCR50wXjWsBPiNqEZSN9lcRD
         I0EUn3AXMgT+W7nwyPK2O4JUoAq6EHeDnBIDtq1vkdAP8rRYOFGbl9hcQMdBwZkD2nEI
         OZPA==
X-Gm-Message-State: AOJu0Yx9tzkFX43F2vicN6sAZ9YSx/2e4vdV88dNpWso2QgNVST0f30e
	S8CK82Xwv7PxR1m9TJT8v+JD3bQImMz2/B8GvOghx/ZAMLKI9xo7FCVtit7mA7unYDuPPcY2dCm
	vYfhBoEmWZKUc6spDN9s1gnhYntujeuGtHzYE
X-Gm-Gg: ASbGncsRDoJJUz97yzO59hnzhQ8cbHKs8aexbBN7NJy2cMvbEPGn1ZMO8KmIiIqzWb8
	1Kt38XM9F2y/xmaLKeth6C/SM9S+IP3hlmJteF/5/+pC7oUXiEmTqbr3l+ry9ZhBkBVzOPZ/6mH
	CwQnJBS1WFML5+GAR5aMOqtDCTHyNJaWlm3pDye48mADxZRTmempLJewnwWKm/UXSXfwuRMuBDN
	fmGMMl9XngBlQTb+LfpjKtz7X1797Ib9uKzdiZtAhH39j6rO6+QWLY4eZ5+7lIkSj6L77pO+LUo
	axgL4agVjBkMVsG2+jf/3vPgcB95MbZdIbpTkmQ9g2UNlnmmnapUkAbAz0yscimbJn0KOsQeiAP
	rsNaXihJbnA==
X-Google-Smtp-Source: AGHT+IGUWZdm9D8d2hudPZnCFmi7yXKHA1CZ7wWJsKITJ/TXMFKIEesjighOYb/MimXVQCCocKK7yApm2jAOKPOJVLY=
X-Received: by 2002:a05:6214:248a:b0:786:d65c:1c3e with SMTP id
 6a1803df08f44-879dc7c5521mr1370446d6.30.1759425640960; Thu, 02 Oct 2025
 10:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 2 Oct 2025 12:20:28 -0500
X-Gm-Features: AS18NWB6qxj8HQdJyEZA2jhJoBIVUzGipHmStWEneP1xhBuJnOXCHOyGk4pTsjY
Message-ID: <CAH2r5mv8=AvJBTE7cxz=BQsjrR8ZOVS_ZkvVSrLzJqrLiomX8g@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
a9401710a5f5681abd2a6f21f9e76bc9f2e81891:

  Merge tag 'v6.18-rc-part1-smb3-common' of git://git.samba.org/ksmbd
(2025-09-29 14:57:08 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/v6.18rc1-part1-ksmbd-server-fixes

for you to fetch changes up to e28c5bc45640bc851e8f7f0b8d5431fdaa420c8e:

  ksmbd: increase session and share hash table bits (2025-09-30 21:37:55 -0500)

----------------------------------------------------------------
Nine ksmbd server fixes
- Fix potential UAFs and corruptions in rpc open and close
- Fix copy_file_range when ranges overlap
- Improve session, share, connection lookup performance
- Fix potential hash collisions in share and session lists
- Debugging improvement - making per-connection threads easier to identify
- Improve socket creation
- Fix return code mapping for posix query fs info
- Two patches add support for limiting the maximum number of
connections per IP address, extending the existing connection limiting
mechanism to enforce per-IP connection limits alongside the global
connection limit
----------------------------------------------------------------
Matvey Kovalev (1):
      ksmbd: fix error code overwriting in smb2_get_info_filesystem()

Namjae Jeon (7):
      ksmbd: make ksmbd thread names distinct by client IP
      ksmbd: use sock_create_kern interface to create kernel socket
      ksmbd: copy overlapped range within the same file
      ksmbd: add max ip connections parameter
      ksmbd: add an error print when maximum IP connections limit is reached
      ksmbd: replace connection list with hash table
      ksmbd: increase session and share hash table bits

Yunseong Kim (1):
      ksmbd: Fix race condition in RPC handle list access

 fs/smb/server/connection.c        | 23 +++++----
 fs/smb/server/connection.h        |  6 ++-
 fs/smb/server/ksmbd_netlink.h     |  5 +-
 fs/smb/server/mgmt/share_config.c |  2 +-
 fs/smb/server/mgmt/user_session.c | 28 +++++++----
 fs/smb/server/server.h            |  1 +
 fs/smb/server/smb2pdu.c           |  7 +--
 fs/smb/server/transport_ipc.c     |  3 ++
 fs/smb/server/transport_rdma.c    |  5 ++
 fs/smb/server/transport_tcp.c     | 98 ++++++++++++++++++++++-----------------
 fs/smb/server/vfs.c               | 16 ++++++-
 11 files changed, 119 insertions(+), 75 deletions(-)

-- 
Thanks,

Steve

