Return-Path: <linux-kernel+bounces-782173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ECBB31C34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA281D4170A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD112FE563;
	Fri, 22 Aug 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JD2aiCtn"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C38433B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873239; cv=none; b=GDYzUvgIxy+oDFt3i5He0UN8PjWYdX77T+tFFvmA1Yj3aO7UN5T/dw1De/NvPRwnKd3h05OwSdgSKkqx6Z0Wdf47EIiWkwDc3qhZQOq6d17Kenwp1PhUKXJoWqwehT5ZPdZYGQpoX+vVGi/pRXoQ+zoYTyfX1H6PPGkLWShYMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873239; c=relaxed/simple;
	bh=FOdnYTSDi6ROuOpfCRNaj55gNPqlmSkZEt+05ddHQCI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=axp7XrRyvee/GtGcDABh5LV4nkwnyhHeQm8qkT56HLNeBgdrgewNMzjHv5wT4GVsXKB5R/i49QNWijHblMwWWfPfWg2tHIAKy/S7mn6WKsw2487+/bk2G5DIlRZRgAzFbxm0iiy8+HXTaciig0z50AQmSYHyn2Oo0CEkyansuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JD2aiCtn; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755873226; bh=fR2XmeaLFqPTQFQ1qgiSwPvMARB0Ec/YTOhXVYA37P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JD2aiCtn1noG67fKZnVqBgD0cli9yGJ7JunAWylrwY+5Tpdi5ZsFVBaSttw85t+lr
	 LMyyq7uqXp3rqFyt6qLicGi0geUl0yQIWnX+0ZJKUPnYaLIdxjyRQH/5II/O3zOuG5
	 pEx/O7xeH3jabdaQ2rGKc3cQqN25alfoyL6xY51A=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb23-0.qq.com (NewEsmtp) with SMTP
	id 6E31C299; Fri, 22 Aug 2025 22:27:35 +0800
X-QQ-mid: xmsmtpt1755872855t3b2skufs
Message-ID: <tencent_F8743177E166003DB9369E978437BE4B8209@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpvt3VlSnxhCwwyEuILRU9s0uXl56mc5lhJatJllOdrRyKm7wAod
	 APljKZ/fpgSY36KEr5I6zy/RlxzgLpJYsAL5CO7gLJoiFTy29WP+oz8XVCrPk0zYHFFR0s9/j16v
	 ovpnPyhaWjb39Y0JwtFyWibejKZKEo8NJY5Nj5/5qKNZ0EtNg714VDHOsDaDuCHpIm0RSy26xPFj
	 lcRiDeSVIhqE1OOKmg220Q6z8qjvonXJoOYWhBXd8t31NAyvjG/L7pI973l/dt1s3HI7H8TptCEV
	 Si/k6FHU3hppkJqvme0mC84LUflPPJK28/zPpNLfoJEo+YUfUuJqex4yyg4FMTGY09ka0KsGuNR0
	 J3AdhpF4U7cHUGmMoaxV0BKEEY6Rk+pMnfC7QSiwF+g4ss8QnwXsKSdh9mpZ5PFm97Rl9QsYJrIH
	 1oUILVd/kUlXekmbwErBrSObz2i840wFmHp8N9Kuahelmu88YK2AAwQrZKdy/zYsYkvhE4gszyMD
	 0YlrJJdQTSpdcH89tb+iyR2RaH2Zjgt1+P3uXSOx2H6yzxncsS49GtHm8Rk5O57FyukOIN9ecHJv
	 /Bervk23cwFXyDp2CkNdKEEvdGlkrgOX3UFSDvGokkYN/hjzhsbOdGABaXdInY+NK+UJaw3Macb4
	 /z0LsolnOaMAWP8/2lMrz1rRkdfmqT6koKsHxgIXERwDKGzk+ZM05FxrrLHsFFLg5gEZue3HaWdt
	 iRne/2haVrE/Tz+EuuYMKdJcTyqJ6uiNN4uw7wrjBJl1UrM+DA4vt+ZDAmKw7QdyWT61QQ6Ftw1L
	 q1SDJRN2aq7e/ZpfqPRwIdAoJFfrP74L/tD8dV+ba4o5oZ1lm+Uxxpg3gOnP7ruZBQ5AWFQLJ8C5
	 LUiwmUS4v9Hl8PHzB5OUyOTZEJmyLSFg8LADTFif2vTwMmV1p5tLIN2p/z8zhjTrceZW5AEjT9KI
	 eQMhSQ+IGehoIRwokPgfuYXlzEB+rx9wvEfw9bmGxqKojLAY+/Sw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
Date: Fri, 22 Aug 2025 22:27:33 +0800
X-OQ-MSGID: <20250822142732.2412127-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
References: <68a68b57.050a0220.3d78fd.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index f6065b5e0e5d..cc2056dd0bef 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -50,7 +50,7 @@ static int v9fs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int ret;
 	struct v9fs_context	*ctx = fc->fs_private;
-	struct v9fs_session_info *v9ses = &ctx->v9ses;
+	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);


