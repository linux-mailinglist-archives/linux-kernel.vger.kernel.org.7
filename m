Return-Path: <linux-kernel+bounces-812105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00151B532FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4644F5A4EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500B322DC4;
	Thu, 11 Sep 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="KnqyHn/V"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90F322A30
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595608; cv=pass; b=WOzRDhx51wAQqDjAum5BL4jr2K8/kJhsR4osw4uM18w7q5RuXGoYH/hHNyHWP/LwOl4GwvcjDPYxb/IE398TvMR6hUNkGaRpLoNs2baAzITdcGJxSMYuda2smdvGKldFg65KmRTv3eWBAK51exx6HO5ByVaG3mdDNUQ/Qb2p4Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595608; c=relaxed/simple;
	bh=2i05d0MBKQiDLkG4vNii6Aj48YBX+TCM5P4DJMFyhpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDdKHpTrbI2L65pnOxMeEUYXSoJaze5auDuagd0YvL+dpW0k8Bt6PfHBNI+jUxqmnUkXQ8r5OifW+yRKWSzig5FnpMPGRVyxaahFby+7YI4MxJLPjtXdGMvj92dWNakNNYySeqz3K/Ez3bkjG4ZKsMYrFTp1vXm57IIk1yEsb6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=KnqyHn/V; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58BCxl7F033599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Sep 2025 21:59:47 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id B562E109F7118;
	Thu, 11 Sep 2025 21:59:46 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M42ZCbQi5Y8S; Thu, 11 Sep 2025 21:59:43 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id ECB81109EFAC6; Thu, 11 Sep 2025 21:59:42 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757595583;
	cv=none; b=ntaFWBghdZWCd5j63lOZCbvqZvzcKR9FzdjNBa96CLJdr4g3AjLG1fPshdZ0SAa0HE8dvu2pyRHd338cp9uzHSsIY9uHGSuLCbIXH40bwyUAJRrrqtJ9XtQzFiN8qAunEXccxVYEK/3mVdwSO34a7o3Da2JOB7/4GGum+m5q41k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757595583; c=relaxed/relaxed;
	bh=uPx2NvH52G2KYmJ1hHRnmcXqOTjZ/o7zDIEaz0j5+og=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=mqHbyRAZjnDZR9zHYlIfjHjxvNItjh6uhwoz33kdrE/jhiSTP/CE9MsrCDi87NysVk8B9v6W45JPVwsWZNVrUuty83YWkqnawAOlH/Nrgrkly7mdo9117tkyxCsVpsyW2GHxhs+CJgnJWvhGu3Nkyt34gkV4pX9vY93wu6JkXZ8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org ECB81109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757595582;
	bh=uPx2NvH52G2KYmJ1hHRnmcXqOTjZ/o7zDIEaz0j5+og=;
	h=From:To:Cc:Subject:Date:From;
	b=KnqyHn/VY2zsP7ac3A7Dt6jwdsCuETobUWn7EbUX/ukjVy3KV+I/hsgFyPN2hMppG
	 CC+oS94EbKAVlxEL/0FgqR8zvcUPLfNY7VgPip6mfo1Kky/ERR+65USoPh6mkTleEX
	 OA//G77pHo7lKKqVQLk7Sjsx6kXQFwxDgxHxDE6A=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] vmw_vmci: fix typo in comment
Date: Thu, 11 Sep 2025 21:59:39 +0900
Message-ID: <20250911125939.587139-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Correct a spelling mistake in vmci_context.h
("receive" was spelled incorrectly).

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/misc/vmw_vmci/vmci_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.h b/drivers/misc/vmw_vmci/v=
mci_context.h
index 980fdece0f7d..083effa08102 100644
--- a/drivers/misc/vmw_vmci/vmci_context.h
+++ b/drivers/misc/vmw_vmci/vmci_context.h
@@ -98,7 +98,7 @@ struct vmci_ctx_chkpt_buf_info {
 };
=20
 /*
- * VMCINotificationReceiveInfo: Used to recieve pending notifications
+ * VMCINotificationReceiveInfo: Used to receive pending notifications
  * for doorbells and queue pairs.
  */
 struct vmci_ctx_notify_recv_info {
--=20
2.47.3


