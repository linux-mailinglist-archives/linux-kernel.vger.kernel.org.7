Return-Path: <linux-kernel+bounces-829709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED412B97AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8166719C80E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627330CDBA;
	Tue, 23 Sep 2025 22:08:59 +0000 (UTC)
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [92.204.81.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4B27FB2A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665339; cv=none; b=Bjo0YNvylkUFwCsYC14y7SZ2tnm+PzHqMyugUDfGv5TXIf7EcTxP6fOSbEZDLR20qHIg2NbAc+UNPJ8U4skHyplqsrcF/Qw4KnVfwt4IcykYhHNr5+MPHkwo0OCDqoO5poL5SyxdoyLs5GOnsDkwKqcTheRIhoYqzSL422QC2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665339; c=relaxed/simple;
	bh=7BVsG+xlTrS2/sNGW0ylNO7M6kSzikiotWPH8lhKxL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k2IgF06llx5pAw7JsLdPanfuCi19ZUNxs9ox/UmfMDoJkw8eNxzaEorIvxTSWDlvA/IxsOpeOz6O3hF2gHSUS4elZXWnY0txfn6h7BUmzGLRL0F913OeDXotuEgeoxRBCUOAVxgUNZEZbpmYYacs6CXVJjll6EchyIRF+OkUY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 1B9IvdJrlRKdg1B9Uvhvsj; Tue, 23 Sep 2025 15:06:26 -0700
X-CMAE-Analysis: v=2.4 cv=cL65cleN c=1 sm=1 tr=0 ts=68d319e2
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ANfWVW7UVYnNx9d1tp4A:9 a=zgiPjhLxNE0A:10 a=irvUdcZYBsSKPCvlqN3O:22
 a=HhbK4dLum7pmb74im6QT:22
Feedback-ID: 4a5751b3902891bb1c527357222a159c:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 0/2] Squashfs: performance improvement and a sanity check
Date: Tue, 23 Sep 2025 23:06:50 +0100
Message-Id: <20250923220652.568416-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOncgw34v0RUv4jCYxiON0wmf4Hsv46VdZqbRmJfjwWiFtOMSvhVui0R0PZe7DyMY8cGr5VlDnzaTmKoJ5dDvx6YUm5rTwWW8b/9tTYmzdnCt2bmtBzd
 MtLgkLJe+Z3frxwErm9qgKWx5HZMH/QffqBFh+Gny+tZmIuDQ/XNNqyliLiYM5645zGjII6N1cGTXHxZY0KZKbgWIAROfHyu6/gOXvWoxe3Tso73f2eXJiTg
 EPOBaLxuT3e1LfqR4Jj2FNdLrL++ZREawnhrmpal5LSXuxZsD00aWyXMS58vIsfD

Hi,

The following patch-set adds an additional sanity check when reading
regular file inodes, and adds support for SEEK_DATA/SEEK_HOLE lseek()
whence values.

Phillip Lougher (2):
      Squashfs: add additional inode sanity checking
      Squashfs: add SEEK_DATA/SEEK_HOLE support

 fs/squashfs/file.c        | 137 +++++++++++++++++++++++++++++++++++---
 fs/squashfs/inode.c       |  24 +++++--
 fs/squashfs/squashfs.h    |   1 +
 fs/squashfs/squashfs_fs.h |   1 +
 4 files changed, 148 insertions(+), 15 deletions(-)

Thanks

Phillip

