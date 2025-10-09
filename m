Return-Path: <linux-kernel+bounces-846862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB1BC9414
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A80CB4FC3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15A2E8897;
	Thu,  9 Oct 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="GCvq1v9a"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137F2E8B60
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015992; cv=none; b=XeA+wjT9u0lvnBkcDl2OVeizdsBgsGMxJV4OYGlSQgmW2kZeaKSYyBUwkspkwLhaUxkMGJ+RsHZis/BTLzBB7ibz1n22oPNOb4jkzf7/PWIpG16tTfq4zZqCSK9QoJ5i0ZKQIDt/0tYERXxHqSKZoh1BrGFohruL5+H5GHeFG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015992; c=relaxed/simple;
	bh=rNLTq1LQFw8bHXqJQapbXIlJpzZHUR76vAyHIGqeW78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kByUFRZ2U3GknWI974AC642Nr449W5Tja6E57PPge/TB648koWuzO7ztMJ8Ag+iMfAgjIvdPS+GEtMwvhdAg/3qXEr4d8vzbuIhBJXp37jtdCkx4TUo2bccbwo5ZPbJ1m4f9Fr7vCcCeP8pVMzuakN3Reo2G7Z6iqMskGa16Bzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=GCvq1v9a; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0B97014C2D3;
	Thu,  9 Oct 2025 15:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760015441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RSEzej2rMgZ/3dQXyeaxr2uE3jRK8E8SdoM2KwIIHvc=;
	b=GCvq1v9aTg5FpSIPtWoorqiXzwQTMz83nHwr/4YiNUtsosP4PtDdQtyKlMjJFVNLWRXwLV
	5pnPNYZm51/Dmf1pV9l9MvYOczeVYDkiqyIX+PA15TD2crMPIrjaH/dXUBJ8UD9ZZCwtLf
	sgWLGkcREcmQKFin31e0cR/WPDTvGUrD8iSOCuJqKDnypCzg3WOtyT4JompyaylcOUKViK
	rF3irMq8qBXy+e5hGpsbdjpWMHqMCWGII3O/pMKSvsgVyL8zn3ylJLxd+XZjbFoG30mUNV
	YKVkLetDEpxD28O+CQ50axVPIM1flLCATD9Hj6M+wwbZ57DOaMbzqqaXW0qUKg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ec0f6332;
	Thu, 9 Oct 2025 13:10:38 +0000 (UTC)
Date: Thu, 9 Oct 2025 22:10:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.18-rc1
Message-ID: <aOe0P8ixMEg4ul5K@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.18-rc1

for you to fetch changes up to 528f218b31aac4bbfc58914d43766a22ab545d48:

  9p: sysfs_init: don't hardcode error to ENOMEM (2025-09-27 21:44:38 +0900)

----------------------------------------------------------------
Bunch of unrelated fixes

- polling fix for trans fd that ought to have been fixed otherwise back
in March, but apparently came back somewhere else...
- USB transport buffer overflow fix
- Some dentry lifetime rework to handle metadata update for currently
opened files in uncached mode, or inode type change in cached mode
- a double-put on invalid flush found by syzbot
- and finally /sys/fs/9p/caches not advancing buffer and overwriting
itself for large contents

Thanks to everyone involved!

----------------------------------------------------------------
Dominique Martinet (1):
      net/9p: Fix buffer overflow in USB transport layer

Nalivayko Sergey (1):
      net/9p: fix double req put in p9_fd_cancelled

Oleg Nesterov (1):
      9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

Randall P. Embry (3):
      9p: clean up comment typos
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Tingmao Wang (3):
      fs/9p: Refresh metadata in d_revalidate for uncached mode too
      fs/9p: Invalidate dentry if inode type change detected in cached mode
      fs/9p: Add p9_debug(VFS) in d_revalidate

 fs/9p/v9fs.c           | 16 +++++++++-------
 fs/9p/vfs_dentry.c     | 33 +++++++++++++++++++++++++++++----
 fs/9p/vfs_inode.c      |  8 +++++++-
 fs/9p/vfs_inode_dotl.c |  8 +++++++-
 net/9p/trans_fd.c      | 17 +++++------------
 net/9p/trans_usbg.c    | 16 +++++++++++++---
 6 files changed, 70 insertions(+), 28 deletions(-)
 
-- 
Dominique Martinet | Asmadeus

