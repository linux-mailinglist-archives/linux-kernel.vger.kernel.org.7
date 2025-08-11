Return-Path: <linux-kernel+bounces-762336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93115B2050F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 861AF4E2084
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6272356C6;
	Mon, 11 Aug 2025 10:17:14 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151821D5AF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907434; cv=none; b=pk9/pfoKnTKw6OLrH9URYS+dt9J9WCxwBc/sRuCq0tSXC1ZZ2x8NenUSDZFKjdkS4pWjfoA1w1/IEm9lXlCak1wi44mRB/F+Ogff7siSYP8DJilPdGZfis9Ss1MvP4+/hAn+5h+ggwU5TAKdy0Ljgo8FflFPX24aAFB7+MwOaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907434; c=relaxed/simple;
	bh=42Qj2pu6ZD9kXaMu36PwsauvAotNEEUuPapWHeOC1+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hz+idd4gL0nkOSYHSfCliE2kpVV7ArVhbFTDlWADmEQWrbKvpN3Z0uaLXgytOeRVqW8jAotTO9dYwp5RGgbigdQpInOkLY3P2ANovDU74xYeTVLJIp5/3wog08FR1QSSQID1hRQFGHkKB3mmpAqiQ/RJGZLX7kMrKYHTRsYIn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.52 with ESMTP; 11 Aug 2025 18:47:10 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
	by 156.147.1.121 with ESMTP; 11 Aug 2025 18:47:09 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From: Chanho Min <chanho.min@lge.com>
To: Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	stable@vger.kernel.org,
	Chanho Min <chanho.min@lge.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 3/4] smb: client: fix potential UAF in smb2_is_valid_lease_break()
Date: Mon, 11 Aug 2025 18:46:38 +0900
Message-Id: <20250811094639.37446-4-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250811094639.37446-1-chanho.min@lge.com>
References: <20250811094639.37446-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Paulo Alcantara <pc@manguebit.com>

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
[ chanho: Backported to v5.4.y, smb2misc.c was moved from fs/cifs to fs/smb/client ]
Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/smb2misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index d7cbf1b07126c..c47927d257635 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -611,7 +611,8 @@ smb2_is_valid_lease_break(char *buffer)
 
 		list_for_each(tmp1, &server->smb_ses_list) {
 			ses = list_entry(tmp1, struct cifs_ses, smb_ses_list);
-
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each(tmp2, &ses->tcon_list) {
 				tcon = list_entry(tmp2, struct cifs_tcon,
 						  tcon_list);

