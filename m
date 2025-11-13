Return-Path: <linux-kernel+bounces-899427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB57C57B39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8F0F4E8DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F421D3C0;
	Thu, 13 Nov 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dUd7j4Sh"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DC207A09
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040850; cv=none; b=JklTzdW86mO00Xveldrob7gcEGJGRrqflOxZiw025afHKaWrGYd86Xg0dDTXvRwbITxoyHtOSfBJ9XPwh5z8ILOvUNAZR0E6s8igEUMppeckji309i8J+Ko8GcV0rFOzrOBTfdApkvOM0eyzvMf+XEyhX6S302jXeGTibwEWMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040850; c=relaxed/simple;
	bh=crthdjy2NFYuC/0xwg/Adbe780f/n3spD1fqnPwHLcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR7hBPCSc3OY1e1dmM3Fqv0QZIChRP/LdXDcOYTXd3Xdd9bjxWvh9ZAkJLNMkZbwoclBMiiwE8V6G/RoPknFeuMYzb3sT5D4nvWkEV2BrsUL9CB1I3U2+iJ/0umHtjyzZWFvI/avocJ2vIy4FmIRik3rEuHyD03yMquKQURNPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dUd7j4Sh; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763040836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GwHuVx0uCHmmcArxYiuoa/6TRiHDFRmBiAH83+sISEw=;
	b=dUd7j4ShwD9nrMCekgeRgzDgnO3EaiIuAzYf6zT+kx5Rcb7u6Rlti8o8THOHOGG31/NJZ2
	SKGLYR2oAJ3PWMjgkcGIIaDYNihQymutM/g0SVQTYrPIPdEc78mE2zIrie1aM5xUl8fRY0
	rF0ahq5byNC+qswqVpWsG6irstsdI5Q=
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
Subject: [PATCH v7 0/2] smb: move duplicate definitions to common header file
Date: Thu, 13 Nov 2025 21:32:50 +0800
Message-ID: <20251113133252.145867-1-chenxiaosong.chenxiaosong@linux.dev>
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

v5->v7:
  - Patch #0001: use typedef to define both CREATE_DURABLE_REQ and CREATE_DURABLE_RECONN for a single struct.
  - Patch #0002: make FILE_SYSTEM_ATTRIBUTE_INFO.FileSystemName a flexible array member.

v6->v7:
  - Patch #0001: CREATE_DURABLE -> CREATE_DURABLE_REQ
                 CREATE_DURABLE_RECONN_REQ -> CREATE_DURABLE_RECONN

v6: https://lore.kernel.org/all/20251113092602.24733-1-chenxiaosong.chenxiaosong@linux.dev/

ChenXiaoSong (2):
  smb: move CREATE_DURABLE_RECONN to common/smb2pdu.h
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


