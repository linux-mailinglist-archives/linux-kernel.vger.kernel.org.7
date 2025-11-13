Return-Path: <linux-kernel+bounces-899030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E0C569CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D4374EBA92
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB5331A68;
	Thu, 13 Nov 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ngBDeKim"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8D2D5A14
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026048; cv=none; b=aIkCxABJ5xc+r84w30XUxzkahTLX73mokMRGTu12o/hXn3oH/0ay2Z1dpUaSMOzwfmix7tSb3j4Km3VMEnwoQ3eoG6TYystLah91wPl6oWgY4ueRjwprqoyGF/fFu3aIln2MJuWeK4qv0bZVyRWsWkZSd5QS/W01Urvgi9JriGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026048; c=relaxed/simple;
	bh=lFyIlcliweTDArjOud38dDnDHE7GQErnUCwb4MO0ybo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUIJ+IWb1j1EmdfXbcNTvblUmvLxUM5YMiv7pxHmaOtOBmhxK9yh9BsSglwAikGpYBNYc5PAlT/z48qI7vF7eQKxnYcBkrQrRFuyLS4GzQeJ3lqddOc4wmr05RubqO31wgfBy+vITeyeMYIs98c2IM9/Uz4wh5r9F405twxqOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ngBDeKim; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763026031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f9Gs7sU3C6pl28t3n8A03C3rIVhAKjaPqrv88ZWeXpE=;
	b=ngBDeKimW5D2u6XFUVjbX0IOfqnXBVIgx4DbaXBAjtGN3yh9i/RU7gIw1X5pePtksSX+Cb
	A27R/Kf2marevi9aDe98L9+K9iPRHACcOCXX11Fi2cAP3ghFz9I03TYiOlTCndzF4xn+38
	oClU9JygROCdn1S5KHQSEACIraBTxVg=
From: chenxiaosong.chenxiaosong@linux.dev
To: sfrench@samba.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	linkinjeon@samba.org,
	christophe.jaillet@wanadoo.fr
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenxiaosong@chenxiaosong.com,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v6 0/2] smb: move duplicate definitions to common header file
Date: Thu, 13 Nov 2025 17:26:00 +0800
Message-ID: <20251113092602.24733-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

In order to maintain the code more easily, move some duplicate definitions
to common header file. Add some MS documentation references for macro and
struct definitions.

I have tested all patches using xfstests and smbtorture, and no additional
test failures were observed in the results. The detailed test results can
be found in https://chenxiaosong.com/en/smb-test/20251113.html

v3: https://lore.kernel.org/all/20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev/
The following patches from v3 have already been merged into the mainline:
  - d877470b5991 smb: move some duplicate definitions to common/cifsglob.h
  - 379510a815cb smb/server: fix possible refcount leak in smb2_sess_setup()
  - 6fced056d2cc smb/server: fix possible memory leak in smb2_read()

v4: https://lore.kernel.org/all/20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev/
v5: https://lore.kernel.org/all/20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev/
The following patches from v4 and v5 have been applied to the ksmbd-for-next-next branch: https://git.samba.org/?p=ksmbd.git;a=shortlog;h=refs/heads/ksmbd-for-next-next
  - smb: fix some warnings reported by scripts/checkpatch.pl
  - smb: do some cleanups
  - smb: move FILE_SYSTEM_SIZE_INFO to common/fscc.h
  - smb: move some duplicate struct definitions to common/fscc.h
  - smb: move list of FileSystemAttributes to common/fscc.h
  - smb: move SMB_NEGOTIATE_REQ to common/smb2pdu.h
  - smb: move some duplicate definitions to common/smb2pdu.h
  - smb: move create_durable_rsp_v2 to common/smb2pdu.h
  - smb: move create_durable_handle_reconnect_v2 to common/smb2pdu.h
  - smb: move create_durable_req_v2 to common/smb2pdu.h
  - smb: move MAX_CIFS_SMALL_BUFFER_SIZE to common/smbglob.h
  - smb/client: fix CAP_BULK_TRANSFER value
  - smb: move resume_key_ioctl_rsp to common/smb2pdu.h
  - smb: move copychunk definitions to common/smb2pdu.h
  - smb: move smb_sockaddr_in and smb_sockaddr_in6 to common/smb2pdu.h
  - smb: move SMB1_PROTO_NUMBER to common/smbglob.h
  - smb: move get_rfc1002_len() to common/smbglob.h
  - smb: move smb_version_values to common/smbglob.h
  - smb: rename common/cifsglob.h to common/smbglob.h

v5->v6:
  - Patch #0001: use typedef to define both CREATE_DURABLE and CREATE_DURABLE_RECONN_REQ
    for a single struct.
  - Patch #0002: make FILE_SYSTEM_ATTRIBUTE_INFO.FileSystemName a flexible array member.

ChenXiaoSong (2):
  smb: move CREATE_DURABLE_RECONN_REQ to common/smb2pdu.h
  smb: move FILE_SYSTEM_ATTRIBUTE_INFO to common/fscc.h

 fs/smb/client/cifspdu.h    | 10 ----------
 fs/smb/client/smb2pdu.c    | 25 ++++++++++++-------------
 fs/smb/common/fscc.h       |  8 ++++++++
 fs/smb/common/smb2pdu.h    |  4 ++--
 fs/smb/server/smb2pdu.c    | 12 ++++++------
 fs/smb/server/smb2pdu.h    | 12 ------------
 fs/smb/server/smb_common.h |  7 -------
 7 files changed, 28 insertions(+), 50 deletions(-)

-- 
2.43.0


