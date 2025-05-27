Return-Path: <linux-kernel+bounces-663654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF6AC4B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 11:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C07B17B13E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6D253923;
	Tue, 27 May 2025 09:26:12 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1B12C1C6FFE;
	Tue, 27 May 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748337972; cv=none; b=g20Jo2FLtv9g/6lCGeaH+ndaZNJSR4eiezGKAg9/ozaKlR7cw+2IpysBhCA0Auaa96T5yOcGUCZeXPYvDx7qnX9gyz/8/0Xc3x/Ffrj5bf2HNlhGEl6citDq25SjY6ARYY7KiP7s9Hb6LMTgOC0Y8F9bcwyxUPMlUBOYEaokeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748337972; c=relaxed/simple;
	bh=Y0tfWQqJPflMwV31+TxJxuGsD+G7TzcUP6kJZXA2sec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfzzoCcetOn8qavY1VP71oSfnAZkQ1WxM6tYiueqRDNurNBJsMp0hMGCj3YDUB1vCxC6ETsW4fiw/DG6l2Y4FXMZMNoFC5ybJid1nnQkhmKLrrN1AOcVLNHz/MhA1NaBaLCrF+AL+szMvtZLzZzDlKoeNQzf7IgCq1xXnpz+e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 9193960190ABC;
	Tue, 27 May 2025 17:26:05 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: Replace simple_strtoul with kstrtoint in expkey_parse
Date: Tue, 27 May 2025 17:25:49 +0800
Message-Id: <20250527092548.1931636-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstrtoint() is better because simple_strtoul() ignores overflow and the
type of 'fsidtype' is 'int' rather than 'unsigned long'.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/nfsd/export.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 0363720280d4..1bc9bc20cac3 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -83,7 +83,6 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	struct auth_domain *dom = NULL;
 	int err;
 	int fsidtype;
-	char *ep;
 	struct svc_expkey key;
 	struct svc_expkey *ek = NULL;
 
@@ -109,8 +108,7 @@ static int expkey_parse(struct cache_detail *cd, char *mesg, int mlen)
 	err = -EINVAL;
 	if (qword_get(&mesg, buf, PAGE_SIZE) <= 0)
 		goto out;
-	fsidtype = simple_strtoul(buf, &ep, 10);
-	if (*ep)
+	if (kstrtoint(buf, 10, &fsidtype))
 		goto out;
 	dprintk("found fsidtype %d\n", fsidtype);
 	if (key_len(fsidtype)==0) /* invalid type */
-- 
2.30.2


