Return-Path: <linux-kernel+bounces-858437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B6BEABFF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E521B5C1DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A12BE641;
	Fri, 17 Oct 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhkdPOUo"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9442BE625
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718287; cv=none; b=o6maPG53UCns7tTgJ29NvuNXVtfevnGRuHxhUqmPiKMwzQBX+qjtbiVsOmtJSRaTVthff4QF6RyhotXtKNY9Ego+S5AuyWPF5giIvTLk+CtVy2MEUWsMvbY98APus4aZoxD6rV4UY+F9xcOn3vEnKFY+lBueSGgG5QHu07OheUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718287; c=relaxed/simple;
	bh=FTb0yFrHuRdjpgAJszQzIgA71Afk50W1vgFtxKtP+FI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hfILk/zNxvFafJk9v9CdpGUS4Ij1bXkfmqnedqQeLiz4hgTLXhsTwJA4Pswpi9Bdv8esC6qi3++V8HhUSZ7mDkmvyrS72A915dcMkv1mgPhHyUBJfjrSUygScNUqifx6UTNjo+ny0Ix7H/7qb5LOsUQL+avwhOhnL/B4C+WNgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhkdPOUo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c103928ffso30752886d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760718285; x=1761323085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MCzK8PbFyItTRYW/eSHgtsp8i0BLpupCg/9Az9LQ8n8=;
        b=XhkdPOUoRgVOybqquu1G+op2vBZ5Luss2RGonvqlvb/I2Gk+AkHtSd5tWvXRe/s1j9
         ky0/15Q+WHU9Lz7MWhiaeYNoWNqbG43+ikEG2plxNHbFHXGQ7emIfyFxoNT495wbA8f4
         G8Bi+LEMA6TYxTuPCgwuyp0NufUe+gYFs69HLfGZcS5SfE7xlwBnLKIYGXl2XPfuG5EA
         jwX3usdA3fjFlUaz8UgNohiA9HE01fivXzbHLA3Efr4q6pEZkD+6smxtXIR1HW3xGtCB
         el7FW/ig6c9lrqJpbe11UC8SXiGopG2w5niN04oHe3vGEtKu2fhIPAB76xrBC7IOqLKj
         r7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718285; x=1761323085;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCzK8PbFyItTRYW/eSHgtsp8i0BLpupCg/9Az9LQ8n8=;
        b=DrHKJYhduaCJ1gHEdNcldGUPTMUQXRHbB+5y+Vuaa7GTbE7Ep5/yNh46pYIU84jfXR
         e64EfZy3YD5ig6w1uEcRUbbNd9fzEBK7SmSn1+tHHCnP7A92g7FIrBoxWAIJkLd342CC
         V/uUvAS3K6lQNGz1Kq9WkaPCwq8BBjs7AttDeK1G95os3QyOsv7Y/sJ/N6cXWoDmH5Kp
         wAh6FEpfYHiQjQoXbYxwbMBjdaAeHj9ZcOi+mstdr5SJ3gHZ5oNA7t/5aMEhA6NIY2rs
         kXhRhWvJYZqf1xOWJq4P3qhbis2Ta1ig+7YXmOL0LQz4e8s5M4QB2Nreq0ixT8Dt6RTs
         xOFg==
X-Gm-Message-State: AOJu0YxCyUo512raoLhHevt0Vr4GTDLHt6ZLZ3CWadYXZ7OzpMTb60wd
	hzSXh8g+bAfvSNdFPlc2LAXpGHUSA0RIsYLpoD6+BYKU64kUaUl7MjFOi+XzwDs9iBPyf+PxBMo
	bbuoK2JJLWX3f46mS1IuZ9PGSdE7OxX8=
X-Gm-Gg: ASbGncs02mARWtFc2Y7d7diMiI8nh3HTZmcdk4a28vdlVIV6miuRpbuzGATD+yCM+Bp
	r6pjFCcb2ttFjOefmBEK8xFDvKXGhslCb9lItMLqL4JyNHcBXdc0rxinJDpMFF845iVrhqQ29Eb
	LJY0lCB9zOEMs495rI4fp7QzK+Qrybd/rQ0CtZZ2HaBN0aAq/PSFV1GXPIJkaE13/KqPjJUW1xK
	OnOFW4TlpN9knQDsnkkLnIhvC1h1mMkkZ69NIs3CcYOLSwm9J8CCw0GmmxS3Fpf3tm4MIXU9ocU
	jZfZ2e5W9svHUYGYJvjbrbYiX7R3fUGiVJiyaQZbH6tI69TlmjaFGH2tN/sXqZiW0EuP34NIm+3
	5aDu3zESxAqIdWyIylP/RQ96RJ1AbaqI0TMFL6hDlMFwTJ8csTkqW8Phr+1KMPue+4UwyVVqb5G
	A=
X-Google-Smtp-Source: AGHT+IEbKATRBQDJWotutsMuJ49f83ga0Ul3qcbhLWyRCQriEnv5Vi+HPuaaefU+GoPJWUoUDdT9wn/jVEaiNaFbuZY=
X-Received: by 2002:a05:6214:519a:b0:87c:2b5d:5bbf with SMTP id
 6a1803df08f44-87c2b5d6316mr20954186d6.30.1760718284648; Fri, 17 Oct 2025
 09:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 17 Oct 2025 11:24:32 -0500
X-Gm-Features: AS18NWDGB2RnEI5Ts-1Q0qBicF34CjvgCmiKaWBpfGxZFWRB7L98oOGQRbem09w
Message-ID: <CAH2r5ms-8MBEd9ssS8vtkneFt=wKW-5MDWr-4pMf0mSZS0JH5A@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

he following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.18-rc1-smb-client-fixes

for you to fetch changes up to 3c15a6df61bab034b087f00181408b1537a535bb:

  smb: client: Consolidate cmac(aes) shash allocation (2025-10-15
22:10:28 -0500)

----------------------------------------------------------------
smb client fixes, security and smbdirect improvements, and some minor cleanup
- Important OOB DFS fix
- Fix various potential tcon refcount leaks
- Eleven smbdirect (RDMA) fixes (following up from test event a few weeks ago):
   -- Fixes to improve and simplify handling of memory lifetime of
smbdirect_mr_io
   structures, when a connection gets disconnected.
   -- Make sure we really wait to reach SMBDIRECT_SOCKET_DISCONNECTED
   before destroying resources.
   -- Make sure the send/recv submission/completion queues are
   large enough to avoid ib_post_send() from failing under
   pressure.
- Eight patches to convert cifs.ko to use the recommended crypto
libraries (instead of crypto_shash), this also can improve performance
- Three small cleanup patches

If you prefer to wait on the crypto library changes, that is fine, but
they tested well and got multiple reviews and look good.
----------------------------------------------------------------
Eric Biggers (8):
      smb: client: Use SHA-512 library for SMB3.1.1 preauth hash
      smb: client: Use HMAC-SHA256 library for key generation
      smb: client: Use HMAC-SHA256 library for SMB2 signature calculation
      smb: client: Use MD5 library for M-F symlink hashing
      smb: client: Use MD5 library for SMB1 signature calculation
      smb: client: Use HMAC-MD5 library for NTLMv2
      smb: client: Remove obsolete crypto_shash allocations
      smb: client: Consolidate cmac(aes) shash allocation

Eugene Korenevsky (1):
      cifs: parse_dfs_referrals: prevent oob on malformed input

Markus Elfring (2):
      smb: client: Return a status code only as a constant in sid_to_id()
      smb: client: Omit one redundant variable assignment in cifs_xattr_set()

Shuhao Fu (1):
      smb: client: Fix refcount leak for cifs_sb_tlink

Stefan Metzmacher (11):
      smb: smbdirect: introduce smbdirect_mr_io.{kref,mutex} and
SMBDIRECT_MR_DISABLED
      smb: client: change smbd_deregister_mr() to return void
      smb: client: let destroy_mr_list() call list_del(&mr->list)
      smb: client: let destroy_mr_list() remove locked from the list
      smb: client: improve logic in allocate_mr_list()
      smb: client: improve logic in smbd_register_mr()
      smb: client: improve logic in smbd_deregister_mr()
      smb: client: call ib_dma_unmap_sg if mr->sgt.nents is not 0
      smb: client: let destroy_mr_list() call ib_dereg_mr() before
ib_dma_unmap_sg()
      smb: client: let destroy_mr_list() keep smbdirect_mr_io memory
if registered
      smb: client: let smbd_destroy() wait for SMBDIRECT_SOCKET_DISCONNECTED

ZhangGuoDong (1):
      smb: move some duplicate definitions to common/cifsglob.h

 fs/smb/client/Kconfig                      |   7 +-
 fs/smb/client/cifsacl.c                    |   5 +-
 fs/smb/client/cifsencrypt.c                | 201 +++++++------------
 fs/smb/client/cifsfs.c                     |   4 -
 fs/smb/client/cifsglob.h                   |  22 +-
 fs/smb/client/cifsproto.h                  |  10 +-
 fs/smb/client/inode.c                      |   6 +-
 fs/smb/client/link.c                       |  31 +--
 fs/smb/client/misc.c                       |  17 ++
 fs/smb/client/sess.c                       |   2 +-
 fs/smb/client/smb2misc.c                   |  53 ++---
 fs/smb/client/smb2ops.c                    |   8 +-
 fs/smb/client/smb2proto.h                  |   8 +-
 fs/smb/client/smb2transport.c              | 164 +++------------
 fs/smb/client/smbdirect.c                  | 321 ++++++++++++++++++++----------
 fs/smb/client/smbdirect.h                  |   2 +-
 fs/smb/client/xattr.c                      |   1 -
 fs/smb/common/cifsglob.h                   |  30 +++
 fs/smb/common/smbdirect/smbdirect_socket.h |  11 +-
 fs/smb/server/smb_common.h                 |  14 +-
 20 files changed, 419 insertions(+), 498 deletions(-)
 create mode 100644 fs/smb/common/cifsglob.h


-- 
Thanks,

Steve

